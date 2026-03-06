Return-Path: <linux-pm+bounces-43788-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iChGE+isqmlTVQEAu9opvQ
	(envelope-from <linux-pm+bounces-43788-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:31:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C05E321EC1E
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C86863055F8F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6E37F73A;
	Fri,  6 Mar 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKNuhlt3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EBB37E301
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793006; cv=none; b=Z84W4BiYVP/S3fePW+6adi2Lvp7zvGuudUHtbwpgCnZjVWYaN4IydZlFwP+w/0hfC0QZHcOGBaT6YGMAw5GYeJafHXGEq540e41JSGUHtsTvrYaGwkFMhk0xTSCCq1LeDlLh71KQSYaklXqEGQtUfXwbcVtaeLntv9t1M5ClwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793006; c=relaxed/simple;
	bh=k+2eK86lvnhd0G39XcYd0Wo9v7NwbPnA00WtqszUSr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4Qe99nwBVme3STIJwM2bHu+vcXc4kQe4cwpbwCvSPPoJMclIvG+5iy+2jEcZdZCGNNugv6yMWCC/7vfs5YXW0Kr4RmLJb7sGamuQS4zdKiIewHC9EpLIkZvSyEyUo3BbaAaYvor03+7BkIpap0FFN47oSIQX1io+6EkRZkxdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dKNuhlt3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b940f962a82so266378766b.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772792999; x=1773397799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJyveOpQYRN0Rj97xYSp2eMNn5Hi3Nxu7cTlokaFCRE=;
        b=dKNuhlt3KCfBsuTey8Np6s1O64kfB8yNf95T89pvdr0nD08aWxe5lj9CrquQYlcBSv
         FQr1qwZnDWnjsB7kGtONsMcnMYXbgB7eToQRh0r2WYf9wUEm47udvF9rGD6ixRFCwUk7
         01M1xTNKr1uQT1T4HPjbbMBcYRs7Uj1bXn8YLOEaPKIHLUUOt9aCvGvEsTbNRGN5t+fg
         UTAwUjN2PYq0rgk/+90Zvnq1/Q0kI+YC/VY4NJAGOaYS8naluir2Uao/VwrjKt+QxAgZ
         EMNdd3fydPClvSs36YUHrQ+bAcv++NVaFKBeowH3p7CS1P9Qyha84lIcb4QbBZ+RSShr
         mHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792999; x=1773397799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GJyveOpQYRN0Rj97xYSp2eMNn5Hi3Nxu7cTlokaFCRE=;
        b=QJGURTuNLEKp29ZInkYy3nrfWT1ESCAZnR9+zb2Fof8T9u/HClPS3cZ/vnvqB4jA8v
         p3BVHyg9OtlHgwMX4YWctVkTxlSWZUTC06oZoSegl19oec1y/ksCduV6uWntzlD9DTqf
         LSdw1qYAi8rxmRLdpUyqP1tgmzCRHYW1E9gr3EV96rV3dldA6ZasoK7aPUtovvJWLu9C
         bVwnO3XySF8lckhkk5vp5uIEiRRYdQj6BeYYMJyK9cHHpCpW45CgARKauoli/2lJPqIT
         IlgaL4vIsA++ShayR+n1MRBcMLgyuk3ruOm++fraat6AJHaB9rr2VXxTWreiQxzsfGrL
         1qPw==
X-Forwarded-Encrypted: i=1; AJvYcCU/VN22G2zFRvVdLibOZdR6bgBADMsWt5XQCcL/3VgwqHBRKMtc7iN5aQ0Y3Vz8+5lXuxiVkpFdZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRuh0fpKHJ0jzkG17/IbWq7kMvXx/cYUJ0SSCatUeXzBao79hS
	Id/7Bo6I13IJRR/b4XrXkIV2lhHYkK/C65ClXidXaqVN/P2323yqpr6C6b4pnC0fVaU=
X-Gm-Gg: ATEYQzzdADxk3JSs+FUcghJdujLzHiX5J14/Bg6vtdm1HnVu9iTPfxAyM33X3DLvRR7
	0r46XoikvoZCYkhpyp4tSdKGwRzpXQ2h+u20JKv8pVhzOvtq0uS5z2l0l578iS1ImsoBILT8bFx
	RNNX9uQYdTFtfaCh7N6mVyDheb8qHWQpbAahZ2xqkB6nvXmhZQs/7JuhPDMyS8YeJv6AgyW0Dwo
	E/R/nP9KkZYF2Qu2+hqBunt9Su/hLyOCUtJ0zbosfr5M37lGONJ/UHujj8czHXHq2j58Nyrmgg6
	qXYUXaDSh+PqmM+lzYKpFQtY3+Tron0wNlJ7+QB6DMN8whhrT87+g2emv17Uq9+aG6KB8D/FAKu
	B67D635wlCdBRRpwkWJMAj47Wy6nVuV6uPzJvOePQEtoGnF2g2sXaw0JJjANEYb6Ca2yyjSokfc
	IW22MheDRkNA0aH/nU17QKDPEgQ7wlvGFSQuxr2OUh08cAI28TbM2MMN6WfKx91nynVupIITxEJ
	djpMAZ38VjumwlNnAC09yqSlQ==
X-Received: by 2002:a17:906:6a0c:b0:b8e:3d49:25db with SMTP id a640c23a62f3a-b942e00db25mr86819966b.54.1772792999461;
        Fri, 06 Mar 2026 02:29:59 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8c95csm42907266b.21.2026.03.06.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:29:59 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Mar 2026 10:29:59 +0000
Subject: [PATCH v7 08/10] pmdomain: samsung: use dev_err() instead of
 pr_err()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-gs101-pd-v7-8-03f7c7965ba5@linaro.org>
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
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: C05E321EC1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-43788-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
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


