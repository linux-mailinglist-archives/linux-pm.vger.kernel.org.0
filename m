Return-Path: <linux-pm+bounces-41632-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J5nIZQ2eml+4gEAu9opvQ
	(envelope-from <linux-pm+bounces-41632-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:17:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3AFA5625
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D6F630B33F0
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72E32C306;
	Wed, 28 Jan 2026 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1a+HWFu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B573161BF
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616665; cv=none; b=ZyvhKc79nGWltP+DwIk+AyJtCq53zw4ujSkznBrSyZom1MSUE3w3ohS/UKWothQkjSJAVRITTRPwyeln6sV5olpwlPupbzYCbLq5fGZFzw4yn8O3HXPi63meJ9T88HfNosqZ9itdAbq+uis08Iqo9MFJaO4KIwdUwbGDcJTnTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616665; c=relaxed/simple;
	bh=JnjfvK+MHgibmXdj8c8QyUL8Q5i+pDFvx54OCA4Mehc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5MLTp+Sp4JB2bQ7eBwNcVMtozXJ/u78UVClfMNGUHNpym2RFZyiJbiIBhEt5At+k7XpziyQa5cdZpS4OGWG0OX5F9wV9dQg+lXAWmo0QLy45Hk8KITc0FRw+mKf0f2ObqbXRQ/YJd3bHyplQVvSHpMTFf4rSgojC8uJg/LVGIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M1a+HWFu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8715a4d9fdso2720866b.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 08:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769616658; x=1770221458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kov2pn4auGP7KnNGCEIBpS1LmUNVpZnSgM4Kim/Xeow=;
        b=M1a+HWFu6T15gKjZ0K74uqkZreQ+DrsmvCWoA/WiSiJ67d5lxxS68++U8Y87bc0Reo
         /j2HMN4IEqnEzIcitkAwT/TDHqq34PqB0RRrAV4E5sb5UXLno70/DbsKlnDpe6TWiatV
         fulSoIZceU3LaWGnhk+uX7nwvlC/lCKr5bC36O1+7kg78ZkhXeNSMTG5nEvAimTRpMH7
         +dGsT0qHqopLXizz+DUcZBLPvuGXxHSwEUfIzLL6amtbjxkgJgQVXRtO47pxJlhMv/KE
         abK9pj7RTXzzyspIAjSjfuFGVLtojLQSGeQZYWoc7hd+NXLBduB5kmxi26e2XpnOh/jg
         ik+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616658; x=1770221458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kov2pn4auGP7KnNGCEIBpS1LmUNVpZnSgM4Kim/Xeow=;
        b=FT4BSIaAx5uDBU4nEOpTMqOOf6er+dYWM+uTNsIfoO06vK+Z5NAIMVIyt7/OxylScO
         Lh/ZyAeObVDRzlMtD69tgXkxQMvkbtZHVIXZ3S18Z+Vua5saTjmqKU4ryYq7lWLI2dV8
         XIhWf5EcD0/GntT70vKhXFaz22at6xL6lmCCdS+vY7GKaN1MXasQdDYobEwy21GWQBDD
         wZ8CHkdzMciBiKDo60RswsD0/PVVSWOS6xJ0cQWIjiQGqqTLbgmy7ShccMRxYcrJhzZk
         lhOjBmqed3fUE0FzLywVvP+H8z4wqKpfre4j0b/RK5bhNJP4qCMiq3bWgIGvkLEI5TIv
         G6HA==
X-Forwarded-Encrypted: i=1; AJvYcCU+u/cmlXBPOxyu3OdY4mHSV50H0ZhNrcJZv8aGo6MghZcwDuiRH6Q6MseKz7BGqDJVSPgd5SlVFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6Phv/pHfUBYDlUFIiAYGOI2/L0qWFvg9m9+7FGwlP5UnWV2z
	FNsLmhcqvBuzxfcTnoQNPiNjFWgCmPlQz0WBNuOpWnViAE2fJDoIB6et2pxllXolsRA=
X-Gm-Gg: AZuq6aIwbpYdYzs9grtwfT4nIMcgva0XCLNh1yvga4BtXiV9oqUSHgf/h7IzYb6/TLb
	TO73jgzI9igGGFqbEHALhltca0uPOgRXJUXVMaoXVeDuLqIMgs7sAUr+kizwh+p5NbdhPkN1YQB
	nIJLNTfEdVom8K56+rBUw5XS67loos2SiiV1cPEY2CNyBPtDLB8EDfD4KAYezOh0hOO0EgDTJHR
	/HSHJ6OXTWZGyR5B5dLiySit+CHP5Znz+KdMAPTxBDm9CbWPA13N4sPv0ATxM6s298Pc6fWIUe9
	RM6fWVvAO1RXoZVYW4f2aZHlQrQoYZaXE+8FbbMh6SNT129153/HDrV0iMEMLOSA8upljVPqZ0Z
	c6SYFQcs9MSjaZiSzEhUCVL7x8LnBiP81xLELXHq69b0IE4E2Jo6daJkJWzjspnXAZVprxgY/5t
	rw3xMqK6D5XB425z2XUVBYM9MxYJt2STVkLVs5I42t7zGQU3hqAWdfu44yH5icvZNBUiEMiBPik
	DzauQ==
X-Received: by 2002:a17:907:94c4:b0:b87:2780:1b29 with SMTP id a640c23a62f3a-b8dab32edfdmr423420166b.37.1769616658444;
        Wed, 28 Jan 2026 08:10:58 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c021fsm148553366b.49.2026.01.28.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:10:58 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 28 Jan 2026 16:10:59 +0000
Subject: [PATCH v4 10/10] pmdomain: samsung: implement domain-supply
 regulator
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-gs101-pd-v4-10-cbe7bd5a4060@linaro.org>
References: <20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org>
In-Reply-To: <20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41632-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B3AFA5625
X-Rspamd-Action: no action

Some power domains on Exynos are fed by a regulator rail and therefore
regulator control needs be implemented for Exynos power domains.

On Google gs101, HSI0 (USB) is one example of such a power domain.

While at it, add a to_exynos_pd() to avoid direct use of
container_of() in various additional places, and update existing code
to use it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 53 +++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index f59986b56213dfcc470d9cccc61a36a81954bdcc..ed7a5807555bcf86e4ec88166bfd5f6c06c9322c 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -20,12 +20,15 @@
 #include <linux/of_address.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #define EXYNOS_SMC_CMD_PREPARE_PD_ONOFF		0x82000410
 #define EXYNOS_GET_IN_PD_DOWN			0
 #define EXYNOS_WAKEUP_PD_DOWN			1
 #define EXYNOS_RUNTIME_PM_TZPC_GROUP		2
 
+#define to_exynos_pd(gpd) container_of_const(gpd, struct exynos_pm_domain, pd)
+
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
 	u32 local_pwr_cfg;
@@ -39,6 +42,7 @@ struct exynos_pm_domain_config {
 struct exynos_pm_domain {
 	struct regmap *regmap;
 	struct device *dev;
+	struct regulator *supply;
 	struct generic_pm_domain pd;
 	const struct exynos_pm_domain_config *cfg;
 	u32 configuration_reg;
@@ -64,12 +68,10 @@ static int exynos_pd_access_controller_power(struct exynos_pm_domain *pd,
 
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
-	struct exynos_pm_domain *pd;
+	struct exynos_pm_domain *pd = to_exynos_pd(domain);
 	u32 timeout, pwr;
 	int err;
 
-	pd = container_of(domain, struct exynos_pm_domain, pd);
-
 	if (!power_on) {
 		err = exynos_pd_access_controller_power(pd, power_on);
 		if (err) {
@@ -126,14 +128,45 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	return err;
 }
 
+static int exynos_pd_regulator_enable(struct regulator *supply)
+{
+	return supply ? regulator_enable(supply) : 0;
+}
+
+static int exynos_pd_regulator_disable(struct regulator *supply)
+{
+	return supply ? regulator_disable(supply) : 0;
+}
+
 static int exynos_pd_power_on(struct generic_pm_domain *domain)
 {
-	return exynos_pd_power(domain, true);
+	struct exynos_pm_domain *pd = to_exynos_pd(domain);
+	int ret;
+
+	ret = exynos_pd_regulator_enable(pd->supply);
+	if (ret)
+		return ret;
+
+	ret = exynos_pd_power(domain, true);
+	if (ret)
+		exynos_pd_regulator_disable(pd->supply);
+
+	return ret;
 }
 
 static int exynos_pd_power_off(struct generic_pm_domain *domain)
 {
-	return exynos_pd_power(domain, false);
+	struct exynos_pm_domain *pd = to_exynos_pd(domain);
+	int ret;
+
+	ret = exynos_pd_power(domain, false);
+	if (ret)
+		return ret;
+
+	/* Ignore regulator errors - the domain was disabled after all. */
+	exynos_pd_regulator_disable(pd->supply);
+
+	return 0;
 }
 
 static const struct exynos_pm_domain_config exynos4210_cfg = {
@@ -283,6 +316,16 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* get the domain power supply if required */
+	pd->supply = devm_regulator_get_optional(dev, "domain");
+	if (IS_ERR(pd->supply)) {
+		if (PTR_ERR(pd->supply) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(pd->supply),
+					     "failed to get domain supply");
+
+		pd->supply = NULL;
+	}
+
 	/*
 	 * Some Samsung platforms with bootloaders turning on the splash-screen
 	 * and handing it over to the kernel, requires the power-domains to be

-- 
2.52.0.457.g6b5491de43-goog


