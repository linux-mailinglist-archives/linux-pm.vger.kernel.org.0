Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8110D665
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 14:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfK2Nwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 08:52:41 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63896 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfK2Nwk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 08:52:40 -0500
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
IronPort-SDR: NVP07n5UHQyO85D6M5ziFM/uaKw1m1DZNFWSnXI8pTvWi10Vw8TJkJsoB74NxpzMW34fmwBl50
 2vM8Zny4bPk3r0DzqEcyRHYgl1WWVYzqeh0fbQbpI9KlHoybCqS4BfJLRFltdMp9aLeH5TnStn
 tc525Mu/QP2Ki4iUS3LH9chDppDSd3S7yOhDUeFBtG3xawQPNvZp1fbatOeWR4pgK+y6yKoLWt
 YfQ+Ne8+O1eGCAcRR7m5OHBXwWpdDzf5sSJ0KtpUqrtDRDtFU5K8U65lP5x9GPErnMLTfqdqaW
 YEE=
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="58778749"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2019 06:52:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Nov 2019 06:52:20 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Nov 2019 06:52:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v3 9/9] ARM: at91/defconfig: enable config flags for sam9x60 SoC
Date:   Fri, 29 Nov 2019 15:51:45 +0200
Message-ID: <1575035505-6310-10-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
References: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable config flags for SAM9X60 SoC. This includes SoC flag
(CONFIG_SOC_SAM9X60) and IP/board specific flags as follows:
- atmel maxtouch
- flexcom
- XDMA
- I2S Multi-channel
- mikroelectronica proto board
- SAMA5D2's ADC
- atmel QSPI
- classd

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 148f753de6c7..5c5df8bc0074 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -13,6 +13,7 @@ CONFIG_ARCH_MULTI_V5=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
+CONFIG_SOC_SAM9X60=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
@@ -49,6 +50,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_GLUEBI=y
 CONFIG_BLK_DEV_LOOP=y
@@ -99,6 +101,7 @@ CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_ATMEL=y
@@ -108,11 +111,14 @@ CONFIG_I2C_AT91=y
 CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
+CONFIG_SPI_ATMEL_QUADSPI=y
 CONFIG_POWER_RESET=y
+# CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC is not set
 CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
+CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_MFD_ATMEL_HLCDC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -136,6 +142,9 @@ CONFIG_SND_ATMEL_SOC=y
 CONFIG_SND_AT91_SOC_SAM9G20_WM8731=y
 CONFIG_SND_ATMEL_SOC_WM8904=y
 CONFIG_SND_AT91_SOC_SAM9X5_WM8731=y
+CONFIG_SND_ATMEL_SOC_CLASSD=y
+CONFIG_SND_SOC_MIKROE_PROTO=m
+CONFIG_SND_MCHP_SOC_I2S_MCC=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
@@ -167,9 +176,11 @@ CONFIG_RTC_DRV_AT91RM9200=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
 CONFIG_AT_HDMAC=y
+CONFIG_AT_XDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
+CONFIG_AT91_SAMA5D2_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=y
 CONFIG_PWM_ATMEL_HLCDC_PWM=y
-- 
2.7.4

