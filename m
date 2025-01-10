Return-Path: <linux-pm+bounces-20206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9AA090CF
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A56E3ABC67
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894E3211289;
	Fri, 10 Jan 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHmw7Ilj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3720E038;
	Fri, 10 Jan 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512774; cv=none; b=LiU7k0xtu3jveStLw7mAQGe4fFtNeF2i/fAtzzPKGY6xuvRAlPK6+a2cYKigZujPWp+tEgWX/fX/F4N2qzmqoGEIrUqHXm599vj1mfPbuWO70I7efK7D2bMA6hmPaQF6gLjhP6H8v/KKZR3XenpanGTMYXqG68cuVc4SRqUQx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512774; c=relaxed/simple;
	bh=vauxvDSwKlKTk6qcnBpjN1w/dRkrra6zyxLDp8MAcCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1pundrwBJnCSl00teqMtjTEGlWa93/oIsWuiRQ+7iRKkO12gS1XkReXpfAPwo0UqN0VsTBf0XYYMcjN2nO+opjiL02nYmEAzIy2Ps9sJrt9IIX8LhSbgGV/pXpa1y0B8Sj90WNDP4qyu4OBxNeO1SWz5wzdi+QHKS8oCsp4l4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHmw7Ilj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43634b570c1so14925445e9.0;
        Fri, 10 Jan 2025 04:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512771; x=1737117571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IDV4rlFDRuNbSeS9oXz02YE2ahNbn5hfSRCRdGOq8k=;
        b=KHmw7IljChgUKiO3CJPAkiblCjwDmT3rDy0xtxWXH0mScspxfZ+XPkRLiZK2omhn+F
         aHDMuVdO3NDKZncqAeeZvjW1xAD3NJtskger9+jzJjcqgbUDF+6sLUAs/C1Lgu8TgKed
         epv6Zw+pJ9B5N+coe7AZuGabkso38PomVpbaiMbtRW8QWA4vi6wufygVdhgLhTdLOOGx
         vd9hdQErv5cgNBOq1w1NLR6BNpU5PRQYO7hhlOwg412YJzQk4FAxOZEOTb+Zk3MvdiAG
         LilwTN74KNhDYwnp1sBpJMJKAHxtdr+MEkzMRtygY+4FDUGtxsJ/kZa8v5XnaKVI6DPG
         zG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512771; x=1737117571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IDV4rlFDRuNbSeS9oXz02YE2ahNbn5hfSRCRdGOq8k=;
        b=Rq736s6ynVVosp6sh/JXgNqIE+zZ3LJBcmqmaNcvLo1412wpkemxmJUbPT+XafAhED
         KWlF1QhbGjQDf7034Sc02/kABArKuYPIFsl9RNQ+Z6mpXgaAfwU0YPiSaU1lN1nU2x59
         bIjru4wl2IDn8y9Qf+3i4KPRp6AhqtsT31+ik5/+c6020ivqAb6w0nvIXam0Rf0f7ab4
         fsOXK8AcY5JMb2oP4bHYYzuZPgo7G3u/pdHAgPN9AIXWz45/SZU7SxHL9Rk2vkHHIaJc
         u0jGAdETFb8hffi7OYxE4MTZG0l3BYWlYe5SHnPLnSDCC3m8LzRTNP8ZXiskktTBPj5l
         uFTg==
X-Forwarded-Encrypted: i=1; AJvYcCUinakfX86jZTEcCGYjSvcKA6913SW1hKzSI0d1ont7eiiEhmAcHdR+wlLVFcikdD3L+eADnAhX0ZYJ@vger.kernel.org, AJvYcCVR+ak559UVV7h7EqDvifFic47OVDcXRigGihhNtCmhCEFKoA4wzjqMoRIpa76tbHGXtC4YgHAHfFi7VQ==@vger.kernel.org, AJvYcCVrYdm4DkhgGL/H6jVJG4EwE7fR2SI5j7Zx3hIcvakOW6ZyuVjDa5+WpHj2JLXrBxT8HlPn/Ej5tOzq@vger.kernel.org, AJvYcCWIouM7748Gge6uPhzuRmWUBuf9lAdWB74WnWRVDHXtpUPvHOmg6dA4+rpHZVUu1xXFXl1SdmITXm900L2V@vger.kernel.org, AJvYcCWJZCdJ/pMo64bmAYnz+ulhZkna0uSI1C1gzup//gMAQQQ+tKJK4ix8UeI8eeVchyKIGugvJZai1p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdPJcovE5KG7aAmQCjL3AmLtZSvFhBxv4JPVyQvhe6/WfB7el
	+xA/pWkNzxGmrHJ2A7JhFSRYuO4xYNdo1muh5WYxjEyYAF16ZecJ
X-Gm-Gg: ASbGncs8HYWm/rObSCpI1VDqj1zVw9ncCsoUpNqeJ85hEAqy5R6TuVhvVVRqEch7Sx5
	JNUuN9B6i6sUYG1rXD1W7lOZkmhTQuVN6GIwC3LJK63surDEie4D9h76YxCzJ2YiqBMG0KmJDCG
	QCwsCW2AxI9suuZy1txF4gAfvG73phWmBhToNNDwfFPDav01qaJGTLsC5alxfKgLv2bA7v/q4WY
	DeBzDH5UgY8vUerpW3U53Gj1PfKY4zhu4HjEIlQt+BA0g4votx5SpYbZa5Mcw5zW1o8+U2bfaSW
	/is9xFa7grg=
X-Google-Smtp-Source: AGHT+IEGd7BTx/sSUTaiyRlVd+uw8tKsr3CTAv2qrkU80Kq5dTpNkTo4ac7Bq005/MdcQmzErXY2IA==
X-Received: by 2002:a05:600c:19c9:b0:434:f953:eed with SMTP id 5b1f17b1804b1-436e2707babmr109962935e9.30.1736512770947;
        Fri, 10 Jan 2025 04:39:30 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:30 -0800 (PST)
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
Subject: [PATCH 02/12] dt-bindings: pinctrl: sunxi: add compatible for V853
Date: Fri, 10 Jan 2025 13:39:13 +0100
Message-Id: <20250110123923.270626-3-szemzo.andras@gmail.com>
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

Add compatible strings for V853 family pinctrl.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index 450240570314..990b78765427 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -44,6 +44,7 @@ properties:
       - allwinner,sun8i-r40-pinctrl
       - allwinner,sun8i-v3-pinctrl
       - allwinner,sun8i-v3s-pinctrl
+      - allwinner,sun8i-v853-pinctrl
       - allwinner,sun9i-a80-pinctrl
       - allwinner,sun9i-a80-r-pinctrl
       - allwinner,sun20i-d1-pinctrl
@@ -179,6 +180,18 @@ allOf:
           minItems: 7
           maxItems: 7
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,sun8i-v853-pinctrl
+
+    then:
+      properties:
+        interrupts:
+          minItems: 8
+          maxItems: 8
+
   - if:
       properties:
         compatible:
-- 
2.39.5


