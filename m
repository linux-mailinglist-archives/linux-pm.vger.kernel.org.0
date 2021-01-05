Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7563A2EA88F
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 11:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbhAEKYL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 05:24:11 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16875 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbhAEKYK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 05:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1609842249; x=1641378249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TlZzrEOIf/3/5B+zOCXR4I8QfmzCw8MsObQuupcbP4U=;
  b=Wp5iiM4VUZMMy7JCF3UP1mnwZVVVX7sD4HzTRtbj0gQNqUuDVv9Obv3j
   FdzT0TEDtw8y4wTwLfB8vYp7ccYSyR7ENPIS7wW70EDEKbtIx0cCntA8K
   Vohj3bXAvvi5Gw8qL7ww2+Fc+FkWHPG+0SbwZUJwGlXPN1bpmtG1rlEeq
   r2W12sKmwAsfjeb7fg8gr+bwRt92Q2ZNyh/I4vi64wi1scF8aCsM6D9Qr
   HjeahOwtgKulU1H7EqfLsk8j0r4cG471PIW1cYu14EoWrj4wA3yNvMSpI
   jaPZkd0eFy8Redk+QinhtDXPYe0FjbkXY4xHJlMF7zg1sAMIvhLw+BRbM
   g==;
IronPort-SDR: OwTUI08nLLsYJEc2ZAldt7p/MYpbVWnULc2N7r/M3wt0tkt9O8H6UV0xchDK9mT0g78skganhS
 3oKFXX6qcSTVoyik9QtE+azfQBw2Z4PuMxz3voOxxtHrhnqIP8Ji+2Ob5y4oBym/PDIRCTTQRn
 mhjf4bPsNVnY5b0WxC3HjjOoG/1oiGIL71KOXco9rbvdsGi727roAHcCNoHxhY8H3o8NlV7V0B
 Llr3LgWKW8+auFozLAN2ZX28SIl/z/zUHrF1pvDlhdUGO/uZWjB997mi2XsBgt8j328iXXdA5A
 XD0=
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="99023622"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jan 2021 03:22:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 03:22:42 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 5 Jan 2021 03:22:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] MAINTAINERS: add sama7g5 cpufreq
Date:   Tue, 5 Jan 2021 12:22:27 +0200
Message-ID: <1609842147-8161-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com>
References: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add entry for sama7g5 cpufreq driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..6c19b79c56de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11769,6 +11769,12 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/microchip/wilc1000/
 
+MICROCHIP SAMA7G5 CPUFREQ DRIVER
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	drivers/cpufreq/sama7g5-cpufreq.c
+
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.7.4

