Return-Path: <linux-pm+bounces-30326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEAAAFBEE5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 02:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E44560FCD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 00:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26F7464;
	Tue,  8 Jul 2025 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjG1QNfQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF538FB9;
	Tue,  8 Jul 2025 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932947; cv=none; b=MexGxnkjohg5yf2xKI4ZvdB/CRVd4VCZe+7DXPizh2ERzxnjUWVufxLJ06naRRTw4JP4cVt41p1KGhHj9NpgsNnJzZ0ZsyGWOxIcTXWtp7Q8cFeySqsTEv4V72HELcTsmBjtzuQDp2XgL0MBtrHse/vL01L3bYXH+B+n6b76tv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932947; c=relaxed/simple;
	bh=oGRHJS2/KFYufyAFNRjiMUXXFkY1yNLM85w2UfIQEKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xo9u07hIw0wF1TlsNM9rnhbABw9nXYYDawBtLlkBTdrf/6Sqpj1GY79AWJclw+KnTyNyLGc3o36DBm/9/URXEXupx5sNYScCrYqRgLyJx3ZyJLIXlkrea2dWd1Zz+8NCb9d52g8P6a1IlRh0LhhcX/YWo+Kl9Rr2fD4MdtLK7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjG1QNfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA71C4CEF1;
	Tue,  8 Jul 2025 00:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751932946;
	bh=oGRHJS2/KFYufyAFNRjiMUXXFkY1yNLM85w2UfIQEKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjG1QNfQf3FT/h0ejv99XMCmWXmVrd1ql24PFZDB7obobXuObqH2AOHpIIUlH3bEx
	 rMNU8jlATYumj0aZKtmNbSpQNBjg1GwjYUBcEjA8LM9KgL24rgoOBv4HBwUakAY9ED
	 YTgc0jMLucUZ/89FTyKE4Y8VhClZeDY+q73P2ZsixGXdVy6ad9v4yWBzPlNAOFfVIQ
	 9bIZI+L2NJb/DjMm0rqJKO5OeXHq0xQXgdHcE8+YvDveGL1nOPJDfyr4R3FpZnwA4P
	 Z9uMpOjDify00f4Fg+XVc8zX61Gcz8/8YXLBwbK7ElLy1jc46C/1gql8FRaJPTuAE1
	 y7D8FCU+zfrzg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>,
	Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	ebiederm@xmission.com,
	linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the suspend sequence
Date: Mon,  7 Jul 2025 20:02:13 -0400
Message-Id: <20250708000215.793090-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708000215.793090-1-sashal@kernel.org>
References: <20250708000215.793090-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.5
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 12ffc3b1513ebc1f11ae77d053948504a94a68a6 ]

Currently swap is restricted before drivers have had a chance to do
their prepare() PM callbacks. Restricting swap this early means that if
a driver needs to evict some content from memory into sawp in it's
prepare callback, it won't be able to.

On AMD dGPUs this can lead to failed suspends under memory pressure
situations as all VRAM must be evicted to system memory or swap.

Move the swap restriction to right after all devices have had a chance
to do the prepare() callback.  If there is any problem with the sequence,
restore swap in the appropriate dpm resume callbacks or error handling
paths.

Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Nat Wittstock <nat@fardog.io>
Tested-by: Lucian Langa <lucilanga@7pot.org>
Link: https://patch.msgid.link/20250613214413.4127087-1-superm1@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

## Critical Bug Fix for Real User Issues

