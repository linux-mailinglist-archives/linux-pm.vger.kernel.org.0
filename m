Return-Path: <linux-pm+bounces-7951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D58C8C4B
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 20:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B10E1C2136A
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0135712F398;
	Fri, 17 May 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgBZylgN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9D433A6;
	Fri, 17 May 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715971069; cv=none; b=iGaX0C5I/qXzFg6RRuyO7rRm7sJinKAeyOynYKvF58DHzmPE+dJ6hXmkvTMeaOrIFl1/2RlqMNaw+qEKBbyGqRXKg12EfP3dOvdQOaMG2BO1plyl+onAPcChVI9W4Dm+jF5/G9AtWuRp4ShyQxUtNFfsrSf3N4gszIX7q06NUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715971069; c=relaxed/simple;
	bh=cDl+GeQ2P3waQU2VJqEU9acfUxXsJOs+MhfK/QhHSyc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=f9xLbj2j81Z6UopdyWEzUKzb/B3MnyIxcgZn0IZoxSfTB6RIW9CTpHMXrb4ZOxQx/vT1G7yj4MuwJp4hEstwO+ZBHy8MfksY1kfYu0JecwpjZHWkHu6B2JMAcWe/H8MD8scLLnM7SGdD4jSXRNWEYaab5t273jbXY5xvyJ0zAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgBZylgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DDEC2BD10;
	Fri, 17 May 2024 18:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715971069;
	bh=cDl+GeQ2P3waQU2VJqEU9acfUxXsJOs+MhfK/QhHSyc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OgBZylgN9zqWkDZhPWI5AGWnFINa0FhFeM1ReY7pspp2aFMbHSdYte6a4q0Uty5x7
	 uZ20F6/dFcD5zgGiknU07ckIywVb82jG0Y4vXFtnq11+JlMYPi3tDue5Alk/9ZTfS4
	 my2ejW1MdeoxqIVQYMZTfIUCBUqUL0YlVIl6v6RTgDpc5vPjxbojUXk0yUu1kRbhFr
	 qsYV/Z4iBtcjSpwS1zpjhtBaMOsQZ9zWe00Af1TSvV4slW4ZuwGgI8D9o21PJATFD4
	 sB/ar8sL/Lp+/kCuMLH/1Wci3pQpyv01CC6ZYknCXCoPhOBT7bxFKtKtdcM/eECxUp
	 4bZBEtphTVVbA==
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
Date: Fri, 17 May 2024 21:37:44 +0300
In-Reply-To: <35086bb6-ee11-4ac6-b8ba-5fab20065b54@intel.com> (Dave Hansen's
	message of "Fri, 17 May 2024 10:22:32 -0700")
Message-ID: <871q60ffnr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Hansen <dave.hansen@intel.com> writes:

> On 5/17/24 10:15, Kalle Valo wrote:
>> Borislav Petkov <bp@alien8.de> writes:
>>> There might be some #GP or so in the logs in case we've managed to f*ck
>>> up microcode application which emulates that IBRS MSR bit and the
>>> actual toggling or so when suspending...
>> So the weird part is that when the bug happens (ie. suspend stalls) I
>> can access the box normally using ssh and I don't see anything special
>> in dmesg. Below is a full copy of dmesg output after the suspend
>> stalled. Do note that I copied this dmesg before I updated microcode so
>> it will still show the old microcode version.
>> 
>> Let me know if you need more info.
>
> Kalle, could you remind us what we're seeing here?  Does this show 30
> working rtcwake tests followed by a failure at "rtcwake test 31" where
> the system failed to suspend?

Correct. So basically what I do is that I start the nuc box, ssh into it
and run:

sudo su
for i in {1..400}; do echo "rtcwake test $i" > /dev/kmsg; rtcwake -m mem -s 10; sleep 10; done

Here's the start of first loop:

