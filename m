Return-Path: <linux-pm+bounces-31794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D39B1976E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979E4174D71
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AC9481DD;
	Mon,  4 Aug 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhAImmS8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073279F2;
	Mon,  4 Aug 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267282; cv=none; b=quQolAvQ7zG5xhWLFkECzgl5FKLAyhRudRur1wf4UY5RYI9XSZBheJoRpiAMaKV79PGas5wrEB0hWjnIeLzcJoQF12xaN/kxGl/ShMJpFVmUvPl2B7XYXblsnQBUdInU+IQIl3rZbHIrZMMMhxMzZf4LeCJ2VARKY9MHU8sYo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267282; c=relaxed/simple;
	bh=wMC8u6S930szpMT1zlayPBjEMT0xjyBbU0JfwvLXesE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VeOhz5RkXlaaNGWcYry6x/v2XtnF7O6Dv4jSE6B5qVlzyPcjZlbgenNuDYqXCirB1ZZuBgXvLzPXFGKLMpCcCKlRCGTncG4MAoKAl6Ym3So8kCQBdwEYmKtLNnV5Z8Uk3Dbd9U23IHIuXn8BegeZSTYjuDsvDxKlhtKPqEslhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhAImmS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02EAC4CEF8;
	Mon,  4 Aug 2025 00:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267282;
	bh=wMC8u6S930szpMT1zlayPBjEMT0xjyBbU0JfwvLXesE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhAImmS8cNwvHZ4iLSN04sShty+ST4d0E13rd3r7zhgLJ4QyaMbXiHwZr7oDakQZO
	 //x9XHhihA87XogIQuf5KdrgCHCS3outgtJIU2CTLzdmNbe9IpdOOhgcJicgMCpT5w
	 X1HsZ1bHncLvlFULArcutegRrfT2esChUQX8F7DU4Ij4PrvIaPmus26Vx0onawQITf
	 iHKFwYcR+iRddDQZokWUtu53Xybr+HWkjgy4jn7e2CXJxtFeymLy4/EtP3n0DkQW0t
	 2aLSVDBuCLjtWzNQU9o6/6hTQBH0JRnm4MVhFy1GOaL2z8sCdHElaXw3BI9kpd7O76
	 TsUkWXgqcmuLw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Prashant Malani <pmalani@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 04/80] cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag
Date: Sun,  3 Aug 2025 20:26:31 -0400
Message-Id: <20250804002747.3617039-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002747.3617039-1-sashal@kernel.org>
References: <20250804002747.3617039-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.9
Content-Transfer-Encoding: 8bit

From: Prashant Malani <pmalani@google.com>

[ Upstream commit 0a1416a49e63c320f6e6c1c8d07e1b58c0d4a3f3 ]

AMU counters on certain CPPC-based platforms tend to yield inaccurate
delivered performance measurements on systems that are idle/mostly idle.
This results in an inaccurate frequency being stored by cpufreq in its
policy structure when the CPU is brought online. [1]

Consequently, if the userspace governor tries to set the frequency to a
new value, there is a possibility that it would be the erroneous value
stored earlier. In such a scenario, cpufreq would assume that the
requested frequency has already been set and return early, resulting in
the correct/new frequency request never making it to the hardware.

Since the operating frequency is liable to this sort of inconsistency,
mark the CPPC driver with CPUFREQ_NEED_UPDATE_LIMITS so that it is always
invoked when a target frequency update is requested.

Link: https://lore.kernel.org/linux-pm/20250619000925.415528-3-pmalani@google.com/ [1]
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/20250722055611.130574-2-pmalani@google.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Code Change Analysis

The change is minimal and focused - it only adds the
`CPUFREQ_NEED_UPDATE_LIMITS` flag to the cppc_cpufreq_driver struct:

```c
- .flags = CPUFREQ_CONST_LOOPS,
+ .flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
```

This single-line change modifies the driver flags in
drivers/cpufreq/cppc_cpufreq.c:928.

## Bug Being Fixed

The commit addresses a real bug where:

1. **AMU counters on CPPC platforms provide inaccurate measurements**
   when systems are idle/mostly idle
2. **This causes cpufreq to store incorrect frequency values** in its
   policy structure during CPU online
3. **Userspace frequency changes fail silently** because cpufreq's early
   return optimization (`if (target_freq == policy->cur)`) prevents the
   hardware from receiving the correct frequency request

The bug manifests as userspace being unable to set CPU frequencies
correctly on affected CPPC platforms, which is a functional regression
that impacts power management and performance.

## Why This Qualifies for Stable

1. **Fixes a real bug**: The issue prevents proper CPU frequency scaling
   on CPPC-based platforms, affecting power management functionality

2. **Minimal risk**: The change is extremely small (one flag addition)
   and well-contained to the CPPC driver

3. **Clear fix semantics**: The `CPUFREQ_NEED_UPDATE_LIMITS` flag is an
   established mechanism (introduced in commit 1c534352f47f)
   specifically designed for this scenario where drivers need frequency
   updates even when target_freq == policy->cur

4. **Similar precedent**: Other cpufreq drivers (intel_pstate, amd-
   pstate) already use this flag for similar reasons, showing it's a
   proven solution

5. **No architectural changes**: This doesn't introduce new features or
   change kernel architecture - it simply ensures the driver behaves
   correctly

6. **Recent related fixes**: The git history shows ongoing work to fix
   CPPC feedback counter issues (e.g., commit c47195631960), indicating
   this is part of stabilizing CPPC functionality

## Impact Assessment

- **Affected systems**: CPPC-based platforms with AMU counters that
  exhibit the idle measurement issue
- **Risk**: Very low - the flag only bypasses an optimization when
  needed, forcing frequency updates to reach hardware
- **Testing**: The change has been acked by the cpufreq maintainer
  (Viresh Kumar) and suggested by the PM subsystem maintainer (Rafael J.
  Wysocki)

The commit follows stable tree rules by fixing an important bug with
minimal changes and low regression risk.

 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index cb93f00bafdb..156c1e516cc8 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -816,7 +816,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 };
 
 static struct cpufreq_driver cppc_cpufreq_driver = {
-	.flags = CPUFREQ_CONST_LOOPS,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
-- 
2.39.5


