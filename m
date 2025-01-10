Return-Path: <linux-pm+bounces-20205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8823A090C9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A2A3AB63F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660DB20E315;
	Fri, 10 Jan 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPr3Qstn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1E20E021;
	Fri, 10 Jan 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512773; cv=none; b=T0sx6bDd9PvDP6rnBaMwbes62EEduLJq0GMk+B1NK+WVx+iNrPjhvywc99F9pZjyhHKbEccGnnxtOE/jfDhcfn6phwzRwaJe0V+q3lpHZR6ECaVmTzJ01pU1THf0R9MOkHlVyDnY3sBN1U+Sv2chbR4/g1VCZPYRiVKPDHbKZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512773; c=relaxed/simple;
	bh=ge8fyti9gCsQiwQCMXMgKI3uciNb8E67pHGTQZtgV1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeQ6dTp3KHN07wOftRW67sME+p/ylLZyh6owmn9EPKCxZiMya91uM8mg+L20BrLUB0+fBDfhFlzlhRV/kXltN5icGwl8eMbVaRtywBB02oqk/uSqrVYP8XD6IoEyVoADc1f9vFaNfa3qk28ILuLrTW+SIlxY63M8/G4/o0Q/Wkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPr3Qstn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4362f61757fso19999205e9.2;
        Fri, 10 Jan 2025 04:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512769; x=1737117569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUSKtDxpYUB0G5u44s+MtVvA5eK94sL+CVnm4h5Hbb0=;
        b=NPr3QstnucAI3GpEDU6Wj2C+QcK2WSJoEXlo/i/QBnTsBjA8xbt0cCuO4oETYeRW+4
         iTpx3MuITiJDJ9etnNlJX0CYzUOkmC1A5UTnYy57EXWomn3tXHRp8t6Jha2y/4PZq3Sk
         FUuTKiLSjjUJ+qSy+AIPgoshR6YORh+Se3a7xD6BD3gaNQk3LJb2AfQbFhUcexm+jVzn
         dmIgdQ36oU6F0iI+JGRD3ucXIBOwXeKlqxTcB+k1QZ6Hu4D0+vjg5YBBXUl2Hy//AmO1
         2nK/7PEW/HN76hD2T7ffJP2Tg8LTn3BOHtOB1XcxBlWsaToxEMUnANA3hROgHmCRR4lw
         tHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512769; x=1737117569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUSKtDxpYUB0G5u44s+MtVvA5eK94sL+CVnm4h5Hbb0=;
        b=Av9HxYEuWoZxN6zdEWhyhDV7hHi4tfG0h6U47zxuWqc1jBloqefARkt81voV9vv1Sz
         NkBFQ5xMnSLeq0ZA1JcrxXUbF0jzHKPdcC+oAliY0EtmIj14oBTrU4S9fUe51yDP17+6
         jBPUouKkqmeTOpeJ/hQoabY3CjwAvJdFTQ3uXFijqGdBgUnoRMhDtNfT/MiamQE6pOEt
         PhK0ZEAGTpTykfgB0XsrucDjAhHNtrkVB14A8MlirlJma8HtAsLTIFfSkBgfWWSff26p
         CL/VqJL6901yYJk/+PxXGMYWJMZeNkqnNil4wFC/pJn8kYUYorI1MtafcSwSNF1jDNqV
         LK5A==
X-Forwarded-Encrypted: i=1; AJvYcCUSBASTpoFS8qG4jn7Wkidr3rPlWYpYhSGhqF/dceotZhwHJ/3Yr/kLns7OVhgVPIpOJpl7xMqt+ecS3PR/@vger.kernel.org, AJvYcCUf6xFbPyGsG2/DSRYxwkDFF3M5v+uR5TdlNaU/bTVa6ax78haqJhV6FQM3ui0Z/5HJ6/TrVPsaEEsu@vger.kernel.org, AJvYcCUwhOAHZlzkKt59lGvAIunPKU7KCTaOia6MtxGPtCTTmpBqkTjTlKOTQiHoVJc41FqTWAejpghOZoc=@vger.kernel.org, AJvYcCVewfDKw650WSMghHpwGnL0MHQcp81IC98jKrDbxxfU7irv8Q/W35YNMAbzzQSK8cGZ6nj31FyLWgZT@vger.kernel.org, AJvYcCWfAIjx25mwcknWKJWNi9nlE8cv+x+Vt4zcC2o1HppJKNr9JqwqEAIhMvvFxvA0+RuSKDZmgv72wnzdzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9i8EE3etluC2hfIRisuD6FZlmsUEEynyD/zfT9zrmo3iHxi2
	6vi/micJRXeLTKC/lnn7ueVwAnCngNkRIC8Wauu13YjJO3VQpV91
X-Gm-Gg: ASbGncvqnCuiJZs0XG5sjFXg2sSRrdBuUSKTzYdDDwib7rHfAOTwv1KmPMfCdYcO1D9
	OjCqi7X2D/AbCtnGLw+tbm9KTcVEmX6ua0blBiDT7sT682LOmryC6nCOi71Co+PaTHmqc8vIYv6
	jvpfEVhv2csEO9BCgzoA7pcqG0CVTB+mHGxlFxKpL9L/461OY0pjqvazQU3c/0i0WnjSR8124y3
	6RXhdai2GSpZB5YVdNVAoOBLBTrhRfQkz724xQJS6PtPZtoJtoHrA6+drFUlkFYINBteqYjm/N2
	PVNtuBuZiRM=
X-Google-Smtp-Source: AGHT+IFTgEN5UJlFq7sBCmdgeoA7UGiB+lm0UDSMol2G3trBcljxqzM+QxvHHhfLr6Xw5bNGFHDEog==
X-Received: by 2002:a05:600c:3b86:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-436e26c7ebamr106896935e9.14.1736512769053;
        Fri, 10 Jan 2025 04:39:29 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:28 -0800 (PST)
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
Subject: [PATCH 01/12] clk: sunxi-ng: allow key feature in ccu reset
Date: Fri, 10 Jan 2025 13:39:12 +0100
Message-Id: <20250110123923.270626-2-szemzo.andras@gmail.com>
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

Some newer SoCs, like V853 has reset registers, what can be write only
with fixed key value. Move this value from ccu_mux and reuse
in the reset code.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 drivers/clk/sunxi-ng/ccu_common.h | 2 ++
 drivers/clk/sunxi-ng/ccu_mux.c    | 4 +---
 drivers/clk/sunxi-ng/ccu_reset.c  | 7 +++++++
 drivers/clk/sunxi-ng/ccu_reset.h  | 1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

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
index 941276a8ec2e..3fd5d427c26c 100644
--- a/drivers/clk/sunxi-ng/ccu_reset.h
+++ b/drivers/clk/sunxi-ng/ccu_reset.h
@@ -12,6 +12,7 @@
 struct ccu_reset_map {
 	u16	reg;
 	u32	bit;
+	u32	features;
 };
 
 
-- 
2.39.5


