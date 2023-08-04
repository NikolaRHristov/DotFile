from github_dependents_info.gh_dependents_info import GithubDependentsInfo
import json

gh_deps_info = GithubDependentsInfo(
            'aimhubio/aim',
            debug=False,
            sort_key='name',
            min_stars=0,
            json_output=True,
            badge_markdown_file=False,
            badge_color='informational',
            merge_packages=True,
        )

dependents = gh_deps_info.collect()
with open('aim_dependents.json', 'w') as f:
    json.dump(dependents, f, indent=4)
