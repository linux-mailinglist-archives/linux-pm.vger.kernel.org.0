Return-Path: <linux-pm+bounces-42977-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLEUKWsCm2nPpgMAu9opvQ
	(envelope-from <linux-pm+bounces-42977-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:19:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3ED16F312
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878F830432C9
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4696281525;
	Sun, 22 Feb 2026 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=abscue.de header.i=@abscue.de header.b="sqjpUWst"
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF622773CA;
	Sun, 22 Feb 2026 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766228; cv=none; b=FXjPYqyQ+qS+KfPa9+mDxRGuwVnbeSeM8uBl7g97THFtsBRq4nahASLBn8ZgKXmZNwAFMRRO4GtdM9J/WpwqfeuYu0SsqVWXPXjBKXeYZei2NYTuOEBAd824R3uiqjVGwEjAPhny7I/2pNOyvpai/QChrmD+JcA8c/Tbq6ysK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766228; c=relaxed/simple;
	bh=+iiQLnW9mFrlM8Se0IaHaqflFlLXdAb5S9n2UY3+Ri0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gi6C7EPrdvgY8mlgOal6T7lk/b8ChqPP5Ej18LhxPj6yfKtaElr2c8mjoy4dG1qmzA6Mb9L46UDtZMDPq5uWwUsJ2HlEQEfpwJmLASof9BE9SmWHOJdB/eIXuF0FPWYa83rxrzEu6KQmskP55h9v2z4stRH0lC6up9BtpLQ3CMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=fail (0-bit key) header.d=abscue.de header.i=@abscue.de header.b=sqjpUWst reason="key not found in DNS"; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde0:3300:edee:770f:8e03:a80])
	by srv01.abscue.de (Postfix) with ESMTPSA id 6B3871C01BC;
	Sun, 22 Feb 2026 14:16:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1771766218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WZzDsqMTn4PgLVYK/X6oARz+antdMzU7A7JyMHz9eM=;
	b=sqjpUWstGkAXS9lSW54pvtd8Hx410gzYAnwn7ngJyHoAlmwPB0irmOUoMKIolkwjQnphOl
	43HvLZ9RDnQD4j8U7hu9CV82z73a32NAunJyrh9yzK0FCkU/UcaK94mbqzvQm9P2okV8gY
	uhXkxH4/4PYzFjvCtAF20dArUdTrB5vOuLGtnn5lOg3/ZnztmN+zFoN3FeiQyK1tM5VCk8
	+7izwuTo6crcY/OfkG66k8s5GoTrPayWix+HshRLE8VKgpMd0gutYZ9VO8nXBamdz6iBKx
	YWEuPLPhx3sEA+Xlg/UU7HRFOTWpuLnZZz26jUqgsGFJYml6R4fHAjwVdW98Lw==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sun, 22 Feb 2026 14:16:50 +0100
Subject: [PATCH 6/6] regulator: sc2731: Add platform_device_id table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260222-sc27xx-mfd-cells-v1-6-69526fe74c77@abscue.de>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42977-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[abscue.de];
	FREEMAIL_TO(0.00)[bootlin.com,kernel.org,gmail.com,linux.alibaba.com];
	R_DKIM_PERMFAIL(0.00)[abscue.de:s=dkim];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[abscue.de:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[otto.pflueger@abscue.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.548];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,abscue.de:mid,abscue.de:email,config.dev:url]
X-Rspamd-Queue-Id: 4B3ED16F312
X-Rspamd-Action: no action

Make the regulator driver for the SC2731 PMIC probe automatically. Using
a platform_device_id table instead of DT compatible matching avoids the
need for a separate compatible property in the "regulators" node, which
simplifies the DT bindings and makes the parent MFD device responsible
for selecting the correct regulator driver for the PMIC.

However, this means that the regulator device is not automatically
associated with the "regulators" node. Tell the regulator core to
perform device tree lookups using the parent MFD device instead of
the regulator sub-device and set the .regulators_node member in all
regulator definitions so that the "regulators" sub-node is used.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/regulator/sc2731-regulator.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/sc2731-regulator.c b/drivers/regulator/sc2731-regulator.c
index 5447e1a47d15..93c8156c5110 100644
--- a/drivers/regulator/sc2731-regulator.c
+++ b/drivers/regulator/sc2731-regulator.c
@@ -131,6 +131,7 @@ static const struct regulator_ops sc2731_regu_linear_ops = {
 			  vstep, vmin, vmax) {			\
 	.name			= #_id,				\
 	.of_match		= of_match_ptr(#_id),		\
+	.regulators_node	= of_match_ptr("regulators"),	\
 	.ops			= &sc2731_regu_linear_ops,	\
 	.type			= REGULATOR_VOLTAGE,		\
 	.id			= SC2731_##_id,			\
@@ -226,7 +227,7 @@ static int sc2731_regulator_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	config.dev = &pdev->dev;
+	config.dev = pdev->dev.parent;
 	config.regmap = regmap;
 
 	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
@@ -242,12 +243,19 @@ static int sc2731_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id sc2731_regulator_id_table[] = {
+	{ "sc2731-regulator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sc2731_regulator_id_table);
+
 static struct platform_driver sc2731_regulator_driver = {
 	.driver = {
 		.name = "sc27xx-regulator",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sc2731_regulator_probe,
+	.id_table = sc2731_regulator_id_table,
 };
 
 module_platform_driver(sc2731_regulator_driver);

-- 
2.51.0


