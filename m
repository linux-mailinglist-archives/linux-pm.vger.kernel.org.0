Return-Path: <linux-pm+bounces-21390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A47A28ABA
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613C93A5DB2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EEC4C76;
	Wed,  5 Feb 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRiXift6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F9DF5C;
	Wed,  5 Feb 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759952; cv=none; b=IxJwFnO5va1q4FMSQ1xWa43/j8jEjBX1bAx4sanvOBUyYE8kXqJ4UYYulLP43JhBtaZRJoLhAhNRhKQzX+3OKqImB334D9/rMUrbfcSadIz6UUhS35IpNI3/VnZub9r+7HXvRUXt8O5G/hqKhL/A5efyLkxszumB7pukR3GXF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759952; c=relaxed/simple;
	bh=45BY3DS1djtWDIlfvJbwSMK8G513VCijeE4jgdsghbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PFJejvvD+elrAqjJA6ZpqNZ+41e5j6GivjpZmuWbECSGzv9zbv6hXSEQy+POFA4CvcRdZC589b9rnvE1vMWfOljOlVa5eFYvDrxGQkzYHdEzajWAvVeMKz2Qlg+k7xCKMtsbgCYx53nBTaD12W4xjSjxnwycIDFueAG/iReakvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRiXift6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dce1d61b44so629794a12.2;
        Wed, 05 Feb 2025 04:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759948; x=1739364748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYwdC6FkM1FkoHrBLoPreNjUtz/aJNsrJlKRqn3rXe4=;
        b=NRiXift6VxtIvcGmyvOgKA2pENFiSY+gRJ+GrN9gvOdjlETRfBqG4tndzjOYkm4Ve5
         ZP6qIG9VREF+7+MXNMVY3OsIp+o6GtgiedQjtIO9xQ4qwyEBPVe2bfK8ZAJWDDVQvSYI
         lS53WbxI6M2D3XMS0/lug6mLGiShApgYV5MihbwNLJvTLToJolDJ0j+gFOoaoIuZ7KiP
         WRI33B3RnXZmx8NPlQKphIniPtktJnXfatZ/b3xZPe86hnDMEVx/Z7IVwoMjsGBLqBNn
         KY/WM0q+2s8QADEXR/Y/1yyRL9oyllzXfBZ90KHMAjumbyavh18lxgYUZ7krjsCCXtCI
         kw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759948; x=1739364748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYwdC6FkM1FkoHrBLoPreNjUtz/aJNsrJlKRqn3rXe4=;
        b=QdHxZ6Ay3kdFiSUCBTRjj67ZMfXPLsE3Ga6T5qejxvuBKyHHtL5TZ2aJ9VZXXngOtD
         lyOMsppId0AvBmFfwHdaU9DRtpJ1jeETa4jK+ZRhF473/OcvMr50P5nACRsAPbNg1mdl
         uyCj5KpWLQbz1h4Bo3nR2nK5IMz52QgXDW9ROvNq25dReKLkUL3XY2J0JJlFxcAWF76N
         qMDoGFjkyDmuHuPpppZjhAVsHpoHzZBeKmCR9e/uKUK8WjUP1nafvKDW8Bv2JjZuNq7k
         QhjtBENcswBiO1FmkXu+eYOhXBpJNIy5icb9Q8NExWWo3NXtcRULyznAhlMszsPaePdu
         L/8w==
X-Forwarded-Encrypted: i=1; AJvYcCU4Y4BRVS4iIsHFzo1kiQWBEchDotaDI3OUX++hvWK3Qn6Q/ULrSMVxoCDwnXMylJ3gHNEU0qtrzEun@vger.kernel.org, AJvYcCVEarEn2DDHWIWtPMXOpsYjqwkRlhylTUisrdele6iv2m/1r6XfKd3mdnYy3g2PbGVV6SMGAEP6B/4mFg==@vger.kernel.org, AJvYcCVtfKJbBQenfpoLcB0jE86jTwdaq2/ms917lGS8/KmjhHDKRTIH1zt0lTxmDbTyhQDEGirZ6xn/ebsBtZuC@vger.kernel.org, AJvYcCXVpErJi0/gOw6PMieT/XezL8DGwsmf0Kiz2rqstdxxzZGkq0lbZ1kGMtxhpDj9I3Zt6FxpV7Oj7p+y@vger.kernel.org, AJvYcCXmgI+OlQ9ekpPAYJ4Lsk0xMvRQoR1szg63YUsXmu25Bhlu0RuWczAVjw4vesXl1PV+S6nwP7S4Gmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0dP+71N8rqeWLp46GghUuMPdA6NVOfeBpfJCTNJuDMLIV1EzN
	ZauZ0SrvNumRGv5W3afhOkN/7Ng9bMFz8XgLtKJuFMiITZPYZtx/
X-Gm-Gg: ASbGnct9zudnbgiPgLdkDWeSeNpvw7M1f88s+Sb9uLD1yikPxr99gFxE9iDGYFPenwL
	KtDr4/wTtlaUYSXt37mDSR1CfuT2svDJVV1MEy7dkavD6spyw9jZXoRSbbyjLK6XIprl0q5WoIB
	+fTMev8m9LvkOwc7JcWO1s71+Kg9TdiyMtU+8PEebJ+DTgzvsELgb507O07PMOxU1daArfclW6Q
	fYAiLFi68HDbNcmIrILq2kBZ0f0Ykxg4lAfxVD6bXRrRgLZjBMTe0qN0UqtqF/z+ylb7qPg7X5Y
	b5On28P4F3i7cqEAzmVHqZSf89wrsSdRvCAlItdeMx4GkQ==
