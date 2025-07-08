Return-Path: <linux-pm+bounces-30397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDAEAFD7A4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 21:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD881896584
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 19:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0493D238152;
	Tue,  8 Jul 2025 19:52:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A501DDA24;
	Tue,  8 Jul 2025 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004331; cv=none; b=RWTlYCDeLrfj0tK40kN/zuO/bB/lTdw52DtF2q/FwY+LFoyewjw+XKgXEz93a1gF45oSbGgM+i/bmPsz61F/yWj09Vylj5pUOR1QWixs8s40qWvQAJtlK7Ws3OWrcWtNkMlxoNhM+4RL7XmCWXUlMkn0sI84zxFYyVMpbgp+Ho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004331; c=relaxed/simple;
	bh=rIcG7QnMKABBJ4xbCaROXpMcNgkWqi9ulfpR9mmLQ3I=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=JXfPl8jQrgQZdtOwNhqhKHFKbx1CmVyNXMlH7qi73jnyNVpD/YiM6d/ykbKqGcRsxvGot5wxeEwo0lLoCQD9cI6P7Cy9u7DvWM+e0PsTEPBOHdVrOYwPjjXH1kjmNOLk+WjCqS8y1PlRAnfi0T9nNZyIHbUnGBq4ItpLSCn9L+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:47190)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZDld-0087r7-EQ; Tue, 08 Jul 2025 13:14:13 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:57294 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZDlb-00EWoI-M0; Tue, 08 Jul 2025 13:14:13 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev,  stable@vger.kernel.org,  Mario Limonciello
 <mario.limonciello@amd.com>,  Nat Wittstock <nat@fardog.io>,  Lucian Langa
 <lucilanga@7pot.org>,  "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
  rafael@kernel.org,  pavel@ucw.cz,  len.brown@intel.com,
  linux-pm@vger.kernel.org,  kexec@lists.infradead.org
References: <20250708000215.793090-1-sashal@kernel.org>
	<20250708000215.793090-6-sashal@kernel.org>
Date: Tue, 08 Jul 2025 14:13:42 -0500
In-Reply-To: <20250708000215.793090-6-sashal@kernel.org> (Sasha Levin's
	message of "Mon, 7 Jul 2025 20:02:13 -0400")
Message-ID: <87ikk2wl5l.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uZDlb-00EWoI-M0;;;mid=<87ikk2wl5l.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18eWuTXhpEEG+cAz+KqRLkQHqIlLXpyYLk=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sasha Levin <sashal@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 882 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 11 (1.3%), b_tie_ro: 10 (1.1%), parse: 1.76
	(0.2%), extract_message_metadata: 24 (2.8%), get_uri_detail_list: 6
	(0.6%), tests_pri_-2000: 8 (0.9%), tests_pri_-1000: 2.7 (0.3%),
	tests_pri_-950: 1.56 (0.2%), tests_pri_-900: 1.20 (0.1%),
	tests_pri_-90: 124 (14.0%), check_bayes: 112 (12.7%), b_tokenize: 20
	(2.3%), b_tok_get_all: 14 (1.6%), b_comp_prob: 6 (0.7%),
	b_tok_touch_all: 67 (7.6%), b_finish: 0.92 (0.1%), tests_pri_0: 691
	(78.3%), check_dkim_signature: 0.99 (0.1%), check_dkim_adsp: 3.6
	(0.4%), poll_dns_idle: 0.89 (0.1%), tests_pri_10: 2.2 (0.2%),
	tests_pri_500: 10 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rafael@kernel.org, rafael.j.wysocki@intel.com, lucilanga@7pot.org, nat@fardog.io, mario.limonciello@amd.com, stable@vger.kernel.org, patches@lists.linux.dev, sashal@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false


Wow!

Sasha I think an impersonator has gotten into your account, and is
just making nonsense up.

This reads like an impassioned plea to backport this change, from
someone who has actually dealt with it.

However reading the justification in detail is an exercise in reading
falehoods.

If this does not come from an impersonator then if this comes
from a human being, I recommend you have a talk with them.

If this comes from a machine I recommend take it out of commission
and rework it.

If I see this kind of baloney again I expect I will just auto-nack
it instead of reading it, as reading it appears to be a waste of
time.  It is a complete waste reading fiction in what little time I have
for kernel development.

Eric


Sasha Levin <sashal@kernel.org> writes:

> **YES**
>
> This commit should be backported to stable kernel trees for the
> following reasons:
>
> ## Critical Bug Fix for Real User Issues
>
> 1. **Fixes Actual Suspend Failures**: The commit addresses real-world
>    suspend failures under memory pressure on systems with AMD discrete
>    GPUs. The linked issues (ROCm/ROCK-Kernel-Driver#174 and
>    freedesktop.org/drm/amd#2362) indicate this affects actual users.

The links in the first paragraph are very distorted.  The links
from the actual change are:

 https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
 https://gitlab.freedesktop.org/drm/amd/-/issues/2362

Those completely distorted links make understanding this justification
much harder then necessary.


> 2. **Regression Fix**: This is effectively a regression fix. The PM
>    subsystem's early swap restriction prevents AMD GPU drivers from
>    properly evicting VRAM during their prepare() callbacks, which is a
>    requirement that has become more critical as GPU VRAM sizes have
>    increased.

That is a justification.   There is no evidence that a kernel change
made this worse.  Thus there is no evidence this is a regression fix.


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

Completely wrong.  

> 4. **Low Risk of Regression**: The change maintains the original intent
>    of preventing I/O during the critical suspend phase while allowing it
>    during device preparation. The swap restriction still happens before
>    `dpm_suspend()`, just after `dpm_prepare()`.

This is a fundamental change to a susbsystem that the subsystem
maintainer does not say is low risk.

> ## Follows Stable Rules
>
> 5. **Meets Stable Criteria**:
>    - Fixes a real bug that bothers people (suspend failures)
Addresses a real bug.

>    - Small change (moves function calls, doesn't introduce new logic)

The change is a large change in the logic.

>    - Obviously correct (allows drivers to use swap during their
>      designated preparation phase)

It obviously changes the behavior.  It is not at all obvious
the change is behavior is desirable for all callbacks, and in all
other scenarios.


>    - Already tested by users (Tested-by tags from affected users)
Yes it has Tested-by tags.

> ## Similar to Other Backported Commits
>
> 6. **Pattern Matches**: Looking at the similar commits provided, this
>    follows the same pattern as the AMD GPU eviction commits that were
>    backported. Those commits also addressed the same fundamental issue -
>    ensuring GPU VRAM can be properly evicted during suspend/hibernation.

Which commits that were backported?

> ## Critical Timing

Timing???  There is no race condition.

> 7. **Error Path Handling**: The commit properly handles error paths by
>    adding `pm_restore_gfp_mask()` calls in:
>    - `dpm_resume_end()` for normal resume
>    - `platform_recover()` error path in suspend.c
>    - `pm_restore_gfp_mask()` in kexec_core.c for kexec flows
>
> The commit is well-tested, addresses a real problem affecting users, and
> makes a minimal, obviously correct change to fix suspend failures on
> systems with discrete GPUs under memory pressure.

What evidence is there that this commit has been tested let alone
well-tested.

The entire line of reasoning is completely suspect.

Eric

