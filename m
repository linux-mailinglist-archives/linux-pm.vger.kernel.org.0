Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D696109EA4
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 14:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfKZNM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 08:12:56 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:56971 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfKZNMz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 08:12:55 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: s1r+VMWgk8BGUsk6zfUdzjdhEn82Pb8LNILPviEHf6UKZVsA7TEfbZZp12ue+QiPgRIrTxS1G9
 EIY0liGmNCUs4qKK372toowLGz37a79E0bwdfueQtWRauFBOVlEcMhqjYwDFdYzZbqB7VUnzK8
 MhIXM0CWnh4AigxQZ+xuJxl9askTSJ2xgSph6ZdvolZa+Zy2zKQOP4Z7k+Ec6m2fwmCc1oeubf
 deGhJlKMKKUZBwApeSwNZj6gMENvLXL5cG1T51cbA3H5sntk/l0djihRRFOyRnbUTZy5ifRn0a
 BCc=
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="58391051"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Nov 2019 06:12:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 Nov 2019 06:12:52 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 26 Nov 2019 06:12:49 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 00/17] SoC and defconfig support for SAM9X60
Date:   Tue, 26 Nov 2019 15:12:04 +0200
Message-ID: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
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

Claudiu Beznea (12):
  ARM: at91: Kconfig: add sam9x60 pll config flag
  ARM: at91: pm: move SAM9X60's PM under its own SoC config flag
  drivers: soc: atmel: move sam9x60 under its own config flag
  power: reset: Kconfig: select POWER_RESET_AT91_RESET for sam9x60
  drivers: soc: atmel: select POWER_RESET_AT91_SAMA5D2_SHDWC for sam9x60
  ARM: debug-ll: select DEBUG_AT91_RM9200_DBGU for sam9x60
  ARM: at91: Kconfig: add config flag for SAM9X60 SoC
  ARM: at91/defconfig: use savedefconfig
  ARM: at91/defconfig: enable config flag for sam9x60 SoC
  ARM: at91/defconfig: enable config flag for atmel maxtouch
  ARM: at91/defconfig: enable config flag for flexcom
  ARM: at91/defconfig: enable config flag for XDMAC

Codrin Ciubotariu (3):
  ARM: at91/defconfig: enable config flag for I2S Multi-channel
  ARM: at91/defconfig: enable config flag for audio PROTO board
  ARM: at91/defconfig: enable config flag for CLASSD

Tudor Ambarus (2):
  ARM: at91/defconfig: enable config flag for SAMA5D2's ADC
  ARM: at91/defconfig: enable config flag for ATMEL QUADSPI

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

