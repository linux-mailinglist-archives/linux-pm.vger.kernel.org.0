Return-Path: <linux-pm+bounces-21391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF41EA28AC0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9A41613BD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48E41E485;
	Wed,  5 Feb 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KseG2d/X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42831802;
	Wed,  5 Feb 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759955; cv=none; b=BsqQIpdQbvEdIKLTcpSV+WgrDHawVOpw4KZW1+AIIjl2rCTSDVdpEe3UXlX4IFka8VXSmculZHYu6YP357x1ySVBPinUlnPHJGYc5TMqVBpgwL0PEZfwC1BT9S5O5SYcHdHjOoIgkjX5oHVGtcFeR3wRwBjqmu5cZ7ivdO8RLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759955; c=relaxed/simple;
	bh=QF06GksP3emXyQKbOEhFrnPVJDpK6xAoObPMVytWgNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2mDd92zTj8yplydxk5krjlT/5/v+fSSMXgPFKG8ZppVf5obiYGXZknBdhAeYoJzgFvsmUHIhh89hLIP8hOY6UjC18v3YoYqV8Ip1GK/NTWgp37R1AaHmV7xnZuKsiS++LO87WQVfbC78/Di6keJsIjiFz7pJDT8QLFtyL5oDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KseG2d/X; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so363386366b.3;
        Wed, 05 Feb 2025 04:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759950; x=1739364750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSQeWzSgrb+Bgv6s0GnYuvjzz6MyzXd89J++ZXTBfTQ=;
        b=KseG2d/Xlhq03CpB34mNV7C0BgMz9pb0GcqloQVIgwCQGBqgtEtLIyRRVwcKbwp96y
         PS1jBGylxxWV7xVf3z8G7Tsg711tWd5yxq0b98n4J4VFOhhMaidSe24MkFEctlxhrae9
         77iWFHJm/E+XQXlO1VQBOCqqZLnGfCkrYGM0qz+mSzQr8bd4v/AfoMweQi+fl17HMNmc
         nWetfcebH+RAJV7y1rha15r4apB3/QCFsN8MrH1svMv6k1LyORQebnrjVysRNDfHFIO6
         xLy6i803ZFW5lFePIfFArOdpKmNbb9+xRESZyISB42zZ2lUNLeWEILUN+r5z70FQlFc7
         ZpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759950; x=1739364750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSQeWzSgrb+Bgv6s0GnYuvjzz6MyzXd89J++ZXTBfTQ=;
        b=wvmW1V1S882KmfGIJX808jKaXzLHepPjyZiJslImZyvwoghPGfdiX7H8IOZkHA0mmC
         R7q8pd0Q0qjA6jdX6aWnXmjHNFOFYlWSUwF6O6LOkl4ydnBqTh+UQxWGFn2ZqxgHrHOm
         KOkFf3sUZgSnREjx7+QdS2vyX3A1BcDQmyd5TNHhIdjWS0PQl87IxMNMVEye04Qf9f3i
         NWK213AlSdLaVo68pZYqICRiPPnPUK1nqMMkjHOWRCtdznBLw5oiErCGMNH7miLCKInQ
         bWzUQmEhmeufDPUjUc0rg0Jurqc4mfxGS6W3eHTK1qZEs0+fqWF1ikdVwVa4qr4+Uar9
         eO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZkKqgzB/vy01aDU9YfkSvwcc6ah+oIYtYqNxnoHQQZr5As+CPRrMPm1+XgRFgjUKqxhPQHwsadJbv@vger.kernel.org, AJvYcCV0WKA8p24uaHeTbdjfuXGTcqUWRF/nFE7O6kdiY56Pmqh3P0KDu7qXo9xzgLYwCVCaTB+93bmxh7uAXvBD@vger.kernel.org, AJvYcCVXTQ7j77k1DU8vxwvAjqZPHRPcK2MzJcPKagyoIFHrNVQIEF+XSGXcrcjJ3viqTSHrHiD3y53pxx/+AQ==@vger.kernel.org, AJvYcCVtGkTRJmxbqeclaugFZlH1zFUsqPv4X67oWW/Ne/Bzh68ySKCilMAivfmbJ3DGp6S0pkSdKGg6Go0=@vger.kernel.org, AJvYcCXoeXRTaO894rSNR1FMVg7pmNYBxJw785othfKfoxuDXeQQszsx7kYLvSqfdBDeitBOPj5s+amVUooH@vger.kernel.org
