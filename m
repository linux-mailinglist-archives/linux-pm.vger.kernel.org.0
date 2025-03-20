Return-Path: <linux-pm+bounces-24352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11A4A6B00C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 22:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598043A6BBD
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 21:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A4221733;
	Thu, 20 Mar 2025 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjbeDUmn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BA2063E3;
	Thu, 20 Mar 2025 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506899; cv=none; b=QokUkrvEjIalYTv91woQcV44fA73KDEUmr8phhmrbTQJ10daFK3YIwkTyMqwry3DZEmjXVhPnKXaPjOSnX/syQ7VzouXIIFVMwtV9kXUSwQ67bQdkaasMMlEn7I4J+PfwSZhFZKcyhs8MN/WnyGT0ACWthvZhnrUsVI9a0JK79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506899; c=relaxed/simple;
	bh=D9ofxX9hLAGxyPLjcoNLaXDp4j8xu69Ftxd064PeBvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/EGfVPhqgHHS125BDzkQTo9QX41NFbFmU3uX4eYheiocLyS0k9tGt3AIIzcimDmNVGvMokwU4l7FSf5IYBn8EsXVZXB20H1ABhXEJtlhh7DAL2H0+atMVN5APoZ3c13mHkpyfOAqQhqEMmWCmrwe5WhHtg5mnJnjct24bkl2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjbeDUmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD114C4CEDD;
	Thu, 20 Mar 2025 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506899;
	bh=D9ofxX9hLAGxyPLjcoNLaXDp4j8xu69Ftxd064PeBvg=;
	h=From:To:Cc:Subject:Date:From;
	b=QjbeDUmnRVnMbVKWSJ+93pxy+U2rNdJdc7NYyJS7WaRF+5AUah+e1KW0/3cT10gIP
	 DtFh5epqIYbm9BmY4o7Q+gTk9hK+9ZlC9EH4VviFiMkGxVFBypg1IL2oYObA00O3B8
	 ALWDkk0Vx3pf0Z8WrXWJ4KONvZESF4gvBqxOwJJZTrHu4wjazpjhsGfrlrjjfwBgKC
	 VMg6rn6KEm5NvqXnu2Xo979tK+4ds4BRVq/FQ+sKRAtcoBsRTgPvDg3IylcvSca7DZ
	 ZQyFXm+xcjifkWP8RVr0J1u6LiAIYsq8jKfyOpQM1sMo1FrIgL9zyYAwfZIFVH4wzn
	 ITvLXUeSwktLw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] cpufreq/amd-pstate: Prefix setup messages with FW_BUG
Date: Thu, 20 Mar 2025 16:41:32 -0500
Message-ID: <20250320214132.664522-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

To make it clearer that amd-pstate failing to setup is a problem
with the firmware, prefix several messages with FW_BUG.

Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 024d33d5e3670..0a9d6fe426d1c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -931,13 +931,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	 * Check _CPC in ACPI table objects if any values are incorrect
 	 */
 	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
-		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
+		pr_err(FW_BUG "min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
 			min_freq, max_freq, nominal_freq);
 		return -EINVAL;
 	}
 
 	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
-		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
+		pr_err(FW_BUG "lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
 			lowest_nonlinear_freq, min_freq, nominal_freq);
 		return -EINVAL;
 	}
@@ -1505,7 +1505,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 
 free_cpudata1:
-	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
+	pr_warn(FW_BUG "Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
 	return ret;
 }
-- 
2.43.0


