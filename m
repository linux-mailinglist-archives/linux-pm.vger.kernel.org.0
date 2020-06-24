Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8E207815
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404392AbgFXP4z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404657AbgFXP4w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:56:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15F1C061573;
        Wed, 24 Jun 2020 08:56:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so2796128wrq.8;
        Wed, 24 Jun 2020 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SsocOkhsEBGPt4ylLwY4+agknd5SdHwSbE5z/lYrnUg=;
        b=vcsjg+WOdUVNUUl3OoEfJ4yxqra7MFSyrqsQSozD6FzBjgLAEOBa3tnynCqcCuAgeB
         k0fDK564QFFUmRe3JRopIl33gBrXT8IzO4FMF9R5Dja/gOC6H0pD0tUnh9yeuIH1Wc5Q
         iUoNDVkVCgc7kA82GVR5M01YGkq39+cXy4k9AZYwDzJNPLX6RNeaVkCBR22Rps1RTBxT
         1utl693aWjNHtjfjiLd/OUYJit8PCL2Ea9+RY3JsNHQYtuffqy+Xnty3l2alonoYT9yY
         GHUxCZFrCjrRICPullT8Vj9oT1vpJ8ZbUIoetRmabfMM1NutXO1FTXmUMlM2C9LN2Hnd
         noMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsocOkhsEBGPt4ylLwY4+agknd5SdHwSbE5z/lYrnUg=;
        b=n0FasC+6xucT/c0s2Gc/yVilp9TK02AJbCzHM9v9SdvMCnIKtDsbDAAh+BYKl9py+6
         qdB5bbpPrU7IzeqA+skbk5pMDPDUXGt6Cu5hr5Pq4/3X4x5okEZdFDy3vPHAd2WUz/xu
         aTtc3P0+orXwFJfTMsQjvf4hhev/1WJUaThhNm9wSP1Ee6CrbpnFG1NQMZYtK5L+GFb4
         /X7vuvkNS5mpuufa7Ob1zdtjSp3lu1+dsHQB4/2c3oqc4O6Kx5/ooTDCrhxkaFCyW8XV
         83EkBpOw8VS1CqTmaob5Zu7RxRhDZF8CG2wLtkIwQJwlmwxP7IIYcSDCxc1MLE8qGdZe
         he1w==
X-Gm-Message-State: AOAM532PldRy47X1YnyHz7ctnG47BVp6EOGs8Hg7EBMpJwTQcGLkyw7y
        7OMqFpQF3E3veU05asbyBrw=
X-Google-Smtp-Source: ABdhPJxv8Mb6sKrct1+QA79hTd2qvGoOEFPmWrTsskj8dTeDfsa31O6Yjmj85VeNIi0zhmcw5FYHzQ==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr31903766wrw.6.1593014210501;
        Wed, 24 Jun 2020 08:56:50 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id a22sm8289031wmb.4.2020.06.24.08.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:56:49 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 2/6] dt-bindings: power: supply: Extend max17040 compatibility
Date:   Wed, 24 Jun 2020 18:56:29 +0300
Message-Id: <20200624155633.3557401-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624155633.3557401-1-iskren.chernev@gmail.com>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
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

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
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
2.27.0

