Return-Path: <linux-pm+bounces-31788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9200B19716
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FE73B6798
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AE14E2F2;
	Mon,  4 Aug 2025 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL6gJzvz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03ED76026;
	Mon,  4 Aug 2025 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267098; cv=none; b=V+hkBYU8yDmgabZ+SVHRaMKoL343hd8jaWKKp32cbOymkaGRhsDKWPfZzmBxSHBlvZt1Uc3VGmHc9pD+WW7Pk3DxuoWfSCN+lrde6MGq0ymGriNG79gRH5gOlK8S13tukY8PH2TIKqpt/DPdcBqe8/WZfLLBWGpOFfcb9kEaIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267098; c=relaxed/simple;
	bh=UnQSs95JYVI0B+A70FNW1tGIgLBZbavwLHlTWIc81ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aE5b87dg1wYCzVGbY8ZV8wI1ca+IqXbXM/kFEjqiJyGbtZXVLEvlHmPKxplkrl/ew6uXzx7NSz7l3zW6SN+LWIuhggYWqtoJYACTDDWtOHSGN8ZQdxl1JwcJ5E37Q5C4r6Qyq44HlTUW7nlPgCVdin7EY/IUmuUIaJFfWsC5Uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL6gJzvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C82DC4CEF8;
	Mon,  4 Aug 2025 00:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267097;
	bh=UnQSs95JYVI0B+A70FNW1tGIgLBZbavwLHlTWIc81ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DL6gJzvzUAbDR17/RmQVG35KuJ3RX4wy4NA9pR0HalDTPhDPtn4xG2yXyciUWEj0T
	 WKC3X+2Gt32u5ibEQ3NfauIzfmX42lJgQgCavLW5RsrrhKdozAx21eVBL7eWbsiZMj
	 5LPvkJnX+Nuj0+CqUg/1T8RPo9F1UB7m/RYE/E5uK/8llI+awTSLR3dByu8tPAqIF4
	 F9rcvXH+7MAPhrcxj2eb1x1IzmNEhJmbnIcY+VJVOpsHA+mUAhaYG8Xhv8rNtXZGkC
	 mQuUtl6bJ5Ycuo6YORao1owYWsBeuWztVh5VPuXq7QgUGFnbOzVK1uO5blbkOk43QT
	 r11OQBGgPbpMg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16 25/85] cpufreq: intel_pstate: Add Granite Rapids support in no-HWP mode
Date: Sun,  3 Aug 2025 20:22:34 -0400
Message-Id: <20250804002335.3613254-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002335.3613254-1-sashal@kernel.org>
References: <20250804002335.3613254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit fc64e0421598aaa87d61184f6777b52614a095be ]

Users may disable HWP in firmware, in which case intel_pstate
wouldn't load unless the CPU model is explicitly supported.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Link: https://patch.msgid.link/20250623105601.3924-1-lirongqing@baidu.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's the
extensive analysis:

**Nature of the Change:**
The commit adds support for Intel Granite Rapids processors (both D and
X variants) in the intel_pstate driver when Hardware P-states (HWP) is
disabled in firmware. This is a hardware enablement patch that adds two
new CPU model IDs to existing lists:
- `INTEL_GRANITERAPIDS_D` and `INTEL_GRANITERAPIDS_X` are added to
  `intel_pstate_cpu_ids[]` table

**Why This Is a Good Backport Candidate:**

1. **Fixes a Real User-Facing Issue**: Without this patch, users who
   have Granite Rapids CPUs with HWP disabled in firmware cannot use the
   intel_pstate driver at all. The commit message explicitly states
   "intel_pstate wouldn't load unless the CPU model is explicitly
   supported." This means affected systems would fall back to less
   efficient CPU frequency scaling drivers, significantly impacting
   performance and power efficiency.

2. **Minimal and Safe Change**: The patch only adds two lines to an
   existing CPU ID table:
  ```c
  +       X86_MATCH(INTEL_GRANITERAPIDS_D,        core_funcs),
  +       X86_MATCH(INTEL_GRANITERAPIDS_X,        core_funcs),
  ```
  These entries follow the exact same pattern as all other CPU entries
  and use the standard `core_funcs` handler, which is already used by
  many other Intel CPU models.

3. **No Architectural Changes**: The commit doesn't introduce any new
   features, modify existing logic, or change any kernel interfaces.
   It's purely a hardware enablement patch that extends existing
   functionality to new hardware.

4. **Low Risk of Regression**:
   - The change is contained entirely within CPU model detection tables
   - It only affects systems with the specific Granite Rapids CPU models
   - Uses the well-tested `core_funcs` implementation already used by
     Sapphire Rapids, Emerald Rapids, and other server CPUs
   - The code path is only triggered on systems with these specific CPUs

5. **Follows Established Pattern**: Looking at the surrounding code,
   Granite Rapids entries were already present in the
   `intel_pstate_cpu_oob_ids[]` table (for out-of-band control),
   indicating this is completing support that was partially added
   previously.

6. **Important for Server Deployments**: Granite Rapids is a server CPU
   platform, and enterprise users often disable HWP for specific
   workload requirements or compatibility reasons. Without this patch,
   they lose access to the intel_pstate driver entirely.

The commit meets all the criteria for stable backporting: it fixes a
real bug (driver fails to load on supported hardware), the fix is
minimal and contained, there's no risk to existing systems, and it
provides important functionality for affected users.

 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 64587d318267..1782b29dc595 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2775,6 +2775,8 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	X86_MATCH(INTEL_TIGERLAKE,		core_funcs),
 	X86_MATCH(INTEL_SAPPHIRERAPIDS_X,	core_funcs),
 	X86_MATCH(INTEL_EMERALDRAPIDS_X,	core_funcs),
+	X86_MATCH(INTEL_GRANITERAPIDS_D,	core_funcs),
+	X86_MATCH(INTEL_GRANITERAPIDS_X,	core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
2.39.5


