Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968F72DC093
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 13:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgLPM7C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 07:59:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34838 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgLPM7C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 07:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608123541; x=1639659541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=y0VIgEcAfnFxlzKPzgHfAm5WyrzSYYbMAuV62pyP/44=;
  b=zAGNKXkbrj+ke9IIn5d9KrTMehIXv69yYJTTrR23bypF4Jbum80BhHeh
   /Tt9HTIySB30+fWp6Jvqd984jtdsB3Ojb3S7n2yDjGbnzoYbpO71Wq2LP
   4lLVzvmQIG2BmppnKy1asHp3KAoJw92H0ttZIYxsQ1lMuM3eZIhyhqcIT
   4v7nTDPeSjHvio1JLH/GvVtPXdTrnSmsY+rJpZBsQcYuCupx3IEMNEj8y
   g4a/L6L8tRlSlK16Lqs2rdMAKXf02SIquX53KuGk/3OgZFubjYk/VvGK/
   yjmU4dDsNNrT+p0Xs4FcipQZb8dBotmxOuL/l8DfjvOioLEm4LOG5SJQi
   A==;
IronPort-SDR: GzKGhUVLILj8KTKbCL/NhPPttsrv4Hq5cV8yfyN2dnMCYgoF3SQAbkS38aVmf2OIKrNuYSmtqP
 Ic9OzxxMDb+PWIO7r235k5MDfO0nmy9qtu2MLWBx6fbA6E06vJiTRoT2GG/4dolrRNtf6TOALe
 40nHbBz2Dhc+NAm/A7bi0I85iN3sAjYj/JOwz0gOvYgiMGbeY7U1HQ9hD2XWLhrln/tHT5otcK
 5peP69BTNfWNWpcqW4UH67KWG6lmVpTmD3KXXw12/efbyzwO0rQ3RQlHACawkz8Zsk2sFHyWal
 cos=
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="102993959"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2020 05:57:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 05:57:45 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 16 Dec 2020 05:57:43 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] power: reset: at91-sama5d2_shdwc: fix wkupdbc mask
Date:   Wed, 16 Dec 2020 14:57:31 +0200
Message-ID: <1608123453-1423-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to datasheet WKUPDBC mask is b/w bits 26..24.

Fixes: f80cb48843987 ("power: reset: at91-shdwc: add new shutdown controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index e90368ed6f71..3996167f676f 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -37,7 +37,7 @@
 
 #define AT91_SHDW_MR	0x04		/* Shut Down Mode Register */
 #define AT91_SHDW_WKUPDBC_SHIFT	24
-#define AT91_SHDW_WKUPDBC_MASK	GENMASK(31, 16)
+#define AT91_SHDW_WKUPDBC_MASK	GENMASK(26, 24)
 #define AT91_SHDW_WKUPDBC(x)	(((x) << AT91_SHDW_WKUPDBC_SHIFT) \
 						& AT91_SHDW_WKUPDBC_MASK)
 
-- 
2.7.4

