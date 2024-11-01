Return-Path: <linux-pm+bounces-16881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52549B9484
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142651C21CF9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3B1C876F;
	Fri,  1 Nov 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GlavWRV8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9BA25634
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475410; cv=none; b=EZrifGCEanQFcCG8PukoUsKIB+Se3ljkzADJlxhR6YXr8dMtizyqBueBGtGbWoy56XpUnhMA+Q+rsuQTgB/WPNEXuQg81gSE69odKl+yAHGCtkRCoNym+A2jrXeWLXp+vhA29VvcdBpnJgKcDaPZ/Hv9XMpAx2wVAy3l/9dBnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475410; c=relaxed/simple;
	bh=Ewuo8tkZRIPnXmWm+AAeqen1P+AccwVWLIprM0pWxB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elCDhWJm8E3QWn/irzA9jz3JZ0o52cx+rI+i2px9akM4sMD5HxN0HmygDu76Z0z1roDi/DRcPSOaycVaF5uyesG83jLFXDZmgVs5eGSevSyBNCFbQ3jZXZ75zwiRtvtyXMEkiukEheuVekLtheKQt8oEolh6Pz7wzofrItCvLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GlavWRV8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb47387ceso21688335ad.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730475406; x=1731080206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3idRexV6BiHXZ5h21OJlIktjbdShqDapELZrhtrPoA=;
        b=GlavWRV8rj5M4yaCSuCrWwPaud8GoNysP1nIGG+1r/0TMjkG448geV46cT068HyWKi
         VXr3AyvpY+W6AuN7fvgLxi2Cmx5AYDQD/qglirSNikCqJoZs98zQGY8TnDy051qCMYPS
         PdsbOSBWWsTM+1b6IhTSuvDkI33R5dvHXG3WjmQGTZ03XF6nq13PsF2M6/u2zbR3zuaE
         xIlhqJqSdGzSmCkMbNpLMdqAnx54zui/FvsLVvgiLESF6YN8oGOl03pB77tYgznATQAP
         mRnsavRWWCViyJk2YwitAo73N24aAD7Wb20K8W8WBz0Y+a0sBNDhOM++akFQlETJewpT
         nesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730475406; x=1731080206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3idRexV6BiHXZ5h21OJlIktjbdShqDapELZrhtrPoA=;
        b=Nynnv+AMXmBZXIjLAran+lgkJnHeUBPykGExv3TesSF0mZCoBl26t7App9kvTjFSP7
         i90oMiTjJ8ZtFM4gni1qmlWoUr+OSz9nbMLD9BE71uUZD1LlGWdjLYiXQyswQRFXkuFu
         mx85zf4BRFUY48C8ZZ0ePzTjn3/x66xS6fEl8c0kbvJ6klAMt1L0EI9C3+z3d1RZSapt
         kzyB47/ij7yIYTo9MYmfjxNJjjC1ii8dl7Nmao3x0hJAoODKsyJB/CAHFsuHxa8awo1E
         tOgLP1MSj7Kn+Dda6T49tn6mW9GmjNELxb7BDbenmt6aD9TjgJM5M3QyACEoXamGuwxI
         CYfA==
X-Forwarded-Encrypted: i=1; AJvYcCVusjzrKYCVmp1SER02wQydRPSBF16GbXFOF18A+fvWmsf2xclAqweLxA0Eou+SrNrw43nW/w94Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJsJxsUk+Ve80ycp4FiYBbzB7wxBRQCKbDfVObYKXbxYKNU1B
	g/31sSh2pU0zi0cK8IZ02pH0t6ncjZIl9j4eh8XiMivGmxzuG48g6ubAQeFK3RhSBfrL9S62Afp
	Uij+NcQ==
X-Google-Smtp-Source: AGHT+IGY/08HilcbZmR1lKyyTr906chNTawpACDKuD2s3QhEtikW9I1wYr4l+lhIq37jX+2CszHKmg==
X-Received: by 2002:a17:903:11cd:b0:20c:f0dd:c408 with SMTP id d9443c01a7336-210c6897f24mr302882505ad.20.1730475406525;
        Fri, 01 Nov 2024 08:36:46 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c1189sm22803555ad.204.2024.11.01.08.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 08:36:46 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 01 Nov 2024 08:36:20 -0700
