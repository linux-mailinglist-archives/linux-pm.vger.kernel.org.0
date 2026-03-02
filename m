Return-Path: <linux-pm+bounces-43412-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG4QOLaSpWnXEAYAu9opvQ
	(envelope-from <linux-pm+bounces-43412-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:37:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76F1D9ED6
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B84E73065714
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459A3F23DD;
	Mon,  2 Mar 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdG1s2G5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175A3E0C4B
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458343; cv=none; b=KCiSc53jbaD1eFTnSLVEOEz0sIjAScUrSGdJEoBmltGKz+Lr0z/aPR2JbCF8lptdnwKaOItDRvGregaAGypuReVNNwGv0F7Q+FAvILuFFdd1TnDsVIxOm+5sEqFwJRnk9ZImqJEDwgNVuk3X53Pbx2CNCw/6jrTlDTFF8kj+zTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458343; c=relaxed/simple;
	bh=YpM1lHLHES0D2RDGEBro9MqKfLBBWbbGMNDTqVCiga4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FT03gIvJ3J4GDmBDNL+b+iCfhG9IubAuxEsxal+8v/Fb7Rpic5EAyFGh/4ZBs+wcFc1+wd6RVRgc0/Fvd3YBTMQniV+V0WRkz9GGZsaE7Gmr5buHSkHC8Fn8k5h0uS/w3J8MqbRi9YLn58V3RjzaoYyaToFIhhavZAV4R61ezEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rdG1s2G5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65f771c6b89so6500944a12.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772458339; x=1773063139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHqedqbcEfS+s76zrbM+gGzB6LORzSXrgaPJoZBxb/k=;
        b=rdG1s2G5CodWoDA1whho6wtk+8mex4QP09bq+LbCIM46xyw2usnZUQH6FAxhU7yfpU
         jFA1Dg5QPPw11CkYESffVFrOy4f3xoQfhThbY5+NrDWVeERnSppbAjjGQjSOv4bb7NCk
         fzA9u0mk75OwZZvDesV6261ILKhXLD4RkduI8e//PLov55dSJ7HwrroFej4C3UmoBVW6
         vTnO4pLY7w4ZThma5I2vAotKcTWK51kwL/+9+rqS/2fDwZIDZZ/6BIUhKVfBoDhxk6Lo
         RD4emsZ/SMRZtyCfiRiTgTL7j5jHUR1geY2yZMUJ/+qUhISaVRYSbzdqF41kV8DY0/J4
         gwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458339; x=1773063139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PHqedqbcEfS+s76zrbM+gGzB6LORzSXrgaPJoZBxb/k=;
        b=uh45E1QJD3BCbFKJajzMhUPxdxKR1m+k4mJCsc0/to09mcLd+TC9vLL+/SGw5eSqiz
         NfUlIZlq9kJzI1Y1oI1t5Es2QSttsP9AfFOZdB2mVWoiNiG8N1SH46yPnRAPJ/DD/xZ6
         4/Nv3iHT+K1EyJzzaYIudpzQXlXg9Qka/sp+gSQ+XQ6yiL6YcSvp+VoFXHBZ9IavFyzf
         gJTUAK1f259i1os9xzZScxYCnP2LkEAY5c31OLC8p4IxjR1w5/0JwBfS68NDfFe/pXR+
         R71Xb13VfpmHaevxigKEPbM//JXFL3dEwpL84PfJjNORjPsCAaYrCItPV+NpkcGKo9fP
         7awg==
X-Forwarded-Encrypted: i=1; AJvYcCXMfcrfzJQchOQjxbOelOea3VQvqyw05mIpELvQW8SPdHKd6LMRYj7yvg6SWIKGox9aE3JjuhkaTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7KFc+SYtMw5vbhK0JPmltaVpPAIcy+ayQOLrnXTptKrqf2ia
	klIO0buaeWLZ4yq3o5OvP9+lxWzcrTeROJ0AzS/WT9thDafqSQHCPDdEcQtkClJfzZs=
X-Gm-Gg: ATEYQzxKTJVcgk/hLuZNb82V6vZDFTtA3udNZAL72n3uKZuaihMWVdLKXBC6ccvvT8v
	jxYAUR/sqeQWiMlsbW7F/COzBVPrLlqsGYb2gHWoBr6N/DuWghnZ97iN8EtZwVB8EAAuRCl/3i7
	UxKAuaak5MqnMu0KQYz8G8Of8CriMez/1FRnb8LePmh5Jv6gqbBBN6VQrUBX+GoZr6e+WB8XV1u
	aJsCJc/Jeu9L+xLDB6XFlk53yn9+ilcUVjlkhPSEw8+FChZbcHN2tlqASducTexWfgXS0s4z6pN
	DnPuZUPXOZa/SjzTJGPAZqzRv/APR0TSBRoG5Sd2iplFMLNP2Z7Mah+uulvA82OAvD8X4d9uL8z
	BbeObl7293mNcpimLQaEwAuybR4ekXbsVqYRjFLy4DGvkXWQxqLlMPn/tT+aR3z13YCczLu6rQn
	UApW/F+cOrMOqVTPHeB1GwNT7dQfdDI2Ai4CMCPA9iVU8Gi3OaUJDjraOI+sfXpaeY77TeLCTEm
	hAbwBvMbmZIOYE=
X-Received: by 2002:a05:6402:398b:b0:65c:2af1:b7e2 with SMTP id 4fb4d7f45d1cf-65fddee587dmr4953593a12.27.1772458339270;
        Mon, 02 Mar 2026 05:32:19 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d1c6sm3282988a12.17.2026.03.02.05.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:32:18 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 02 Mar 2026 13:32:04 +0000
Subject: [PATCH v3 05/11] power: supply: max17042: use dev_err_probe()
 where appropriate
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-max77759-fg-v3-5-3c5f01dbda23@linaro.org>
References: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
In-Reply-To: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43412-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D76F1D9ED6
X-Rspamd-Action: no action

dev_err_probe() exists to simplify code, harmonise error messages, and
set the deferred probe reason if relevant - there's no reason not to
use it here.

While at it, return the actual error from devm_regmap_init_i2c() rather
than overwriting with -EINVAL, when relevant.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v3:
- update commit message regarding devm_regmap_init_i2c()
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
2.53.0.473.g4a7958ca14-goog


