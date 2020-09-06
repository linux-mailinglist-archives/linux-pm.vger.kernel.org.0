Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD625F0B7
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 23:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIFVbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 17:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgIFVb2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 17:31:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4B4C061573;
        Sun,  6 Sep 2020 14:31:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so13441508wrm.2;
        Sun, 06 Sep 2020 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fonzV6H3kUDytr9hBf4pACI65W7dWeL4Kqz5kV0SbFc=;
        b=jHgbO1mfkEROljBnQh+7tTheHs6f4lfQ5B9+n8JIAL4H8HpkScxzQuveINgodOgINe
         Fq+iWunWveCw+StD6czf+uMuxmewK2F86P5lFBNI4kV8RONnvL7scQkrNjcg+41DkCFT
         mvI/u3ZNzKKO/6R/a3x0z6Y0x74XS6ugODPfSDQ5dmPjrn98xmgKTybRb0di13JN0qoj
         cxE6/S7MnH3w226HFfpIp98MEejWhV+KJ7PwHABolA0DDQiX3tiE2Zz3KzgUcSbNmi+X
         or84p025D3Kde6fQrwYj40CjVObVD0OE4wuWeVZNyV+1muEplcYGyJlfX4lJZ0TrOVvL
         YzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fonzV6H3kUDytr9hBf4pACI65W7dWeL4Kqz5kV0SbFc=;
        b=T1J+BRpFoVauhyHwVSZM/8B7JCBKS2xFb3A4LRCZBwtG6BvTczB9Jr070v5qQRZugN
         6Sl7pu36AFPhk2yj1TysgNV0G740/bnkh4HZlVjktGATS6YVN+XlC90vnmDr/PIS+kCu
         5rH2VO/lvGmh12RBxwUqkf//9FY+VSEfmNlAiAma2tehakibEUF+Od1gIkq+jF+fVZjR
         svTYzeAZmcaHlSCVtsXjIpLeBL33uH397nWt5R21AGUVXFux9RSkm+GVXk1DQQgLkt5H
         SN7jSANEOUHZNhYQ9NPyw4vkGkK1XCWgi191lzg6tOjBuAGwR+BeECJKm5OTAMVUkpYJ
         sEog==
X-Gm-Message-State: AOAM530kLGjzyR2+3cc+RMR7zVl/zCxgm0+QnRmqjp50EYHYaa/X2TeK
        NyZPtWjWqwizPi5gvTRgtYc=
X-Google-Smtp-Source: ABdhPJzuOkfXTt+5yMGmQzzQBnltcp85WSN9g+RIzPyHtmzdce5BEGZY9hfgOnABvuZPu+raTCWFKg==
X-Received: by 2002:adf:db43:: with SMTP id f3mr19882859wrj.219.1599427887217;
        Sun, 06 Sep 2020 14:31:27 -0700 (PDT)
Received: from localhost ([91.92.14.102])
        by smtp.gmail.com with ESMTPSA id v17sm24689966wrr.60.2020.09.06.14.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 14:31:26 -0700 (PDT)
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
Subject: [PATCH v4 5/7] dt-bindings: power: supply: max17040: Add maxim,rcomp
Date:   Mon,  7 Sep 2020 00:30:54 +0300
Message-Id: <20200906213056.2161410-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906213056.2161410-1-iskren.chernev@gmail.com>
References: <20200906213056.2161410-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To compensate for the battery chemistry and operating conditions the
chips support a compensation value. Specify one or two byte compensation
via the maxim,rcomp byte array.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/power/supply/max17040_battery.txt   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
index 554bce82a08e6..2cf046d12d922 100644
--- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -17,6 +17,11 @@ Optional properties :
 				Specify this boolean property to divide the
 				reported value in 2 and thus normalize it.
 				SOC == State of Charge == Capacity.
+- maxim,rcomp :			A value to compensate readings for various
+				battery chemistries and operating temperatures.
+				max17040,41 have 2 byte rcomp, default to
+				0x97 0x00. All other devices have one byte
+				rcomp, default to 0x97.
 - interrupts : 			Interrupt line see Documentation/devicetree/
 				bindings/interrupt-controller/interrupts.txt
 - wakeup-source :		This device has wakeup capabilities. Use this
@@ -41,6 +46,7 @@ Example:
 	battery-fuel-gauge@36 {
 		compatible = "maxim,max17048";
 		reg = <0x36>;
+		maxim,rcomp = /bits/ 8 <0x56>;
 		maxim,alert-low-soc-level = <10>;
 		maxim,double-soc;
 	};
-- 
2.28.0

