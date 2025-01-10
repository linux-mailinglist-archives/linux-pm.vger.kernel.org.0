Return-Path: <linux-pm+bounces-20210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C715CA090D7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F0716A6E5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0E21171A;
	Fri, 10 Jan 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIE/38fI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFE2116FF;
	Fri, 10 Jan 2025 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512788; cv=none; b=dKCUyQR3VbO+fcS1UorDQJFfM0lTpZ47piKIgxvUHqXpQCzui5XeR7LLkKTSL1UrcisNPtRWP2q+a0HYdOjf7U14wMk5HCguzkn4FKR6PvglqaKvE+xw+2adDD5rtyJ9yZkFSj+R+8qlvqhQfjpa0fbq6Wy4YBYvwxub3Ltjcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512788; c=relaxed/simple;
	bh=o8h/VzsZar4MuZPKhggqHy071v6GV7q5cNk4H31hFrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZUUBF03kT+DeNXatpnK47UzktSz62ijtlsG8d4HJVatTu2ySH6fc8JD/4i5OdgknA9xUhnOFg/d97rva4yPJEueNL9C4lNDd1mZOaSgD/OYZ/1/rJqKUNnPktMLfq7Ou4L8Tn654mwHp05gfludr4QwrVcHq0HN55kUlalG4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIE/38fI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43635796b48so13064455e9.0;
        Fri, 10 Jan 2025 04:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512784; x=1737117584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+vyretXSqvlGJ089eDiUrdk+gO1h5CCjoi8R7tvGhk=;
        b=gIE/38fIbVl2XkocKjISR+juKmIsBhFV3VyEXA/qSABXT4BA55XZVrvuW/ruhxlmDz
         /9nLFnN5TEaPynmEw+Gf6GRzh+QIwrPDz4MWG896vBQCAVisE0oAhMAIFyVAWGeKt9A6
         GscJg3TaXKa2pySCI+J3jy28x62pqvOhdo/61pAKq+9uuQShxpfTGi9pI1G94Qb09G8Q
         m2fNxiyEsniCgyB6BVpWCOoYUe3+/QDBmhtMo6oTgJUD+z67q+41jExwKxCtVIQloASF
         Gztsx85r7qFgtPrYGChBE1qbGA4CY+9DeURRM8mbNe7FlPjrKgYafpqiw83pGbVTpsq1
         YcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512784; x=1737117584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+vyretXSqvlGJ089eDiUrdk+gO1h5CCjoi8R7tvGhk=;
        b=f61khUHOZf1wZH3nbmukxsuKmtV5yznbV4gqOiRIJlog5v03/H55t4Xjv9N8hDQERr
         JVR0T/mMHDD/frbSkc4Yyq69oNCR2FD4xnxNURxOfGMBR6I4EQAh0NyKVbxHWNPPDrqU
         h/0qFXE6KWvXs0JwnCDB3YJVc4fLVI5zTlY5ZpifIdsAWu4NoTf56RBDCMPpMsfR/7Vf
         m1xJe4k1SvhCgLVFGOi3RjRKQZPfmhRhIMY2Q2BRx1G+f960ka1PdgcIAx84wzh1w6Oo
         bDLRJn6DmEMXyGhDSlzrlYrpUKTOygxvX+YOYG9GS5itc2o/doqlPXO6UwgmVq2CUJO2
         GDDg==
X-Forwarded-Encrypted: i=1; AJvYcCU3R8d0NCwZwhOSJUt3GvYnynJt6KC763ObBWs8yj8DnqHtbyPGgLib0Gy9ywdjuz+SIiOBciukNBE=@vger.kernel.org, AJvYcCULEaWDMwe6cANXx1rTOpvzGmzTkyG0qMyZ7ybdmgg2JY5XQfMk5hgA9xyC+UtKSsfWWzwALwhqZWz9w0Re@vger.kernel.org, AJvYcCVVLI9ljRR5pxF+j2oDYa6V8U6D+iT+XlOMuZXDhTmVbxJ5G4XSuhul4vQueWMSG5cRQja9ZBj+dis/kA==@vger.kernel.org, AJvYcCVpKMIl7nmmJrLXOzYZrNsxL2vkNJPQuhjJ93lZqmxEjkRSVOJK03v4dXJBDszB9kADpEyx++eI3KVm@vger.kernel.org, AJvYcCXX4aoGCeSFn4hCKwiFUMS30SRcCVBwx9GqURGOslRP9AQ7E1FD/nBGQVsqr0K14OI/jmPK6PeSKGXs@vger.kernel.org
X-Gm-Message-State: AOJu0YyCC0eJkf2PXgWjY3R3KhY1xynA8VrhOgBI+ITTFGMfMOvISARj
	VLXPU1Fj7pR+sLUxQoZ82slzw6tiRj7x8M6IDNBvz73n0RoFVfgR
