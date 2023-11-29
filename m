Return-Path: <linux-pm+bounces-472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB707FD70B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5467A283008
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F51C68D;
	Wed, 29 Nov 2023 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCL3w5H6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B1410C3;
	Wed, 29 Nov 2023 04:44:07 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35b0b36716fso6459295ab.0;
        Wed, 29 Nov 2023 04:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701261846; x=1701866646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elZXM+Abii+KZRVpe/jUXO4xHCec/DFLJnfi96Bh/bI=;
        b=VCL3w5H6AhOOuoK8J0LlVReAQHQ6ujrGRHx97oSizgqfSuYzFSwUfRMB4iBgxiKtIW
         WIDOoEWLd3H0vqmVah2zHF5FirThu1SNY1o56x/aft4nW9KwXkwza3gU7BxjD92c2HaJ
         qlm1bFV3NBnNFVTjFJyYnBaABrv/nUxovDIqkFxOQ5wNkHRzhVeI0xMg2jvM1z0HKzNE
         +YgLN1+ktXSWZKi8YXJZ4dM1t9jNhr9XjuWPOMy2HcAeMtili4dH/12wKghQF48FwEZ3
         PWQh8ylcbztF7n1JSq1b8nl6Jr1RdQflaC4eZcmYXSuRAKx75CHgPH22JpczE/Yb58/+
         aOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261846; x=1701866646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elZXM+Abii+KZRVpe/jUXO4xHCec/DFLJnfi96Bh/bI=;
        b=l4MY20o5jMdXYaKLPLsL6pCLIyFZafDmn7S7yUXwD7NwhVEg69r/VTscdaVs2JWTvy
         mr30jjUU2cjuXC4LyIJG4C7BJsddhbKsSEu/4gKhyQToCVwVKN+CMHJjwL/7uVMr5eR6
         oNGQAfnVR2AYUDnqBDHwN/d1RqLq7/oZTc9gShJgOoVXdQ3s66P8ZOtcf46m9elGwRs+
         dZfiWd9rRpDI0o+SW6T3jRPL7Uz3/pQ3AeBTO+so7Mjvb127VgQ3Fc0oJVU7CPcf1W1c
         WQtOegAS3ueWVeBH5qU8rlQzJM9W0nlsOQXlBo0UaZPiOZtZ0Wv0jBKnXoW45AFUABm2
         hS2w==
X-Gm-Message-State: AOJu0YzVCRwY4kOk/a1RTpi6UtilCnhilZjXyOO9MfqeTMURIdArDJpD
	KipNmhsBhiW4Yv05BZ+e1kY=
X-Google-Smtp-Source: AGHT+IEgdZdb28X+dRlRrJtWHp6v/WXK2rCkT0E/McCMcHVjkqEHXEyo1SLHHLPCH3n8MjLRWmhdig==
X-Received: by 2002:a92:ce8c:0:b0:35c:7b32:241f with SMTP id r12-20020a92ce8c000000b0035c7b32241fmr13255152ilo.2.1701261846313;
        Wed, 29 Nov 2023 04:44:06 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5db0:20f8:912:48b])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0068bbd43a6e2sm11028416pfb.10.2023.11.29.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:44:05 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v12 4/4] thermal: thermal_of: Allow rebooting after critical temp
Date: Wed, 29 Nov 2023 09:43:30 -0300
Message-Id: <20231129124330.519423-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129124330.519423-1-festevam@gmail.com>
References: <20231129124330.519423-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Changes since v11:
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


