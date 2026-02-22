Return-Path: <linux-pm+bounces-42974-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLhTGQACm2nPpgMAu9opvQ
	(envelope-from <linux-pm+bounces-42974-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 048BF16F2AE
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05F64302001F
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B322ACEB;
	Sun, 22 Feb 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=abscue.de header.i=@abscue.de header.b="Oqig/cKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF934227BB5;
	Sun, 22 Feb 2026 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766226; cv=none; b=MH8xBGQwo25krsKtw6m/usZHXvcKGmLtzskSFVb8yGnwulJywiw7kJuKWEYA3O4u/YRjgd1jDGYo5N2Tl/C2Oe8A+6bfYhODJDDsmmR0jsZfelU5BiIeG7t5hvzNdskQ8AJhex4hRdwLDSmlux4M6z/iPoUsBKS4uphbLqU0w8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766226; c=relaxed/simple;
	bh=Qy/ZzJzXlxJG0Kd8Vu8wKqaecC5eRWxDQXJ2vAMO9nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhWJIkMQVmmu3wqw9BEBBj0A7CsYu7VIn52o0OCNB+bDEqrnQ+DIFs1H2sQ8Eam5x2qGudFiAUJ0JdRA9c+ijVMhHQ2ki2hwlzB5NA9cNoOgX+aGnYu+TcNYP9jmNgZSTv0sWjAWBaGxJTKc/9Mpjvets9qJ+0QBe4uinQvrcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=fail (0-bit key) header.d=abscue.de header.i=@abscue.de header.b=Oqig/cKD reason="key not found in DNS"; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde0:3300:edee:770f:8e03:a80])
	by srv01.abscue.de (Postfix) with ESMTPSA id 192F11C01BA;
	Sun, 22 Feb 2026 14:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1771766217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNJ1QLnEBZKWZgNkgyks8YAmNrDo9kh16AdJax9ymZU=;
	b=Oqig/cKD9VWziUzGKIuAsSRVA7vg9DdO51yvdiDIMNXZealdg75QdShXPQ92KjmetemDGy
	Y4X4sALD963xv79RVrp/NhW915wyGLdiOsCI+GhpZlzNOIvzb5nYdQIcDVciYyjoOE6G7t
	8dHfvBeZ5g+ZZwaNG/8+FXdKR6Ue845Z3pUxziwGoytY45mWIfxxP5oxbdJ+IP2WRxwNnx
	PgiF+Oc/ENUSyYH1sQE1znZB/tognsi/tK6CW8ry/EfnfrKP1tJ1kp2nphGqKdFAMICTP+
	vvM1V+DndRpG3ky7qmq2/RxOspyb6OUfNv0ISn4wpLiYiMupmgsCSlc+mpuYDQ==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sun, 22 Feb 2026 14:16:48 +0100
Subject: [PATCH 4/6] mfd: sprd-sc27xx: Switch to devm_mfd_add_devices()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260222-sc27xx-mfd-cells-v1-4-69526fe74c77@abscue.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42974-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[abscue.de];
	FREEMAIL_TO(0.00)[bootlin.com,kernel.org,gmail.com,linux.alibaba.com];
	R_DKIM_PERMFAIL(0.00)[abscue.de:s=dkim];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[abscue.de:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[otto.pflueger@abscue.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.580];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,abscue.de:mid,abscue.de:email]
X-Rspamd-Queue-Id: 048BF16F2AE
X-Rspamd-Action: no action

To allow instantiating subdevices such as the regulator and poweroff
devices that do not have corresponding device tree nodes with a
"compatible" property, use devm_mfd_add_devices() with MFD cells instead
of devm_of_platform_populate(). Since different PMICs in the SC27xx
series contain different components, use separate MFD cell tables for
each PMIC model. Define cells for all components that have upstream
drivers at this point.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/mfd/sprd-sc27xx-spi.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index d6b4350779e6..57941bec4c2e 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -48,6 +48,31 @@ struct sprd_pmic_data {
 	u32 irq_base;
 	u32 num_irqs;
 	u32 charger_det;
+	const struct mfd_cell *cells;
+	int num_cells;
+};
+
+static const struct mfd_cell sc2730_devices[] = {
+	MFD_CELL_OF("sc2730-adc", NULL, NULL, 0, 0, "sprd,sc2730-adc"),
+	MFD_CELL_OF("sc2730-bltc", NULL, NULL, 0, 0, "sprd,sc2730-bltc"),
+	MFD_CELL_OF("sc2730-efuse", NULL, NULL, 0, 0, "sprd,sc2730-efuse"),
+	MFD_CELL_OF("sc2730-eic", NULL, NULL, 0, 0, "sprd,sc2730-eic"),
+	MFD_CELL_OF("sc2730-fgu", NULL, NULL, 0, 0, "sprd,sc2730-fgu"),
+	MFD_CELL_OF("sc2730-rtc", NULL, NULL, 0, 0, "sprd,sc2730-rtc"),
+	MFD_CELL_OF("sc2730-vibrator", NULL, NULL, 0, 0, "sprd,sc2730-vibrator"),
+};
+
+static const struct mfd_cell sc2731_devices[] = {
+	MFD_CELL_OF("sc2731-adc", NULL, NULL, 0, 0, "sprd,sc2731-adc"),
+	MFD_CELL_OF("sc2731-bltc", NULL, NULL, 0, 0, "sprd,sc2731-bltc"),
+	MFD_CELL_OF("sc2731-charger", NULL, NULL, 0, 0, "sprd,sc2731-charger"),
+	MFD_CELL_OF("sc2731-efuse", NULL, NULL, 0, 0, "sprd,sc2731-efuse"),
+	MFD_CELL_OF("sc2731-eic", NULL, NULL, 0, 0, "sprd,sc2731-eic"),
+	MFD_CELL_OF("sc2731-fgu", NULL, NULL, 0, 0, "sprd,sc2731-fgu"),
+	MFD_CELL_NAME("sc2731-poweroff"),
+	MFD_CELL_NAME("sc2731-regulator"),
+	MFD_CELL_OF("sc2731-rtc", NULL, NULL, 0, 0, "sprd,sc2731-rtc"),
+	MFD_CELL_OF("sc2731-vibrator", NULL, NULL, 0, 0, "sprd,sc2731-vibrator"),
 };
 
 /*
@@ -59,12 +84,16 @@ static const struct sprd_pmic_data sc2730_data = {
 	.irq_base = SPRD_SC2730_IRQ_BASE,
 	.num_irqs = SPRD_SC2730_IRQ_NUMS,
 	.charger_det = SPRD_SC2730_CHG_DET,
+	.cells = sc2730_devices,
+	.num_cells = ARRAY_SIZE(sc2730_devices),
 };
 
 static const struct sprd_pmic_data sc2731_data = {
 	.irq_base = SPRD_SC2731_IRQ_BASE,
 	.num_irqs = SPRD_SC2731_IRQ_NUMS,
 	.charger_det = SPRD_SC2731_CHG_DET,
+	.cells = sc2731_devices,
+	.num_cells = ARRAY_SIZE(sc2731_devices),
 };
 
 enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
@@ -204,7 +233,9 @@ static int sprd_pmic_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = devm_of_platform_populate(&spi->dev);
+	ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_AUTO,
+				   pdata->cells, pdata->num_cells, NULL, 0,
+				   regmap_irq_get_domain(ddata->irq_data));
 	if (ret) {
 		dev_err(&spi->dev, "Failed to populate sub-devices %d\n", ret);
 		return ret;

-- 
2.51.0


