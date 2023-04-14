Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7604E6E23CF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDNM5y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDNM5x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:57:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCA7AF3C;
        Fri, 14 Apr 2023 05:57:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso16486411wmq.2;
        Fri, 14 Apr 2023 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477049; x=1684069049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaBrk11q48i3/r1oBLKd+aJHK6utmrPZfM1ILPoyDxo=;
        b=kE7ONyWMVeJ8IBCgWHtKCiutF5wISIzLPbZhfS1L5mUADDpCBvGFiZ3QPlw//GsvsS
         VwnBtUcOqDaXLtchHNMb/Qwu/8uY5Zw98dYaOYWzd0C5dhkfaiTGKoPrhUGPuJwNH+OA
         flZJCxUojDgcJ5WXT7aoBtANYHvkWxWrIcGbjycvjv4CtEntzdv7FwdRzkCEXEdwTy9O
         OVAws2QDJnyPBnDz2Pw5uI+FjXwNf3cEOazZs4dn6HZ5GJP5eKzYE+Q8RQw45cNYucIr
         esckSbLv1Eyhn1yF6RU4OWQuLXzRsYSuSIect0EuXGBq8YCumNVDazwiTV1kUP2YIz0m
         JgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477049; x=1684069049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaBrk11q48i3/r1oBLKd+aJHK6utmrPZfM1ILPoyDxo=;
        b=UfG1bcOnSXBIfhAdX66hDNJL5zJkCMzCVK040vsGMXcl0S7668IxIwdH1wmRrJUUfH
         DwXDBbnglmfS+eMDx6i5Br5uuEQMwwgMk4oijdiKV70/zq1l8jkYwA2p96Xzip+rYqgT
         58HZ/WT+Q1gOOJjGGuSe0iy6jEwCI4732R2IN7ZwAHDDBhLINQ7o4pSeWbvgHYtBh9nK
         w7FjDUeY6Udb1MwEMAHE5M7S0tx4FYQX2EKyOear3IDaQ/4YalgBqeSzLAyPlZQcJFIB
         QrhrIkUghp92ecdNdU2zjd11NU4t2eLbahIDK9HTloLX4H/wGEI/hWMyP4dHVN165XvG
         ur2A==
X-Gm-Message-State: AAQBX9diCNfJ5PeWgVvhJ6BGQg9Xcx4BSwIHMCtxc/9Qcm1+vlT9//1d
        9LxK3ZhVpMyviRGEZMlFvE7Nbc1ydJ8=
X-Google-Smtp-Source: AKy350bUkqvi535j/o/A+l1Bp6n2sbue+DdWT0BMcuK0ZIXlUvY/H1F+SpyPnhwkvgR01kBM9ytsZQ==
X-Received: by 2002:a7b:c8ce:0:b0:3f0:ad5a:d69f with SMTP id f14-20020a7bc8ce000000b003f0ad5ad69fmr3493364wml.25.1681477049436;
        Fri, 14 Apr 2023 05:57:29 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m14-20020a056000008e00b002c71b4d476asm3498377wrx.106.2023.04.14.05.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:29 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 03/10] thermal: tegra: Constify SoC-specific data
Date:   Fri, 14 Apr 2023 14:57:14 +0200
Message-Id: <20230414125721.1043589-4-thierry.reding@gmail.com>
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

The SoC-specific parameter structure is read-only data, so consistently
use const to mark it as such.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ca39340cd93f..958fa10de516 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -339,7 +339,7 @@ struct tegra_soctherm {
 
 	u32 *calib;
 	struct thermal_zone_device **thermctl_tzs;
-	struct tegra_soctherm_soc *soc;
+	const struct tegra_soctherm_soc *soc;
 
 	struct soctherm_throt_cfg throt_cfgs[THROTTLE_SIZE];
 
@@ -2054,19 +2054,15 @@ MODULE_DEVICE_TABLE(of, tegra_soctherm_of_match);
 
 static int tegra_soctherm_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct tegra_soctherm *tegra;
 	struct thermal_zone_device *z;
 	struct tsensor_shared_calib shared_calib;
-	struct tegra_soctherm_soc *soc;
+	const struct tegra_soctherm_soc *soc;
 	unsigned int i;
 	int err;
 
-	match = of_match_node(tegra_soctherm_of_match, pdev->dev.of_node);
-	if (!match)
-		return -ENODEV;
+	soc = device_get_match_data(&pdev->dev);
 
-	soc = (struct tegra_soctherm_soc *)match->data;
 	if (soc->num_ttgs > TEGRA124_SOCTHERM_SENSOR_NUM)
 		return -EINVAL;
 
@@ -2222,7 +2218,7 @@ static int __maybe_unused soctherm_suspend(struct device *dev)
 static int __maybe_unused soctherm_resume(struct device *dev)
 {
 	struct tegra_soctherm *tegra = dev_get_drvdata(dev);
-	struct tegra_soctherm_soc *soc = tegra->soc;
+	const struct tegra_soctherm_soc *soc = tegra->soc;
 	int err, i;
 
 	err = soctherm_clk_enable(tegra, true);
-- 
2.40.0

