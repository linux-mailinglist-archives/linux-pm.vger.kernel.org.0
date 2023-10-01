Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7270B7B44FE
	for <lists+linux-pm@lfdr.de>; Sun,  1 Oct 2023 05:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjJADAh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Sep 2023 23:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJADAg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Sep 2023 23:00:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775DCDA;
        Sat, 30 Sep 2023 20:00:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c72e235debso9342365ad.0;
        Sat, 30 Sep 2023 20:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696129231; x=1696734031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47dEmse1a5JMP/Qf4cGHMz4JqlEGe3n1j3cZCwSDWPw=;
        b=PC9x+UTDkQH/kPPQNpOs+zv9NfYp74lxerQKQACjiFdMalzEV6vuYLe1j38QrPJncx
         SHHFCRLddtiDcxIMD1V+9/oeofeSVmE/K3K5yO2wujykqdFPKJbJaGP1GSTmnmg44cjd
         oP9KTlsd04Yflfj6B+Qy4fitb269eI8khCXI2LWONTNG1xFK8duDz+KJkYeR0MKaf9wG
         ol/W5f0zHv1vJATnSyw6+stoMlB+Nqv5rfOC5KPmZICVT7uelTBVJUXM0vBcJ01oqlBo
         O34Y4Uba65Q3abtMR9ZmmmcUUO7yTQxek67f0uehl6YC3M6p4q0uphpiReo+0UjDtZOq
         /tYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696129231; x=1696734031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47dEmse1a5JMP/Qf4cGHMz4JqlEGe3n1j3cZCwSDWPw=;
        b=RjRDBANKvMg97rX2PPtLwxVulAC4KYl7iaKnseUF8lsdGcX0xp2ggFWYm0GxxOt87X
         AIe0QeZ3cJgGJNZiXgyHJ4RhGLr3mtJn7VT7cbTbXnwsoVL0GuydP/rpe9PPdyhdGeyZ
         bTwN0aCNbjuOvQpht47Wq/CRZykBRSf9eJHUItSt6nBsg7QJzckWWcJlW/UKYyaFmYoZ
         RRD0NkHEUiZF8lZtEB84DS6nBCNRDgep90i22b4CtJQ78zyqPR0we/sSfEoHICjrXtPM
         MO3aUna920/AQJHMhNos+J98GYFbfrvVQlhQ99V8TIer55QL4RC3a0fB3yXMJDgiVWpo
         viiQ==
X-Gm-Message-State: AOJu0YwMFwkXIZKGSldWivE+kWMio5rRqWCD/Y5NRQuLZtcuiX1Auw+A
        pZ7uDeGddS08GjWxypKx1vw7dPxXgvs=
X-Google-Smtp-Source: AGHT+IGVyovU5d0ySaMIGltgKTxvHOQy+zCkoECdIDZR4mm6kpi7TxiSnh77OTvWIpfzw1O48wA7cw==
X-Received: by 2002:a17:902:da8d:b0:1c1:fbec:bc3f with SMTP id j13-20020a170902da8d00b001c1fbecbc3fmr9147248plx.5.1696129230855;
        Sat, 30 Sep 2023 20:00:30 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:355a:d2a5:90:39d5])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001b8baa83639sm6801788plb.200.2023.09.30.20.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 20:00:30 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v9 3/3] thermal: thermal_core: Allow rebooting after critical temp
Date:   Sun,  1 Oct 2023 00:00:14 -0300
Message-Id: <20231001030014.1244633-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001030014.1244633-1-festevam@gmail.com>
References: <20231001030014.1244633-1-festevam@gmail.com>
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
Changes since v8:
- Simplify the logic for calling thermal_zone_device_critical_reboot(). (Daniel).

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

