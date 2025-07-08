Return-Path: <linux-pm+bounces-30414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40202AFDB1B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 00:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246921C4072A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 22:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638C425A2AB;
	Tue,  8 Jul 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N62kqzG3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755225334B;
	Tue,  8 Jul 2025 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013573; cv=none; b=Btnim/asoaJuTUaUJHHIJFHTdR7JbGZjCS+lGsf2x+jmg1khTQHYlVucWBC4YchVn23EufVIZj/9ajWIkiPoGQ9HUk5KA6B9d11oXkUHTJRg1YZsTz7PiYoBlNS+bFV6ooXpN1UwBYKyFSVb/elVowcqqs9xyP/j1RHTM3tSZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013573; c=relaxed/simple;
	bh=kYrg6N+iGJMB3IncQTR1f8OwIscAnjjBNP5f3b7e5/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZVvVFDWxKuG+UbbKU10Jw28DkCAfxdHwWfqqKF1Dw9PCIcJCX1dYsNgzRoe8MeXYqLmgpm+X/LZe4pIPEuTweAJdKfBDQ23WYOMPPjYHhmV8XCx+gncTUfon3hOuhjJEfn71pkxRniRrqDc594uzfzf/puRHfz9HmiiSOH0JJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N62kqzG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86910C4CEED;
	Tue,  8 Jul 2025 22:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752013572;
	bh=kYrg6N+iGJMB3IncQTR1f8OwIscAnjjBNP5f3b7e5/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N62kqzG3NbPhzfYpzEbe0IPQjFyIGvaSTDFEhbBD/JDkeVFMVEjoJFEp77oFrsjVE
	 rCNBR1xWAVvYmjnunsZQ8nClEVBtz+wJ5kAT6OWlXddQMjTXXwTLw4KRI6y92gVUP7
	 ZjFfmpU/0LFOlrGYlGtWWNxcluXoc1wwbUe0NTz//PhGhy/yaBo42EmmHT+pjs2gYa
	 tuvp7weNCCOehJsFmKSzTTH+9vRbk7VshhBMmBLunmjvWt2FkPaDZWDcq0JBFHojeD
	 FcJk1ixVy3/e4C/04RV4dGSJiO2W3K2wUacnkhKTgp+URmsU/twlmNDg+6Cqp2t6bk
	 VrOGmiJSSzdPQ==
Date: Tue, 8 Jul 2025 18:26:08 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2bAMGrDDSvOhbl@lappy>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>

On Tue, Jul 08, 2025 at 04:46:19PM -0500, Eric W. Biederman wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
>> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
>>>
>>>Wow!
>>>
>>>Sasha I think an impersonator has gotten into your account, and
>>>is just making nonsense up.
>>
>> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/
>
>It is nice it is giving explanations for it's backporting decisions.
>
>It would be nicer if those explanations were clearly marked as
>coming from a non-human agent, and did not read like a human being
>impatient for a patch to be backported.

Thats a fair point. I'll add "LLM Analysis:" before the explanation to
future patches.

>Further the machine given explanations were clearly wrong.  Do you have
>plans to do anything about that?  Using very incorrect justifications
>for backporting patches is scary.

Just like in the past 8 years where AUTOSEL ran without any explanation
whatsoever, the patches are manually reviewed and tested prior to being
included in the stable tree.

I don't make a point to go back and correct the justification, it's
there more to give some idea as to why this patch was marked for
review and may be completely bogus (in which case I'll drop the patch).

For that matter, I'd often look at the explanation only if I don't fully
understand why a certain patch was selected. Most often I just use it as
a "Yes/No" signal.

In this instance I honestly haven't read the LLM explanation. I agree
with you that the explanation is flawed, but the patch clearly fixes a
problem:

	"On AMD dGPUs this can lead to failed suspends under memory
	pressure situations as all VRAM must be evicted to system memory
	or swap."

So it was included in the AUTOSEL patchset.

Do you have an objection to this patch being included in -stable? So far
your concerns were about the LLM explanation rather than actual patch.

>I still highly recommend that you get your tool to not randomly
>cut out bits from links it references, making them unfollowable.

Good point. I'm not really sure what messes up the line wraps. I'll take
a look.

>>>At best all of this appears to be an effort to get someone else to
>>>do necessary thinking for you.  As my time for kernel work is very
>>>limited I expect I will auto-nack any such future attempts to outsource
>>>someone else's thinking on me.
>>
>> I've gone ahead and added you to the list of people who AUTOSEL will
>> skip, so no need to worry about wasting your time here.
>
>Thank you for that.
>
>I assume going forward that AUTOSEL will not consider any patches
>involving the core kernel and the user/kernel ABI going forward.  The
>areas I have been involved with over the years, and for which my review
>might be interesting.

The filter is based on authorship and SoBs. Individual maintainers of a
subsystem can elect to have their entire subsystem added to the ignore
list.

-- 
Thanks,
Sasha

