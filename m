Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48D01D140A
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 15:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEMNI4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 09:08:56 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43028 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgEMNIz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 09:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589375335; x=1620911335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wEXDFyhD27FZDpCBx83MYF8BSCc7p0QLtEEMqVkQwfk=;
  b=kVMNO2NsH2oPLucy4doYPWJG+Ohuyj4JXRWb8d5Ib5iM5lYOQkJRGw34
   Mz6O9PAEIDhWb3Ld3Ar09UemY3j5CIX95zuEGUQy3CIcDs3uMFucBUS7z
   PCZviQ42mDfqJwpdGTCb4P0jf4iJiC2Kv6PfmNCMyt/r64wruH2QRLeuT
   ph/r6dTOLePkOwd6jSGpTNeF9wQQ5bgjqj1Sr/EES7LaxVsSM4oXM/hxW
   /x9VNAblajw1UjEph8kG3TlZE/WFPXx5ptmiw4OOsGEQ/fEDzzOvB/JMD
   U9iW7sS7CaNkWh8GPRP5fUC4HzCCU49Q1H8D7iZTkzYoIug0AxggM86S4
   Q==;
IronPort-SDR: u4GtpcwpQ8MLU6OB9FkxDseViNR3YvoIb2dMRW2aHsvK94tIS3YRC/H1aZ1aJGFh447eHJ6kxm
 q0M9h2sHr59/QU8HxihFuIrdVG6L6VY1StWHUaXYcFnJ+0gUZ1kYwzulTdKX9mKoyjDNMzGlW1
 WRoWOxUtL7Qf/vH9i/84trcmss+PxIw8QdVVYIiN1CrScjMZzqrrZF03S7HzRVRK8cubqsbNZk
 Up62au2XJDvEMe26Udy40kwR9xIUIxKskgvj+ggSJFtYonedtPRoxzWJsNiom5nY35mxdL2tkf
 n18=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="79438661"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:08:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:08:57 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:08:52 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/5] power: Adding support for Microchip Sparx5 SoC
Date:   Wed, 13 May 2020 15:08:37 +0200
Message-ID: <20200513130842.24847-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200513125532.24585-1-lars.povlsen@microchip.com>).

It adds reset support for Sparx5, using the ocelot reset driver.

It is expected that the DT patches are to be taken directly by the arm-soc
maintainers.

Lars Povlsen (5):
  dt-bindings: reset: ocelot: Add Sparx5 support
  power: reset: ocelot: Add support for Sparx5
  dt-bindings: reset: ocelot: Add documentation for
    'microchip,reset-switch-core' property
  power: reset: ocelot: Add support for reset switch on load time
  arm64: dts: sparx5: Add reset support

 .../bindings/power/reset/ocelot-reset.txt     | 13 ++-
 MAINTAINERS                                   |  1 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi     | 11 +++
 drivers/power/reset/Kconfig                   |  3 +-
 drivers/power/reset/ocelot-reset.c            | 95 ++++++++++++++++---
 5 files changed, 105 insertions(+), 18 deletions(-)

--
2.26.2
