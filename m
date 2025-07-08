Return-Path: <linux-pm+bounces-30398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F51AFD7E1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 22:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52601C204B0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 20:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD252253A1;
	Tue,  8 Jul 2025 20:08:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0121ABDB;
	Tue,  8 Jul 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005280; cv=none; b=kkCvaWItWVFN9+QmFnPAsdwnfJNVeSnghwdkgOx3vEAaXl6RL0alM0M06lBvzX4KBenSgyBfxWdbDmqvL27l0fYB4klRXLWZWKjAdQPTCvQyZ4UgLfZK23MbXalbVyt8ps+D3rf8vqW9+RE38X++vwEKuoCqqDWHSzkAQFdzcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005280; c=relaxed/simple;
	bh=4TApNHMh5bXuI1y5A4A8GkOhQSZM0IKOP7GX7SjIcW4=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=hro7eKXw5lC2BycGM1vwZoUS9COBwPEO5gNvAGU9qFg+APTORWnbOCHrjR5Ezar0jqpoLxumqfdIXPWUUhhOSTa0kAHetE/14vQRbHm/7sy301II3WuUnmeEaYzavlU1R7P6rqFDzNc3ZBfNc6jSzeM/nFptqulO94mJlq/Us+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:54402)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZE4L-000RSs-N6; Tue, 08 Jul 2025 13:33:33 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:56478 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZE4K-008C0F-0d; Tue, 08 Jul 2025 13:33:33 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev,  stable@vger.kernel.org,  Mario Limonciello
 <mario.limonciello@amd.com>,  Nat Wittstock <nat@fardog.io>,  Lucian Langa
 <lucilanga@7pot.org>,  "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
  rafael@kernel.org,  pavel@ucw.cz,  len.brown@intel.com,
  linux-pm@vger.kernel.org,  kexec@lists.infradead.org
References: <20250708000215.793090-1-sashal@kernel.org>
	<20250708000215.793090-6-sashal@kernel.org>
Date: Tue, 08 Jul 2025 14:32:02 -0500
In-Reply-To: <20250708000215.793090-6-sashal@kernel.org> (Sasha Levin's
	message of "Mon, 7 Jul 2025 20:02:13 -0400")
