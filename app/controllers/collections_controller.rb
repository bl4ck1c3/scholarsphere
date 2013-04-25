# -*- coding: utf-8 -*-
# Copyright © 2012 The Pennsylvania State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class CollectionsController < ApplicationController
  include Hydra::CollectionsControllerBehavior
  include Sufia::Noid # for normalize_identifier method
  prepend_before_filter :normalize_identifier, :except => [:index, :create, :new]
  before_filter :has_access?, :except => [:show]
end