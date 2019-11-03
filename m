Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C023ED606
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 23:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfKCWIk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 17:08:40 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48174 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfKCWIk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 17:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1572818918; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=/EPj4Iza17N8gPM/llWGgmaRA7Okh4ILYdXdlgDqNwc=;
        b=Q8w14l5hw/Pvm2aODE3I01Of+4noTkO2NZxlLj6DzM8mX4ZsgmNVsxvrDRdbJVoTZWpful
        tWj/4bODx1GlZV3u1TUDSTRlhfo0Xuz9klHcag7w6ocQY8YmUv4sXzxdidZcY1BdQrzOEa
        EyAosBU6fpv1Qt95h5euQ2KBVd5g/Y8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: power/supply: Document generic USB charger
Date:   Sun,  3 Nov 2019 23:08:00 +0100
Message-Id: <20191103220801.10666-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add documentation about the devicetree bindings for the generic USB
charger.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/power/supply/usb-charger.txt     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/usb-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/usb-charger.txt b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
new file mode 100644
index 000000000000..fd46734cb0e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
@@ -0,0 +1,24 @@
+Generic USB charger bindings
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Required properties :
+ - compatible : should be "usb-charger"
+ - phys: phandle to the USB PHY
+
+Example:
+
+usb_con: extcon {
+	compatible = "linux,extcon-usb-gpio";
+	vbus-gpios = <&gpb 5 GPIO_ACTIVE_HIGH>;
+};
+
+usb_phy: usb-phy@0 {
+	compatible = "usb-nop-xceiv";
+	#phy-cells = <0>;
+	extcon = <&usb_con>;
+};
+
+usb_charger: usb-charger {
+	compatible = "usb-charger";
+	phys = <&usb_phy>;
+};
-- 
2.24.0.rc1

