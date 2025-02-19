Return-Path: <linux-pm+bounces-22506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D47A3CAE2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE197189C34F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C279325A64A;
	Wed, 19 Feb 2025 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW1o/nNZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DC2586FF;
	Wed, 19 Feb 2025 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999011; cv=none; b=KART17M8FminrgyrrInbEMjjhZ75c1rB08AbDdny87mYUoENtjF1TgkyqArgoAB9SMy/NePdyIkuy6q8qGgG5aFNT5dkK5K6thLwYln2e+MXcWbxC01ilbPg/w/9NaRU91vIcuV59ctnK0G+PZF3CrhBT2jkXTp1MXt/GVzbOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999011; c=relaxed/simple;
	bh=8MGNgWGo7RgeW78wzyjYJSurH7mhV2gZ9vlrH7ayfD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZ0MbTpJTVe0qMEWWWIpnjeMZHhRRpoDsQeMF3J9mIjBIW9rSuP3rE9hxTiyXt30CaZtEAVaYPep2SsQc/jWGbnA9NL9EUDgacQV1okjyOJXmmtrmnWIDCujnz4Ow8cjh3eznQK5+9dzJPQJja9wP3hXX+VCTrIPsRiD/+0TQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW1o/nNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62022C4CEDD;
	Wed, 19 Feb 2025 21:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999011;
	bh=8MGNgWGo7RgeW78wzyjYJSurH7mhV2gZ9vlrH7ayfD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AW1o/nNZBOtzGoSDYRvnhulqzlqGKOOb7ohz3QGuxax0kfsIh1VGuUJjzJqEed6+7
	 E2bt8vwenQtzwtrLgFF+WhGcPq41RT/Ulc//t7oaq+mcdJsI1A5PmEngLGibEtQ/kX
	 FoYEu9JAfUS+Moa3TfcizcMAgNBNFvCOhnQD1GxYqBB5TsJrA8M2DSNk0EnpZZ4Gyl
	 82uLGZFvJ4XRCM2lOnEl9cOqODbwyp1qpy66p+mOOL9cpFWRCQWkJSAT0xgpfvvoc8
	 qg5JsLRPbX77AwClczy6d1D+1/ildLAylttxgzTUBxT9sl4MpEZjqTLPbYDxcRsscy
	 ptjkKhq3UYbgA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v4 15/19] cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
Date: Wed, 19 Feb 2025 15:02:58 -0600
Message-ID: <20250219210302.442954-16-superm1@kernel.org>
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

On EPP only writes update the cached variable so that the min/max
performance controls don't need to be updated again.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index da6c39564c9ea..3c87e7cde2a4d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -336,6 +336,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
+	u64 value;
 	int ret;
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
@@ -362,6 +363,11 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 	}
 	WRITE_ONCE(cpudata->epp_cached, epp);
 
+	value = READ_ONCE(cpudata->cppc_req_cached);
+	value &= ~AMD_CPPC_EPP_PERF_MASK;
+	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
 	return ret;
 }
 
-- 
2.43.0


