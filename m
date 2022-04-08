Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161EF4F9F19
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 23:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiDHVXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 17:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiDHVXh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 17:23:37 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE6C6568;
        Fri,  8 Apr 2022 14:21:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e189so10104548oia.8;
        Fri, 08 Apr 2022 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAncHnLBpOlRUc0OOfu8cfX5QtgUJCxxL9tQZFajpgg=;
        b=eBrJh77ttbk7uak8/KwhrN0FgVTJhtQBH37Uvro0w1QPQSCdWGUFWk+Hoy5kAmN6/3
         9D14l10vBYL6DzGyxJinf5N8HJMfvNtO2Y4M8uz7g+pbFoezv3fwOhYR0v0o0cBOUKEk
         iaMMMQF2Vh0CRsh673U2cCcXjczsQocMyeU6pn6zL23yRM/iFmcQeFSGMVWf8uvsMuZ3
         q1LDicFiQB3VudXZnnuFQ7ylqWuC3dEMLOvyZvHISPz8E9Ckx3+JdoG0wOuexBcA4RXD
         FJhMR7FLx8lNc1VSXjLpEmeKRS09eE5uTOhwB6cEmgk+ruLSIkONrYtMJvA61kKf/S4e
         f6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAncHnLBpOlRUc0OOfu8cfX5QtgUJCxxL9tQZFajpgg=;
        b=wSnQPo0Wo9vgbiydaxUB+dxoQx/QAep6AiJCLU5dcSTqWnD0J1fL1MFAwRyXogYduQ
         WZoZfbndCu0xqenLyD+QoNx3i9y4HZ0tSKNB9ZZ4Hcd2OFkj4Uxu9EWRdOrM8j96bWll
         ckUtS4qAAztRjQ4C66kGlBLmkZeiVT5OTGIaoT0fMTNRNx9O1rzQmI6TPJ8ZxKHbNrIR
         TGQYT0GHof9XDK74e7XFsYUymlvvTV5oZ68VqRD+voX84XY5DvclNsUta1p3MEnBzS82
         jqBKBLEayZ+FQzZQ/+KdAfUT9FphVhBTWIU20gXduHYVC54fQdUS4e3vU77gdlssa3l1
         XWJw==
X-Gm-Message-State: AOAM530Cev/atXOtI1LFr0+p2WH37urZ8UGByzkU1SULTvjbMd0Kk/G7
        3+4j26ET1oK+y71PdSBFAdmOmr1fzeQ=
X-Google-Smtp-Source: ABdhPJwaBfTYmCbKEOtZhUm8UpxJ14O2ovNkTUdcFOP4pDItDbSIOkT/gs/Pww3s+6KRvrqny58tnA==
X-Received: by 2002:a05:6808:23cd:b0:2ec:f109:689a with SMTP id bq13-20020a05680823cd00b002ecf109689amr785881oib.280.1649452891755;
        Fri, 08 Apr 2022 14:21:31 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000de98fe4869sm9950375oab.35.2022.04.08.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:21:31 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        maccraft123mc@gmail.com, jon.lin@rock-chips.com, sre@kernel.org,
        heiko@sntech.de, krzk+dt@kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 4/4 v6] arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
Date:   Fri,  8 Apr 2022 16:21:21 -0500
Message-Id: <20220408212121.9368-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408212121.9368-1-macroalpha82@gmail.com>
References: <20220408212121.9368-1-macroalpha82@gmail.com>
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

