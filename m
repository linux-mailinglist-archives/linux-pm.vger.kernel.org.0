Return-Path: <linux-pm+bounces-35747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0FBBEB56
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 18:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76FCD34A630
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665622874F2;
	Mon,  6 Oct 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFEHqKBd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08D2DEA9E
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769017; cv=none; b=hEzfrBs8OlfejHQ/CD+0/sssBKRLZv+PBWTcVx1J8+rx5NeGc+IhHbrDCoDH3OwRTZdsgpUqjNzSjfKX7lstRV1rqarMeIfdTBlk8iBo9/B8M1DB9cuaSIuSJerRrcR+MqSOJseyiW4snmVxOqvch81lcPbRtDvij7r8+dA6A8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769017; c=relaxed/simple;
	bh=geIKgWF2ALweoM3YZgXz0Zorhb0jTxVcchCl54bV0Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fAhX/Hj2qTxv7B85cweYuhJ4/Dy2VBVufN8r619ru0Leey00HTJ7e1IrWxt3iDBSHbnk6abTtcR+OVAr3jSRO9xfe5ojOoCaufSai47zJ4iRl+gBurQsw+0Kuc5HDpAPjeeN8xbW40t3XrFPtfbWdEAgWD4aGEB0GgqhSfvmE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wFEHqKBd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso2442793a12.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769011; x=1760373811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxwnlAP3n5M7cyJiouK6nx2qCN8Hw+Sbnl76f2YXigk=;
        b=wFEHqKBdBeQ2ei8jpQHWd7l6Tm/e7UCOh5/su4FIFADv9zrzduqO4UJQ3Cx5yX4K9A
         klcDvD6QWcrLTQGJvrIay1XWz3nJ4GKsC8xHIangXHXKcpmBFKD5ytX65mXaGD15yTl7
         +e0SoNE4SuBDUHin48IYvlwrti9QYXrGSrCHrxnvmKnObFuWB19st0oDeD9PQubGOLn0
         IdPdnvo+xS+qMhRu2/6vo2In9CFADENDaII3X2OjBvSvfPBzUD7uwv14MlS4Lwdi8/jX
         DZJ7EUbB4WuldhwMVvL+TkfCkh9YCxqBMXwhmOjU1+qcWKxhCogEPo/7K2tdyHG1ZHXf
         j5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769011; x=1760373811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxwnlAP3n5M7cyJiouK6nx2qCN8Hw+Sbnl76f2YXigk=;
        b=FbHbDPq83GE6R43CChyJqIHNfC/MnsvAeg55Q8xarxVvKQvCoApToNNBy48Isz2GmC
         gVjjy/oCZgU5uK1lUPZn/x039mOZS2/RrMEiagPoAHPJw2mbkHQWz8FmhY1lzwu1CgFi
         lALywduzkNtXYX9NO7amZxm/z4Kg/ZmaVgbXvq1asnLiofWTO2qpNtkouB5lHb0bnbTO
         StNxR5mLvpo+DRMlslwn4jl4sbDReZVXaoOnCKb2FQg04/dagJRr6JvUah3lzrk9Z/9b
         g6maH1F8oarUi+QWVNmQcxry/lpxVfxpOz3SdiutWS4CV10T6Fs/22gW0etm8CYAp7Dw
         m7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7OxTlr4OPY/XvS/y6Csy0elQiUoev6+v5VBlf4aeba0X0sD0d27cb+PBAwN4gbsK3lN8ho6M0Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuwnps0ka+0HOgpqP6paL/STICmju++R5vWenCprMLQ3ZPJCf
	iWqNzfH4eBLgtMwy7vB/+Ogd0YZdemrw3WS2p4cJq2LHWp2tIcFWLhZfmBJz1GDdR24=
X-Gm-Gg: ASbGncu337u462DdnwEk0Zs0nwlm4Y96B9A4ZxA0/f899kxgjsIQFVwXzoAV9VawefU
	ByhXVvwQMc1GEbERKoysm0+HxNEyX4WGZHAIhO/Z1cX6ExI1NhjBjfTcejLxx2Uw7K1APDvQ5mL
	Fd+x2QzjBj+JRnthEEEr2jcOAFy7+c+uYl3liIgguopQs+x7QmOIvJiZgNiXFnE39fPAtm7NHOZ
	/6bRhAlg0P4cOjHLUhrAohF1Cz4nxfS2ziRviJcr5nHbknOG9YU7rwQMBRQd536d9p3hIu9KcTo
	ceE6nA3AZR6Cm3OmKJAknCkCCZpqGllzgjKdeAD/6BrC2xMMhLPocHfi63k9S+aRaf5Nx2xRhau
	SVz//nKcPj6pwMp51tRXfVN/dKZKc/hINAYxLghsMzOsAk/U7v4ipl0uigsPegVKmbvpJvaQBkW
	deL37B/rExkKTs4rnuFq1LqaKYN86y3275I82vMHnZ
X-Google-Smtp-Source: AGHT+IE6Qi3Ngqwo98RrZzSI9Sk/ybN3uGg/1PQQF+EI33WkQU1ToLbh1rIvJ4g1vAv9PRSJV5XHUQ==
X-Received: by 2002:a17:906:c108:b0:b45:66f6:6a17 with SMTP id a640c23a62f3a-b49c429cf5emr1502411466b.45.1759769011299;
        Mon, 06 Oct 2025 09:43:31 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:30 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:32 +0100
Subject: [PATCH 06/10] pmdomain: samsung: don't hardcode offset for
 registers to 0 and 4
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-6-f0cb0c01ea7b@linaro.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

On platforms such as Google gs101, direct mmio register access to the
PMU registers doesn't necessarily work and access must happen via a
(syscon) regmap created by the PMU driver instead.

When such a regmap is used it will cover the complete PMU memory region
rather than individual power domains. This means the register offsets
for the configuration and status registers will have to take the power
domain offsets into account, rather than unconditionally hardcoding 0
and 4 respectively.

Update the code to allow that.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 431548ad9a7e40c0a77ac6672081b600c90ddd4e..638d286b57f716140b2401092415644a6805870e 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -29,6 +29,8 @@ struct exynos_pm_domain {
 	struct regmap *regmap;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
+	u32 configuration_reg;
+	u32 status_reg;
 };
 
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
@@ -41,11 +43,11 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 
 	pwr = power_on ? pd->local_pwr_cfg : 0;
-	err = regmap_write(pd->regmap, 0, pwr);
+	err = regmap_write(pd->regmap, pd->configuration_reg, pwr);
 	if (err)
 		return err;
 
-	err = regmap_read_poll_timeout(pd->regmap, 0x4, val,
+	err = regmap_read_poll_timeout(pd->regmap, pd->status_reg, val,
 				       (val & pd->local_pwr_cfg) == pwr,
 				       100, 1 * USEC_PER_MSEC);
 	if (err)
@@ -146,8 +148,10 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
 	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
+	pd->configuration_reg += 0;
+	pd->status_reg += 4;
 
-	ret = regmap_read(pd->regmap, 0x4, &val);
+	ret = regmap_read(pd->regmap, pd->status_reg, &val);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to read status");
 

-- 
2.51.0.618.g983fd99d29-goog


