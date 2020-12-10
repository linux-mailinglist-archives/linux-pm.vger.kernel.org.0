Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D52D65C8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 20:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393236AbgLJS5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 13:57:50 -0500
Received: from foss.arm.com ([217.140.110.172]:45090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390488AbgLJOb0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 09:31:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06B161FB;
        Thu, 10 Dec 2020 06:30:29 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.1.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0F173F718;
        Thu, 10 Dec 2020 06:30:25 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com, orjan.eide@arm.com,
        robh@kernel.org, alyssa.rosenzweig@collabora.com,
        steven.price@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        ionela.voinescu@arm.com
Subject: [PATCH v4 0/5] Thermal devfreq cooling improvements with Energy Model
Date:   Thu, 10 Dec 2020 14:30:09 +0000
Message-Id: <20201210143014.24685-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set is a continuation of my previous work, which aimed
to add Energy Model to all devices [1]. This series is a follow up
for the patches which got merged to v5.9-rc1. It aims to change
the thermal devfreq cooling and use the Energy Model instead of
private power table and structures. The power model is now simplified,
static power and dynamic power are removed. The new registration interface
in the patch 3/5 helps to register devfreq cooling and the EM in one call.
There is also small improvement, patch 2/5 is changing the way how
thermal gets the device status (now uses a copy) and normalize the values.
The last patch is here for consistency and will probably go through drm tree.

The patch set should apply on top of thermal/testing. It does not depend on
new EM API change which is queued in the pm/linux-next tree as v5.11 material.
Thus, could go in parallel. That was the main motiviation for this v4.

changes:
v4:
- patch 3/5 - removed dependency on the EM API change
-- removed em_dev_register_perf_domain() and just use
   dev_pm_opp_of_register_em() which API has not changed
-- removed a helper registration function and renamed
   devfreq_cooling_em_register_power() to devfreq_cooling_em_register()
   (was actually suggested by Ionela during review)
-- moved energy_model.h to include in devfreq_cooling.c not .h, since
   there is no EM structure in there anymore
- adjusted comments and commit messages
v3 [4]:
- dropped direct check of device status and used just a copy of 'status';
  a separate patch set will be proposed to address this issue
- modified _normalize_load() and used 1024 scale to handle ms, us, ns
- removed 'em_registered' and called em_dev_unregister_perf_domain()
  unconditionally, so the drivers will have to make sure the right order of
  all unregister calls to frameworks which might use EM; this call must be last
  one; a proper comment added
- removed 'em' pointer from struct devfreq_cooling_device, 'dev->em_pd' is used
- removed of_node_get/put(), since the code can handle it
- removed dfc_em_get_requested_power() (as missed to do it in v2)
- collected all Reviewed-by tags
v2 [3]:
- renamed freq_get_state() and related to perf_idx pattern as
  suggested by Ionela
v1 [2]

Regards,
Lukasz Luba

Lukasz Luba (5):
  thermal: devfreq_cooling: change tracing function and arguments
  thermal: devfreq_cooling: use a copy of device status
  thermal: devfreq_cooling: add new registration functions with Energy
    Model
  thermal: devfreq_cooling: remove old power model and use EM
  drm/panfrost: Register devfreq cooling and attempt to add Energy Model

 drivers/gpu/drm/panfrost/panfrost_devfreq.c |   2 +-
 drivers/thermal/devfreq_cooling.c           | 391 +++++++++-----------
 include/linux/devfreq_cooling.h             |  27 +-
 include/trace/events/thermal.h              |  19 +-
 4 files changed, 198 insertions(+), 241 deletions(-)

-- 
2.17.1

