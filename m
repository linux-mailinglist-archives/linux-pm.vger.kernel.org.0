Return-Path: <linux-pm+bounces-26683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1DAAA897
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 02:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9AF178EAF
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 00:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1A351813;
	Mon,  5 May 2025 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjYEPcKn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009D35180C;
	Mon,  5 May 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484835; cv=none; b=qshetWeJFrGoIrH2iJg6nRjQxiRHF42eP0mXYVXxht0e0Sx/fdZGM8SZrcsTuj3zMd3FlMCx+ibkg/8d6LJ0EBItysrTnOKkcB5/GUJmQyHq3vGO4f3Eh+uyT37WREMhRHlxXZnZE8LpGc+wwc3FmZNcezQhtIfzEma8bhM9Mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484835; c=relaxed/simple;
	bh=XGuv68T7aVBqmN9aFUmsC0uDVOK4ein5VyoTAEl3hjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhiJY8g2hfipT+qoW54leTLue+5pxtBBTtTBUGL+JHXiDLqXdkj+oY9XfNoCcfc6re9rFQPjRSUUIehhCkeDXmQ21+mVtz0uV2wVVshoGemGAmQlqJENl/nOcXZqLiv6NxvSc7hHa34T3j9mMEKhP/SvYYJhneFkpLRisbE8x8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjYEPcKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E16C4CEE4;
	Mon,  5 May 2025 22:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484835;
	bh=XGuv68T7aVBqmN9aFUmsC0uDVOK4ein5VyoTAEl3hjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjYEPcKndtnbXYgSdo+IXCN0T5jzPkqr/WRqi3dATsDkjr4UrGt9vRv1hJleE+k9I
	 QcNWQ/agxXDXWRDO79qITOJpdGKoS0uEAYNXruSiiQpUrZtErYtN2uWckVXgxqbsmG
	 FQjWQqfCboNnG/9zUARNSBotImub+ziPrGtB6B7EySUnAGgQA+MR1+LeL/OW2ilepN
	 /qCJ3JYpyil1se4x1eHmRO6NOzlUEZMWUQgGtOVJfU2+UNWvCs3xoyjuAKioJKRZL6
	 Xzm/u6qKC09rX6r0qLKogmJHBKMH3351L8DQrWxCJF8Rc6wmK5ddipa3UUtREKj5rA
	 AX1NE2sEd3r2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alice Guo <alice.guo@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 038/486] thermal/drivers/qoriq: Power down TMU on system suspend
Date: Mon,  5 May 2025 18:31:54 -0400
Message-Id: <20250505223922.2682012-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Alice Guo <alice.guo@nxp.com>

[ Upstream commit 229f3feb4b0442835b27d519679168bea2de96c2 ]

Enable power-down of TMU (Thermal Management Unit) for TMU version 2 during
system suspend to save power. Save approximately 4.3mW on VDD_ANA_1P8 on
i.MX93 platforms.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20241209164859.3758906-2-Frank.Li@nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qoriq_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 52e26be8c53df..aed2729f63d06 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -18,6 +18,7 @@
 #define SITES_MAX		16
 #define TMR_DISABLE		0x0
 #define TMR_ME			0x80000000
+#define TMR_CMD			BIT(29)
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
 #define TMTMIR_DEFAULT	0x0000000f
@@ -356,6 +357,12 @@ static int qoriq_tmu_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_set_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	clk_disable_unprepare(data->clk);
 
 	return 0;
@@ -370,6 +377,12 @@ static int qoriq_tmu_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_clear_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	/* Enable monitoring */
 	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
 }
-- 
2.39.5


