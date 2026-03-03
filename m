Return-Path: <linux-pm+bounces-43511-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPnPBvb/pmk7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43511-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:36:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD41F2C05
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D878304A7E8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5480E495536;
	Tue,  3 Mar 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="itZwBtvw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF49495500
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551999; cv=none; b=igrQAacbXFF81Ddpb/+RUfic0j5CJrBrKnkm/P9Jyj5Lo3OfeRlnllf70FtlmfO2hLV3uAAKg4Il6JNLbavYWHZC0aRkItW7WTbCqhPiYAL2DAIgwKaO72FTgzJDCBZOkaEHrk9CbyP7m0iG271j7yCHlsuOEqsQ0aU2Xj7zZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551999; c=relaxed/simple;
	bh=rZeSH+p/sWb94+YtWuBoX7zwjk1MlkPbjBLWjAkhzPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KHvGJ4suSaX/nOT+nQ3p0YmDsq4bO28b6TgvHdMgPY9hWju/U/6iDFKKpTXigvQ4UXqf6TLxx19oo5ay4wbAE7/FJvfu7uuZ9Q84tOYWYBbEX+gy6jM58T5Xop/TGSGDk4gH5zxK0gorEnoZyiYDmCBMWdu21KWzLHJC9J+FukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=itZwBtvw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-436e8758b91so3807468f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772551995; x=1773156795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8FV20nY94XdgsSpk3nNKgaUktiutL3Fj9XNodWc9Os=;
        b=itZwBtvww5qi7F4KxnyEbu42CJ8yOLlHtb4q+fHda0i3MivUngVPJAaNxrseMTsTRz
         RsNxa9vx1nrn5995xbjzIgrNdOVxTXJR0XxKLqSOEBJmT92AgKEeId3NigNj3ohoMeHl
         eM+Rpa7oy7Nm6FC7MWJTgPoysiglM+nsJ/4Vp3H1sdGxNY4wWctPg91yNhpzTjZEescg
         BE+Y7/GxCPW2oApGdTqDUZA60edRWma5V77XElzkolhhxKxFmkoJ52jPsKpm4zx/1UcN
         uX+F/tIzgXPI5Urgsboh+XbiwManZl5bZnt9HqkWg3wk255kKA7WpuN/u9DDQD6jIo4f
         WqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551995; x=1773156795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I8FV20nY94XdgsSpk3nNKgaUktiutL3Fj9XNodWc9Os=;
        b=HwQW9ESHRb37toDRCMcWwT/IRRCmXQDu3qbfVZPov7LLHEXzu5ukl07xVNXdT9k9Bb
         5dULggVLQJBI2Vmb4G//1u80oYeCEqRKAXBGRnv5phV779qdyLaeMEV8HTKUyu+1NC2W
         AkNmzXyRbM7+lsLduKwoVSNekk6D1NpnTi7ikQ136Kk/lXN5BA0ejutJna9qMEKO8HAj
         iK4F+zAJ18psrgowDPAmXgt7TUJ2SxqZ+J607qRLSPnRCh3lDBSVgEd8AyxgXUJYm8Mv
         V+qNwJcBQFBzfKFo4VQVXF1fmN0LJO8yYyj64aKNQBNCNCQ0xf/VMRu4jlh+gObqD7ri
         bTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFuG+Mpzw89I0QimTUHlZAr/BCMKvfK44huWFmaKDYuev2gBP1KiaUu7Ju+sxnd8T1T38ohmyX1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzm0c6hvh0ngtd1x9uUBb+PmuiAsHiq+cJOcbtQIds62WhcQrz
	jV2iiFGzn4B+e1WBX3hazIK3E/Qa8iSzIwWAVy992rG5l7fMqeJhToY+OG4xbEAaktg=
X-Gm-Gg: ATEYQzxSjCfSqb7Dg8ft45h4GJVWAqWdcPmyVWpDE9z3rrIjb41JAAElqjZgs6+hjk9
	2hcbRMDjlTnTSgbFhueGPcLr4mTtFBI70JgNcdVac31KTFNOCz1WqxYEeiHTgBY65lEDaorBECr
	uRw/ssDksI3jPsX8AXsIvQrZTE5EbTd6Wt81A+ioLq1rVZ+oJwovAcdAfCQKRobPtf88tY7wMmO
	tExJ2fRHdwAHj0kYF7LsrcEFxAd8PbtP/3sRx5okIYG8TlbKR3xLx8IkoTd8+fiYLEO07WjxloI
	eMB1oo5p30c7NKCYCfC+2fMA9gpKg9gMRZIJMr77xsxUc4el7ouUgVNUJN+08K0ltSoRrxFfAQP
	ZEegKD4+xoIeiW0lVoXqgI6m0RrA+UOv5ZjY68qtiY5j+DEz2Qn4zCmHDZcJRycKTBlLElpuJX2
	Q0kqCSkoHqU0UG1CJIixUw+qSnIWHGMzSbRReG3Tzx7/64CXOoy/E74wV4PKbmpT98Ygg7529xv
	Og=
