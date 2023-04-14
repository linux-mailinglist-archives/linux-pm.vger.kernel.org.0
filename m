Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEABF6E23DE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDNM6D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDNM6C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:58:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA0269E;
        Fri, 14 Apr 2023 05:57:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so8198448wmb.3;
        Fri, 14 Apr 2023 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477054; x=1684069054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZSnA9V82lqicVJGiNFqWTCI4618K2puWAelw0l2AMA=;
        b=eGQKkP65wDojg6CW+4mQy90XuO5RjVA/nIqhc55r9E7GHARoNDdSczIP5Aba23zkno
         BCSYC9Fo1Lj6vcTEiUo1FIrBK7b3cgYx8nlMXv6m7/gVAew4ibtRx3AUaN6kr3OLO5v2
         kme0o7cG+d7oKiOR7TDNENGui1Kb1/VF/BQCzQKw0fRzb+VbxFIvUbSuUzGB8Cd+p1JC
         F8Cv9oPKv50hoHKeofD6jEyvJFIjqPy+sVdOhLyhCVGZ74FeGNZdtwBXrJRKR2crqK+0
         7a8Sq83vz9MVvkBEIXNdTv2SoUNiaEPvJIGrliL98jKmW45yql7v62q6wBm1HUkWRZKV
         VkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477054; x=1684069054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZSnA9V82lqicVJGiNFqWTCI4618K2puWAelw0l2AMA=;
        b=DRhnOtG9RtAumcxneeSx8JWt33/LozDXWWTarRBVgz+LxNpQu6jY7wC+ZdiwHbpYJ6
         z8vjZQkbdUQ5+eSNRFbmc66e/7UJKN+GYYaUefAVlpwdWg5YLkEtge6OGNKkC1IjheXy
         JLPKbp5OixhT72DUIjjt3cWFmAl4vgH3nPtH5yBB2kw1kRKZbAgkW2Kqc+W2+UfkUnQv
         mxLPkG4Rle5Nm5ic5iIgAa8HXuiULxzVuPNNuPmTIMCZxUfqn5IY8HYImW3H+9gjghd5
         TdgZoUdgR00PwD754/VaYGRkw7lNI2EzPXx5D95e3K2L0gwMoOlOsAhNP1iOj4YG5hRZ
         zWlg==
X-Gm-Message-State: AAQBX9ebZ71AGO6mVQWSYTt6qiZAMTLdy4CyRY5ae51Hxag1kF3vxevJ
        jO89dQHqef5bj6ETMAjKrPs=
X-Google-Smtp-Source: AKy350bunq95HazkEFvBWGKoHsHyRQ8ZmABKuw3+odFHdf4DWvKThsba/WB7Y+wEObgFe8YN2VHvmg==
X-Received: by 2002:a05:600c:330a:b0:3f0:9fec:a5c2 with SMTP id q10-20020a05600c330a00b003f09feca5c2mr4330365wmp.15.1681477054560;
        Fri, 14 Apr 2023 05:57:34 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d55c4000000b002f74578f494sm1130398wrw.41.2023.04.14.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:34 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 08/10] thermal: tegra: Minor stylistic cleanups
Date:   Fri, 14 Apr 2023 14:57:19 +0200
Message-Id: <20230414125721.1043589-9-thierry.reding@gmail.com>
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

Fix up some whitespace (padding, identation) issues and reword an
unreadable comment.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index b6e61393fb8f..ba93ea1486f6 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1459,7 +1459,9 @@ static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 	ret = of_property_read_u32_array(ts->dev->of_node, "nvidia,thermtrips",
 					 tlb, count);
 	if (ret) {
-		dev_err(ts->dev, "invalid num ele: thermtrips:%d\n", ret);
+		dev_err(ts->dev,
+			"failed to read \"nvidia,thermtrips\" property: %d\n",
+			ret);
 		return ret;
 	}
 
@@ -1756,7 +1758,7 @@ static void throttlectl_gpu_level_select(struct tegra_soctherm *ts,
 }
 
 static int soctherm_oc_cfg_program(struct tegra_soctherm *ts,
-				      enum soctherm_throttle_id throt)
+				   enum soctherm_throttle_id throt)
 {
 	u32 r;
 	struct soctherm_oc_cfg *oc = &ts->throt_cfgs[throt].oc_cfg;
@@ -2048,8 +2050,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	soctherm_init(tegra);
 
 	for (i = 0; i < soc->num_ttgs; ++i) {
-		struct tegra_thermctl_zone *zone =
-			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
+		struct tegra_thermctl_zone *zone;
+
+		zone = devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
 		if (!zone) {
 			err = -ENOMEM;
 			goto disable_clocks;
-- 
2.40.0

