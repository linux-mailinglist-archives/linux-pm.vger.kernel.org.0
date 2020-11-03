Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727F52A3FA2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 10:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKCJGS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 04:06:18 -0500
Received: from foss.arm.com ([217.140.110.172]:44690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgKCJGQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 04:06:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7A63139F;
        Tue,  3 Nov 2020 01:06:15 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.19.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 538693F719;
        Tue,  3 Nov 2020 01:06:11 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, amitk@kernel.org, corbet@lwn.net,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, dianders@chromium.org, mka@chromium.org,
        rnayak@codeaurora.org, rafael@kernel.org, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, sboyd@kernel.org, nm@ti.com
Subject: [PATCH v4 0/4] Clarify abstract scale usage for power values in Energy Model, EAS and IPA
Date:   Tue,  3 Nov 2020 09:05:56 +0000
Message-Id: <20201103090600.29053-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The Energy Model supports power values expressed in an abstract scale.
This has an impact on Intelligent Power Allocation (IPA) and should be
documented properly. Kernel sub-systems like EAS, IPA and DTPM
(new comming PowerCap framework) would use the new flag to capture
potential miss-configuration where the devices have registered different
power scales, thus cannot operate together.

There was a discussion below v2 of this patch series, which might help
you to get context of these changes [2].

The agreed approach is to have the DT as a source of power values expressed
always in milli-Watts and the only way to submit with abstract scale values
is via the em_dev_register_perf_domain() API.

Changes:
v4:
- change bool to int type for 'miliwatts' in struct em_perf_domain
  (suggested by Quentin)
- removed one sentence from patch 2/4 in IPA doc power_allocator.rst
  (suggested by Quentin)
- added reviewed-by from Quentin to 1/4, 3/4, 4/4 patches
v3 [3]:
- added boolean flag to struct em_perf_domain and registration function
  indicating if EM holds real power values in milli-Watts (suggested by
  Daniel and aggreed with Quentin)
- updated documentation regarding this new flag
- dropped DT binding change for 'sustainable-power'
- added more maintainers on CC (due to patch 1/3 touching different things)
v2 [2]:
- updated sustainable power section in IPA documentation
- updated DT binding for the 'sustainable-power'
v1 [1]:
- simple documenation update with new 'abstract scale' in EAS, EM, IPA

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-doc/20200929121610.16060-1-lukasz.luba@arm.com/
[2] https://lore.kernel.org/lkml/20201002114426.31277-1-lukasz.luba@arm.com/
[3] https://lore.kernel.org/lkml/20201019140601.3047-1-lukasz.luba@arm.com/

Lukasz Luba (4):
  PM / EM: Add a flag indicating units of power values in Energy Model
  docs: Clarify abstract scale usage for power values in Energy Model
  PM / EM: update the comments related to power scale
  docs: power: Update Energy Model with new flag indicating power scale

 .../driver-api/thermal/power_allocator.rst    | 12 +++++++-
 Documentation/power/energy-model.rst          | 30 +++++++++++++++----
 Documentation/scheduler/sched-energy.rst      |  5 ++++
 drivers/cpufreq/scmi-cpufreq.c                |  3 +-
 drivers/opp/of.c                              |  2 +-
 include/linux/energy_model.h                  | 20 ++++++++-----
 kernel/power/energy_model.c                   | 26 ++++++++++++++--
 7 files changed, 80 insertions(+), 18 deletions(-)

-- 
2.17.1

