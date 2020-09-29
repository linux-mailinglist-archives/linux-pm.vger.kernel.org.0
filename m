Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E17B27CA17
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbgI2MQe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 08:16:34 -0400
Received: from foss.arm.com ([217.140.110.172]:42538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732276AbgI2MQ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Sep 2020 08:16:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD08D1063;
        Tue, 29 Sep 2020 05:16:27 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.50.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 625E93F73B;
        Tue, 29 Sep 2020 05:16:25 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, qperret@google.com, mka@chromium.org,
        rjw@rjwysocki.net
Subject: [PATCH 1/2] docs: Clarify abstract scale usage for power values in Energy Model
Date:   Tue, 29 Sep 2020 13:16:09 +0100
Message-Id: <20200929121610.16060-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model (EM) can store power values in milli-Watts or in abstract
scale. This might cause issues in the subsystems which use the EM for
estimating the device power, such as:
- mixing of different scales in a subsystem which uses multiple
  (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))
- assuming that energy [milli-Joules] can be derived from the EM power
  values which might not be possible since the power scale doesn't have to
  be in milli-Watts

To avoid misconfiguration add the needed documentation to the EM and
related subsystems: EAS and IPA.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 .../driver-api/thermal/power_allocator.rst          |  8 ++++++++
 Documentation/power/energy-model.rst                | 13 +++++++++++++
 Documentation/scheduler/sched-energy.rst            |  5 +++++
 3 files changed, 26 insertions(+)

diff --git a/Documentation/driver-api/thermal/power_allocator.rst b/Documentation/driver-api/thermal/power_allocator.rst
index 67b6a3297238..5e04553ded5f 100644
--- a/Documentation/driver-api/thermal/power_allocator.rst
+++ b/Documentation/driver-api/thermal/power_allocator.rst
@@ -269,3 +269,11 @@ won't be very good.  Note that this is not particular to this
 governor, step-wise will also misbehave if you call its throttle()
 faster than the normal thermal framework tick (due to interrupts for
 example) as it will overreact.
+
+Energy Model requirements
+=========================
+
+Another important thing is the consistent scale of the power values
+provided by the cooling devices. All of the cooling devices in a single
+thermal zone should have power values reported either in milli-Watts
+or scaled to the same 'abstract scale'.
diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index a6fb986abe3c..ba7aa581b307 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -20,6 +20,19 @@ possible source of information on its own, the EM framework intervenes as an
 abstraction layer which standardizes the format of power cost tables in the
 kernel, hence enabling to avoid redundant work.
 
+The power values might be expressed in milli-Watts or in an 'abstract scale'.
+Multiple subsystems might use the EM and it is up to the system integrator to
+check that the requirements for the power value scale types are met. An example
+can be found in the Energy-Aware Scheduler documentation
+Documentation/scheduler/sched-energy.rst. For some subsystems like thermal or
+powercap power values expressed in an 'abstract scale' might cause issues.
+These subsystems are more interested in estimation of power used in the past,
+thus the real milli-Watts might be needed. An example of these requirements can
+be found in the Intelligent Power Allocation in
+Documentation/driver-api/thermal/power_allocator.rst.
+Important thing to keep in mind is that when the power values are expressed in
+an 'abstract scale' deriving real energy in milli-Joules would not be possible.
+
 The figure below depicts an example of drivers (Arm-specific here, but the
 approach is applicable to any architecture) providing power costs to the EM
 framework, and interested clients reading the data from it::
diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 001e09c95e1d..afe02d394402 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -350,6 +350,11 @@ independent EM framework in Documentation/power/energy-model.rst.
 Please also note that the scheduling domains need to be re-built after the
 EM has been registered in order to start EAS.
 
+EAS uses the EM to make a forecasting decision on energy usage and thus it is
+more focused on the difference when checking possible options for task
+placement. For EAS it doesn't matter whether the EM power values are expressed
+in milli-Watts or in an 'abstract scale'.
+
 
 6.3 - Energy Model complexity
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.17.1

