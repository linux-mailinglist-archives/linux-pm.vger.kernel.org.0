Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CE110D661
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 14:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK2Nwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 08:52:38 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63896 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfK2Nwi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 08:52:38 -0500
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
IronPort-SDR: fG2LFoGa3VTNMoC62aLReiD8KqvHsUHmPgVeM/gpb+85wgLOC7rageSGoak8wV4LVVW2Q46lvR
 x8KV4NW3+KoXSYlLl9fJlajvfc60ejbsH54eZ7U44IJ+W2vUTYRBoI4oCxUA5Wj0AzzwklS7uu
 8JA7pzSXwuQAtjBlWWqJOGGWbieFmOOXBjs1uigSVeIsSj71mfz4lVYprlOjOC6xz/L+roIGsH
 xBlaXUHQfQfF+PIHPuNgaY0dYr29HvboQscRSxk02YuyZEsyNtMCj6srhJHCaucO0541OSMntH
 22E=
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="58778727"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2019 06:52:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Nov 2019 06:52:16 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Nov 2019 06:52:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 8/9] ARM: at91/defconfig: use savedefconfig
Date:   Fri, 29 Nov 2019 15:51:44 +0200
Message-ID: <1575035505-6310-9-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
References: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use savedefconfig.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 44 +++++++++++++-------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 3729a6e0ee24..148f753de6c7 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -7,11 +7,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
@@ -27,6 +22,9 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
 CONFIG_KEXEC=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -37,13 +35,7 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 CONFIG_IPV6_SIT_6RD=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
@@ -69,8 +61,8 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
-CONFIG_MACB=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
+CONFIG_MACB=y
 CONFIG_DM9000=y
 # CONFIG_NET_VENDOR_FARADAY is not set
 # CONFIG_NET_VENDOR_INTEL is not set
@@ -82,10 +74,12 @@ CONFIG_DM9000=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_DAVICOM_PHY=y
 CONFIG_MICREL_PHY=y
-CONFIG_RTL8187=m
 CONFIG_LIBERTAS=m
 CONFIG_LIBERTAS_SDIO=m
 CONFIG_LIBERTAS_SPI=m
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
+CONFIG_MWIFIEX_USB=m
 CONFIG_RT2X00=m
 CONFIG_RT2500USB=m
 CONFIG_RT73USB=m
@@ -93,15 +87,10 @@ CONFIG_RT2800USB=m
 CONFIG_RT2800USB_RT53XX=y
 CONFIG_RT2800USB_RT55XX=y
 CONFIG_RT2800USB_UNKNOWN=y
+CONFIG_RTL8187=m
 CONFIG_RTL8192CU=m
 # CONFIG_RTLWIFI_DEBUG is not set
-CONFIG_MWIFIEX=m
-CONFIG_MWIFIEX_SDIO=m
-CONFIG_MWIFIEX_USB=m
 CONFIG_INPUT_POLLDEV=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=480
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=272
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -119,8 +108,8 @@ CONFIG_I2C_AT91=y
 CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
-CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
@@ -130,14 +119,11 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_SOC_CAMERA=y
 CONFIG_VIDEO_ATMEL_ISI=y
-CONFIG_SOC_CAMERA_OV2640=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_FB_ATMEL=y
-# CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_ATMEL_LCDC=y
 # CONFIG_BACKLIGHT_GENERIC is not set
 CONFIG_BACKLIGHT_PWM=y
@@ -200,12 +186,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_FS=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
@@ -215,3 +195,9 @@ CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_ACORN_8x8=y
 CONFIG_FONT_MINI_4x6=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_USER=y
-- 
2.7.4

