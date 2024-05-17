Return-Path: <linux-pm+bounces-7955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B63F8C8C98
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9461F22A1F
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 19:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736C313E3E0;
	Fri, 17 May 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1SYVzmP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477FD6A005;
	Fri, 17 May 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972933; cv=none; b=QQ/i0pRgj0D7kWG+RRZYaomOdeGHizHE9aRCxVXU8jVWBwY0+iiSMfOYF2TaxseAIfbJ6LbOKKBy9ZIZgiNaeU6yhf3xDeaR8ABYlp+SlgYIhWRNEON58eTqxuZ5bzpQ0VbYj1KuCmeaqMCe1YNv0l3lLiKgL3UGb8Sy2M56m3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972933; c=relaxed/simple;
	bh=uWb+bOSKwQLJn2Jz1qSkQVUr71jyyOc0xxanYUgAxrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFJA9BwKNdljJgKRbFqQkPAp8A2gWEN8Ot7/7faFXPxRlrhUfGRd/SzfoOhzqYIdeY+wqpCxZp396KbcZLafpMvuTnWu/PBmwLB9iBA0aoz81IxxDj1SGBbe0+FYJSKQDGg9TWXPV4g38gH8uZDuZc8QBnEE5Ixc6SdJnrbzmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1SYVzmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B611DC32789;
	Fri, 17 May 2024 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715972932;
	bh=uWb+bOSKwQLJn2Jz1qSkQVUr71jyyOc0xxanYUgAxrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B1SYVzmPVa95dii8iiNGtWbLnTRYHsNyGY7TVnPycTDXAk3DJBlQppLj44zNGyc+U
	 GhhVRlWsBkN8LPYPURcukRIiJAahNyMthuUXayDEb4WqQRzn0M04aWAU5ImLEZuq/K
	 pwmGci4Y122Pc+Vo2PEp72j/FNFr4gAXtGLRV4n2lDjvTvpejpG1jMmtM2OS5IjlYS
	 7fT4VlfMOBYtTk4i1UdHsRho9A6uz3Zkz/dDt30lXty9sGoz0Sm4qf5BrNy6Vf+A5u
	 Y9Q+/QffY2SZ6DizYsyRgYveRTXtsmY0xVTm7gdTXty/Y+fo6NIVRZtWIlAnDSc4Iz
	 2EKG2LaWZVelg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ac4470de3bso67475eaf.0;
        Fri, 17 May 2024 12:08:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4mENtBuqDt2koXhnTscw/9Ji7dJk3uMGwi5eIRNIQKc4Gq6k41pPiLwfzxQgQ7GkwpNJDBq1iDrFlGn/vCLkRJ+uaht5LkSta9Etpf5BAZn7pedMPM6WIMsbLFfyMqJUX7BSfM20=
X-Gm-Message-State: AOJu0YxZW6/o71188Y90/ok8IA6W/ltN0AbcGvq0JI6Se/Bn54q/Qvwa
	6rknc+bwk2JJ0CtGoyTixOwH1TpQOMSOcn+wOsG/U1MA/NKRYH//TeAjZdbf3yupSEUZBArMADy
	FECabuVYxXLOWRhi+/2i1URpgrp8=
X-Google-Smtp-Source: AGHT+IG+4u8KxAGrrysp6nvFWeu9dDnGpa/wsXf20CS/0o0U1GC6cHp5W7yqKNQ3oZ2MRrdPXCbVMkds2yJkFSkH1do=
X-Received: by 2002:a05:6820:1f16:b0:5b2:7d9f:e708 with SMTP id
 006d021491bc7-5b28193e476mr24576900eaf.1.1715972931992; Fri, 17 May 2024
 12:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87o79cjjik.fsf@kernel.org> <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
 <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local> <87h6f4jdrq.fsf@kernel.org>
 <878r0djxgc.fsf@kernel.org> <874jb0jzx5.fsf@kernel.org> <20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local>
 <87msoofjg1.fsf@kernel.org> <35086bb6-ee11-4ac6-b8ba-5fab20065b54@intel.com>
 <871q60ffnr.fsf@kernel.org> <7813dff5-b140-48c4-bc15-ed25c7a07591@intel.com> <87eda0cljg.fsf@kernel.org>
In-Reply-To: <87eda0cljg.fsf@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 May 2024 21:08:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJnXPMq5cjEs=yPrSU1hpJ3H3cMce8fOGQCripYfbeGQ@mail.gmail.com>
Message-ID: <CAJZ5v0hJnXPMq5cjEs=yPrSU1hpJ3H3cMce8fOGQCripYfbeGQ@mail.gmail.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
To: Kalle Valo <kvalo@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 8:59=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Dave Hansen <dave.hansen@intel.com> writes:
>
> > On 5/17/24 11:37, Kalle Valo wrote:
> >> While writing this email I found another way to continue the suspend
> >> after a stall: terminate rtcwake with CTRL-C in the ssh session runnin=
g
> >> the for loop. That explains why 'sudo shutdown -h now' makes the suspe=
nd
> >> go forward, it most likely kills the stalled rtcwake process.
> >
> > Could we try and figure out what rtcwake is doing during its stall?  A
> > couple of ideas:
> >
> > You could strace it to see if it's hung in the kernel:
> >
> >       strace -o strace.log rtcwake ... <args here>
> >
> > You could look at its stack in /proc, like this:
> >
> > # cat /proc/`pidof sleep`/stack
> > [<0>] hrtimer_nanosleep+0xb5/0x190
> > [<0>] common_nsleep+0x44/0x50
> > [<0>] __x64_sys_clock_nanosleep+0xcb/0x140
> > [<0>] do_syscall_64+0x65/0x140
> > [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > Or you can use sysrq:
> >
> >       echo t > /proc/sysrq-trigger
> >
> > to get *all* tasks' stacks dumped out to dmesg.
> >
> > I'd probably do all three in that order.
> >
> > Getting a function-graph trace of rtcwake during the stall would also b=
e
> > nice, but that's a lot of data so let's try the easier things first.
>
> I can do all that but most probably not this week. Luckily it's quite
> easy to reproduce the bug, one time I even saw it in the first iteration
> and usually within 15 minutes or so.
>
> And do let me know if there's anything else I should try.

My somewhat educated guess is that pm_notifier_call_chain_robust()
blocks for you, so you can add debug printk()s around the call to this
in suspend_prepare().

It is also possible that pm_prepare_console() does something weird and
your description of the problem indicates that it doesn't get to user
space freezing.