X-Google-Smtp-Source: AGHT+IGwwnpMG9KpubRS1ckqsKV0lRhKkSXdJJkp9LazwK0ad82cff1p5Us/UKXT3VoqZffwLnJ1uw==
X-Received: by 2002:a05:6402:388c:b0:5d9:8877:895a with SMTP id 4fb4d7f45d1cf-5dcdb732cd0mr3409724a12.17.1738759947712;
        Wed, 05 Feb 2025 04:52:27 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm11559997a12.45.2025.02.05.04.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:52:27 -0800 (PST)
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
Subject: [PATCH v2 00/10] Support for Allwinner V853 SoC
Date: Wed,  5 Feb 2025 13:52:15 +0100
Message-Id: <20250205125225.1152849-1-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V85x is a SoC from Allwinner with video encoding targeted for the field of
IP Camera. It integrates the single CA7 core, and a T-Head E907 RISC-V mcu.
The SoC has the usual Allwinner peripherals and a Vivante NPU.
V853 is a BGA package without DRAM, V851s/V851s3 has the same die with
co-packaged 64MB/128MB DRAM (in a QFN88 package).

This patchset tries to add basical support for the V853 device family.

Changelog - v2:
 - rebased on 6.14-rc1
 - add a needed gate with key support to sunxi clk
 - rewrite the ccu-r driver
 - fix license issues
 - remove the pinctrl binding, as it has beed applied
 - rework the pinctrl driver, use the new sunxi dt based mux support. This new pinctrl
   driver depends on the new sunxi device-tree based mux support patch series [1].
 - remove the new usb phy binding, as the v853's usb phy is very close to d1/a64
 - add a board dts
 - ccu: add module description
 - ccu: fix PLL enable bits, and min multipliers
 - ccu: change PLL flags to CLK_SET_RATE_GATE
 - ccu: use SUNXI_CCU_M_HWS at peripheral PLLs
 - ccu: convert the VIDEO and CSI PLLs from nm type to nkmp according to BSP
 - ccu: cpu axi clk use pointer
 - ccu: fix comments
 - ccu: swap i2s1 and i2s0 bus clocks
 - ccu: fix indentation
 - ccu: fix RST_BUS_SPIF order
 - ccu: convert RST_RISCV_CLK_GATING from reset to gate

[1]: https://lore.kernel.org/linux-sunxi/20241111005750.13071-1-andre.przywara@arm.com/T/

Andras Szemzo (10):
  clk: sunxi-ng: allow key feature in ccu reset and gate
  pinctrl: sunxi: add driver for Allwinner V853
  dt-bindings: clock: sunxi-ng: add compatibles for V853
  clk: sunxi-ng: add CCU drivers for V853
  dt-bindings: power: add V853 ppu bindings
  pmdomain: sunxi: add V853 ppu support
  dt-bindings: phy: allwinner: add v853 usb phy
  phy: allwinner: add v853 usb phy compatible
  ARM: dts: sun8i: add DTSI file for V853
  ARM: dts: sun8i: add DTS file for yuzuki-lizard V851s

 .../clock/allwinner,sun4i-a10-ccu.yaml        |    3 +
 .../phy/allwinner,sun50i-a64-usb-phy.yaml     |    2 +
 .../power/allwinner,sun20i-d1-ppu.yaml        |    1 +
 arch/arm/boot/dts/allwinner/Makefile          |    1 +
 .../boot/dts/allwinner/sun8i-v851s-lizard.dts |  196 +++
 arch/arm/boot/dts/allwinner/sun8i-v853.dtsi   |  656 ++++++++++
 drivers/clk/sunxi-ng/Kconfig                  |   10 +
 drivers/clk/sunxi-ng/Makefile                 |    4 +
 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.c       |  120 ++
 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.h       |   14 +
 drivers/clk/sunxi-ng/ccu-sun8i-v853.c         | 1145 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-v853.h         |   14 +
 drivers/clk/sunxi-ng/ccu_common.h             |    2 +
 drivers/clk/sunxi-ng/ccu_gate.c               |    6 +
 drivers/clk/sunxi-ng/ccu_gate.h               |   14 +
 drivers/clk/sunxi-ng/ccu_mux.c                |    4 +-
 drivers/clk/sunxi-ng/ccu_reset.c              |    7 +
 drivers/clk/sunxi-ng/ccu_reset.h              |    2 +-
 drivers/phy/allwinner/phy-sun4i-usb.c         |   10 +
 drivers/pinctrl/sunxi/Kconfig                 |    5 +
 drivers/pinctrl/sunxi/Makefile                |    1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c    |   53 +
 drivers/pmdomain/sunxi/sun20i-ppu.c           |   15 +
 .../clock/allwinner,sun8i-v853-ccu.h          |  132 ++
 .../clock/allwinner,sun8i-v853-r-ccu.h        |   16 +
 .../power/allwinner,sun8i-v853-ppu.h          |   10 +
 .../reset/allwinner,sun8i-v853-ccu.h          |   60 +
 .../reset/allwinner,sun8i-v853-r-ccu.h        |   14 +
 28 files changed, 2513 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-v851s-lizard.dts
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c
 create mode 100644 include/dt-bindings/clock/allwinner,sun8i-v853-ccu.h
 create mode 100644 include/dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h
 create mode 100644 include/dt-bindings/power/allwinner,sun8i-v853-ppu.h
 create mode 100644 include/dt-bindings/reset/allwinner,sun8i-v853-ccu.h
 create mode 100644 include/dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h

-- 
2.39.5


