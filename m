Return-Path: <linux-pm+bounces-43177-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGKRL4kenml+TgQAu9opvQ
	(envelope-from <linux-pm+bounces-43177-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 22:56:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C3818CF96
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEA543028EA9
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 21:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01A342CBB;
	Tue, 24 Feb 2026 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUWkWT8O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB066342CA7;
	Tue, 24 Feb 2026 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970163; cv=none; b=FqRXrVo5TuXciMtr4QdIyuWv9da6+f9sQAkc1M1GudlY2A8Pao1DXRkRIPUKuCASRI3j4I50EkkTcuT6m+3a1hWPGT3z4ire1N/MJygzxEIyIlKwLl0N6P/GNQfW0vgQ3GUlotyqRJAOy1P5iJ5rfxlxjRXJ710FDoU5T5smfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970163; c=relaxed/simple;
	bh=FaqHwDX2ukqf1Wcm2BuGyMLZ+j5NPr4vWFjOFI2JMUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HrNry4caa/HOdoqzqjVCls7B4rtbiCHfk04qqSAypvHhlfOXjG7pJTAWe/PRmjgJK5mS/P+RenOI0guGVSKMvufy6Ss+6k0p8J8O1F9yiDJyrJIEgxHQ+2jGOcXpNp2mZQc84LTvKcYrm8ws+sApwUTv8SfaHzxU33P5/H6JegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUWkWT8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A68C116D0;
	Tue, 24 Feb 2026 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771970163;
	bh=FaqHwDX2ukqf1Wcm2BuGyMLZ+j5NPr4vWFjOFI2JMUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cUWkWT8OEVQDB9FyszmsxFwF6OIEGQkej/lK+dwmk+0OI55VvnMKD2skELJARHqe8
	 16tHqH0IM3nIXCQ5t88bV+FfPsXO3aboL2XPNBK4mWUBgY4biX7jzcAkdLc1jNPlMd
	 DdPaDf1BsR18/hEjNAzMM7HLXjjNJp5IqTZV01N8FCsFVOQCDwZGsLRCKTvGcEfISG
	 ElL3OUTre6WK16nTpShOSrhPrDXnfHP/5GwDckcyp2Yzq9EsyRJHX7DYKW+JD29xFc
	 XCCILFJmj11O32qw1DbPJ/tg0wx9u4juqnoD/0gx6opPSOoq6EQqDD+Q4Es4z/XU/t
	 ua/B9LPA/+Dtg==
From: Thomas Gleixner <tglx@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle
 <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Linux
 PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH RFC] tick/sched: Prevent pointless NOHZ transitions
In-Reply-To: <5987061.DvuYhMxLoT@rafael.j.wysocki>
References: <875x7mv8wd.ffs@tglx>
 <ca2b5ede-1922-4540-bc44-a7ff6bec406f@arm.com> <87zf4yt90t.ffs@tglx>
 <5987061.DvuYhMxLoT@rafael.j.wysocki>
Date: Tue, 24 Feb 2026 22:55:59 +0100
Message-ID: <87jyw1u7ps.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-43177-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68C3818CF96
X-Rspamd-Action: no action

On Tue, Feb 24 2026 at 22:31, Rafael J. Wysocki wrote:
> On Tuesday, February 24, 2026 5:13:06 PM CET Thomas Gleixner wrote:
>> So either the governor/driver muck provides some sensible default
>> implementation or this has to go into into default_idle_call().
>> 
>> Oh well...
>
> It looks like the issue is cause by the tick_nohz_idle_stop_tick() called right
> before invoking default_idle_call().
>
> After the recent changes mentioned above, cpuidle_select() will never stop the
> tick when there's only one idle state in the cpuidle driver, so it would be
> consistent to make the default case behave analogously.  The default idle state
> is never a deep one AFAICS.
>
> So maybe something like the below?
>
> ---
>  kernel/sched/idle.c |    2 --
>  1 file changed, 2 deletions(-)
>
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -186,8 +186,6 @@ static void cpuidle_idle_call(void)
>  	}
>  
>  	if (cpuidle_not_available(drv, dev)) {
> -		tick_nohz_idle_stop_tick();
> -
>  		default_idle_call();
>  		goto exit_idle;
>  	}

Which prevents VMs or other systems which do not have an idle driver to
stop the tick at all. That's just obviously wrong, no?

Thanks,

        tglx



