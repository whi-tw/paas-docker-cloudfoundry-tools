#!/usr/bin/env bash
set -euo pipefail

function contains_element() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

function get_workflow_acceptance_tests() {
    local workflow="${1}"
    local tests
    tests="$(yq '.jobs.workflows.with.has_acceptance_tests' "${workflow}")"
    if [ "${tests}" == "null" ]; then
        echo "false"
    else
        echo "${tests}"
    fi
}
function get_workflow_dockerfile() {
    local workflow="${1}"
    local dockerfile
    dockerfile="$(yq '.jobs.workflows.with.dockerfile' "${workflow}")"
    if [ "${dockerfile}" == "null" ]; then
        echo "Dockerfile"
    else
        echo "${dockerfile}"
    fi
}

function workflow_matches_name() {
    local workflow="${1}"
    local potential_image_name="${2}"
    set +e
    yq -e ".jobs.workflows.with.image == \"${potential_image_name}\"" "${workflow}" &>/dev/null || return 1
    set -e
}

function get_image_workflows() {
    local potential_image_name="${1}"
    local potential_workflows=(.github/workflows/"${potential_image_name}"*.yml)
    local matched_workflows=()
    local workflow
    for workflow in "${potential_workflows[@]}"; do
        if workflow_matches_name "${workflow}" "${potential_image_name}"; then
            matched_workflows+=("${workflow}")
        fi
    done
    echo "${matched_workflows[*]}"

}

function basedir() {
    local file="${1}"
    echo "${file}" | cut -d'/' -f1
}

changed_files=("${@}")
images=()
dockerfiles=()
acceptance_tests=()

for file in "${changed_files[@]}"; do
    potential_image_name=$(basedir "${file}")
    contains_element "${potential_image_name}" "${images[@]}" && continue
    workflows="$(get_image_workflows "${potential_image_name}")"
    for workflow in ${workflows}; do
        workflow_dockerfile=$(get_workflow_dockerfile "${workflow}")
        workflow_acceptance_tests=$(get_workflow_acceptance_tests "${workflow}")
        images+=("${potential_image_name}")
        dockerfiles+=("${workflow_dockerfile}")
        acceptance_tests+=("${workflow_acceptance_tests}")
    done
    # potential_workflows=(.github/workflows/"${basedir}"*.yml)
done
echo ::set-output name=images::"$(jq --compact-output --null-input '$ARGS.positional' --args -- "${images[@]}")"
echo ::set-output name=dockerfiles::"$(jq --compact-output --null-input '$ARGS.positional' --args -- "${dockerfiles[@]}")"
echo ::set-output name=acceptance_tests::"$(jq --compact-output --null-input '$ARGS.positional' --args -- "${acceptance_tests[@]}" | sed 's/"//g')"

# ; do
#             basedir="$(echo $file | cut -d'/' -f1)"
#             grep "image: $basedir" .github/workflows/*.yml
#           done
