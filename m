Return-Path: <linux-pm+bounces-21512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB4DA2B485
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BD13A7455
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150222FF31;
	Thu,  6 Feb 2025 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/FnBGRV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822022FF28;
	Thu,  6 Feb 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879045; cv=none; b=qtk3PH4baDlEZY3GW46NtweKxP6hhx1AVSBNcjtVrVUCItsvNq/j5WAjuYB+T5SqHXCIuGGH64aGXshQmUUY5MvXjzz/xvVQFeGD73A061cxVpLELpwJvMDxsPOg9z0PVDY9P1hwwHcoDWw+cn0pzFU66EhMu93iFkJ1oRvQEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879045; c=relaxed/simple;
	bh=DJw6jRM4DE5wPpm4i3UZzPi1UKkoFFTnrgHqtsxJffA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nklbGpmSjSEEc93yJrU4FNXJuyr/4n3hwwchwvX2OjV9OTzAlSlINc2J52cNRwUQFy2HxbZQWRCPpv33ioE57oCvwMKVBHeOOf7fXuO4QjRPbKv5HGkGMWfS2qAfGdptIztxY/emncCjZxWh+ViVoFQ+i0w28gqGfL9cTFdPEB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/FnBGRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10144C4CEEF;
	Thu,  6 Feb 2025 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879044;
	bh=DJw6jRM4DE5wPpm4i3UZzPi1UKkoFFTnrgHqtsxJffA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/FnBGRVM12xYxiyHw7ACjWFb1h2oWM78CPp0uN8k4TDn9f66X9xOJhCr60ijypzO
	 YEMlbbsoppasQqyPg5x45367A+e0o3+m9vJHqJQwQ23r9+9obs4bqqvLK6LAOo7CWa
	 WdxYq4IQj5CyzqaGq1uJBDAxf3+mKy26t+Ae5jqlXGcbgt+YpKfFeb1rQZ8hziy5nO
	 qxJhK9sgBGtd7V5xYaJllReIg7Jbds0ThmFkEhzdHbcjhkr/n0KPAoLYPIjhYsaivC
	 Hc4297UNnJaF8gH+FDxTLQ2l4lsS95pvOQOkAs61s4hNGHZTTmAddbj8lxLyWjuj5f
	 0vkUEDpFQLRKg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 08/14] cpufreq/amd-pstate: Cache CPPC request in shared mem case too
Date: Thu,  6 Feb 2025 15:56:53 -0600
Message-ID: <20250206215659.3350066-9-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206215659.3350066-1-superm1@kernel.org>
References: <20250206215659.3350066-1-superm1@kernel.org>
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cd96443fc117f..2aa3d5be2efe5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -502,6 +502,8 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
 			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
 {
 	struct cppc_perf_ctrls perf_ctrls;
+	u64 value, prev;
+	int ret;
 
 	if (cppc_state == AMD_PSTATE_ACTIVE) {
 		int ret = shmem_set_epp(cpudata, epp);
@@ -510,11 +512,29 @@ static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
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


