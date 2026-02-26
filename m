Return-Path: <linux-pm+bounces-43250-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMFEJT5IoGkuhwQAu9opvQ
	(envelope-from <linux-pm+bounces-43250-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:18:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95D1A6447
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1457E318EFD6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257632BF54;
	Thu, 26 Feb 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKN/acmA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D931AF2C
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111505; cv=none; b=R49iLb32TOYX+PXBMxz5ufS2yDbZNVcSWMwtBcx9C/jOrzU88megq5Iz+AyB1g4OgxnhQkP8fSys5YH4Ch+XBoBjmaqtUfuZzH/rttXwBsa9KMaBk/S1h3uEUiDwqDoo/ofCqxAxLCotfMtkOdKE+QdovROY5sR/5OITf8A1/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111505; c=relaxed/simple;
	bh=eh1OY1ieLLdHnT7gZwSOwUnROhsTRrF71czKCjiixts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwLlkWSnO5Bm2tza1JWVp8UPENuSnNmUGyxpp2SCSsduMgUWHKDXwiXgpB/INedOZ1SWcjciQWFk89qzsxRDf5yRnw1i9SWqbCyNFKh2AN31ldWCRJeVTexfnB0VIHRzEpZa4WGFs9v4JblI9y/kwRCqy7WzBfUVvt7IFwn6Wmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKN/acmA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b90bc00578cso125371066b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772111501; x=1772716301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6Q/YbctU2cng/xKxSbyuYnqAnOaNtvn3Ivyo/NwaTY=;
        b=QKN/acmARLYDJhLlKJil0cPrQHhlvzBrhslXhmBvlYhJqJAO6Bg4W5/h6fTGF6UOJl
         4qZaP3vjEvR4adtEMzoBQP9wiIMDEloFcAbgHRSlLIi+f1r9pxX8NAA3lUyqQa4eQewL
         VE0M6XPB4Nplz54ojR7cAA5cbQim+GL0u9D21F0m3+UyT+sn3MlWT1rC+jSELLpI42B4
         i1cewpQvjcxqWCCA1r0KfXyWho3ht5dyO7upeZ6dWixSyAaSoAmGG0A17qasYHsSDrx2
         5xQJ0ggPlrdtQ9cdZwzLaPYiJhMFro6c0EV5WCLNt+dvKGBkUd6YSHuBiHDrWQIE80h1
         wCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111501; x=1772716301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c6Q/YbctU2cng/xKxSbyuYnqAnOaNtvn3Ivyo/NwaTY=;
        b=JayuhIwq8rel7AVdN9+EU035N/yYxV3wxhzb4HAcbCJ0hj6TWzPT1vvwmRSfoyl3k6
         mJLC8AWc/vGqTEefs392yQtZTK7UesIsW1UPtFPdBkJdOZomVq5tANDify0DtfszlKV0
         4F0BXRlGsy91V3yJVTBnnfGHW9nvQQlaX+URkKSfUezAY/T2TkA9U4rnV89U+FO8nP3/
         Apq1fD/EfuvHbeVnhqzgeZ4XIk3GhTtV1CWM64/ilqQEwY7EaTFe0Sufu/8xOBytXxa2
         bDBc5xl20V9a2KiayRUofHao01sFI0cdqYadQWRmfqEiuh6lA/JWPBFeBR9btIfu2eDX
         tfLw==
X-Forwarded-Encrypted: i=1; AJvYcCX0AfBO9T4deWzQ/9Zhwcn09BcsapiAFSLQWLzbeyAmeDKQ+YqXYdcXkRQiPVFmz2+bUAfT0eDULA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtANK+4BI4NqOOHjnrDpF+SsKkIxDMtDbikRCCmACzsw+yOiWe
	uoqbxz5mcltsSS3IHb7UmTOlfhW3SSBxoA3pq+18WO6bAh8PeLEAqueAD/4uSEBgKKM=
X-Gm-Gg: ATEYQzwMaZjVt2DVwWDH6ID2r+H+c4nRxEB+9L796tc4HT7I901nOt8afkM/ZKHbrlO
	UQIMZRtQpjKeqfDfRE8nU5r3RhU3iUHeQvmIe/gkxF2EPbVYoCHB6YouGxdWbqYquvXgPW4Jfcg
	/nK9PGLFgTesi/4DRMK+UjT/JIGgxzQrb+CF8FPJgmIBLEIZcHqZ15dBNlM6vISuKNT3HRpm+iC
	g1JCmniW3fxccsDhzXyzqb53J3BrUxEoUplN/fdhE7zU/FuvYpxmw2Yk5ZSYzgr/Ks+8KwG693J
	MwtHjF1VTsa7wlrb8H6lbLiB1N6UPq8MRFcSb823tDkk01cS+Y4ZGhAPUCjw0CowJ/04r88wNoI
	Z14XaEV7PJosZ/vFR8LCFMCPcxEAuJ8/5N6uY7mefS3zDWh+z7jcCUjSHQHiaGrik8W4RvvE4Id
	FFUJBQAYq3iBLDFOFhFbsujGlpi5SRBcwsjmu5vVYx01ZLYFs2Ca4eu9C07EGUvxPh4sk5E/SRr
	9eAftCZ3xoUgfx5YKwMXqRTYvId
X-Received: by 2002:a17:907:78c:b0:b90:ba11:1694 with SMTP id a640c23a62f3a-b935b936384mr131201466b.50.1772111500895;
        Thu, 26 Feb 2026 05:11:40 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm55125866b.26.2026.02.26.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:40 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 26 Feb 2026 13:11:40 +0000
Subject: [PATCH 06/11] power: supply: max17042: avoid overflow when
 determining health
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-max77759-fg-v1-6-ff0a08a70a9f@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43250-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: EE95D1A6447
X-Rspamd-Action: no action

If vmax has the default value of INT_MAX (e.g. because not specified in
DT), battery health is reported as over-voltage. This is because adding
any value to vmax (the vmax tolerance in this case) causes it to wrap
around, making it negative and smaller than the measured battery
voltage.

Avoid that by using size_add().

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index b9277f81a25d..8808c0d2ad10 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -201,7 +201,11 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto out;
 	}
 
-	if (vbatt > chip->pdata->vmax + MAX17042_VMAX_TOLERANCE) {
+	/* avoid
+	 * /sys/class/power_supply/max170xx_battery/health:Over voltage
+	 * due to overflow
+	 */
+	if (vbatt > size_add(chip->pdata->vmax, MAX17042_VMAX_TOLERANCE)) {
 		*health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		goto out;
 	}

-- 
2.53.0.414.gf7e9f6c205-goog