[   54.945105] rtcwake test 1
[   55.162603] PM: suspend entry (deep)
[   55.168875] Filesystems sync: 0.006 seconds
[   55.182427] Freezing user space processes
[   55.191498] Freezing user space processes completed (elapsed 0.008 seconds)
[   55.191711] OOM killer disabled.
[   55.191805] Freezing remaining freezable tasks
[   55.193507] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   55.194056] printk: Suspending console(s) (use no_console_suspend to debug)
[   55.244962] e1000e: EEE TX LPI TIMER: 00000011

Now I leave the box to run it's test. I come back later to see that the
for loop has stalled and the box is not going into suspend gain. I ssh
into the machine and see this in dmesg:

[  449.061525] rtcwake test 31
[  449.176854] PM: suspend entry (deep)
[  449.179072] Filesystems sync: 0.002 seconds
[  632.961545] loop0: detected capacity change from 0 to 8
[  637.003835] gpu-manager (6735) used greatest stack depth: 23808 bytes left
[  738.799026] kworker/dying (87) used greatest stack depth: 23488 bytes left
[  932.951032] loop0: detected capacity change from 0 to 8
[ 1232.962610] loop0: detected capacity change from 0 to 8

The system tried go into suspend but after the "Filesystems sync:"
message nothing happened for 10 minutes. I assume loop0 messages are
from some Ubuntu daemon, maybe snapd or similar. I have seen them
always, they are not specific to this issue.

And now comes the really strange part: if I run  'shutdown -h now' the
suspend continues apparently normally. Afterwards I checked from
/var/log/kern.log and didn't see any errors:

May 17 13:34:38 nuc2 kernel: [  449.176854] PM: suspend entry (deep)
May 17 13:34:38 nuc2 kernel: [  449.179072] Filesystems sync: 0.002 seconds
May 17 13:37:42 nuc2 kernel: [  632.961545] loop0: detected capacity change from 0 to 8
May 17 13:37:46 nuc2 kernel: [  637.003835] gpu-manager (6735) used greatest stack depth: 23808 bytes left
May 17 13:39:28 nuc2 kernel: [  738.799026] kworker/dying (87) used greatest stack depth: 23488 bytes left
May 17 13:42:42 nuc2 kernel: [  932.951032] loop0: detected capacity change from 0 to 8
May 17 13:47:42 nuc2 kernel: [ 1232.962610] loop0: detected capacity change from 0 to 8
May 17 13:52:45 nuc2 kernel: [ 1527.307800] Freezing user space processes
May 17 13:52:45 nuc2 kernel: [ 1527.334585] Freezing user space processes completed (elapsed 0.024 seconds)
May 17 13:52:45 nuc2 kernel: [ 1527.336094] OOM killer disabled.
May 17 13:52:45 nuc2 kernel: [ 1527.337562] Freezing remaining freezable tasks
May 17 13:52:45 nuc2 kernel: [ 1527.340324] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
May 17 13:52:45 nuc2 kernel: [ 1527.342596] printk: Suspending console(s) (use no_console_suspend to debug)
May 17 13:52:45 nuc2 kernel: [ 1527.380121] e1000e: EEE TX LPI TIMER: 00000011
May 17 13:52:45 nuc2 kernel: [ 1527.474981] ACPI: EC: interrupt blocked
May 17 13:52:45 nuc2 kernel: [ 1527.540696] ACPI: PM: Preparing to enter system sleep state S3
May 17 13:52:45 nuc2 kernel: [ 1527.567302] ACPI: EC: event blocked
May 17 13:52:45 nuc2 kernel: [ 1527.567307] ACPI: EC: EC stopped
May 17 13:52:45 nuc2 kernel: [ 1527.567311] ACPI: PM: Saving platform NVS memory
May 17 13:52:45 nuc2 kernel: [ 1527.567412] Disabling non-boot CPUs ...

While writing this email I found another way to continue the suspend
after a stall: terminate rtcwake with CTRL-C in the ssh session running
the for loop. That explains why 'sudo shutdown -h now' makes the suspend
go forward, it most likely kills the stalled rtcwake process.