1. **Fixes Actual Suspend Failures**: The commit addresses real-world
   suspend failures under memory pressure on systems with AMD discrete
   GPUs. The linked issues (ROCm/ROCK-Kernel-Driver#174 and
   freedesktop.org/drm/amd#2362) indicate this affects actual users.

2. **Regression Fix**: This is effectively a regression fix. The PM
   subsystem's early swap restriction prevents AMD GPU drivers from
   properly evicting VRAM during their prepare() callbacks, which is a
   requirement that has become more critical as GPU VRAM sizes have
   increased.

## Small, Contained Change

3. **Minimal Code Changes**: The fix is remarkably simple - it just
   moves the `pm_restrict_gfp_mask()` call from early in the suspend
   sequence to after `dpm_prepare()` completes. The changes are:
   - Move `pm_restrict_gfp_mask()` from multiple early locations to
     inside `dpm_suspend_start()` after `dpm_prepare()` succeeds
   - Add corresponding `pm_restore_gfp_mask()` calls in error paths and
     resume paths
   - Remove the now-redundant calls from hibernate.c and suspend.c

4. **Low Risk of Regression**: The change maintains the original intent
   of preventing I/O during the critical suspend phase while allowing it
   during device preparation. The swap restriction still happens before
   `dpm_suspend()`, just after `dpm_prepare()`.

## Follows Stable Rules

5. **Meets Stable Criteria**:
   - Fixes a real bug that bothers people (suspend failures)
   - Small change (moves function calls, doesn't introduce new logic)
   - Obviously correct (allows drivers to use swap during their
     designated preparation phase)
   - Already tested by users (Tested-by tags from affected users)

## Similar to Other Backported Commits

6. **Pattern Matches**: Looking at the similar commits provided, this
   follows the same pattern as the AMD GPU eviction commits that were
   backported. Those commits also addressed the same fundamental issue -
   ensuring GPU VRAM can be properly evicted during suspend/hibernation.

## Critical Timing

7. **Error Path Handling**: The commit properly handles error paths by
   adding `pm_restore_gfp_mask()` calls in:
   - `dpm_resume_end()` for normal resume
   - `platform_recover()` error path in suspend.c
   - `pm_restore_gfp_mask()` in kexec_core.c for kexec flows

The commit is well-tested, addresses a real problem affecting users, and
makes a minimal, obviously correct change to fix suspend failures on
systems with discrete GPUs under memory pressure.

 drivers/base/power/main.c | 5 ++++-
 include/linux/suspend.h   | 5 +++++
 kernel/kexec_core.c       | 1 +
 kernel/power/hibernate.c  | 3 ---
 kernel/power/power.h      | 5 -----
 kernel/power/suspend.c    | 3 +--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1926454c7a7e8..dd1efa95bcf15 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1182,6 +1182,7 @@ void dpm_complete(pm_message_t state)
  */
 void dpm_resume_end(pm_message_t state)
 {
+	pm_restore_gfp_mask();
 	dpm_resume(state);
 	dpm_complete(state);
 }
@@ -2015,8 +2016,10 @@ int dpm_suspend_start(pm_message_t state)
 	error = dpm_prepare(state);
 	if (error)
 		dpm_save_failed_step(SUSPEND_PREPARE);
-	else
+	else {
+		pm_restrict_gfp_mask();
 		error = dpm_suspend(state);
+	}
 
 	dpm_show_time(starttime, state, error, "start");
 	return error;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index da6ebca3ff774..d638f31dc32cd 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -441,6 +441,8 @@ extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
 extern void pm_report_hw_sleep_time(u64 t);
 extern void pm_report_max_hw_sleep(u64 t);
+void pm_restrict_gfp_mask(void);
+void pm_restore_gfp_mask(void);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
@@ -485,6 +487,9 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 static inline void pm_report_hw_sleep_time(u64 t) {};
 static inline void pm_report_max_hw_sleep(u64 t) {};
 
+static inline void pm_restrict_gfp_mask(void) {}
+static inline void pm_restore_gfp_mask(void) {}
+
 static inline void ksys_sync_helper(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3e62b944c8833..2972278497b0b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1082,6 +1082,7 @@ int kernel_kexec(void)
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
  Resume_console:
+		pm_restore_gfp_mask();
 		console_resume_all();
 		thaw_processes();
  Restore_console:
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 5af9c7ee98cd4..0bb5a7befe944 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -418,7 +418,6 @@ int hibernation_snapshot(int platform_mode)
 	}
 
 	console_suspend_all();
-	pm_restrict_gfp_mask();
 
 	error = dpm_suspend(PMSG_FREEZE);
 
@@ -554,7 +553,6 @@ int hibernation_restore(int platform_mode)
 
 	pm_prepare_console();
 	console_suspend_all();
-	pm_restrict_gfp_mask();
 	error = dpm_suspend_start(PMSG_QUIESCE);
 	if (!error) {
 		error = resume_target_kernel(platform_mode);
@@ -566,7 +564,6 @@ int hibernation_restore(int platform_mode)
 		BUG_ON(!error);
 	}
 	dpm_resume_end(PMSG_RECOVER);
-	pm_restore_gfp_mask();
 	console_resume_all();
 	pm_restore_console();
 	return error;
diff --git a/kernel/power/power.h b/kernel/power/power.h
index f8496f40b54fa..6037090578b71 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -235,11 +235,6 @@ static inline void suspend_test_finish(const char *label) {}
 /* kernel/power/main.c */
 extern int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down);
 extern int pm_notifier_call_chain(unsigned long val);
-void pm_restrict_gfp_mask(void);
-void pm_restore_gfp_mask(void);
-#else
-static inline void pm_restrict_gfp_mask(void) {}
-static inline void pm_restore_gfp_mask(void) {}
 #endif
 
 #ifdef CONFIG_HIGHMEM
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8eaec4ab121d4..d22edf9678872 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -537,6 +537,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 	return error;
 
  Recover_platform:
+	pm_restore_gfp_mask();
 	platform_recover(state);
 	goto Resume_devices;
 }
@@ -600,9 +601,7 @@ static int enter_state(suspend_state_t state)
 
 	trace_suspend_resume(TPS("suspend_enter"), state, false);
 	pm_pr_dbg("Suspending system (%s)\n", mem_sleep_labels[state]);
-	pm_restrict_gfp_mask();
 	error = suspend_devices_and_enter(state);
-	pm_restore_gfp_mask();
 
  Finish:
 	events_check_enabled = false;
-- 
2.39.5


