Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD6126804
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfLSR2k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:28:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35243 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSR2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:28:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so3651715pfo.2;
        Thu, 19 Dec 2019 09:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JoZyySS78BiNU1aODtc8vpSYvJMQn2ITDVR9fgmYmY=;
        b=WaaqDZqK//XLc6TXiRxt1Qqke4VgaCivw/JuTOr5sVzH2UIKthSS2zBh4NZCnAFUpG
         kMec0K2/0GBElO2NfKNj8V/XJXihE4NGyoYF/Y805KrJ2Wh+yXcYZR3UMrris97TFeei
         ktmy934BelNmAqIw8L9aTu8U7ukdKpCqsFBQmezt8YT+hm/ykwUQqFuJWM3AZI3mfLhR
         KVvmVz1/jhLUWxtdzGorniiACkGqgkj89ev9294DUYfMGvxMDtEDbTiZNTE29YKZSmbB
         yMSMpYyKyvpLC4IOUpnEOyXdB/KlKqKabiKaKjtNTgaLpFcrdVntBSuqLtdz6ojbVl9D
         5Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JoZyySS78BiNU1aODtc8vpSYvJMQn2ITDVR9fgmYmY=;
        b=hXL7i3P9l1mxbogliEHq/nzbk/KcdkOy6nAuCylog3H6vUx3+z9A077JacVt+rd5Ef
         5jmE9wvAysqYMNesqf0Fsu4/YI2Jqqv4QUE0yeVj5xMCIw9RQeYHxHn5xGEhizeYVJOa
         2DRChKA1b0Sn9hORRVHIETdGwyLROKXEAq5YwJg+QLlOw7wGsy3grNrY++ZqMiAtdaOm
         TDMhwLOLwBu9POnFy3c6YBgoSqfS24Ohd/1D5N+Eb3snxsL9VU+buLeXB2aq3DZIq/Tx
         GBmCfnjUAjY8LYBNkqPgjtuCJUAlPQjpDUpD5ANXDUlzCqq0b5+8ZdoYLI9PAJHuszq4
         QCPg==
X-Gm-Message-State: APjAAAW803nCiYWkwo15NJe3zuQ6vvE+xfSs/pXx1R+2LULGHDNWb1P2
        iMbH+FU0+XTmyCbug9sfffo=
X-Google-Smtp-Source: APXvYqztENyahsDISGwV/gwDlv84foPdppuLiWeUuJmuF3CZO4dD6xdLyJPlIgJCUz5oG+jKbC+yMA==
X-Received: by 2002:aa7:870c:: with SMTP id b12mr11025712pfo.82.1576776518627;
        Thu, 19 Dec 2019 09:28:38 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v143sm536209pfc.71.2019.12.19.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:28:38 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megous@megous.com>,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v8 5/7] arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
Date:   Thu, 19 Dec 2019 09:28:21 -0800
Message-Id: <20191219172823.1652600-6-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219172823.1652600-1-anarsoul@gmail.com>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

There are two sensors, one for CPU, one for GPU.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index e92c4de5bf3b..f9df95b2d542 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -176,6 +176,32 @@ mali: gpu@1e80000 {
 			assigned-clocks = <&ccu CLK_GPU>;
 			assigned-clock-rates = <384000000>;
 		};
+
+		ths: thermal-sensor@1c25000 {
+			compatible = "allwinner,sun50i-h5-ths";
+			reg = <0x01c25000 0x400>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_BUS_THS>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
+
+		gpu_thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 1>;
+		};
 	};
 };
 
-- 
2.24.1

