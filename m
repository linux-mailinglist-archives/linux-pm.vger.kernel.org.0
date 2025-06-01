Return-Path: <linux-pm+bounces-27942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC60ACA79F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 03:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D45417D24D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 01:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D101A9B32;
	Sun,  1 Jun 2025 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNBTfjr/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7D337879;
	Sun,  1 Jun 2025 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821509; cv=none; b=H0usCgE1qKfPCD3wCggjNsFEalI7NEzLKMO+2Ljp7kNPDq3Q1EjsZhMuGHBWhXJafevUIr6ylBFYfNzaqusB5dzfrs7e1fRQ7GFYGtOh16Q8F+0BIyqlLVPsOSlHXy/IZi0bFeQxQYowAQqrqK8ayWZTaehhv3XYdgsjSOAL2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821509; c=relaxed/simple;
	bh=lf/XHBQvY6M1zlbBn7QHOXzavC6BI42rFG/+5oYwu1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1PVtuspZ+9lyHYVwHR35sGz4JWh3gFrJ540VBQeyl/bD6snRwM5U8QR4yD91gxqtHRk3PjufWO1VoKXqo66PtQkicwrtvgDZuOFLYLQzq1L+oMc0Jnfgj8ki8slahN4ewL0V/fWs2e+Ab8dp9YlIdEQC+XvStf+dSdyVpnaUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNBTfjr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3E7C4CEE7;
	Sun,  1 Jun 2025 23:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821509;
	bh=lf/XHBQvY6M1zlbBn7QHOXzavC6BI42rFG/+5oYwu1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNBTfjr/AQijAP7yVqr961LYZjqNJdphjk+bQj98GyJQzQuweJ/WbC9+6BSPERDrN
	 o3+eHMYYms+ZuPCeuho7+mfc1ELjldOsABXdUGVbY7kwV0N+Uv7rnOzlQLJlPa0Sk4
	 YnTVPbc1vdgCxLit1bKpiuBIyrF5tjp3jASCcJlteCsWwCQE2zLFB49LuNMaWJwfdm
	 2P13YpVO1wldq35vwMHJt4Nsj1LXTsQod5wXdhKVk/ON98xpGakFypTrRXIRJhKGd1
	 0WXWxxKUQr3w+7K9ShDvfGFKlTGUaWwnS73FfJWmqPgWqLo7m/6Bxz9OBl3Tg5HGK6
	 SDRqxtUxuJAww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 32/34] cpufreq: Force sync policy boost with global boost on sysfs update
Date: Sun,  1 Jun 2025 19:43:56 -0400
Message-Id: <20250601234359.3518595-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234359.3518595-1-sashal@kernel.org>
References: <20250601234359.3518595-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 121baab7b88ed865532dadb7ef1aee6e2bea86f5 ]

If the global boost flag is enabled and policy boost flag is disabled, a
call to `cpufreq_boost_trigger_state(true)` must enable the policy's
boost state.

The current code misses that because of an optimization. Fix it.

Suggested-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/852ff11c589e6300730d207baac195b2d9d8b95f.1745511526.git.viresh.kumar@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Analysis ### Code Change Analysis The commit makes a very small,
targeted fix to the `cpufreq_boost_trigger_state()` function in
`/drivers/cpufreq/cpufreq.c`. The change removes a single optimization
check: **Before:** ```c if (cpufreq_driver->boost_enabled == state)
return 0; ``` **After:** ```c /bin /bin.usr-is-merged /boot /dev /etc
/home /init /lib /lib.usr-is-merged /lib64 /lost+found /media /mnt /opt
/proc /root /run /sbin /sbin.usr-is-merged /snap /srv /sys /tmp /usr
/var linux linux-kernel Don't compare 'cpufreq_driver->boost_enabled'
with 'state' here to linux linux-kernel make sure all policies are in
sync with global boost flag. linux-kernel/ linux/ ``` ### Bug Being
Fixed The commit fixes a synchronization bug between global boost
settings and per-policy boost settings. The problem occurs when: 1.
Global boost is enabled (`cpufreq_driver->boost_enabled = true`) 2. Some
policies have boost disabled (`policy->boost_enabled = false`) 3. A call
to `cpufreq_boost_trigger_state(true)` should enable boost on all
policies The old code would return early due to the optimization check,
failing to sync the policy-level boost flags with the global setting.
This means individual policies could remain out of sync with the global
boost state. ### Backport Suitability Assessment **✅ Fixes Important
Bug:** Yes - this addresses a functional bug where boost settings can
become inconsistent between global and per-policy levels. **✅ Small and
Contained:** Yes - the change is minimal (removes 2 lines, adds
comment), affecting only one function. **✅ Low Risk:** Yes - the change
simply removes an optimization, ensuring the existing sync logic always
runs. This cannot introduce new bugs. **✅ No Architectural Changes:**
Yes - this doesn't change any APIs or data structures. **✅ Critical
Subsystem:** While cpufreq is important, this specific bug affects only
boost functionality, which is not a core feature. **✅ Clear Side
Effects:** The only side effect is that `cpufreq_boost_trigger_state()`
will now always iterate through all policies even when the global state
appears unchanged, ensuring proper synchronization. ### Comparison with
Similar Commits Looking at the provided similar commits: - **Similar
Commit #3 (YES):** Also fixes per-policy boost behavior with targeted
changes - **Similar Commit #4 (YES):** Introduces boost_supported flag
with minimal risk changes - **Similar Commits #1, #2, #5 (NO):** These
add new features or make broader architectural changes This commit
follows the pattern of commits #3 and #4 - it's a small, targeted fix to
existing boost functionality without introducing new features. ###
Stable Tree Criteria Compliance This commit meets all stable tree
criteria: - Fixes a real bug affecting users who rely on per-policy
boost controls - The fix is obvious and minimal - No risk of regression
since it only removes an optimization - Doesn't change user-visible
behavior except to fix the broken synchronization - The bug could affect
power management and performance on systems using cpufreq boost The
commit represents exactly the type of small, safe bugfix that stable
trees are designed to include.

 drivers/cpufreq/cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d13139497da44..6294e10657b46 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2637,8 +2637,10 @@ int cpufreq_boost_trigger_state(int state)
 	unsigned long flags;
 	int ret = 0;
 
-	if (cpufreq_driver->boost_enabled == state)
-		return 0;
+	/*
+	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
+	 * make sure all policies are in sync with global boost flag.
+	 */
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver->boost_enabled = state;
-- 
2.39.5


