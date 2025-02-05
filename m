Return-Path: <linux-pm+bounces-21393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3546A28ACA
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1009A1625BD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7278F33;
	Wed,  5 Feb 2025 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Pebmny"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB3B664;
	Wed,  5 Feb 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759958; cv=none; b=ppieZcHz2hYH+w9IBvOuy/BlhfYfwpQW/9o5jn9tZRgMdWaF2KRvHRPiKLKd9TiuL9fv7Rh6i+ne5Nb0oBxSWVU8hq9gZ0QW/8Jc/TNQpwcRVey9GK9Odpwlk0qoZt+5RbqCgpWSxGFFgb/7ZBMNadCTXPTkxUW2hYRqprZ3X2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759958; c=relaxed/simple;
	bh=6TBomxW37eD9orK7Nb3UMxflZeeYqEOZWtxALk1VVCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJ7GmKlQZFBAqtiMdj592hFlUa9AytCwmTpOHMLB57pwrsc7SijPS5sPEyjpRgytRen7ARkYGkp+c7yApyEvA9oauYOkokJqgA72WVEO8kFu1oh3fjsA9wXdVwq4mudvUXKPp/XcQSQe9rGqrlOnwLsLJIU/pQLI926pp+StTjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5Pebmny; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so1281819a12.0;
        Wed, 05 Feb 2025 04:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759954; x=1739364754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h7BTYhKIDGSovARV/kRMaz8LzJgfzBwpICZVS1kS+4=;
        b=J5PebmnylfLjjCrC4ErN59zBc93mwHwtmRh3FwD7Um0UzlseAWaMIzMbKn1dO5LnWT
         7NTtuG0PNGjVFWW4m4MYqhCP9Tm7oMcikjq3Hy3jWitPhPgLTN0Rjmx/ZxeA5cXE3uio
         MeBkryciZO782sYDPiL5fQWV5d57THrHmYLTAschuuOn2E/a/f4agsK/4yfr1VD4LOaF
         SYiUuMB2soAJowoe/elX/39JFUWd7aFMud4uktO+Rnt7oNx1VNrILsN/SltxGdNDzoUe
         onVNTRo7qalsHy2c/7wnvRwZbgzLEBH+ZzGUn8EvyA5GuQiNnqoiv2Xnu1S9Xe1JU67u
         JeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759954; x=1739364754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2h7BTYhKIDGSovARV/kRMaz8LzJgfzBwpICZVS1kS+4=;
        b=KPbPd4xWVrZQNxyglZJiCmHyae80HVmvF9RXAZvtPkYPyoH9AeLb6G3QFJjA99QNCU
         aPkLz/dA6NFqxx6l0h/pCUx3LQRwRUJxKksPvQ/DYrpmA4NH+OsebPy8VWjVSdlANQO2
         HygSTXs38K+jsjp9ghboBpoU+7xQsIP31DwTbEqwFLyiDgIbtdvwhuhgS7SPZIORQA8k
         v2LusP2jh5g9NU06jeTrq5gWFGCf/AN7nIcUYR6/3WTZKWa9ZUNtavlNL37myEdmVZWO
         mwmeOGeMbNGSavgHCmL1mkbsjH9YwJhipk/AaKyK5or0hvy7fTiIc7t1gv9pugrb55Is
         7EOg==
X-Forwarded-Encrypted: i=1; AJvYcCU4VlZM3oPpb+Sdt9cwfQgnmrFwoJx+0NBRHw64dafNmXULGzFOE6oEbZrpQZB55ku79en9zxZr1LHt@vger.kernel.org, AJvYcCUFBx5aANX0zBFv1ZG4B46YFaMNbBgqmC+Mj0G8qNAMCnjPCf0pWzQaNnLPpe3fCSL9FWwbfmk66gfYe33n@vger.kernel.org, AJvYcCUuFw1fM36a+OCptHWCWMAIO5bHJ0IaZAe65uf+M48D3ZymI8uKPU/eneDwS+BEY1xxBTlIYNVfeAMt/w==@vger.kernel.org, AJvYcCVaZnm0aI/Q6K/LYsmNliy3LP951AFE7P4njZfPnV/R5in9bvqV25dL4xZca567RgUFx4IRB5zSN/ls@vger.kernel.org, AJvYcCVr9CTHGaslRO4JTvX0qWJ4eiQ9pDbFnkXC8pLOVCC5VGzsAWtEpC6V30ZqJE7rX8G8ArgkjuyWwIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmTqifac8/TGnQ1MhEIFLg1Plc6M41Vc9TkkaRVNQu34W55sq
	bscJ94Fr9EzA8Zt8byWlsH9iyX2Io3EyFMdKZzW6BAlVQn+Mqipa
