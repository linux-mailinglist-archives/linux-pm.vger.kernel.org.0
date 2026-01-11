Return-Path: <linux-pm+bounces-40610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22AD0ED95
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 13:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCEFB3010CD7
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FB93314A4;
	Sun, 11 Jan 2026 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2aUfqnr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79715331A5C
	for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768134407; cv=none; b=B1hn/O0XhsQJXBUefzJfrhTuIgpirdyp4fAjUglj6rnPUmGD/YlOBZZzH8Eiu9VAAsokwvfIFe56dAUt49PP5J+Gl/xrk4DgUz6jfASxqLNl3+vZZyWQUinK0TWZFxMvULLeDU+yGv9HkeF7/BS5vAbcM3o1ERnV88P1Ffnp0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768134407; c=relaxed/simple;
	bh=Ck7lcvvpFXmcTPqx3lxvUnh2xq5aJHth5h2wHcA5WuI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QnjJDq3RJsq4qZ1gKO240qFC0mxsbzNd+4SmGz4j6xzQ6EFgspsTKn6ymbf/3y0WqYxC1Wrbj1QiYQT9AJxYy7BIYTh9oOpSncSm2lYHICMYpY2ES5L3ddIl3Zw4LmanRZ1RcaNKxoawW4GG6dJ12zNm+HrkpB/oVgP1R2j8G9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2aUfqnr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2751322f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 04:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768134399; x=1768739199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r1UIfSMBl/lGxmQbxQeCI7S+pZQk/LVuPWKVFb8JRoo=;
        b=h2aUfqnr6gKS1aaLadMWNeNiGxFFBEGXYnVqVbp2A90aCqMmtL+DCiVwl6OfnsrLdC
         LqpjH39ds7dhDsD9twAXA86fTRwBAb23uqObMFT7DNa+8GaM8IHi3UWmn0suIFiipdNv
         kJ9/yuqjQxi9c6uejzVFNfcu/gXzwL3WY7VEq1fF9AQ7y9hX9Q5tqyBybYrseSlVf7dr
         f2xK49IftAG54erebgk9JRGBFBptMWAOp5iWzDpRVEgE2ip9L73EQtpkD5e4NlnBPSww
         ImPBZRC+QPINCcnxA31HDIuOIv+ZfXLOqRlg7wPcOrb9gdwIfkWYfd7IYyQSQWrTOlvH
         h4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768134399; x=1768739199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1UIfSMBl/lGxmQbxQeCI7S+pZQk/LVuPWKVFb8JRoo=;
        b=ejkIJEWXJo5wuQgQ3aXm1/lzjsuZ9CzBVEdwTqYlrXb6Uj/SR/JwdqT7XOP4tSs9IC
         tL2TmHJJTREeJHEooZW/MJ+FSwFtgrhns0atSdJwVwGL5wSPuwTpZBDamS3RKshQIpNx
         paB5083HtRQamDeZkCNZBNQBdVYgpJchHR1X40Y02TLISdO0HOEPnfgXzBZGWX4ZJ+V6
         vn3ELkGCXjZdgUI37jE6P+bNJZyRDF+8xd/G58RlAmzieqtjGCkxyBeXMmt1+24y3015
         xkSyfaS2P5HpAMD+6rocuonEekfCA3blbMAfEOze0ksPLXKIh6W3cG2Qn7PSQg6RKjxC
         8f1A==
X-Gm-Message-State: AOJu0YziGTjTzbtJ+5urtXXdOS/Iz8URwKT5kuvpHDrJdKwpg94q+Qxp
	22Ldud9sF/GOS6PHogSnFxSC4BpcVyHQ17IHY36sY0LNjVBsJ8TvHS1/2TIo5g==
