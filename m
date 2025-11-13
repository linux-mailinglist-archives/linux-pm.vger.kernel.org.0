Return-Path: <linux-pm+bounces-37979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57963C59AB3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E42444E7703
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DC931B118;
	Thu, 13 Nov 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OhHPgEZI"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9D31B100;
	Thu, 13 Nov 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060833; cv=none; b=rQgARVtymm3g0rK3Q/sMW2/X7Q2ftCSaneFLAcj+qiAm0AKU3NkR1ry98Vx8K8PRAJ3LAYedNW/vIQii49VX0Mloijl46gdSMwu9cUxnfCP4huUKDLBfsEpRq/2jNg/fkZHEOG6bIVDXaEvCAYMT7Ae5T9BKgSsc7HeWSVyVLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060833; c=relaxed/simple;
	bh=LWX7GkimFoy35tTCAVN375evxoUHiYMParoV5iSHup0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKW82v75RGl7CEPZAXpG1XuEtIG/QPPGzLdlxICm3qdqA0Y7mMDK9E5MATGt70bUkvt/fJ1LH1CFfc4cEt6PBf3adoCLei+22RQJ9gXNg8YHSIOEJ+A3QmCV1woGCcPjgLe6B+XfeyuAGqqhfCNmvnJf1JW2wQUuw5eLuH2IWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OhHPgEZI; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2974F25EDC;
	Thu, 13 Nov 2025 20:07:10 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8yQAZqCJSbdI; Thu, 13 Nov 2025 20:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060829; bh=LWX7GkimFoy35tTCAVN375evxoUHiYMParoV5iSHup0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OhHPgEZI5Hc87mCWuQgovlTU2oEKjGmmgMtuHC01n2GNwqjrfkyFs8DdM4xeYdDCU
	 u33UUPAVsyrGycygK1lbo6/aitdIg5AhZqm1rwUcGHOXa5wW0YbsN2k0lgrY2znlF1
	 DMrqTuln6J1Z4ejHdlmQOOeWdMI72Oa0F6csBUTLsjdafWS5tKj0VVAWkt4vtIIvlX
	 4nTmfXMeevd2KqP8SDh4+cCtvc3z8Y+mX3UCAwth3V0r7TcnLrYkNGnpRMXw/jyobz
	 9owrrK4XnvAfHhBc5CHK2HnYmd7EfTdb8A6/fKg+L2k08U49GkFFq3zU0hKed74IC9
	 U0fR2U7VBww2A==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:09 +0530
Subject: [PATCH 08/13] mfd: sec: store hardware revision in sec_pmic_dev
 and add S2MU005 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-8-9e3184d3a0c9@disroot.org>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
In-Reply-To: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=3228;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=LWX7GkimFoy35tTCAVN375evxoUHiYMParoV5iSHup0=;
 b=bRpngdA7TgTIKE+t9saHEIyI0x6s+mH+8sGFu1P7k4ySWz+PkoTJv3cbdNH40RqVdV7JC54M1
 8VZ7JaXBxKsDc14MrzSfpX9RiEmPAFBIh2gZZ75/wcnMqDKAqz7C7Yo
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

The device revision matters in cases when in some PMICs, the correct
register offsets very in different revisions. Instead of just debug
printing the value, store it in the driver data struct.

Unlike other devices, S2MU005 has its hardware revision ID in register
offset 0x73. Allow handling different devices and add support for S2MU005.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mfd/sec-common.c         | 30 ++++++++++++++++++++++++------
 include/linux/mfd/samsung/core.h |  3 +++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index 4c5f4dc2905b..f51c53e7a164 100644
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
@@ -86,17 +87,34 @@ static const struct mfd_cell s2mu005_devs[] = {
 	MFD_CELL_OF("s2mu005-rgb", NULL, NULL, 0, 0, "samsung,s2mu005-rgb"),
 };
 
-static void sec_pmic_dump_rev(struct sec_pmic_dev *sec_pmic)
+static void sec_pmic_store_rev(struct sec_pmic_dev *sec_pmic)
 {
-	unsigned int val;
+	unsigned int reg, mask, shift;
 
 	/* For s2mpg1x, the revision is in a different regmap */
 	if (sec_pmic->device_type == S2MPG10)
 		return;
 
-	/* For each device type, the REG_ID is always the first register */
-	if (!regmap_read(sec_pmic->regmap_pmic, S2MPS11_REG_ID, &val))
-		dev_dbg(sec_pmic->dev, "Revision: 0x%x\n", val);
+	switch (sec_pmic->device_type) {
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
+	if (!regmap_read(sec_pmic->regmap_pmic, reg, &sec_pmic->revision))
+		return;
+
+	sec_pmic->revision &= mask;
+	sec_pmic->revision >>= shift;
+
+	dev_dbg(sec_pmic->dev, "Revision: 0x%x\n", sec_pmic->revision);
 }
 
 static void sec_pmic_configure(struct sec_pmic_dev *sec_pmic)
@@ -236,7 +254,7 @@ int sec_pmic_probe(struct device *dev, int device_type, unsigned int irq,
 		return ret;
 
 	sec_pmic_configure(sec_pmic);
-	sec_pmic_dump_rev(sec_pmic);
+	sec_pmic_store_rev(sec_pmic);
 
 	return ret;
 }
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index fc07f7944dcd..ccd1bfa15b85 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -63,6 +63,7 @@ enum sec_device_type {
  * @irq_base:		Base IRQ number for device, required for IRQs
  * @irq:		Generic IRQ number for device
  * @irq_data:		Runtime data structure for IRQ controller
+ * @revision:		Revision number of the device
  * @wakeup:		Whether or not this is a wakeup device
  */
 struct sec_pmic_dev {
@@ -74,6 +75,8 @@ struct sec_pmic_dev {
 	int device_type;
 	int irq;
 	struct regmap_irq_chip_data *irq_data[MAX_IRQ_CHIPS];
+
+	unsigned int revision;
 };
 
 struct sec_platform_data {

-- 
2.51.2


