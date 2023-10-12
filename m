Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F3D7C7574
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441930AbjJLR7A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379692AbjJLR6w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FCBDD;
        Thu, 12 Oct 2023 10:58:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso2194074a12.1;
        Thu, 12 Oct 2023 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133528; x=1697738328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w1QvXNCjhCwydWbGL6K5jdkXe4i3JkNhn/cRw8swm4=;
        b=cd8EERvH6wtA3LHXZkYQCkeN3lQZVJO6i+bWn6+alq09962D6Lf2wkRk/mfoY/Rjrn
         LgBx5Qib4SM/B+jK5QkaOBLeUarNfmIbMEQroF5SGbsVtOPN1zXExGl02d0UKufWtaf5
         Fr9LeTdkUgSq35OVZkUtaOHXdmQq6HTcBhOqPCi0SPDY+QsxaJLkv03puVgW2kbi/B3x
         XEwu6ggUI/HwOps+v0/mDRtmUYa/mjN1xTV64Myx4r3xBbC1ziKNugj3hytA3DupGAi2
         7hbZYmB92L2K+nJZvCo1SQwFefWIDgvw7VE5uFMBGBxJQH6tVZyB3xQtEk77RD4Ac1lE
         P43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133528; x=1697738328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w1QvXNCjhCwydWbGL6K5jdkXe4i3JkNhn/cRw8swm4=;
        b=sqq+ayWtMIBF2F+7dqTCmKdvlX1tqutVbUqVFcOIEZHF88y5ReeDizKhfWtPElGSvq
         xFF+mqJUuNKvRguUv/WeH2coMUOmJtsB7+d6RZ01pNfdgjPVYiSKxWW8M2Elx4RCqsna
         35uOnaNX7f2w5IYQaEYEzz531BWYda44tkgy82Adz3QJxKV0vkIVLtlFeE+Ma0hAqljb
         BYC9Fwx4oiz8kEvkNtkHpSny9sVliT9KlvueE6z7CIVeRDmRz/vFq0/APINYYVHMu8lH
         Fkd+nJ6vs5z08Wy3GGYX/v+L867ys56HQI/qTjW5y7WTfRDmvmyehPjk/BqnA1IGB+pS
         6RxA==
X-Gm-Message-State: AOJu0YwvAtbseHel2NSnzRp8rIZbE0yph1WNiMxSVe15Fq8cbaV3ATYa
        BOAvZvX5Mnd0IRGocAcpzSs=
X-Google-Smtp-Source: AGHT+IENSRl5HdQNxKI72dP6CzFsGJdIGO1t5hauPXbx3MvA5x2RA3yUuEsex+p3PXXTGUJ7hKdUSg==
X-Received: by 2002:a05:6402:2065:b0:53d:f072:7b0a with SMTP id bd5-20020a056402206500b0053df0727b0amr3279263edb.39.1697133528424;
        Thu, 12 Oct 2023 10:58:48 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b25-20020aa7df99000000b0053808d83f0fsm10417564edy.9.2023.10.12.10.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:48 -0700 (PDT)
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
Subject: [PATCH v2 05/13] thermal: tegra: Constify SoC-specific data
Date:   Thu, 12 Oct 2023 19:58:26 +0200
Message-ID: <20231012175836.3408077-6-thierry.reding@gmail.com>
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

The SoC-specific parameter structure is read-only data, so consistently
use const to mark it as such.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index f434e141dcdf..11c23ace2c81 100644
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
 
@@ -2220,7 +2216,7 @@ static int __maybe_unused soctherm_suspend(struct device *dev)
 static int __maybe_unused soctherm_resume(struct device *dev)
 {
 	struct tegra_soctherm *tegra = dev_get_drvdata(dev);
-	struct tegra_soctherm_soc *soc = tegra->soc;
+	const struct tegra_soctherm_soc *soc = tegra->soc;
 	int err, i;
 
 	err = soctherm_clk_enable(tegra, true);
-- 
2.42.0

