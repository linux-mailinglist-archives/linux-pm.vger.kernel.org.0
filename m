Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF991F1EEC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 20:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgFHS1D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 14:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFHS1D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 14:27:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FC7C08C5C2;
        Mon,  8 Jun 2020 11:27:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so542405wmc.1;
        Mon, 08 Jun 2020 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvRrHd8bC9uCfGjyL3GOLoak3bX7Ko8cQb8L4zQ0GAc=;
        b=rnj2cuZyjxkdPSYoKcDyj6QKNuE7eMXvAbCFvWrs7/fSbL9S0OyUe5TArZ58/alBsa
         s7N0DyLN3wDq1pbuxD9SQOkq42mLZTfZi9JzT87baAgVcrJNyJH2x0VccOufMg9DcNFw
         Ij3xC9wNS6CXmRpLhzBxHu9h+VAJ33tTkEm268FOQCe/LtAfWpFGwR8dbI0OzHG7h7ea
         aPKHKkqGkuDN9MhvebkOSdtooabA8lyjf9oQOL7wqKhH/UyCIFRKR8fCk2A4yhYRmBsU
         +i8Brg/deaAYttupqYiPldC6Bzi+oZ3kxX9LM9Cl2sxUsVqeMsJxr+lapC6/G6AjrodR
         pNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvRrHd8bC9uCfGjyL3GOLoak3bX7Ko8cQb8L4zQ0GAc=;
        b=NnjuEhnUnccQ6bBlx2VSsSPnjOx82z3pcpxX6xlw99NMONAefL+2BsOzcNx9Pqhpgz
         htc/DeM5Y/SwkZEYXZ31RIbZ7VwZjN9oRKz9QcdcdtyZSbv4esm+RM+tR5wDOvvCjnLB
         QunkIRXc9Vb2M8PHDO0AYCYHAMt49EIEtrxLqyT3nshjaR/eBgGOAyaUv6mNJnI3JofJ
         S4oV6yb92wT1+ciTX4CiVHGzAP9/RlXTcXgCXaalXyOAdK6yLbVJf8BVOQOSfRew28nW
         OE9WAgZsmLdlTnu1ZcSEMB5AX6VDdmPCEooljIsHCBGvF8zN+0oKkiIvTM/KuuzbCWID
         zFsw==
X-Gm-Message-State: AOAM531B0ZsZqruNW6AW7IWeof69nEmpuEp65nzNPcm8eUdSf5rNXFS1
        lCwiaobyhW5W42XyOtkOTtp6OWCwAzR8kg==
X-Google-Smtp-Source: ABdhPJxYH6qX5MxKcQYcT4dhKEoWjVLVUIiLEg3kUDbhj5qn4paWnxcT4VYvH9RoLRtTVAIYoDKNqQ==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr35589wmb.162.1591640821653;
        Mon, 08 Jun 2020 11:27:01 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id h27sm663689wrb.18.2020.06.08.11.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 11:27:00 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH 1/2] dt-bindints: power: supply: Document max17040 extensions
Date:   Mon,  8 Jun 2020 21:26:41 +0300
Message-Id: <20200608182642.592848-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Maxim max17040 is a fuel gauge from a larger family utilising the Model
Gauge thechnology. Document all different compatible strings that the
max17040 driver recognizes.

Some devices in the wild report double the capacity. The
maxim,double-soc (from State-Of-Charge) property fixes that.

To compensate for the battery chemistry and operating conditions the
chips support a compensation value. Specify one or two byte compensation
via the maxim,rcomp byte array.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../power/supply/max17040_battery.txt         | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
index 4e0186b8380fa..be11cab4530b9 100644
--- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -2,7 +2,9 @@ max17040_battery
 ~~~~~~~~~~~~~~~~
 
 Required properties :
- - compatible : "maxim,max17040" or "maxim,max77836-battery"
+ - compatible : "maxim,max17040", "maxim,max17041", "maxim,max17043",
+ 		"maxim,max17044", "maxim,max17048", "maxim,max17049",
+		"maxim,max17058", "maxim,max17059" or "maxim,max77836-battery"
  - reg: i2c slave address
 
 Optional properties :
@@ -11,6 +13,15 @@ Optional properties :
 				generated. Can be configured from 1 up to 32
 				(%). If skipped the power up default value of
 				4 (%) will be used.
+- maxim,double-soc : 		Certain devices return double the capacity.
+				Specify this boolean property to divide the
+				reported value in 2 and thus normalize it.
+				SOC == State of Charge == Capacity.
+- maxim,rcomp :			A value to compensate readings for various
+				battery chemistries and operating temperatures.
+				max17040,41 have 2 byte rcomp, default to
+				0x97 0x00. All other devices have one byte
+				rcomp, default to 0x97.
 - interrupts : 			Interrupt line see Documentation/devicetree/
 				bindings/interrupt-controller/interrupts.txt
 - wakeup-source :		This device has wakeup capabilities. Use this
@@ -27,7 +38,16 @@ Example:
 		compatible = "maxim,max77836-battery";
 		reg = <0x36>;
 		maxim,alert-low-soc-level = <10>;
+		maxim,rcomp = /bits/ 8 <0x97 0x00>;
 		interrupt-parent = <&gpio7>;
 		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 		wakeup-source;
 	};
+
+	battery-fuel-gauge@36 {
+		compatible = "maxim,max17048";
+		reg = <0x36>;
+		maxim,rcomp = /bits/ 8 <0x97>;
+		maxim,alert-low-soc-level = <10>;
+		maxim,double-soc;
+	};

base-commit: 1713116fa907cc7290020f0d8632ec646d2936f8
-- 
2.27.0

