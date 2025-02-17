Return-Path: <linux-pm+bounces-22278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768C4A38ECC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CF818941F2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B31DE887;
	Mon, 17 Feb 2025 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD/dEuMu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0B1DE4F6;
	Mon, 17 Feb 2025 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830067; cv=none; b=XJISSWc2PsUJfUnXy3UJ41Gjs9FwLVKpOi67k5UoVRxkp2zXwpUUDegRU5/CXq7w//6FQI4JWWisUtR2zu/07f+Q28LjbeeHsh2gPmgn8nYEsoDOKpsTxQTeA6NHlygcpAYi3FTwa7eIbo9AWngpxk1NG1LBii53QijjXSzHPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830067; c=relaxed/simple;
	bh=la8u9QF1Jfg+PUuHvqM9VlVDImBp13gGudt2jl5/rKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhJ8fscwcP3760CoLSJfAfc6p5LX/VBh/Toy+pk/KznHAyID0D+h/ZOuLNGW3hg/rBbAB8834bJlaVA8rfsWPim1v9kd8pES4ed9qIhJGrfODpGDY28zi1ZNkwIplkuLXtQ3V6IQWKeHZPj6EWqOahCBIJXt2GniBc5r+I5GCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD/dEuMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EEDC4CEE2;
	Mon, 17 Feb 2025 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830066;
	bh=la8u9QF1Jfg+PUuHvqM9VlVDImBp13gGudt2jl5/rKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XD/dEuMuv9bPa08ZojCmP5BNd/3PXE73NlA0EbJayg8TSZb+b9cQFlZAsLncOEl1s
	 Ci38kGamBqR7eBMEEHtIMOa7elQtf3EZXK9GTLj2R2GVQX1RJPvmf0wGh0k7t8J98C
	 nCRaY0yyEgB+TjEBpHhHOBtwAf5Hs0zYTckZKEcXyrpeyRUBctOBgtzTpCpJJUP17/
	 0FA5ro1ua46k/oOnsJ2M+R+z4/h5o/kUWmZKPHOdp30qcwQYO1/QfzQ0vWn2dxIyIN
	 kHvESrsGHfpwX+fr0ef7Jl1kq+Ijgwr4H9Wkp5poL666ct6T0hc9wnlQXfTFdW2rsY
	 jtyY6tqaxb4dA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 13/18] cpufreq/amd-pstate: Cache CPPC request in shared mem case too
Date: Mon, 17 Feb 2025 16:07:02 -0600
Message-ID: <20250217220707.1468365-14-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217220707.1468365-1-superm1@kernel.org>
References: <20250217220707.1468365-1-superm1@kernel.org>
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
index 2c8f6e92ec8a8..4eb3ba6dfdbd9 100644
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


