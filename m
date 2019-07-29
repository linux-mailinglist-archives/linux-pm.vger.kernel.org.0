Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F2379326
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbfG2Sd6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 14:33:58 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:40432 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbfG2Sd6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 14:33:58 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 14:33:56 EDT
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id 94D8196323;
        Mon, 29 Jul 2019 18:24:26 +0000 (UTC)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.253])
        by mxout1.routing.net (Postfix) with ESMTP id C407B40983;
        Mon, 29 Jul 2019 18:24:26 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-185.76.97.79.bambit.de [185.76.97.79])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 78DB0405D3;
        Mon, 29 Jul 2019 20:24:25 +0200 (CEST)
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>
Cc:     Josef Friedl <josef.friedl@speed.at>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v3 10/10] arm: dts: mt6323: add keys, power-controller, rtc and codec
Date:   Mon, 29 Jul 2019 20:24:21 +0200
Message-Id: <20190729182421.7192-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

support poweroff and power-related keys on bpi-r2

changes since v2: none (=v2 part 7)

Suggested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm/boot/dts/mt6323.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mt6323.dtsi
index ba397407c1dd..7fda40ab5fe8 100644
--- a/arch/arm/boot/dts/mt6323.dtsi
+++ b/arch/arm/boot/dts/mt6323.dtsi
@@ -238,5 +238,32 @@
 				regulator-enable-ramp-delay = <216>;
 			};
 		};
+
+		mt6323keys: mt6323keys {
+			compatible = "mediatek,mt6323-keys";
+			mediatek,long-press-mode = <1>;
+			power-off-time-sec = <0>;
+
+			power {
+				linux,keycodes = <116>;
+				wakeup-source;
+			};
+
+			home {
+				linux,keycodes = <114>;
+			};
+		};
+
+		codec: mt6397codec {
+			compatible = "mediatek,mt6397-codec";
+		};
+
+		power-controller {
+			compatible = "mediatek,mt6323-pwrc";
+		};
+
+		rtc {
+			compatible = "mediatek,mt6323-rtc";
+		};
 	};
 };
-- 
2.17.1

