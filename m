Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F92119529
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 22:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfLJVTQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 16:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfLJVMb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Dec 2019 16:12:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC42E2077B;
        Tue, 10 Dec 2019 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012350;
        bh=xTn/GfSIOlOalx4DQGBotd4mEAi28u2VH+yoN/+OPzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InWQqlR9fTZHRquky7Wb+X8HH/UJInJoJn2IYR5WWed0OzfFSv2s1mW+i7+ow7cEU
         fliSyZDdvmFOiCaHN2xHiSO8GLzeeD4kWJctZxL7NAT6dmdXj7vl1w+82fIq8XwdyR
         jrAl/UTV4wQ4gNKVYCopONzgjp8MbqNw/yuUDYHE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 280/350] cpufreq: Register drivers only after CPU devices have been registered
Date:   Tue, 10 Dec 2019 16:06:25 -0500
Message-Id: <20191210210735.9077-241-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 46770be0cf94149ca48be87719bda1d951066644 ]

The cpufreq core heavily depends on the availability of the struct
device for CPUs and if they aren't available at the time cpufreq driver
is registered, we will never succeed in making cpufreq work.

This happens due to following sequence of events:

- cpufreq_register_driver()
  - subsys_interface_register()
  - return 0; //successful registration of driver

... at a later point of time

- register_cpu();
  - device_register();
    - bus_probe_device();
      - sif->add_dev();
	- cpufreq_add_dev();
	  - get_cpu_device(); //FAILS
  - per_cpu(cpu_sys_devices, num) = &cpu->dev; //used by get_cpu_device()
  - return 0; //CPU registered successfully

Because the per-cpu variable cpu_sys_devices is set only after the CPU
device is regsitered, cpufreq will never be able to get it when
cpufreq_add_dev() is called.

This patch avoids this failure by making sure device structure of at
least CPU0 is available when the cpufreq driver is registered, else
return -EPROBE_DEFER.

Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Co-developed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bc19d6c16aaa5..a7db4f22a0771 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2634,6 +2634,13 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	if (cpufreq_disabled())
 		return -ENODEV;
 
+	/*
+	 * The cpufreq core depends heavily on the availability of device
+	 * structure, make sure they are available before proceeding further.
+	 */
+	if (!get_cpu_device(0))
+		return -EPROBE_DEFER;
+
 	if (!driver_data || !driver_data->verify || !driver_data->init ||
 	    !(driver_data->setpolicy || driver_data->target_index ||
 		    driver_data->target) ||
-- 
2.20.1

