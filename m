Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620333399FC
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 00:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhCLX3K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 18:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhCLX2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 18:28:53 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553CFC061574;
        Fri, 12 Mar 2021 15:28:53 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id j17so5107634qvo.13;
        Fri, 12 Mar 2021 15:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NksHk6o9BZVf367p18XMGJ+vJsqnrfhkmXtcTXnK83c=;
        b=CseHd52+WFd5w8nDAJD8ldnopH3/uvcsy797QER94OUBRD0zq9Ymz0UQiPvXueeiR+
         arsidgxosqRTg3vmbX9f1QFHsHbHTZVbiG9eo/Qe4J3XjxHVoLLRmHn4liYwLJ+Ou73M
         ru8GfUrWd8sn3hwvbh5Gmr989VQBKDA9nqKrqeL4wblc7uanDN+mQFiSDbGU+6p+tFQo
         OKxLCCCuRLAOeu6yzyqQF03K/Oi4tHL50MCxRQGRO9E5BKiLbTn0FRHaYVHeSH0ntBiC
         khG4DxvM1Ix+nozMHQnEevaFC1F/UbuXA5ylgpKdnW9Uohs8GdKNaWbYWEkTt31F2uV9
         kduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NksHk6o9BZVf367p18XMGJ+vJsqnrfhkmXtcTXnK83c=;
        b=UdMKIe5P4luGQc+f7YjBz/citRJ4H2Dfy5FAZ2uVdmfMiaqTAkC/OXCZauEU8HsVKS
         KBTJYWvd+keCzGbHPIg4I7Ml7GYAyhk/69/TUDFbWgCVhxUwZi5hgk79V/4pHZuCVg7x
         qfEvNvxc0fByXNMMzjQbNtiSaOGhs+tqRbTKjD/0dXQ6iNSMNx0a8CgRQNA/HCGZEzFv
         RUvapNBnYTrH6As9YayC9ECqvhbrz2j2iIglVeoPtmphCDl+WMK9NibtFoBRBNpm8f97
         TkEmz3JxaDDQPc+7ciq5LS9UVyI1gMVyeSHx4DQSMYRcoMHlucptSOq5iVhAwLgdkVAB
         tUjA==
X-Gm-Message-State: AOAM530iuwim2gx0ERjJCuGaK2r9kqSRDbawdRoVzw6oSNcKg4cs0+W+
        K97QNJ/csX19TNeABa89LAk=
X-Google-Smtp-Source: ABdhPJywXiwA/rZMVLEZFNQAcgYRy+304alblOIfyzDWSYUPev7gXuszb788zek1UFPLVQ9+vxHuhg==
X-Received: by 2002:a05:6214:d6d:: with SMTP id 13mr699275qvs.60.1615591732622;
        Fri, 12 Mar 2021 15:28:52 -0800 (PST)
Received: from localhost.localdomain ([156.146.54.3])
        by smtp.gmail.com with ESMTPSA id 17sm5455448qky.7.2021.03.12.15.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 15:28:51 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] cpufreq: Rudimentary typos fix in the file s5pv210-cpufreq.c
Date:   Sat, 13 Mar 2021 04:56:21 +0530
Message-Id: <20210312232621.2083-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


s/untile/until/
s/souce/source/
s/divier/divider/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
   Krzysztof spotted a grammatical flaw left over ...so corrected..

 drivers/cpufreq/s5pv210-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 69786e5bbf05..af1ac3f6e4b8 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
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

