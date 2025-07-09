Return-Path: <linux-pm+bounces-30500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CE4AFEEF5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 18:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8685C0AAD
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E821FF42;
	Wed,  9 Jul 2025 16:42:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB38206F2A;
	Wed,  9 Jul 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079330; cv=none; b=LVcDw+WviQjbEP7djGac9csN0e5kCxaf4w7wknBvx3oTvWttLXp2+y1njAnTaDEnmNlDudhv51Ct34thBw6RN29k9E8JZ33h91gA8epu376M8ODzNOtlQLWPLcTpLsEhPt0GFvKGOMmVc2E0AvOdIGhCZrSqUE3S9DzoKuuZ4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079330; c=relaxed/simple;
	bh=pwZh3BoCjDCOWjFcw83VsmJa0G1VKuWp9z8oOTPBC8c=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=tquHGQQRuK7i0x110pZm5qEp6dg50Y04sy5B817ofGDRCI+vjEI7WnIk3UTN59uXPjw4tVbfBD2tIV2AL1tycTXrFoEWjp9O8Tj5L6yCLMdluDCQxcOSUoMDFe3qo6YZIbClZ0IuP+ErzynAlLwX/loFViVgAejF6MtZrzn0oTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:55620)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZXap-00GDB9-ED; Wed, 09 Jul 2025 10:24:23 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:58876 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZXao-00G7I3-2H; Wed, 09 Jul 2025 10:24:23 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev,  stable@vger.kernel.org,  Mario Limonciello
 <mario.limonciello@amd.com>,  Nat Wittstock <nat@fardog.io>,  Lucian Langa
 <lucilanga@7pot.org>,  "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
  rafael@kernel.org,  pavel@ucw.cz,  len.brown@intel.com,
  linux-pm@vger.kernel.org,  kexec@lists.infradead.org
References: <20250708000215.793090-1-sashal@kernel.org>
	<20250708000215.793090-6-sashal@kernel.org>
	<87ms9esclp.fsf@email.froward.int.ebiederm.org>
	<aG2AcbhWmFwaHT6C@lappy>
	<87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
	<aG2bAMGrDDSvOhbl@lappy>
Date: Wed, 09 Jul 2025 11:23:36 -0500
In-Reply-To: <aG2bAMGrDDSvOhbl@lappy> (Sasha Levin's message of "Tue, 8 Jul
	2025 18:26:08 -0400")
Message-ID: <87ms9dpc3b.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uZXao-00G7I3-2H;;;mid=<87ms9dpc3b.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18thKjXD4GyCYLuzUNwo9PSKH5r56NcL1w=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4946]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sasha Levin <sashal@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 762 ms - load_scoreonly_sql: 0.02 (0.0%),
	signal_user_changed: 4.1 (0.5%), b_tie_ro: 2.8 (0.4%), parse: 1.32
	(0.2%), extract_message_metadata: 18 (2.3%), get_uri_detail_list: 5
	(0.7%), tests_pri_-2000: 8 (1.0%), tests_pri_-1000: 2.0 (0.3%),
	tests_pri_-950: 0.95 (0.1%), tests_pri_-900: 0.80 (0.1%),
	tests_pri_-90: 112 (14.7%), check_bayes: 109 (14.3%), b_tokenize: 9
	(1.2%), b_tok_get_all: 13 (1.6%), b_comp_prob: 4.3 (0.6%),
	b_tok_touch_all: 80 (10.5%), b_finish: 0.79 (0.1%), tests_pri_0: 604
	(79.3%), check_dkim_signature: 0.42 (0.1%), check_dkim_adsp: 3.1
	(0.4%), poll_dns_idle: 0.96 (0.1%), tests_pri_10: 1.74 (0.2%),
	tests_pri_500: 6 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rafael@kernel.org, rafael.j.wysocki@intel.com, lucilanga@7pot.org, nat@fardog.io, mario.limonciello@amd.com, stable@vger.kernel.org, patches@lists.linux.dev, sashal@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Sasha Levin <sashal@kernel.org> writes:

