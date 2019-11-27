Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BB310AA24
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 06:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfK0FaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 00:30:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43295 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK0FaH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 00:30:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id h14so196207pfe.10;
        Tue, 26 Nov 2019 21:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9R7+DQrvs6TQPapCAJo0gk7ntwM61doRyvwyArb+eI=;
        b=TH8Cv41KFqnO7YoWhF3rUR1KCNUQJDWeIWCGHjxg+IoW5wMeCB2YlPG+nzKRWR7hf0
         MxQ0cDN93bo4wWlrE9FvswOP05pIKVpdcEhRj0WcRGaQYcb3WLXGFM9YlVQCJ1UI/0u7
         Lp8gLjpxu1/xO7JUwotlfW0WFz1XiwHhSHACilfn7HOzTcXC7QMiGQjcnqNFhU13Mdle
         5SFBHc0iO4GABmm+pWKmStDq/jZF9s4RXg0VWfeP5X/+bZaWSZy0ihRODHIc+W8K8bpN
         CXEfV5zgzQ0zp9rAkPfkqpjFp+H/FLGZQZ/ZHOFzBLoaIhMxC7sDnUeHJ+OeSU7sRv7b
         02DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9R7+DQrvs6TQPapCAJo0gk7ntwM61doRyvwyArb+eI=;
        b=DtTXgQRbsZRJ7OdosyAKb3zQWATHuPl+Oh8vPn6cmT30MiC9LNvhAF2/J4eYFrDlhd
         kdLH68w1PDwJUxpMGb8qkDRA3ZdIqogmm0oRzTUSXBC21oonOczQZpIgaX7MSqh2Jdsl
         SdTpmnuDDkmZN5z+A/M+d7ZKlDNwasEszQ80YhIqinCnYbIL3TpHsIKC0K2zuDMox0rt
         mtAJ3Ilpo77/PfOKlZJUSQkxqGoagkRN1vxijOHCapZvNsdVByoJacjOomMiSA9rcRgZ
         hYECPwURssylD6ITRH9nfvMXMpou710Zqj3XNfDgvRvEOK7gb16oczm0TCeDOZtq/tW1
         ckng==
X-Gm-Message-State: APjAAAWlaqGqSH5WmvWmvBZ1FwjflYkqp/CUlV2jVyHW2VeVhLtR9WDD
        UMOLC2c9jBTlD5W/l5HBH98=
X-Google-Smtp-Source: APXvYqxTI+MD/D0kvl0k+/tjZfeKHHZWlWyAB8qP26s2p6gtSih/hYSQl8OXFDwnSnq2wB0zXiS2ug==
X-Received: by 2002:aa7:90d5:: with SMTP id k21mr45284823pfk.178.1574832606794;
        Tue, 26 Nov 2019 21:30:06 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id p38sm4360825pjp.27.2019.11.26.21.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:30:06 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
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
Subject: [PATCH v6 5/7] arm64: dts: allwinner: sun50i-h5: Add thermal sensor and thermal zones
Date:   Tue, 26 Nov 2019 21:29:33 -0800
Message-Id: <20191127052935.1719897-6-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127052935.1719897-1-anarsoul@gmail.com>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index f002a496d7cb..27fb0d2fc9a7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -167,6 +167,32 @@
 			assigned-clocks = <&ccu CLK_GPU>;
 			assigned-clock-rates = <384000000>;
 		};
+
+		ths: ths@1c25000 {
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
 
@@ -212,4 +238,10 @@
 
 &sid {
 	compatible = "allwinner,sun50i-h5-sid";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	ths_calibration: thermal-sensor-calibration@34 {
+		reg = <0x34 4>;
+	};
 };
-- 
2.24.0

