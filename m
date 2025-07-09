Return-Path: <linux-pm+bounces-30492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B000EAFEE22
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9F54A0D36
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306BA2E973B;
	Wed,  9 Jul 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7bStvu8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BC28EBFE;
	Wed,  9 Jul 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076427; cv=none; b=gl9OxHbm5uWhE/ZE1Zt+Hmq/HuCx/dBR2D7CzEIB12fdhmGaW9SldN87VdhcudzmkGBFyzGAEAJu7Shu8OHZHuFc4HfLWnc186ZPaBWJPxX6GrgecWaDPSChwDfgvjQCAqbwBnEM5Mb0n/WLk5rkOloVaZl8/WnyWRf6l3nZy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076427; c=relaxed/simple;
	bh=X99T3zLCk1wsD+6/htrl/rppok06x79Qi4swnOe3K4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4flQFdUZBcdCTOwri2doRwJ570WUdr8gzOy5zhrt7etmB1Z3hMnzOSMyun6K+PU6gHtTvfq+hctLEz+tnoI5vxh5ewgVKkevB26WJv6o1FuUp2JhsGAqw+5Tq19SZHmBCTaDpCbDPgQMDxRgGT5ABBkeBS5fLI2P1ZXl/sJIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7bStvu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76020C4CEF7;
	Wed,  9 Jul 2025 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076426;
	bh=X99T3zLCk1wsD+6/htrl/rppok06x79Qi4swnOe3K4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7bStvu8t/kBb0l6jYfh1H4MhIj4m+VKvH59Cgt5NpcMySeqHuEHNUsjIDTQ/6/eO
	 OBiy4OlUkXuppnsUJIrZ+CR5X4V0xpSRZoHAKbfymEf/QCuW9noULXNbEno6Lh6jFx
	 tWImZVdEFIhSYrIiFfFhlmCfe1lco0zkq6jKnslV8YDumiRFtPTs3sFCaxY7BO4+oW
	 Lzawg78qkX4bdxWPQ78xKptMeD9rFAo6poIpRI+7OmAJ/2gnFJdOIvGYWG7g383vLQ
	 vYXMQJK2Ty2TbSR34g86HxuKp2tP21aepI7CyvgFhRe3fncoSfrkLQqC7AZMzUZ8xk
	 yCfUwf89AnpHA==
Received: by wens.tw (Postfix, from userid 1000)
	id 3E1A35FE8C; Wed,  9 Jul 2025 23:53:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 2/4] pmdomain: sunxi: sun20i-ppu: add A523 support
Date: Wed,  9 Jul 2025 23:53:41 +0800
Message-Id: <20250709155343.3765227-3-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709155343.3765227-1-wens@kernel.org>
References: <20250709155343.3765227-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

A523 has a PPU like the one in the Allwinner D1 SoC.

Add a compatible entry and a list of power domain names for it.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pmdomain/sunxi/sun20i-ppu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pmdomain/sunxi/sun20i-ppu.c b/drivers/pmdomain/sunxi/sun20i-ppu.c
index 9f002748d224..b65876a68cc1 100644
--- a/drivers/pmdomain/sunxi/sun20i-ppu.c
+++ b/drivers/pmdomain/sunxi/sun20i-ppu.c
@@ -193,6 +193,19 @@ static const struct sun20i_ppu_desc sun8i_v853_ppu_desc = {
 	.num_domains	= ARRAY_SIZE(sun8i_v853_ppu_pd_names),
 };
 
+static const char *const sun55i_a523_ppu_pd_names[] = {
+	"DSP",
+	"NPU",
+	"AUDIO",
+	"SRAM",
+	"RISCV",
+};
+
+static const struct sun20i_ppu_desc sun55i_a523_ppu_desc = {
+	.names		= sun55i_a523_ppu_pd_names,
+	.num_domains	= ARRAY_SIZE(sun55i_a523_ppu_pd_names),
+};
+
 static const struct of_device_id sun20i_ppu_of_match[] = {
 	{
 		.compatible	= "allwinner,sun20i-d1-ppu",
@@ -202,6 +215,10 @@ static const struct of_device_id sun20i_ppu_of_match[] = {
 		.compatible	= "allwinner,sun8i-v853-ppu",
 		.data		= &sun8i_v853_ppu_desc,
 	},
+	{
+		.compatible	= "allwinner,sun55i-a523-ppu",
+		.data		= &sun55i_a523_ppu_desc,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun20i_ppu_of_match);
-- 
2.39.5