X-Gm-Gg: AY/fxX5GU2yIl11NjoZWLVGLcJpQtJXQSUd9QOhhtbTXvTz9FD4lZVpNwSJuGmMeDd3
	PrltPmQjRA1qOybtxm6aAdcJ3N5Kc5PzamqxE8E7JDOnzcGpwUNFmSFh2dAHbB/wKnuSBnhQTZ5
	RrACUsY+ZmEYetXa6W1zAfDJfWrrjeosUwLur/qGtQZ11l7QPM/34aGC0orJfrm9LBU2Smq8d48
	RI7iuOKv2erq4UM+NtXJwhXz2VRC+Sd1Gxg+NgBQfM5gcB+SCCf3YzVRaX2ojUas8E0CLuktDtJ
	zDfYp5XF24uSATf+nwRwIDWyx2wdQyghg75hBAMjWhRCoRQ9g+F/P7VNr9kJmTmEbPDRlh70dE+
	jF03VIjN0YXzpCIOxcq9YsJJWm6Klfg7xicSDsfBPiFk1aSCr9g1tdToM36/uQflWGhsX/LNMdM
	9UOVp5b/Q=
X-Google-Smtp-Source: AGHT+IFffOOCcBc4r6t7N3Sm3O5mKZyQnj7GUrEEOt3M8f31gA1kiZBn7OiEptRxzcAXvHypZoG0sw==
X-Received: by 2002:a5d:588e:0:b0:431:b1e:7ff9 with SMTP id ffacd0b85a97d-432c37742d0mr15630603f8f.59.1768134399336;
        Sun, 11 Jan 2026 04:26:39 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-432bd0dad8bsm33252720f8f.8.2026.01.11.04.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 04:26:38 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: PM: hibernation bug: wake up event during resume
Date: Sun, 11 Jan 2026 15:26:25 +0300
Message-ID: <20260111122625.2228669-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Resending, because I got no answer previous time. ]

Hi, PM people! I found (yet another) hibernation bug on my laptop:
sometimes wakeup events abort resuming from hibernation.
I think I know how to fix this. And I already started to write patch.
But I need your help to finish the patch.

The bug is already fixed by 2d967310c49e (i. e. by denylisting
VEN_0488:00@355), but this fix is unsatisfactory for reasons described
below.

====

So, I found a bug on my laptop. This is still the same laptop as with
my previous bug reports: Dell Precision 7780.

When I resume from hibernation, sometimes the resume doesn't work,
and I see this in my logs:

Dec 20 02:04:55 comp kernel: PM: Loading and decompressing image data (811211 pages)...
Dec 20 02:04:55 comp kernel: PM: Image loading progress:   0%
Dec 20 02:04:55 comp kernel: PM: Image loading progress:  10%
[...]
Dec 20 02:04:55 comp kernel: PM: Image loading progress: 100%
Dec 20 02:04:55 comp kernel: PM: Image loading done
Dec 20 02:04:55 comp kernel: PM: hibernation: Read 3244844 kbytes in 1.62 seconds (2002.99 MB/s)
Dec 20 02:04:55 comp kernel: PM: Image successfully loaded
Dec 20 02:04:55 comp kernel: printk: Suspending console(s) (use no_console_suspend to debug)
Dec 20 02:04:55 comp kernel: ACPI: EC: interrupt blocked
Dec 20 02:04:55 comp kernel: ACPI: EC: event blocked
Dec 20 02:04:55 comp kernel: ACPI: EC: EC stopped
Dec 20 02:04:55 comp kernel: Disabling non-boot CPUs ...
Dec 20 02:04:55 comp kernel: smpboot: CPU 31 is now offline
Dec 20 02:04:55 comp kernel: smpboot: CPU 30 is now offline
[...]
Dec 20 02:04:55 comp kernel: smpboot: CPU 11 is now offline
Dec 20 02:04:55 comp kernel: Wakeup pending. Abort CPU freeze

Note that I don't touch anything during this. I don't touch mouse,
keyboard, power button, etc.

This is observed on Linux 6.18 from Debian.

