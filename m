Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2902A3D2C89
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 21:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhGVSeK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhGVSeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jul 2021 14:34:06 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B9C061757
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 12:14:40 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so6290996otq.11
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0aWNNv9WpUcy7y4m+gwqybbiitO/w79/3+r+dgiLdyo=;
        b=Fe3cv5d9j3Cm64YrBiB8CZCXxUwQDfbrwSWxNvP+JGwPMLmEwQW1xE+wW8yQSJ7Plr
         wL+BV12UeiM5IlXkwnJg7m2p86JzMnRESVsps+4gDCXRvBhXWlfevoevAuCw7ia8Xaoi
         1o6NJQGRZ2cVSBnifsljUvrs4vrA1owaHFk/ipKy3ar0NL5s9MG0Ehm1c6HLezKwV8UO
         yFxdoBacgvds2uE/MhUo1fdfCsibXYU5akPOfem/Qxc7C4jmA9dzJQlaO9bLLXd5ievO
         /tZ9+9RdE6taZMDj3x5ickdKlvYDf0eCxxRJyLluztzU6i1IrZh3xTx1/hcIouNBs1tr
         4Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aWNNv9WpUcy7y4m+gwqybbiitO/w79/3+r+dgiLdyo=;
        b=b3cbHJG2xEuPdZrfdlJ5sxxIWyA/NluDR/RZB0JROx56cKeqZ7bJAPCa7ErI+ynk7P
         yHVsq69DRqxgjl5iu+D7giUdI8Iqrg1OvG3e21Yz5JVV31X3oOhflTUPo/HB2J/G3CJk
         kTbaz7z6HiarWystiR5fG6VmNtJ8JT8K72wCm8D7KzNG19pN53uIRT2772JEtNlHZ9U5
         rNvMtroO1zG/w/wBh/1lr4bCRSVqJtGaBwxLwdjXuuhTK0MAevsFW5e5vF+daafd3iyO
         o6PNAwjpVOxdKozaChe6xf8rHRehSxMcqs+fNDcJd2Gmk3+u2rrP8mlsBnol0aa9uVXi
         Es3A==
X-Gm-Message-State: AOAM533uKGUwtaqS0wWhjJM9LJ3l8YDP6c4dCRdpAw28ptlU42INdA1C
        J/VqUT3y2Bk+eiaH3WPhRjU=
X-Google-Smtp-Source: ABdhPJyveC7de70TPyQMb+WzgNIRTCsr1ebcGRtb/SzH8FpGrs9tKjSyhYQt1aQzyc3zRo3Ut/sWWQ==
X-Received: by 2002:a05:6830:2317:: with SMTP id u23mr870801ote.88.1626981279867;
        Thu, 22 Jul 2021 12:14:39 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r26sm3106167ooh.32.2021.07.22.12.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 12:14:39 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC 1/4] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Thu, 22 Jul 2021 14:14:27 -0500
Message-Id: <20210722191430.28203-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722191430.28203-1-macroalpha82@gmail.com>
References: <20210722191430.28203-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Create dt-binding documentation to document rk817 battery and charger
usage. New device-tree properties have been added.

- rockchip,resistor-sense: The value in microohms of the sample
			   resistor.
- rockchip,sleep-enter-current: The value in microamps of the sleep
				enter current.
- rockchip,sleep-filter-current: The value in microamps of the sleep
				 filter current.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/mfd/rk808.txt         | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 23a17a6663ec..fa42b6253d26 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -70,13 +70,37 @@ Optional RK817 properties:
 
 - vcc8-supply:  The input supply for BOOST
 - vcc9-supply:  The input supply for OTG_SWITCH
+
 - codec:	The child node for the codec to hold additional properties.
 		If no additional properties are required for the codec, this
 		node can be omitted.
-
-- rockchip,mic-in-differential: Telling if the microphone uses differential
+- rockchip,mic-in-differential:	Telling if the microphone uses differential
 				mode. Should be under the codec child node.
 
+- battery:	The child node for the charger to hold additional properties.
+		If a battery is not in use, this node can be omitted. If a
+		battery node is used, the following values are required:
+		rockchip,resistor-sense, rockchip,sleep-enter-current,
+		rockchip,sleep-filter-current, and a phandle to a
+		monitored-battery node that contains a valid value for
+		charge-full-design-microamp-hours,
+		charge-term-current-microamp,
+		constant-charge-current-max-microamp,
+		constant-charge-voltage-max-microvolt,
+		voltage-max-design-microvolt, voltage-min-design-microvolt,
+		and a valid ocv-capacity table.
+- rockchip,resistor-sense: Value in microohms of the battery sense resistor.
+			   The PMIC only supports values of either 10000 or
+			   20000. This value is used by the driver to set
+			   the correct divisor value to translate ADC readings
+			   into the proper units of measure.
+- rockchip,sleep-enter-current: Value in microamps of the sleep enter current
+				for the charger. Value is used by the driver
+				to calibrate the relax threshold.
+- rockchip,sleep-filter-current: Value in microamps of the sleep filter current
+				 for the charger. Value is used by the driver
+				 to derive the sleep sample current.
+
 Optional RK818 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -459,6 +483,13 @@ Example:
 			};
 		};
 
+		rk817_battery: battery {
+			monitored-battery = <&battery_cell>;
+			rockchip,resistor-sense = <10000>;
+			rockchip,sleep-enter-current = <300000>;
+			rockchip,sleep-filter-current = <100000>;
+		};
+
 		rk817_codec: codec {
 			rockchip,mic-in-differential;
 		};
-- 
2.25.1

