Return-Path: <linux-pm+bounces-30719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D002B029B3
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 09:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B971C22142
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 07:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677BF22258C;
	Sat, 12 Jul 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn3HgoY6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE522129E;
	Sat, 12 Jul 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752306046; cv=none; b=IpJHDUH5z6Jf0VxLPwFkzJf3xSHwM6qHbwfIDdSk0FZ0KgQvGmyjfDah4umLcU9K3KzCefj1dBUyyXoQNWzyDsr/81b1d8J5RBDEOEz8GiqrtaGy40GBEI7GCP0vUXK057ui/t6458vlkkgCgb6lr6wfIOP6nbgo5UyWRYkrEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752306046; c=relaxed/simple;
	bh=6uHbo6HUenPSIvGsm+OeKmKy0pXsvQeHi/n/do9ag0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBTW2arZP9kbd1bII5ypmA34/cabMocoJhOomifGPcA7oyMGhgQEZlO9k2mi38QLWPt/Z2WT8t1CVf+8+GVvpCvFbYYKsj9FU/+zG7gEORhvOQ/orJ16DBjlNMQXS+7MelmwjPIoDB3lcXVcuRYoQpQgjTcl0icpJ2ABM7uxOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn3HgoY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CECC4CEF6;
	Sat, 12 Jul 2025 07:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752306045;
	bh=6uHbo6HUenPSIvGsm+OeKmKy0pXsvQeHi/n/do9ag0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yn3HgoY6eLTvQY6S6cDuf2aghwU79S3PZ0Tbv+hkCb9apGhxhd9IPYR6M/x3f/7My
	 idhO6DhRZ8OU/2/HpBZvK3EhRiffItHCh7iZp/hsFB9g/qQlW/4PV1OpvekDx9WRyr
	 wV83uWA0Pvl8w3KB1OQXu4M/GNh6OdWtyy8iCRl30oqWoeAQMW6dZEiRDOokIpANTq
	 uabHlUeX5EHOyBuyRHFhOfft6Wb/nqEL00L4hpOp88XkxN6nb4H7O2q6Sy3j/Rj+Bj
	 JeKxPqbovPxGs/T72Wa1XrISH3Dhj7Wf/SwPqNeexFgVZ2X61SW7iGXpj6/PRVpqz3
	 37tNPWINycrDg==
Received: by wens.tw (Postfix, from userid 1000)
	id A3B8A5FFD1; Sat, 12 Jul 2025 15:40:42 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 4/5] pmdomain: sunxi: sun20i-ppu: change to tristate and enable for ARCH_SUNXI
Date: Sat, 12 Jul 2025 15:40:20 +0800
Message-Id: <20250712074021.805953-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712074021.805953-1-wens@kernel.org>
References: <20250712074021.805953-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

There is no reason why the sun20i-ppu cannot be built as a module. So
change it to tristate.

Also enable it by default for ARCH_SUNXI since this driver is required
for some peripherals to work, and update the help text to reflect this
requirement.

This aligns it with the new PCK-600 driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2:
- New patch
---
 drivers/pmdomain/sunxi/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kconfig
index eb1ce2dd8e53..858446594c88 100644
--- a/drivers/pmdomain/sunxi/Kconfig
+++ b/drivers/pmdomain/sunxi/Kconfig
@@ -1,13 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config SUN20I_PPU
-	bool "Allwinner D1 PPU power domain driver"
+	tristate "Allwinner D1 PPU power domain driver"
 	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on PM
+	default ARCH_SUNXI
 	select PM_GENERIC_DOMAINS
 	help
-	  Say y to enable the PPU power domain driver. This saves power
-	  when certain peripherals, such as the video engine, are idle.
+	  Say y to enable the PPU power domain driver. This is required
+	  to enable power to certain peripherals, such as the display
+	  engine.
 
 config SUN50I_H6_PRCM_PPU
 	tristate "Allwinner H6 PRCM power domain driver"
-- 
2.39.5


