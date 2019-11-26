Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255BF109EC1
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfKZNN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 08:13:56 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58371 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKZNNi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 08:13:38 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: kqwlt/mhjvdp9xuiX/7x8GmbrLW8q+nC3Yu8ZXtfXldmXRKrS0m7a+0cGrUU4HS+tbhSFRc2qD
 2EGVNedPWEpw0m0vBzOBB8P6a8pw0spIXoMUhM3dP9hUrDFb0c/BTmWLzhZyxBiyRK0AhK3Z36
 +1faI2dYNA9+vikyJtc0PkSWmy58lRou811y6SUBxKJyz4u6nYs47Co+fixCwI0xNMvJpzxolg
 t0SBcXb3vGqL9q83cDE6Ry7LqvSRB0e0+fu0j/dBOjDKXUK4+snBVvN0NcOZd33KpegcuIWqVk
 nsM=
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="59777394"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Nov 2019 06:13:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 Nov 2019 06:13:21 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 26 Nov 2019 06:13:19 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 11/17] ARM: at91/defconfig: enable config flag for flexcom
Date:   Tue, 26 Nov 2019 15:12:15 +0200
Message-ID: <1574773941-20649-12-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable config flag for flexcom. This IP is available on SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index c3305e563742..7603efe5809e 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -116,6 +116,7 @@ CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
+CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_MFD_ATMEL_HLCDC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.7.4

