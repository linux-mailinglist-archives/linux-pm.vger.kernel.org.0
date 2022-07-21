Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAE357D156
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jul 2022 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiGUQSs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jul 2022 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiGUQSQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2022 12:18:16 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B78AB1D;
        Thu, 21 Jul 2022 09:17:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u9so2536607oiv.12;
        Thu, 21 Jul 2022 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAncHnLBpOlRUc0OOfu8cfX5QtgUJCxxL9tQZFajpgg=;
        b=Bnit3RnvVApAb0BMEMNLC5rf9A3SmIziFUfAu9GLA+7b5ZtGCSodLw6p2A1aI+nDs1
         u15wB+GGv2DJzAQh5lNIe7ldxuTcYUMiCf6ZLx2hBSbbA/qb7+f7XFLkvoMTEkxaFeA1
         DQ9V+ZfTZByF2zWCQcSYIJLVjQ5hnzDbgqtaWdDcikmCxfhoigw8FVqUQonK1FMa6XgN
         6ezVSfLYqk249M9aR1BMA5vya53fXyUeNynnGMM0pNAuhWX7Vfc0P98jjzfgS7TmEXoj
         A/D0MeJAG46M3aWVE/bzMDoW3i8/96akDLz07ziXeeW8wGhPwuegfgr7+LrRIQUssJjI
         ZHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAncHnLBpOlRUc0OOfu8cfX5QtgUJCxxL9tQZFajpgg=;
        b=56rOTmamQCgBq2anXBhU5hKQMQWjW4qN6dsNhYIwtl8P96Ogq3hOWpUzJ2sEFl15qS
         YN0hno7vXPuhfPpEEL/zVG/cbDM8KLMoH53ak3eMFrWGujss24NI3fCeahZuOZX0bIVz
         j1SFUW8dV64pSf+o0faw38klvSNomeO7whUXlRun5GO+JNPzuCyFEKjQJM0yduF1eecW
         pBrZlVzpfbTAn3NkbUFp1nai5N4/rrxm5IVF/7ReOOAVlYGAh7OpKZYmhpVNjsUW4bTR
         IGVMw+sthKatwrhq2i3vxuSvqNnnAuHWO6Fw2C0SD3XJK4wJso7HDIxQaLjqfFI/e42d
         jk3A==
X-Gm-Message-State: AJIora98uZg+mAMMBfbCWFoBkZvccHl3oFYA9pVb67h8DobUqwSV2j6h
        ZDDA9ZjrUzTdsyVfqopq3rQcwKOxqA0=
X-Google-Smtp-Source: AGRyM1v6n8kqlO/5xGGVPCCoaBUta9NonqGVhE2EvR9sUgVPEj0oKX+iaCKC0K5Tt2G8nXOCkMDePQ==
X-Received: by 2002:aca:5e82:0:b0:33a:5c00:49e2 with SMTP id s124-20020aca5e82000000b0033a5c0049e2mr4944590oib.167.1658420257560;
        Thu, 21 Jul 2022 09:17:37 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id cy18-20020a056830699200b0061cc06a886csm951732otb.9.2022.07.21.09.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:17:37 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [RESEND 4/4 v7] arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
Date:   Thu, 21 Jul 2022 11:17:18 -0500
Message-Id: <20220721161718.29800-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721161718.29800-1-macroalpha82@gmail.com>
References: <20220721161718.29800-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

