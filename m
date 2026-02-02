Return-Path: <linux-pm+bounces-41909-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJpDGv2VgGnL/gIAu9opvQ
	(envelope-from <linux-pm+bounces-41909-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 13:18:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5347CC468
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 13:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BE9430078A9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784923644A0;
	Mon,  2 Feb 2026 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="PYqHEXaw"
X-Original-To: linux-pm@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5223EA8B;
	Mon,  2 Feb 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034682; cv=none; b=IYJXfjF8x9z31i/Gt+/8zcEadaPriPHME1ZQt4v0V5hzDKk+QF2v65uKIMPvttDKKP8ZgGyZajwcoBf/QhfZhIUm+KO3DYa9yKFl3OmujyiJ+fQitZA6S5NWaXrOto++KlDLcdg7yTL4iCoen0GLBIbtpqrStl5F/OX7oOsWgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034682; c=relaxed/simple;
	bh=TYUt9FJt7CNpzvjqNiYdqwlE0EzS/PuXV9htmRNdeus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pOcpOS+dC65vZFZgR/D6Sl90CW6PHGbvPWQxW1nsiT8MW+pAFk3TGYNSa2RpzQ6X12gZ8HZtOsYbRNj7frr0Sgza2mHLrYJOIJtaS3fqu6nMl15nYcJj1tYwPcUTgKsfKXwrlEj6OCXUFo78Hv7hISMliPhzm4/3G1HoChUElgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=PYqHEXaw; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id A2D99C003C;
	Mon,  2 Feb 2026 15:11:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru A2D99C003C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1770034266; bh=9X65dIlOa5ojXdY4XCMIq4fTKSrnjG2v6PFxlaTSkIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=PYqHEXawImslVyqhtRdcrwwrEHfq3G5Aa1vUaICHgfQ6qDOYVnTVzt7Iq4bpovd4e
	 oKpwvkuCHv0MUPfEWxjdPbbP3mkMoxOr9xbkGwaY2Bm4M1W3a00pnWml1ZqKetqOzX
	 MAD70ixxdS+VPMWpk+3Perm5zvmaTlId4mRC9StYyJutqJgNQcUUihyPXa+mpSYNV2
	 m4LFg6CFWNm26HE4BGh8Ryd95GqjwzHE4HGkmRNBQypx/g87RDzl9RnT6Cb4G0lsqT
	 g0py1DC31Fdgh0XP3wq6xLeACmkYcyfRUet/6xg+gUbrxIwTadQ+N44u8dRV2YRi5C
	 OzR+/dLy64abQ==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon,  2 Feb 2026 15:11:06 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Feb 2026 15:11:05 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Sebastian Reichel <sre@kernel.org>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, NeilBrown <neil@brown.name>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>, Anton Vorontsov
	<anton.vorontsov@linaro.org>, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas
	<notasas@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 1/1] power: supply: twl4030_charger: check return values in twl4030_charger_enable_usb()
Date: Mon, 2 Feb 2026 15:09:12 +0300
Message-ID: <20260202120912.4098587-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=ksmg01.maxima.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 86 0.3.86 47cb2a3d3f5c7e795bff2d0998e8c196722872ab, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;mt-integration.ru:7.1.1;81.200.124.61:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 200035 [Feb 02 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.20
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/02/02 06:24:00 #28171150
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mt-integration.ru:s=sl];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41909-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mt-integration.ru];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mt-integration.ru,brown.name,ti.com,linaro.org,gmail.com,vger.kernel.org,linuxtesting.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.abramov@mt-integration.ru,linux-pm@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[mt-integration.ru:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mt-integration.ru:email,mt-integration.ru:dkim,mt-integration.ru:mid,linuxtesting.org:url]
X-Rspamd-Queue-Id: A5347CC468
X-Rspamd-Action: no action

twl4030_charger_enable_usb() ignores multiple return values from I2C
writes and helper calls. This can lead to silent failures where the
hardware is not configured correctly.

