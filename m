Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B401448E2E9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jan 2022 04:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiANDRh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jan 2022 22:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiANDRh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jan 2022 22:17:37 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D687C06173E
        for <linux-pm@vger.kernel.org>; Thu, 13 Jan 2022 19:17:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id s15so1617507pfw.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jan 2022 19:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=22J5kbkqZMwi+zbdPplWGyEMzniZ46lPbAAksAaXwtc=;
        b=dsktbiJ4cPJ7xF2ETl4LH75h7FyhR9XRGkBiaY9HDBCzIrCXLk2RdlUVHDSb1rE2C2
         lAcLWzpfOlGRp8Hbpt/GwUQlrjAYVXTO+fz4thr4VPCGRQQVi5z0ovQaDQ+soUH3PdMT
         PlQnN+cKPOt+XNDx5//1UEaDQsXml0dHu13D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=22J5kbkqZMwi+zbdPplWGyEMzniZ46lPbAAksAaXwtc=;
        b=ok/Yz3X58E3YxdyXwhIo3/NLqASjGMJYrtthSQpiJyglbY3h4Pkx7nMzFjwt2Wp1y4
         OBEG2cgCbNIRsPCou9/rvsLpjd06+pc8kVbJx/h7S1Qay6GbbB5Ob8AWicF91CR6kq7i
         CzgMsuBS8fDUdtbcAYLdHRQP4/Gi/rq1NTSEZLgo3OclrZNwyFcZeOc7lzVRzxdaX45n
         3nlZ9myCWRsVQEskolzpLvskd7Wa6kCxmMsYerGuLLpzbJEmFZ8yFOVSDI7RLMgLXgIF
         5bpCWlENSN/MAg214odPjWXi+vS4tLDipziCqgQwszMr4CThZ7KLSG2vnmhARE0CJMSA
         2R3g==
X-Gm-Message-State: AOAM532hfGFmO9f4ca5jxJ5a5GR67uyzsIgX2mfY7tEKswlLV71XAMi8
        pzq8/l2xpRNtBSiHsY/4E4hHkg==
X-Google-Smtp-Source: ABdhPJwfE81HsvaNi1f/JpvJoBon3nPvWpf1kFbZbO+0UlkMFrPSkdRgPvXz1RJpo/tskm1nh28PaQ==
X-Received: by 2002:a05:6a00:15c8:b0:4ba:fa69:3807 with SMTP id o8-20020a056a0015c800b004bafa693807mr7075964pfu.10.1642130256491;
        Thu, 13 Jan 2022 19:17:36 -0800 (PST)
Received: from localhost (99-47-69-49.lightspeed.sntcca.sbcglobal.net. [99.47.69.49])
        by smtp.gmail.com with ESMTPSA id lk10sm11101947pjb.20.2022.01.13.19.17.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jan 2022 19:17:35 -0800 (PST)
From:   Benjamin Li <benl@squareup.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Benjamin Li <benl@squareup.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: thermal: tsens: respect thermal_device_mode in threshold irq reporting
Date:   Thu, 13 Jan 2022 19:17:30 -0800
Message-Id: <20220114031730.25621-1-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

'echo disabled > .../thermal_zoneX/mode' will disable the thermal core's
polling mechanism to check for threshold trips. This is used sometimes to
run performance test cases.

However, tsens supports an interrupt mechanism to receive notification of
trips, implemented in commit 634e11d5b450 ("drivers: thermal: tsens: Add
interrupt support").

Currently the thermal zone mode that's set by userspace is not checked
before propagating threshold trip events from IRQs. Let's fix this to
restore the abilty to disable thermal throttling at runtime.

====================

Tested on MSM8939 running 5.16.0. This platform has 8 cores; the first
four thermal zones control cpu0-3 and the last zone is for the other four
CPUs together.

  for f in /sys/class/thermal/thermal_zone*; do
    echo "disabled" > $f/mode
    echo $f | paste - $f/type $f/mode
  done

/sys/class/thermal/thermal_zone0	cpu0-thermal	disabled
/sys/class/thermal/thermal_zone1	cpu1-thermal	disabled
/sys/class/thermal/thermal_zone2	cpu2-thermal	disabled
/sys/class/thermal/thermal_zone3	cpu3-thermal	disabled
/sys/class/thermal/thermal_zone4	cpu4567-thermal	disabled

With mitigation thresholds at 75 degC and load running, we can now cruise
past temp=75000 without CPU throttling kicking in.

  watch -n 1 "grep '' /sys/class/thermal/*/temp
      /sys/class/thermal/*/cur_state
      /sys/bus/cpu/devices/cpu*/cpufreq/cpuinfo_cur_freq"

/sys/class/thermal/thermal_zone0/temp:82000
/sys/class/thermal/thermal_zone1/temp:84000
/sys/class/thermal/thermal_zone2/temp:87000
/sys/class/thermal/thermal_zone3/temp:84000
/sys/class/thermal/thermal_zone4/temp:84000
/sys/class/thermal/cooling_device0/cur_state:0
/sys/class/thermal/cooling_device1/cur_state:0
/sys/bus/cpu/devices/cpu0/cpufreq/cpuinfo_cur_freq:1113600
/sys/bus/cpu/devices/cpu1/cpufreq/cpuinfo_cur_freq:1113600
/sys/bus/cpu/devices/cpu2/cpufreq/cpuinfo_cur_freq:1113600
/sys/bus/cpu/devices/cpu3/cpufreq/cpuinfo_cur_freq:1113600
/sys/bus/cpu/devices/cpu4/cpufreq/cpuinfo_cur_freq:800000
/sys/bus/cpu/devices/cpu5/cpufreq/cpuinfo_cur_freq:800000
/sys/bus/cpu/devices/cpu6/cpufreq/cpuinfo_cur_freq:800000
/sys/bus/cpu/devices/cpu7/cpufreq/cpuinfo_cur_freq:800000

Reported-by: Zac Crosby <zac@squareup.com>
Signed-off-by: Benjamin Li <benl@squareup.com>
---
Changes in v2:
- Reordered sentences in first part of commit message to make sense.

 drivers/thermal/qcom/tsens.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 99a8d9f3e03c..0b6299512e7c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -509,13 +509,16 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 		spin_unlock_irqrestore(&priv->ul_lock, flags);
 
 		if (trigger) {
-			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
-				hw_id, __func__, temp);
-			thermal_zone_device_update(s->tzd,
-						   THERMAL_EVENT_UNSPECIFIED);
+			if (s->tzd->mode == THERMAL_DEVICE_ENABLED) {
+				dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
+					hw_id, __func__, temp);
+				thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
+			} else {
+				dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC) skipped as zone disabled\n",
+					hw_id, __func__, temp);
+			}
 		} else {
-			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
-				hw_id, __func__, temp);
+			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n", hw_id, __func__, temp);
 		}
 
 		if (tsens_version(priv) < VER_0_1) {
-- 
2.17.1

