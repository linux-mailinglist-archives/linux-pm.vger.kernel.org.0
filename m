Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51E2F25EC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 04:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfKGDSr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 22:18:47 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.210]:11560 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733118AbfKGDSq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 22:18:46 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 39A23410337CA
        for <linux-pm@vger.kernel.org>; Wed,  6 Nov 2019 21:17:23 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id SYIVi85tMiJ43SYIVihaC2; Wed, 06 Nov 2019 21:17:23 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H+g7AYW8DqVIzvI+3N37//r3zkgiBk8GNs4olp1Yr9M=; b=U91k772fD8fY5roAOyl7gkffgL
        x8A2ije+wEM1tu4ATFKlH0qHZbnChSsjYPrL7vMsFUIBY82XoKdRlOJkxurc6nFMs+NUWvVSRTP9K
        C5x5j6++848Zc2f/m5w4dt5dQPc71ppSqARGSS1o3TbIF+hfjQrHvZ0v4LkpUZVEtM5kFo0s2eg0i
        i76o/pNsumT2sdPXsdDeIcpm12S71VQbdzxudC/VgASYt+uvv+2uXd2sE9kWdDiM/LRVhgjTQpOj6
        LIe3iK5CIWNARfoKn+VpHOifp3BoKrkXvlqs9c3U73NEccnVjoxVNHDkXcqro/A0AJNCltaqJJwFf
        zmJ1A08A==;
Received: from [191.31.194.59] (port=34854 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iSYIU-000Mrk-9w; Thu, 07 Nov 2019 00:17:22 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v6 2/5] dt-bindings: power: supply: Max17040: Add DT bindings for max17040 fuel gauge
Date:   Thu,  7 Nov 2019 00:17:07 -0300
Message-Id: <20191107031710.5672-3-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191107031710.5672-1-matheus@castello.eng.br>
References: <20191105095905.GA31721@pi3>
 <20191107031710.5672-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.194.59
X-Source-L: No
X-Exim-ID: 1iSYIU-000Mrk-9w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.194.59]:34854
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 40
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

