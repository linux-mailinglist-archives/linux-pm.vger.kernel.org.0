Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42B1FEF74
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 12:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgFRKN7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgFRKN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 06:13:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A638C06174E;
        Thu, 18 Jun 2020 03:13:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p5so5407825wrw.9;
        Thu, 18 Jun 2020 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofe7nJVAVWjLyJL8t4PpDn39yJzviAXAAMypfIFntOI=;
        b=i/HO+PxqnWKAQSyq/Xh6rEdogjYLB+ReE6hg4iTtg3eCa7x3wzIKvlEqTQ9hdLfH9v
         xUafRsV9lrYQms0zdNyXxpuSgJipptP2XkMvUrPDaw5nvtITN0kfz2ebwU2qdI7gnLv3
         0T82dRVB40i35x+V0Uy/WtNdvYW7Mvryxyr0YjG6c0PmF2voxtlH2qVDTz2H6bsmR7/i
         ubrjKECuSNy6KhyirtD+I8Fl0XOB2OVEJMHSCp/daA2VfeVx9btvf+CXrO9ugFLZoZpP
         M1eHDAn46/56ucUewhRAKK9r0ZGtKauDAkXQyKNPEgEj+MT2OqPDwu2qyB1qi4rRDHjG
         33Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofe7nJVAVWjLyJL8t4PpDn39yJzviAXAAMypfIFntOI=;
        b=rFxT26oydypQkzZoTaqkbBuHi5V/xdlh7W7jhNUoiDnvOzIqRXe2TJEEZfI9YyoGsc
         V5ZrHN5DOtZrNkBPRE/MHoj59QsrdKVz1yJ+wrw//dovv2Wm/d020Z0NcPkrGQszY7iI
         4tsm8D2mrbzZeRzf9MODX4QAgh3Evv7cKlkfiH+mTQiWeEJNmY9G81ee9NhtN9VxC3no
         t4SQk3je3izfrkFVbiTH/cg2AdIOcMwt9iWadEmbngDJFkRqu+dsv0EtF/JvDZNkN0Z8
         73fJYflejKuTa6kMucQOhCo9rww2HinYft7zgvsXbEWXHAebm6BLvBpM+CMZ3pbsKncN
         FlAg==
X-Gm-Message-State: AOAM5312BixJQtFCClwfIL7o1WNwIsd8AzNddacthf915gx6VwjaVRGr
        WcY+A+Qdktja1FbelsKg0qMFLXK7Dqs=
X-Google-Smtp-Source: ABdhPJwUJTp7kFoxbzS9NlyOX4LlbTCaL3vi3FLnL2azj38Ci4pZ9vsgReoYRfs98DH5tB2Oa6go0g==
X-Received: by 2002:adf:9404:: with SMTP id 4mr3665859wrq.367.1592475235180;
        Thu, 18 Jun 2020 03:13:55 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id e25sm3272396wrc.69.2020.06.18.03.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 03:13:54 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: power: supply: Document max17040 extensions
Date:   Thu, 18 Jun 2020 13:13:39 +0300
Message-Id: <20200618101340.2671020-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
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

Complete device reset might lead to very inaccurate readings. Specify
maxim,skip-reset to avoid that.

To compensate for the battery chemistry and operating conditions the
chips support a compensation value. Specify one or two byte compensation
via the maxim,rcomp byte array.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
v1: https://lkml.org/lkml/2020/6/8/682

Changes in v2:
- add maxim,skip-reset
- remove 2 byte rcomp from example, the specified compat string supports 1 byte
  rcomp

 .../power/supply/max17040_battery.txt         | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
index 4e0186b8380fa..3ee91c295027f 100644
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
@@ -11,6 +13,18 @@ Optional properties :
 				generated. Can be configured from 1 up to 32
 				(%). If skipped the power up default value of
 				4 (%) will be used.
+- maxim,double-soc : 		Certain devices return double the capacity.
+				Specify this boolean property to divide the
+				reported value in 2 and thus normalize it.
+				SOC == State of Charge == Capacity.
+- maxim,skip-reset :		Do not reset device on driver initialization.
+				Some devices report extremely inaccurately after
+				a hard reset.
+- maxim,rcomp :			A value to compensate readings for various
+				battery chemistries and operating temperatures.
+				max17040,41 have 2 byte rcomp, default to
+				0x97 0x00. All other devices have one byte
+				rcomp, default to 0x97.
 - interrupts : 			Interrupt line see Documentation/devicetree/
 				bindings/interrupt-controller/interrupts.txt
 - wakeup-source :		This device has wakeup capabilities. Use this
@@ -31,3 +45,11 @@ Example:
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