X-Gm-Gg: ASbGnctRide1IdbifRLYF7PoA39M6ToLH+SkLoM/HtN9RirhSOKDqN0xnI0hBViwCLn
	ijvOl/jVFDwyHfY1Nf/m+DyCHXL3sgRI1l1t93BmCZmZJuEGCECHG4y5SSjIkWhfp60d8lFvrAD
	AS5oP2GBUDIB/xwEfBz96gLcpTWdVKh3q/iSlZ4srFaAVKZeP0f4R2TdwSsI4SvsBhXMZxynY/2
	mcwH8Ysk/FeRvpJcA/cpbAm0FTEX/F2p3mcE9+2WWVjkqgIg//X1E6bNLru5OtAqKsPOffcXEtT
	8Wv4J/Nz2+7hT/J3+7sQQWSPzV3WtuOMjZvJiIUTKvUXjg==
X-Google-Smtp-Source: AGHT+IGGu/7AADk3D0HpZFHZbd5mDOa9V/c+jpDgka/onZHtiRlSlj8RdhKfxdaOzwjowoHiNYitlg==
X-Received: by 2002:a05:6402:34c8:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5dcdb7295c9mr6548115a12.17.1738759953701;
        Wed, 05 Feb 2025 04:52:33 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm11559997a12.45.2025.02.05.04.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:52:33 -0800 (PST)
From: Andras Szemzo <szemzo.andras@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 03/10] dt-bindings: clock: sunxi-ng: add compatibles for V853
Date: Wed,  5 Feb 2025 13:52:18 +0100
Message-Id: <20250205125225.1152849-4-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205125225.1152849-1-szemzo.andras@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V853 has 2 CCUs, add compatible strings for it.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 .../clock/allwinner,sun4i-a10-ccu.yaml        |   3 +
 .../clock/allwinner,sun8i-v853-ccu.h          | 132 ++++++++++++++++++
 .../clock/allwinner,sun8i-v853-r-ccu.h        |  16 +++
 .../reset/allwinner,sun8i-v853-ccu.h          |  60 ++++++++
 .../reset/allwinner,sun8i-v853-r-ccu.h        |  14 ++
 5 files changed, 225 insertions(+)
 create mode 100644 include/dt-bindings/clock/allwinner,sun8i-v853-ccu.h
 create mode 100644 include/dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h
 create mode 100644 include/dt-bindings/reset/allwinner,sun8i-v853-ccu.h
 create mode 100644 include/dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 1690b9d99c3d..9369d62284ed 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -33,6 +33,8 @@ properties:
       - allwinner,sun8i-r40-ccu
       - allwinner,sun8i-v3-ccu
       - allwinner,sun8i-v3s-ccu
+      - allwinner,sun8i-v853-ccu
+      - allwinner,sun8i-v853-r-ccu
       - allwinner,sun9i-a80-ccu
       - allwinner,sun20i-d1-ccu
       - allwinner,sun20i-d1-r-ccu
@@ -103,6 +105,7 @@ else:
       compatible:
         enum:
           - allwinner,sun20i-d1-ccu
+          - allwinner,sun8i-v853-ccu
           - allwinner,sun50i-a100-ccu
           - allwinner,sun50i-h6-ccu
           - allwinner,sun50i-h616-ccu
