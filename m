Return-Path: <linux-pm+bounces-22135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A96A36A34
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D297A3EF1
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10B31A2643;
	Sat, 15 Feb 2025 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB7CZoJB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787384D02;
	Sat, 15 Feb 2025 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580790; cv=none; b=Ee/88nLM/cO9fpOpvTIJw3dAY4p7fMS1jYy3aNj5j+0s6+0lj4watqQmxqWDXLNqEry+Lvh8lmFhbB8OuE++Jsi5HacgEnmP3H34Lt23B1aJgjSP5/6s49QZD8gA2QPdxxgN2SFT5NY/Wi8OOJeJUHahbjUocAgKnonrddgpN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580790; c=relaxed/simple;
	bh=n1llojOtze1HUUs++vYrMmPS+J3E3Jr9jv6wTQOk5vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7efDeK+9Gje/7uROorsbHqiEYguNng9RDxD5zB8Y4NrLk6/c12S+mZIsN13UjXxonN4uuAZyqDzdkDoHffn861WeMCXb9qBeueF7gtJuosXI7r2HUG54qir0udxVQCpKPZ5Icb7GTLO/BePBTX4kbWKAd6uT0qCMYRgZ9XytN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PB7CZoJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D5CC4CED1;
	Sat, 15 Feb 2025 00:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580790;
	bh=n1llojOtze1HUUs++vYrMmPS+J3E3Jr9jv6wTQOk5vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PB7CZoJB8pfpiF/0Fq5ASCumQTxlPUCnWJVHZGf3C1BiaD7T6nvunihPiwkSS4+mr
	 kMx0dCf0f6jL/gN+WB088K1LIGs/1aW8GKY9Ui2XC6LI/EMdlFJ1EVkmFx+e0ixK1O
	 foVsxLKGa9Mbxlx5eVkLBIiPIDqm9xSJ6goa/Q9WCZwfx6Ng7EPUjT81Py8ih3kaj5
	 nlFtKwbc/UkPZUz2Y3oyMqMWYet+cxwdJ6mfbMLEeDysA29It9FJ1cSmcg2asjk1OV
	 chBOLxGJlImWRbrDA+oZbwilBYpfp/YPlsGO9JQ4A1uVyzPHo1oYv3UZnnmA2h8v4p
	 uX+RaWllIRpqQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 14/17] cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
Date: Fri, 14 Feb 2025 18:52:41 -0600
Message-ID: <20250215005244.1212285-15-superm1@kernel.org>
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

On EPP only writes update the cached variable so that the min/max
performance controls don't need to be updated again.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1304bdc23e809..fd2b559f47c5c 100644
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


