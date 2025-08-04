Return-Path: <linux-pm+bounces-31825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D3CB19909
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74C7189810F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDB61E0B9C;
	Mon,  4 Aug 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRSrsgG6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2A1DE4E5;
	Mon,  4 Aug 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267955; cv=none; b=Lkt5bOOxiFe1T1ZUsHCXiIvMuWns3vuSLzo8sJKv7qNYsPctYZjW0dY6fLrnyICe5ZeJMt+enOnYu4GXR+WOW28eYihUkdD9hpR/6rdm0mNp5dhDVGME63PcHsII0M3wpjuAefNtd0Ah4k9ynC6xQF1MZm6TjVHvzncy34A4Yh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267955; c=relaxed/simple;
	bh=1aaxKEB7kvQk5YOXJwPtxcVj18XuCL1eOML76XNPBCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpSSbg6Cch5vYxtUWoIucYMzshMC7XLEahD6Ey/JDtErxjsp+XXlueUX435HGAH6FPn/eOSNwUEFOE+JHdQe+cRLEqsxHUikAUXd1c+NGyISLl/5dfP8nFJuASNzf7/SIm9lI9KEFX+a1e6cWilH2HeoBfJOdNGQFjO2LnuiwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRSrsgG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23E6C4CEF8;
	Mon,  4 Aug 2025 00:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267955;
	bh=1aaxKEB7kvQk5YOXJwPtxcVj18XuCL1eOML76XNPBCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRSrsgG6hLEfa3ne9EQz5WhLL8wefSYdNKG/L2+B1AXTYI9XOXqFBPm7Tg/W1sCPX
	 M9r9WqXFm8d4yQPA8ClHxVLLtH3djJUWljT992Q9NBe+v1T22FbrkLyWjinh2jQuyJ
	 Jf9IYNDD/QTgcscAyHFXwkJ2DOzgMUIQwgggXBagEUNRDpPfiq9leRIeg3qGq3dY79
	 UHVzPBOd33s1GJ2EPrsu1BHeqEh/KhgJtNDWe73cidBUZUzJxy3a5kP35hKwLWoW5U
	 ezAjpeTj5Al46+r6bfbNXZMfZTRQxva/nf8XD6+H1Sigbr1O5wgHWNx1qA9LFWFwrE
	 rbndgxfA49Nwg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/44] cpufreq: Exit governor when failed to start old governor
Date: Sun,  3 Aug 2025 20:38:15 -0400
Message-Id: <20250804003849.3627024-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003849.3627024-1-sashal@kernel.org>
References: <20250804003849.3627024-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
Content-Transfer-Encoding: 8bit

From: Lifeng Zheng <zhenglifeng1@huawei.com>

[ Upstream commit 0ae204405095abfbc2d694ee0fbb49bcbbe55c57 ]

Detect the result of starting old governor in cpufreq_set_policy(). If it
fails, exit the governor and clear policy->governor.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Link: https://patch.msgid.link/20250709104145.2348017-5-zhenglifeng1@huawei.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Bug Analysis

The commit fixes a **resource leak and inconsistent state bug** in the
cpufreq governor switching code. Looking at the code changes in
`cpufreq_set_policy()`:

### The Bug:
In the original code (lines 2716-2721), when switching governors fails
and we need to restore the old governor:
```c
if (old_gov) {
    policy->governor = old_gov;
    if (cpufreq_init_governor(policy))
        policy->governor = NULL;
    else
        cpufreq_start_governor(policy);  // Bug: no error handling here
}
```

If `cpufreq_start_governor()` fails, the code doesn't handle the error.
This leaves the system in an **inconsistent state** where:
1. The governor is initialized (`cpufreq_init_governor` succeeded)
2. But the governor failed to start (`cpufreq_start_governor` failed)
3. The policy still points to a non-functional governor
4. Resources allocated during `cpufreq_init_governor` are **leaked**
   (module reference count, governor's init() allocations)

### The Fix:
```c
if (cpufreq_init_governor(policy)) {
    policy->governor = NULL;
} else if (cpufreq_start_governor(policy)) {
    cpufreq_exit_governor(policy);  // NEW: Clean up on failure
    policy->governor = NULL;        // NEW: Clear the governor pointer
}
```

## Why This Should Be Backported:

1. **Fixes a Real Bug**: This addresses a resource leak where
   `cpufreq_init_governor()` acquires resources (notably
   `try_module_get()` at line 2442 and potential governor->init()
   allocations) that aren't cleaned up if `cpufreq_start_governor()`
   fails.

2. **Small and Contained Fix**: The change is minimal - just 4 lines
   modified to add proper error handling. It doesn't change any APIs or
   introduce new functionality.

3. **Prevents System Instability**: Leaving the cpufreq subsystem in an
   inconsistent state (initialized but not started governor) could lead
   to:
   - Module reference count leaks
   - Memory leaks from governor init allocations
   - Potential crashes if the partially-initialized governor is accessed
     later

4. **Error Path Fix**: This is clearly an error handling path that was
   incorrectly implemented. The pattern of calling
   `cpufreq_exit_governor()` after a failed `cpufreq_start_governor()`
   is already used elsewhere in the code (line 2711).

5. **No Architectural Changes**: The fix simply adds missing cleanup
   code in an error path. It doesn't change the normal operation flow or
   introduce new features.

6. **Critical Subsystem**: The cpufreq subsystem is critical for power
   management and system stability. Bugs here can affect system
   reliability.

The commit follows the stable kernel rules perfectly - it's a clear bug
fix that prevents resource leaks and system instability, with minimal
risk of regression since it only affects an error path that was already
broken.

 drivers/cpufreq/cpufreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bbb0cbb2eb8c..4f68e34cde0b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2605,10 +2605,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	pr_debug("starting governor %s failed\n", policy->governor->name);
 	if (old_gov) {
 		policy->governor = old_gov;
-		if (cpufreq_init_governor(policy))
+		if (cpufreq_init_governor(policy)) {
 			policy->governor = NULL;
-		else
-			cpufreq_start_governor(policy);
+		} else if (cpufreq_start_governor(policy)) {
+			cpufreq_exit_governor(policy);
+			policy->governor = NULL;
+		}
 	}
 
 	return ret;
-- 
2.39.5


