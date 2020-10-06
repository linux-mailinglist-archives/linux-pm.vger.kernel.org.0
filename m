Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9582D2852CC
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgJFUDd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 16:03:33 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48139 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFUDd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 16:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602014612; x=1633550612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S5Lk5IYNPfklOzkbGG082cbWlD2ByiSYJT6pEWsLLHk=;
  b=rCy+7xrPOXiKiVT7bpwxszIwy+JXH1t0Y1a2+CLN8SMZkvJ7qzMUI96s
   9GoeU/RPF3SXiMRtbkUHd+OB3L6hfY4k6nHpVMXCcGwPMBrnFeCjaPTHg
   MC8s/Cpc+0k274yzmGrFYKotsPn2FYFxS3Ww2t4vJultm6AsufObn31gx
   Fd2LsPjN55YvRQYDViyz3q3qQqDKeNJQhTkK2ojWG/WbjvpxtG/io/zAs
   K+2pMsHzz8aeXPx3merfig6Zc4ofk8S/FpI8C+GVPw4314DqLUyjF9MyH
   uedUozrF9rA3QW8NMrPX+18N0iMdtRKBkD5iqP0wyJAiabv/zLpvo5cPB
   A==;
IronPort-SDR: EjA+WSvRrbWAAKoR1p4KH0TbPBINsfgYSy6WP3BCx9DlLd08m+K4doO6SrNi10ejbEo6WHrxz6
 cit0oB1MOCRjUTKEklE8v0Ib427M8rk1jiyDwLO1Ho5r/0WuMedvymQoOnspm3evDuILHE8zfT
 Rafx0L7nxOnuyV/QoE9QmnEfRIxL9Z+7sLfIgmFDVhbmB6u4ahz6l1i9hWT83FcQkzQGEwomsd
 Qk7NvbyM95sM4bRnagJFzMh25uzg6KppJqXy9GVbpaDQDYpbV8Mb8GR1twdC6BkQiENd1KYMjz
 iQc=
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="91665223"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2020 13:03:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 13:03:31 -0700
Received: from soft-dev10.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 6 Oct 2020 13:03:30 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/3] power: Add reset support for Microchip Sparx5 SoC
Date:   Tue, 6 Oct 2020 22:03:13 +0200
Message-ID: <20201006200316.2261245-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds reset support for the Sparx5 SoC, using the ocelot reset
driver.

Changes in v2:
- Dropped the parts for resetting the switch core upon load time -
  controlled by the 'microchip,reset-switch-core' DT property.

Lars Povlsen (3):
  dt-bindings: reset: ocelot: Add Sparx5 support
  power: reset: ocelot: Add support for Sparx5
  arm64: dts: sparx5: Add reset support

 .../bindings/power/reset/ocelot-reset.txt     |  7 ++-
 MAINTAINERS                                   |  1 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi     | 10 ++++
 drivers/power/reset/Kconfig                   |  3 +-
 drivers/power/reset/ocelot-reset.c            | 55 +++++++++++++++----
 5 files changed, 60 insertions(+), 16 deletions(-)

--
2.25.1
