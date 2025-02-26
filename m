Return-Path: <linux-pm+bounces-22964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDABA4571B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1789C1897BA8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E91624EA;
	Wed, 26 Feb 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxlAEZgx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CE27426A;
	Wed, 26 Feb 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556197; cv=none; b=rL9CGME85apqfLsgGXXxrVS5+x0FvK3eggkGURcXZue6IPzJ4boi+DOm7DONc014QQTwxXm5JKZm8/Bv+iKsFOC7Vi0b0eRH/JdZGbrXIbscu7A8I7UmmrcSu4ubCXtijguY1TEOJEMu83R/S5FMeY54Vzny4mh811QnXdGV9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556197; c=relaxed/simple;
	bh=Ny+mf6wTXBWd26jscZCcfKEiG9iktam74gC2s8tYJNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeTYu+52ITzvtwkTnp3y6ykzrGmPb6LSp4+4WMMTktKDFc1dXeGkBAI5UFtnUoGY335/5CDENmNUfhcBF1GwCR6keTBYxGGS0Hlr+USRKhm7zUsQJcyiHcnOsfFic7XSJickTEfIdzKSs/NTlm7198Sp7cGfYVNcwaGqBsI3gmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxlAEZgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38273C4CED6;
	Wed, 26 Feb 2025 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556197;
	bh=Ny+mf6wTXBWd26jscZCcfKEiG9iktam74gC2s8tYJNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxlAEZgxQ0J0A5gI3SDhoy/+gtYrZK85pRYTbN6XAOsD+lwRoaVNBnxSHhCTG3/CM
	 ym9Q5zD1uaVro05T+/pqd0kliEmyNdVsvr8fp63S7ZhiW61EIlOD8+7XLZSMCkXD8/
	 42FD0Sw7pGkeg4mPxJWouN+pMmAoawTtPnP4usQezZlSGMglD2zQVfS4NCpI+oBkh4
	 jQy7XzJu5fJEtKfQfqKltR+VP8O3OmCdVrn3ME/MNMJm22j9pladiPJ0RwC9zO0vQX
	 1v5BqI3tB9JxNbzzxr5jpSGtQbZXnMB0BQyLStiUsUcfm6D5mN1F26PNjhUqfNU1h+
	 uj67B79Frk9JQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 11/19] cpufreq/amd-pstate-ut: Adjust variable scope
Date: Wed, 26 Feb 2025 01:49:26 -0600
Message-ID: <20250226074934.1667721-12-superm1@kernel.org>
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

In amd_pstate_ut_check_freq() and amd_pstate_ut_check_perf() the cpudata
variable is only needed in the scope of the for loop. Move it there.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Apply to amd_pstate_ut_check_perf() too
 * Add tag
---
 drivers/cpufreq/amd-pstate-ut.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 2ab3017d7a0bb..edc1475989e3d 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -113,11 +113,11 @@ static int amd_pstate_ut_check_perf(u32 index)
 	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
 	u64 cap1 = 0;
 	struct cppc_perf_caps cppc_perf;
-	struct amd_cpudata *cpudata = NULL;
 	union perf_cached cur_perf;
 
 	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+		struct amd_cpudata *cpudata;
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
@@ -186,10 +186,10 @@ static int amd_pstate_ut_check_perf(u32 index)
 static int amd_pstate_ut_check_freq(u32 index)
 {
 	int cpu = 0;
-	struct amd_cpudata *cpudata = NULL;
 
 	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+		struct amd_cpudata *cpudata;
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
-- 
2.43.0


