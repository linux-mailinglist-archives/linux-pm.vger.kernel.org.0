Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482CD13DE81
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgAPPVB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 10:21:01 -0500
Received: from foss.arm.com ([217.140.110.172]:50934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgAPPVB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 10:21:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2136F1396;
        Thu, 16 Jan 2020 07:21:00 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E3AB3F68E;
        Thu, 16 Jan 2020 07:20:48 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        Chris.Redpath@arm.com, ionela.voinescu@arm.com,
        javi.merino@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, lukasz.luba@arm.com,
        patrick.bellasi@matbug.net
Subject: [PATCH 0/4] Add support for devices in the Energy Model
Date:   Thu, 16 Jan 2020 15:20:28 +0000
Message-Id: <20200116152032.11301-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Hi all,

This patch set introduces support for devices in the Energy Model (EM) framework.
It will unify the power model for thermal subsystem and make it simpler.
The 1st patch refactors EM framework and adds support for devices. The 2nd patch
changes dev_pm_opp_of_register_em() in OPP/OF which now should take as an
argument struct device pointer. It touches a few trees (OMAP, NXP, mediatek) updating
their CPUfreq drivers to the new interface.
Patch 3 changes thermal devfreq cooling removing old code for calculating local power
table. It simplifies the code and uses EM for requested power calculation.
Last patch 4 is based on 'drm-misc-next' and adds EM to Panfrost driver.

The patch set is based on v5.5-rc6 tag (excluding last patch).

Regards,
Lukasz Luba

Lukasz Luba (4):
  PM / EM: and devices to Energy Model
  OPP: change parameter to device pointer in dev_pm_opp_of_register_em()
  thermal: devfreq_cooling: Refactor code and switch to use Energy Model
  drm/panfrost: Register to the Energy Model with devfreq device

 Documentation/power/energy-model.rst        |  67 ++--
 drivers/cpufreq/cpufreq-dt.c                |   2 +-
 drivers/cpufreq/imx6q-cpufreq.c             |   2 +-
 drivers/cpufreq/mediatek-cpufreq.c          |   2 +-
 drivers/cpufreq/omap-cpufreq.c              |   2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c           |   2 +-
 drivers/cpufreq/scmi-cpufreq.c              |  11 +-
 drivers/cpufreq/scpi-cpufreq.c              |   2 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c |   3 +
 drivers/opp/of.c                            |  43 +--
 drivers/thermal/cpu_cooling.c               |  10 +-
 drivers/thermal/devfreq_cooling.c           | 397 +++++++------------
 include/linux/devfreq_cooling.h             |  17 -
 include/linux/energy_model.h                | 108 ++++--
 include/linux/pm_opp.h                      |  13 +-
 include/trace/events/thermal.h              |  19 +-
 kernel/power/energy_model.c                 | 406 ++++++++++++++++----
 kernel/sched/sched.h                        |   2 +-
 kernel/sched/topology.c                     |   4 +-
 19 files changed, 631 insertions(+), 481 deletions(-)

-- 
2.17.1