Add return value checks and error logging to fix it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7f4a633d2133 ("twl4030_charger: add software controlled linear charging mode.")
Fixes: e9f14c18b83c ("twl4030_charger: Change TWL4030_MODULE_* ids to TWL_MODULE_*")
Fixes: 2e727f1787e3 ("power_supply: Add driver for TWL4030/TPS65950 BCI charger")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 drivers/power/supply/twl4030_charger.c | 69 +++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 04216b2bfb6c..a32e155c59f1 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -466,11 +466,24 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 			}
 			/* forcing the field BCIAUTOUSB (BOOT_BCI[1]) to 1 */
 			ret = twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTOUSB);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to set BCIAUTOUSB: %d\n",
+					ret);
+				return ret;
+			}
+
 		}
 
 		/* forcing USBFASTMCHG(BCIMFSTS4[2]) to 1 */
 		ret = twl4030_clear_set(TWL_MODULE_MAIN_CHARGE, 0,
 			TWL4030_USBFASTMCHG, TWL4030_BCIMFSTS4);
+		if (ret < 0) {
+			dev_err(bci->dev,
+				"failed to set USBFASTMCHG: %d\n",
+				ret);
+			return ret;
+		}
 		if (bci->usb_mode == CHARGE_LINEAR) {
 			/* Enable interrupts now. */
 			reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_TBATOR2 |
@@ -483,22 +496,58 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 					ret);
 				return ret;
 			}
-			twl4030_clear_set_boot_bci(TWL4030_BCIAUTOAC|TWL4030_CVENAC, 0);
+			ret = twl4030_clear_set_boot_bci(TWL4030_BCIAUTOAC|TWL4030_CVENAC, 0);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to clear AC flags: %d\n",
+					ret);
+				return ret;
+			}
 			/* Watch dog key: WOVF acknowledge */
 			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x33,
 					       TWL4030_BCIWDKEY);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to write BCIWDKEY (0x33): %d\n",
+					ret);
+				return ret;
+			}
 			/* 0x24 + EKEY6: off mode */
 			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x2a,
 					       TWL4030_BCIMDKEY);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to write BCIMDKEY (0x2a): %d\n",
+					ret);
+				return ret;
+			}
 			/* EKEY2: Linear charge: USB path */
 			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x26,
 					       TWL4030_BCIMDKEY);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to write BCIMDKEY (0x26): %d\n",
+					ret);
+				return ret;
+			}
 			/* WDKEY5: stop watchdog count */
 			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0xf3,
 					       TWL4030_BCIWDKEY);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to write BCIWDKEY (0xf3): %d\n",
+					ret);
+				return ret;
+			}
 			/* enable MFEN3 access */
 			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x9c,
 					       TWL4030_BCIMFKEY);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to write BCIMFKEY: %d\n",
+					ret);
+				return ret;
+			}
 			 /* ICHGEOCEN - end-of-charge monitor (current < 80mA)
 			  *                      (charging continues)
 			  * ICHGLOWEN - current level monitor (charge continues)
@@ -506,11 +555,29 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 			  */
 			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0xf0,
 					       TWL4030_BCIMFEN3);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to write BCIMFEN3: %d\n",
+					ret);
+				return ret;
+			}
 		}
 	} else {
 		ret = twl4030_clear_set_boot_bci(TWL4030_BCIAUTOUSB, 0);
+		if (ret < 0) {
+			dev_err(bci->dev,
+				"failed to clear BCIAUTOUSB: %d\n",
+				ret);
+			return ret;
+		}
 		ret |= twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x2a,
 					TWL4030_BCIMDKEY);
+		if (ret < 0) {
+			dev_err(bci->dev,
+				"failed to write BCIMDKEY: %d\n",
+				ret);
+			return ret;
+		}
 		if (bci->usb_enabled) {
 			pm_runtime_put_autosuspend(bci->transceiver->dev);
 			bci->usb_enabled = 0;
-- 
2.39.5


