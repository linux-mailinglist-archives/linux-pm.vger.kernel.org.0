Return-Path: <linux-pm+bounces-43787-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMtTHtqsqmlTVQEAu9opvQ
	(envelope-from <linux-pm+bounces-43787-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:30:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C321EC00
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 350323002789
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C8A37E2F6;
	Fri,  6 Mar 2026 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FL4AHvQE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0E37D12F
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793004; cv=none; b=FYnPJO/yjKPzDT+CGLlHXc5XYyAP4N1fYyfIrJYUfJ9ezV8rSKs1waGHUwPHcuuFq+auVh+z8hfeiUV3V0pYFjHTWrAhqIw4I8cQFvv+CWtUHxl78xAkqca4EOeykL3FFTW4pOXOrlrmNG+yQXDuHFjVZ/BZkceFc8w9w6+Feo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793004; c=relaxed/simple;
	bh=dHULg4KAQ86aduIcQuHp4BhJ2Nb07EP6bPz5fIOQLSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8iyE6OyT0bBiBKTb7exG1PXjCxyDOL6h0n15pHLFJCWe6w8Fa38/+kDjtioY8NIyvT6G8IMMQ5jEOv8Ss9tOUSTjD7cioLq+Wv0RPMDE97GLxZXAzMpnbPhbi5SYvgnaTeSXbGJtT+Pp30PtKGh2nfi0/bKHcOGB/Z6ExG1NlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FL4AHvQE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so1110076366b.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772792998; x=1773397798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aes9Ymy2SVK6T0USFDpwiCwEp+iOTQGnFHuH7w4M/To=;
        b=FL4AHvQEVYvbAajWoTI8ePBmqFickSVhiwIdB43AaSjVsXPr3ujGMbZh4S2Fwg/pso
         9D5GzB2iEcd21+1U5GzizJRFvXQ2fN+qFydGy9i9/cp4v+xJud6PFeRVxGYmR7KCL0Mi
         hWCkhdNi+WvVUl+HInB5h+jNtygB49ExlFetI9KTjCOviPX/Y0Inm8nGgWL7mVVakHOK
         I/Psk8OLhW/Vxie16lYKAKyvPTzKiwRfgMrT2hxy7c/n1v27+ERlgovVs9A0w20eka7L
         +Tdiw7PwEsX4zz18/ED0nV4O9GePgn4V5N5/vy78pnZdEZehCLkuseO3yT1ObfgfGufW
         GEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792998; x=1773397798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aes9Ymy2SVK6T0USFDpwiCwEp+iOTQGnFHuH7w4M/To=;
        b=Y9O6+yZkzizuskwDw2IO+pv5dUV9pfAaUv92GJT7KPGb9QuZLno0ZxpfV5lQZvu7sQ
         Sfnq62Oq4DPTxFc7lyJSFdrGV2EPutFLJm1fUrcnGy9GUMZJ6dwMKHJBydzAHbwFbTJo
         Slxw7Evd3BeyZNOX9kXJqMq0t7x26X7pl9GTkMuA/TGXo8rQsOFGdywyHMv0jB3gzzGi
         mL123gNNrIqRisLyg5O0/DG34Cx1KddjglVgVJVHz1gwPFFe3eV7z+08G3HsvamrbFZ9
         rneiTxiwOjqpadhbHPuAc26NepjorvehDhFY3loe8Zzjdm0+w0cV5VMRU+hkJGJSHV67
         TRNA==
X-Forwarded-Encrypted: i=1; AJvYcCX7hi0Ar+VOfMCT3be/jN1imDNob7QmPeMWGKodz5eVvLfJHU4dJmtb9SAt6fCHWfsHXodJZiwgPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqC8LsQfbLUs79+0jYTiYxzLBvk6bHA/lgf4vg9B/TgbReqgFu
	UtJIU0rEbUAdBAxk04f2eHhOHmAnHr6Q6V5FYGra0mEIb0esd8HGkREnc1H+kCXVN8A=
X-Gm-Gg: ATEYQzyb8P4EgRDjI//O72/fU/xuLcOBSLzZfnEctgpQMalRuHu+JEPurGZpdrcfoOu
	8y+WcQc4pvXrcSyoqX3pYtQ+8rP4xIamiaYUlIWS5Fb/43ncoSYQV14B1odrrb7aCUw8CqiSWRN
	qR2QSioD3ABeSpcaRJnkM4IwH1YbejXsfsE5bHA7vDznndfyUCd3VL5fvQ81M7lVEZgDft4vNq6
	dZ4ZzgglJC4jlT1MMN+p6YGX5i+aDwMuI31pYtmrsPHJ0ktmGQil32sCkwPYUz1IfpM3G/L3hO3
	ehmqdz7t8VPM83Ir5EW1JEepvcR5Te7sm1o/KQdpIZ5KeecSkRiEMaduezttIodWyLTy4vFZpxz
	sF6YKRAXcWsOsjvNXBtPFghA1qqXRUBwY0HCmZb42pVFvdpHzrbLvXduCKOFB/rD2kct57n+lFS
	oWPAOBcmnM23Y40G7XfMgxt7s68n5Jx+3tSztBaD5gVFzbtt9hVjq7kpScjxjYTOMFIhDifTrAX
	E0FatbB6uFEJNs=
X-Received: by 2002:a17:906:9f8e:b0:b8e:7dcb:7f1b with SMTP id a640c23a62f3a-b942dbdc76fmr87190666b.21.1772792998248;
        Fri, 06 Mar 2026 02:29:58 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8c95csm42907266b.21.2026.03.06.02.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:29:57 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Mar 2026 10:29:57 +0000
Subject: [PATCH v7 06/10] pmdomain: samsung: don't hard-code offset for
 registers to 0 and 4
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-gs101-pd-v7-6-03f7c7965ba5@linaro.org>
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
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
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 234C321EC00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-43787-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On platforms such as Google gs101, direct mmio register access to the
PMU registers doesn't necessarily work and access must happen via a
regmap created by the PMU driver instead.

When such a regmap is used it will cover the complete PMU memory region
rather than individual power domains. This means the register offsets
for the configuration and status registers will have to take the power
domain offsets into account, rather than unconditionally hard-coding 0
and 4 respectively.

Update the code to allow that.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 3bcba7d38ac1..8df46b41f9bc 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -30,6 +30,8 @@ struct exynos_pm_domain {
 	struct regmap *regmap;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
+	u32 configuration_reg;
+	u32 status_reg;
 };
 
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
@@ -41,7 +43,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 
 	pwr = power_on ? pd->local_pwr_cfg : 0;
-	err = regmap_write(pd->regmap, 0, pwr);
+	err = regmap_write(pd->regmap, pd->configuration_reg, pwr);
 	if (err) {
 		pr_err("Regmap write for power domain %s %sable failed: %d\n",
 		       domain->name, power_on ? "en" : "dis", err);
@@ -53,7 +55,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	while (timeout-- > 0) {
 		unsigned int val;
 
-		err = regmap_read(pd->regmap, 0x4, &val);
+		err = regmap_read(pd->regmap, pd->status_reg, &val);
 		if (err || ((val & pd->local_pwr_cfg) != pwr)) {
 			cpu_relax();
 			usleep_range(80, 100);
@@ -164,6 +166,8 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
 	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
+	pd->configuration_reg += 0;
+	pd->status_reg += 4;
 
 	/*
 	 * Some Samsung platforms with bootloaders turning on the splash-screen
@@ -174,7 +178,7 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	    of_device_is_compatible(np, "samsung,exynos4210-pd"))
 		exynos_pd_power_off(&pd->pd);
 
-	ret = regmap_read(pd->regmap, 0x4, &val);
+	ret = regmap_read(pd->regmap, pd->status_reg, &val);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to read status");
 

-- 
2.53.0.473.g4a7958ca14-goog


