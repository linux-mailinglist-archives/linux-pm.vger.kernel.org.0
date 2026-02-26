Return-Path: <linux-pm+bounces-43249-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACN4LRJHoGkuhwQAu9opvQ
	(envelope-from <linux-pm+bounces-43249-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:13:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80D1A62FE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E27433080B85
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDA132B9B7;
	Thu, 26 Feb 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXlzJYkb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773531A7FD
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111505; cv=none; b=Jts+inV9aMTxi985X6pNOJMGGwFXpNIJJQuiRHlKalJMN81QSxDESFvxWw+sLVUEqiA99NoeR1b5KLUKamJYaheLDpmh72CbG4iPj0qqkeP74iaBM0QYbNYrDAb9wfLcfXKAwsT3ABqesfQA+QiG+dP+dLqBYQtfF+8r3VJJMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111505; c=relaxed/simple;
	bh=dN8f41bDXLag1KExFhMc74SNVuHCSIm9nPSwzqJfuzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9GCzsNKDwekdA/x+Cszs1UxHI+l+VA8eKx/5A3vD3/H5EKjLECu99TMtEtdJZAvY8HLrIWi/7I+SP4oWZNzbzmFsvTbJq1n9Qse02X+nhqm2uNlokrLD7Sn3714ZURuTm533ncdLcfmA5N2SWqFdTZlHMneny6t152crVNThbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXlzJYkb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b93698bb57aso32798966b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772111500; x=1772716300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELA1QB+7rfEMiXDUeYSPxVC8r4onmGwJXoRsl094MSo=;
        b=UXlzJYkb+u8ztZa2t9jj4bEuALmwysSjAcEXqGby6LKrZiNp4AXo7brDlZhkmDhYoY
         jJyOJREbj6+k23EGXNHMB0lE7uqZrUz4QYTqrC4mDFbBSpf4bvshEkrXomrocvWOzuzA
         /qWrQ8vO4IBjTMHXlr37M7lBg9UhszB43in6Ptu3x29bnUVslSPCxRE90Xr/CXZ9G2zF
         tiK5u+/VdIOYPhmQL+RGgC4ku7hfsJ2uZZNGCl4EtYtuiHHzjpvz8Ex0C132pM95fMxa
         OETDkpuSPrb/m7aBXt+G+F4mTpuxeYYn1AWn7qUlPF9vI2P1lYdhTMijzwWIBpqddhgu
         gZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111500; x=1772716300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ELA1QB+7rfEMiXDUeYSPxVC8r4onmGwJXoRsl094MSo=;
        b=AvSls3EWOj8qrKSXRDgcBooyiDBtQp3VTV5OVH1rG3zOfYy8wuO9B0Ps9fhASFLoxH
         w9wLEaPUtyc2eu8YgC0I96VmzlmeSkwwr4W9bYpWNGmid54lFD1KqrIrniJMkc6cRvmp
         FpaioX+2u1YLQH2nW7V/c7QZLefEGshisVo0JWlUakjV9ejBUcXAhK2ALZ1ELO17icP9
         6OFP8BK4XtkW8ro+frw0FTVJ84DUiS94bLONRhH/Ppk7z2uJD1wynb5uwC7+N8fLhBxi
         AYulwsf733L6Lxm6+TcjEEuqtD8hzmiuD2QQOXdL2cbaC9ib6+sSRtRciudV/aG/+Ekk
         EpNg==
X-Forwarded-Encrypted: i=1; AJvYcCWC0gt0oiq1GJZQVCMz0OKpLK6ki0S6akoLNFaqSWdqzsnGoU07/D+4oStnYgjs6lU/hDFnIAiiYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyviOGrB3h0CdnQemQnDq/zO7N00H8heMoz69bk4h/exJ4MsPgE
	yGbqNCkrnB3Fp40GIpFo+RVasrr9SCdHKNFd5Qi9LUDwWyaZpmHFM8sZBQpn+yeCYKU=
X-Gm-Gg: ATEYQzwU0GnO9PqYFNwwd5GHWA8uAq5gq0Cs3MMSVUfXuct2Eupe+iTRqUGBusRzmqA
	mA14Kg/DegzXdLfDv2jvCAs/GhvRrn9+Ne3qmBGGgtZYMqAHPrAtyYW0PmK/io25Q10JD/v7iFK
	cSN5HneoCbKRvBywNK6uuYlIzUz3t7bUb5bx5Y8TkurxCEckigCfr0uxRyiQFfrV2rchY078pfv
	fRq0CYWqLb96sdC1mW6ZoL9QHfTFCgMo8FNkEm4MF7RdoTax6eBxSiNrVLZvQ/1LPCG/8Jlnv2M
	qNmlgR95vtZ/7NVN9Oh8Bqa1sePYC+DBMRP2b5s7hhJYE7imHN8fK/HIAYWP087yRMmSfSs2W60
	ZPih3KnNhW8XFITshJmAnodyzyCQiSu0TPjmaIA4n6qi+p25ulEeK6NAZ5MHOSwMrtOVLLmMVQ5
	q4sm0frqEKxDFcyYAhW+CC4ai7qXls5W9GXUZS+PLBHfgi4J5zEZkuSjCrtI/I7UeUiTmuD3PgX
	fy/s0QfV/+Iq+zZcA==
X-Received: by 2002:a17:907:cd07:b0:b8f:c684:db37 with SMTP id a640c23a62f3a-b9356f47682mr164714966b.9.1772111500272;
        Thu, 26 Feb 2026 05:11:40 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm55125866b.26.2026.02.26.05.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:39 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 26 Feb 2026 13:11:39 +0000
Subject: [PATCH 05/11] power: supply: max17042: use dev_err_probe() where
 appropriate
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-max77759-fg-v1-5-ff0a08a70a9f@linaro.org>
References: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
In-Reply-To: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43249-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E80D1A62FE
X-Rspamd-Action: no action

dev_err_probe() exists to simplify code, harmonise error messages, and
set the deferred probe reason if relevant - there's no reason not to
use it here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 07759d4fdc37..b9277f81a25d 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1053,16 +1053,14 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 	chip->dev = dev;
 	chip->chip_type = chip_type;
 	chip->regmap = devm_regmap_init_i2c(client, &max17042_regmap_config);
-	if (IS_ERR(chip->regmap)) {
-		dev_err(dev, "Failed to initialize regmap\n");
-		return -EINVAL;
-	}
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(dev, PTR_ERR(chip->regmap),
+				     "Failed to initialize regmap\n");
 
 	chip->pdata = max17042_get_pdata(chip);
-	if (!chip->pdata) {
-		dev_err(dev, "no platform data provided\n");
-		return -EINVAL;
-	}
+	if (!chip->pdata)
+		return dev_err_probe(dev, -EINVAL,
+				     "no platform data provided\n");
 
 	dev_set_drvdata(dev, chip);
 	psy_cfg.drv_data = chip;
@@ -1090,10 +1088,9 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 
 	chip->battery = devm_power_supply_register(dev, max17042_desc,
 						   &psy_cfg);
-	if (IS_ERR(chip->battery)) {
-		dev_err(dev, "failed: power supply register\n");
-		return PTR_ERR(chip->battery);
-	}
+	if (IS_ERR(chip->battery))
+		return dev_err_probe(dev, PTR_ERR(chip->battery),
+				     "failed: power supply register\n");
 
 	if (irq) {
 		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;

-- 
2.53.0.414.gf7e9f6c205-goog


