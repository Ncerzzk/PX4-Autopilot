############################################################################
#
#   Copyright (c) 2020 PX4 Development Team. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. Neither the name PX4 nor the names of its contributors may be
#    used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
############################################################################
set(upload_command echo no upload parmeters set)
if(DEFINED ENV{AUTOPILOT_HOST} AND DEFINED ENV{AUTOPILOT_REMOTE_USER} AND DEFINED ENV{AUTOPILOT_REMOTE_PATH})
        set(upload_command scp ~/fly.tar.gz $ENV{AUTOPILOT_REMOTE_USER}@$ENV{AUTOPILOT_HOST}:$ENV{AUTOPILOT_REMOTE_PATH}/)
endif()

add_custom_target(upload
        COMMAND rm ~/fly -rf
        COMMAND mkdir -p ~/fly
        COMMAND cp -d ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/*   ~/fly/
        COMMAND cp -d ${PX4_SOURCE_DIR}/posix-configs/autopilotpi/*.config  ~/fly/
        COMMAND cp -d ${PX4_BINARY_DIR}/etc  ~/fly/ -r
        COMMAND tar -czvf ~/fly.tar.gz ~/fly
        COMMAND ${upload_command}
        DEPENDS px4
        COMMENT "uploading px4"
        USES_TERMINAL
)


