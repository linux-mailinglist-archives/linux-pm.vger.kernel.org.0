Return-Path: <linux-pm+bounces-43647-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJY0DOUeqWmL2QAAu9opvQ
	(envelope-from <linux-pm+bounces-43647-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:12:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1005F20B377
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A4CF303F1E9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79A2DCC05;
	Thu,  5 Mar 2026 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pyx2Hrd+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE62D47F4
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691122; cv=none; b=Le5j3gCih9v7eRQg2OASw0ZkZq6o3ameNkqSWZgZ0FsPu3yUgTfQoR4HGBkfPeyz1P/537xdvaMxnjuCq0/milQ7q1c23sAlWAKhXLDI5W0XV2CHTRksMLxeViTa1LHoRpzB6/4/eZAs/i4h+Kx5O9B57ZWnR2nfyMGISqBvC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691122; c=relaxed/simple;
	bh=dHULg4KAQ86aduIcQuHp4BhJ2Nb07EP6bPz5fIOQLSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJsGg3WGA5U2BhCMjm8Ru2+pl+Xu2cvyGnHXrUgT2vgzu6oVYBmvENqzT0uJBK4SrYQRt5CWLHeq13qdNB3muMmvYgYdDBDEcCPyOgaXNPcDKduw1OW8/lHMtO5A/8Z3Bb0F0Py5kgPJDXo5RNxKYYRK33DZiwj5cQjgPPKgEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pyx2Hrd+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b936505e7a0so571139766b.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 22:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772691119; x=1773295919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aes9Ymy2SVK6T0USFDpwiCwEp+iOTQGnFHuH7w4M/To=;
        b=Pyx2Hrd+Z9OhjTWh6aRW9jXcmXxotjMhT/zSlyRrBLCM1+R6XGMEZNToJDcsfQSmtL
         7bEK4Hck/tKNR157Kz9gjJuyHyvMwrZWiF0N2joiD6Mbr/fLGjDv1wJZ6zMR/HbAAFex
         +h4klHQrJ5WPOI1xwNA2xGgY8cC/ixn90nIgxDK/n3iKQYE7sx8KgC+0FZeZ1CVcRBXl
         W+uEolZ0gJ36EPW3nzmPxqCcKqObS5n7YcePFuoYytpgLGDuKYGvorjHHWgcFBGQBxvq
         uQ0O8Ga7DsIYZRIgaAlaleGk1Bru3jy9c31Vf34hTy3bH9SqtB/pLK8b9D7Sm7i3gY45
         PHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691119; x=1773295919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aes9Ymy2SVK6T0USFDpwiCwEp+iOTQGnFHuH7w4M/To=;
        b=n1vrnkHhaH0Kgrio/0vmvAHfrXIM7Nue9WLBN7EgBHhWC/ECYIzyi661lbGSqybQKf
         zMRGI9tnt8Y/UM50aJVbBtEm/qz8Rf2bAIImrN/kRMCY4gkINBRalmJZcUc0rJ3lGjTh
         GshJm9LWQRSXXFeTjfqn3qIi6JSh0IklwzvFhUR5YPeYkHiUNEFNqg/nwKtPj5o4oDI2
         TzjklfiZ4iJ+Q703wz20c/QgALNYszrcIeCCHbko18CJWSu+rEIfypkkqJeCauY0FQB7
         ihf9P0rIU46LOgKkls78GCoPsOQWE7uy+3UQ91NOuEnYTX2uMfXVOK4fmvNyGSG7MDmi
         K8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVinAO33JZ7l771WVbn0uXtk0JRpvsrPyhjbRLgMMGWwzJlJYmLsNvgxhsvHtrciHARJQn71rec2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbI+jhryWWHGietQBrp8Gx3dDZiRYtAs+h6AdpTSupJOeyQz8U
	S9KAeMZ6mNX5k/l5CogZNEclV6/IkVkZmb+lLg2x7X6NmUd/ysZbjTDZ181Fm6ciCh0=
X-Gm-Gg: ATEYQzy/U6nLmrE35TgCfS5VeiH4ev6MilIyMCiNIJQiALLQUad9z1BMwLcKlDYbngw
	7Wx3fWh6RYLTzAKX2VsD+M8HlXF8FRT0/Df34TeNdR9urTw4Dmb5xqMYj8f0W2bc9gNrgmVZm3u
	EDS1QPM0ul8QVNp0gpEWNoLSILsMVo/Ok2Di82chfVXAdJrzz8bw5pzFXEkIIPp7FrVuYofcFNB
	6AVIiXCzAphnPnsTUkkIBe2XIiVln8ROQ3/jJ+DSj8F1RKz1u2prTBIePO6aZkFtcGa0FKRICSh
	Ic1V5K+c0BWQguUB8e76gx46B3mw3mH4oy1xQ7/Lg6ca4/AO86XK9uLnrjzl3eIDclm4ZirgLWr
	kgmIiIl8XulZCd8YIfWDvF0CQWr1UDRcJOHbYDmJQM7RxCORIPprPpHOU0Zr5lE80Yenh+Wo4FK
	SHOOOxVtSgCnP6bMghZISY4UYeAD8WFD9yHlULin/5M0SlKfQC/IayxMiRbWCowKQ+idIcVEMfP
	9J+R+T26HHnVzM=
X-Received: by 2002:a17:907:d20:b0:b94:827:c561 with SMTP id a640c23a62f3a-b940885921dmr63080666b.4.1772691118046;
        Wed, 04 Mar 2026 22:11:58 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec3243sm849355966b.53.2026.03.04.22.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:11:57 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Mar 2026 06:11:55 +0000
Subject: [PATCH v6 06/10] pmdomain: samsung: don't hard-code offset for
 registers to 0 and 4
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-gs101-pd-v6-6-8cb953c1a723@linaro.org>
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
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 1005F20B377
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43647-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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


