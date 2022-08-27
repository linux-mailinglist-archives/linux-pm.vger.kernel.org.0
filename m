Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A65A33C0
	for <lists+linux-pm@lfdr.de>; Sat, 27 Aug 2022 04:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbiH0CQm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 22:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345399AbiH0CQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 22:16:40 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2136061D6C;
        Fri, 26 Aug 2022 19:16:39 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11cb3c811d9so4325127fac.1;
        Fri, 26 Aug 2022 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2GZridEIMW8CPRQ+2eZ76vH2Oowxq5t+h5oKo5idFyk=;
        b=VqhINItpw2XkGViR//dC8OW5gBh3IRF2mKwplTJ0ssmcZT5qvj8wOZUVhdhBMN2DFw
         Kxr4JdM59LmTUeBYv/AKSDjbZWwH32fUabZdJ3JkbhvaaOZs7eTwBmQ4VCY+HYxlKp5X
         hoMmarS1b4X6jacWQUqAK/gMi5HMzxglduEiLoKOEaM+fHGWQLxPmAzyY7U4wnAN7Y0e
         uwlboUXrFPS3wSBfHtgpUex2He/Xv48YHI/ifAZzLAbrENHGrTJPtotItQfdazTCwlcm
         rgz/E40gXuhUSJzVy1VbIttg/48jBMGMcpXNcHrgO7tPtI4+W6AkePTyuu2VkzSIYz8J
         wXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2GZridEIMW8CPRQ+2eZ76vH2Oowxq5t+h5oKo5idFyk=;
        b=6TWjoLSPrjMiW1kxim4ZGHPQI+2ZHRqVJz+4fIA22uznvmDJzvf0IQO16/LlLmUqYo
         etD1MifeGR0caMft0+ByXf9PNf7zYvjaYmN/sWC77cqQOfOQpMaqfho1ZNhWzeo3E9Np
         jvgrRlDyykONMH+hBBj0bmIWcz5cB0L0nsANFH5CaFAXUD0cDw6XAeaqbLk8iIqJfQeB
         u4T26XQ14dPMI15ZHdEPDJS7EPqlZXt5Ayp5k+XNnV+Irn8NNNwFKwvqBtv0oT2gha4t
         VC9xcbfou9O063qv39PvNGv+WUXlDui8QDRlc6/8X2EYSSPQcGUIV45tBQp7wnxP/UuV
         mrEA==
X-Gm-Message-State: ACgBeo3T9EWhZRnV5UNWSmB5z3E3HetyGTv0YK7FY/A0o9v+/74hsDl0
        cPcAyC2gfuSB29QxXi9UeCBF/aRAE7c=
X-Google-Smtp-Source: AA6agR6geDGUHxUz7PKBVAf1gxnKGlENRQZD1p9+58mCEZNijq987/wTA2oDFwzbblKnhWE7QdKpWw==
X-Received: by 2002:a05:6870:d795:b0:11c:fc91:94e8 with SMTP id bd21-20020a056870d79500b0011cfc9194e8mr3339584oab.24.1661566598141;
        Fri, 26 Aug 2022 19:16:38 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id q4-20020a9d7c84000000b0061cd208fadesm1925752otn.71.2022.08.26.19.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 19:16:37 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lee@kernel.org, philip@pscan.uk,
        mazziesaccount@gmail.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V10 4/4] arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
Date:   Fri, 26 Aug 2022 21:16:23 -0500
Message-Id: <20220827021623.23829-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827021623.23829-1-macroalpha82@gmail.com>
References: <20220827021623.23829-1-macroalpha82@gmail.com>
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

