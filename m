Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD8270ABE
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 06:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgISEri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Sep 2020 00:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISEri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Sep 2020 00:47:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183D2C0613CE;
        Fri, 18 Sep 2020 21:47:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so4770848pfi.4;
        Fri, 18 Sep 2020 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1+rk0Yb85QwC2uyvEMI2pDfEImVWuhSTx15aUUDMpOg=;
        b=g68ExC3d9sovA7VmyWcDsPBMqHLhWKIcTFcUEh81MmXMOmBeXLI+hrsu9m0+TigiBP
         NIgJqjlM+/+FuFhr8ViyzlhzcJeD657/l7K8CuGHZezozE0OZqDlb+MbgD5yswpO1ock
         rQAY0kjdwRrF/rprigJCIZJLo/fWuERSw3ypQMLfPqk5r0TOqbwO8xlZNR0lID4Xo8iz
         NvambGcH03EvjQKtkp9Srpq+foceEKzm4joXMW7/wNnvD9VeQotQK7m7VKeByi58FNb1
         THzC0RXxta02G/tn9uuwA9+ppOcER5tLTeFAs+EPWSLQ5NC+f/GkPlzN85ckrZtFQ4pr
         vXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1+rk0Yb85QwC2uyvEMI2pDfEImVWuhSTx15aUUDMpOg=;
        b=kBPD6oFCJvlU+vbXT2Ql3rztVVCWvKXFwLfLSbHiM1D4nkoXCPki77bV5kTdFoTM2K
         ckulSMtN0vcwdI9TcL7xgJfV/ykRdU1hnv/3CVz9yIcI9GGLUQBtSkZch3ilJ7oUYjZE
         grCvhEpvEuze7/5xBzC6aRTxUEjEj811zo5XAy0q1THLrzQYZluPBi7e/59sl4/7R14j
         tKCVOdoABkIpAl7wK3aZxReMveWJjgP2ZFc544eEogQKlgYJ6qrIz3ZXr0HSUF6tmfU8
         wP/QoARN/yoUo7zaEzBjDx8LyaX9U1TrwDl6NmE5vwS+h9aWnxfvpk3hsZRirmLWRxox
         L/IQ==
X-Gm-Message-State: AOAM5314No4Ny12PD8XPRnH0stS3N8cxIXxlSowRNm4Wm0Crqp4cqFPc
        zoZ1lspSFpbvxM360WriUsc=
X-Google-Smtp-Source: ABdhPJzV2XSt7/1TMMaL54a+Y5LNWcvRNGgkfwWflY4O11w6GSTD+hw4JUMFpUvEXav4NghtsSpWBQ==
X-Received: by 2002:a05:6a00:15c8:b029:142:2501:35ca with SMTP id o8-20020a056a0015c8b0290142250135camr19183086pfu.42.1600490857573;
        Fri, 18 Sep 2020 21:47:37 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id h35sm4718339pgl.31.2020.09.18.21.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 21:47:37 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: [PATCH] thermal/drivers/cpuidle_cooling: Change the latency limit
Date:   Sat, 19 Sep 2020 12:47:25 +0800
Message-Id: <20200919044725.2148-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

The injected idle duration must be greater than the wake up latency
(entry + exit latency) or the idle state target residency (or  min
residency), otherwise we end up consuming more energy and potentially
invert the mitigation effect.

In function idle_inject_fn(), we call play_idle_precise() to specify
a latency limit which is finally used in find_deepest_state() to find
the deepest idle state. Although the latency limit is compared with
s->exit_latency_ns in find_deepest_state(), it should not be exit
latency, but the idle duraion minus entry latency which can ensure
that the injected idle duration is greater than the wake up latency
(entry + exit latency).

There are two timers in idle inject process, the length of the first
timer (timer_1) is idle duration, and the length of the second timer
(timer_2) is idle duration plus run duration. When timer_2 expires,
it's restarted and idle_inject_timer_fn() is called and it wakes up
idle injection tasks associated with the timer and they, in turn,
invoke play_idle_precise() to inject a specified amount (idle duration)
of CPU idle time. The major functions called are as follows:

play_idle_precise() ->
 do_idle() ->
  cpuidle_idle_call() ->
   cpuidle_find_deepest_state() ->
    find_deepest_state()

When we call find_deepest_state(), some time has been consumed from
the beginning of the idle duration which could be considered the
entry latency approximately, so the latency limit should be the idle
duraion minus entry latency which can ensure that the injected idle
duration is greater than the wake up latency (entry + exit latency).

Here are two sample scenes,
scene   entry latency(us)    exit latency(us)    idle duration(us)
1            500                     600               1000
2            500                     600               3000

In scene 1, if we use exit latency (600us) for the latency limit,
we may find a idle state which has a exit latency equal to or less
than 600us, suppose the idle state's exit latency is equal to 600us,
then the wake up latency (entry + exit latency) is greater than idle
duration.

In scene 2, if we use exit latency (600us) for the latency limit,
we may also find a idle state which has a exit latency equal to
600us. But if we use the idle duraion minus entry latency
(3000 - 500 = 2500us), we can find a deeper idle state to save
more power in idle duration.

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 drivers/thermal/cpuidle_cooling.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 78e3e8238116..6f78c7816fcc 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -174,6 +174,7 @@ static int __cpuidle_cooling_register(struct device_node *np,
 	struct idle_inject_device *ii_dev;
 	struct cpuidle_cooling_device *idle_cdev;
 	struct thermal_cooling_device *cdev;
+	unsigned int entry_latency_us;
 	unsigned int idle_duration_us = TICK_USEC;
 	unsigned int latency_us = UINT_MAX;
 	char dev_name[THERMAL_NAME_LENGTH];
@@ -198,7 +199,9 @@ static int __cpuidle_cooling_register(struct device_node *np,
 	}
 
 	of_property_read_u32(np, "duration-us", &idle_duration_us);
-	of_property_read_u32(np, "exit-latency-us", &latency_us);
+	if (!of_property_read_u32(np, "entry-latency-us", &entry_latency_us) &&
+	    idle_duration_us > entry_latency_us)
+		latency_us = idle_duration_us - entry_latency_us;
 
 	idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
 	idle_inject_set_latency(ii_dev, latency_us);
-- 
2.17.1

