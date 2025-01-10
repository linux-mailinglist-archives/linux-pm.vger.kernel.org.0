Return-Path: <linux-pm+bounces-20215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF657A090F1
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7277A4133
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10D212FB6;
	Fri, 10 Jan 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML+amvuk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD66212F86;
	Fri, 10 Jan 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512798; cv=none; b=cv1koiCVMr/irFaAKFF7zWGIoqMUajeCfqJEURY6wKLOkRGEsPowmyabD9jGnbIQPNc4O2Y14zghthpXYuvskLznlZSWQQEgir1L9mYIyk2K5VjIJ/jCYaFjBQIgDcqWLTxtkcjageLcxtx8cijpKmEZJbStR86fBwrYZkFfpAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512798; c=relaxed/simple;
	bh=fAychnlTty8Tf17BfrbRyxuypyLsiDl4IrtmkrnXB2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Byjqe7JvcDLMOLRT68CV2tqgtv4xDi8G8Q8nJrzS7/rbgVNVGKw5m1TSHgOuTem4p7tz8xf/uVYlBDsmiy69RDe+/iW5RKYzQmj5RsOBmCXmMxd2TbMb0Bo1dGEeL/sAEryO0q3JDd93TuW3eoPEIluCLSZmvDDYGPg17TiTGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML+amvuk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361f664af5so23374255e9.1;
        Fri, 10 Jan 2025 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512795; x=1737117595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igx3vsbHYU2SbSLzctYG8vb+8rPR+0Pom3GeePVXdeo=;
        b=ML+amvukh8YoRbCUrj6POI5IPRADNkLj1lO6DyZirmO952RxhKqFm9O8XfQPQtusQZ
         71oNnC7CVgliwtb5JeIzKcOuEruS021V3Iy0ykqaCQiUAdSFgUucy6bitBNi10m9hA2d
         KrYQRhIejRwln4AyDz6KjR1IUvCG+3thfqrcaMvbjYNfzElsBpbQsQvp2j6aWNexMLuO
         MbRzqr6/P2DiH/uzFzt5TxqYBKuf6Xg21EzGzPTdKV+GKFQ5b5EpEHVs4LCM8AjnaaDv
         IKjTqoITN/MCvyNDf8QAJ5Ah8uuDQTQRphiv8n37pz4qT37XZhlAaAt8yoQRk0fVWe02
         gBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512795; x=1737117595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igx3vsbHYU2SbSLzctYG8vb+8rPR+0Pom3GeePVXdeo=;
        b=Y4m0PqlXNBVNQFcAKJ4aN7uZbRfPt9s/Vg3aAz+zFVo8OxdeKtusPkb1RjYpQbR6ny
         EmfDjpJ6X8On7v2mFfUMYkKxyXbW97dP2vmWNGpk7x2/acCHZLiQnGNqQRQnAfPYLCvI
         d0n6XdzP0RpNlsSlF+/6iHjJi7EEYsp/4Ox0EYLd2SJ6lkLsvW32oEw4sRNoZaudAs8H
         sbUMiDiXHpg9Uy3Tz7Qy/ZJDfqAZl6Xwj3XsDoXYB9J62d1fydgSJ8jkEneRTJnoMxmg
         +DgsiPYDmnzV2ivAXD9zFCYSJ97bgCO9cdM2mEEL7XcwEp3lwaiCYo87XRcXdKg2XF0P
         jEWw==
X-Forwarded-Encrypted: i=1; AJvYcCV/nvQqGvvCUbsm6Qk1MX9/IlncoLc7mhWk66LzmmJ7p6O5hjBzS9a83e3c3m18w6JFkSJ/n5IToG8HXQ==@vger.kernel.org, AJvYcCVb9lbqPqIUNbtJqzKv5YppBpJh1eDZPdsp24NILlZVGir88wvM7WgTtvXrLbxYGZnMZKnKtsbVL4M=@vger.kernel.org, AJvYcCWWRjzu6ZpwasIpen14+tnfyJdkiPzVGvkMYB3Riq3kORZjYTuJMcXpg+3k8NopHO246gOUev4KGSbo@vger.kernel.org, AJvYcCX2FEvPY5d3cOU8Rsbl4N64f4eZQsWh/5Bnl/Nu84ZbJDcmIgi6xuID/WvhUEXLNmUSCUw8slEhr00lmwK6@vger.kernel.org, AJvYcCXJGg+C1R3v/DskF4nFsLHMOcEMEPVwxIVjPULfZb0fUa+3ytfHjWH8bqB7KTYfV9eIQWuBI3QOp6O8@vger.kernel.org
X-Gm-Message-State: AOJu0YyAlS93oBwzFFRfRcLMZMi3CRi2hqJY2Y8Perb9rrFVsE27xdwc
	/AJJSTH/H8z7a27T70/Rt+KutA6S80xPUeDBiyxld5z5aLc2k/86
X-Gm-Gg: ASbGncsMC4EB6mN2eKLZSJUO/5zRuOLJ0qR/q1rU2nBgG7vsmJWQA6M4QCgWtgZ6Tdr
	WmV9qKO6kcYSz8BAYUpCrCZX53Yb1Mih0hkbbV57MNb3JKrTp6z3sC3LxuEdFQ5WNjt/Q62Hyrg
	w/ZRP6a4AwFwj6a403nruPLDCR8u0Of4wzcSPECcqxq0bWGo5EQRWEbEfZeTPB3tqssRkFavgK2
	p0NHj0bdLqu+mvajrfPYwDbeQgpCf/XtM8jBpw0vUAcsuJdDtVCWPBzkP2gu13VUTxkylWrWPnN
	4sV9qw5lSPU=
X-Google-Smtp-Source: AGHT+IHJBa9+air9IL9blTAVkIeyT+Uy608NuMWnh0WegSAUF/lpfSwiNlAx3KeEO2hjhXHZuc5uCw==
X-Received: by 2002:a05:600c:1c8f:b0:434:f586:753c with SMTP id 5b1f17b1804b1-436e2686096mr99189355e9.7.1736512795073;
        Fri, 10 Jan 2025 04:39:55 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:54 -0800 (PST)
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
Subject: [PATCH 11/12] phy: allwinner: add v853 usb phy compatible
Date: Fri, 10 Jan 2025 13:39:22 +0100
Message-Id: <20250110123923.270626-12-szemzo.andras@gmail.com>
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

V853 has a dual role USB phy, similar to other Allwinner devices, but with
only one phy. Add a compatible for it.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index cd159a71b23c..e126a0dcc19b 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -1006,6 +1006,15 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.phy0_dual_route = true,
 };
 
+static const struct sun4i_usb_phy_cfg sun8i_v853_cfg = {
+	.num_phys = 1,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+	.hci_phy_ctl_clear = PHY_CTL_SIDDQ,
+	.phy0_dual_route = true,
+	.siddq_in_base = true,
+};
+
 static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
 	.num_phys = 4,
 	.phyctl_offset = REG_PHYCTL_A33,
@@ -1042,6 +1051,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	  .data = &sun50i_a64_cfg},
 	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
 	{ .compatible = "allwinner,sun50i-h616-usb-phy", .data = &sun50i_h616_cfg },
+	{ .compatible = "allwinner,sun8i-v853-usb-phy", .data = &sun8i_v853_cfg },
 	{ .compatible = "allwinner,suniv-f1c100s-usb-phy",
 	  .data = &suniv_f1c100s_cfg },
 	{ },
-- 
2.39.5


