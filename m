Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3640EAFB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhIPTnj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 15:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhIPTnj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 15:43:39 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401F5C061574;
        Thu, 16 Sep 2021 12:42:18 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso9709632otr.13;
        Thu, 16 Sep 2021 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTuSMH4A7Ffb6ZlHMh0V3hg0lEYSc6xST4UQtOrkdPg=;
        b=iDHZt+X3Ab83QWM+zioYv8T9mPVyWyN18lkIQ67D0wE5HebPGEb8XAXU1FmswZdEON
         0I8TR39I0TIgpEMqMnTVu3GO4vSIiNv2zZORBrfBCCVr+BS6POJsjYC2SeJN+OMg81ns
         YvzHde2N5G1pDD58k5cO7tnBF9CdEetD4wjAZwvEFv/dO56IVkMBwq8nPZE46Ruizfkt
         Z4nVz0zFbKptl5Aa4F3Y0kdJDtbGXFnp1xbx7ILUCyoFT0MwbxDzactX+fLOl+zQuKTG
         ydBoaNphuuV6UOjfj0k2XeXNBqtsnIrMjmdNQ2sxKQQ7d3pFRl6JeMcBSuEy8r+5HXKd
         uASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTuSMH4A7Ffb6ZlHMh0V3hg0lEYSc6xST4UQtOrkdPg=;
        b=GiY1IOUVmXTH3fA2riwKKqEFYMkM62KL1NOuye4VOgC0NGoyOMIACCZjyJvagngOGZ
         RjfTifv73dYeWVb2vQsTlogmvDRzl1tWMv6vSIuNHeTvMdt7u7UxxsaHvdMYzZxgDOLI
         CkRRIklyeklsJzJMT1BLKKGgq+H89fa4OfO8NhSvI30ZsJ1GaIAVKhw6PY4F3FmSHE2v
         IkS9hjGETcJekg5JWwtJKj0me9oVvWxAY2As01nufCTws6ENW2tQR5t2x/vB+wgptzS+
         gnM2WJ+Hmg4t3xBY0WhamI20x1tnl1N/F+Ql56PoQZu/dmvaSA6YZX0LlV64SXYVM4D1
         lxvA==
X-Gm-Message-State: AOAM531r/7/eu7d5rItIIimDU2AS8A2dAfpx9OP2HVNYP7PzEzchJGwQ
        XhMaxSbn07WRXd08LMkgYSI=
X-Google-Smtp-Source: ABdhPJwhg8JOIgJgx1O1LOuW4rSayLJgA72Qlw2tltl2ImAglUJNyczSTwL0CnDUqhd49eJOWr3Htg==
X-Received: by 2002:a9d:798f:: with SMTP id h15mr6000781otm.227.1631821337664;
        Thu, 16 Sep 2021 12:42:17 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id c10sm963359ooi.11.2021.09.16.12.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:42:17 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, heiko@sntech.de,
        sre@kernel.org, maccraft123mc@gmail.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 RESEND 4/4] arm64: dts: rockchip: add rk817 charger to Odroid Go Advance
Date:   Thu, 16 Sep 2021 14:42:08 -0500
Message-Id: <20210916194208.10387-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916194208.10387-1-macroalpha82@gmail.com>
References: <20210916194208.10387-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 7fc674a99a6c..aff8d0768c5a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -52,6 +52,25 @@ backlight: backlight {
 		pwms = <&pwm1 0 25000 0>;
 	};
 
+	battery_cell: battery-cell {
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
+		ocv-capacity-table-0 =	<4106000 100>, <4071000 95>, <4018000 90>, <3975000 85>,
+					<3946000 80>, <3908000 75>, <3877000 70>, <3853000 65>,
+					<3834000 60>, <3816000 55>, <3802000 50>, <3788000 45>,
+					<3774000 40>, <3760000 35>, <3748000 30>, <3735000 25>,
+					<3718000 20>, <3697000 15>, <3685000 10>, <3625000 5>,
+					<3500000 0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -462,6 +481,13 @@ regulator-state-mem {
 			};
 		};
 
+		rk817_battery: battery {
+			monitored-battery = <&battery_cell>;
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

