Return-Path: <linux-pm+bounces-43170-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACNINXv5nWmeSwQAu9opvQ
	(envelope-from <linux-pm+bounces-43170-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:18:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E1118BDA8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 622863047585
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50463ACA59;
	Tue, 24 Feb 2026 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="bBd2C17M"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A63AA1B5;
	Tue, 24 Feb 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960575; cv=none; b=cetw5XZGQvgbAV2QCFE4RAb423HgwyjVzDsMM/kuRkGpHvuiHZjweAycUBlv8Dxrut/p1Ll2T/vvZEcsReBPmD+9B82qg8tuh+cbhjUyooCwrCVtU5wS4+Q8MAVJnYPkuzsBW4/XUMN9qVz/McOZnsIK8xqxKBDQ5WL2JCevIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960575; c=relaxed/simple;
	bh=GNR5y1jtsQHUa1hbRRRrnxXYag6TtwuZRR6bHbrXcMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G00Zg52lnd+ArdEbwNIrLUfw2f5taXeGSSfyryaHA/b0ZS+zmGtUzzbQ35scPw0FMbYl2FKgszU2DKDCE8Ah8/rpptDFiTsUxXU5JjpflgDUOBRYVkDexy8Obc8cqZ4QdNCGTXwvnP8HfeVPn/i8drW9WaUjzTRw+/nM3BvOqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=bBd2C17M; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 412C7264BB;
	Tue, 24 Feb 2026 20:16:13 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vUyW9qIi-xKW; Tue, 24 Feb 2026 20:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960572; bh=GNR5y1jtsQHUa1hbRRRrnxXYag6TtwuZRR6bHbrXcMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bBd2C17MHJkiIMCv0RTvrQIHsPRVi7eBgsvXVk6SF2QVrQh7OvQepFZbEohN5/jBb
	 UWspsLdXOudWs1qT12EVTxUNWgRy6a+dchybD42HKK8rBRXn+6AceZVteCk/3fRP8s
	 bAtdR3libd6O7w5K2cic6jHEQrI6csjJ5GIxsQZ4S/rUWAMDJJGh/YdRPoIyQYfMfb
	 5dJrznp1da1cT3AcLKFdZsq9jOnBgerhl/qtfxnsOhE3/h8dFhCyOCV+Rr21lllWwm
	 u5mVLjpFb1FC8dgRBKMXXQxISF1G16xMbhrb970FvI6GMfG0nXnwXNcMDuaqBEILUh
	 H1wJ884JhclZg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 25 Feb 2026 00:45:10 +0530
Subject: [PATCH v3 08/13] mfd: sec: resolve PMIC revision in S2MU005
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-s2mu005-pmic-v3-8-b4afee947603@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
In-Reply-To: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43170-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,disroot.org:mid,disroot.org:dkim,disroot.org:email]
X-Rspamd-Queue-Id: F1E1118BDA8
X-Rspamd-Action: no action

In devices other than S2MPG1X, the revision can be retrieved from the
first register of the PMIC regmap. In S2MU005 however, the location is
in offset 0x73. Introduce a switch-case block to allow selecting the
REG_ID register.

S2MU005 also has a field mask for the revision. Apply it using
FIELD_GET() and get the extracted value.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mfd/sec-common.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index b3268516bf75e..230bee16d0690 100644
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
@@ -119,20 +120,27 @@ static const struct mfd_cell s2mu005_devs[] = {
 
 static void sec_pmic_dump_rev(struct sec_pmic_dev *sec_pmic)
 {
-	unsigned int val;
+	unsigned int reg, mask, val;
 
-	/* For s2mpg1x, the revision is in a different regmap */
 	switch (sec_pmic->device_type) {
 	case S2MPG10:
 	case S2MPG11:
+		/* For s2mpg1x, the revision is in a different regmap */
 		return;
-	default:
+	case S2MU005:
+		reg = S2MU005_REG_ID;
+		mask = S2MU005_ID_MASK;
 		break;
+	default:
+		/* For other device types, REG_ID is always the first register. */
+		reg = S2MPS11_REG_ID;
+		mask = ~0;
 	}
 
-	/* For each device type, the REG_ID is always the first register */
-	if (!regmap_read(sec_pmic->regmap_pmic, S2MPS11_REG_ID, &val))
+	if (!regmap_read(sec_pmic->regmap_pmic, reg, &val)) {
+		val = FIELD_GET(S2MU005_ID_MASK, val);
 		dev_dbg(sec_pmic->dev, "Revision: 0x%x\n", val);
+	}
 }
 
 static void sec_pmic_configure(struct sec_pmic_dev *sec_pmic)

-- 
2.52.0


