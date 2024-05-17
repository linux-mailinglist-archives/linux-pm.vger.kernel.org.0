Return-Path: <linux-pm+bounces-7954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D418C8C66
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 21:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F31C22AA6
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02D413F43D;
	Fri, 17 May 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD3YDl+t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591713E414;
	Fri, 17 May 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972445; cv=none; b=ENpfjET6et0HN8yOfCdAMySWPYopu7+A87LQdoydZHSfxdTTYriYpjDv5C2cd7yJFw/z/6175depQ6x3th3WcrT4ew0ljrLGTz0yVRfV+Xfeav3xWfZx9fmol8U/x500+VFBzf0NR3JYijY3nK6y6cVCzh5dP9wE7urF5npZVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972445; c=relaxed/simple;
	bh=ADnkPt6I97GHoVi8MXMcPa3bF85S6IMqkxYA1vtcreo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dh7yDNJp7utO3etS/+UlC6tfvgFa1BJORkfzVhPPsgw8YjMti7LgjvXmE+o6lXmyj7ldWaWjvnrmDYMikz96gitTpo/THKa5YnZ1lrZNZi7YQJsaM+53bZNCAIe6DFP4lvHcr9vqpQHGuF+oXUC0Iv/0M8u3fZRhQVp8bQirKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD3YDl+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C91BC4AF0B;
	Fri, 17 May 2024 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715972445;
	bh=ADnkPt6I97GHoVi8MXMcPa3bF85S6IMqkxYA1vtcreo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TD3YDl+tH9Qq1XpiA5U7xKZ86nvTAj0TK4kPw6UjQHrIix512K9cs2WG1BN+U6xcy
	 189qHR0xfnHAmg1cIqWn1OMR1733ImnBPScO2fLyivkAi+G64Xrjzwpy+O2U3/mNUp
	 I6qrVo+5e99XGkcVanOkKP7HL7BvJ9FO8YJ8crIRxGNl3eDFMD1IEIKxjyEMrSnUF1
	 qkDfSWV0XveBhLWc6To03E6W0PpivejQtWqzpx29t88fb5IsBRJz+W6WFFm1fQm7yO
	 eAcEwAKtGFW3zbFNsF3NyqpOo0PId7cimuv+S2JS42aTnO2flYKac1QNWy9yna+Zf8
	 65xAIziICuTzA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c992e5c821so299619b6e.2;
        Fri, 17 May 2024 12:00:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXODlLLWal98CsdD8gGya0EbkoVj3kH0KMHgAy59UP3dFsDJSj+Zjzvlt99ETWh1zUmCA0NMiV9PYg01VQ5qQ+IVJ0p1k63WJj8Oe0JKUqWdMdlhbrvfyPGMLf5Vhpg3zEK+fV1iNU=
X-Gm-Message-State: AOJu0Yy4YTulQI0cQ5f2O7mdd8LbLDscQEQ1/LxVMY7gHdi5ulw+mgb3
	LlJvD0OephGyZ1HnGVKrTp07f2Jm43wZv9F68FIkQ6zOXa8Qf/7xhCAedxEFOLP54pP4pSjImHG
	wZKjt3kaXrdpRnbooG8zI5WGmSPo=
X-Google-Smtp-Source: AGHT+IGkXcfQC2f4iOxP1rUvz4ub0Dh5q3DMeMbKL1l2x1rk8J0zs1a4GCCNtZVO/eZUGYa78kpjaYJ7/E2frxnJTV8=
X-Received: by 2002:a05:6808:148f:b0:3c8:4227:4fb0 with SMTP id
 5614622812f47-3c997056b60mr26057516b6e.2.1715972444363; Fri, 17 May 2024
 12:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87o79cjjik.fsf@kernel.org> <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
 <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local> <87h6f4jdrq.fsf@kernel.org>
 <878r0djxgc.fsf@kernel.org> <874jb0jzx5.fsf@kernel.org> <20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local>
 <87msoofjg1.fsf@kernel.org> <35086bb6-ee11-4ac6-b8ba-5fab20065b54@intel.com> <871q60ffnr.fsf@kernel.org>
In-Reply-To: <871q60ffnr.fsf@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 May 2024 21:00:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHoU7dHxzL5ryehZT7unZiapoiBzPo1d=wsffNGqcS7Q@mail.gmail.com>
Message-ID: <CAJZ5v0iHoU7dHxzL5ryehZT7unZiapoiBzPo1d=wsffNGqcS7Q@mail.gmail.com>
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

On Fri, May 17, 2024 at 8:37=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Dave Hansen <dave.hansen@intel.com> writes:
>
> > On 5/17/24 10:15, Kalle Valo wrote:
> >> Borislav Petkov <bp@alien8.de> writes:
> >>> There might be some #GP or so in the logs in case we've managed to f*=
ck
> >>> up microcode application which emulates that IBRS MSR bit and the
> >>> actual toggling or so when suspending...
> >> So the weird part is that when the bug happens (ie. suspend stalls) I
> >> can access the box normally using ssh and I don't see anything special
> >> in dmesg. Below is a full copy of dmesg output after the suspend
> >> stalled. Do note that I copied this dmesg before I updated microcode s=
o
> >> it will still show the old microcode version.
> >>
> >> Let me know if you need more info.
> >
> > Kalle, could you remind us what we're seeing here?  Does this show 30
> > working rtcwake tests followed by a failure at "rtcwake test 31" where
> > the system failed to suspend?
>
> Correct. So basically what I do is that I start the nuc box, ssh into it
> and run:
>
> sudo su
> for i in {1..400}; do echo "rtcwake test $i" > /dev/kmsg; rtcwake -m mem =
-s 10; sleep 10; done
>
> Here's the start of first loop:
>
> [   54.945105] rtcwake test 1
> [   55.162603] PM: suspend entry (deep)
> [   55.168875] Filesystems sync: 0.006 seconds
> [   55.182427] Freezing user space processes
> [   55.191498] Freezing user space processes completed (elapsed 0.008 sec=
onds)
> [   55.191711] OOM killer disabled.
> [   55.191805] Freezing remaining freezable tasks
> [   55.193507] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [   55.194056] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
> [   55.244962] e1000e: EEE TX LPI TIMER: 00000011
>
> Now I leave the box to run it's test. I come back later to see that the
> for loop has stalled and the box is not going into suspend gain. I ssh
> into the machine and see this in dmesg:
>
> [  449.061525] rtcwake test 31
> [  449.176854] PM: suspend entry (deep)
> [  449.179072] Filesystems sync: 0.002 seconds

This means that ksys_sync_helper() has run, so it blocks somewhere in
enter_state() around suspend_prepare().

Can please echo 1 (as root) to /sys/power/pm_debug_messages and retest?

This should allow us to see more in the log.