Subject: [PATCH v5 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-lpm-v6-10-constraints-pmdomain-v5-1-3011aa04622f@baylibre.com>
References: <20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com>
In-Reply-To: <20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-cb14d
X-Developer-Signature: v=1; a=openpgp-sha256; l=3966; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=Ewuo8tkZRIPnXmWm+AAeqen1P+AccwVWLIprM0pWxB8=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBnJPWMo1qK7rflgRga9T/TyTsA7X95SDxo2qEx3
 XJ5U8aE5veJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZyT1jAAKCRBZNxia0/vG
 ZfTJD/97EoOKKx2D/jgBRXrjpmjWbT2pCWYpAORn4EPRLgpHjzYeqnJbXXTDyPv5LwBDVQ0svyY
 /1R8Me7OjWOmjdHWyfAwOJZLVGQq22/B7pSfLJbjfaLQ7HvkxtB0qbcWFS/hjbI9osjSS1sTK7o
 2h8Enq+TNtzgqAX+7Q/zp57hCn2KwXNNDpgFQBSk7K3KpupCgNwUlM2faqLGPwlqEyTMUErWBCv
 DETk1E/RGFQEOX04q1mt6Etjuh/dxDzNzZYShU0X2Icn3isEtAnaYgE9c1l4Qr/qfGXRZjAI+FV
 AUQKl2BXfW3ylqH2ycOub+jmie1yf5OxygCWbKwt9B0s6in0moZgaBLnbVwWxUbvgYeDTanCSqx
 dHriZzlHlFVtIYee8KblIl/0fh4qCpzjfNT7L+Igm6U4TjWuSZZRfclIa/YNM3ejzXjaasVMj4B
 gVC+UNOXUDqO1REpYRN2hFjm4clV+wogBxM4awCvXbXjUBz6IK+OipP7DP9i1JOWiCUQWZSuMRP
 Jqarclr/xN1uUXq1l1ilzgQkEoPBP93K4xgjXyXvisyEG4Ql3N2LFKE1w6CaQHvsXxCndK6B4ra
 NENxt2+KIm9MxpPT+fgTjqZwNNihsyCd6aCUX2fb4c1/q0Od3gw+YZPtbbY2Y3rteNa+RYLHPGd
 wEsoQj61WEHQpGA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

For each device in a TI SCI PM domain, check whether the device has
any resume latency constraints set via per-device PM QoS.  If
constraints are set, send them to DM via the new SCI constraints API.

Checking for constraints happen for each device before system-wide
suspend (via ->suspend() hook.)

An important detail here is that the PM domain driver inserts itself
into the path of both the ->suspend() and ->resume() hook path
of *all* devices in the PM domain.  This allows generic PM domain code
to handle the constraint management and communication with TI SCI.

Further, this allows device drivers to use existing PM QoS APIs to
add/update constraints.

DM firmware clears constraints during its resume, so Linux has
to check/update/send constraints each time system suspends.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3decd5b70f835338ed4e0b2a3c9373..c976a382d64c807daea72fa1ea9d6c11c8773762 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -13,6 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
+#include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
@@ -51,6 +53,27 @@ struct ti_sci_pm_domain {
 
 #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
 
+static inline bool ti_sci_pd_is_valid_constraint(s32 val)
+{
+	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+
+static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
+	if (ret)
+		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
+			ret);
+	else
+		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
+			pd->idx, val);
+}
+
 /*
  * ti_sci_pd_power_off(): genpd power down hook
  * @domain: pointer to the powerdomain to power off
@@ -79,6 +102,26 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
 		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int ti_sci_pd_suspend(struct device *dev)
+{
+	int ret;
+	s32 val;
+
+	ret = pm_generic_suspend(dev);
+	if (ret)
+		return ret;
+
+	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
+	if (ti_sci_pd_is_valid_constraint(val))
+		ti_sci_pd_set_lat_constraint(dev, val);
+
+	return 0;
+}
+#else
+#define ti_sci_pd_suspend		NULL
+#endif
+
 /*
  * ti_sci_pd_xlate(): translation service for TI SCI genpds
  * @genpdspec: DT identification data for the genpd
@@ -188,6 +231,13 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pd->pd.power_on = ti_sci_pd_power_on;
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
+				/*
+				 * If SCI constraint functions are present, then firmware
+				 * supports the constraints API.
+				 */
+				if (pd_provider->ti_sci->ops.pm_ops.set_device_constraint &&
+				    pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
+					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
 
 				pm_genpd_init(&pd->pd, NULL, true);
 

-- 
2.46.2


