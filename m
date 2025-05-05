Return-Path: <linux-pm+bounces-26688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CADAAAF4A
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6591B6511F
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 03:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1A2F8BD9;
	Mon,  5 May 2025 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuI8mBMC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FA288C3E;
	Mon,  5 May 2025 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486427; cv=none; b=mf+1/RXc4ndeLjD2VjG9DKn1FNCnN6MfYDJQQY24nY5YNIrafpGTQd+Or0/ZuQQCW5JU/o7IBtBGVRz9mVyrUARBW2BPtN9Faka4yILG3pmlsuXytKejeV3kbPaBTHz39CWpG8E+33LNwCFvmRLVY/6/lb/7FKpWitNxlTPE1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486427; c=relaxed/simple;
	bh=wPqWs/MU+mZlGVCIaXuOK7C3hbYOvFqKgchztPWGctg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OnyV6bSvJz5a5jW0kuv0dbrRVZlSQtwcSQ9UyDEetpGrj99RPBjCdfHDDQuNGcEMVxMzmnJfn3r6nDTAhiGK/rUa7tXDx553dKGdORy+9Et8dD94Q/dE3vV5cLikdo2g7iq40r9sEoZKbQgsxS8s8J+2Re4pHHVZ8HnzZBCRj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuI8mBMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0184C4CEEF;
	Mon,  5 May 2025 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486425;
	bh=wPqWs/MU+mZlGVCIaXuOK7C3hbYOvFqKgchztPWGctg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XuI8mBMCgveBLPhT22AV9w/MRnjNcn8UCeq58PvgsOsM+SXRooIuFef6pjUiobTmE
	 ULelpmkWno4Ow3FhVUaPShdLPyMb26mcKIDsmXqX2JXTE6mOKNEjzXXBv3tcC0nkTa
	 cP/47GR8MzSVg/Nzd4bwK3uaFNMa5AlImNbiT3DflpackfRKjuWaHd4EF79x6/UDds
	 mHgkwHPNvzkDrhxfKgk9xaV4+yLEETFWNPEsiBI4ffqko1Q4anwCy8rzbvj7H+hoWr
	 +2VPDWG6bYmzQYKzWYt3uOToVjGc4J7VUyvxzEa3bNtSedkROeTjiSDnYVO7YceWyh
	 IoyLRzrAotkNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alice Guo <alice.guo@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 020/212] thermal/drivers/qoriq: Power down TMU on system suspend
Date: Mon,  5 May 2025 19:03:12 -0400
Message-Id: <20250505230624.2692522-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index d111e218f362e..b33cb1d880b74 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -19,6 +19,7 @@
 #define SITES_MAX		16
 #define TMR_DISABLE		0x0
 #define TMR_ME			0x80000000
+#define TMR_CMD			BIT(29)
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
 #define TMTMIR_DEFAULT	0x0000000f
@@ -345,6 +346,12 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
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
@@ -359,6 +366,12 @@ static int __maybe_unused qoriq_tmu_resume(struct device *dev)
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


