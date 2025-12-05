Return-Path: <linux-pm+bounces-39233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3133CA60B4
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 04:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1AFF307B8DD
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 03:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B64628751B;
	Fri,  5 Dec 2025 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5Wq7lbd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F1286D40;
	Fri,  5 Dec 2025 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906770; cv=none; b=DWpNEt2Slez76miiiCbaopiskvfNFueiAbsc6K82ZQ4W64V28mach+YlNkujRCtjHkn+fSa8lwMs4QAmMAwfvaMDcc0DJqk/TAN4udoPT5YscB7nZLkbthpnNtIeZbHxNd7v1FImMQX6sYvVXzKayNv5feySuggdiUGrbpQaoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906770; c=relaxed/simple;
	bh=Xw2tiDofM9huEod2qZ3ZtmwpWgJkbGH/y/kn7RzbcsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWrBvtaRReKB1GnmjBWmEiJfLgqnwj+33NUJANHnVwUBEbE6wKQ5MCiXsc1mrWuiKtHGsJ75Ba4oNZrSbyWTjviqgJHV15CnquIX5sCDntXAzk5+N3fIzK/KWhsFTa8qQ7llHVFibykymBcllkSk+8LbM8K0Ikc4sTqU4Pb1Efo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5Wq7lbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB96C16AAE;
	Fri,  5 Dec 2025 03:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764906770;
	bh=Xw2tiDofM9huEod2qZ3ZtmwpWgJkbGH/y/kn7RzbcsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5Wq7lbd6dwAqgMW+F80V2Y4pGYci4cjTdX5k451CANMNP4Ys/RGlG7Gizm/S9KrL
	 AbWiQgvBbsLvkTybsZAdusZKhQVBhHpjLgvDNUrWX6h4zudOSb9blxmXz1rgM6gYb/
	 qANZq9l1OBkwadqdB1FRChspUXl6T21xqyrOuDuXwQVs+CUUVFMFkFu8yz7iPlUx4Q
	 VU5P1asEKAsLc3xWWieJ2Ddo9inCDkgP+awTgkA9QJ5EUTZnIv2rLtbgw3hsfIVu5c
	 8WUKczjTK4DWoxlxk/dSRha/VwPRzcijNWXU3ZNCC9gMoIfbcVGPj+PrgNufdBI1P9
	 gR2RV3t4UvBVQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.6] cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
Date: Thu,  4 Dec 2025 22:52:33 -0500
Message-ID: <20251205035239.341989-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205035239.341989-1-sashal@kernel.org>
References: <20251205035239.341989-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hal Feng <hal.feng@starfivetech.com>

[ Upstream commit 6e7970cab51d01b8f7c56f120486c571c22e1b80 ]

Add the compatible strings for supporting the generic
cpufreq driver on the StarFive JH7110S SoC.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### 1. COMMIT MESSAGE ANALYSIS

**Subject**: `cpufreq: dt-platdev: Add JH7110S SOC to the allowlist`

**Key observations**:
- Uses "Add" (new hardware support), not "Fix"
- No "Cc: stable@vger.kernel.org" tag
- No "Fixes:" tag
- No bug report references ("Reported-by:", "Link:")
- Reviewed-by from Heinrich Schuchardt (Canonical)
- Signed-off by Viresh Kumar (cpufreq maintainer)

**Commit message**: Adds compatible strings to enable the generic
cpufreq driver on StarFive JH7110S SoC.

### 2. CODE CHANGE ANALYSIS

**Files changed**: 1 file (`drivers/cpufreq/cpufreq-dt-platdev.c`)

**Change**: Single line addition:
```c
+       { .compatible = "starfive,jh7110s", },
```

**Context**: Added to the `allowlist[]` array (line 90), right after
`starfive,jh7110`.

**Code logic** (from `cpufreq_dt_platdev_init()`):
1. If root node matches allowlist → create cpufreq-dt device
2. Else if CPU0 has `operating-points-v2` and root node is not in
   blocklist → create cpufreq-dt device
3. Else → return -ENODEV

**Impact**: Adding `starfive,jh7110s` to the allowlist ensures the
cpufreq-dt platform device is always created, regardless of operating-
points version.

**Root cause**: Without this entry, cpufreq-dt may not be created for
jh7110s devices, breaking CPU frequency scaling.

### 3. CLASSIFICATION

**Is this fixing a bug or adding a feature?**

- No explicit bug report or "Fixes:" tag
- Enables hardware support for a new SoC variant
- Similar to the jh7110 addition (commit `4b4c0d37164c2`, April 2023)

**Exception category check**:

1. Device IDs/compatible strings: Yes — compatible strings are device
   tree device IDs. Stable rules allow "just add a device ID"
   (Documentation/process/stable-kernel-rules.rst line 15).
