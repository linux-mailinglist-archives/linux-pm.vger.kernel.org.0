Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8262928D6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgJSOGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 10:06:41 -0400
Received: from foss.arm.com ([217.140.110.172]:58386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgJSOGl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Oct 2020 10:06:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E283D6E;
        Mon, 19 Oct 2020 07:06:40 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.15.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72B5D3F66E;
        Mon, 19 Oct 2020 07:06:35 -0700 (PDT)
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
Subject: [PATCH v3 4/4] docs: power: Update Energy Model with new flag indicating power scale
Date:   Mon, 19 Oct 2020 15:06:01 +0100
Message-Id: <20201019140601.3047-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019140601.3047-1-lukasz.luba@arm.com>
References: <20201019140601.3047-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update description and meaning of a new flag, which indicates the type of
power scale used for a registered Energy Model (EM) device.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index ba7aa581b307..60ac091d3b0d 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -30,6 +30,8 @@ These subsystems are more interested in estimation of power used in the past,
 thus the real milli-Watts might be needed. An example of these requirements can
 be found in the Intelligent Power Allocation in
 Documentation/driver-api/thermal/power_allocator.rst.
+Kernel subsystems might implement automatic detection to check whether EM
+registered devices have inconsistent scale (based on EM internal flag).
 Important thing to keep in mind is that when the power values are expressed in
 an 'abstract scale' deriving real energy in milli-Joules would not be possible.
 
@@ -86,7 +88,7 @@ Drivers are expected to register performance domains into the EM framework by
 calling the following API::
 
   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-		struct em_data_callback *cb, cpumask_t *cpus);
+		struct em_data_callback *cb, cpumask_t *cpus, bool milliwatts);
 
 Drivers must provide a callback function returning <frequency, power> tuples
 for each performance state. The callback function provided by the driver is free
@@ -94,6 +96,10 @@ to fetch data from any relevant location (DT, firmware, ...), and by any mean
 deemed necessary. Only for CPU devices, drivers must specify the CPUs of the
 performance domains using cpumask. For other devices than CPUs the last
 argument must be set to NULL.
+The last argument 'milliwatts' is important to set with correct value. Kernel
+subsystems which use EM might rely on this flag to check if all EM devices use
+the same scale. If there are different scales, these subsystems might decide
+to: return warning/error, stop working or panic.
 See Section 3. for an example of driver implementing this
 callback, and kernel/power/energy_model.c for further documentation on this
 API.
@@ -169,7 +175,8 @@ EM framework::
   37     	nr_opp = foo_get_nr_opp(policy);
   38
   39     	/* And register the new performance domain */
-  40     	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus);
-  41
-  42	        return 0;
-  43	}
+  40     	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
+  41					    true);
+  42
+  43	        return 0;
+  44	}
-- 
2.17.1

