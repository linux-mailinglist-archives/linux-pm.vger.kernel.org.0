Return-Path: <linux-pm+bounces-39234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F98CA60BA
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 04:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E0D63009386
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 03:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD028751B;
	Fri,  5 Dec 2025 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2RxtvSM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A377081E;
	Fri,  5 Dec 2025 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906773; cv=none; b=JW5fu21H1hUt84d216iQyFoWoeMx4tOMYygm5BghwzMaYKr98EsYNv0HHPCNT3/56Sxlo9QQtVeD80nSjP4pOFGWfV5bV7ElZ9lW7pcohuq5+oV1XcQNdzNmlC0LjFIvXqndQMMeT4ZiNzJcK88/EcyBACXoRm3hRnue84ZKBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906773; c=relaxed/simple;
	bh=aCnktdb+wTVLC3gj9nec1duNC0hS3OcJnFItNItmnAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOtP9RnA+DhhfJUgkg4BuBQPQrH+7Jjtgr5zw4MSdKcpTGoFkdE0lIlSUCGOLLKenRbJUUMe2R7yKlvLAm9QlSYYAz1JRivTFg9bzdWBoZ996doP8tJhev/WcYMqAp1z9mYwsEc59PvB6YMTEWMVAi03k4KfTH4yfRTnOHAqmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2RxtvSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18DCC116B1;
	Fri,  5 Dec 2025 03:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764906773;
	bh=aCnktdb+wTVLC3gj9nec1duNC0hS3OcJnFItNItmnAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2RxtvSMdslKaWhoOtZaHjmqC/MSnyHnAd9TLVevkydFuHJVs0P4nxWnDAhkzIvKl
	 zVdbFFUVq4w5tVg3ormyLggB4Xp8OujJMTUsUcvrQgIqSTdUsPhD+pVSUxqgqoJ3b1
	 wrp1x4EU4NiaWo6qeFVTyQWTOVH9qullRl+codpIW8Iqf1ihXhQN5iS2ndBdzSdRUS
	 edzNBDushAKlMltIAmRH4lpJTAHMgg1OBWX9WTYlPadxktRcuSWmKofDfe3r+lNUK6
	 r+DJWrvEP4bHqydVtgwq2vW8IxvfHqlP6UHaPSL/GIWAWTpBbx8V4hG0XYZ4KHI3WH
	 QKKmEma42gNKA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Shuhao Fu <sfual@cse.ust.hk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	krzk@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.18-5.10] cpufreq: s5pv210: fix refcount leak
Date: Thu,  4 Dec 2025 22:52:34 -0500
Message-ID: <20251205035239.341989-5-sashal@kernel.org>
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

From: Shuhao Fu <sfual@cse.ust.hk>

[ Upstream commit 2de5cb96060a1664880d65b120e59485a73588a8 ]

In function `s5pv210_cpu_init`, a possible refcount inconsistency has
been identified, causing a resource leak.

Why it is a bug:
1. For every clk_get, there should be a matching clk_put on every
successive error handling path.
2. After calling `clk_get(dmc1_clk)`, variable `dmc1_clk` will not be
freed even if any error happens.

How it is fixed: For every failed path, an extra goto label is added to
ensure `dmc1_clk` will be freed regardlessly.

Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit message describes a refcount leak:
- Subject: "cpufreq: s5pv210: fix refcount leak"
- Explains the bug: `dmc1_clk` is not freed on error paths
- Explains the fix: adds a new `out:` label to ensure cleanup
- Signed-off-by: Shuhao Fu and Viresh Kumar (cpufreq maintainer)

Missing tags:
- No "Cc: stable@vger.kernel.org"
- No "Fixes:" tag pointing to the commit that introduced the bug
  (4911ca1031c2ad from 2011)

### 2. CODE CHANGE ANALYSIS

The bug:
- In `s5pv210_cpu_init()`, after `dmc1_clk = clk_get(...)` succeeds, two
  error paths jump to `out_dmc1`:
  1. `policy->cpu != 0` (line 521)
  2. Unsupported memory type (line 533)
- `out_dmc1` only frees `dmc0_clk` and `policy->clk`, not `dmc1_clk`,
  causing a refcount leak.

