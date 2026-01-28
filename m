Return-Path: <linux-pm+bounces-41631-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIFFBKM9emlB4wEAu9opvQ
	(envelope-from <linux-pm+bounces-41631-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:47:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B6A61CF
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81B9E31E8DCB
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FB323416;
	Wed, 28 Jan 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i36qBX9Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCD314A78
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616664; cv=none; b=EOTVR8qhEQE0JPDn4HWX9R/eDtRTgVrjrSxD8yGejNB/7FYb7vtm44qpl0l2TdhaShHkRcDCzY3HcDEBTv30l3e28LYVUNgHnLyiLPpl61DjcXBgYubaKwgNslSv9+eghdTPqhd2sQDyQDSvcBdmo+8OlSPfXxAqx6D3l2m77Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616664; c=relaxed/simple;
	bh=t2PVoqEhqZMJZC67I3W1iuIM3JwoW/UJ4k6IbMPc6/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GB9eIPkCQhCBDAN6KECLgkDqVfOi5Ul+qUvtfIGqpIwaf1qCX6o5p2vrv74feHLrV6RYVdyahz79RAjmHV2M5lN64qwHd1qQ86C0boZUp6mlKgm4T71vFYLjrD50hrRCR8f0tU2xaIWrFrwJ2Csa7Tdk2wUni3TMt/K1o55E9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i36qBX9Z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8871718b00so870850166b.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769616658; x=1770221458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLy2uL/FtYE0GEpGfFAeMw9BLXBDMwcv0NDa1wsnuec=;
        b=i36qBX9ZCm4UYSDy3nAO1ZgaU8uTJhDvrQxW5TpHFRsK9BuzqjTx/sgAdym/2GmPrO
         VzigOhwMLa6AOQWvdBFA3sYCv9PYjOxgtmYF5ngPiyDRkbrmKQRQ24rUCrDr/67aqdfE
         E8GE9JSNLvJ6NNdAfvZPV3kys8pawHvTkBT+c+4y8zRPYuqwAQVFYFPhLoLUynkMtdR8
         pBONNAssteMPC/7tSHN3qxfNw1fvifxo7Jooj0JouXgLQkVDogccWZvJAslFbkIUnxAi
         uNa345TczAeNMn3zDYKYw3sDRIo4Jo2D+01wQZ2iD50zH/VAs9s3WVfaaG/KQoDUBSwl
         1DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616658; x=1770221458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mLy2uL/FtYE0GEpGfFAeMw9BLXBDMwcv0NDa1wsnuec=;
        b=J0dTJ1CRBz001kSMtJkFK1JyigyTIKBeV+YTxTQcA+RMNY9fvbVcJXfRbaU7or4Ohh
         jrnAlJek7PHBmdYvQ10Yrqo+Pe28ntIrMEpRz9OaEYkpJ1gdn01RxZtoticj/b4AE2Xm
         DffJ+YPDWAlxFA46JiHp6VbT1Jhh6pQ7y2ntxbdQIIt5C2HIMy/hrcIJ7Lra7uQReft1
         svgJrGcbwCIJRcxx+U1FNVeBBVHO/BzOQAqJR8KIKhJTuAqU82mhdCUSsVWnfnHxEup8
         3ytsKkm6a4ZIi2C47AbDAwFoU4+6HakpN4TU8yvZTgan/gDVzegNkKHfxIuflmaVkFHN
         W8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7wJXlV41D77Fgj9oU9UqJ3b6nlXbRavrDhdtiwKBRVmCpJARrZbHdLWg8x2mmjdb2cR2sYHCKpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YykGfpNvNK1rH1FX8e109l/v8+DIQOoJrEESNrG1SMafY08QowN
	6oqnO894oVQfX4IRHWXvfiapUAwjMuP8UGEXDIipvI88A9Fxu56rqgj/tyxGuj+2lkU=
X-Gm-Gg: AZuq6aIevz88Ra5qpCPUSgHKi2WbabFtxoC9TWvl6of98cEJtZZULUYX4qV8Q6XZCsN
	94ccMdNCRwnuIfMtu3eRaye9vXfEnPzl4Pk8b5/IEURuWuX4uFs0ku4JfBVgbn/Brc3u41UWewU
	NWuee3Jq7du10h1hhaAj+2KE2nv1MsgH/If1Ok7myMdxGoak7fVc1VUNzNfOiiz04E3+lU5eGGt
	46484MNs6IyHl19j8LvJ6pRrlPhggi+cvk8Kdqq0FYNqDA29O7u+7hAAglEg55XhqCMrdAtf2NC
	/o8YvWMz07ztjPJEzxSekzdSJxWRSDYIXsbI5zm+9xJBFczPTuT1hIuZo21u6jc9V3IBK9pvWQ+
	iljJ/gdGW7G7BDy6bnXBFD0LEVOFrGZL2MgokwjIEGiTUSiyDJJUwHYZH+iNfz67PGGlhxkn347
	ZeTRt3ghwlw5lXSAlsQMNU+iXQyIFDzy7OJiVOPRIDoN4M/pV0lE6hAPr+hUuyVi8wMShOMcaAE
	1bcHg==
X-Received: by 2002:a17:907:d88:b0:b88:587f:f594 with SMTP id a640c23a62f3a-b8dab1b526bmr445917666b.18.1769616657919;
        Wed, 28 Jan 2026 08:10:57 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c021fsm148553366b.49.2026.01.28.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:10:57 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 28 Jan 2026 16:10:58 +0000
Subject: [PATCH v4 09/10] pmdomain: samsung: implement SMC to save /
 restore TZ config
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-gs101-pd-v4-9-cbe7bd5a4060@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41631-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: 417B6A61CF
X-Rspamd-Action: no action

Newer Exynos platforms have a Distributed Trust Zone Protection Control
(DTZPC) linked to each power domain. It controls the access permissions
to various registers from secure and non-secure world. An SMC call is
required to instruct the firmware that the power domain is about to be
turned off and again once it was turned on. This allows the firmware to
save and restore the DTZPC configuration. Without, register access to
various registers becomes impossible from Linux (causing SError), as
the PoR configuration doesn't allow access.

Neither the requirement for the SMC call, nor its arguments appear to
be specific to gs101, as at least Exynos E850 also uses the same as can
be seen in [1], hence prefix the new macros simply with EXYNOS_.

At least on gs101, this SMC call isn't implemented for all power
domains (e.g. it's missing for HSI2 (UFS)), therefore we issue a test
SMC to store the configuration during probe, and if it fails we mark a
domain as always-on to avoid the SErrors and to avoid unnecessarily
retrying for each domain on/off.

Link: https://lore.kernel.org/all/20230308233822.31180-4-semen.protsenko@linaro.org/ [1]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 96 ++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 41a232b3cdaf0f4be413b25d9373b99c6a3db602..f59986b56213dfcc470d9cccc61a36a81954bdcc 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -9,6 +9,7 @@
 // conjunction with runtime-pm. Support for both device-tree and non-device-tree
 // based power domain support is included.
 
+#include <linux/arm-smccc.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -16,12 +17,19 @@
 #include <linux/pm_domain.h>
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
+#define EXYNOS_SMC_CMD_PREPARE_PD_ONOFF		0x82000410
+#define EXYNOS_GET_IN_PD_DOWN			0
+#define EXYNOS_WAKEUP_PD_DOWN			1
+#define EXYNOS_RUNTIME_PM_TZPC_GROUP		2
+
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
 	u32 local_pwr_cfg;
+	u32 smc_offset;
 	bool use_parent_regmap;
 };
 
@@ -32,11 +40,28 @@ struct exynos_pm_domain {
 	struct regmap *regmap;
 	struct device *dev;
 	struct generic_pm_domain pd;
-	u32 local_pwr_cfg;
+	const struct exynos_pm_domain_config *cfg;
 	u32 configuration_reg;
 	u32 status_reg;
+	phys_addr_t ac_pa;
 };
 
+static int exynos_pd_access_controller_power(struct exynos_pm_domain *pd,
+					     bool power_on)
+{
+	struct arm_smccc_res res;
+
+	if (!pd->ac_pa || !pd->cfg->smc_offset)
+		return 0;
+
+	arm_smccc_smc(EXYNOS_SMC_CMD_PREPARE_PD_ONOFF,
+		      power_on ? EXYNOS_WAKEUP_PD_DOWN : EXYNOS_GET_IN_PD_DOWN,
+		      pd->ac_pa + pd->cfg->smc_offset,
+		      EXYNOS_RUNTIME_PM_TZPC_GROUP, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct exynos_pm_domain *pd;
@@ -45,7 +70,17 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 
-	pwr = power_on ? pd->local_pwr_cfg : 0;
+	if (!power_on) {
+		err = exynos_pd_access_controller_power(pd, power_on);
+		if (err) {
+			dev_err(pd->dev,
+				"SMC for power domain %s %sable failed: %d\n",
+				domain->name, power_on ? "en" : "dis", err);
+			return err;
+		}
+	}
+
+	pwr = power_on ? pd->cfg->local_pwr_cfg : 0;
 	err = regmap_write(pd->regmap, pd->configuration_reg, pwr);
 	if (err) {
 		dev_err(pd->dev,
@@ -60,7 +95,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		unsigned int val;
 
 		err = regmap_read(pd->regmap, pd->status_reg, &val);
-		if (err || ((val & pd->local_pwr_cfg) != pwr)) {
+		if (err || ((val & pd->cfg->local_pwr_cfg) != pwr)) {
 			cpu_relax();
 			usleep_range(80, 100);
 			continue;
@@ -72,9 +107,21 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	if (!timeout && !err)
 		/* Only return timeout if no other error also occurred. */
 		err = -ETIMEDOUT;
-	if (err)
+	if (err) {
 		dev_err(pd->dev, "Power domain %s %sable failed: %d\n",
 			domain->name, power_on ? "en" : "dis", err);
+		return err;
+	}
+
+	if (power_on) {
+		err = exynos_pd_access_controller_power(pd, power_on);
+		if (err) {
+			dev_err(pd->dev,
+				"SMC for power domain %s %sable failed: %d\n",
+				domain->name, power_on ? "en" : "dis", err);
+			return err;
+		}
+	}
 
 	return err;
 }
@@ -99,6 +146,7 @@ static const struct exynos_pm_domain_config exynos5433_cfg = {
 
 static const struct exynos_pm_domain_config gs101_cfg = {
 	.local_pwr_cfg		= BIT(0),
+	.smc_offset		= 0x0204,
 	.use_parent_regmap	= true,
 };
 
@@ -126,6 +174,38 @@ static const char *exynos_get_domain_name(struct device *dev,
 	return devm_kstrdup_const(dev, name, GFP_KERNEL);
 }
 
+static int exynos_pd_get_access_controller(struct exynos_pm_domain *pd)
+{
+	struct device_node *ac_np;
+	struct resource ac_res;
+	int ret;
+
+	ac_np = of_parse_phandle(pd->dev->of_node, "samsung,dtzpc", 0);
+	if (!ac_np)
+		return 0;
+
+	ret = of_address_to_resource(ac_np, 0, &ac_res);
+	of_node_put(ac_np);
+	if (ret)
+		return dev_err_probe(pd->dev, ret,
+				     "failed to get access controller\n");
+
+	pd->ac_pa = ac_res.start;
+
+	/*
+	 * For some domains, TZ save/restore might not be implemented. If that
+	 * is the case, simply mark it as always on, as otherwise a power cycle
+	 * will lead to lost TZ configuration, making it impossible to access
+	 * registers from Linux afterwards.
+	 */
+	if (exynos_pd_access_controller_power(pd, false) == -ENOENT) {
+		pd->ac_pa = 0;
+		pd->pd.flags |= GENPD_FLAG_ALWAYS_ON;
+	}
+
+	return 0;
+}
+
 static int exynos_pd_probe(struct platform_device *pdev)
 {
 	const struct exynos_pm_domain_config *pm_domain_cfg;
@@ -195,10 +275,14 @@ static int exynos_pd_probe(struct platform_device *pdev)
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
-	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
+	pd->cfg = pm_domain_cfg;
 	pd->configuration_reg += 0;
 	pd->status_reg += 4;
 
+	ret = exynos_pd_get_access_controller(pd);
+	if (ret)
+		return ret;
+
 	/*
 	 * Some Samsung platforms with bootloaders turning on the splash-screen
 	 * and handing it over to the kernel, requires the power-domains to be
@@ -212,7 +296,7 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to read status");
 
-	on = val & pd->local_pwr_cfg;
+	on = val & pd->cfg->local_pwr_cfg;
 
 	pm_genpd_init(&pd->pd, NULL, !on);
 	ret = of_genpd_add_provider_simple(np, &pd->pd);

-- 
2.52.0.457.g6b5491de43-goog


