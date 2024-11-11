Return-Path: <linux-pm+bounces-17306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36659C3926
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 08:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2049E1C21119
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96EE15B546;
	Mon, 11 Nov 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="dZT6giQf"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1DF155741;
	Mon, 11 Nov 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311279; cv=none; b=Fr+7huH71E3ZW6jo4K4/fVkYnHu17rwlpr+6senSqJFQjFFuFqpXxawoPHh6GdbyBIQEuxLeh/7po3pTkXqRAklPDVyo1X7UWIebTHRgdflbOzxRI7vSUuEt3zXWVhM2Af3yfSuM5cpPiloqrkSmOz6rGHLx7OvgPE/7eefgEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311279; c=relaxed/simple;
	bh=FgBt3Jg123yYyp1wUYmUaLQCSARYYCtAyEm2IhlMMkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iu/Ia/ru+DBU3bF7gKfgSD4VlF+YcBL7oVhFbKADNOGOGGxCwfJg7rBzFuERNRu3ry+me+hvFumgZmTtl6GHz6i0IJvxDskzH8yzvD6IfIGmKlrA4db3ahmJ9Jo8PiBXmOKM2HcahfH7BnCWSewanK9FPJBlzAlxDyAdU0qWeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=dZT6giQf; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C8744A043B;
	Mon, 11 Nov 2024 08:47:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=zsgQV6ELrg9oFQ/7FJ1q
	djm9jhFe9TnMay+N17iy5hQ=; b=dZT6giQfDuW+IGUa3NKO2gWhiBnqJ4u87f6Z
	N4JtRiz/GZ2XfnCFzuN02VF6ixz2Yw55nZvHRniwj1PhQs4M7Ie7q9xqDEo3AJ1m
	S/znaXvmNI2uL1lYWiKFEjfKU623VsKgB2UZamFG+Os7YqjoOUCOV9on3EUwwKDY
	MjkEjedCoofrV4vii6RQes09ULmrlFYpSrzgFzIFHple1p1LB4q1xxR63QL82YKm
	QmwuV/IarRgvagssfEgEYnUn9LoR5tPtJWJPBspKyNq6ASy5FSHg/7gdU4gDm7DW
	wLp5/DI4oeASiFLfORLDJUkz7miAS5U+Ei7Niah5BlnHhAVRBGFFOftpiDgzPM1M
	vgksv9+CpZ0Kyvbo0t5Xt8AfAqj2SX77SQ2DxrQNYMA1It4RZ7/5oTbC3JgMTYqJ
	+ztLEDlY+9o1zq0LSohPLS4gYb1jmUxR2g9a5yCuZQ5FII0SNWGfc63XE/bqZbIN
	IBe348wLvjBKKGOLphV8g+1dpNuSEtUuJqjKIZtKlckLUm1wOJCi0OQhkhm9DwvP
	SGzp4X/YmUZ6ugZVOJ88bUohWbev5w5F1eSfQWY9rAW6+Bkg0RiYctlMTY+JGgEs
	NKvZ1CMMJ9R/v+VHQ47n3Cc8TPE6COoegvGXvDIIwm181SD24jJHIqmrOFc1/9Qj
	4JPnsXs=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Samuel
 Holland" <samuel@sholland.org>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v4 5/7] power: ip5xxx_power: Check for optional bits
Date: Mon, 11 Nov 2024 08:47:18 +0100
Message-ID: <20241111074720.1727163-5-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111074720.1727163-1-csokas.bence@prolan.hu>
References: <20241111074720.1727163-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1731311269;VERSION=7980;MC=3696430840;ID=287559;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485561716B

Some parts may not have certain control bits. These bits
however may be non-essential to the system's operation,
as the default behaviour is the one we would set anyways,
or the bits are not applicable for said part (e. g. enabling
NTC on a part without an NTC pin, or one where it cannot
be disabled via registers anyways).

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/power/supply/ip5xxx_power.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 3a739a969dde..02e2a0c95407 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -111,6 +111,7 @@ struct ip5xxx {
 	} const_curr;
 };
 
+#define REG_FIELD_UNSUPPORTED { .lsb = 1 }
 /* Register fields layout. Unsupported registers marked as { .lsb = 1 } */
 struct ip5xxx_regfield_config {
 	const struct reg_field charger_enable;
@@ -204,9 +205,11 @@ static int ip5xxx_initialize(struct power_supply *psy)
 	 * Disable shutdown under light load.
 	 * Enable power on when under load.
 	 */
-	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.boost.light_load_shutdown.enable, 0);
-	if (ret)
-		return ret;
+	if (ip5xxx->regs.boost.light_load_shutdown.enable) {
+		ret = ip5xxx_write(ip5xxx, ip5xxx->regs.boost.light_load_shutdown.enable, 0);
+		if (ret)
+			return ret;
+	}
 	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.boost.load_powerup_en, 1);
 	if (ret)
 		return ret;
@@ -229,9 +232,11 @@ static int ip5xxx_initialize(struct power_supply *psy)
 	 * Enable the NTC.
 	 * Configure the button for two presses => LED, long press => shutdown.
 	 */
-	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.battery.ntc_dis, 0);
-	if (ret)
-		return ret;
+	if (ip5xxx->regs.battery.ntc_dis) {
+		ret = ip5xxx_write(ip5xxx, ip5xxx->regs.battery.ntc_dis, 0);
+		if (ret)
+			return ret;
+	}
 	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.btn.wled_mode, 1);
 	if (ret)
 		return ret;
@@ -505,9 +510,12 @@ static int ip5xxx_battery_set_voltage_max(struct ip5xxx *ip5xxx, int val)
 	if (ret)
 		return ret;
 
-	ret = ip5xxx_write(ip5xxx, ip5xxx->regs.battery.vset_en, 1);
-	if (ret)
-		return ret;
+	/* Don't try to auto-detect battery type, even if the IC could */
+	if (ip5xxx->regs.battery.vset_en) {
+		ret = ip5xxx_write(ip5xxx, ip5xxx->regs.battery.vset_en, 1);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.34.1