X-Gm-Gg: ASbGncsEdRonmOZUKWymeuXDSZFpBsvKcKIpZFEc5gBAePVtquGyU+p3q6w/ukgf9TO
	Q3s4RRhMxb/+XonzA4R0qGPjPm/fJ3oqLAlN5pzxDFiorQ5SuSV8zTefKBNdKDNEiDk+IgIvx2P
	JJ09XoC5NSmVCMT4WD3QmHA6CCfc/MiqJrPNEbNGNc5x5N3hNqj6M/Y4T1GvtKj7yeKqy7pWJNI
	RVgv5prYXVOaihmTtTAXic+f5/URuBR/2W7f1XA47edQr55dEqBJvSgyWL2Qn22ahlRfyNkTYe8
	AelT0+GwiWk=
X-Google-Smtp-Source: AGHT+IFwaXo9aGBJOTGl5BoaqQu+VYw+3Ya+bt9n+J3d1HC2ZWpchPLfQal3en/7ZqfXC7AIaW2MZg==
X-Received: by 2002:a05:600c:358a:b0:436:e69a:7341 with SMTP id 5b1f17b1804b1-436e9d686b2mr56317705e9.3.1736512783626;
        Fri, 10 Jan 2025 04:39:43 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:41 -0800 (PST)
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
Subject: [PATCH 06/12] dt-bindings: clk: sunxi-ng: add V853 CCU clock/reset
Date: Fri, 10 Jan 2025 13:39:17 +0100
Message-Id: <20250110123923.270626-7-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110123923.270626-1-szemzo.andras@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the device tree needs the clock/reset indices, add them to DT binding
headers.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 include/dt-bindings/clock/sun8i-v853-ccu.h   | 132 +++++++++++++++++++
 include/dt-bindings/clock/sun8i-v853-r-ccu.h |  16 +++
 include/dt-bindings/reset/sun8i-v853-ccu.h   |  62 +++++++++
 include/dt-bindings/reset/sun8i-v853-r-ccu.h |  14 ++
 4 files changed, 224 insertions(+)
 create mode 100644 include/dt-bindings/clock/sun8i-v853-ccu.h
 create mode 100644 include/dt-bindings/clock/sun8i-v853-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-v853-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-v853-r-ccu.h

