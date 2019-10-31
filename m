Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D09EB7AF
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 20:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfJaTBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 15:01:55 -0400
Received: from gateway32.websitewelcome.com ([192.185.144.98]:32310 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729252AbfJaTBy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 15:01:54 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 15:01:53 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 175C1E6B536
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 13:41:50 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id QFOIiqt1N3Qi0QFOIiDPGm; Thu, 31 Oct 2019 13:41:50 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u9eu9WCQNyseKzoI8Ryx9iIExl/72+uskdYexjehiNk=; b=G1Lm9dgqzDhBZfmncbb1NY3Nkf
        UrAJyZ8rwlAaCbFyKhYobMYu310kkHTIgLf60Ypi+azzXJtNlo+vYhqYqBsEMPz+Un1+bezqAGkMQ
        09OBEFwIoEizfwAnAcDvYmztTgr1xOaYVY4cSgKMdVRw3nvmZyV/d76dU4d81GneZ6QtTd0WW6dtp
        blKJNAA6Pbv4lvSbq3phZT0DJWyNVP/BGLcwNE4eXTiP3ELlFr6k19M1M2/xCadkal2aAUxi/k0HC
        BAQTqISdltabD0qmLX3J1jD8XC6yaXJWrpGNmPvP8DUjFYmxXyS9wBuORKM+BVY4Vy8mmLtAEWpDW
        DDUzMjSg==;
Received: from [191.31.195.127] (port=35710 helo=castello.bz.toradex.local)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iQFOH-0035gz-3t; Thu, 31 Oct 2019 15:41:49 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v4 2/4] dt-bindings: power: supply: Max17040: Add low level SOC alert threshold
Date:   Thu, 31 Oct 2019 15:41:32 -0300
Message-Id: <20191031184134.30621-3-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191031184134.30621-1-matheus@castello.eng.br>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.195.127
X-Source-L: No
X-Exim-ID: 1iQFOH-0035gz-3t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.bz.toradex.local) [191.31.195.127]:35710
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 25
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For configure low level state of charge threshold alert signaled from
max17040 we add "maxim,alert-low-soc-level" property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
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