X-Received: by 2002:a05:6000:4009:b0:439:b4dc:1e20 with SMTP id ffacd0b85a97d-439b4dc2140mr14752521f8f.50.1772551995515;
        Tue, 03 Mar 2026 07:33:15 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:15 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:52 +0400
Subject: [PATCH 07/11] power: supply: bq257xx: Consistently use indirect
 get/set helpers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-7-e6e5e0033458@flipper.net>
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
In-Reply-To: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364; i=alchark@flipper.net;
 h=from:subject:message-id; bh=rZeSH+p/sWb94+YtWuBoX7zwjk1MlkPbjBLWjAkhzPY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+69mqXngfuiPb/FH0y/uX75w/RRvA75267Ovm1vbu
 rawHXm4r2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTUMdYxYuDiFICp3v2L4b+38RUfhkfpP3tabvRuDxS58S7I29fUwPVH7OOvpmou1S8YGS4uvB1
 tsULRr2hy6OxS11Xbp2uyK8+0b9qy8qzi9wVmnXwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: CEBD41F2C05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43511-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,flipper.net:dkim,flipper.net:email,flipper.net:mid]
X-Rspamd-Action: no action

Move the remaining get/set helper functions to indirect calls via the
per-chip bq257xx_chip_info struct.

This improves the consistency of the code and prepares the driver to
support multiple chip variants with different register layouts and bit
definitions.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index e14dd16f9d08..deb60a9bd222 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -30,9 +30,15 @@ struct bq257xx_chip_info {
 	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
 	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
 	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
+	int (*bq257xx_get_ichg)(struct bq257xx_chg *pdata, int *intval);
 	int (*bq257xx_set_ichg)(struct bq257xx_chg *pdata, int ichg);
+	int (*bq257xx_get_vbatreg)(struct bq257xx_chg *pdata, int *intval);
 	int (*bq257xx_set_vbatreg)(struct bq257xx_chg *pdata, int vbatreg);
+	int (*bq257xx_get_iindpm)(struct bq257xx_chg *pdata, int *intval);
 	int (*bq257xx_set_iindpm)(struct bq257xx_chg *pdata, int iindpm);
+	int (*bq257xx_get_cur)(struct bq257xx_chg *pdata, int *intval);
+	int (*bq257xx_get_vbat)(struct bq257xx_chg *pdata, int *intval);
+	int (*bq257xx_get_min_vsys)(struct bq257xx_chg *pdata, int *intval);
 };
 
 /**
@@ -489,22 +495,22 @@ static int bq257xx_get_charger_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		return bq25703_get_iindpm(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_iindpm(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-		return bq25703_get_chrg_volt(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_vbatreg(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		return bq25703_get_cur(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_cur(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		return bq25703_get_vbat(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_vbat(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		return bq25703_get_ichg_cur(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_ichg(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
-		return bq25703_get_min_vsys(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_min_vsys(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		val->intval = pdata->usb_type;
@@ -632,9 +638,15 @@ static const struct bq257xx_chip_info bq25703_chip_info = {
 		.bq257xx_hw_init = &bq25703_hw_init,
 		.bq257xx_hw_shutdown = &bq25703_hw_shutdown,
 		.bq257xx_get_state = &bq25703_get_state,
+		.bq257xx_get_ichg = &bq25703_get_ichg_cur,
 		.bq257xx_set_ichg = &bq25703_set_ichg_cur,
+		.bq257xx_get_vbatreg = &bq25703_get_chrg_volt,
 		.bq257xx_set_vbatreg = &bq25703_set_chrg_volt,
+		.bq257xx_get_iindpm = &bq25703_get_iindpm,
 		.bq257xx_set_iindpm = &bq25703_set_iindpm,
+		.bq257xx_get_cur = &bq25703_get_cur,
+		.bq257xx_get_vbat = &bq25703_get_vbat,
+		.bq257xx_get_min_vsys = &bq25703_get_min_vsys,
 };
 
 /**

-- 
2.52.0


