Return-Path: <linux-pm+bounces-27920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E174ACA49D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 02:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B352C1885D83
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 00:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A010929A9DE;
	Sun,  1 Jun 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaEw7Jcz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E376299AAC;
	Sun,  1 Jun 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820831; cv=none; b=P5XENqoemIiP2eUaEDsNLQ916zIa77owBGVD4AjaJymZyeR0iQ6UMTM+P0q9CnVLNsHvHXcFvJpYNesODofmrtq3Biu7xwcJ9nyLi3AI8oTmkhlZgYRDAPVime9A92YkMFRnDcxh7LbU0JR4ZO80gjzz8GFBkfe2Pnf8wyxpQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820831; c=relaxed/simple;
	bh=C/YTaGm6mtkWnxS8DPl1/hbQyDkSrdLPkjsHiWcMnfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAszezn6+uGSxa9uinBOTVDlbAV0a24uJd0PNqGpfDivDVvW/PMc9utOGhKxj/ZNkb9UPcuz7mstgpIW/jYMI4JbTmdxNS99Yjt4BZvzeZYTEo7X+hp7Fr2rAxAI9YQxsUJIFJ1B1zBoqr0ZWiE3/H9CWSrVVPJMaHpXG+7Gdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaEw7Jcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3EFC4CEF1;
	Sun,  1 Jun 2025 23:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820831;
	bh=C/YTaGm6mtkWnxS8DPl1/hbQyDkSrdLPkjsHiWcMnfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaEw7Jczs/EFrtdPJVtMS4mxmLLOdIbps5/Jpx6rIYD6vx2oVU1ik4RHTsfgbJHQP
	 KqN4FN6Zm5KjTSiQC8JjJT3htkUW0ZI2XGKkDNCJM5+IU1Srf/ODANudrLdZaT/sFF
	 8Jb1RN/tTfvb3W0TEyuDR7sZ2lmCXHw1GutjARMNP+nejE39/YcONy7BZJkVhQrWen
	 iAVn36WL590eNOeDB81xnwSQrS3fgrF0LOaHA8BHY0MssoOB4GGfIKvDLQsR0O/JBS
	 fO9vcIqoFpG27wOvb5h4VjpWi/Kv6iWwKdm4HtTQndhzyXu67CMAitF5MAAvdGMUbd
	 ftZgVAXhpfM7Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Dhruva Gole <d-gole@ti.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 098/102] pmdomain: core: Reset genpd->states to avoid freeing invalid data
Date: Sun,  1 Jun 2025 19:29:30 -0400
Message-Id: <20250601232937.3510379-98-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 99012014c902cd9ad85fd288d8a107f33a69855e ]

If genpd_alloc_data() allocates data for the default power-states for the
genpd, let's make sure to also reset the pointer in the error path. This
makes sure a genpd provider driver doesn't end up trying to free the data
again, but using an invalid pointer.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Link: https://lore.kernel.org/r/20250402120613.1116711-1-ulf.hansson@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Now I can see that the commit "99012014c9 pmdomain: core: Reset
genpd->states to avoid freeing invalid data" is already in the kernel.
Let me analyze the backport suitability based on the code changes and
the similar commits provided. **YES** This commit should be backported
to stable kernel trees based on the following analysis: ## Backport
Justification: ### 1. **Critical Bug Fix with Security Implications**
The commit fixes a use-after-free/double-free vulnerability in the power
domain management core. This is exactly the type of critical bug that
stable trees are designed to address. The bug manifests when: - A genpd
provider driver calls `pm_genpd_init()` - `genpd_alloc_data()`
successfully allocates default power states but then fails later (e.g.,
in `ida_alloc()`) - The error path leaves `genpd->states` pointing to
freed memory - Subsequent cleanup by provider drivers can cause
`kfree()` to be called on invalid memory ### 2. **Small, Contained Fix**
The code change is minimal and surgical: ```c - if (genpd->free_states
== genpd_free_default_power_state) + if (genpd->free_states ==
genpd_free_default_power_state) { kfree(genpd->states); + genpd->states
= NULL; + } ``` This adds only 2 lines of code to reset a pointer to
NULL, which has minimal risk of introducing regressions. ### 3.
**Comparison with Historical Similar Commits** Looking at the provided
similar commits: - **Similar Commit #1** (Status: YES): "Fix error path
in pm_genpd_init() when ida alloc fails" - Also fixes error handling in
genpd initialization, similar scope and impact - **Similar Commit #4**
(Status: YES): "Add missing put_device()" - Also fixes resource cleanup
in genpd, small contained fix with `Cc: stable@vger.kernel.org` Both of
these accepted backports deal with similar error handling issues in the
same subsystem, supporting the case for this commit. ### 4. **Critical
Subsystem Impact** The power domain management subsystem is fundamental
to kernel operation, especially on embedded systems and SoCs. A use-
after-free bug in this core infrastructure could: - Cause kernel panics
during device initialization failures - Lead to memory corruption that's
difficult to debug - Affect system stability during error recovery
scenarios ### 5. **Clear Bug Pattern** The commit follows the
established pattern of good backport candidates: - Fixes a clear,
reproducible bug (invalid pointer access) - Has minimal code changes
with clear intent - Addresses memory management correctness - Authored
by the subsystem maintainer (Ulf Hansson) - Includes a detailed commit
message explaining the fix ### 6. **Error Path Robustness** This fix
improves the robustness of error handling, which is crucial for stable
kernel operation. When hardware initialization fails or memory
allocation fails, the kernel must handle these conditions gracefully
without corrupting memory or crashing. ### 7. **No Architectural
Changes** Unlike Similar Commits #2, #3, and #5 (marked NO), this commit
doesn't introduce new features, architectural changes, or performance
optimizations. It purely fixes a correctness issue in existing error
handling logic. The commit represents exactly the type of important bug
fix that stable trees should include: small, contained, addresses a real
correctness issue, minimal regression risk, and affects a critical
kernel subsystem.

 drivers/pmdomain/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 949445e929731..951071e1093ac 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2194,8 +2194,10 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 	return 0;
 put:
 	put_device(&genpd->dev);
-	if (genpd->free_states == genpd_free_default_power_state)
+	if (genpd->free_states == genpd_free_default_power_state) {
 		kfree(genpd->states);
+		genpd->states = NULL;
+	}
 free:
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
-- 
2.39.5


