Return-Path: <linux-pm+bounces-7941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE798C8ACB
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22724280E72
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441E13DDB6;
	Fri, 17 May 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5mx1wEx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE413DDB0;
	Fri, 17 May 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966395; cv=none; b=jeisjv1fCHb8h+GtGMUDNHRuEa2d+DAbsdqHrYmQMcyYJ8W52i9qGeY8EON66Uihi0vwrhKNTyLYxK5tt8rS6FBNS7pjYiI82I9A+OtEAt2CLh7ORJobaXoSjccx99kz+EAsYLRgMMxr45p9/2WWfnGT3fXXDbeGlpUcUzz6TVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966395; c=relaxed/simple;
	bh=JPiqBtueOqPjvHwerNvEOHviFOz8JLhoUGBcqfWBC3c=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DdVUgAjUM/slswDq5ipqvD68g9PPm8wuXBaOeidd81Ag1RhL85dK6jsuEs3MdOosX7xYB+jMGxYyeoxerwZlsErbkqe79d7SjZ3vF5ktluAip5+v6i3PPTj/1CL36Ka3UsaNm/lvXhdWeQWc3Uoh7R6R4FPcaFJQEBhLwlhD5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5mx1wEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7E4C2BD10;
	Fri, 17 May 2024 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715966394;
	bh=JPiqBtueOqPjvHwerNvEOHviFOz8JLhoUGBcqfWBC3c=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=e5mx1wEx3q4W4Dg2PF0Vy+sO5zWRFTALnTj034RxWk6s4Z26oID48/LP8xbWhSQCa
	 wj48FqdekdqhkaxYk4i1tYy2CZRK7kqpP0+n7UoL50xZ3gp7D+BdcyHnG+e1/NrI0D
	 ltPqbUK6PKbpqRJ+nX9gEisYRCuUDeELQYMMn86/GTe8raOEHlg5WA6q8tmwkv8hL0
	 JRveOPRg8sqUnKapbaT1atylRRx5JnmkC9vB+Ci6X9fPaPMNXj2aEWGZ6qnxjz7pIj
	 mkIPTC4zLhZ4R4ye5cddGJHL6Mz7dvKQa20QeuJJXJo6cQJvPF18ESy6Ko3MezgJCB
	 LbJCIu+4vAbfQ==
From: Kalle Valo <kvalo@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>,  Borislav Petkov <bp@alien8.de>,
  Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Dave Hansen <dave.hansen@linux.intel.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  x86@kernel.org,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  regressions@lists.linux.dev,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  Daniel Sneddon
 <daniel.sneddon@linux.intel.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
References: <87o79cjjik.fsf@kernel.org>
	<20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
	<20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
	<87h6f4jdrq.fsf@kernel.org> <878r0djxgc.fsf@kernel.org>
	<874jb0jzx5.fsf@kernel.org>
	<feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
	<20240515072231.z3wlyoblyc34ldmr@desk>
Date: Fri, 17 May 2024 20:19:49 +0300
In-Reply-To: <20240515072231.z3wlyoblyc34ldmr@desk> (Pawan Gupta's message of
	"Wed, 15 May 2024 00:22:31 -0700")
Message-ID: <87ikzcfj9m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pawan Gupta <pawan.kumar.gupta@linux.intel.com> writes:

> On Tue, May 14, 2024 at 09:10:07AM -0700, Dave Hansen wrote:
>
>> On 5/14/24 06:17, Kalle Valo wrote:
>> > The kernel we use in our ath11k testing has almost all kernel debug
>> > features enabled so I decided disable all of them, which unsurprisingly
>> > also fixed my suspend problems. So maybe this is something which happens
>> > only when MITIGATION_IBRS_ENTRY and some debug option from 'Kernel
>> > hacking' are both enabled?
>> 
>> I had my money on DEBUG_ENTRY, but it doesn't look like you ever had it
>> enabled.
>> 
>> I've got basically two theories:
>> 
>> One, the IBRS value is getting mucked up somewhere, either that %r15
>> value is getting stepped on or the per-cpu value is corrupt and the
>> WRMSR #GP's, causing the hang.
>> 
>> Two, IBRS_{ENTER,EXIT} is called in a "wrong" context somewhere.  Either
>> it is clobbering something it shouldn't or it is assuming something is
>> in place that is not (like a valid stack).
>> 
>> But the whole "'sudo shutdown -h now' then suspend somehow immediately
>> unstalls" thing is really perplexing.  I hope Pawan has some ideas.
>
> Nothing promising yet. I now have the system with the same model, but the
> system is only booting in recovery mode with the config attached with the
> report.
>
> Kalle, I wanted to try reverting the below commits:
>
> aa1567a7e644 ("intel_idle: Add ibrs_off module parameter to force-disable IBRS")
> 1e4d3001f59f ("x86/entry: Harden return-to-user")
> c516213726fb ("x86/entry: Optimize common_interrupt_return()")
>
> ... but I haven't reproduced the issue yet.

I can try to revert those but didn't manage to do it yet.

> FYI, cmdline "spectre_v2=off" should have the same effect as
> CONFIG_IBRS_ENTRY=n.

Confirmed, I don't see the bug with "spectre_v2=off" and the box
suspended succesfully 400 times.

> Other interesting thing to try is cmdline "dis_ucode_ldr".

This didn't help. I tried twice, the first time it failed after 11
suspend loops and the second time after 34 loops.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

