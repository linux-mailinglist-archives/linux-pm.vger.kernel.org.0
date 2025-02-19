Return-Path: <linux-pm+bounces-22493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7279A3CAC2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38261891C26
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1C255E3D;
	Wed, 19 Feb 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+MRw/7j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502125333D;
	Wed, 19 Feb 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998999; cv=none; b=qinwWyEWPoTh7kq7TGPsoN+43g0KSoXybeqe64Y3p9shSQEeO+ci54x//DFHOy2mdFpqsuQN1xy0kBMaAc8oL/0VGnnJwb0TaltPp5lYQIZAbw7x3zgHK0qLjKMGpYvPfcMnY+frtV0dK1wH1+/a2t145exc7k1WTKFLEWH5yLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998999; c=relaxed/simple;
	bh=ilgT06MbsflIrYv98uNq0UmK/spWCJ7P07rxxC/sXTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqDKcJ0y76rQZ/mEtd/8uveVFk6J5F1OET8u3lP/JBA2R0lcSUzCsXfwxYH5wQad0mQzJ+Hc93Nm+HREsZq+qir8ud2nLqjo1mNqOO6oM/L0sjrDh2nZhq8tk6jyAeDYW2LzAC5M/d1O7V+jUAMbmSafBtluOe+2ouBYKnrHLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+MRw/7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D13C4CEDD;
	Wed, 19 Feb 2025 21:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739998999;
	bh=ilgT06MbsflIrYv98uNq0UmK/spWCJ7P07rxxC/sXTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+MRw/7jvj0dKJpdYzTCMVGhqodcZpPcwKgG5xcA+qYzAN4Y75x1T/bP6OGEBMFzg
	 LppHhwkMZ8smVKqZKfFD2FPzi/X4Dzo9yIWeOeiE6T+Yk/odAng0dvXQb5D7d/HfBq
	 Y8swx+tcGzwLhNgzaH/N7Xee1fCSBwrZb4EsB1HbohkXUWYV7g+swz0wQFaJHQsGNo
	 AsW07koPg+Miprk5gV0FwTN1PLpAgdJAfyRqcriwTNVKaYgjcB+D8NH1g+jrQM6bUE
	 f7bWX3KiCVzRTT3RQzF6iv1QfqlGKxJ7HB22TKtLcJFZFszc3b4vqx19Si7PSEVeB5
	 O9dMNi2KxQtng==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v4 02/19] cpufreq/amd-pstate: Show a warning when a CPU fails to setup
Date: Wed, 19 Feb 2025 15:02:45 -0600
Message-ID: <20250219210302.442954-3-superm1@kernel.org>
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

I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
populated.  This is an unexpected behavior that is most likely a
BIOS bug. In the event it happens I'd like users to report bugs
to properly root cause and get this fixed.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
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


