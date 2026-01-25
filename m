Return-Path: <linux-pm+bounces-41431-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP41AuxqdmkuQgEAu9opvQ
	(envelope-from <linux-pm+bounces-41431-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:11:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36E81FEB
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EAF8303FF07
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 19:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661C92F28E3;
	Sun, 25 Jan 2026 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="V7FTF07r"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E92F28FB;
	Sun, 25 Jan 2026 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368111; cv=none; b=nSRUXhzrnr3S7M+wlTdLiqXKpdmngVxvp2n/PyzSjIP9tAexCAIqKL/jsekrOpfQzXEizv6wJC6Zglayx5RYlOziGZJClZ1urJRHHkWEzOd1lRKbkvcTchwUVbbkErRC+b3w3SALYpfCpd5qVG4SZ3f2oftz9Z2dT/FoLl2rJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368111; c=relaxed/simple;
	bh=gTxPQVGxuD03CVONg3AGqFWFgv4PY5jrCFnImUW+i0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btJLQngdiQF2ylbUtxyBOmwijmfBzYuINBBprCrGTTdW4QjXvO83rYycg/r8gaj7MlZpTYVH9ebkvzpHqhyNW3REfXBHx9wmnhIl7bXthYu8i05y/wvt1H9MKUmqhCBV+r6fvKN+XfLpWiPg6V0gce7w03OwFxApzTeJsEcauig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=V7FTF07r; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 546A427E78;
	Sun, 25 Jan 2026 20:08:28 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L08hPs4BWpaQ; Sun, 25 Jan 2026 20:08:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368107; bh=gTxPQVGxuD03CVONg3AGqFWFgv4PY5jrCFnImUW+i0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V7FTF07rWMEinH/YwFmAT6Lr1thNB6MNJ8uJg6sZEeHj5f8txZ00Ee/rNSyvcqiPJ
	 n5u6aV9Cz0sUSxmB2jztGWQe5SvsUq9pDE0KLmQvzLrKiucbwWI9BG4fD4boMSEl77
	 2xeG8ZRgu1BXIrWcSUSNJt/xj4vA5a+W1ToBi30SOXfrgH4cgSmwJozSBS13vX/AZm
	 O4SORGObRYWn9bfuSDPhQXKQVpIO7WE/lWViEZ15ehqz+Ig05kBTWHSUlsKHjm2rsl
	 5BKltQ2rkX8cAIQv/eKNB340omSvPFaWyWBEge3FqIJOEXOGKnszbaaFlFTDM/H/0k
	 wcGNLwClVS3Mw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 00:37:14 +0530
Subject: [PATCH v2 07/12] mfd: sec: store hardware revision in sec_pmic_dev
 and add S2MU005 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-pmic-v2-7-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
In-Reply-To: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41431-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6C36E81FEB
X-Rspamd-Action: no action

The device revision matters in cases when in some PMICs, the correct
register offsets very in different revisions. Instead of just debug
printing the value, store it in the driver data struct.

Unlike other devices, S2MU005 has its hardware revision ID in register
offset 0x73. Allow handling different devices and add support for S2MU005.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mfd/sec-common.c         | 41 ++++++++++++++++++++++++++++++----------
 include/linux/mfd/samsung/core.h |  1 +
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index bc2a1f2c6dc7a..069a1ba9aa1f1 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -16,6 +16,7 @@
 #include <linux/mfd/samsung/irq.h>
 #include <linux/mfd/samsung/s2mps11.h>
 #include <linux/mfd/samsung/s2mps13.h>
+#include <linux/mfd/samsung/s2mu005.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm.h>
@@ -111,17 +112,38 @@ static const struct mfd_cell s2mu005_devs[] = {
 	MFD_CELL_OF("s2mu005-rgb", NULL, NULL, 0, 0, "samsung,s2mu005-rgb"),
 };
 
-static void sec_pmic_dump_rev(struct sec_pmic_dev *sec_pmic)
+static int sec_pmic_store_rev(struct sec_pmic_dev *sec_pmic)
 {
-	unsigned int val;
+	unsigned int reg, mask, shift;
+	int ret;
 
-	/* For s2mpg1x, the revision is in a different regmap */
-	if (sec_pmic->device_type == S2MPG10)
-		return;
+	switch (sec_pmic->device_type) {
+	case S2MPG10:
+		/* For s2mpg1x, the revision is in a different regmap */
+		return 0;
+	case S2MU005:
+		reg = S2MU005_REG_ID;
+		mask = S2MU005_ID_MASK;
+		shift = S2MU005_ID_SHIFT;
+		break;
+	default:
+		/* For other device types, the REG_ID is always the first register. */
+		reg = S2MPS11_REG_ID;
+		mask = ~0;
+		shift = 0;
+	}
+
+	ret = regmap_read(sec_pmic->regmap_pmic, reg, &sec_pmic->revision);
+	if (ret) {
+		dev_err(sec_pmic->dev, "Failed to read PMIC revision (%d)\n", ret);
+		return ret;
+	}
+
+	sec_pmic->revision &= mask;
+	sec_pmic->revision >>= shift;
 
-	/* For each device type, the REG_ID is always the first register */
-	if (!regmap_read(sec_pmic->regmap_pmic, S2MPS11_REG_ID, &val))
-		dev_dbg(sec_pmic->dev, "Revision: 0x%x\n", val);
+	dev_dbg(sec_pmic->dev, "Revision: 0x%x\n", sec_pmic->revision);
+	return 0;
 }
 
 static void sec_pmic_configure(struct sec_pmic_dev *sec_pmic)
@@ -262,9 +284,8 @@ int sec_pmic_probe(struct device *dev, int device_type, unsigned int irq,
 		return ret;
 
 	sec_pmic_configure(sec_pmic);
-	sec_pmic_dump_rev(sec_pmic);
 
-	return ret;
+	return sec_pmic_store_rev(sec_pmic);
 }
 EXPORT_SYMBOL_GPL(sec_pmic_probe);
 
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index 43e0c5e55f5d3..56aa33d7e3d60 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -70,6 +70,7 @@ struct sec_pmic_dev {
 
 	int device_type;
 	int irq;
+	unsigned int revision;
 };
 
 struct sec_platform_data {

-- 
2.52.0


