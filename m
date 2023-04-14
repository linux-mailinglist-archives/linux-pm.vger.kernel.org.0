Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED336E23D3
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDNM6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjDNM56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:57:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A48B46E;
        Fri, 14 Apr 2023 05:57:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l18so17339582wrb.9;
        Fri, 14 Apr 2023 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477052; x=1684069052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9pPG1OjYyEL7kO5yYxLJmvkbxiHIdIeQSpBsx+hCOU=;
        b=kQaJ7QgsbOqWgtJ15q+8DkBZ+48TChGVap0TBGLSr+8s5PWnQvaSUKoA7WF+EEPhev
         ObIcpXsum6Lt74A4JULtF1jrzPgMVxsb0l/INe6rypOMY5ynTO5omcZYLtvhYpNQCocp
         fQqV0aBeqwlFSz1c7S2LjlMXjwbLb/N82xg+bmI2Fc7k44DIR2QFRqst6UK2qbuR7/od
         Aj22785Z6lAoo8u2ojgjX74u7slvAp43i9gYaAjelfdJdgGoJZlKxT1Vsymnr6GM0k47
         4DNDY8kUE9IAQiWIMVvB+lzG1DhOzNt27kmrPY03oG+MugIZYLLGHkx5Nc5GzQ4ykbUM
         Ne+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477052; x=1684069052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9pPG1OjYyEL7kO5yYxLJmvkbxiHIdIeQSpBsx+hCOU=;
        b=h+RWRTYoXHMpyNzixXQ96OD9+0Ql7onjMV9CZYNcTtwsySdI4HXmRjqPKnG7w/lkaP
         jM4XHPJDth8swR3r4a7z9rGTymdwQW1Bk/AOvtXb6vrZNPJpclAapxsoWX0JKfoK3aXG
         FrQMuKToNTHePwzSMBsMkxar2YKJWziOQSkhON832Q5mMa6PeuzqbGfUgYwlPxrY9o8t
         p1qae2vAPEtwIDIYLt6NEorYrETie+HdpljDUHwqSedhXrfQLE0Ux2fDN4ALutSbP4ls
         noOOjwXWaPpCV8/8rO9teeIwO3S9qvNmK9Aw9+cDnLJT6/udt52bpx+Et14og4JcVEz0
         CGcA==
X-Gm-Message-State: AAQBX9cZaNimF1EG8iMkjA+vnA0sxxTKAHRVdyhK3COig8OAd1y1ausI
        4oa5AO0VcC8UCLYHPXEbOK8=
X-Google-Smtp-Source: AKy350a4O9nfwcQIEYjlFeCGsF4GeEnqQdrpDwxUqdbib6eeOfAvfYgoy4cB0c/A70Uktqsmcvdc8A==
X-Received: by 2002:a5d:45c7:0:b0:2e5:1da2:2a06 with SMTP id b7-20020a5d45c7000000b002e51da22a06mr4065996wrs.5.1681477051751;
        Fri, 14 Apr 2023 05:57:31 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b15-20020adfe64f000000b002f00793bd7asm3512111wrn.27.2023.04.14.05.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:31 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 05/10] thermal: tegra: Use unsigned int where appropriate
Date:   Fri, 14 Apr 2023 14:57:16 +0200
Message-Id: <20230414125721.1043589-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414125721.1043589-1-thierry.reding@gmail.com>
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
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

From: Thierry Reding <treding@nvidia.com>

Use unsigned integers more consistently, which helps to make it more
explicit about what values can be expected.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index eb12e8cc0a2f..730b034004cb 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -565,8 +565,9 @@ find_throttle_cfg_by_name(struct tegra_soctherm *ts, const char *name)
 
 static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 {
-	int i, temp = min_low_temp;
 	struct tsensor_group_thermtrips *tt = ts->soc->thermtrips;
+	int temp = min_low_temp;
+	unsigned int i;
 
 	if (id >= TEGRA124_SOCTHERM_SENSOR_NUM)
 		return temp;
@@ -1436,33 +1437,34 @@ static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
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
 
@@ -1556,7 +1558,7 @@ static int soctherm_throt_cfg_parse(struct tegra_soctherm *ts,
 static void soctherm_init_hw_throttling(struct tegra_soctherm *tegra)
 {
 	struct device_node *np_stc, *np_stcc;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < THROTTLE_SIZE; i++) {
 		tegra->throt_cfgs[i].name = throt_names[i];
@@ -1819,8 +1821,8 @@ static void soctherm_throttle_program(struct tegra_soctherm *ts,
 
 static void tegra_soctherm_throttle(struct tegra_soctherm *ts)
 {
+	unsigned int i;
 	u32 v;
-	int i;
 
 	/* configure LOW, MED and HIGH levels for CCROC NV_THERM */
 	if (ts->soc->use_ccroc) {
@@ -1894,8 +1896,8 @@ static int soctherm_interrupts_init(struct tegra_soctherm *tegra)
 static void soctherm_init(struct tegra_soctherm *tegra)
 {
 	const struct tegra_tsensor_group **ttgs = tegra->soc->ttgs;
-	int i;
 	u32 pdiv, hotspot;
+	unsigned int i;
 
 	/* Initialize raw sensors */
 	for (i = 0; i < tegra->soc->num_tsensors; ++i)
-- 
2.40.0

