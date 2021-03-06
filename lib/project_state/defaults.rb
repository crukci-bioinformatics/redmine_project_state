module ProjectStatePlugin

  module Defaults

    CUSTOM_PROJECT_STATE = "Project State"
    CUSTOM_STATE_TIMEOUT = "State Timeout"
    CUSTOM_HOUR_LIMIT = "Hour Limit"
    CUSTOM_RESEARCHER_EMAIL = "Researcher Email"
    CUSTOM_ANALYST = "Analyst"
    CUSTOM_ISS_COSTCODE = "Cost Centre"
    CUSTOM_PROJ_COSTCODE = "Cost Centre"

    HOURS_PER_DAY = 7

    INTERESTING = ['Prepare','Submit','Ready','Active','Hold','Post']

    ORDERING = {'Ongoing' => 0,
                'Prepare' => 1,
                'Submit' => 2,
                'Ready' => 3,
                'Active' => 4,
                'Hold' => 5,
                'Post' => 6}

  end
end
