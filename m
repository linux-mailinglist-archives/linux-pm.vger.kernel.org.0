Return-Path: <linux-pm+bounces-23416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB0AA4E5AF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA5C8C40EC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B827CB1D;
	Tue,  4 Mar 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="qSMpyj3B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jDSKMzdK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6862BD59F;
	Tue,  4 Mar 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103389; cv=none; b=sOnxDSFucHj5UdrT/GOX7IDZ9cjVGSK709c6AGpYRXFjqsqjRIUQ4iYTpC6tyon5IbPfJ70uTOR+h2Ju69l/muYxj2/ko7ZhLFuUyWFayHmDdGCK7kMd1FH2H4TOeglksogqnIeNAyvQguxQhT/I02KD8dS4jxVOz46udeu5yNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103389; c=relaxed/simple;
	bh=KpOBBY6WRXLagv8RIY0lnTlBIQOQa93BHXs62YUgAlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwBhhkm+1W0Jt+d7KuX4LWYJJVECK5cuucPp7/4u9+WGT5+PDpcTzQkBgRMwnFCgjjdLugxocnzgYJAxF7H0OMHUFkH/OeJQPM4IltMZ4k6RYGOpWsPswQ2fJkGrjZWL1eLw2hQiukA65omUDoi/AV3BM76UFcsL+T8xP6MFB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=qSMpyj3B; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=jDSKMzdK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741103387; x=1772639387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RxjLY+dO2+M6dAPP4O5C2TYlQAkIEGVFn+LqzUU56xk=;
  b=qSMpyj3BRSwjaKjsekqjGfbfvIyF0yCFpNOrX0ykjgsPaQOT/6oXJOK0
   +vhIs3cS5C00E70LzljFHGvFVzwlCYnQmI5AMCpNjK2QX3dS62o+j1c20
   a9avHfueda70DgkTXEHN68J5qt+NRYtfJKd6zL7gjngYY1qpcqvEk0NqZ
   CWuAuHGTgLd8euZYcJ2gZOSZDYbbn8GLojMjiwLASJxNjWIGuenGCBeyF
   pi1NdACDeAY4hqLnzxuK9gfQbMv1+RkL2RM9K9ojWG+LpSyKoaM10arI6
   QFoSNYxpC9QLKVLe2ZX2cFVq5um9X0BtHfbN8Wm7sqx969wbt4Cl09yqs
   g==;
X-CSE-ConnectionGUID: srgkOrVoSMGCzSHkE6t96A==
X-CSE-MsgGUID: VITbaLT5S6KiMjEaQghCIg==
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="42272731"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Mar 2025 16:49:44 +0100
X-CheckPoint: {67C72118-1B-B1D34AC3-DEA5B19F}
X-MAIL-CPID: E0D2B10078B4CA83A8D18B3CD17988BB_4
X-Control-Analysis: str=0001.0A00636B.67C72119.00E4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6641016190F;
	Tue,  4 Mar 2025 16:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741103380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxjLY+dO2+M6dAPP4O5C2TYlQAkIEGVFn+LqzUU56xk=;
	b=jDSKMzdKu3rSdQ/LMNCBayk1t2v+VAGcA84zQfLZTsPYgCv+uM4h2jjqV1CHbwe7nS8b26
	kHic7Upuv68wa80OQKIcbUzoL0ErVV2yLyqaZWWTL53rbUP9hlhwWBmY/5HmMiABrdD9pG
	E2qb6RydzNlSYreRljFVZuvIR2osQ1fCo+xtOnW6qlLRAK/iqQtOb+rKnL6eudhTlWsfpd
	FsmfhLZURQJFvoopeZXjKGU0vXKWU4fMsvCVTssJ5YMhMNSM/z5+Lq0DMASoPr8ul9bRj8
	VKxr1Qcu9OeFmbO+knq3/8+7VoGqcY81LtAnkEI2mmj/XGzj5v0JLS+w6n4IIA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 1/6] clk: imx: clk-fracn-gppll: Add 477.4MHz config for video pll
Date: Tue,  4 Mar 2025 16:49:20 +0100
Message-ID: <20250304154929.1785200-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add the 477.4MHz frequency support that will be used by video subsystem
on imx93.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 85771afd4698a..f0c34a02acac3 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -85,6 +85,7 @@ static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
 	PLL_FRACN_GP(519750000U, 173, 25, 100, 1, 8),
 	PLL_FRACN_GP(498000000U, 166, 0, 1, 0, 8),
 	PLL_FRACN_GP(484000000U, 121, 0, 1, 0, 6),
+	PLL_FRACN_GP(477400000U, 119, 35, 100, 0, 6),
 	PLL_FRACN_GP(445333333U, 167, 0, 1, 0, 9),
 	PLL_FRACN_GP(400000000U, 200, 0, 1, 0, 12),
 	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10),
-- 
2.43.0