diff --git a/include/dt-bindings/clock/allwinner,sun8i-v853-ccu.h b/include/dt-bindings/clock/allwinner,sun8i-v853-ccu.h
new file mode 100644
index 000000000000..cf56c168e1cd
--- /dev/null
+++ b/include/dt-bindings/clock/allwinner,sun8i-v853-ccu.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Andras Szemzo <szemzo.andras@gmail.com.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_ALLWINNER_SUN8I_V85X_CCU_H_
+#define _DT_BINDINGS_CLK_ALLWINNER_SUN8I_V85X_CCU_H_
+
+#define CLK_OSC12M		0
+#define CLK_PLL_CPU		1
+#define CLK_PLL_DDR		2
+#define CLK_PLL_PERIPH_4X	3
+#define CLK_PLL_PERIPH_2X	4
+#define CLK_PLL_PERIPH_800M	5
+#define CLK_PLL_PERIPH_480M	6
+#define CLK_PLL_PERIPH_600M	7
+#define CLK_PLL_PERIPH_400M	8
+#define CLK_PLL_PERIPH_300M	9
+#define CLK_PLL_PERIPH_200M	10
+#define CLK_PLL_PERIPH_160M	11
+#define CLK_PLL_PERIPH_150M	12
+#define CLK_PLL_VIDEO_4X	13
+#define CLK_PLL_VIDEO_2X	14
+#define CLK_PLL_VIDEO_1X	15
+#define CLK_PLL_CSI_4X		16
+#define CLK_PLL_AUDIO_DIV2	17
+#define CLK_PLL_AUDIO_DIV5	18
+#define CLK_PLL_AUDIO_4X	19
+#define CLK_PLL_AUDIO_1X	20
+#define CLK_PLL_NPU_4X		21
+#define CLK_CPU			22
+#define CLK_CPU_AXI		23
+#define CLK_CPU_APB		24
+#define CLK_AHB			25
+#define CLK_APB0		26
+#define CLK_APB1		27
+#define CLK_MBUS		28
+#define CLK_DE			29
+#define CLK_BUS_DE		30
+#define CLK_G2D			31
+#define CLK_BUS_G2D		32
+#define CLK_CE			33
+#define CLK_BUS_CE		34
+#define CLK_VE			35
+#define CLK_BUS_VE		36
+#define CLK_NPU			37
+#define CLK_BUS_NPU		38
+#define CLK_BUS_DMA		39
+#define CLK_BUS_MSGBOX0		40
+#define CLK_BUS_MSGBOX1		41
+#define CLK_BUS_SPINLOCK	42
+#define CLK_BUS_HSTIMER		43
+#define CLK_AVS			44
+#define CLK_BUS_DBG		45
+#define CLK_BUS_PWM		46
+#define CLK_BUS_IOMMU		47
+#define CLK_DRAM		48
+#define CLK_MBUS_DMA		49
+#define CLK_MBUS_VE		50
+#define CLK_MBUS_CE		51
+#define CLK_MBUS_CSI		52
+#define CLK_MBUS_ISP		53
+#define CLK_MBUS_G2D		54
+#define CLK_BUS_DRAM		55
+#define CLK_MMC0		56
+#define CLK_MMC1		57
+#define CLK_MMC2		58
+#define CLK_BUS_MMC0		59
+#define CLK_BUS_MMC1		60
+#define CLK_BUS_MMC2		61
+#define CLK_BUS_UART0		62
+#define CLK_BUS_UART1		63
+#define CLK_BUS_UART2		64
+#define CLK_BUS_UART3		65
+#define CLK_BUS_I2C0		66
+#define CLK_BUS_I2C1		67
+#define CLK_BUS_I2C2		68
+#define CLK_BUS_I2C3		69
+#define CLK_BUS_I2C4		70
+#define CLK_SPI0		71
+#define CLK_SPI1		72
+#define CLK_SPI2		73
+#define CLK_SPI3		74
+#define CLK_BUS_SPI0		75
+#define CLK_BUS_SPI1		76
+#define CLK_BUS_SPI2		77
+#define CLK_BUS_SPI3		78
+#define CLK_SPIF		79
+#define CLK_BUS_SPIF		80
+#define CLK_EMAC_25M		81
+#define CLK_BUS_EMAC		82
+#define CLK_BUS_GPADC		83
+#define CLK_BUS_THS		84
+#define CLK_I2S0		85
+#define CLK_I2S1		86
+#define CLK_BUS_I2S0		87
+#define CLK_BUS_I2S1		88
+#define CLK_DMIC		89
+#define CLK_BUS_DMIC		90
+#define CLK_AUDIO_CODEC_DAC	91
+#define CLK_AUDIO_CODEC_ADC	92
+#define CLK_BUS_AUDIO_CODEC	93
+#define CLK_USB_OHCI		94
+#define CLK_BUS_OHCI		95
+#define CLK_BUS_EHCI		96
+#define CLK_BUS_OTG		97
+#define CLK_BUS_DPSS_TOP	98
+#define CLK_MIPI_DSI		99
+#define CLK_BUS_MIPI_DSI	100
+#define CLK_TCON_LCD		101
+#define CLK_BUS_TCON_LCD	102
+#define CLK_CSI_TOP		103
+#define CLK_CSI_MCLK0		104
+#define CLK_CSI_MCLK1		105
+#define CLK_CSI_MCLK2		106
+#define CLK_BUS_CSI		107
+#define CLK_BUS_WIEGAND		108
+#define CLK_RISCV		109
+#define CLK_RISCV_AXI		110
+#define CLK_RISCV_CORE_GATE	111
+#define CLK_RISCV_CFG_GATE	112
+#define CLK_FANOUT_24M		113
+#define CLK_FANOUT_12M		114
+#define CLK_FANOUT_16M		115
+#define CLK_FANOUT_25M		116
+#define CLK_FANOUT_27M		117
+#define CLK_FANOUT_PCLK		118
+#define CLK_FANOUT0		119
+#define CLK_FANOUT1		120
+#define CLK_FANOUT2		121
+
+#endif
diff --git a/include/dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h b/include/dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h
new file mode 100644
index 000000000000..48fe598b7bd8
--- /dev/null
+++ b/include/dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Andras Szemzo <szemzo.andras@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_ALLWINNER_SUN8I_V853_R_CCU_H_
+#define _DT_BINDINGS_CLK_ALLWINNER_SUN8I_V853_R_CCU_H_
+
+#define CLK_R_AHB		0
+#define CLK_R_APB0		1
+#define CLK_BUS_R_TWD		2
+#define CLK_BUS_R_PPU		3
+#define CLK_BUS_R_RTC		4
+#define CLK_BUS_R_CPUCFG	5
+
+#endif
diff --git a/include/dt-bindings/reset/allwinner,sun8i-v853-ccu.h b/include/dt-bindings/reset/allwinner,sun8i-v853-ccu.h
new file mode 100644
index 000000000000..e258117518aa
--- /dev/null
+++ b/include/dt-bindings/reset/allwinner,sun8i-v853-ccu.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Andras Szemzo <szemzo.andras@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_RST_ALLWINNER_SUN8I_V85X_CCU_H_
+#define _DT_BINDINGS_RST_ALLWINNER_SUN8I_V85X_CCU_H_
+
+#define RST_MBUS		0
+#define RST_BUS_DE		1
+#define RST_BUS_G2D		2
+#define RST_BUS_CE		3
+#define RST_BUS_VE		4
+#define RST_BUS_NPU		5
+#define RST_BUS_DMA		6
+#define RST_BUS_MSGBOX0		7
+#define RST_BUS_MSGBOX1		8
+#define RST_BUS_SPINLOCK	9
+#define RST_BUS_HSTIMER		10
+#define RST_BUS_DBG		11
+#define RST_BUS_PWM		12
+#define RST_BUS_DRAM		13
+#define RST_BUS_MMC0		14
+#define RST_BUS_MMC1		15
+#define RST_BUS_MMC2		16
+#define RST_BUS_UART0		17
+#define RST_BUS_UART1		18
+#define RST_BUS_UART2		19
+#define RST_BUS_UART3		20
+#define RST_BUS_I2C0		21
+#define RST_BUS_I2C1		22
+#define RST_BUS_I2C2		23
+#define RST_BUS_I2C3		24
+#define RST_BUS_I2C4		25
+#define RST_BUS_SPI0		26
+#define RST_BUS_SPI1		27
+#define RST_BUS_SPI2		28
+#define RST_BUS_SPI3		29
+#define RST_BUS_SPIF		30
+#define RST_BUS_EMAC		31
+#define RST_BUS_GPADC		32
+#define RST_BUS_THS		33
+#define RST_BUS_I2S0		34
+#define RST_BUS_I2S1		35
+#define RST_BUS_DMIC		36
+#define RST_BUS_AUDIO_CODEC	37
+#define RST_USB_PHY		38
+#define RST_BUS_OHCI		39
+#define RST_BUS_EHCI		40
+#define RST_BUS_OTG		41
+#define RST_BUS_DPSS_TOP	42
+#define RST_BUS_MIPI_DSI	43
+#define RST_BUS_TCON_LCD	44
+#define RST_BUS_CSI		45
+#define RST_BUS_WIEGAND		46
+#define RST_RISCV_SYS_APB	47
+#define RST_RISCV_SOFT		48
+#define RST_RISCV_CFG		49
+
+#endif
diff --git a/include/dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h b/include/dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h
new file mode 100644
index 000000000000..57629d635115
--- /dev/null
+++ b/include/dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Andras Szemzo <szemzo.andras@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_RST_ALLWINNER_SUN8I_V853_R_CCU_H_
+#define _DT_BINDINGS_RST_ALLWINNER_SUN8I_V853_R_CCU_H_
+
+#define RST_BUS_R_TWD		0
+#define RST_BUS_R_PPU		1
+#define RST_BUS_R_RTC		2
+#define RST_BUS_R_CPUCFG	3
+
+#endif
-- 
2.39.5


