Return-Path: <linux-pm+bounces-7953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B8B8C8C60
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 20:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542D31F23A75
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84713E032;
	Fri, 17 May 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Msol5c2e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BC13D8B7;
	Fri, 17 May 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972344; cv=none; b=gnTi8Bgk0XbIkhphw7EflmiRgHwBzzbEwABUVQ7RrL++vlTP5FMG7uClkRDF2EbGfxqQpHf1xO92aTzX0YuLIXUWX8bycAiMHnmBGCVxCQhxUWncjbsVU1mO5v33jPhwlPtBJ8VAnlXZGsf/Hsc/0NQNhkB3wil5iYtLeO/Iin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972344; c=relaxed/simple;
	bh=Yt8hIwKuHi9fG/9C0XoO9CSfPV78OHT2fV6rHiD0uYI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=n+TRPPv2uaZzjwIzfDSb+XhvkmNR0Izje86P+5342srqbd49W3bI2cLG8wfpA3O3O+XaR0KZRltck60Eh7J7ji3wuRb43hkWTFd9Lb2Al4xK621SQAipuiYDXXntke2wsGkK/5ooN8uP/HftFg3IwLL+HwBAM2lcqqmPHR1d+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Msol5c2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB882C2BD10;
	Fri, 17 May 2024 18:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715972344;
	bh=Yt8hIwKuHi9fG/9C0XoO9CSfPV78OHT2fV6rHiD0uYI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Msol5c2ebRtlfXBEfaKTuTEYF9et2HbfZPrSs7cuyhrUp6ZdcBfPnH6QTWFWxdBXX
	 RkRExgHpaW/S+elCa/4Etqz/2axIs9mSFQwNntRuEmLZHOGihOBs+vfriP5pwUs5J+
	 CsiHQYfUVWeUV3eEuZhCUaTGG0kXzM/Q1hG/IPlO92hXK/N9xKB+q5oLHVW2TlenD7
	 Fw8BdkRi1XMjdaVaqO007x5upNqb/RtykzuWuje/Fs6kAFcugeHnWL5uY7jJa6K4/1
	 j1qiC+4UYuGtFKbxo0ItOd6WQS+wnu2JSJeN7hiC9i2h6QWJhqgzuby39NoeHMuNBP
	 buFIehWpX0Hag==
From: Kalle Valo <kvalo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,  Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>,  Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  x86@kernel.org,  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org,
  regressions@lists.linux.dev,  Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
References: <87o79cjjik.fsf@kernel.org>
	<20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
	<20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
	<87h6f4jdrq.fsf@kernel.org> <878r0djxgc.fsf@kernel.org>
	<874jb0jzx5.fsf@kernel.org>
	<20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local>
	<87msoofjg1.fsf@kernel.org>
	<35086bb6-ee11-4ac6-b8ba-5fab20065b54@intel.com>
	<871q60ffnr.fsf@kernel.org>
	<7813dff5-b140-48c4-bc15-ed25c7a07591@intel.com>
Date: Fri, 17 May 2024 21:58:59 +0300
In-Reply-To: <7813dff5-b140-48c4-bc15-ed25c7a07591@intel.com> (Dave Hansen's
	message of "Fri, 17 May 2024 11:48:44 -0700")
Message-ID: <87eda0cljg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Hansen <dave.hansen@intel.com> writes:

> On 5/17/24 11:37, Kalle Valo wrote:
>> While writing this email I found another way to continue the suspend
>> after a stall: terminate rtcwake with CTRL-C in the ssh session running
>> the for loop. That explains why 'sudo shutdown -h now' makes the suspend
>> go forward, it most likely kills the stalled rtcwake process.
>
> Could we try and figure out what rtcwake is doing during its stall?  A
> couple of ideas:
>
> You could strace it to see if it's hung in the kernel:
>
> 	strace -o strace.log rtcwake ... <args here>
>
> You could look at its stack in /proc, like this:
>
> # cat /proc/`pidof sleep`/stack
> [<0>] hrtimer_nanosleep+0xb5/0x190
> [<0>] common_nsleep+0x44/0x50
> [<0>] __x64_sys_clock_nanosleep+0xcb/0x140
> [<0>] do_syscall_64+0x65/0x140
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> Or you can use sysrq:
>
> 	echo t > /proc/sysrq-trigger
>
> to get *all* tasks' stacks dumped out to dmesg.
>
> I'd probably do all three in that order.
>
> Getting a function-graph trace of rtcwake during the stall would also be
> nice, but that's a lot of data so let's try the easier things first.

I can do all that but most probably not this week. Luckily it's quite
easy to reproduce the bug, one time I even saw it in the first iteration
and usually within 15 minutes or so.

And do let me know if there's anything else I should try.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