This bug is very bad. It cancels resume, and thus I lose my hibernation
image with all unsaved data. I. e. the bug causes data loss.

This bug has the same cause as another similar bug I discovered recently:
i. e. wakeup event VEN_0488:00@355 , thus it is already fixed by mainline commit
2d967310c49e (authored by me).

But 2d967310c49e fixes this bug for my particular laptop only. But what if
I buy some another laptop in the future? Wakeup events should be simply
ignored completely during restore from hibernation. Because otherwise
we lose hibernation image, i. e. we get data loss!

Moreover, I want to be sure that resume is not cancelled even if I actually
actively touch mouse, keyboard, etc. Touching mouse should not cause data
loss!

Looking at the logs, I see that the cause is call to pm_wakeup_pending in
freeze_secondary_cpus . So, one option is simply to remove this call.
I already checked: in all non-resume code paths call to freeze_secondary_cpus is
always followed by call to syscore_suspend, which calls pm_wakeup_pending, too.

Thus removing pm_wakeup_pending call from freeze_secondary_cpus will not
break anything, i. e. responding to wakeup events in non-resume code
paths will continue to work.

The only problem is this: we will ignore wakeup events during freezing of
CPUs (in non-resume) code paths, and check wakeup events later instead.
But I think this is okay, because freezing of CPUs should not take lot of time.
On my computer it takes less than millisecond.

But, as I said above, I want to fix this problem not only on my laptop,
but on all others, too. What if other calls to pm_wakeup_pending are
problematic, too? So, we should make sure that either pm_wakeup_pending is
not called during resume, either pm_wakeup_pending always returns false
during resume.

====

I see 3 ways to achieve this.

Way #1. Audit all calls to pm_wakeup_pending and make sure that it is
never called during resume.

For call in freeze_secondary_cpus we can simply remove it, as explained above:

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1919,12 +1919,6 @@ int freeze_secondary_cpus(int primary)
                if (!cpu_online(cpu) || cpu == primary)
                        continue;

-               if (pm_wakeup_pending()) {
-                       pr_info("Wakeup pending. Abort CPU freeze\n");
-                       error = -EBUSY;
-                       break;
-               }
-
                trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
                error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
                trace_suspend_resume(TPS("CPU_OFF"), cpu, false);

Then we have call in device_suspend_late. device_suspend_late is called
both in resume and non-resume code paths. So, we can do something like this:

--- i/drivers/base/power/main.c
+++ w/drivers/base/power/main.c
@@ -1638,7 +1638,7 @@ static void device_suspend_late(struct device *dev, pm_message_t state, bool asy
        if (READ_ONCE(async_error))
                goto Complete;

-       if (pm_wakeup_pending()) {
+       if (!(state.event & PM_EVENT_QUIESCE) && pm_wakeup_pending()) {
                WRITE_ONCE(async_error, -EBUSY);
                goto Complete;
        }

There are other calls, all them should be dealt with, too.

Way #2. Ensure that pm_transition is set correctly in resume code path and
check it in pm_wakeup_pending. (Not good idea, because pm_transition is
file-private, and pm_wakeup_pending is defined in other file.)

Way #3. Ensure that events_check_enabled is false in resume code path and
make sure that pm_wakeup_pending is always false if events_check_enabled is
false:

--- i/drivers/base/power/wakeup.c
+++ w/drivers/base/power/wakeup.c
@@ -890,7 +890,10 @@ bool pm_wakeup_pending(void)
                pm_print_active_wakeup_sources();
        }

-       return ret || atomic_read(&pm_abort_suspend) > 0;
+       if (events_check_enabled && atomic_read(&pm_abort_suspend) > 0)
+               return true;
+
+       return ret;
 }
 EXPORT_SYMBOL_GPL(pm_wakeup_pending);

====

What should I choose? (There may be other options, of course.)

Please, fix the bug. Or help me to do this.

-- 
Askar Safin

