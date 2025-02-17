Return-Path: <linux-pm+bounces-22267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2BBA38EB0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405131887252
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E91ACEB0;
	Mon, 17 Feb 2025 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZbkFdBq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03E1AC43A;
	Mon, 17 Feb 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830057; cv=none; b=bZPr/27S6UsVYIG8PJ7tUjnBiSr+6za5Nrc1C7wOovbQo399sN8MUND6uU8unJrtlNuW6vV3VhJ+/o3Sa3O3w7nPZV22j3Uv7MQcqU/5MPO6y9UYFdRTCxSNfH/NAddXLFbBVTV606geX3/yRKabWFX1UPJl0NvYjZeRFJvmxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830057; c=relaxed/simple;
	bh=KIAWwlvgtB3R8MAUcew3Zv+qzjK3vwp7je4vfaGTHkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNdHncoIr/AGhjwFqQqQuOi55920RNhCKd2GAdAYE2M23nPnhglhGS9lE4ZGgAB5V0X2h4fyU/W1deE5eAoeLLo3HY4h6YNa2DLX6SEXt8U7CSjXJhfQLq02gIuffgYqlVbF+wWXSOujnHLjs4YNmKSE2AQ53vVcS9IV1CNJMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZbkFdBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04FFC4CEE2;
	Mon, 17 Feb 2025 22:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830056;
	bh=KIAWwlvgtB3R8MAUcew3Zv+qzjK3vwp7je4vfaGTHkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZbkFdBqB5Pw6f9B63UidtEmRP0J5jwg6LjDVa9aYuuVbEnOeaaBEvsnYvfpbOIgC
	 fMjuAhCak/Aso4rNtS3FBqiwmpmjoBWT9UrUER8PRosaTmJP5HxnA32l1PU1PdhC81
	 HlAtavdGliDf1F9sXx/QOA7yNCZOHjIuJ4hE7HN7VpDnD8RQKIjHV1OxM42n5rxwIi
	 5/l1/NNLgcGzfLR5sD4qqUx5Smn+kw9NjYh/0w14V8RGg2K4t2n2/x1Bv5TOZcwjEf
	 agmdU2KZUjzESFqFLXUQ5XPmKtFSf88okq4+ouncKCkLUv1I3aAnUpU8Q3dJl9eNKg
	 xFH9iU86hJLCg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 02/18] cpufreq/amd-pstate: Show a warning when a CPU fails to setup
Date: Mon, 17 Feb 2025 16:06:51 -0600
Message-ID: <20250217220707.1468365-3-superm1@kernel.org>
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

I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
populated.  This is an unexpected behavior that is most likely a
BIOS bug. In the event it happens I'd like users to report bugs
to properly root cause and get this fixed.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 12fb63169a24c..87c605348a3dc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1034,6 +1034,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 free_cpudata2:
 	freq_qos_remove_request(&cpudata->req[0]);
 free_cpudata1:
+	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
 	return ret;
 }
@@ -1527,6 +1528,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 
 free_cpudata1:
+	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
 	return ret;
 }
-- 
2.43.0


