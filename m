Return-Path: <linux-pm+bounces-34642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDF5B572FD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14736189B4FD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB212F0680;
	Mon, 15 Sep 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQEsE9ER"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF52EFD98
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925224; cv=none; b=bXL/hTsQOHrUNyszdZ6hSO5iSTSClZTrdubD/SHX0IevLMJUSIl2FrG3wf4p+jKTIXXjBY6IB/takrI2EOkrr++IHvNcrlDCZfqRXxVvNlmEzo2nHt71QqcIkNge15bJM52h3CfKiUdYsh+pEjjdqFwyuWzUM4OByVaxJHGae2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925224; c=relaxed/simple;
	bh=VZtjZX5nWnA6XHKHLY/D8R3Dg/JFKTJfQ8yOs63cA6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV4yYnzs6Mk7UU+k/lhhVJ711cc0tzDzCa6hOFflv6vFElDeo2d28W0Vy+VXaFA60BTcQMftWmmL5yM+U0hpKK5H91pnE9xPCZd3yKUaPqr/IaCjTKJNH5hMqeq7f2q8z+W6OLvFzx2TMW/mXFjLyvWdG2kUrKXLlHTmqXSiOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQEsE9ER; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f716e25d9so3983442e87.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925220; x=1758530020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0bQRlmnKfDqgMf8snk80FkB/8ickhLw4rD40tCbpRQ=;
        b=QQEsE9ERSlV6BHJd5JcA4m6RztV6bPoIsabBhHA2etyBN0xKq8pvWG01nuS872bgT2
         z8C+vlyB7Vad+1IKY3KxitDtId/WpdhUOywPghKqyR6v8/Iw+l6i8EJPCui1eh6E5zfF
         fpdvGWkt0zgAhEZ8qieOaf0QJ/SMYlLJeHfgcpWzT5Xs6nmZkgb2FqLHymym3SySl8PF
         HDqhJQvCqaHAjibM5FNm8rL1M7AcWaD3MP52Lqp0MHi/gsyzS3jx1VEMiekFKP/ABJmF
         9A90PHzyeWJw3N5tlhvD9dHGzL2yk34afES80JkxjzTLTgf7/J7dPtbH2pnGDf+OQM7R
         Iqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925220; x=1758530020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0bQRlmnKfDqgMf8snk80FkB/8ickhLw4rD40tCbpRQ=;
        b=To3VoylJdOJ/VmZZUT7gkKFndQ4UvyHcI3JfEoLUTidKoLPf3sMydECNBATWvR9+qa
         cYFUWeX15QaDlfQyV5Uf96szNRnBi56YNS81d7qo+bU+bURrCF7OzvqVDHrxymvT7y0D
         vOeuRJf/zKjSXHTTAV8hRDEnWu4pIDAcdtoT70+P8SmAi3MyO8O6Q7fuP9vMnNl0WXPG
         VpSWOtZq2zoU2IbnKOVHtRtwFGQC2eDidWblN0VxdHtjcagQpnJPCFPuvkhMnQbMWZIk
         OvMT5g4Au2xMDNmPeyGY5e8r5igyNtCpxIdn7QaSHuUJ2J4GNWavGLcxxiNt3Um8R/I+
         YM6A==
X-Gm-Message-State: AOJu0Yx1Y42VdhlHBFhDH/PT/9Sfim2vBBkQNnTmk+xjDYlG6QYxbrQB
	lVhjmTh5Mg1OzPNFZigEXro9rj1Kn+GbaCaBQaxciu7uVJbNgvoP/zq4KltNOB1KHWKJe4WQ9Ey
	OIXsbnrU=
X-Gm-Gg: ASbGncvfBtKFOh8VeRL1eYj++OiwIujlsfxpza+USVJK0SUJMucmJp8IIFt75sFhgfD
	+sMwz9cc/jda9NC79XWjs9VbfSLbY+CbvUNeDjzpGphx6EoFEuA12475i0bBRVlz3tdMHsArUkr
	q01jzhD5ONMq+KkjTYDR358moU1krCbrtvTC89UGgFKYnpIoadYtw5WI6p4O2jN+5jt4o1B743R
	9OD0LcEjN6CuFdPPAUIoBdwZNXqFSjPPHVi49tp43rhi4Fr7ukO6mNbf3URodVTXuh2ajKnKuuq
	8WQEidfqrTpUEJmgGHQypOmiwKylQipx8TCdnjgffi4ovFdKmIrR93IyPrFqPrICPGTKTAkWn6z
	Yne0Vzr/xtB1WxAepAWZdC4oZrlfj6G1T65BD6HsTXQgIWCZ+wPNn4Ys=
X-Google-Smtp-Source: AGHT+IGPhTuEG2m4SiCDqh898kzAlhbg8Uvlnka6m56w2D7gJmLC1nJiufAqd/hfn5WD27cwWn5ytA==
X-Received: by 2002:ac2:4cb1:0:b0:55f:6d28:bcee with SMTP id 2adb3069b0e04-5704f1cf24amr2705611e87.34.1757925220270;
        Mon, 15 Sep 2025 01:33:40 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:39 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 2/4] mmc: add COMPILE_TEST to multiple drivers
Date: Mon, 15 Sep 2025 11:33:15 +0300
Message-ID: <20250915083317.2885761-3-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These compile on x86_64 with =y and =m.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/host/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7232de1c06887..b14daa045eff9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -56,7 +56,7 @@ config MMC_STM32_SDMMC
 
 config MMC_PXA
 	tristate "Intel PXA25x/26x/27x Multimedia Card Interface support"
-	depends on ARCH_PXA
+	depends on ARCH_PXA || COMPILE_TEST
 	help
 	  This selects the Intel(R) PXA(R) Multimedia card Interface.
 	  If you have a PXA(R) platform with a Multimedia Card slot,
@@ -608,7 +608,7 @@ config MMC_SDHCI_MSM
 
 config MMC_MXC
 	tristate "Freescale i.MX21/27/31 or MPC512x Multimedia Card support"
-	depends on ARCH_MXC || PPC_MPC512x
+	depends on ARCH_MXC || PPC_MPC512x || COMPILE_TEST
 	help
 	  This selects the Freescale i.MX21, i.MX27, i.MX31 or MPC512x
 	  Multimedia Card Interface. If you have an i.MX or MPC512x platform
@@ -866,7 +866,8 @@ config MMC_DW_PCI
 
 config MMC_DW_ROCKCHIP
 	tristate "Rockchip specific extensions for Synopsys DW Memory Card Interface"
-	depends on MMC_DW && ARCH_ROCKCHIP
+	depends on MMC_DW
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select MMC_DW_PLTFM
 	help
 	  This selects support for Rockchip SoC specific extensions to the
@@ -948,7 +949,7 @@ config MMC_USHC
 
 config MMC_WMT
 	tristate "Wondermedia SD/MMC Host Controller support"
-	depends on ARCH_VT8500
+	depends on ARCH_VT8500 || COMPILE_TEST
 	default y
 	help
 	  This selects support for the SD/MMC Host Controller on
-- 
2.34.1


