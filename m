Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB97F0650
	for <lists+linux-pm@lfdr.de>; Sun, 19 Nov 2023 14:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjKSNGP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Nov 2023 08:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKSNGP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Nov 2023 08:06:15 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA82182;
        Sun, 19 Nov 2023 05:06:07 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bcdfcde944so1045319b3a.1;
        Sun, 19 Nov 2023 05:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700399167; x=1701003967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A09XQ/iM8ir9KSsU7sYyrVg8iTGWGF8CT8MAp5IDCU8=;
        b=CnbjXPFYRERgcAbgDuLwh8bsrlHIcCtluP8c9G9x4Ah3yzQjqfUrTPu7RYesp+qWLR
         zO/8U2JE/oiJ2J7d5liRqtfWO9cZixZbHyOtZP26okN1tR4P3GK8bwS830Myn9dJihKq
         NY/0T4g73T5IZjkoG81Mam6gf1fYAMTEwb7PXWci+p8Ge/88BjxN1Q/tRwt2EXAmXuZt
         /qOpchCTsEGlgPkVzs4xOl8UJg2fymUHm9Xt5iK21STQDVCaCRRLkvWbghQciLaN896d
         Zlug0sPNp3/+knguZI2OnEeJoTfLyIR60Ka+bFQ5mB7zwpmcE/J5BiVRsDkREHk3nTbQ
         AZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700399167; x=1701003967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A09XQ/iM8ir9KSsU7sYyrVg8iTGWGF8CT8MAp5IDCU8=;
        b=i4XC2xH8mGnkuwkKa+KK4/H+d7r3vZYIBvmhULgM3cE6CG3IJ0OqrpKt5DzGkjIdpt
         vL2WqwEL09rjK9cjh8afi+qml8jeMnPA+HChOwRJYycCj0pwl8VtwFpj8Aaf9MscMWLP
         g38QV+X1/hdp2zy8ym2odYd0uUZQIy91a7ObfkVNfvvodKmLIji5BAjItHLcLrA5FvaB
         aSzq3m+rY1vovgpeWHaM+vYEGRjIRFudz6FbdcZnqdPDhCiWCaE40ddi6uFRcLHpKdYX
         Bzt/mc7nnTZyJBisv2MpgT4JyFGKAxzMWbhiFa4/atVKQ2b6LoL9M+7Vk6o8spbtpbCR
         rAyg==
X-Gm-Message-State: AOJu0YzI7bXOlXaoZGudGahHKxZSbTIXUcrRE5W2xE6Ezkeoz9tnRFQm
        8UWfyXXwIY05ihI/s6RIp+Q=
X-Google-Smtp-Source: AGHT+IFQl4HKK6ys65WrWUwifoI4NPzXWOD3ZBmz1vcxHtWWOBZHlmULJn/28SRkbfmyA643+YWtzA==
X-Received: by 2002:a17:902:f691:b0:1cf:55c7:94e9 with SMTP id l17-20020a170902f69100b001cf55c794e9mr3726397plg.2.1700399167219;
        Sun, 19 Nov 2023 05:06:07 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8afe:6d39:e955:7d2a])
        by smtp.gmail.com with ESMTPSA id ik14-20020a170902ab0e00b001bde65894c8sm4433696plb.268.2023.11.19.05.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:06:06 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, mazziesaccount@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v11 4/4] thermal: thermal_of: Allow rebooting after critical temp
Date:   Sun, 19 Nov 2023 10:05:51 -0300
Message-Id: <20231119130551.2416869-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119130551.2416869-1-festevam@gmail.com>
References: <20231119130551.2416869-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Currently, the default mechanism is to trigger a shutdown after the
critical temperature is reached.

In some embedded cases, such behavior does not suit well, as the board may
be unattended in the field and rebooting may be a better approach.

The bootloader may also check the temperature and only allow the boot to
proceed when the temperature is below a certain threshold.

Introduce support for allowing a reboot to be triggered after the
critical temperature is reached.

If the "critical-action" devicetree property is not found, fall back to
the shutdown action to preserve the existing default behavior.

If a custom ops->critical exists, then it takes preference over
critical-actions.

Tested on a i.MX8MM board with the following devicetree changes:

	thermal-zones {
		cpu-thermal {
			critical-action = "reboot";
		};
	};

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v10:
- None

 drivers/thermal/thermal_of.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1e0655b63259..4d6c22e0ed85 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -475,6 +475,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	struct thermal_zone_params tzp = {};
 	struct thermal_zone_device_ops *of_ops;
 	struct device_node *np;
+	const char *action;
 	int delay, pdelay;
 	int ntrips, mask;
 	int ret;
@@ -511,6 +512,11 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	mask = GENMASK_ULL((ntrips) - 1, 0);
 
+	ret = of_property_read_string(np, "critical-action", &action);
+	if (!ret)
+		if (!of_ops->critical && !strcasecmp(action, "reboot"))
+			of_ops->critical = thermal_zone_device_critical_reboot;
+
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
 						     mask, data, of_ops, &tzp,
 						     pdelay, delay);
-- 
2.34.1

