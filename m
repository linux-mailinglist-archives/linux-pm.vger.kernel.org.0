Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C82A52DA94
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbiESQry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 12:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbiESQqC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 12:46:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EAD24BF8
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 09:45:54 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m25so7159744oih.2
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAncHnLBpOlRUc0OOfu8cfX5QtgUJCxxL9tQZFajpgg=;
        b=hJy6IxH21tG0Q2UVRI6I0zpPJBekBS3BT51UmhrFdjVWmuOIh75PYs12fFPvf5Hhmk
         OHERQ4aC7BLYotIVpL1fykIFL7ZSwuRMuxXJ2hCCbT7igx+rb2hdWtayaJ1RFfqL7Kif
         AU6C0gQagpcxlkaUvO9yZvBRam5QI+98UHdIIfgLmC7jqslf2Wsxc9wqMPMEELoGcJAs
         Qr38w+dazgnW0y/pYniDTTKMDktRVOMGy7Ufv//p3gRBz0BhUPQ3mB939KaCS3xcElZs
         P231f4tlbL60zVDOuMDS0PuK1xDKGNP+8T3ldEsmu9HEvUqDsiVV5g7G0V0j1VMiSKmr
         jtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAncHnLBpOlRUc0OOfu8cfX5QtgUJCxxL9tQZFajpgg=;
        b=abUO09UtwELbAj0DoJ9xj5x/G6tDH0NARmZdfa87OZwczJZ8M2yy8iRj1aCSuGGfZO
         g66BYoi6iqghEhnebeffL4LomUROoXqr1rrt9cFqSWo/IsfiPFR/3Qby/rbPsA7/mJEd
         HGJzQqw1Z2SJTM+G64UPUdKOJCzswDBr8eF8a5PXp2neGEHTY3YXADI6RQkT26n1uQUx
         94iiGbS4iFfsRC4Trr+lioXhtSwmpI5nq+8bbOCZYQDmxsKdsXKb6jtuv7DOsBgtbQhh
         y498KKJN9r03x9CrWVn+mYu49dtxhHGA8YvkoGPE2fQFur+nv9f3bOq92I/U2tAT+C7T
         tjJA==
X-Gm-Message-State: AOAM532gBliVvbfY4QbYrzkVKw1jJOhV10+yoA9ipRg1xjfhWeyOhyOd
        uXkrd3RYoIVbajymj9+OPyV+lg1+dwFzOg==
X-Google-Smtp-Source: ABdhPJz551tN9FM+mkMdW4A/XUbEeb/DtY+Y/vclXl9Gt1dtCrgtIQkaivvVQHph2qP/N47jz4ikPg==
X-Received: by 2002:aca:5889:0:b0:32a:f591:8731 with SMTP id m131-20020aca5889000000b0032af5918731mr828910oib.270.1652978753548;
        Thu, 19 May 2022 09:45:53 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id i20-20020a9d6114000000b0060ae5f10973sm575601otj.15.2022.05.19.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:45:53 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, sre@kernel.org, jon.lin@rock-chips.com,
        zyw@rock-chips.com, zhangqing@rock-chips.com,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH 4/4 v7] arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
Date:   Thu, 19 May 2022 11:45:33 -0500
Message-Id: <20220519164533.1961-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519164533.1961-1-macroalpha82@gmail.com>
References: <20220519164533.1961-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add the new rk817 charger driver to the Odroid Go Advance. Create a
monitored battery node as well for the charger to use. All values
from monitored battery are gathered from the BSP kernel for the
Odroid Go Advance provided by HardKernel.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index ea0695b51ecd..ba72e6716e8c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -52,6 +52,25 @@ backlight: backlight {
 		pwms = <&pwm1 0 25000 0>;
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3000000>;
+		charge-term-current-microamp = <300000>;
+		constant-charge-current-max-microamp = <2000000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <180000>;
+		voltage-max-design-microvolt = <4100000>;
+		voltage-min-design-microvolt = <3500000>;
+
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 =	<4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
+					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
+					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
+					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
+					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
+					<3574170 0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -472,6 +491,13 @@ usb_midu: BOOST {
 			};
 		};
 
+		rk817_charger: charger {
+			monitored-battery = <&battery>;
+			rockchip,resistor-sense-micro-ohms = <10000>;
+			rockchip,sleep-enter-current-microamp = <300000>;
+			rockchip,sleep-filter-current-microamp = <100000>;
+		};
+
 		rk817_codec: codec {
 			rockchip,mic-in-differential;
 		};
-- 
2.25.1