X-Gm-Message-State: AOJu0YwkaLGmtOorg9Mt7pJxN5gHx3ASKvnAO87L9DJY8NvqrguvYAzz
	Ta06CYyAy6T2/3u5odxRLWbzwe1Uouc1m9QSZXjOcExNy7iugCtf
X-Gm-Gg: ASbGncu2kojTroqLQwSVJz9sxhkh5bMTaVEY7ccAgYRx7Q3wC2/+Xx7V5lskDYtYqrY
	Tys4gkZLNXTPoE8QOSiP2MeMW0rC9UQxwHk2G2aCCWbySt/TayKObViACsIMtTFE+g6dciVf5CW
	kn5EZLnrYU+zI8CWGO6dav7YMATO/C7MDsLgJhZkz/WTiqK9dnUHQ3GjKSInecGZTEK4VSzcUt2
	A3nVIrqTzYsb3ZpOHOUKJp7BTlt7afaLnN7nwOylfcygjvqqw8byBqo7olU2ZS7HEBanOrGMG4R
	rneM//R0N3WYRwDAhDdf0GqlomB2+GzgorTC/WNOShnKnA==
X-Google-Smtp-Source: AGHT+IGecgfsMcG35UqT0e1WE5j5jytX3/spRmqUEZGqCE6i0UxnZyh0jUtBcSjoqCNwAvn31NH/Fg==
X-Received: by 2002:a17:907:7254:b0:aab:740f:e467 with SMTP id a640c23a62f3a-ab75e214c28mr230820566b.8.1738759950159;
        Wed, 05 Feb 2025 04:52:30 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm11559997a12.45.2025.02.05.04.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:52:29 -0800 (PST)
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
Subject: [PATCH v2 01/10] clk: sunxi-ng: allow key feature in ccu reset and gate
Date: Wed,  5 Feb 2025 13:52:16 +0100
Message-Id: <20250205125225.1152849-2-szemzo.andras@gmail.com>
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

Some newer SoCs, like V853 has reset and gate registers, what can be write only
with fixed key value. Move this value from ccu_mux and reuse
in the reset code, and also introduce a new macro to support writing gate
registers with a key.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 drivers/clk/sunxi-ng/ccu_common.h |  2 ++
 drivers/clk/sunxi-ng/ccu_gate.c   |  6 ++++++
 drivers/clk/sunxi-ng/ccu_gate.h   | 14 ++++++++++++++
 drivers/clk/sunxi-ng/ccu_mux.c    |  4 +---
 drivers/clk/sunxi-ng/ccu_reset.c  |  7 +++++++
 drivers/clk/sunxi-ng/ccu_reset.h  |  2 +-
 6 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index dd330426a6e5..36132cb8b920 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -23,6 +23,8 @@
 /* MMC timing mode switch bit */
 #define CCU_MMC_NEW_TIMING_MODE		BIT(30)
 
