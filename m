Return-Path: <linux-pm+bounces-21396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160EBA28AD8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4161164CBB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDFE13C8E2;
	Wed,  5 Feb 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMIemiy0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E482D98;
	Wed,  5 Feb 2025 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759962; cv=none; b=d7iL7OHhHh0qYD7RfnxRAApP75z10x9mkQ15nObw100KG9NgQ+yDs9hhKgBcYo2Ma8V4D5mHrgnUqZ9mS28nGHoItitAIQURbgQnHsSHU3qKjb+99a/0t0HytVvGwiHtGmR/FO+72EhVuscZHCgOM0w5rZTzpG0/e9wBJ6E/UPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759962; c=relaxed/simple;
	bh=sNeUaSsNfk2mWBS/Z6Pa2pSYUp7Gc/6G9bD5NGx0EYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFvOCaTp5RpxxASdaPSiRjtOB+xEjo1w7dI34GPKGASt7dyLbOrcVQWPelNhmjWx7SUTIhD8necPEIuPEQphzZm2IicP4qiaSuulAOLOxvWsq3X02BBB8SS7H8BOEWN8F7CzQbIKLHq9DusDE/H9ylwWuczLNB7Ra0fNDiKukT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMIemiy0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaeec07b705so1127780666b.2;
        Wed, 05 Feb 2025 04:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759959; x=1739364759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEOAzVx6WPB9stA5mr4n7x/fL+LclH0gvOV71KsByXY=;
        b=nMIemiy0DZhD2uXOPS0xlHmM0PTVbTf43TShrB4Jpu3F/qDf2+x2X4XoyUMcmGUtZr
         E5Wo89MmaN8ya3IPRk9gV5GRjr3e4PLUvTjEwVMuqLmflaUrr+eA6VxADhp1jm5gpD9o
         Jws/wiZrGA830rujfPlR39RjSXvPKjqh6e8Yp/ZjaomWgCbom2Y4i2JJahngA2cDH+zB
         vPdPvnrEGwmOKsb4Dm+Y1zsoCkQhUxKaQi+hrPhRaeLyDESNrywNG3E7qbfjG3ZPVwnG
         YLQEhnkHpcIory4ZdfEbq+t638zrQgYhzMuJxIDKrv4Z55tVgHPGSHLYZ7waUJnzeqTd
         neag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759959; x=1739364759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEOAzVx6WPB9stA5mr4n7x/fL+LclH0gvOV71KsByXY=;
        b=hVPbV2SPbsPVdwg6njRQ3W6RlPg4pzZqVL+SkFXrLBLq4e1wlGPlxf18Qt81oELLr5
         ifLUf+llwAudIv3f1ucAegcDuq+lqG2v5AMueI+Jq33LG4fl+mHSUHEfotkLfmAxuCVs
         nwTqTxXIWDjP+57yy0WWAH6KbnZuijAAvA+COiCTf0uVTO5SlcG4yxBgdNmroPntGCza
         6egJ3g+WXr7wpRXrq4CSBGJAxIJkfm7fwS8TIqB4ve7hRXd26a1Ks0Sw6rOhmb7hUhpq
         HIlOMbR1ImaoihXuFUCBbSBHaL8AEKNueSRXMMKJmItFJaZqTdZvmz+JvU5Hm6ErzXRL
         MwBA==
