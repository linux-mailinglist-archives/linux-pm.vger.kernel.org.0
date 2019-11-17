Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE20DFFA4C
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2019 15:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfKQOgC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Nov 2019 09:36:02 -0500
Received: from gateway30.websitewelcome.com ([192.185.198.26]:38541 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfKQOgC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Nov 2019 09:36:02 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id D68CA4F5D
        for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2019 08:14:42 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id WLK6iYEgOBnGaWLK6i88qo; Sun, 17 Nov 2019 08:14:42 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TW+3zC7f5QFpsJZdkCGHzqRD76y7rl/5etwZN6tUe7A=; b=a14FreoEnSwooYHeX1+EstLKva
        cmnF39DsVD+Jpr7A6Eq2+6Dz1UozwRot0wvyBelu6gTteaeHExdV/RpHfc5sKg+bH5+1A1D6pwUUE
        cRGEcSckUfzZXDE2h8sb+eu6x+fZDfIzDFMhTK9dlGJ2pme/UNyJ/HVOB3o3ufocsfrq01NOL0/0+
        dI83VECj5czt53uLxr7Astqp1/nm3djjANfibxD45gHwS+g/aOPuhjhMJ+dqByZpQASAw3zeuBHvr
        D0X53qddOsQrg6/HNUkkT+WvR2PtdDYCuTzfD6SwT7v/51Q2yo9VVGk6QHNtqYORP/HYOtk2ky9Ad
        m44oXJYg==;
Received: from [186.222.229.111] (port=47408 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iWLK5-001Ad4-KP; Sun, 17 Nov 2019 11:14:42 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 2/5] dt-bindings: power: supply: Max17040: Add DT bindings for max17040 fuel gauge
Date:   Sun, 17 Nov 2019 11:13:32 -0300
Message-Id: <20191117141335.23404-3-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191117141335.23404-1-matheus@castello.eng.br>
References: <20191117141335.23404-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 186.222.229.111
X-Source-L: No
X-Exim-ID: 1iWLK5-001Ad4-KP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [186.222.229.111]:47408
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 26
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Documentation of max17040 based fuel gauge characteristics.
For configure low level state of charge threshold alert signaled from
max17043/max17044 we add "maxim,alert-low-soc-level" property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../power/supply/max17040_battery.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
new file mode 100644
index 000000000000..f2d0b22b5f79
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -0,0 +1,33 @@
+max17040_battery
+~~~~~~~~~~~~~~~~
+
+Required properties :
+ - compatible : "maxim,max17040" or "maxim,max77836-battery"
+ - reg: i2c slave address
+
+Optional properties :
+- maxim,alert-low-soc-level :	The alert threshold that sets the state of
+ 				charge level (%) where an interrupt is
+				generated. Can be configured from 1 up to 32
+				(%). If skipped the power up default value of
+				4 (%) will be used.
+- interrupts : 			Interrupt line see Documentation/devicetree/
+				bindings/interrupt-controller/interrupts.txt
+- wakeup-source :		This device has wakeup capabilities. Use this
+				property to use alert low SOC level interrupt
+				as wake up source.
+
+Optional properties support interrupt functionality for alert low state of
+charge level, present in some ICs in the same family, and should be used with
+compatible "maxim,max77836-battery".
+
+Example:
+
+	battery-fuel-gauge@36 {
+		compatible = "maxim,max77836-battery";
+		reg = <0x36>;
+		maxim,alert-low-soc-level = <10>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-source;
+	};
--
2.24.0.rc2