+#define CCU_KEY_VALUE			0x16aa0000
+
 struct device_node;
 
 struct ccu_common {
diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_gate.c
index ac52fd6bff67..a7ffaa8d3cb6 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.c
+++ b/drivers/clk/sunxi-ng/ccu_gate.c
@@ -20,6 +20,9 @@ void ccu_gate_helper_disable(struct ccu_common *common, u32 gate)
 	spin_lock_irqsave(common->lock, flags);
 
 	reg = readl(common->base + common->reg);
+	if (common->features & CCU_FEATURE_KEY_FIELD)
+		reg |= CCU_KEY_VALUE;
+
 	writel(reg & ~gate, common->base + common->reg);
 
 	spin_unlock_irqrestore(common->lock, flags);
@@ -44,6 +47,9 @@ int ccu_gate_helper_enable(struct ccu_common *common, u32 gate)
 	spin_lock_irqsave(common->lock, flags);
 
 	reg = readl(common->base + common->reg);
+	if (common->features & CCU_FEATURE_KEY_FIELD)
+		reg |= CCU_KEY_VALUE;
+
 	writel(reg | gate, common->base + common->reg);
 
 	spin_unlock_irqrestore(common->lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_gate.h b/drivers/clk/sunxi-ng/ccu_gate.h
index dc05ce06737a..37e21fcdd931 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.h
+++ b/drivers/clk/sunxi-ng/ccu_gate.h
@@ -68,6 +68,20 @@ struct ccu_gate {
 		}							\
 	}
 
+#define SUNXI_CCU_GATE_HWS_WITH_KEY(_struct, _name, _parent, _reg,	\
+				       _gate, _flags)			\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_KEY_FIELD,	\
+			.hw.init	= CLK_HW_INIT_HWS(_name,	\
+							  _parent,	\
+							  &ccu_gate_ops, \
+							  _flags),	\
+		}							\
+	}
+
 #define SUNXI_CCU_GATE_HWS_WITH_PREDIV(_struct, _name, _parent, _reg,	\
 				       _gate, _prediv, _flags)		\
 	struct ccu_gate _struct = {					\
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index d7ffbdeee9e0..127269ab20ea 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -12,8 +12,6 @@
 #include "ccu_gate.h"
 #include "ccu_mux.h"
 
-#define CCU_MUX_KEY_VALUE		0x16aa0000
-
 static u16 ccu_mux_get_prediv(struct ccu_common *common,
 			      struct ccu_mux_internal *cm,
 			      int parent_index)
@@ -196,7 +194,7 @@ int ccu_mux_helper_set_parent(struct ccu_common *common,
 
 	/* The key field always reads as zero. */
 	if (common->features & CCU_FEATURE_KEY_FIELD)
-		reg |= CCU_MUX_KEY_VALUE;
+		reg |= CCU_KEY_VALUE;
 
 	reg &= ~GENMASK(cm->width + cm->shift - 1, cm->shift);
 	writel(reg | (index << cm->shift), common->base + common->reg);
diff --git a/drivers/clk/sunxi-ng/ccu_reset.c b/drivers/clk/sunxi-ng/ccu_reset.c
index 55bc7c7cda0f..a9aee35c6617 100644
--- a/drivers/clk/sunxi-ng/ccu_reset.c
+++ b/drivers/clk/sunxi-ng/ccu_reset.c
@@ -9,6 +9,7 @@
 #include <linux/reset-controller.h>
 
 #include "ccu_reset.h"
+#include "ccu_common.h"
 
 static int ccu_reset_assert(struct reset_controller_dev *rcdev,
 			    unsigned long id)
@@ -21,6 +22,9 @@ static int ccu_reset_assert(struct reset_controller_dev *rcdev,
 	spin_lock_irqsave(ccu->lock, flags);
 
 	reg = readl(ccu->base + map->reg);
+	if (map->features & CCU_FEATURE_KEY_FIELD)
+		reg |= CCU_KEY_VALUE;
+
 	writel(reg & ~map->bit, ccu->base + map->reg);
 
 	spin_unlock_irqrestore(ccu->lock, flags);
@@ -39,6 +43,9 @@ static int ccu_reset_deassert(struct reset_controller_dev *rcdev,
 	spin_lock_irqsave(ccu->lock, flags);
 
 	reg = readl(ccu->base + map->reg);
+	if (map->features & CCU_FEATURE_KEY_FIELD)
+		reg |= CCU_KEY_VALUE;
+
 	writel(reg | map->bit, ccu->base + map->reg);
 
 	spin_unlock_irqrestore(ccu->lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_reset.h b/drivers/clk/sunxi-ng/ccu_reset.h
index 941276a8ec2e..8da721ac3a7d 100644
--- a/drivers/clk/sunxi-ng/ccu_reset.h
+++ b/drivers/clk/sunxi-ng/ccu_reset.h
@@ -12,9 +12,9 @@
 struct ccu_reset_map {
 	u16	reg;
 	u32	bit;
+	u32	features;
 };
 
-
 struct ccu_reset {
 	void __iomem			*base;
 	const struct ccu_reset_map	*reset_map;
-- 
2.39.5


