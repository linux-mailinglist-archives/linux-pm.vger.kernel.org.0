Return-Path: <linux-pm+bounces-36694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A140BFFD63
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4983A45E5
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFC62F3612;
	Thu, 23 Oct 2025 08:20:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421E2F260A;
	Thu, 23 Oct 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207614; cv=none; b=GH/6LsZ0pWpssgxW8+QHuISRzJR9YELaQSM67kYkj7ZLukwHNajxCf5TkDi3eNry6HK5rGBAtmWA/tUBodvDZBuGHhgKsAaB19pc+FVa8WTqbWinGCHZW0YvM0V757RWqyDTNlt6Y8rHnHe+GAXffJhIgb4YE4dE0a2XbTqosUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207614; c=relaxed/simple;
	bh=VhPtr6TDNe8OLVZ0qvExPnEgZsGRrfM30yFQB8ExEy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5Ak4merWL/BkV+R/xveQvy5DpK6ttycTPprNk2rvrGRRB/U7WgQe2qF9AnBRIiiW4l/ZmE4cDRF8gJfHPYq0FPf58Qf7M8y2b2wkJpiaWuPXVOsuQBf82S4UtLxjq+wQ7UC9pPz7bm2mVS+jo4Br7wvVM5fE7ziQCGnYLyUmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: a8gUGW8zTVmv6QGKSR7v3Q==
X-CSE-MsgGUID: CHzIUoSHQ+yBT++oK9YlVA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Oct 2025 17:20:07 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 86A99417CA94;
	Thu, 23 Oct 2025 17:20:01 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 01/10] clk: renesas: r9a09g077: add TSU module clock
Date: Thu, 23 Oct 2025 11:19:15 +0300
Message-ID: <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a TSU
peripheral with controlled by a module clock.

The TSU module clock is enabled in register MSTPCRG (0x30c), at bit 7,
resulting in a (0x30c - 0x300) / 4 * 100 + 7 = 307 index.

Add it to the list of module clocks.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/clk/renesas/r9a09g077-cpg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 5dca5c44043e..79083165537c 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -195,6 +195,7 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst = {
 	DEF_MOD("adc0", 206, R9A09G077_CLK_PCLKH),
 	DEF_MOD("adc1", 207, R9A09G077_CLK_PCLKH),
 	DEF_MOD("adc2", 225, R9A09G077_CLK_PCLKM),
+	DEF_MOD("tsu", 307, R9A09G077_CLK_PCLKL),
 	DEF_MOD("gmac0", 400, R9A09G077_CLK_PCLKM),
 	DEF_MOD("ethsw", 401, R9A09G077_CLK_PCLKM),
 	DEF_MOD("ethss", 403, R9A09G077_CLK_PCLKM),
-- 
2.51.1.dirty


