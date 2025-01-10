Return-Path: <linux-pm+bounces-20213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE19A090E5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12158188DDA2
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26F212D67;
	Fri, 10 Jan 2025 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moKRgYS3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA55212B13;
	Fri, 10 Jan 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512794; cv=none; b=kXqYF0YXarA9/LCClFFC+QLaJWqL0Fg5xSXnui4IFbpQDWO3YBryWtIkwC90g+kScmYo0ycjF5o0Ruc5ohkuedauvL268T39k5qzrHsoSP4H3P40hKCh+dnAITiUF3J5ecPErl9waZsR6e1VvQLS1FJoqbaNst/XLeR1GAqoIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512794; c=relaxed/simple;
	bh=zBLG4CxX0BDGx07H299sHpVzVkNxFvrgxwNPxbva9g0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=toS6Xbw43geGCvJDtIXDvg42DLdCLWK/+jpMOwD7T4M1HTTd97UY1VWqEPBhu6692hkUSTrNlf32yYP7wMsybYC52H1Wnw6UgrvFoGHqVvw59sBl7zyqlNZOqyaLQyonSO/EY+unBk5eq5WYDT8H8v95aOpxXTZJ+CH56sRUCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moKRgYS3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e06af753so1108308f8f.2;
        Fri, 10 Jan 2025 04:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512790; x=1737117590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNhXrg+N/HiSI29fpVyr4UPfccHi3IoiUSacUgvn9w4=;
        b=moKRgYS3CddQog6taBAad3WfyUcI28Xj0vNrtByxQqe3je/NbYcMJxxilENAZZ4/XK
         c4s48Nv3J8S7syPLxm/Cs4Nkce0WLPmN7nYBm+C6Wjo73+1a9fYKs0h5Fd0vMz/4tx13
         xNPJPF61vaIauj2nV61+GTpSf4o9iIUdqyPvZvtrQaVvMSOWiUkkHSFT59567IRf06MF
         b6u+TAteRRqvT2Qli2fkLXszwvQf2beXTqqqRAHASec8EEIw+QiB2JQ4+MQXfjLh4TSO
         Mw9lMe5txSraM2GtTqCd6Zf7m9ls+Iq/tJl8i9EnYz85KT1Fl9oV+zBVcZewYcjRN84B
         IIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512790; x=1737117590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNhXrg+N/HiSI29fpVyr4UPfccHi3IoiUSacUgvn9w4=;
        b=gn1VG2+j0+NlnjRVU0JXksAiilddUC16qP8acCyl2jqysCeI4l1kKtYLSGiJe5F990
         B2AMEuZzHmOV/jPfd+kCGMTRIX89Qg8OUsU690DAHsc0Iyu47H8bye6TJjvgEn2kPgNe
         zJv02L4v3NyqipczNLAQPcK4u/Jdr+YvpXl4KlKOQ9BZ/2a23lgT0wzOhXqHr9x4yW8h
         Q3gikW7/+7EMvCPDLeaUMQ6A9jirwuSkk5OZHozr3ZNQecumDIfFmEfRJagIETY1El1z
         82JfwByWwlwXL6VHWxD4eMn53s2pxcutDDeuHt5wmw8ljR7sy7Z3bbF+HuMQCiIK72my
         8anQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2mXbuep9fMYe2jokRQTnrbbPBbo6TifpzR0lHaOG5mXGbo/5Qeuu4XH4jhiasojhvRMaaoLNw7wp7Mp1p@vger.kernel.org, AJvYcCVKsdHgHwwb/5mVJuZaWRowauzee63HQd0KZ02lHnBnTIqTOuMUL2QNOl8wRMQc7d4pSnsBjY4Cv6tZlQ==@vger.kernel.org, AJvYcCWDLiLPztLrTNqSWGrlooLFsTzMoXav6gB/x/LW2cho9no5E5ShHGPJllbA5cAxsHBNayy6FzW4uF4=@vger.kernel.org, AJvYcCWz/FyHZNUrAIv5PB0ONNciiyQxbAItfn2CUgB7WubGesSqOx9R4RZJ1oY1yJAzSJcImqigyP4LezwB@vger.kernel.org, AJvYcCX7h9Idlx8whxKjoD/V5algGRxWFns1HxRnJYPOMVYOp38GQaia6tBoZafQbo/4aodiiJahZWkYCmU4@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLJPdGeREXEYLmYf/bawYJ1PNFyEwuBRsrxL25zfFYWzcddbw
	wqjo40bQthbQYocX76gkOVvqiX/UuzKxo8QgEKFhyBiCpKZdCbtT
X-Gm-Gg: ASbGncu887jHb3pHS6Qf4cqDHHUlEggOALh/sETaIlaWD5KgPFlxUBW+V6RSewUqDqX
	frmLJ2MyF7y7CJB2PvgRossmyH/ysRKubLTbWvbwqNe3ezalUdG1GWNkX+6NMCfiiyGxFJkTmC0
	5GFLL2vxqOQIqCESzxPy9N+KEyuJgN0uinwNxgtoYthxEvVSE2E5kbzEebbB6B5wJXLVkW6L8/X
	42K53PCDjBe07Kty4V+wJtZc9Vm6llWck/lkNziQzS6GROqoDUqpQBvaqIDfyHtSr8h2kAPlaFc
	q/PAoYUMvj0=
X-Google-Smtp-Source: AGHT+IHpIt3+i8brazuVYahCjibjXFreCv5USXJ4UmTVffG85lEn4Al2QbLsK9oWzZTtDuNp60eq/g==
X-Received: by 2002:a05:6000:1566:b0:385:f1f2:13f1 with SMTP id ffacd0b85a97d-38a87303e62mr9114655f8f.22.1736512790498;
        Fri, 10 Jan 2025 04:39:50 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:49 -0800 (PST)
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
Subject: [PATCH 09/12] dt-bindings: power: add V853 ppu bindings
Date: Fri, 10 Jan 2025 13:39:20 +0100
Message-Id: <20250110123923.270626-10-szemzo.andras@gmail.com>
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

The device-tree needs ppu indexes, add it.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 include/dt-bindings/power/allwinner,sun8i-v853-ppu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 include/dt-bindings/power/allwinner,sun8i-v853-ppu.h

diff --git a/include/dt-bindings/power/allwinner,sun8i-v853-ppu.h b/include/dt-bindings/power/allwinner,sun8i-v853-ppu.h
new file mode 100644
index 000000000000..b1c18a490613
--- /dev/null
+++ b/include/dt-bindings/power/allwinner,sun8i-v853-ppu.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_POWER_SUN8I_V853_PPU_H_
+#define _DT_BINDINGS_POWER_SUN8I_V853_PPU_H_
+
+#define PD_RISCV		0
+#define PD_NPU			1
+#define PD_VE			2
+
+#endif
-- 
2.39.5