diff --git a/include/dt-bindings/clock/sun8i-v853-ccu.h b/include/dt-bindings/clock/sun8i-v853-ccu.h
new file mode 100644
index 000000000000..a405b982f914
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-v853-ccu.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (C) 2020 huangzhenwei@allwinnertech.com
+ * Copyright (C) 2023 Andras Szemzo <szemzo.andras@gmail.com.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN8I_V85X_CCU_H_
+#define _DT_BINDINGS_CLK_SUN8I_V85X_CCU_H_
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
+#define CLK_CPU		22
+#define CLK_CPU_AXI		23
+#define CLK_CPU_APB		24
+#define CLK_AHB		25
+#define CLK_APB0		26
+#define CLK_APB1		27
+#define CLK_MBUS		28
+#define CLK_DE			29
+#define CLK_BUS_DE		30
+#define CLK_G2D		31
+#define CLK_BUS_G2D		32
+#define CLK_CE			33
+#define CLK_BUS_CE		34
+#define CLK_VE			35
+#define CLK_BUS_VE		36
+#define CLK_NPU		37
+#define CLK_BUS_NPU		38
+#define CLK_BUS_DMA		39
+#define CLK_BUS_MSGBOX0	40
+#define CLK_BUS_MSGBOX1	41
+#define CLK_BUS_SPINLOCK	42
+#define CLK_BUS_HSTIMER	43
+#define CLK_AVS		44
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
+#define CLK_BUS_WIEGAND	108
+#define CLK_RISCV		109
+#define CLK_RISCV_AXI		110
+#define CLK_RISCV_CFG		111
+#define CLK_FANOUT_24M		112
+#define CLK_FANOUT_12M		113
+#define CLK_FANOUT_16M		114
+#define CLK_FANOUT_25M		115
+#define CLK_FANOUT_27M		116
+#define CLK_FANOUT_PCLK	117
+#define CLK_FANOUT0		118
+#define CLK_FANOUT1		119
+#define CLK_FANOUT2		120
+
+#endif /* _DT_BINDINGS_CLK_SUN8I_V85X_CCU_H_ */
diff --git a/include/dt-bindings/clock/sun8i-v853-r-ccu.h b/include/dt-bindings/clock/sun8i-v853-r-ccu.h
new file mode 100644
index 000000000000..0c10295c6d9c
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-v853-r-ccu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/* Copyright(c) 2020 - 2023 Allwinner Technology Co.,Ltd. All rights reserved.
+ *
+ * Copyright (C) 2023 rengaomin@allwinnertech.com
+ */
+#ifndef _DT_BINDINGS_CLK_SUN8I_V85X_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN8I_V85X_R_CCU_H_
+
+#define CLK_R_TWD		0
+#define CLK_R_PPU		1
+#define CLK_R_RTC		2
+#define CLK_R_CPUCFG		3
+
+#define CLK_R_MAX_NO		(CLK_R_CPUCFG + 1)
+
+#endif
diff --git a/include/dt-bindings/reset/sun8i-v853-ccu.h b/include/dt-bindings/reset/sun8i-v853-ccu.h
new file mode 100644
index 000000000000..89d94fcbdb55
--- /dev/null
+++ b/include/dt-bindings/reset/sun8i-v853-ccu.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2020 huangzhenwei@allwinnertech.com
+ * Copyright (C) 2023 Andras Szemzo <szemzo.andras@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN8I_V85X_CCU_H_
+#define _DT_BINDINGS_RST_SUN8I_V85X_CCU_H_
+
+#define RST_MBUS		0
+#define RST_BUS_DE		1
+#define RST_BUS_G2D		2
+#define RST_BUS_CE		3
+#define RST_BUS_VE		4
+#define RST_BUS_NPU		5
+#define RST_BUS_DMA		6
+#define RST_BUS_MSGBOX0	7
+#define RST_BUS_MSGBOX1	8
+#define RST_BUS_SPINLOCK	9
+#define RST_BUS_HSTIMER	10
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
+#define RST_BUS_SPIF		26
+#define RST_BUS_SPI0		27
+#define RST_BUS_SPI1		28
+#define RST_BUS_SPI2		29
+#define RST_BUS_SPI3		30
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
+#define RST_BUS_WIEGAND	46
+#define RST_RISCV_SYS_APB	47
+#define RST_RISCV_SOFT		48
+#define RST_RISCV_CLK_GATING	49
+#define RST_RISCV_CFG		50
+
+#endif /* _DT_BINDINGS_RST_SUN8I_V85X_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun8i-v853-r-ccu.h b/include/dt-bindings/reset/sun8i-v853-r-ccu.h
new file mode 100644
index 000000000000..4420f7dbbcdc
--- /dev/null
+++ b/include/dt-bindings/reset/sun8i-v853-r-ccu.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/* Copyright(c) 2020 - 2023 Allwinner Technology Co.,Ltd. All rights reserved.
+ *
+ * Copyright (c) 2023 rengaomin@allwinnertech.com
+ */
+
+#ifndef _DT_BINDINGS_RESET_SUN8IW21_R_CCU_H_
+#define _DT_BINDINGS_RESET_SUN8IW21_R_CCU_H_
+
+#define RST_BUS_R_PPU		0
+#define RST_BUS_R_RTC		1
+#define RST_BUS_R_CPUCFG	2
+
+#endif /* _DT_BINDINGS_RESET_SUN8IW21_R_CCU_H_ */
-- 
2.39.5


