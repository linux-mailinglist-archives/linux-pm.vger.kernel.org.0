Return-Path: <linux-pm+bounces-22966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5849A4571F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D181777B5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F38280A22;
	Wed, 26 Feb 2025 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS0zs3ud"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA227426A;
	Wed, 26 Feb 2025 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556200; cv=none; b=irWJEqsd7IDXFIc+FGxvATbeVDIrnNExo07gwG2yx0a4l32Bg9U2RD/dKQuYI0lz/wtDnB07qQG2YJV/5uEsJALPs/B49My7Mvnhlfzdo0k+R8Nsh3ZwvMlgsNATIyvEf4z9XutnYF4rC3bWMyezwTjrPDXa1zTsaOy7Gg45Lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556200; c=relaxed/simple;
	bh=rU//cHwKIhLi6KZBHAg93+4ucs5Sgd4xwHdvD2vWArk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGLb+oAnCKBTlIMxWLL88kf5vwm2G9IBFFVgACM+NJgkaedBvF6AsNmDM8NpBWxYEznMZQTzlnd2mwtBoOKa84fypKAQjf439s0erUt0X5ZsWgbM0dTQLeKd3Ur2iow6rb/k/ICCQ2IVTGX0tU0JtBdDCyhHjYOYWqiHTHsWFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS0zs3ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DD0C4CEE7;
	Wed, 26 Feb 2025 07:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556200;
	bh=rU//cHwKIhLi6KZBHAg93+4ucs5Sgd4xwHdvD2vWArk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tS0zs3ud6xw7wny9/SBrsrVUyVyVHsZhMS9SLzBpGXpNzANNfpY2Te6RZHBU6XUVS
	 5s7X134UoMWjA5WQ1mczNMnDVZbLV1zjE26olhMfP5qEEHShEJsocXiKrYLPC+DynD
	 GCbaPgdQTnG9bd5LH16XIY3fPv62oPNOVYqtYkz75zguazACFB98U8dxzTD58jLR+I
	 qKr3+uCLkjvjNBCyCZYOHrp8JG+peg/q8JVMb1QZu+0cmhXlCaUCZ7AHKqFuhYMpcy
	 uJRtw0v/nN4qKl8j83bllAnb6M66xj6030p5rUkK6OlzVFFBL6tQb4OrjOCFDX1ukU
	 K1YUW2/rK/SQw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 13/19] cpufreq/amd-pstate: Cache CPPC request in shared mem case too
Date: Wed, 26 Feb 2025 01:49:28 -0600
Message-ID: <20250226074934.1667721-14-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226074934.1667721-1-superm1@kernel.org>
References: <20250226074934.1667721-1-superm1@kernel.org>
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
index c2260bbee4eb7..0c686af5e062d 100644
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


