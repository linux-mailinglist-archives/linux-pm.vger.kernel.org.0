Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72007274141
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgIVLrl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVLnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 07:43:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8F6C0613D1;
        Tue, 22 Sep 2020 04:43:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so16705230wrx.7;
        Tue, 22 Sep 2020 04:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Av0fZ69JkaQIBeo1B6gGY+Urq+AUCC2Cj5EXWWcsh8c=;
        b=MIOcIkITXgEBNgYZMz5nYcRieyB7u4OCbn3gsw4Jp9ZVMjCxnaAnueZhKuCmbz6n2R
         UFQkJGv9VyQ2AgO0fDVwnmibFcWbvrz2Vb3B9zRr1IyWIOIuy6tt8c1NTAZJkpoL9M8B
         oEvo++vsY5swcI6USMvlmh42AA9N/hv/LDPokEfTB8CJz/b5boVpFLAsdvdMVyEZyjBJ
         zSkLHK8zviLWmi+DnO4I2KVA6a4Ex6waa4Ia1NWW0BGP1V45U8XOCk6O8qiaZXUQEXiU
         VTpamh3Otgauahaiq0bFix8fQSy24TgiQfz+ICNCRhT7zLYV5tFlOe5uLjgw+LdWxaBg
         pSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Av0fZ69JkaQIBeo1B6gGY+Urq+AUCC2Cj5EXWWcsh8c=;
        b=J8q5gK29hCK0kUKpBuVHMBtvJkz686kjaFvybLIWjuTD7lR9VQcH4tyxdV0mOi5z/X
         ssYZ9f0FgM4zKW6vU9ltVz7h3MenFE9lYO5zed/ydD/6tYP4MArDqJi9kFT6WT8chAK4
         h9h9bzm25jb6J4dtJN8JlgPz3TCudYXitAEwQOIHNCKSiNXJUOLcd5V13GPB+0I7hRa1
         OVZeoAWf8/VC/cFCniCoSUSm2CZx6tpvNkLjNcLcFIL47VJgJjgowT7nObZ16m52WYVb
         LCpCB+six35PiVDBglzV/UQOvE9YQUfLuOtujAS2e2irpkeggQJXMl3nIkMZ45ICTX5k
         ie1A==
X-Gm-Message-State: AOAM533vEpiXuOqBpMWRuObmS8cG9O4mkkUIwK0+ZYHVEq/6WwTEVXbp
        dNZ6iuruu4THYEYmCXOKqh4=
X-Google-Smtp-Source: ABdhPJzjAXxGv2RN30HTX4GdkPoOGJ56oGKzYOw0uxOo5FJuhJ/DQpzm3vI36IDA39V5eKVLEbwmLA==
X-Received: by 2002:adf:fed1:: with SMTP id q17mr4737395wrs.85.1600775008866;
        Tue, 22 Sep 2020 04:43:28 -0700 (PDT)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id k12sm26072591wrn.39.2020.09.22.04.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 04:43:28 -0700 (PDT)
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
Subject: [PATCH v5 3/7] dt-bindings: power: supply: Extend max17040 compatibility
Date:   Tue, 22 Sep 2020 14:42:33 +0300
Message-Id: <20200922114237.1803628-4-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922114237.1803628-1-iskren.chernev@gmail.com>
References: <20200922114237.1803628-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

