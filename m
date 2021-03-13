Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC80339B9E
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 05:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhCMDxB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 22:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMDw1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 22:52:27 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813BC061574;
        Fri, 12 Mar 2021 19:52:27 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id m186so9911205qke.12;
        Fri, 12 Mar 2021 19:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iepmwUErVLR4gCT4NQ9D13hsXaYoesUmxjRuMtpazw=;
        b=Ia0zCxJ/ZJLdAmN/xs8X/b3SNfOoU7fDmRm1auOhVLB1wT8asAn/Wd7/MoLdc2SxkV
         qZpfKWNoAf+CbN6OdCrFk/7zMcOm69g2o6/lWiG/gj4YrDR1P4MDQ2+hyYw3YihhrO1y
         D6B+tnbreCqBUVFXxLoow5tUtQUHvxKOTvcG9Oi/wtf/1Xkgym06llpcYOQ3jhGD3mZL
         DNDBIFQlFFFtVggMjCq5TS3Dtu36TZTk694x+VG2OI4MLhkJgB9DI5JXEwBh8PIOpr5v
         DlO7Q36CN/HTpHBR1OMfMlcHWwHuXlupQaJbqmSLa47qM5yG3p6LT4HercntNfEkun6T
         Ah7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iepmwUErVLR4gCT4NQ9D13hsXaYoesUmxjRuMtpazw=;
        b=ngNecc3/qJSk75gedG+8z24VgtDzhjEIXYzZe7OoDnbNIlpFkFy4blltFYaaYR4JXU
         31NOntFiUhkQxe75+WdJ04TD6pvPViHo2khkC5vAZJQx4cWNV6x0Ef+lJYly/xchvaCx
         ntw4H9EJ+aab/WMC6d1m2hqongt1TqV8cK2M+61Osazrgp2LvP8gPSGPXKkbhcLD1Eqb
         gwRXWRptCbQeht+TCZFBOrFJ171jZ5BLfYq87HXynhXmVa7xUGDkH2DmPYoWmByRCu/q
         s6ym6L99hFWJMnCFNBuR01gWMd57fGYaRwFy9JmHzgLqkcphU6b2qn4j1uErrEXUXKk/
         QJLA==
X-Gm-Message-State: AOAM530KreajAfULKCJWHM4s9OZPmziQGiwt6lA+bnkCpJBxHyidVDvC
        q/fGko86cE3xdjLMTcgpelI=
X-Google-Smtp-Source: ABdhPJz8R7/xayF/Qhe6GXMX8hyHvlso3Nl+V0cWXIWPouf9m34Jb4Kc3LCCmga6FOTgR7mjotut4Q==
X-Received: by 2002:a37:6c1:: with SMTP id 184mr15421331qkg.462.1615607546562;
        Fri, 12 Mar 2021 19:52:26 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.104])
        by smtp.gmail.com with ESMTPSA id c27sm5806645qko.71.2021.03.12.19.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 19:52:25 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V3] cpufreq: Rudimentary typos fix in the file s5pv210-cpufreq.c
Date:   Sat, 13 Mar 2021 09:19:51 +0530
Message-Id: <20210313034951.13269-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Trivial spelling fixes throughout the file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V2:
  Incoporated the findings of Tom Saeger <tom.saeger@oracle.com>

 drivers/cpufreq/s5pv210-cpufreq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 69786e5bbf05..73110b005716 100644
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
@@ -320,7 +320,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)

 		/*
 		 * 3. DMC1 refresh count for 133Mhz if (index == L4) is
-		 * true refresh counter is already programed in upper
+		 * true refresh counter is already programmed in upper
 		 * code. 0x287@83Mhz
 		 */
 		if (!bus_speed_changing)
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
+	 * L4 level needs to change memory bus speed, hence onedram clock divider
 	 * and memory refresh parameter should be changed
 	 */
 	if (bus_speed_changing) {
--
2.26.2

