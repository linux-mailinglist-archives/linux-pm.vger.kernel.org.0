Return-Path: <linux-pm+bounces-11923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A3A948339
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 22:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429651F2226A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 20:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7833214A606;
	Mon,  5 Aug 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHfICOL/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEAF13C809;
	Mon,  5 Aug 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889266; cv=none; b=X+EApLl+YKwRYlwpnO1yxJOBNwe1x7bPgnKh62VqK6q3lgN6FfdUujdOq/oey/7HuVplHFsj82AvUPRswpngSvkhm0C9dd/ltjcozxnt3s15mp8PXT/sri6VjuL4G121LK/o7+BVHLM/C23pUCsds0bOARrlaD/hAtVDOcwPDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889266; c=relaxed/simple;
	bh=aSsOKcHWrL7OYpaiilqQDg8DY+BVww7YDCEqeu+txpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0g8cmXylicOJ3jk4ZeO2Qd8DSKxQVQ08Ae8R6jiNKnzYheLG092LjZIYgyLDNTwkeTs0nm5TmeBzU6nGepCgAypJWz9ARBBYVwhY8NjhUefMOJ8urkuKH3PWPtQ9/KPU0j7lLhPnG2csuYIyu66bGVgncgelZ2XFfuA/V197Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHfICOL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE1FC32782;
	Mon,  5 Aug 2024 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722889265;
	bh=aSsOKcHWrL7OYpaiilqQDg8DY+BVww7YDCEqeu+txpg=;
	h=From:To:Cc:Subject:Date:From;
	b=QHfICOL/l0EGSBKfixpcy5rxrg/laYgHcSiWfX9HaY0pYI3nxTTzgQpr6i/2vptjM
	 f1F4XoLKA917AIWeB2tjmFKL2Qu8Di+3dmBE97A50OaEM+m2QVHxvaxl4qxia1nd4e
	 EPWBNAFaXMG4ruJBzvDmyOgkzsRn5J7D/r3zDIuyee/x+9dfw67LpGaLcAiyRwRRhx
	 oA2Up2yOYcN5/jIwpARakN971a8JgpiKv6/mG0/R8B2PsBZjt+F5VYGx2YVTuOFpgd
	 jFjcuiWeo5lzEIqxcCwb0xVGx4U73Jt5jLFunWAoC2MhSVvEp5hOb8VMldk0D+UmQt
	 y5wV+/Dv/RNTQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: kernel test robot <lkp@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] cpufreq: spear: Fix uninitialized variable "i"
Date: Mon,  5 Aug 2024 14:20:41 -0600
Message-ID: <20240805202042.3229190-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refactoring in commit dca2ef2b7d91 ("cpufreq: spear: Use
of_property_for_each_u32() instead of open coding") left "i"
uninitialized. Initialize it to 0.

Note that gcc doesn't detect this, only clang does.

Fixes: dca2ef2b7d91 ("cpufreq: spear: Use of_property_for_each_u32() instead of open coding")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408030418.gnJDcCpm-lkp@intel.com/
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/cpufreq/spear-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 4d28147c23f1..f8c16699a68d 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -173,7 +173,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
 	struct device_node *np;
 	struct cpufreq_frequency_table *freq_tbl;
 	u32 val;
-	int cnt, i, ret;
+	int cnt, i = 0, ret;
 
 	np = of_cpu_device_node_get(0);
 	if (!np) {
-- 
2.43.0


