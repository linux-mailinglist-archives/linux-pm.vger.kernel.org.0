Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E53BAFA1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhGDW7A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhGDW6r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CFBC061762;
        Sun,  4 Jul 2021 15:56:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a6so22066116ljq.3;
        Sun, 04 Jul 2021 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vQ4cs3VgWLJga415tPCIQjUw6gZRpH8cjCgquGMc+E=;
        b=WXGLiDrr4sJOqapU3wEnrGALhG8MVKjhg71T3yAYjOEsQrkyQdztB7G4Oe8ZIHWB13
         B19wLoX2zLN+y6a3/itgszTsRSZJZicMLA2uRI6Yhpo28juz9qTxfkqEQPcKwRBu4Hnt
         rmL6vvpQS9epXd9xf1SknhuIZzwq2StLCud5OPxDyzisuVGE633hz3G5HkXkI0XMkQhT
         XIS7yOCH97KTJ6wnX/PPDf+Qqt1mYWB3sNyURQryiz/VSrx5Yil9ypa9pmEILsWN/2eA
         vGG+JJewJkc4CHCYRW8KfcbkkCO7FISK8Plsh8VEVOz1ZEEPnKh1G+7KOFbJ/S/nNBUc
         X/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vQ4cs3VgWLJga415tPCIQjUw6gZRpH8cjCgquGMc+E=;
        b=ZWppEQYE+viwvFX4ZZxGIcH40Xev5IoX4gIIawvqSVSX569SZOvYfYjnCs7lDU4B4c
         zImZxDZG0dIJm5AU+n9FhP0ky3iShMASQuK7aATTMGzAykiV9YA4qwQr4eBxNpm3rSgc
         MWm2aA/gseMtyq91xS1xLj8L1lAH2PC2UN+VHrJQKOuYOqpv8PXNZyeP55nSDgGWMf6t
         +IeCrvmLXZw8aDaIVPmo+ihV70QHQ52pW+iIVdxDvTXrrd1/C/tvvYEnM24U/vqTADUT
         jbmgsJD9SRW+zwhk0+NXWXSbOd/mA7hb1OQ7/PaE59vcnnEhIoKpfJVttKyYmvr0tmHq
         IHBw==
X-Gm-Message-State: AOAM533rbhSFp5UiDpWr6SeQLfgbZqst7lhDmRtZm/uQIuc3jYIKrlR1
        qioPrDmkw88pJYKVi5Glvyo=
X-Google-Smtp-Source: ABdhPJyZOce6aAlIj+jfnWSBP2TDS7LDzvVA4QRvDqQidi0R5ZPHESWzLzR96eJdYN0nVg1SwxvGCQ==
X-Received: by 2002:a2e:9544:: with SMTP id t4mr9042352ljh.474.1625439368744;
        Sun, 04 Jul 2021 15:56:08 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 12/12] ARM: tegra: nexus7: Enable USB OTG mode
Date:   Mon,  5 Jul 2021 01:54:33 +0300
Message-Id: <20210704225433.32029-13-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Nexus 7 has OTG-cable microUSB port, enable OTG mode. USB peripheral
devices now can be connected to Nexus 7 using OTG adapter, switching
USB port into host mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index 8bc552b09672..c341e8971b2f 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -941,9 +941,29 @@ power_supply: charger@6a {
 			interrupts = <TEGRA_GPIO(V, 1) IRQ_TYPE_EDGE_BOTH>;
 
 			summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW>;
+			summit,inok-polarity = <SMB3XX_SYSOK_INOK_ACTIVE_LOW>;
 			summit,enable-usb-charging;
 
 			monitored-battery = <&battery_cell>;
+
+			usb_vbus: usb-vbus {
+				regulator-name = "usb_vbus";
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microamp = <750000>;
+				regulator-max-microamp = <750000>;
+
+				/*
+				 * SMB347 INOK input pin is connected to PMIC's
+				 * ACOK output, which is fixed to ACTIVE_LOW as
+				 * long as battery voltage is in a good range.
+				 *
+				 * Active INOK disables SMB347 output, so polarity
+				 * needs to be toggled when we want to get the
+				 * output.
+				 */
+				summit,needs-inok-toggle;
+			};
 		};
 	};
 
@@ -1017,12 +1037,13 @@ sdmmc4: mmc@78000600 {
 	usb@7d000000 {
 		compatible = "nvidia,tegra30-udc";
 		status = "okay";
-		dr_mode = "peripheral";
+		dr_mode = "otg";
+		vbus-supply = <&usb_vbus>;
 	};
 
 	usb-phy@7d000000 {
 		status = "okay";
-		dr_mode = "peripheral";
+		dr_mode = "otg";
 		nvidia,hssync-start-delay = <0>;
 		nvidia,xcvr-lsfslew = <2>;
 		nvidia,xcvr-lsrslew = <2>;
-- 
2.32.0

