Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3359ED2C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiHWULG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 16:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiHWUKq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 16:10:46 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554F29BB7E;
        Tue, 23 Aug 2022 12:30:24 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id o204so9700160oia.12;
        Tue, 23 Aug 2022 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2GZridEIMW8CPRQ+2eZ76vH2Oowxq5t+h5oKo5idFyk=;
        b=dMqnqKGcGz1UnYzbfddE4tCtY5Hy6uoMm13x+BrWH8ZrfAqQ1a0HHKxgdFqDYrZ4k9
         oLCtN7XMVeZVndgPbVM8OKn2IuVAif0WeeT5WiZqvXw75dh8Zzao/jVLTaviSoLCKS5r
         l+XJ4t3bd7WAkzthhAWq3+yGH/cPJUI8+IHAPDGBX0eHCHGtYKeg1A23I4jPoBfp/UaM
         FH5v2HRyXznLBhDqcs107Fu+raytowHqpeJzd2GX3VrNzY7FoUnqkXCj3oznQB+98Pvx
         04hbE2/s8RY+39NeJYg7i9lU45zDdmEBeiUade499lhE27ilw1d/IERdmJDALLE5g+46
         vl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2GZridEIMW8CPRQ+2eZ76vH2Oowxq5t+h5oKo5idFyk=;
        b=ZbjMXpAltzA2bFBnuDkVzTfiEQQNExqHBdH1gaDWYeMKbsnl7Vm5pfUg+MoufOgYk2
         qwI1Oup23KqhKRZc9J9Ij6WJHb0UXvt5EJYeIwtGJXa/joNMLNcIlHOnSBY2e626tjB8
         xwcXc4vM3GBHveQgqJ1AewdZsCPs9Z3B9lMskZOQaDOz5s+ppszgc4yJH6OcguAfv64a
         ZElxMvXen/P102cXS/eVff7cGdBGZpPe0Jexnlc6OYLcLmeG63umZPXqtqLjEQJ2ME75
         0rTR+NRgCoHUjlBQnX2gZ8fENeFfAH4yRzjByFtkXkLJoV3PdOHtgu8n146nBSpa7T8r
         tYMA==
X-Gm-Message-State: ACgBeo0+N4TVVFmUt1wconzD74eqS08Pw/nNJj7BWbQhd7nKCKs6Tm2f
        QqqREKMcXLtCUs9sXe4SYzc=
X-Google-Smtp-Source: AA6agR6FQTc7FBuSeJDq8R2LCle7aCYOQ1HXmFoH0IhXw/srpqQcLT+Ap4fH4iW+DGzGAbUyT66T1w==
X-Received: by 2002:aca:1109:0:b0:343:25d4:9b36 with SMTP id 9-20020aca1109000000b0034325d49b36mr2005439oir.0.1661283023480;
        Tue, 23 Aug 2022 12:30:23 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id f36-20020a056871072400b0011382da43aesm4070372oap.16.2022.08.23.12.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:30:23 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lee@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V9 4/4] arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
Date:   Tue, 23 Aug 2022 14:30:15 -0500
Message-Id: <20220823193015.10229-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823193015.10229-1-macroalpha82@gmail.com>
References: <20220823193015.10229-1-macroalpha82@gmail.com>
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
index 415aa9ff8bd4..72899a714310 100644
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

