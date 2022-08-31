Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205375A747B
	for <lists+linux-pm@lfdr.de>; Wed, 31 Aug 2022 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiHaDcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 23:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaDcX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 23:32:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AEB6E88F;
        Tue, 30 Aug 2022 20:32:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 72so13226216pfx.9;
        Tue, 30 Aug 2022 20:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nPaDIn/sK01+deqEGSWcjlk2p2vZQ2Os08WFJvZ7Ixw=;
        b=DRZfuSDN6GRbsmTBn85sNzAsFAH2Za3oO615Hb1Jq7zE51jeGVrLhCnt9/mQGZPyLS
         XwZSMot51L0FJvmn2wfAlNDvjjI+fJJy4ruIcgILk7PE/C4O0+sMGr0b6N9hBF3X6Lj7
         LBpLq2XM/HGxEvnkBhsRjlp1N905JuWFHcn5Fua0cm0UE9s5BEmXFFlLHL3pYLgTQLKA
         Di20Vw4/FLxnY3aZHzaHUayOxgZzjUQXIKcIGUrNvBzvwRk0ANOulFjFZy0s/4CT/enG
         LSJTDexJ1i5sL1lNrF8/VoOy5x6HibUSy+TagyEvtvPtqianSTyJc/wDn5hWbTUYddjp
         rxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nPaDIn/sK01+deqEGSWcjlk2p2vZQ2Os08WFJvZ7Ixw=;
        b=4hUeETkdZzifMukFe1+ghKsUFDiewebQLzODyPy7+xqbu/tqEicgdvEHKVfLWgNA+U
         cVVAK21jGZX7QPQaLa6FiQm9Dws1cOayBYZfBurid9iCf/X+X8uOTK0K+G9G/fc3PzxG
         E+JGmf7pMuiBroXAJznxjVymORP1ZmLBNwYw5vsvRXrlDZTvao7iVQo56vLuErKBLnWF
         DBJv1EKsRFGyAB8aS0Di92JNkyDLTQfUUGZdWHi5k+2L90+aYKlfID6WIS7VjgZPm3eO
         lslV+Ilt2he4ncuwFqlCXxrchXxHAOAR/8SPDVYj+BtfZIhiinj/XndSo2yfJ+DFzTeM
         G8gw==
X-Gm-Message-State: ACgBeo37o5DTX0C8FNDevznP/8V/tuXbmI9sf5jARGQl+QnGolT7ehxU
        paZQBBCbZrjExCUBzKyiP50=
X-Google-Smtp-Source: AA6agR7J85GXAhFXMalz5txQ4T8714W4il3NeyfLmW5+guT4vEAG59kh3dQ01DUm9dB7wwWaOO2u0w==
X-Received: by 2002:a63:4e25:0:b0:41c:62a2:ecc3 with SMTP id c37-20020a634e25000000b0041c62a2ecc3mr20670579pgb.596.1661916742023;
        Tue, 30 Aug 2022 20:32:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0016bb24f5d19sm10596717plh.209.2022.08.30.20.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:32:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     rafael@kernel.org
Cc:     viresh.kumar@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] cpufreq: tegra194: Remove the unneeded result variable
Date:   Wed, 31 Aug 2022 03:32:13 +0000
Message-Id: <20220831033213.302056-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value smp_call_function_single() directly instead of storing it
 in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/cpufreq/tegra194-cpufreq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 1216046cf4c2..7e143c06972e 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -314,11 +314,7 @@ static void tegra194_get_cpu_ndiv_sysreg(void *ndiv)
 
 static int tegra194_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
 {
-	int ret;
-
-	ret = smp_call_function_single(cpu, tegra194_get_cpu_ndiv_sysreg, &ndiv, true);
-
-	return ret;
+	return smp_call_function_single(cpu, tegra194_get_cpu_ndiv_sysreg, &ndiv, true);
 }
 
 static void tegra194_set_cpu_ndiv_sysreg(void *data)
-- 
2.25.1
