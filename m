Return-Path: <linux-pm+bounces-43649-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YArQKfgeqWmL2QAAu9opvQ
	(envelope-from <linux-pm+bounces-43649-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:13:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F020B3A2
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4FF13039343
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037BE2EC0B0;
	Thu,  5 Mar 2026 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4k2GzsZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F92DCBF4
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691123; cv=none; b=CQ7AUR9QM9qINoppLjF1w9lFEK5ryflFPpo86uKhFqTylBpv1NSbVeeftg+caPaE9WncJXDg4e2wFHHo2j0l8oNhn9CPsGcvWnNzvjhvUSW7kG6tn6ow9XRj8/vVmDtH4t/dqsyNHRvqREUL7L3o7eX+Iw/zMMp2hOXmJzBnRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691123; c=relaxed/simple;
	bh=k+2eK86lvnhd0G39XcYd0Wo9v7NwbPnA00WtqszUSr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG1aVxQ0ck5xJbG9lxvWn0yaon3aAnfhoN/Wf2dPrXoJB/yrhjm92XYfwyIfmDCyIqi416KdWvpt5rFvNUNjaAg9p6Za8gtugrGuQNIwAg3JlSHKgCHne3Z90BKT8SyXha7DrK117pU8ysaWGCD1eC0ZrtBcGm3kYUnKUCAfucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u4k2GzsZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-660a58841d4so3142099a12.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 22:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772691120; x=1773295920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJyveOpQYRN0Rj97xYSp2eMNn5Hi3Nxu7cTlokaFCRE=;
        b=u4k2GzsZuF9Bb9VgAvJB8IHq3AE+Kkvz9CufyLHj2pn6GljqJsfBwxfXil4+sfeCtk
         7xXCTBpAXwA0j8PYuxJvv8+w6IRzqh6RjHZvscpl9DbCJJaUNArLrCvsmpft43NgvxEo
         BNGzKN1hPMBHbad4cQG6WRc33Oko41paYqVZTN6YPl4oJfks1qVPXR5KVZQNYXgzPKQi
         M7AbjJ/BzXeewOTonn/R07cXKKbzj+vdvic6O6EPo+AucEShWTHp3OT0i3bpRevrxY8s
         /cggWdrWXFPTS2Plm6Gd4R4cG3z91Q9P9CQpR7EY43DodDkm6ioYqsTe8Voqy7aDaR7d
         xlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691120; x=1773295920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GJyveOpQYRN0Rj97xYSp2eMNn5Hi3Nxu7cTlokaFCRE=;
        b=wa6VAkDgBWepSW1QAep/BsW5UEcg1AYwEJzMidcCIkZIzrTqbt24bW1GrDR4/2dYqs
         btRy1IxCDZpdD/mrh35r8iFMI5ICBUpoJ3ofmEK6/ykeSqGA8o4Aun/bdlWofCFSbiRX
         fWeFryAPddmNVE5CzTq+PEtiZ9QqYZKjfbMbq5afwotpuXYsAaEs+lwmf6C76xVOuwFz
         8acXEHk494IrKtfEiZmQVNcZA6GrAP5wroKoqqxE+LAS3lCRPiHycMrtlGBH22D/G9PP
         n3I//VK+TPfdLxFJG5nUE1DUUlBc/Hf8IxgChfSC/R0H7eE67HL6tg7yCT/opGUaYEBD
         TioA==
X-Forwarded-Encrypted: i=1; AJvYcCVahmrxsekPTtBuixuYyW9Snakgh9Kfb0xNqPY6+RuuDEiod4+0R9CBDiiJp77qwJaWoSw1Z2czGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJL+mFKshXCn326TSQJxC1/3Z5mzd5w2VImg6tsa0ligx2lJ01
	ihgOwRxMF5FU5/EXf7l/z+c+jNLeFFZDFExTMcmJBs9+Fdr7peD+WiohRQzz3EaXatY=
X-Gm-Gg: ATEYQzx70pUJM5WzQHt2lTt03kH3jBL5ZPx2C9qjDjywVOqHHsEdNQTL3Q3GOqPA5l3
	sOehrgBWBQd2zH7Ftf32WLDPE3YQibg0MpGrQvaU+kciXwRWxszd8seHw3stGetAKJajrWlYVg0
	sOqi5bWWFKfDhheezMHipThpjYEm1LC2Q0TjY1xqmAzKbRZ3SR7MA7j61HtlLTGxKKTfHlrfN5T
	2TFjInxWZ/rQv2+ocWZu6JImlpxoDm10ruzqF/7E+7mp9aRSTHs0coQUBIIYOzQPLpDnFQBO43v
	KkMFqEs3HvlCF2b78vU/lw6BGKdDHnYyUDZZsi//+PTm4s2JZA5uPnsgob2LVaNx3n7Dpwh2BL3
	GmbQXv7BV/0SPl0lPiYWQkrSgUGFC0vbw5zlschzVZxDGBIazASXTxicCUWXnZMseRN7jUKNgUl
	apJYifXM3CPWdGxrk/Yx0dS8uSmLqLvLS9sl/iRKcjqqJ0Vz9EEn8AaCopsLu4fUd4AINcEtGbG
	uNr6Rrk2pjugno=
X-Received: by 2002:a17:906:209a:b0:b94:102d:243a with SMTP id a640c23a62f3a-b94102d2a92mr24981766b.37.1772691120288;
        Wed, 04 Mar 2026 22:12:00 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec3243sm849355966b.53.2026.03.04.22.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:11:59 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Mar 2026 06:11:57 +0000
Subject: [PATCH v6 08/10] pmdomain: samsung: use dev_err() instead of
 pr_err()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-gs101-pd-v6-8-8cb953c1a723@linaro.org>
References: <20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org>
In-Reply-To: <20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 6C4F020B3A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43649-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,samsung.com:email,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Action: no action

dev_err() gives us more consistent error messages, which include the
device. Switch to using dev_err().

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 2214d9f32d59..41a232b3cdaf 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -30,6 +30,7 @@ struct exynos_pm_domain_config {
  */
 struct exynos_pm_domain {
 	struct regmap *regmap;
+	struct device *dev;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
 	u32 configuration_reg;
@@ -47,8 +48,9 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	pwr = power_on ? pd->local_pwr_cfg : 0;
 	err = regmap_write(pd->regmap, pd->configuration_reg, pwr);
 	if (err) {
-		pr_err("Regmap write for power domain %s %sable failed: %d\n",
-		       domain->name, power_on ? "en" : "dis", err);
+		dev_err(pd->dev,
+			"Regmap write for power domain %s %sable failed: %d\n",
+			domain->name, power_on ? "en" : "dis", err);
 		return err;
 	}
 
@@ -71,8 +73,8 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		/* Only return timeout if no other error also occurred. */
 		err = -ETIMEDOUT;
 	if (err)
-		pr_err("Power domain %s %sable failed: %d\n", domain->name,
-		       power_on ? "en" : "dis", err);
+		dev_err(pd->dev, "Power domain %s %sable failed: %d\n",
+			domain->name, power_on ? "en" : "dis", err);
 
 	return err;
 }
@@ -140,6 +142,8 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
+	pd->dev = dev;
+
 	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;

-- 
2.53.0.473.g4a7958ca14-goog


