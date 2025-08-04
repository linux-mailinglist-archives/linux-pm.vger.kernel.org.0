Return-Path: <linux-pm+bounces-31838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C9B19986
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6751898831
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9A1FE47C;
	Mon,  4 Aug 2025 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3DFI8wk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4981519A0;
	Mon,  4 Aug 2025 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268166; cv=none; b=ZPV+t1eGo1nivZK8i9RLLah4kdhoryxzLV4qkqN3MBeK9Gve6aqw/D8IbpkV56GhX6Yjoj5v9+Sk3VQijipQ+btIEsnRax1/wMApmxIAHuSoTjXfxOdZWIBCf3LLB0OWkSr6Z7UF4fUJsofXR3iy17tczt4uHR74ri9XD0wuSEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268166; c=relaxed/simple;
	bh=dljcmrZyQ6cYAqyndDCAPMnqOk7KaindJMW7AjvhsCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRKxjN5+Ym8TZQQbeWfn7c565t5M64W/VtFDd1MhA9gIn/eWJNjDa+sJmLJPLpNvr/AbvbrDuXiEPVHfcGi6G9hKlfzZ/Ulss4nU1FmvM+c0XPwPDK6oovBaFPKzOg3r/mJtZxWNi3fNm4WmxgVCujbQgjNFHkwndaJ5BZ02F1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3DFI8wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AB6C4CEF0;
	Mon,  4 Aug 2025 00:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268166;
	bh=dljcmrZyQ6cYAqyndDCAPMnqOk7KaindJMW7AjvhsCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3DFI8wkLpAN9t0hhcLOtM0LtvjY1C3idybm1mkVBBmMtwssCN94M4tYEky3Ti5mO
	 zBk2bj+1STZhVbpmxToYT5ic0QPRoOPM+b+LyAfFJ7LBLqA/e6h5QR05uEG6FOKnAV
	 XA0AB4CKKwb17oSl1IqR4Ewa45d6/u7M4T8ZpA8PKxbSjy27n3vwWaPzmbAg7cpsU6
	 7tFB7TtmZ6wQOtB49mzaRj1V/fKGMbgdWswzQSyKKYO8aKHcj9vPM6EFeSI6Td+hGi
	 g5tQc474EzbcSqpRJrFbWRvvyfEiqg8q1slxF0AkWVxmj3jgI/X0ncdtAvw5sWvZdT
	 62wmWkhzg24bw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/28] cpufreq: Exit governor when failed to start old governor
Date: Sun,  3 Aug 2025 20:42:07 -0400
Message-Id: <20250804004227.3630243-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004227.3630243-1-sashal@kernel.org>
References: <20250804004227.3630243-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.296
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
index 2a2fea6743aa..0bb17bb615f5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2482,10 +2482,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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


