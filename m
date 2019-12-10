Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F580118716
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 12:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfLJLsl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 06:48:41 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58892 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfLJLsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 06:48:38 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 4e04c00f13f68e91; Tue, 10 Dec 2019 12:48:36 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM mailing list <linux-pm@vger.kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Subject: [PATCH] cpuidle: Fix cpuidle_driver_state_disabled()
Date:   Tue, 10 Dec 2019 12:48:35 +0100
Message-ID: <2533476.AZShXAyBN7@kreacher>
In-Reply-To: <7b0313c4-0d2b-fbd9-469b-1e0ce79aacc3@linaro.org>
References: <7b0313c4-0d2b-fbd9-469b-1e0ce79aacc3@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It turns out that cpuidle_driver_state_disabled() can be called
before registering the cpufreq driver on some platforms, which
was not expected when it was introduced and which leads to a NULL
pointer dereference when trying to walk the CPUs associated with
the given cpuidle driver.

Fix the problem by making cpuidle_driver_state_disabled() check if
the driver's mask of CPUs associated with it is present and to set
CPUIDLE_FLAG_UNUSABLE for the given idle state in the driver's states
list if that is not the case to cause __cpuidle_register_device() to
set CPUIDLE_STATE_DISABLED_BY_DRIVER for that state for all cpuidle
devices registered by it later.

Fixes: cbda56d5fefc ("cpuidle: Introduce cpuidle_driver_state_disabled() for driver quirks")
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/driver.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-pm/drivers/cpuidle/driver.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/driver.c
+++ linux-pm/drivers/cpuidle/driver.c
@@ -403,6 +403,13 @@ void cpuidle_driver_state_disabled(struc
 
 	mutex_lock(&cpuidle_lock);
 
+	spin_lock(&cpuidle_driver_lock);
+
+	if (!drv->cpumask) {
+		drv->states[idx].flags |= CPUIDLE_FLAG_UNUSABLE;
+		goto unlock;
+	}
+
 	for_each_cpu(cpu, drv->cpumask) {
 		struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
 
@@ -415,5 +422,8 @@ void cpuidle_driver_state_disabled(struc
 			dev->states_usage[idx].disable &= ~CPUIDLE_STATE_DISABLED_BY_DRIVER;
 	}
 
+unlock:
+	spin_unlock(&cpuidle_driver_lock);
+
 	mutex_unlock(&cpuidle_lock);
 }



