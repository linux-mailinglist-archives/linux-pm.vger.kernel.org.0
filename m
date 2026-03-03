Return-Path: <linux-pm+bounces-43510-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIvWGuP/pmk7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43510-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:36:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F59B1F2BFD
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A368B3064F28
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152DA494A16;
	Tue,  3 Mar 2026 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Ua8GBkxl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE6494A0B
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551997; cv=none; b=bwNPJyaBX/GTmuua/9Xwke+pbOvE2jOpS3dkMeqRgONMo2j25zn0w8lh2iqpttFT3fC/QbQAyzcRaLXSXT5lbqg8RNQ9Xj/4F/dnM7Ncq/VNp79N4Ot/8MpkzYawYuRDiGHLmu/biSmQfHlRIRSP9pMHk669NKotzN0kyHBo+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551997; c=relaxed/simple;
	bh=rI3qlTJ6sVlqcAKmwgpX1F1kJ2fiqBBvb2/yVu30Rak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ueJp78nX0498xk3Y1Jnn4d02+yzN0p+J9DM3BsyhlzxdEffT3VblSGZPnrXbydfyI/gTfTwldEOpFmazLHRawpa4A6x4EfTFG+O3pCcRzT3UuRWeCFSQk4mBt7BIjiOpVUn6tHIJIVUc/GU/IXk4eWjlBqW/BtkwelG6N1P8FCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Ua8GBkxl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439ac15f35fso2944066f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772551993; x=1773156793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNXZcw1aJqSKR83mcQk2RSs9v+AW3Tva6N8ZbjfBrlI=;
        b=Ua8GBkxlESGiY2A5Y7GFL9vHLTj5ov1xkOeQZ6jjS/ISydLjTNt/uH2E2MPginOOsb
         VFn6z2gOUxQjQNhIWwfANKncXfphUr+fR9p0MUAWvMOzvMHBHOValrTpJYVI+iOk68pe
         G0kM4Oe2hggUGvPeB+d3UDk+i8uWVGgWNfF0rFdKRC/8+v7Ga0CtGhGrn3pZWfq1zibs
         aULhHgHqkSFEBFLM7RXzw0IVUyBv0IP0JRXKPAFHWWyqI5Ws9eN4ApJznEu5VLmy79S1
         87BIEe6AmbtsLHj0uVbZroaWuWnYpNgXev8xknyHqeFZCPZsjMFOoG67EdU3e/vpMz6q
         jPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551993; x=1773156793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UNXZcw1aJqSKR83mcQk2RSs9v+AW3Tva6N8ZbjfBrlI=;
        b=ZHR9YnK8JA0ROJqJPsLkZW65ImEjFNONpkvLvayCYrY9Kz/9bqzQ5GbweGsCk1Rcqj
         eiEsRpe9eAef/Ap/kf06/mu46qjoPoXRZHVJr5JXV6xDIz+Sdo5gxYLhohunj5+gq/yc
         mfflNVDAq7rVjN4b3zobD1o4o2Q2czFPuhnL0dIMTPIWBo7+PbDPslWPM4TwLHP2aq9E
         s98cqDMo6zigzh9cDwG/fEfBPc6xcKdGTgVGQAar10zl8gu2keFpLF0h0hCiDGBbQMcb
         C8f4KKRgFnZ6+6qn61vBiKYEESqjNlczMyRiqCz01XXuWdDo2ZWRawn8N9Cbb5JeTIsb
         tSVg==
X-Forwarded-Encrypted: i=1; AJvYcCVRDI5frB4eXU2VkGaTwOZ/x/u66uaBzKagHjArgvMBTgEAUnqkeWUjvC+pDDfc0ZmW80CIZztOtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0bX3HdqLDov/tUMlyjXqdPJW1gJmvU1gwGBJ27QK8YGyTPBz
	aAHigbPsVG02Db1WGaY/U4qxqg94SqVuC6A5Ks7jJSIfsH33JNBRGYubaNQ5KV5Itls=
X-Gm-Gg: ATEYQzxz65xbd5cd3vQAdwocr/siFgfWai3SmAqlV2Sc9MdxRpFzaZSULuHbCPAa8Vz
	0h8VQbLb/rP0/Uex2PLtqAcbSBuwpcsHLFqeRs4JvlFFkXrys7BKb6z85mHjBCOtn9EqL5qL5hI
	0KHSY2ILrcp0mQOIyoUJjI6t+Gx3YK6mkcJiw/CB+qYdjMvrQjZbNUahoxpPUTwnAnaoaq+EMYS
	o4TBA3dShf4LWuFhIRGtqMw0YIZT3UsAp35yyqrIKm6ZqRoUTQkMwWWA/h0WmfxwoE2fwjaVCBl
	0O6MlqForoT7j/7NnR0Nol1VWXB8AAen9ObzPni6RcqIr5nXS5BtVOz3zhL6rSQcKjf7pmHR12J
	DqRzBsIkDp35RTsOXRZKtQoC3rUhtRXAVKYR/KyhOPvipLJuhyETgalLF02VuigtWQ/wQWa1UVj
	30Hw0lFiqYE9AX69XnpaKvA0c3eHCAALkAPgRcHHRxPHb3fee9f2wD/VvTgQbb0JLvBNgXRq89k
	08=
X-Received: by 2002:a05:6000:4381:b0:439:be3b:ddb6 with SMTP id ffacd0b85a97d-439be3bde4dmr8169353f8f.59.1772551992921;
        Tue, 03 Mar 2026 07:33:12 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:12 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:51 +0400
Subject: [PATCH 06/11] power: supply: bq257xx: Make the default current
 limit a per-chip attribute
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-6-e6e5e0033458@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=alchark@flipper.net;
 h=from:subject:message-id; bh=rI3qlTJ6sVlqcAKmwgpX1F1kJ2fiqBBvb2/yVu30Rak=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+6+WcPX2hgVn/H6Eb4rPSA5m3rp10a3PHEyc34Qk2
 KN/2WXVdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDVr+sZ/orNDFWJSCvQnrvsaVt2ZFLVmkrxNfdzS+7wrllpFyigMovhr9StvqJ
 sec69CT26W/edfTaljSX7icS0XbvmterobH3jywIA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 0F59B1F2BFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43510-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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

Add a field for the default current limit to the bq257xx_info structure and
use it instead of the hardcoded value in the probe function.

This prepares the driver for allowing different electrical constraints for
different chip variants.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 7ca4ae610902..e14dd16f9d08 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -26,6 +26,7 @@ struct bq257xx_chg;
  * @bq257xx_set_iindpm: set maximum input current (in uA)
  */
 struct bq257xx_chip_info {
+	int default_iindpm_uA;
 	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
 	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
 	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
@@ -627,6 +628,7 @@ static const struct power_supply_desc bq257xx_power_supply_desc = {
 };
 
 static const struct bq257xx_chip_info bq25703_chip_info = {
+		.default_iindpm_uA = BQ25703_IINDPM_DEFAULT_UA,
 		.bq257xx_hw_init = &bq25703_hw_init,
 		.bq257xx_hw_shutdown = &bq25703_hw_shutdown,
 		.bq257xx_get_state = &bq25703_get_state,
@@ -675,7 +677,7 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
 				       "input-current-limit-microamp",
 				       &pdata->iindpm_max);
 	if (ret)
-		pdata->iindpm_max = BQ25703_IINDPM_DEFAULT_UA;
+		pdata->iindpm_max = pdata->chip->default_iindpm_uA;
 
 	return 0;
 }

-- 
2.52.0


