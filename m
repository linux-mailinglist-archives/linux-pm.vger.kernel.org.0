Return-Path: <linux-pm+bounces-31803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7611BB19804
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E799D7A1C0E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8215A8;
	Mon,  4 Aug 2025 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHw2Ff1Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC1A48;
	Mon,  4 Aug 2025 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267526; cv=none; b=dT55RFpHNQhdxv/tYhTyQptSQflyXiv82nnkkX5NNKEx8yD6ppOLBfLxMGvjwPBZ4zg0pNgLAu55xtCo/yazpbyHBphDi0OOVMKdnhchczDaBRN7W2ffPGK8yKGcIh4xUALeheOTQQsooYFmtFx8zoujES7qzsl52OJM4xYKfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267526; c=relaxed/simple;
	bh=pPsgNha4PxxDKJ35GHfl2Hr7DLGnJC5Y/rY9qsjfjWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twITNSgvu6fFX3HbY2o+Gpyl3MBa29vSAW9Wy2HQ7peaj/hT0L3HnMTfOIzsjXQTLLheeP+fSnNj0jNUpPkYUyW6svQKxUU5YsjN/40pjUUV3y5U+/pcIzzHTuTghx6grcuW6bT6pIU2lR6DgJOTkj4XTUk8mCc7A7f9C0nGWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHw2Ff1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64B0C4CEF0;
	Mon,  4 Aug 2025 00:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267526;
	bh=pPsgNha4PxxDKJ35GHfl2Hr7DLGnJC5Y/rY9qsjfjWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHw2Ff1ZQsCJdvHMl24oV7lOPBFm5uRYPAug/PjswGL72vb1zyfvEyax8LO16iE5b
	 iRrZ7uC3p4o49ipTOkbFvquB8iLmkeQhsuImRqGd/Um/hWcYYWdm1rIIXsmnhWUFxQ
	 TM6+tT5Vfl9d4WoAWT5imWyFTy07KpSAcIIFELrlEpShLS1QS698J1EBgQGDPH8oFF
	 RaB3eqGBMQjUPR8KYN0Mhx7COMH6IEy61m0HlsUFRqL0VWmrH/QoDqXbVWPjI3GtLd
	 RigqDipHTztzaqJmh5P2DDMFvKmE0wifUs2cTxJn9LifgJ/SiEg1oCHHlAjRZFn5B1
	 7ikHahKwtlduw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 17/69] cpufreq: Exit governor when failed to start old governor
Date: Sun,  3 Aug 2025 20:30:27 -0400
Message-Id: <20250804003119.3620476-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003119.3620476-1-sashal@kernel.org>
References: <20250804003119.3620476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.41
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
index 1f52bced4c29..79b303679880 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2723,10 +2723,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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


