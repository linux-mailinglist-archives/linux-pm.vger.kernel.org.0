Return-Path: <linux-pm+bounces-24695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE1A7790F
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 12:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5180516A822
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C81EE008;
	Tue,  1 Apr 2025 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNt1VGjK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9126AE4;
	Tue,  1 Apr 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504335; cv=none; b=P5zhlwVdxOKcJ+2qwcrcYNrvto29TP0rJ9veGwlFYMom+dVp2oeC1tGcQ5xBffPxKPcByrAa294FlBG4JH4f0pqTokRso/0Oqi2T21KaKU9rATeynFpVFvpUe55DyACFDw81G3hCAdZB7NEhAUibuPjNHPSZbt8N/4b9nCHIBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504335; c=relaxed/simple;
	bh=1J2qbwEWhTOM+i9p0aZch6e63TdcFavMP/FTEsA4tBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f6petCBvo5C/DApjKyfGMlvVW/YtbGyXsM2VWSnTka8JhY5vABgAVS0mgmOOH1Hx5GIvayc+cEjkqy8DkopMEWxIcq18Qa0nkhbmgRglrmhQOdqqjhNuW/3Tyeca0Tgp9KUMB4KyJ+2XR067d26jiIToVtf6dz3qJyU8grLG4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNt1VGjK; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22548a28d0cso144586025ad.3;
        Tue, 01 Apr 2025 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743504333; x=1744109133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+ws8im8ohTlJQtEnzDmiWkVTfAf613mtu+yQQ/ls+Y=;
        b=SNt1VGjKyEF3kjHqcAa8rBPsOAW+B7VegczyqzKfEgH7gmZAewsgzZukbr1XntLhyd
         myq7lk0mb4p/2K2Ma5G7zQHGPJy/I4IDKknRfMVnU47v+EECaMM+2bJZJ9vBoMPceRPd
         Z9g3CLwQesbgZIALw4PWH1fhoaoG/kcbp3+NWWU0btHcOwSC0DcsuSmnmM5juTFg50mF
         G8orYVpJNLNZ258jIl77QE7IenNy1fgfmmchLbf2up7FJN/1ppVWbIJeWUmUQo0fIftf
         5x+fZftSF7gGMj9j2qb1Qvc4AtWQqHrfefI5WkaZqK6PxBbse5IFaPFNfmIXCeWK+LDc
         gr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743504333; x=1744109133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+ws8im8ohTlJQtEnzDmiWkVTfAf613mtu+yQQ/ls+Y=;
        b=CL8mVoZO+icqTR0SgFXSd16cwsoTzJ3TwdMOKUCiT7759w/3gCga6iO+lFN6/D8KK+
         zn5pCFEoaHuN14suR/Cj8EQH+RNwb6IGwMRiZ3URxugHtxNG2BYbIluBg01X07C12eA9
         iyfG75wUHegzr0qNXbVc1LoNzm1/qoyXLs97Qsk+c0vHgp4uvMMhhHFkiJAAAZiFJSrx
         g09efICpWklNHqG+LgSLyNdBD9h7ZbVonnsj601lerq3RWf4BKfr1waIfjeKIwvvqz1M
         nieqX3F0YGdkofCS41N5C+FbC4Z36Mnf8PI5FOjTuiFOIVAZQ9ivt9Pv7zwCBS/WhNKP
         Iifg==
X-Forwarded-Encrypted: i=1; AJvYcCU28Fo3a+btYBYaq8rwVfP69RJ6IQdUne73E5tNdYq2w7+k32N9g8NXD0tqjGnEzC0qBH0UzDcNEgXxyoJh6bgB0xA=@vger.kernel.org, AJvYcCUhPvRvPZdIhdv+ABeAuK2z2/Fd2k7I6xNgxqFJcaCTa/ScytdyYEGHLEj4gTVikTvNssnLXEL8PxrkXaE=@vger.kernel.org, AJvYcCXJNG5KNLmngJnrPizt5WhfxkOhb0OR06r2f4lCxqslEmunmMVoXYQHHYnQDoTxKAovTyWzB55VRDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHh0P5CocPo7Dg2pLQTMWbvxBWsM3oEUG9qNPvwXG0Og8eXxd
	lnB0Mb2mf9DktjO94HJIq0xrrQev7oPBdxs0E/u6gHufWUciRVus
X-Gm-Gg: ASbGnctiFO7zoLfqGKd0k0xIB01TdY2S1R/U4J15UxiZtORUAlQ3kxiErYwK27GtezC
	VNFZ5QutL8eI1vBDDOfF1UTKS5v/uXqOkmYln6yHmrtu2/DuqLXkuGRTUkzBtm2fOQu23B1Vssv
	eG9ry8mHnGRcbEVTyfEV0KxwcvYRaWvlOYBdYCKHbL4/XFZlTw7ZQ5DrptTRA4xrr4XHXPhzMsk
	wtqdJQ3ihBPCZSJoAdjMiWiy9VRoyOO+C5BIlNvaQ37RH3cx/ollcx4jeUFxO8b11NQgryi6EFf
	U97hyxcmMk+QRQNFE/7W9Hq94y6MN/CxBxNB3W1z5V9wVTV+Je+jYdK465MhTKdmofymtE4=
X-Google-Smtp-Source: AGHT+IFiE33VzXMHFadbE/k13q7hzIvU2xHpjvXzKZJeSnDxESI91BfikXodcenS9QgtP0ShUFDirQ==
X-Received: by 2002:a17:902:da88:b0:223:f408:c3f7 with SMTP id d9443c01a7336-2292f96232amr175133745ad.16.1743504333420;
        Tue, 01 Apr 2025 03:45:33 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf4ebsm84926285ad.155.2025.04.01.03.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:45:32 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: georgi.djakov@linaro.org,
	krzk@kernel.org
Cc: s.nawrocki@samsung.com,
	a.swigon@samsung.com,
	alim.akhtar@samsung.com,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2] backlight: pm8941: Add NULL check in exynos_generic_icc_probe()
Date: Tue,  1 Apr 2025 18:45:18 +0800
Message-Id: <20250401104518.25391-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
exynos_generic_icc_probe() does not check for this case, which results
in a NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 2f95b9d5cf0b ("interconnect: Add generic interconnect driver for Exynos SoCs")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: The fix ensures icc_node cleanup on devm_kasprintf() failure
without restructuring the proven error handling workflow.

 drivers/interconnect/samsung/exynos.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index 9e041365d909..57e779b3e942 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -134,6 +134,10 @@ static int exynos_generic_icc_probe(struct platform_device *pdev)
 	priv->node = icc_node;
 	icc_node->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
 					bus_dev->of_node);
+	if (!icc_node->name) {
+		ret = -ENOMEM;
+		goto err_node_del;
+	}
 	if (of_property_read_u32(bus_dev->of_node, "samsung,data-clock-ratio",
 				 &priv->bus_clk_ratio))
 		priv->bus_clk_ratio = EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO;
-- 
2.34.1


