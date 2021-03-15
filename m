Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8671333B352
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 14:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCONJa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 09:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhCONI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Mar 2021 09:08:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF0FC06174A;
        Mon, 15 Mar 2021 06:08:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so14745416pjb.2;
        Mon, 15 Mar 2021 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRJEvr70IzHCqubocLMuXrvU7JHp9bq9qzJ0p02omVs=;
        b=onjuFLPSKxASfaF5eFOJ9UucCUGbo986h0gukKryrsy9dHjrZaG8/vninUMJIQLoCM
         pZkS4QFR+4SJdIj9hVOUZGXCyusmTLOf9E9olDCSlFsFGXFOWBtQi/2aWZputxoGD5B6
         nFEARzwYeEeSbZeoSGHBQUvgN+HfvAeIcgza7hSr3g5vr5N1Y3EIVFldQP9ny7Tw3bzj
         sxUIp/otx86aAIqhx9fznfxzCd8dYkUXeK8wtonQdAcaT+mAtZoXCgW/vJpyOjpmp2q6
         ukwCBECkpE5CzVpG4t7dsbyv2w7M75VSI4hxGW8rk8SR7m7oSLQBVqhuguEiNXmJqoBL
         tuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRJEvr70IzHCqubocLMuXrvU7JHp9bq9qzJ0p02omVs=;
        b=LaU+6gbRnIW3ULc169n/Pu0cPPBzfmTPmL/4exYqjQU8SddZesAl7JrurYK9bzeAUr
         9f5bo+xAxvrRrTsc3lE8/CKWgWwuUUjaz0CKCLELHG5xMxmw/Aw0psHKe1tFPOouLqTM
         FzTyYAuJQztu+Jyuut2X4SdX5uBKFwYhhKLRgWU3vXDZd0DGfjwoGAL0jFCLdjVSsCH0
         0v/MnhjuRN6K/Ak3+ySlbl94flxhOVOZfkvXkLiYVwjipQIS09NGMqchJgudDD/mKQql
         wahJBVnLENuFPL5M7kaNRhA5Ysgs2FXxzwm18F1N2n1EDksjPA7pWPa19zMuEzS5KdWh
         V+nw==
X-Gm-Message-State: AOAM530A26Z+z8qOmBE4N1FnlRAint1JmEMdl1d+spZJUlhAqwkk08TX
        +ihZ9+sUgAGvQ00ymZTMZl4=
X-Google-Smtp-Source: ABdhPJyW5zg56gpPIPanmhIsR7LtvfTLbkkJXUShLBoglHqsL3mpjiR1jUj1GendPoENubmigK/2Rg==
X-Received: by 2002:a17:90a:a103:: with SMTP id s3mr12973213pjp.158.1615813738543;
        Mon, 15 Mar 2021 06:08:58 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id d134sm13370955pfd.159.2021.03.15.06.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 06:08:58 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, krzk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <cxfcosmos@gmail.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] cpufreq:s5pv210:Fix typo issue
Date:   Mon, 15 Mar 2021 21:08:55 +0800
Message-Id: <20210315130855.9715-1-cxfcosmos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

change 'freqency' to 'frequency'
change 'accoriding' to 'according'
change 'untile' to 'until'
change 'souce' to 'source'
change 'divier' to 'divider'

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 69786e5bbf05..72321c4507af 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -91,7 +91,7 @@ static DEFINE_MUTEX(set_freq_lock);
 /* Use 800MHz when entering sleep mode */
 #define SLEEP_FREQ	(800 * 1000)
 
-/* Tracks if cpu freqency can be updated anymore */
+/* Tracks if cpu frequency can be updated anymore */
 static bool no_cpufreq_access;
 
 /*
@@ -190,7 +190,7 @@ static u32 clkdiv_val[5][11] = {
 
 /*
  * This function set DRAM refresh counter
- * accoriding to operating frequency of DRAM
+ * according to operating frequency of DRAM
  * ch: DMC port number 0 or 1
  * freq: Operating frequency of DRAM(KHz)
  */
@@ -378,7 +378,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		/*
 		 * 6. Turn on APLL
 		 * 6-1. Set PMS values
-		 * 6-2. Wait untile the PLL is locked
+		 * 6-2. Wait until the PLL is locked
 		 */
 		if (index == L0)
 			writel_relaxed(APLL_VAL_1000, S5P_APLL_CON);
@@ -390,7 +390,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 		} while (!(reg & (0x1 << 29)));
 
 		/*
-		 * 7. Change souce clock from SCLKMPLL(667Mhz)
+		 * 7. Change source clock from SCLKMPLL(667Mhz)
 		 * to SCLKA2M(200Mhz) in MFC_MUX and G3D MUX
 		 * (667/4=166)->(200/4=50)Mhz
 		 */
@@ -439,7 +439,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	}
 
 	/*
-	 * L4 level need to change memory bus speed, hence onedram clock divier
+	 * L4 level need to change memory bus speed, hence onedram clock divider
 	 * and memory refresh parameter should be changed
 	 */
 	if (bus_speed_changing) {
-- 
2.25.1