X-Forwarded-Encrypted: i=1; AJvYcCUi0C96n5V/agLFfjFZ1JUvGWMrOAPysBpS4Vh3wcepot48fTyy9hvb5GzYGxnEh9p4np+rrNsreZT4hQ==@vger.kernel.org, AJvYcCV1cQXL3nkJRV9wj9sBns3BIwxcEr1r0CD7+fwcfGK6eJ2R/2d11HvMth1sGnnJweKGhVM4sVL//RdV@vger.kernel.org, AJvYcCV2uJjLCkEsfRYulaSRP4OqpzDk06TkhAnbmkcdd8+UobzKhgVjsJhUx0eqZFMYh8IzPqdREzQizBqqqRwH@vger.kernel.org, AJvYcCVP6W/DS1HRbEV2I6CL2otyY+AOrJgDlKXB/eICWhcgFcTI0l/io23eg/0/wm/mLIesGuSEKGb7vBlF@vger.kernel.org, AJvYcCXOqcYuwuY6aZEsHzE4C/9v5Zyl2zgPR9xGxfumBgqa/18fj0uX0QIDCODiXOuvrDsSz0lewHTvVMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSbi74j4qlGtQgbhMDJpR4fAkTYQ4bDJArTQG/G6NUpOc8GBe
	siKoPDU/jRb3HMzYTEiINL8YZ5Pd2OduBZi2W/B6ny1kChuaS43f
X-Gm-Gg: ASbGnctZA2r7QFGbVm0idE1u6f6ZFX2h2PXmXE1MMlLiiSdRAn47zIDDoc9li0Imayz
	mpqVe1kcpUavHdXc3wFdZ2rpPrXVJC52CnSO6S0M9xTFrLE+f7DT7Fqs9Z8Uev+pX+qidx1663w
	rkppVGqoGAy0E/+U7cTCxkMEhWrySxMRVYb4rM/zIbTOHavfZgVBfq/9irbHShBAzDzy9yC9DWJ
	izBjXE4W1Nn5TUnmdDXSl4xmQNulC7gmNj+TAzIzdchzQNWtMxDkuytDaHNuw90KJoQl8oU3gG6
	xyWd2hd5WJEpeLBWBDLtEyaA1ANBhyp59IogHzE+8wBcUw==
X-Google-Smtp-Source: AGHT+IGXrMqsMiP0zkOFbpXcUy0rvilFMJQHNVAo7U33xcsXTT7GzHgk1vRH+nlowH9w2lytesYKDg==
X-Received: by 2002:a17:907:3fa1:b0:aaf:86a2:651f with SMTP id a640c23a62f3a-ab75e2fc295mr281783466b.38.1738759958692;
        Wed, 05 Feb 2025 04:52:38 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm11559997a12.45.2025.02.05.04.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:52:38 -0800 (PST)
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
Subject: [PATCH v2 06/10] pmdomain: sunxi: add V853 ppu support
Date: Wed,  5 Feb 2025 13:52:21 +0100
Message-Id: <20250205125225.1152849-7-szemzo.andras@gmail.com>
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

V853 has a similar ppu like Allwinner D1, add compatible and the available pd names.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 drivers/pmdomain/sunxi/sun20i-ppu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pmdomain/sunxi/sun20i-ppu.c b/drivers/pmdomain/sunxi/sun20i-ppu.c
index 8700f9dd5f75..9f002748d224 100644
--- a/drivers/pmdomain/sunxi/sun20i-ppu.c
+++ b/drivers/pmdomain/sunxi/sun20i-ppu.c
@@ -182,11 +182,26 @@ static const struct sun20i_ppu_desc sun20i_d1_ppu_desc = {
 	.num_domains	= ARRAY_SIZE(sun20i_d1_ppu_pd_names),
 };
 
+static const char *const sun8i_v853_ppu_pd_names[] = {
+	"RISCV",
+	"NPU",
+	"VE",
+};
+
+static const struct sun20i_ppu_desc sun8i_v853_ppu_desc = {
+	.names		= sun8i_v853_ppu_pd_names,
+	.num_domains	= ARRAY_SIZE(sun8i_v853_ppu_pd_names),
+};
+
 static const struct of_device_id sun20i_ppu_of_match[] = {
 	{
 		.compatible	= "allwinner,sun20i-d1-ppu",
 		.data		= &sun20i_d1_ppu_desc,
 	},
+	{
+		.compatible	= "allwinner,sun8i-v853-ppu",
+		.data		= &sun8i_v853_ppu_desc,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun20i_ppu_of_match);
-- 
2.39.5


