Return-Path: <linux-pm+bounces-22133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C63A36A43
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20C817084A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B322F19F436;
	Sat, 15 Feb 2025 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRCi7WLv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5119F11F;
	Sat, 15 Feb 2025 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580788; cv=none; b=LtQ1X9qe57Ut6AKFE89R0XwKQT5luha7USecBONYIwveWc3ma90/jPbWKUdcklaye5ytmt2FJKrTF3O60/tMHcapdx2qxXvLEtYV3yS47tXp8GhSjNRHdgSVa6hjMALD+jdtS5MQdztWcCMUkM1k6FFcnVakoLJSigczTyFl0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580788; c=relaxed/simple;
	bh=G9aX4hbjlwlSg0cVYqlxtbkbvYF1gi6gR+L6p8BbTLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdjfh4tdtTGmTfm4Jv5APbnvlunFIDelzGOI0LQPCliaTsDoe1uzWPy+NYHFcz2sBVkIt5H9fYB66vtDUfhV4LGv1xGrf0MizCJFknjFUc/6LB5kOeHuWR0rhcJgoTGpVs4pGIN5J1FAApMVDPMkFPOM/bAIkxMIvXEyV4iFJT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRCi7WLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB97C4CED1;
	Sat, 15 Feb 2025 00:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580788;
	bh=G9aX4hbjlwlSg0cVYqlxtbkbvYF1gi6gR+L6p8BbTLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRCi7WLvR4r4N/YRTtVWuawNYKU/IsiM5vQyknbHmiL0EvR62SN3RID8WGa0g6Aod
	 3ADUU7/PnhaFtBYng1A8YU82RBDNziGj733fEJ6ZuLtVacC8F6n9LuyhHjhFuZ0KcO
	 hVvcb5enmAZsjkJTz8J6D1zzOsslxoFsJR6u0bT7hLSzJioxwQ6BBeC5rTArG1l34d
	 0vFV+SXiWvQXmekZkrJIfeGOXEZVolauC63uva5/65+hv8z51c8Dz3HyQQhOHtY+hn
	 39GRDT1lRGYKjH0F3ocLddEavVHkwEtLWlUfGOvlp1Ye3QQ+/ew7JodDiJTNVprWqj
	 VRSimhthVAoPA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 12/17] cpufreq/amd-pstate: Cache CPPC request in shared mem case too
Date: Fri, 14 Feb 2025 18:52:39 -0600
Message-ID: <20250215005244.1212285-13-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005244.1212285-1-superm1@kernel.org>
References: <20250215005244.1212285-1-superm1@kernel.org>
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0a7e69fd32dbf..9517da9b7e692 100644
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


