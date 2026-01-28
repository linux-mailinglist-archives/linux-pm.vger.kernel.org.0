Return-Path: <linux-pm+bounces-41630-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PigLFg2emnn4gEAu9opvQ
	(envelope-from <linux-pm+bounces-41630-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:16:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AE3A55E3
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8648B309DD9A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4DA30C60D;
	Wed, 28 Jan 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhKz5PJd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCB313E23
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616663; cv=none; b=s0GX1MVxL/AUQI3Wt2cDZLF4B5LsxZA7a0pN0GX54UGxHbh1zjj8x6k1uxOfIDJk5NUiXZVRZHw73uYnS/EcFS5chEn8bUFk5xo9fM6z55S8nrNTo9SULDxgqRi8mKyl5llABzP7Xs1eggygJN673sdKr6wfTz6vEzZ9iWdwVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616663; c=relaxed/simple;
	bh=7uwE3SELXGLKzf5NF/JJUetLs0EPpYebrCJSp0Xb+8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFS3ld82DPRQpfXSoTfJUu29qlQXaJ/H0zKeu6JCK95p6ivqPwi5Wk+OLq7pLeYeB70wvDOxHnMF/G/UEqHrf7Y0C8qvW5T3FnnFPguHDvXJB166Pgv892kIaXDUAdSwwCA0Ru+58XglwEp4YtTLPItDf8/lTi2BDK1J3CPnHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhKz5PJd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso80712a12.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769616657; x=1770221457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebxIe09ZJP2AO9RkSAId8NpKhFo/Pn2AHgb75qkbgKA=;
        b=NhKz5PJdbQ9dT0RtSek4l50aFl9txrXWHGMi7Q+pHmTwxofOUGV1/wpP+79VmYwDfe
         C6SvIxPUlihJwuypAOAWMjBe95annT7CZJYD70chcnzzVNT9zOBiaxmkfRX8RX/gx2ql
         BE8GHpvKJfoTDrtAbmVlEyfqrCTu7J2J+lbW9QzgO7dRd944Hu/Lj2tDxKvJYI21tRgO
         phNJ/ObcCe4L2rWIKMNqrRsHVfLvifBFNqAU3lS/tBT0+KVd2SO5WPw0gJ2rOOnDBHdd
         4svNkEjBwpKPFKD57GVzcVuv9PYpDYmQQJuYjVpuO9kAWF6tIEDWFc87Tg64nfuA+p5/
         5FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616657; x=1770221457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ebxIe09ZJP2AO9RkSAId8NpKhFo/Pn2AHgb75qkbgKA=;
        b=ows8+pfrkhIetmkLGrhe1+WYCmWxWQRDjHX0b7LCfWMnrhXz28+F1JydReIBB4U8Gx
         xwqzwmJIm0LMRLnj/Xbf6StyUVFyftORbwim/kRScp/QX94ytdyROhsBwiQgAvCrBnKJ
         QlcfdqoHcYNuEQ5awN3FY34cgXH2u5h+MQpLyB5qXFPzcjiXaVHtxssR6Frvlyfc5DGN
         b6dl+s+wNC21YXzeaMqrUy5RQA3V8S+Dmy2K//dta2WMUYHWjanMOE+/aRYO52a7FnU+
         nqFXUNH2OB8BZewjiU7deuUUXkGm5Anx+66carxpiO+9bkc+fFGD6+1OQ/JVzNyJhCjW
         sGiw==
X-Forwarded-Encrypted: i=1; AJvYcCXfElVH+eXG//UAgh0Pe7KevR4qD9//k83RuxX1DBdmg6hr3+DF5IV5KZ55uDfUqMuCQ8WI1anp0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2uV89thPG/S/5rwWJV+RAcF7LmtNxtqa4FT3igqrD5lrHjMxX
	8WI9B/m0Nu+WFWNEo+nYWYkBx/iYiPRp3n4NZ7W0AnpHM+78zQT2M0aGNPX7aH3WPmY=
X-Gm-Gg: AZuq6aLqwj89E/L88Oem0xSKBwhw8A61FIMIlNarDbRFCe+JVOz6hUJfOhcB13PdgoR
	s8EUBCgdryxthJVgdREQEdQk/WwgUdBFj9489IncF5jeZhuQBbWSQVb7P9ekt1S2CWKK44swVvP
	uJ3G3srk5A3P1am4UVs6YmRHcXurlTG/F7jJulO9Y0OXrTPwU8lKLS2ueY0h3JE20MeZigriQVQ
	bxY1AqwPCM+s8BPfQb+tcynI6Ta4tAgYqyB/8MOI3t2rVho9qGNEkxpB5U7V/59nrgxyK7oW4Js
	OJsw0ocMtq5QK0WLdQTlUAs+V4z7lycElB3+GfBTMG9/dFDO9hr2O1eanSqZemcjFIbEzahWc36
	pvT78eqGO61F/6OAWfxJly74ekiCvkRaQREOohZX8v3/z19t1Z2W6mWxB4+JBM8boVGeEDEIUq9
	nQD3jjBU90GbLrzzP93S9GmAmEx3TUVsHmKJuBwLcHds1wEg6NQit6FZpQ5HEGJSHR+zPa77zPE
	KgAzA==
X-Received: by 2002:a17:907:1b24:b0:b87:3c4a:e68f with SMTP id a640c23a62f3a-b8dab434f1emr359018266b.36.1769616657368;
        Wed, 28 Jan 2026 08:10:57 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c021fsm148553366b.49.2026.01.28.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:10:57 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 28 Jan 2026 16:10:57 +0000
Subject: [PATCH v4 08/10] pmdomain: samsung: use dev_err() instead of
 pr_err()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-gs101-pd-v4-8-cbe7bd5a4060@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-41630-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,samsung.com:email]
X-Rspamd-Queue-Id: 53AE3A55E3
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
index 2214d9f32d5967b60e84f68f4e99a725d66a39eb..41a232b3cdaf0f4be413b25d9373b99c6a3db602 100644
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
2.52.0.457.g6b5491de43-goog