> On Tue, Jul 08, 2025 at 04:46:19PM -0500, Eric W. Biederman wrote:
>>Sasha Levin <sashal@kernel.org> writes:
>>
>>> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
>>>>
>>>>Wow!
>>>>
>>>>Sasha I think an impersonator has gotten into your account, and
>>>>is just making nonsense up.
>>>
>>> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/
>>
>>It is nice it is giving explanations for it's backporting decisions.
>>
>>It would be nicer if those explanations were clearly marked as
>>coming from a non-human agent, and did not read like a human being
>>impatient for a patch to be backported.
>
> Thats a fair point. I'll add "LLM Analysis:" before the explanation to
> future patches.
>
>>Further the machine given explanations were clearly wrong.  Do you have
>>plans to do anything about that?  Using very incorrect justifications
>>for backporting patches is scary.
>
> Just like in the past 8 years where AUTOSEL ran without any explanation
> whatsoever, the patches are manually reviewed and tested prior to being
> included in the stable tree.

I believe there is some testing done.  However for a lot of what I see
go by I would be strongly surprised if there is actually much manual
review.

I expect there is a lot of the changes are simply ignored after a quick
glance because people don't know what is going on, or they are of too
little consequence to spend time on.

> I don't make a point to go back and correct the justification, it's
> there more to give some idea as to why this patch was marked for
> review and may be completely bogus (in which case I'll drop the patch).
>
> For that matter, I'd often look at the explanation only if I don't fully
> understand why a certain patch was selected. Most often I just use it as
> a "Yes/No" signal.
>
> In this instance I honestly haven't read the LLM explanation. I agree
> with you that the explanation is flawed, but the patch clearly fixes a
> problem:
>
> 	"On AMD dGPUs this can lead to failed suspends under memory
> 	pressure situations as all VRAM must be evicted to system memory
> 	or swap."
>
> So it was included in the AUTOSEL patchset.


> Do you have an objection to this patch being included in -stable? So far
> your concerns were about the LLM explanation rather than actual patch.

Several objections.
- The explanation was clearly bogus.
- The maintainer takes alarm.
- The patch while small, is not simple and not obviously correct.
- The patch has not been thoroughly tested.

I object because the code does not appear to have been well tested
outside of the realm of fixing the issue.

There is no indication that the kexec code path has ever been exercised.

So this appears to be one of those changes that was merged under
the banner of "Let's see if this causes a regression".

To the original authors.  I would have appreciated it being a little
more clearly called out in the change description that this came in
under "Let's see if this causes a regression".

Such changes should not be backported automatically.  They should be
backported with care after the have seen much more usage/testing of
the kernel they were merged into.  Probably after a kernel release or
so.  This is something that can take some actual judgment to decide,
when a backport is reasonable.

>>I still highly recommend that you get your tool to not randomly
>>cut out bits from links it references, making them unfollowable.
>
> Good point. I'm not really sure what messes up the line wraps. I'll take
> a look.

It was a bit more than line wraps.  At first glance I thought
it was just removing a prefix from the links.  On second glance
it appears it is completely making a hash of links:

The links in question:
https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
https://gitlab.freedesktop.org/drm/amd/-/issues/2362

The unusable restatement of those links:
ROCm/ROCK-Kernel-Driver#174
freedesktop.org/drm/amd#2362

Short of knowing to look up into the patch to find the links,
those references are completely junk.

>>>>At best all of this appears to be an effort to get someone else to
>>>>do necessary thinking for you.  As my time for kernel work is very
>>>>limited I expect I will auto-nack any such future attempts to outsource
>>>>someone else's thinking on me.
>>>
>>> I've gone ahead and added you to the list of people who AUTOSEL will
>>> skip, so no need to worry about wasting your time here.
>>
>>Thank you for that.
>>
>>I assume going forward that AUTOSEL will not consider any patches
>>involving the core kernel and the user/kernel ABI going forward.  The
>>areas I have been involved with over the years, and for which my review
>>might be interesting.
>
> The filter is based on authorship and SoBs. Individual maintainers of a
> subsystem can elect to have their entire subsystem added to the ignore
> list.

As I said.  I expect that the process looking at the output of
get_maintainers.pl and ignoring a change when my name is returned
will result in effectively the entire core kernel and the user/kernel
ABI not being eligible for backport.

I bring this up because I was not an author and I did not have any
signed-off-by's on the change in question, and yet I was still selected
for the review.

Eric


