Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459758CCCB
	for <lists+linux-pm@lfdr.de>; Mon,  8 Aug 2022 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbiHHRi0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Aug 2022 13:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbiHHRi0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2022 13:38:26 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9701015FC8;
        Mon,  8 Aug 2022 10:38:24 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w196so6077585oiw.10;
        Mon, 08 Aug 2022 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2GZridEIMW8CPRQ+2eZ76vH2Oowxq5t+h5oKo5idFyk=;
        b=VNr7TmmWGkzK2opc+qR2EO6AQeT9SPjP0Xcq20dztuFkQtDlAV4AEvBdhPPILApBeR
         wo2r28snUR33fLQyZBjV7dUjG2+Etfk+nlYJrmSyQb18kTgL3xFKzpooGO1YVOSuyN+H
         SqzFmDv2MZ6ubeYfOnBAYsjulqyRlFNOb/zlztCVMfLpZ7fjFrZnETKOX4ob1qxK6+Lm
         bdD66taOpm1Ugcw6VS/pIF+WdFt6Hrq9lWkCLCKVxQUJ/Pn5kaqPHBtcZNky+06Gp9Mc
         9wv6X70ctFkJXe81XogL9yRuqAIpCe2ZOSmOAS4V0yImlP4OgxZM5mCU9U8kWuBMh7MC
         8EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2GZridEIMW8CPRQ+2eZ76vH2Oowxq5t+h5oKo5idFyk=;
        b=KZhgEVye8IUwtpD0JtBh/7Y+N4zxIoA5BWkuAqfuIMwBmGokmYrn0nRt3AwryGDKbx
         q+i/72SZ2qp6eVDu7jVrqX0gprkQ6di9su8pRJyCBH5Rf1Kjj7CcNwvQWCt5fL2wr+I0
         icPeObB/ge6gqypXwxIH4tX/Hy8DMuGhePiRliAqgRAcLf5p7wKQs0TgVJMAPic5xLH8
         fL29pJ6/73LgzN3isDCemFtdW28X7OVYAcXNyNp41geUHxqDSdeL6dXaZb0cLfgiqJM+
         bTa9TUd6n61uGBjIoeZNBv3MEYiSAxOfkN0HKSKNPKGVCYgjD/S3m+6EbewNWyGNdUHH
         wcog==
X-Gm-Message-State: ACgBeo0yVFLh/m8KW0QQOZBTtWf7F2g7QpuvC13XgT7je5uf5wwKKuRy
        QPgD8pGEclP+Vkmx5QdGwtyLS7idv44=
X-Google-Smtp-Source: AA6agR6bvE+zxkq25jcDZyy7QqdHyAByWqf5z02gpFx1yIOm9mMTRKgbRvH8ig1Okk2nan/1NhDweA==
X-Received: by 2002:a54:4394:0:b0:33a:234e:f9da with SMTP id u20-20020a544394000000b0033a234ef9damr11436821oiv.116.1659980303564;
        Mon, 08 Aug 2022 10:38:23 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id s2-20020a056870248200b0010edfa2b0e8sm2429202oaq.50.2022.08.08.10.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:38:23 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee@kernel.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v8 4/4] arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
Date:   Mon,  8 Aug 2022 12:38:09 -0500
Message-Id: <20220808173809.11320-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220808173809.11320-1-macroalpha82@gmail.com>
References: <20220808173809.11320-1-macroalpha82@gmail.com>
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

