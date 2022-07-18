Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D01D577985
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiGRCF7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jul 2022 22:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiGRCF5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jul 2022 22:05:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199B1263E
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 19:05:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 5so7801334plk.9
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 19:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BjGRHLy/P5muSoNU/Pz9GHQ5lT79yzzrjudG9IvvpQ=;
        b=U0y4ZBls7dp+IJthAqtm3XZcN2mDc6Moz9aOky11OGh5xiAsXPqmRYsA3ASCViImED
         vpJrYT4RAU/o8wPtQhqFHjcYkKJzY5G5DVfPTTfa0UUkzrJwXVN0Wm7mGz7f//bYkaRf
         uLDbNup6TOEzG9s3eL6z4z+h8Ena/JD34EfCsDDgjVc6CkEZMz602FQys6VUr388b92k
         mzcoV/yWkXI3Qs5gRCQGujTZ9y0IGWwMSULp+rPXNnTsMJGgNXBV3cabDo+FHSn+JhT8
         VJyK66uhR9Un2xnPRr02kdIGF0IdJIE5fAEvK+BGY9dLg3/K81yUur3oPa0Vc6PxR/eb
         9Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BjGRHLy/P5muSoNU/Pz9GHQ5lT79yzzrjudG9IvvpQ=;
        b=U/HzcN10lnZcNdxm7NUXgHyL4kuFt5pmc85vH1Jc4cLEQM25BiJn3UJltSa4yT9SyZ
         FQAPGDfbIaHkMNxLZBcTjIeji0Q7MMQSkxpfvaHFI+vP2CxYTwk/o60HRoTW2HDXyJdu
         +p0+9ws4jWKVMrIwQ0DaDW2/CiemLrAG9LakKti/oi3Q2n9edvjZrs15QZARKDCrAVTR
         zNopjuwPBVF+FQ3N1Fj9ie3o0OKJxCVlDwvbwRYCr3vVMzht+A7QaNwru4JA96jOm+up
         NrRSTmVjOJQ6KLCBLAWlQeNA98PIidqdNotdp2mPgAHSSmog800Y0+DSjWEdzuCD3plw
         uQ2Q==
X-Gm-Message-State: AJIora/9o7ycYF8vzfw4728rvPPbxauQLvCyAXouhYeDI/ZeSO5TInnU
        jau1xeAP8WD0X0U6Ukb7drAchA==
X-Google-Smtp-Source: AGRyM1uvcp85DEmyxiSH3PvubO+xKzXk2te9CDJYpnpmn6NbRBOkzE7RuaKMYrS+kcgYBbSLzhJsTA==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr36153656pjb.164.1658109956039;
        Sun, 17 Jul 2022 19:05:56 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78ed2000000b00525302fe9c4sm7863809pfr.190.2022.07.17.19.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 19:05:55 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: tegra194: Staticize struct tegra_cpufreq_soc instances
Date:   Mon, 18 Jul 2022 07:35:48 +0530
Message-Id: <5c1a9b405d96848f2dac9aefcef121ad178872f4.1658109927.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix sparse warnings by marking these structures static.

Fixes: 273bc890a2a8 ("cpufreq: tegra194: Add support for Tegra234")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra194-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 2a6a98764a8c..1216046cf4c2 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -162,7 +162,7 @@ static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
 	.set_cpu_ndiv = tegra234_set_cpu_ndiv,
 };
 
-const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
+static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
@@ -430,7 +430,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
 	.set_cpu_ndiv = tegra194_set_cpu_ndiv,
 };
 
-const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
+static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
 	.ops = &tegra194_cpufreq_ops,
 	.maxcpus_per_cluster = 2,
 };
-- 
2.31.1.272.g89b43f80a514