The fix:
- Adds a new `out:` label that calls `clk_put(dmc1_clk)`
- Changes the two error paths to `goto out;` instead of `goto out_dmc1;`
- `out:` falls through to `out_dmc1` for the rest of cleanup

Change size: 4 lines added, 2 lines modified (minimal change)

### 3. CLASSIFICATION

- Bug fix: fixes a resource leak
- Not a feature addition
- Not a new API
- Standard error handling pattern

### 4. SCOPE AND RISK ASSESSMENT

- Scope: single function, error paths only
- Risk: low
  - Only affects error paths
  - Standard cleanup pattern
  - No logic changes beyond cleanup
- Subsystem: cpufreq (mature)
- Dependencies: none; self-contained

### 5. USER IMPACT

- Affected users: systems using the S5PV210/S5PC110 cpufreq driver
- Severity: resource leak (not a crash, but still a bug)
- Trigger conditions:
  1. `policy->cpu != 0` (non-zero CPU)
  2. Unsupported memory type (not LPDDR/LPDDR2)
- Impact: clock reference leak on error paths

Historical context:
- Driver introduced in v2.6.37 (2010)
- Bug introduced in commit 4911ca1031c2ad (2011-06-06)
- Present in all stable trees since 2011

### 6. STABILITY INDICATORS

- Tested: no "Tested-by:" tag
- Reviewed: signed by Viresh Kumar (maintainer)
- Age: commit is recent (Oct 2025), but the bug is old

### 7. DEPENDENCY CHECK

- No dependencies
- Code exists in stable trees (driver present since v2.6.37)
- Fix applies cleanly to stable trees

### 8. COMPARISON WITH SIMILAR FIXES

Similar refcount leak fixes in cpufreq:
- `cpufreq: nforce2: fix reference count leak` (9600156bb9985)
- `cpufreq: mediatek: fix device leak on probe failure` (ebc4ed14a4dbf)
- `cpufreq: qcom-nvmem: fix memory leaks in probe error paths`
  (e3fd01a810537)

These follow the same pattern and are appropriate for stable.

### 9. STABLE KERNEL RULES COMPLIANCE

- Obviously correct: yes — standard cleanup pattern
- Fixes a real bug: yes — resource leak
- Important issue: moderate — resource leak, not a crash
- Small and contained: yes — 6 lines changed
- No new features: yes — only fixes cleanup
- Applies cleanly: yes — no dependencies

### 10. RISK VS BENEFIT TRADE-OFF

Benefits:
- Fixes a long-standing bug (14 years)
- Prevents resource leaks
- Low risk, small change
- Standard pattern

Risks:
- Minimal — only touches error paths
- No functional changes

Concerns:
- No explicit stable request tag
- Driver targets older ARM SoCs (may have limited current use)
- Leak only occurs on error paths

### FINAL ASSESSMENT

This is a valid bug fix that meets stable criteria:
1. Fixes a real resource leak
2. Small, contained change
3. Low risk
4. No new features
5. Standard error handling pattern

The lack of a "Cc: stable" tag is not a blocker; maintainers may add it,
or it may have been missed. The fix is appropriate for stable backport.

**YES**

 drivers/cpufreq/s5pv210-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 4215621deb3fe..ba8a1c96427a1 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -518,7 +518,7 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 
 	if (policy->cpu != 0) {
 		ret = -EINVAL;
-		goto out_dmc1;
+		goto out;
 	}
 
 	/*
@@ -530,7 +530,7 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 	if ((mem_type != LPDDR) && (mem_type != LPDDR2)) {
 		pr_err("CPUFreq doesn't support this memory type\n");
 		ret = -EINVAL;
-		goto out_dmc1;
+		goto out;
 	}
 
 	/* Find current refresh counter and frequency each DMC */
@@ -544,6 +544,8 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 	cpufreq_generic_init(policy, s5pv210_freq_table, 40000);
 	return 0;
 
+out:
+	clk_put(dmc1_clk);
 out_dmc1:
 	clk_put(dmc0_clk);
 out_dmc0:
-- 
2.51.0


