Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6F10D653
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 14:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfK2Nv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 08:51:58 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:53483 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfK2Nv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 08:51:58 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: h5SHTUUGrFynw3OqVDljNloPVDJf/ril5qn86YWzvZhV88T2PkE3APvVIe3R3c8x5aSbdTnqrU
 mgjnM1YxoiD4WNtamkfpsRja3cx4qIe/4dimTNcD1gGX5QDi8VoWWAExUdbR23GM5rZPA8Xb2d
 f78itzV5tPXN8cjFiYPEE1b9kTgzLMGjcUZqjln4NVaEdYcB1yC7CupdrUKUCZtyvjPN6FmEaC
 zVHqk4tt7U+kWJDsG7CVfiXUaF5mWJ1L2iBcY1jT1jKDZJrNNpUJ2jam+VkJJugINPjsflkr1W
 7Os=
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="57287972"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2019 06:51:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Nov 2019 06:51:53 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Nov 2019 06:51:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/9] SoC and defconfig support for SAM9X60
Date:   Fri, 29 Nov 2019 15:51:36 +0200
Message-ID: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series enables proper support for SAM9X60 in Kconfig and
defconfig.

Thank you,
Claudiu Beznea

Changes in v3:
- move patch "ARM: at91: Kconfig: add config flag for SAM9X60 SoC" before
  the patches that uses CONFIG_SOC_SAM9X60
- sqash defconfig patches (except the savedefconfig one)

Changes in v2:
- cahnged cover letter title; previously it was:
  "add defconfig support for SAM9X60"
- have new entry in arch/arm/mach-at91/Kconfig for SOC_SAM9X60
  independent of SOC_AT91SAM9 to be able to select only necessary
  config flags for SAM9X60 (patches 02/17, 03/17)
- select POWER_RESET_AT91_RESET and POWER_RESET_AT91_SAMA5D2_SHDWC
  as for SAMA5D2 (patches 04/17, 05/17)
- select DEBUG_AT91_RM9200_DBGU (patch 06/17)
- shaped a bit the patches titles and commit desciptions for defconfig
  patches (patches 09-17/17)

Claudiu Beznea (9):
  ARM: at91: Kconfig: add sam9x60 pll config flag
  ARM: at91: Kconfig: add config flag for SAM9X60 SoC
  ARM: at91: pm: move SAM9X60's PM under its own SoC config flag
  drivers: soc: atmel: move sam9x60 under its own config flag
  power: reset: Kconfig: select POWER_RESET_AT91_RESET for sam9x60
  drivers: soc: atmel: select POWER_RESET_AT91_SAMA5D2_SHDWC for sam9x60
  ARM: debug-ll: select DEBUG_AT91_RM9200_DBGU for sam9x60
  ARM: at91/defconfig: use savedefconfig
  ARM: at91/defconfig: enable config flags for sam9x60 SoC

 arch/arm/Kconfig.debug             |  6 ++---
 arch/arm/configs/at91_dt_defconfig | 55 ++++++++++++++++++--------------------
 arch/arm/mach-at91/Kconfig         | 24 +++++++++++++++--
 arch/arm/mach-at91/Makefile        |  1 +
 arch/arm/mach-at91/at91sam9.c      | 18 -------------
 arch/arm/mach-at91/pm.c            |  2 +-
 arch/arm/mach-at91/sam9x60.c       | 34 +++++++++++++++++++++++
 drivers/power/reset/Kconfig        |  4 +--
 drivers/soc/atmel/soc.c            |  5 ++--
 9 files changed, 92 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm/mach-at91/sam9x60.c

-- 
2.7.4

