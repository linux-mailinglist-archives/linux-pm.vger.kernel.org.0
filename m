Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E825F0AD
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 23:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIFVb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 17:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgIFVbZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 17:31:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5035DC061573;
        Sun,  6 Sep 2020 14:31:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so13387760wrn.13;
        Sun, 06 Sep 2020 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Av0fZ69JkaQIBeo1B6gGY+Urq+AUCC2Cj5EXWWcsh8c=;
        b=sY7r//0A54xnx1LywbfyeZ+zIU/CBIgWCWneYi5kGd62/5Ro2Em3qc3TiXDFB/WI76
         htku8y5uCJNiCMMA7lWYESNng8WyoHSJhlGuurKz/FEZdgSXz+y/hQ2WFg+uUiIBjwON
         GU8V9vD32gPSv/izlCqKVFQeeuRpKSwSt6NFFbGubi6o2FXyolL/Aqo1Cz5scdCNBwVQ
         w6sv3UGyU4//SL65ZsWW+v14wxejJ39edzN+nSIpVQ2tf27lTcuWiQspzNS08Sl6IUFv
         6QFUjfeewnjTrO/sVBBlyQgTYVjXr4uvIabrkAUh4y2jm0f9Frqg1JZKgrXanZtS6LG2
         dGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Av0fZ69JkaQIBeo1B6gGY+Urq+AUCC2Cj5EXWWcsh8c=;
        b=kRBXiZ5jYWUCzSukh6pYiXhTJpKBTnA4vA9mUlOAl+H8yduVDAjODc4Hw2Jw+lOhLI
         Oi8sjtTnemAEws/6JI7bsr5+GgumCE+cGTADfIlf6Qasn0vqLYPyqmOFSHxrQowpQQg+
         4uP8jGXmFjBnlG2oS1Prr1gBYqAL7l+DVa8hprebg9BF8jPTkgaI+y+7N2Oy13K0rQVS
         Mi6Etg7RGtnOqp9AuGE22u3LcD3Vpr9iVoEJQ7lTPZ6aXYpbet/e/kPtDb+1YYFM/7H8
         OFvB4SV3b4VTFCsMHBLcOsR8c6tHuxT0zsOvbWB9LpNP0RxdsW16JDltxvHik5XqguEW
         FqQQ==
X-Gm-Message-State: AOAM532M4vXaMvAc2/pINFboDSbXcYbYbmJNQvrm9sSQmZwZBspi4O7b
        unArGVAKxWwmS+uLBi4oJ5s=
X-Google-Smtp-Source: ABdhPJw6JikAmn9yqKg5ZQcwYZA1p5ub9mbJ0xgYZtScZx2JqWRU4I3fN75+bbkOr3R5Kdp63OiMbw==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr17560889wrq.381.1599427882957;
        Sun, 06 Sep 2020 14:31:22 -0700 (PDT)
Received: from localhost ([91.92.14.102])
        by smtp.gmail.com with ESMTPSA id 5sm23417637wmz.22.2020.09.06.14.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 14:31:22 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/7] dt-bindings: power: supply: Extend max17040 compatibility
Date:   Mon,  7 Sep 2020 00:30:52 +0300
Message-Id: <20200906213056.2161410-4-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906213056.2161410-1-iskren.chernev@gmail.com>
References: <20200906213056.2161410-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Maxim max17040 is a fuel gauge from a larger family utilising the Model
Gauge technology. Document all different compatible strings that the
max17040 driver recognizes.

Some devices in the wild report double the capacity. The
maxim,double-soc (from State-Of-Charge) property fixes that.
Examples: https://lore.kernel.org/patchwork/patch/1263411/#1468420

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/supply/max17040_battery.txt    | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
index 4e0186b8380fa..554bce82a08e6 100644
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
@@ -11,6 +13,10 @@ Optional properties :
 				generated. Can be configured from 1 up to 32
 				(%). If skipped the power up default value of
 				4 (%) will be used.
+- maxim,double-soc : 		Certain devices return double the capacity.
+				Specify this boolean property to divide the
+				reported value in 2 and thus normalize it.
+				SOC == State of Charge == Capacity.
 - interrupts : 			Interrupt line see Documentation/devicetree/
 				bindings/interrupt-controller/interrupts.txt
 - wakeup-source :		This device has wakeup capabilities. Use this
@@ -31,3 +37,10 @@ Example:
 		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 		wakeup-source;
 	};
+
+	battery-fuel-gauge@36 {
+		compatible = "maxim,max17048";
+		reg = <0x36>;
+		maxim,alert-low-soc-level = <10>;
+		maxim,double-soc;
+	};
-- 
2.28.0

