Return-Path: <linux-pm+bounces-30717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD5AB029B0
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEBB1C221E0
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA9221F37;
	Sat, 12 Jul 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXx/CJqo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13170219A9B;
	Sat, 12 Jul 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752306046; cv=none; b=M8aU49uR28uoBm5SYr2//KW3GoYkd+q6/yb1uwjeaHiUyEsmLJdLa1v7GiplYkcmRj2/g1fugOwHPXPetcl59eX6WBOblGfRgS+8TEq1GOVWXRcFavUmcuJzUZp6zsuBBQrZJhXGT7fSzsjVm+ZIS7zntmFbVdUl7HZ0BVyXLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752306046; c=relaxed/simple;
	bh=X99T3zLCk1wsD+6/htrl/rppok06x79Qi4swnOe3K4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEXEPhheLNJkUsTz0Kb/KGk64A1Eoi/04KVu/GAoOjWUSdPnslF88cGwojCQsoW1e9HrbRj4BWqAMA2LEYMZcy+OUldRk5bhZQ9Wt6vwN7ywoz7YZDDOjKLeyNftkk3oKBDtz50ydEo4j/xzI10wxvg3hyFOD+shJ8zQ4GfTncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXx/CJqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68302C4CEEF;
	Sat, 12 Jul 2025 07:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752306045;
	bh=X99T3zLCk1wsD+6/htrl/rppok06x79Qi4swnOe3K4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXx/CJqomtgwnQpJxpChoXEzdGcCj3/cylxa19BsoEuF0KP+/Czb+5Qtsht5dfxae
	 CfCBnGkU+sEjBuJwqDtweKUohnCss917/CIaza7JWUQ3OFHlXvX8vaTPjiXn+eBYU0
	 2WcoqImW+GvOtb8a5k8TEwlEhQ1kSXqarPhnGgwZOtdCPoHGicfosFiasQmE1w6bGJ
	 7IuM4LeZbRDp37GcVCxW57q1z/0Pl/kVMIakyV71AUstnUZbJSwNYX87eXGsGFibXO
	 u+1ztghFrTCkXwcjHJ+jb4uR1pyzPBel0NZ3C5lRFk5V/FQcOIsKDrBZ1Olu6oWM7p
	 sLY6aEXeVsQow==
Received: by wens.tw (Postfix, from userid 1000)
	id B4E6C5FF71; Sat, 12 Jul 2025 15:40:42 +0800 (CST)
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
Subject: [PATCH v3 2/5] pmdomain: sunxi: sun20i-ppu: add A523 support
Date: Sat, 12 Jul 2025 15:40:18 +0800
Message-Id: <20250712074021.805953-3-wens@kernel.org>
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


