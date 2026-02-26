Return-Path: <linux-pm+bounces-43253-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEg7GxtJoGkuhwQAu9opvQ
	(envelope-from <linux-pm+bounces-43253-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:22:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C62361A65CE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862C231356FA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED013375D0;
	Thu, 26 Feb 2026 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NC1n05GK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02279330332
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111508; cv=none; b=H86txqZFoxmeuLMsrHAgidq6pbnjSe+zA9JzFwoOpUNUbGd9TDKzHvwuMlj/gNE7hZAASYlZWFhE93vBXvMPxGz5iNXit9HEZub9W2ltuRbrTqlTp+4DTMjJX4igKoYOIARKH+mNEtwfAlAkbmv6rzwRzlo494Pranw5DxJiAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111508; c=relaxed/simple;
	bh=GPfoLWJNaZbAuE5sFY9vCrczQONk3K2jd0EZPiGevHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7JcL8ZxecZEbVnwsFyzp4HR1RgdZl58fM5VZhAZ8x/wMi56Iw8mshqmP+W9AMGuFWvp2r5MV2Jf/yn059SKXkU4Onw3ldr19+mcWbMxR7o3mCHTHn0JDB+MnzwoPy5Nze+k/BF+8P4FKFIKWb+ahDQO7RgaAum2aTskOA6Q3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NC1n05GK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f92f3db6fso132542066b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772111504; x=1772716304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jqX19aDR1PCz0IO4VxlMpvKqSC9cfQfLdsBYQBVkyw=;
        b=NC1n05GKgRjeMqSAMaNptOEI6JpKCDmRZk+++IUELVZhgu6xsz8PKIQOYsYTLt3u5Q
         oalbvFnMkJCtI4sodKBCGvi7st/Xkoff01cXo6vqIxs//Aqq3XayCUkAm6jhTv3ZjF0y
         Iw1su11pyePz3Kyt5l4buZtFZ5uhIR2JVElQK8rUGzwHGSltnGtCBJLPf0viBnDie7QZ
         hzHUb3pqs2WVCkUVo0jwP7HokXeUn+Jwm+5nW1+MQawyt+7pYECSr2SqiMCHkYd5Xn7a
         7iHNhe3JqqVy0bj6qZ+RgIjXyiP6ki6WYt473y9D1mnxZBF80lb9cws5Hc6Mjv3TU+uT
         IEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111504; x=1772716304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+jqX19aDR1PCz0IO4VxlMpvKqSC9cfQfLdsBYQBVkyw=;
        b=ZAvxNccjXDWBxUKp1nyWxRlMqufK6xGtrrdPuUqBISmhldi+cbnSMpw+Z1Ffw7Psh0
         4g7NAx9kg0T60uW/LiIBFDE+50DMVkNSfTn9XEGmEWAQ1XQZAMzss9K8R8WD3kL9MDkM
         VqzYcG8VORat+N4aN0oyU7u/0+9di8Ev6R7qGK5u3J9ctCIa/uyHKmIcHgtYI8+pymJf
         YUs4+XMzdx/DoDnOyYZ4e2t9ZKXGS0stgxu3lJRIaDxVI2A07ieMlnqnqEz9u3b70ll7
         Y/i89p6PugCnOjR5UIo8ySSg1V7xwJtBDjNeVwyvhN3svJ0DgYQ5Z9plt/YATXWnJLR7
         573A==
X-Forwarded-Encrypted: i=1; AJvYcCXDheVxvef1dXIVENQRZugfuiQ/rSM1BVONsc9Qo42anLRJh/ghdiFaCf/cHtlrxLvFwAksdDzDng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/tI+fvE/s+SQhfTY+JBSWm/GLMHPVFXhk85AhuZw3PIZUT/6
	FDXSjA8J6OEkQCBfd5Vahdw06VO9Vc2DdHGi+MEabz7Xwk30IiRqe2nmpdypzh4ELZk=
X-Gm-Gg: ATEYQzzBIC6WMAJy7tKKyzdfbLu1eXUrOpv/Vge1G2viRaU9Os9cdG4/oS4thHe0HL+
	DgG6SqlDWy3x2mCB17UEnNu4GXoZzPS7zMyW8Y3AyKWLFY/u4IOTHNbWv/iSq+QxSEk5zCBa/YV
	8ngwAQspkx69WlmQ+Buoc/BBxvx6Etn10cKl6T+HhxQHIMPTYc0AN1olcJ4nidaKxwuXTqB5ykH
	DKbnfqVda038ec8rzxaK5XNV2orjWZJMeuEGvSC9p55J7LMK1LaxJ1vs5drnyGoxtZm+tjfD5CZ
	MNDGiMO+62Geo3yTR+4h3Jn2szorW3+yrUy2n0ZJIKGJ108eBGSoQeun0Ax313M13CgBxUsIDnb
	bB8WKhxvuduzA9gp/8mn7PniZ0t9kF6avtFaNhouSJRsKEoZXN4uOJNbYSWWTy3q6M1oVC5C/Gv
	pL3cOE8Nv4Mone/MwRW9X90SdZx+Ci/2ZyDC17h4YgLO4vXu6L+x+6+GByf77MbvFLHDl2H3i4Z
	iSK7Zp82UPXHRombA==
X-Received: by 2002:a17:907:9445:b0:b93:60a3:8a47 with SMTP id a640c23a62f3a-b9360a38b06mr95155166b.45.1772111504172;
        Thu, 26 Feb 2026 05:11:44 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm55125866b.26.2026.02.26.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:43 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 26 Feb 2026 13:11:44 +0000
Subject: [PATCH 10/11] power: supply: max17042: max17042: consider task
 period (max77759)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-max77759-fg-v1-10-ff0a08a70a9f@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43253-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C62361A65CE
X-Rspamd-Action: no action

Several (register) values reported by the fuel gauge depend on its
internal task period and it needs to be taken into account when
calculating results. All relevant example formulas in the data sheet
assume the default task period (of 5760) and final results need to be
adjusted based on the task period in effect.

Update the code as and where necessary.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
While I do believe this should apply to all devices supported by this
driver, given the register description in max17042_battery.h, I've made
this change specific to max77759, as I have no way to confirm this
works as expected on those. I've found a data sheet for
max17047/max17050 online, which does describe the relevant register
0x3c as 'reserved'.
---
 drivers/power/supply/max17042_battery.c | 20 ++++++++++++++++++++
 include/linux/power/max17042_battery.h  |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 44626abdab34..89909b140cf9 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -61,6 +61,7 @@ struct max17042_chip {
 	struct work_struct work;
 	int    init_complete;
 	int    irq;
+	int    task_period;
 };
 
 static enum power_supply_property max17042_battery_props[] = {
@@ -335,6 +336,8 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * 5000000ll;
+		data64 *= chip->task_period;
+		do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -344,6 +347,8 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * 5000000ll;
+		data64 *= chip->task_period;
+		do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -353,6 +358,8 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * 5000000ll;
+		data64 *= chip->task_period;
+		do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -362,6 +369,8 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = sign_extend64(data, 15) * 5000000ll;
+		data64 *= chip->task_period;
+		data64 = div_s64(data64, MAX17042_DEFAULT_TASK_PERIOD);
 		val->intval = div_s64(data64, chip->pdata->r_sns);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
@@ -1146,6 +1155,17 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
+	chip->task_period = MAX17042_DEFAULT_TASK_PERIOD;
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX77759) {
+		ret = regmap_read(chip->regmap, MAX17042_TaskPeriod, &val);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to read task period\n");
+		chip->task_period = val;
+	}
+	dev_dbg(dev, "task period: %#.4x (%d)\n", chip->task_period,
+		chip->task_period);
+
 	chip->battery = devm_power_supply_register(dev, max17042_desc,
 						   &psy_cfg);
 	if (IS_ERR(chip->battery))
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 76b85ad3cf48..c82043414c88 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -17,6 +17,7 @@
 #define MAX17042_DEFAULT_VMAX		(4500) /* LiHV cell max */
 #define MAX17042_DEFAULT_TEMP_MIN	(0)    /* For sys without temp sensor */
 #define MAX17042_DEFAULT_TEMP_MAX	(700)  /* 70 degrees Celcius */
+#define MAX17042_DEFAULT_TASK_PERIOD	(5760)
 
 /* Consider RepCap which is less then 10 units below FullCAP full */
 #define MAX17042_FULL_THRESHOLD		10

-- 
2.53.0.414.gf7e9f6c205-goog


