Return-Path: <linux-pm+bounces-16583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B014A9B341D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DFBB22CBC
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76731DE3A3;
	Mon, 28 Oct 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is07J4ck"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA631DE2DF;
	Mon, 28 Oct 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127348; cv=none; b=sIspuqZh1HL2u9WheFfu03SU7we67nEVmZJbqUoRcet4UH7NYLKXwUYloIYpRil9FrQIwKNt0XRxykQ+rgoopxh9bEH5HNsQ6SgcAYlE5m59QR3iK3E+FnKZ5nKsnCJmry74FF8wlweEYGAjCQYmNPAgeC5IVUFKiEfm6wSRsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127348; c=relaxed/simple;
	bh=kfXBgOg6zVWOUGhiSRCKOHrB2fjh1mxnOVSXKq4PZhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiWF7sQzO1uMS8sWHzH1jfp1PUzAoqg/iJa5e8BpGR1FYyuS4m+nq6mazN3AISqAHa0scYtZ+igSjhcknTdXRTewlgIOx3waVZbIE0g4p3G+pK8C/cNJi2wK6RSBun54hSAqaY4dpVI3Jl9xb0h/oNXTeegkc8E9KNOdGp2GviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is07J4ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601C3C4CEE4;
	Mon, 28 Oct 2024 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730127348;
	bh=kfXBgOg6zVWOUGhiSRCKOHrB2fjh1mxnOVSXKq4PZhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=is07J4ckvPrkuc/K82TSFXbfQvuiX7RH2vOSkYGY6qFVUxmrere8HgMtk+W9eTjlE
	 0VQlon7Q1GSsxlaieu0AMoGarSpbqaCUkRAd0OhntBTHVMoP7kloru7ZLfiLkN8ozA
	 s7gb66j6f8aRZ7v7dUhezVQVSFqxSpFBpeeN3Cvmu9CXVww9MYzJa01kByhS7XZo8V
	 p5BsxvgmdrogmDcua3tdAVNNsQTJ2ucm1xKZTad9LXWBuyrzocs1brZvmLFSNM9Ci6
	 IAyhKcfeduUcBcOBk2iRSDojPbbZyox78kFtM8Xoko7cO14pv0Q5khZlNw/XLKbdjV
	 +jlQQbGwv7RKg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH v2 2/2] cpufreq/amd-pstate: Move registration after static function call update
Date: Mon, 28 Oct 2024 09:55:42 -0500
Message-ID: <20241028145542.1739160-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028145542.1739160-1-superm1@kernel.org>
References: <20241028145542.1739160-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On shared memory designs the static functions need to work before
registration is done or the system can hang at bootup.

Move the registration later in amd_pstate_init() to solve this.

Fixes: e238968a2087 ("cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call")
Reported-by: Klara Modin <klarasmodin@gmail.com>
Closes: https://lore.kernel.org/linux-pm/cf9c146d-bacf-444e-92e2-15ebf513af96@gmail.com/#t
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e480da818d6f5..f834cc8205e2a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1859,12 +1859,6 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 	}
 
-	ret = amd_pstate_register_driver(cppc_state);
-	if (ret) {
-		pr_err("failed to register with return %d\n", ret);
-		return ret;
-	}
-
 	/* capability check */
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
@@ -1875,6 +1869,12 @@ static int __init amd_pstate_init(void)
 		static_call_update(amd_pstate_update_perf, shmem_update_perf);
 	}
 
+	ret = amd_pstate_register_driver(cppc_state);
+	if (ret) {
+		pr_err("failed to register with return %d\n", ret);
+		return ret;
+	}
+
 	if (amd_pstate_prefcore) {
 		ret = amd_detect_prefcore(&amd_pstate_prefcore);
 		if (ret)
-- 
2.43.0


