Return-Path: <linux-pm+bounces-39763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C0CD3C44
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 07:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5662D3009421
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103522126D;
	Sun, 21 Dec 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz0OZIVR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F9D1A08DB
	for <linux-pm@vger.kernel.org>; Sun, 21 Dec 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766298787; cv=none; b=NXObVdgEItxilQFKwOUcmBPVQgzp7bMAWJvrucaIZ/n4v+JNcmdRiG+TFUqk6sl+uXE/6dhBikO/V6SEti+uXPC2CS41/gZVRoMAasWkEfsaXvBLcJiYzzHn0ZFcitG244YKaxYiWDMonoybYz8bv4QsJMxL+Ok5xVdKYR/K4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766298787; c=relaxed/simple;
	bh=t/SRnNrSaQoFeh37hW4yoybInZcjHy0NWwksWYocxp4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cvkA482Hu1LWOpmDQsNKyDNg1ukORTZVjgxlw3Ast0DBuaQYS7UX0QAujbSExJd2kHPY81+AJaEBhYiSYTQeNrxFgvoX9VSWKYkIGHLxt0eEdK3Y1nhbIMnOPuv863z4tul9hm5B+QK/+qqqGTKdfyoKSr3OQZvHEr6R8xDUO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz0OZIVR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-598f59996aaso4023818e87.1
        for <linux-pm@vger.kernel.org>; Sat, 20 Dec 2025 22:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766298783; x=1766903583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vvUOyQ20NZ3u320o4WJ7ZIkhH1hVl4Z31xAzi8r5Bo=;
        b=Rz0OZIVRdAKsANUMFNYOiww3X19eVXrA0nIwM0BLbbRtPoeK4meQtUusNJ0v606H0g
         uYWslmrDjFC3kxuj8uzjpr12C8SobxqSr1LMwqgWjJhn4WTrP3u7qr/3IOmBV95EPP48
         PKC/ygtW+LymAGnmkAs2JiEZf/221k4gtM80zBjBkbMD1CQSWZIP2wrOPukl75njUNyA
         VccOx4fCbwNqwDtRM/DBEkix/ud/g+y8+UC3/sNWQSpW009dw90Gbny6wDX5lxnGxlX9
         ZzoUShp7RsojBg2ppkyQwbLtjkqEWJIMJpjdZSYEOBmJxYXu/04TOUSWHdOSXhWyZtBm
         qmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766298783; x=1766903583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vvUOyQ20NZ3u320o4WJ7ZIkhH1hVl4Z31xAzi8r5Bo=;
        b=ZfKPWhX+P0o2QG9GghA/2tkxtSNzDbjJ9s3V1MBi7V+wkwx3cymylqvXEjmIFDHfHq
         iy9oNXQR/CMlHM8GcqwwtLYzPVLnNR4CXJ+NgqqpFjhdP2FqYdbPRbAvKf/AOUMlK2Lb
         Rc8NxJDVb0uzM9JsDMU+pWfr0pDJ9QfW/tTS48Tw9fg+DJzn98IVThwWD0YZtk79vnqS
         0/2SOOKqSDVZsCL6hQf48q9A58lMRNJXJpuRFnbI1WP58LFw+jU4HMrTvi8TdIvD0PCG
         Soz9vJeGcIlElPGJ9BqDHoNXozZH82dt76Fefipr18I95A4gCCLHHMnENTixA8E2SCC0
         JylA==
X-Gm-Message-State: AOJu0Yxte/XxDPiu3jGgdfnuddq/CvHvMfu01oxdy6OpuI9MgSi8laJL
	ZpVX1U/6iEYoRtmgrM+q0E4v8DtNdxfslfE8OKf/+A5T5q/8/tGNVBG09dvGLg==
X-Gm-Gg: AY/fxX6k1T+leV3z9QKHvbypPoFFlo3mM2ra7IFOjlWPzY7WkRkJMGDomolUOZmPXdS
	SA88ptbef92mlxqWUSivlBcFrf4xci3Btvud8VT7cSC2g9UXUsO5RcFJByTOrJ+cWJqpywGILmZ
	w//Ko5bePYgr4gjEvN0hcCA+ZBjwcTUu8sLUp1jkFBxB/A9Ef0fISP4WH/h9U0YMZq1xtDyeiwR
	1tBYnWYeBz9Rj86TU/RS1op4B6RlGJte7UeejUy0UN4yfjgwbpMDrO1wJW+iGyDtXIFJ4NcrZqL
	xj5ZxMIc68GOz3gYuX9/QOIWLNLTiB373YxnKcEgpiJkR70of9iBl+7SX25FtkdHvp9sWTX++IC
	YtPaKwAiRiqmeaKQDrZIGsM2cQBPUrxvuXzgPXFqqwCFgfnHC2/FOUE+tq2joDvdFegGFWjIss7
	BDt8JYqFk4
X-Google-Smtp-Source: AGHT+IFH4sTCKSS1GMSuwc+OwiYqzPAVcYDM78ORrmlrP2GRDH82woFInG7r1oweWmtSgj0RnHhVgg==
X-Received: by 2002:ac2:4e04:0:b0:599:1199:9df0 with SMTP id 2adb3069b0e04-59a17cbfe75mr2556883e87.0.1766298782833;
        Sat, 20 Dec 2025 22:33:02 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-3812262b360sm17479351fa.28.2025.12.20.22.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Dec 2025 22:33:01 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: pm: hibernation bug: wake up event during restore
Date: Sun, 21 Dec 2025 09:32:14 +0300
Message-ID: <20251221063214.3276685-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

What should I choose?

Please, fix the bug. Or help me to do this.

-- 
Askar Safin