2. Hardware quirks/workarounds: No
3. Device tree updates: Related — enables DT-based cpufreq support
4. Build fixes: No
5. Documentation: No

**Classification**: Compatible string addition (device tree device ID),
which stable rules explicitly allow.

### 4. SCOPE AND RISK ASSESSMENT

**Lines changed**: 1 line added, 0 removed

**Complexity**: Trivial — single array entry

**Files touched**: 1 file

**Subsystem**: `drivers/cpufreq` — mature, well-tested

**Risk assessment**:
- Low risk: no logic changes, only a list entry
- No dependencies: standalone change
- Driver exists in stable: `cpufreq-dt-platdev.c` added in 2016 (commit
  `f56aad1d98f1c`)
- Pattern matches existing entries (e.g., jh7110)

**Potential issues**:
- None identified — this is a pure addition

### 5. USER IMPACT

**Who is affected**:
- Users with StarFive JH7110S hardware running stable kernels
- Without this, cpufreq may not initialize, disabling CPU frequency
  scaling

**Severity if bug hits**:
- Medium — cpufreq not working means:
  - No dynamic frequency scaling
  - Potential performance/power impact
  - Not a crash, but degraded functionality

**Evidence of user impact**:
- No bug reports found in the commit
- No device tree files for jh7110s in the kernel tree
- Commit is recent (October 2025)

**Assessment**: Enables hardware support; if jh7110s hardware exists on
stable kernels, this fixes missing cpufreq functionality.

### 6. STABILITY INDICATORS

**Tested-by**: None

**Reviewed-by**: Heinrich Schuchardt (Canonical) — positive signal

**Age in mainline**: Very recent (October 2025)

**Maintainer sign-off**: Viresh Kumar (cpufreq maintainer)

### 7. DEPENDENCY CHECK

**Prerequisites**: None — standalone change

**Code existence in stable**: Yes — `cpufreq-dt-platdev.c` exists in
stable trees (added 2016)

**API dependencies**: None — only adds a compatible string

**Backport adjustments**: None — applies cleanly

### 8. HISTORICAL CONTEXT

**Similar commits**:
- `4b4c0d37164c2` (April 2023): Added `starfive,jh7110` — same pattern,
  no stable tag
- Other SoC additions to allowlist follow the same pattern

**Pattern**: SoC additions to cpufreq allowlist typically do not include
"Cc: stable" tags, but many are still acceptable for stable as device ID
additions.

### 9. STABLE KERNEL RULES COMPLIANCE

**Rule 1: Obviously correct and tested**
- Yes — trivial, follows established pattern, maintainer sign-off

**Rule 2: Fixes a real bug**
- Borderline — enables hardware support; if hardware exists, fixes
  broken cpufreq

**Rule 3: Fixes an important issue**
- Medium importance — enables CPU frequency scaling

**Rule 4: Small and contained**
- Yes — 1 line addition

**Rule 5: No new features**
- Borderline — enables new hardware support, but compatible strings are
  explicitly allowed as device IDs

**Rule 6: Applies cleanly**
- Yes — no conflicts expected

**Exception applies**: Yes — compatible string additions are treated
like device ID additions, which stable rules allow.

### 10. FINAL ASSESSMENT

**Arguments for YES**:
1. Compatible strings are device tree device IDs; stable rules allow
   device ID additions
2. Very low risk — single line, no logic changes
3. Follows established pattern (jh7110 precedent)
4. Fixes broken cpufreq for jh7110s hardware on stable kernels
5. Driver exists in stable trees
6. No dependencies
7. Maintainer sign-off

**Arguments for NO**:
1. No "Cc: stable" tag
2. No explicit bug report
3. Enables new hardware support rather than fixing a documented bug
4. Very recent commit (limited testing time)

**Decision rationale**:

This is a compatible string addition, equivalent to a device ID
addition. Stable rules explicitly allow "just add a device ID"
(Documentation/process/stable-kernel-rules.rst line 15). The change is
trivial, low-risk, and fixes broken cpufreq functionality for jh7110s
hardware on stable kernels. The absence of a "Cc: stable" tag is not
disqualifying; many device ID additions are backported without it.

The commit enables hardware support, but compatible string additions are
treated as device ID additions and are acceptable for stable trees. If
jh7110s hardware exists and users run stable kernels, this fixes missing
cpufreq support.

**YES**

 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index cd1816a12bb99..dc11b62399ad5 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -87,6 +87,7 @@ static const struct of_device_id allowlist[] __initconst = {
 	{ .compatible = "st-ericsson,u9540", },
 
 	{ .compatible = "starfive,jh7110", },
+	{ .compatible = "starfive,jh7110s", },
 
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap4", },
-- 
2.51.0