Message-ID: <87ms9esclp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uZE4K-008C0F-0d;;;mid=<87ms9esclp.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+WnfoI1XgX4gSY7g//vFBSvkA5FSvHJZo=
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Sasha Levin <sashal@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1180 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.3 (0.4%), b_tie_ro: 3.0 (0.3%), parse: 1.37
	(0.1%), extract_message_metadata: 28 (2.3%), get_uri_detail_list: 4.6
	(0.4%), tests_pri_-2000: 28 (2.4%), tests_pri_-1000: 3.1 (0.3%),
	tests_pri_-950: 1.48 (0.1%), tests_pri_-900: 1.23 (0.1%),
	tests_pri_-90: 135 (11.4%), check_bayes: 117 (9.9%), b_tokenize: 16
	(1.4%), b_tok_get_all: 14 (1.2%), b_comp_prob: 3.8 (0.3%),
	b_tok_touch_all: 80 (6.8%), b_finish: 0.76 (0.1%), tests_pri_0: 615
	(52.1%), check_dkim_signature: 0.45 (0.0%), check_dkim_adsp: 7 (0.6%),
	poll_dns_idle: 334 (28.3%), tests_pri_10: 2.8 (0.2%), tests_pri_500:
	357 (30.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rafael@kernel.org, rafael.j.wysocki@intel.com, lucilanga@7pot.org, nat@fardog.io, mario.limonciello@amd.com, stable@vger.kernel.org, patches@lists.linux.dev, sashal@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false


Wow!

Sasha I think an impersonator has gotten into your account, and
is just making nonsense up.

At first glance this reads like an impassioned plea to backport this
change, from someone who has actually dealt with it.

Unfortunately reading the justification in detail is an exercise
in reading falsehoods.

If this does not come from an impersonator then:
- If this comes from a human being, I recommend you have a talk with
  them.
- If this comes from a machine I recommend you take it out of commission
  and rework it.

At best all of this appears to be an effort to get someone else to
do necessary thinking for you.  As my time for kernel work is very
limited I expect I will auto-nack any such future attempts to outsource
someone else's thinking on me.

Eric

Sasha Levin <sashal@kernel.org> writes:

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> [ Upstream commit 12ffc3b1513ebc1f11ae77d053948504a94a68a6 ]
>
> Currently swap is restricted before drivers have had a chance to do
> their prepare() PM callbacks. Restricting swap this early means that if
> a driver needs to evict some content from memory into sawp in it's
> prepare callback, it won't be able to.
>
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
>
> Move the swap restriction to right after all devices have had a chance
> to do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
>
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Nat Wittstock <nat@fardog.io>
> Tested-by: Lucian Langa <lucilanga@7pot.org>
> Link: https://patch.msgid.link/20250613214413.4127087-1-superm1@kernel.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> **YES**
>
> This commit should be backported to stable kernel trees for the
> following reasons:

Really?  And when those reasons turn out to be baloney?

> ## Critical Bug Fix for Real User Issues
>
> 1. **Fixes Actual Suspend Failures**: The commit addresses real-world
>    suspend failures under memory pressure on systems with AMD discrete
>    GPUs. The linked issues (ROCm/ROCK-Kernel-Driver#174 and
>    freedesktop.org/drm/amd#2362) indicate this affects actual users.

Those linked issues are completely corrupted in the paragraph above.
From the original commit the proper issues are:

  https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
  https://gitlab.freedesktop.org/drm/amd/-/issues/2362

Which indicate that something is going on, but are old enough and
long enough coming to any kind of conclusion from them is not easy.

> 2. **Regression Fix**: This is effectively a regression fix. The PM
>    subsystem's early swap restriction prevents AMD GPU drivers from
>    properly evicting VRAM during their prepare() callbacks, which is a
>    requirement that has become more critical as GPU VRAM sizes have
>    increased.

There is no indication that this used to work, or that an earlier
kernel change caused this to stop working.  This is not a regression.

> ## Small, Contained Change
>
> 3. **Minimal Code Changes**: The fix is remarkably simple - it just
>    moves the `pm_restrict_gfp_mask()` call from early in the suspend
>    sequence to after `dpm_prepare()` completes. The changes are:
>    - Move `pm_restrict_gfp_mask()` from multiple early locations to
>      inside `dpm_suspend_start()` after `dpm_prepare()` succeeds
>    - Add corresponding `pm_restore_gfp_mask()` calls in error paths and
>      resume paths
>    - Remove the now-redundant calls from hibernate.c and suspend.c

Reworking how different layers of the kernel interact is not minimal,
and it not self contained.

> 4. **Low Risk of Regression**: The change maintains the original intent
>    of preventing I/O during the critical suspend phase while allowing it
>    during device preparation. The swap restriction still happens before
>    `dpm_suspend()`, just after `dpm_prepare()`.

There is no analysis anywhere on what happens to the code with
code that might expect the old behavior.

So it is not possible to conclude a low risk of regression,
in fact we can't conclude anything.

> ## Follows Stable Rules
>
> 5. **Meets Stable Criteria**:
>    - Fixes a real bug that bothers people (suspend failures)
Addresses a real bug, yes.  Fixes?
>    - Small change (moves function calls, doesn't introduce new logic)
No.
>    - Obviously correct (allows drivers to use swap during their
>      designated preparation phase)

Not at all.  It certainly isn't obvious to me what is going on.

>    - Already tested by users (Tested-by tags from affected users)

Yes there are Tested-by tags.

> ## Similar to Other Backported Commits
>
> 6. **Pattern Matches**: Looking at the similar commits provided, this
>    follows the same pattern as the AMD GPU eviction commits that were
>    backported. Those commits also addressed the same fundamental issue -
>    ensuring GPU VRAM can be properly evicted during suspend/hibernation.

Which other commits are those?

> ## Critical Timing

Timing?

> 7. **Error Path Handling**: The commit properly handles error paths by
>    adding `pm_restore_gfp_mask()` calls in:
>    - `dpm_resume_end()` for normal resume
>    - `platform_recover()` error path in suspend.c
>    - `pm_restore_gfp_mask()` in kexec_core.c for kexec flows

I don't see anything in this change that has to do with error paths.


> The commit is well-tested, addresses a real problem affecting users, and
> makes a minimal, obviously correct change to fix suspend failures on
> systems with discrete GPUs under memory pressure.

The evidence that a 3 week old change is well tested, simply
because it has been merged into Linus's change seems lacking.

Tested yes, but is it well tested?  Are there any possible side
effects?

I certainly see no evidence of any testing or any exercise at
all of the kexec path modified.  I wasn't even away of this
change until this backport came in.

Eric

