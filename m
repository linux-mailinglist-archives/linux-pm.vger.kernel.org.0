Return-Path: <linux-pm+bounces-22968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC4A45723
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93683AA0AC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD4281343;
	Wed, 26 Feb 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gct4VRQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFB280A5F;
	Wed, 26 Feb 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556203; cv=none; b=uuPZCiZjBDwTihnmqlab9sYM3Asgoo6xitRneV9eQYPxDZrgIZLuD/9YZZSh1z1vawGx66fzSZ/b8LNzCavT5bMmWlGiy9tbD4ZEOouNT4gEz8I4saky3QNAr0/MHgSXS5iTITQv1lqJP9zGYTYFkrDObkB+Z9w2sHWqf5wOK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556203; c=relaxed/simple;
	bh=lvNlhg8ZQGFHcYmuoWOZ6HwRqxeR0QKm+GESmZ3ZXpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ht1ZcoVwjPOKC2ZP6Rj5dRCszaOAI2zfY7FGRUnNACVurD9a6KInLgzFnyLRnp8Eavj/hfG4GbG/PQJFDBYdzjaP6Hj8iL5gQ6CLPybazQXYD7dRjoAkpWvINVScSE5WDq/EqdYu1r9WwZYHagtT0G7x0h24zbKTDtslwYsQ5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gct4VRQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DB4C4CED6;
	Wed, 26 Feb 2025 07:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556202;
	bh=lvNlhg8ZQGFHcYmuoWOZ6HwRqxeR0QKm+GESmZ3ZXpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gct4VRQvPVCltKkLmjYChOt093JLrbochGFkCh20Lb4YkcGUu5vgbwwZQKpRvukkF
	 ok11NPnD8CdWu2Ae/ap4blzlRRP3Zz5UoHAiahGk7Ki6YH7e5yNtl3wMy31IZMqNc7
	 nzS9QbPcQInT0q+sTdF5rYw63GeCp2iFx9ay//7Ox36kYq/PyRaWgki3GJav6LxS4Y
	 JUTATrB9pi+bqsGBi8znpd4K1vEFZ3mZ50t/E/4JaMTKkNkrS+HdzYVsx97LAnF7FD
	 KrKpHsyFG95Duz87YT7kIYLad2oqkr8yAAWzirMinABPUmdU1JY6wkgesPj/eBKgW7
	 k5JGwX6Eh9PNg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 15/19] cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
Date: Wed, 26 Feb 2025 01:49:30 -0600
Message-ID: <20250226074934.1667721-16-superm1@kernel.org>
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

On EPP only writes update the cached variable so that the min/max
performance controls don't need to be updated again.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 66b61ce124e21..55b6231e6a092 100644
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


