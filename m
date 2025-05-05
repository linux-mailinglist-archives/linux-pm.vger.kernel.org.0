Return-Path: <linux-pm+bounces-26671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E3AA9F9E
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 00:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F461A829CA
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 22:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D528541A;
	Mon,  5 May 2025 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqj5z6X+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AD285412;
	Mon,  5 May 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483340; cv=none; b=iEeZ5IyIwBGt0d5ZTR0hfblVGqPBOkg59EfPcyG68YW9QUGur/LpNwtGYvjmpEeILeHoli/1zw9Wz+BTOoZbVbvHX7lz0oV5+5KVYzjc/iuZzJYmKqE52CjeMGgCJqT3ZfRB1mPXHac+IIGr3Em9mXY2o5+x3jr+GUUnOlrQKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483340; c=relaxed/simple;
	bh=XGuv68T7aVBqmN9aFUmsC0uDVOK4ein5VyoTAEl3hjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvywNVLzA6AoWggYJD5QOsELtZPCRX+kiKzwDBpFzQdRglDp1PQd57WqWYo9TqUZF+7OYBk3KUF1SU0aBlTuOap0kf6xk5xmFA2cnJHnCkwSJWmQSccwOH+Nltul07w9mFt+RqEnQ+b3+XzV3pWtMQMKnu39gaeEuvg+KcggAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqj5z6X+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D034AC4CEEF;
	Mon,  5 May 2025 22:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483339;
	bh=XGuv68T7aVBqmN9aFUmsC0uDVOK4ein5VyoTAEl3hjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zqj5z6X+ub5evepEY9foshTKYuQFeaLC3NpqWyo11JdXQkqX5E28YfrzOWNlPUPVC
	 ot7+MJY5ghCr0u4RV3fSkkXVEGhyiaSDFFHM/+JH6QqnrfYlOxX7zF4T2e6OZrhYEB
	 GxvYaT5+9p8KAUPFW5U+EoRXpzohs7rmvfSzxsnWGyIQ3ZI4oLc4uHnIjxKW10cbgJ
	 90sxDGO5BQHQxVcUYbkoGG6jvTAjq/fsmhDF9RodzJvLn92FN4bbwfVNkpGbJkZkhd
	 TQNoMozeOiTpCFkvhbCOsiBa4PL/x5KAB1TB+ytpgl79pfzuIkb6VsbQ/sXm4aCiEU
	 dcKguqBmYH3DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alice Guo <alice.guo@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 042/642] thermal/drivers/qoriq: Power down TMU on system suspend
Date: Mon,  5 May 2025 18:04:18 -0400
Message-Id: <20250505221419.2672473-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


