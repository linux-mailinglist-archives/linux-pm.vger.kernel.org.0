Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6B91710
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfHROE0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 10:04:26 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:43036 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfHROE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 10:04:26 -0400
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id 75F1E96DF0;
        Sun, 18 Aug 2019 13:56:24 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.253])
        by mxout1.routing.net (Postfix) with ESMTP id E9D6843D5A;
        Sun, 18 Aug 2019 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-185.53.43.183.bambit.de [185.53.43.183])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 493E536008B;
        Sun, 18 Aug 2019 15:56:21 +0200 (CEST)
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        "Tianping Fang" <tianping.fang@mediatek.com>
Subject: [PATCH v6 01/13] dt-bindings: mfd: mediatek: mt6397: change to relative paths
Date:   Sun, 18 Aug 2019 15:55:59 +0200
Message-Id: <20190818135611.7776-2-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818135611.7776-1-frank-w@public-files.de>
References: <20190818135611.7776-1-frank-w@public-files.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

paths in dt-bindings should be relative as suggested by Lee Johnes

Suggested-By: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
changes since v5: splitted from dt-bindings: add powercontroller
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 0ebd08af777d..ab3163a60929 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -12,7 +12,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
 It is interfaced to host controller using SPI interface by a proprietary hardware
 called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
 See the following for pwarp node definitions:
-Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+../soc/mediatek/pwrap.txt
 
 This document describes the binding for MFD device and its sub module.
 
@@ -27,9 +27,9 @@ Optional subnodes:
 - regulators
 	Required properties:
 		- compatible: "mediatek,mt6397-regulator"
-	see Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
+	see ../regulator/mt6397-regulator.txt
 		- compatible: "mediatek,mt6323-regulator"
-	see Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
+	see ../regulator/mt6323-regulator.txt
 - codec
 	Required properties:
 		- compatible: "mediatek,mt6397-codec"
@@ -39,12 +39,12 @@ Optional subnodes:
 - led
 	Required properties:
 		- compatible: "mediatek,mt6323-led"
-	see Documentation/devicetree/bindings/leds/leds-mt6323.txt
+	see ../leds/leds-mt6323.txt
 
 - keys
 	Required properties:
 		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
-	see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+	see ../input/mtk-pmic-keys.txt
 
 Example:
 	pwrap: pwrap@1000f000 {
-- 
2.17.1

