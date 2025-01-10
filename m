Return-Path: <linux-pm+bounces-20208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06073A090C5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7757A2220
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7B211493;
	Fri, 10 Jan 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNBxGrol"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423821147A;
	Fri, 10 Jan 2025 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512780; cv=none; b=Tn7Mfxjhzdq+g0FchJyn5Byw2J3FdMxY5uyqqfoW/BtZScA4vsRufJSMJ8qXe8TuqmEzZVpWzitc4waIRDyTqYzdW5Npmmjptyxb0xSg+XXCYRBPrKZheR799YhiMSzXnCqsXJRpUOKgIaeceKsLdiPJUCSmIwO1svaq7VfTrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512780; c=relaxed/simple;
	bh=hRPZOh5LDm7IxhLYQHGdRwMAy11wdehAaCS3dk3Uu/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8utTWsZRDbtXnIstaPW9pWq3Dlk4RuXGNO88kozfILKp90RM5RaCo0KR1MSvsOlTqgkNdGJsO76Qt3me98GETA4q4asdH6wml6cfCa316FNlpqLxKKOIMy9qI5O364XfdSG0xx97YYvivM7HY0qUsjngOsHHhB0GGYf3A4ljk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNBxGrol; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361f664af5so23371285e9.1;
        Fri, 10 Jan 2025 04:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512777; x=1737117577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKSolp2P4MgJ+EWsjWxfCVZGCobjAXoWhJq48hwpcoY=;
        b=DNBxGrol4jbJMeGBn+5P3ouHOTMitlOy6VKWkIDtq3h4FyJEUH7lIZI+ypPQ9wsdsG
         VhTpQj8znarJTHKFG+z/DKxh/aGUb5qrBV3CnayBXE/lrs01JLUDSYp6m891eAzU8NFA
         5vSEXC527cXlMBRyuyNwjD8AvYT+FFfGkb8egwmPwj/E+/15gJAo0DL+Y2OkUPkufjtz
         z85XUMSIounlua4qdMidERU/nsT64KNVgQh5IDiAUdZ/n7BBeSt8p7YpCvI4mISpH4/8
         h0sVrlFxJfgPYsyrdr5tGfGa4P1Z02VrmMMWkpsFZ90EiQyAtHut/dKYLaao4IWZWGxc
         9IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512777; x=1737117577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKSolp2P4MgJ+EWsjWxfCVZGCobjAXoWhJq48hwpcoY=;
        b=jgmZmbuY6viFm7WYQkwkUDRfLj4oW2biIzFNKK+/vS0wHJCSmSdefs05mUV7T46jp5
         bSQggtLaegEsKmx/byxmAmyqDjMsowu4SQZbIzV1Tfx+ipPnNc+IEQhJK9ossRtmBL9x
         bJc0HT18KGLnZ2annXpHqjuGIwpbCCi7XlM6dSqxVnyuvEhfL/6YrB7eCEMV0y3cRiGo
         b8Wm0z1gWKpCAwGhOK3/9hTgL1ZQjB6+CyVraRLBwtSFpzke2GKsLIwnItrYTGi/ZyEZ
         YOq3VVy/0ITH6bz0apkFlF1x3VkWOtDRtsd8V+Xr03MB6YU3VIuJO6f8EApkdFeCVq8b
         Fpag==
X-Forwarded-Encrypted: i=1; AJvYcCUcEMnWLE7VIy86a3fDqUiPwmlJTvtj77QbHeH1gjsq9V54A0GfeFERl+qfhdsK/zURq4d8dEmiOxEP@vger.kernel.org, AJvYcCW/g4iHpOfg3MXuD1t9HWZd09EZcNN3bG3CloSrj4f02LRXyr1Dy6v99qoezBuG11553D4FAlXJAzo=@vger.kernel.org, AJvYcCWrFSWeZze7snOJSK+81FUcfgGbQWkBt3uM20ibNLw8AQCKvJazsdhCOBjd1ZjKwyRcxPC8vniaMg7liR5o@vger.kernel.org, AJvYcCXEM5N2RfQvnxBB985uLsJxPQJqlK+PAUVwAZDK0KZgD9UxomZe3wIdZiNtK6WKTxumMXMnfzrLOyzi@vger.kernel.org, AJvYcCXbdkbUzO4zYG5AzUmACzcb6rFC5Gibz6zOvvAMvixoHT0k4H7+O0N9ulfmUzPi9UgIVPEO2D4WMrjudA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4SBXarc2ei/nbN9abmeGqZWQYWgBqvc5p2EsrRhccaWP7heJ
	DxKEscaCiDULskdS10c3UKp6SVaUKkFMFc3ZDv1SjOAW12VzcWHx
X-Gm-Gg: ASbGncu4UvXWqsAmpgpDNXULje2MNeeVuySefspmEcigOkp8qy7MEqPk20wneQyenBy
	JUE9wk6Xw8ap1MLu+aKwdi/fW8voTEtryJA90i9+ABYtegbVjTFbzXU43DPtr9Xeowa21GKlBQ1
	cJBFLVdCcaxt+j8UtEQiVhEcYDNHIP2/6aHPJYwaOMiota0s9XxHw9ZoEyESv0SmP4Fm0YX+Vbx
	xBHzYSJsc2dbyZD3LDzcckSH972ExCO6mrnWI4+tBXUDDLUPS17Z1+k5i2ay1d3KIRf7FB6QLDD
	unEKqnhUrHA=
X-Google-Smtp-Source: AGHT+IEQ8ktCEIXZYfxGBQvJN0XMY60MnMJsgrQDbOXvzHS4y+hF4K5GRjd9EaCGACogf65tl83c+w==
X-Received: by 2002:a05:600c:3b0f:b0:434:fff1:1ade with SMTP id 5b1f17b1804b1-436e26be612mr100930655e9.13.1736512776846;
        Fri, 10 Jan 2025 04:39:36 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:35 -0800 (PST)
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
Subject: [PATCH 04/12] dt-bindings: clock: sunxi-ng: add compatibles for V853
Date: Fri, 10 Jan 2025 13:39:15 +0100
Message-Id: <20250110123923.270626-5-szemzo.andras@gmail.com>
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

V853 has 2 CCUs, add compatible strings for it.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 1690b9d99c3d..bb1fa032e789 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -36,6 +36,8 @@ properties:
       - allwinner,sun9i-a80-ccu
       - allwinner,sun20i-d1-ccu
       - allwinner,sun20i-d1-r-ccu
+      - allwinner,sun8i-v853-ccu
+      - allwinner,sun8i-v853-r-ccu
       - allwinner,sun50i-a64-ccu
       - allwinner,sun50i-a64-r-ccu
       - allwinner,sun50i-a100-ccu
-- 
2.39.5


