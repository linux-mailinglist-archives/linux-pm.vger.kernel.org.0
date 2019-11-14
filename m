Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311E3FBE56
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 04:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKNDg1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 22:36:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38656 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfKNDg1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 22:36:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so3153518pfp.5
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 19:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zfh62teJf2BZgYM+/0fl1CP/Fxqn42ZyCR+MYxF6pao=;
        b=nd/6bCe2vLCNQ17q5z7dsZZ6wNxHSpI/uvIqp+SR/3RkVRWmA+ilxHFQGn9YJMLbRb
         GyRObG+7zxD5yfnZyYCV/VhA5BLdTRtiVT9ZVO92wlD24yDUdmZFxVGryOUUj202EtO3
         hkfyADFg4kF46NGnccgEiC3BPsiSUurZK3EbGZWTcymyAiYI3UfF+tL16x4O6Kxmyk2M
         MSG50fTYjnV23yftGr9RwuAHBORRbXXRTQ8QtbdcDWZdEeD18P5xL6Bk8I1VBXwYwTt3
         bElr/gYWXcJz8qBBlL04OiCXr3zgqOOqSPbtFxw6YZgtCjbAXwTojEo3+btxTrZWfXFn
         avLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zfh62teJf2BZgYM+/0fl1CP/Fxqn42ZyCR+MYxF6pao=;
        b=nFfsdA1h7bCtLpoqswuK5nzy/fe23mN8fUb6XeP59oW9e+u9+WR54Z1+R7fuSXEtrq
         nfu/RFNmYsIk86gR1ewbLUtbWRteKKpR/s1QypxXngbIjy+GCribazhseSLPjDDtzegH
         h2j8rv4/TYz4sEW8W6KtzViyjrNeRzb6g8R5FBUkfLWBb4rQyUoBFPz6aUA5zdg1P01L
         +Tur/9x6SwsMe7ICyOAukbgeutJCwR60qPmTLmn8O2jUZ3bqW8LbOt2qpaG6HJyJId4I
         b9NLzLaMhm72ntYAVpUScUfauNVzP2zwqiuxeKvu869gJXSxZEGprZPInQCxX8t0hwRj
         cMyw==
X-Gm-Message-State: APjAAAUsGoouV8Nv6ZzbBiYoezISwK5phXaTCphGWl6j89nDMvI7Yf4a
        g4ol8PCCFoFqKvG4pzEhgTOBNQ==
X-Google-Smtp-Source: APXvYqxl+SlKr/KwBSoet9YqcQ1Hjjw+7TCETckK3oZ1Cw6rNBN7E7Vu0Uen8+spsKTKlo97IlVgcQ==
X-Received: by 2002:a63:6e82:: with SMTP id j124mr7689659pgc.115.1573702584525;
        Wed, 13 Nov 2019 19:36:24 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id c21sm4222858pgh.25.2019.11.13.19.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 19:36:23 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Register cpufreq drivers only after CPU devices are registered
Date:   Thu, 14 Nov 2019 09:06:17 +0530
Message-Id: <c60806d5480b7311ced8db07ff239aa5af7a050d.1573702497.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
@Amit: I have added your sob without asking as you were involved in
getting us to this patch, you did a lot of testing yesterday to find the
root cause.

@Rafael: This fixes the issues reported by Bjorn on Amit's series and so
should land before Amit's series, if at all this is acceptable to you.
Thanks.

 drivers/cpufreq/cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 681c1b5f0a1a..05293b43e56d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2641,6 +2641,13 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
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
2.21.0.rc0.269.g1a574e7a288b

