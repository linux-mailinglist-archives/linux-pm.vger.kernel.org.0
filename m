Return-Path: <linux-pm+bounces-22504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AABBA3CAD9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EBE3AA5DF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DF25A2AF;
	Wed, 19 Feb 2025 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlWKDI7x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D725A2A7;
	Wed, 19 Feb 2025 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999009; cv=none; b=H06u6ksuJpLPe2ixsfTgYAs8zo9EDGe4r1IFTxQ34iSiVsE5eN6S7keApiAW05ABcm8Y9NqZ+t0TXbpRQrLghvbVR0R1cZm8z1obwQpU8y48mpTFiWY8CyVjKDixOKRS7pEeYjjo4t6tN9Zv8/cA4XL9XIFErEJdRBXAI9i5444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999009; c=relaxed/simple;
	bh=4kmpDcJYHAf7oC+MSuOAiYh0nvQUyxcc60WHo3npwuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gavthd9NuSMcUDwSUdgP/v09t6cSw2GJOSgWmNK55+mMppgj0fGkoJyf3IfYjvLclDigTQQZPa82CWAxNeS1JjRmOpTImX2H3o72j5anQavht79t03ak3fYfZIkhhGPKQ44bK6q5gBZp8guzITM+9vAE+SqUzR+ur4xihjvbmA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlWKDI7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79542C4CEDD;
	Wed, 19 Feb 2025 21:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999009;
	bh=4kmpDcJYHAf7oC+MSuOAiYh0nvQUyxcc60WHo3npwuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlWKDI7x6qD0Fx7oEvzy0yX6qPTdxH5E3FQK2jS8iteRhu5XUtDNeGbF29+6lAXhV
	 lo2rFmKRiAwnxn0NLheoCtq5FgKHroWake/sQ7b3lfjBC8SIu6f0O+rwWARw8yhYHw
	 MG17Pxirm/5TtymgPXKtaKq8HH1+q7RWOHzOu3Z/y4IIedUWM/ILByr7sKOFwdOGat
	 evXU3kUroWLJ4168RTWYhkz7GSIuxkirb49WBOCWV9M1sFB//9YV0AFMi5HznuxJI9
	 l4E/cljUbeL2J/qDPKIGTw1bvW1RLRyWkQ4MjTWHFpL7tU2qATgXa7UqdAcEhTWVfk
	 Xi340XX5NVR/g==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v4 13/19] cpufreq/amd-pstate: Cache CPPC request in shared mem case too
Date: Wed, 19 Feb 2025 15:02:56 -0600
Message-ID: <20250219210302.442954-14-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219210302.442954-1-superm1@kernel.org>
References: <20250219210302.442954-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

In order to prevent a potential write for shmem_update_perf()
cache the request into the cppc_req_cached variable normally only
used for the MSR case.

This adds symmetry into the code and potentially avoids extra writes.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cd4048908acf8..4f97c8c104b62 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -496,6 +496,8 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
 			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
 {
 	struct cppc_perf_ctrls perf_ctrls;
+	u64 value, prev;
+	int ret;
 
 	if (cppc_state == AMD_PSTATE_ACTIVE) {
 		int ret = shmem_set_epp(cpudata, epp);
@@ -504,11 +506,29 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
 			return ret;
 	}
 
+	value = prev = READ_ONCE(cpudata->cppc_req_cached);
+
+	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
+		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
+	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
+	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
+	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
+
+	if (value == prev)
+		return 0;
+
 	perf_ctrls.max_perf = max_perf;
 	perf_ctrls.min_perf = min_perf;
 	perf_ctrls.desired_perf = des_perf;
 
-	return cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+	return 0;
 }
 
 static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
-- 
2.43.0


