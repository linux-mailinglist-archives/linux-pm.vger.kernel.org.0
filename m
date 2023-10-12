Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC87C7573
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442127AbjJLR7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441944AbjJLR6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D00D8;
        Thu, 12 Oct 2023 10:58:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98377c5d53eso196194666b.0;
        Thu, 12 Oct 2023 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133530; x=1697738330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUzeKB1yCFHbHpy/R/DeukJyJ6pBoEQylMQ/XA8sQ4U=;
        b=fphUbuP55o+wa/a6FvD0yF8Ys1nS0HJHhNeMIbvREYnreg96Blv1VXgeMMwcEJLEU6
         zBsE0trI00fKSxwTHM3H1m2o25hvisUeER7KJRTkK9IdHkNz3zvo6K9iRrvUxtzMsa1K
         zzs2DrFts85eU7qrSMPjfl+wOcv/nhNpXGSDpTpLWWZniSKGS1+sbayqCpWh0kXEItW6
         4IRJUOSttfOrAj368ymg2mq68X0d9VOvDXdhmICzcPJN2zZmpUKR39GntFguqZLRA+jb
         pGEAHctoNpcOvEyLOHImTfRgRspPsbl0Vpco7+EaPv5emtw4/NN6Yx113/6dBmfWrlod
         NzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133530; x=1697738330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUzeKB1yCFHbHpy/R/DeukJyJ6pBoEQylMQ/XA8sQ4U=;
        b=YpBaUSwXq0hqpZ5UqB7cqbgIHwA210C2v7cDq8PRLiJRAFBMFdw06T+k2+ilkQrnxh
         s1E0Zd/krK7rOFDX+4lSqJbFKrVMN2LsSv4WGr+4KAlSxr8uKTpXyC5iC3Ukm7nSnpsh
         E9MrK6vP9071MeXhO76iBpZTgtn2n1pShxb4sXyz4isjvROC9AaMpNSqFHNYf9WWRIVK
         z9gmzZUs4fmisHfMargGWNzgib6JmqDycZj4FPYMLVlf7qfVDHwj6vmMjnanAKwhk4RQ
         1TxKx/V6YZUWWiZ0GAfT7MhIkJHhivcH+GGKee0mEgj2Z4pyVcNbIR5I9WImYytdoYit
         YtAQ==
X-Gm-Message-State: AOJu0Yx5bwcTXzjOHM7y6OkFGHfrhWbmbfjvM+XopVkU5MIxyFkc2L/U
        WFeOrjGHI0NF9U+pFakxtYk=
X-Google-Smtp-Source: AGHT+IHaxIhtOujcEyPSq8wJRA+tkkWT7e+x3qFSajkRsuhGygsn9qYqURFra05J/HY7qpW3au+qaQ==
X-Received: by 2002:a17:906:3081:b0:9ae:73ca:bbad with SMTP id 1-20020a170906308100b009ae73cabbadmr22046397ejv.43.1697133530282;
        Thu, 12 Oct 2023 10:58:50 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id rp19-20020a170906d97300b009b95b46bbd1sm11323217ejb.133.2023.10.12.10.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:50 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 07/13] thermal: tegra: Use unsigned int where appropriate
Date:   Thu, 12 Oct 2023 19:58:28 +0200
Message-ID: <20231012175836.3408077-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use unsigned integers more consistently, which helps to make it more
explicit about what values can be expected.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 105ec20d509d..c7f8e36cbeab 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -591,8 +591,9 @@ find_throttle_cfg_by_name(struct tegra_soctherm *ts, const char *name)
 
 static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 {
-	int i, temp = min_low_temp;
 	struct tsensor_group_thermtrips *tt = ts->soc->thermtrips;
+	int temp = min_low_temp;
+	unsigned int i;
 
 	if (id >= TEGRA124_SOCTHERM_SENSOR_NUM)
 		return temp;
@@ -1469,33 +1470,34 @@ static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 {
 	struct tsensor_group_thermtrips *tt = ts->soc->thermtrips;
 	const int max_num_prop = ts->soc->num_ttgs * 2;
+	unsigned int i, j, count;
 	u32 *tlb;
-	int i, j, n, ret;
+	int ret;
 
 	if (!tt)
 		return -ENOMEM;
 
-	n = of_property_count_u32_elems(ts->dev->of_node, "nvidia,thermtrips");
-	if (n <= 0) {
+	ret = of_property_count_u32_elems(ts->dev->of_node, "nvidia,thermtrips");
+	if (ret <= 0) {
 		dev_info(ts->dev,
-			 "missing thermtrips, will use critical trips as shut down temp\n");
-		return n;
+			 "missing thermtrips, will use critical trips as shut down temperature\n");
+		return ret;
 	}
 
-	n = min(max_num_prop, n);
+	count = min_t(unsigned int, ret, ts->soc->num_ttgs * 2);
 
 	tlb = devm_kcalloc(ts->dev, max_num_prop, sizeof(u32), GFP_KERNEL);
 	if (!tlb)
 		return -ENOMEM;
+
 	ret = of_property_read_u32_array(ts->dev->of_node, "nvidia,thermtrips",
-					 tlb, n);
+					 tlb, count);
 	if (ret) {
 		dev_err(ts->dev, "invalid num ele: thermtrips:%d\n", ret);
 		return ret;
 	}
 
-	i = 0;
-	for (j = 0; j < n; j = j + 2) {
+	for (i = 0, j = 0; j < count; j = j + 2) {
 		if (tlb[j] >= TEGRA124_SOCTHERM_SENSOR_NUM)
 			continue;
 
@@ -1612,7 +1614,7 @@ static int soctherm_throt_cfg_parse(struct tegra_soctherm *ts,
 static void soctherm_init_hw_throttling(struct tegra_soctherm *tegra)
 {
 	struct device_node *np_stc, *np_stcc;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < THROTTLE_SIZE; i++) {
 		tegra->throt_cfgs[i].name = throt_names[i];
@@ -1875,8 +1877,8 @@ static void soctherm_throttle_program(struct tegra_soctherm *ts,
 
 static void tegra_soctherm_throttle(struct tegra_soctherm *ts)
 {
+	unsigned int i;
 	u32 v;
-	int i;
 
 	/* configure LOW, MED and HIGH levels for CCROC NV_THERM */
 	if (ts->soc->use_ccroc) {
@@ -1950,8 +1952,8 @@ static int soctherm_interrupts_init(struct tegra_soctherm *tegra)
 static void soctherm_init(struct tegra_soctherm *tegra)
 {
 	const struct tegra_tsensor_group **ttgs = tegra->soc->ttgs;
-	int i;
 	u32 pdiv, hotspot;
+	unsigned int i;
 
 	/* Initialize raw sensors */
 	for (i = 0; i < tegra->soc->num_tsensors; ++i)
-- 
2.42.0

