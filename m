Return-Path: <linux-pm+bounces-42184-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCltJRQPhWms7wMAu9opvQ
	(envelope-from <linux-pm+bounces-42184-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:43:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9FCF7C79
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4ACB530095CF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD64D33509F;
	Thu,  5 Feb 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xs7mYAxe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FF337BBA
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327765; cv=none; b=PeUGXnRTDOY+PxMZONv4O/kSceHKJTJ98TA8ic5v7PNAIuGB+qzLLzYLD2ZvKenNVRcKqL0iGDOx0OODhwVQHzvG5oBelfOYG4OrSU7lyxSy+XrUnc4cwAK3ASLlz4oRzp4Qi8LdzKtatEpSWM+8tXD0Q//uGXEMJdUVulHG6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327765; c=relaxed/simple;
	bh=u4sg0GJwh6e+BEq1gu8SNmu5JD78FxHznumDbt705qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCDOFnwPjIx4demrDZfeRO9on4TXpW60iVhNLVbbJbLCfAvFmLxa6t/C2jtxyThZVs73LnNcf3DxViFNbFSWB0PFSxjKuw6Q4rllxAO/5q06ayQoyG2dc75pX2qnF63Cr8m/36asANP6S/2cjaIyeelaBf6xMUqD1OYZGA6AmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xs7mYAxe; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so185082466b.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770327760; x=1770932560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khuzBcy7Hz6jo0S9i03alRelHLigzIL+h0sUh48v3Z4=;
        b=xs7mYAxerbmg5OfOg6zqJEFq+eQGrBgS0dwnvnxoxt+TUkZrGA9dak4soSHA9/YvF6
         wJo6PXQD6gK0MWcdkwBauNEAoUczScw9yXy3UCYRKppnVZoP4jr+JDUCBntMEhUg3SWM
         Qg/0BOH2ghJyS1mpKxNK52rQmk1iq6Uz8zj39T2f0rrE9v5gBTBQ5LgKGwmY0K/CbE/o
         JS8CFHWEZqDHkT70uAt9T6+FM3qE4U1u7XOdHsxjGXsYZ7P7JUxARPOZ91RpAaukxGeW
         OcI7IdTTGuHMDosWF5++KOfeitJtrI5d2TX31NlJkJgonjd2xsyZk1BSoXmnDqpIge/e
         tPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770327760; x=1770932560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=khuzBcy7Hz6jo0S9i03alRelHLigzIL+h0sUh48v3Z4=;
        b=PKzynYpXqIvQ+r5HqVM3gbUm/5He/4zXBKi7VqICwiX3/XMrZ7rdaVOlKj/e6SWu/f
         mBhY4bFdSkXUASxgZMT+rNJHxY9evA5bbuccT+eDhhjd/b/b+daw/UyguS3gjZq+Q6L+
         Lsb5HTUeuf5qCrfQqgsT5ehFH5W7MMgLLGHSu9Jeu6qv30aMzHCYZbF2fMZxp3EO4jKD
         VKkXScqkEhr57WIc9t9idkgUo/Ce3tDQ2zfl9ak4Jmp2GQjChlYKZQA+XlsUkweTqInO
         7cG8a05DN8P/oyCs1q/cDFgDIORDgzgdWEVnmW+/v+mOAcYKT0fJrPRGY7UyRuxpCsLL
         5unw==
X-Forwarded-Encrypted: i=1; AJvYcCU5zRNIq0lclypcxXiNsZP4C+uaOPsCFryFKQWwnJ3PlrT9RetcCS5pS/HvE2HDa+26D35GJkSfSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWILJQePXW8AyWkzv70xZYBixjDjltgZLwXO1pytzMZpFjoQfw
	yamUoeCSr/rUdxMqirLVNAT0V6r0mkILan7G+tmPCJnKfvJ1h/Y+91O4bZUSJO/WzV0=
X-Gm-Gg: AZuq6aKXYwS18NRa/KgLIF++N9dS6SCtt9f84ACvYxC08BE9Ws5BJgugOruKTHBpvdR
	llk/hRFi7+BR6JBnsUaefNjAjgDI/8ryugntYB3mVKHKmnzLtnvDgLk9D358vAII9UBXlcGU0Mi
	y2Uu4XgLwkw17a6SJOz9rimaKSulrgnVFrIAAnY2VaORuHUFJN/IV57OTOE/VtVFt5BNd2Vctsy
	lIh06REZ5IkYQ1vkrwvTRSfOpKzKqRQ8r9oEhWb+pOMb7/4WFbAUGRcuYYvlFWJCoVVX+bz0Dfj
	3eSFhnRAP7fYz5OG/07HYrmOyAgyUNmZs+EzklSCbeOHdM8/vBM1Mvh/rdFJ77Z9FNybjy7kpL4
	Qy26xFONN+PsKw8KpHS5YV3hf4RUrgs8nOnre+TLgA13ouo7ZGCtO3EU+gWfmgUt27fc5rAeBJ7
	zxGMk/bk9TOlu2+uzdRkXsBf+RiTM3qJDE3q6Y/CmWqe5rwxCr1wOpaC1usipClESS0hswVQe/g
	6lWkg==
X-Received: by 2002:a17:907:9810:b0:b87:39d:2bb4 with SMTP id a640c23a62f3a-b8edf45a619mr26687766b.59.1770327759827;
        Thu, 05 Feb 2026 13:42:39 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7a0074sm21859966b.18.2026.02.05.13.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:42:39 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Feb 2026 21:42:38 +0000
Subject: [PATCH v5 10/10] pmdomain: samsung: implement domain-supply
 regulator
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260205-gs101-pd-v5-10-ede49cdb57a6@linaro.org>
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
In-Reply-To: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42184-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB9FCF7C79
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
2.53.0.rc2.204.g2597b5adb4-goog


