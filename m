Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7216ED0C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 18:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgBYRun (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 12:50:43 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:35969 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgBYRun (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 12:50:43 -0500
Received: by mail-il1-f182.google.com with SMTP id b15so2098253iln.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6t/dPVFoBQv1uepPkxmWNx842JW5cVtwk3K/BsPZf0Y=;
        b=GTZlYq3CTZzZwyI5iOVRinhxhQ8RqfP0C0fb2duR/1eE70lqj0tfZlzkKlUdAk38+t
         MX22n5QGNG5kUCQ5IDJr4dtSmcgqRmYIOICrNsyOjCI9WAVquVbqAnPeyBfl/5Yga+gE
         DbLijVj5TuAMQz86N4IlbaJEzx0QqdA/l5Kdcf72JTC11GoFe1jQuY756dzJO9jZo5XJ
         5FWS5E5c4j23SzBKgZNVQs1Qdr3S9XDz9aSL38ZC8ypZNs3KjvU+F8tVrLfzKPLw8Aq5
         /ECjEraTNv+93Pi9SjhCDu3iVIZH/Pa4XDXtIc6Yu/WTgvdt7TH0vX/2kzASEbeA5mg3
         Y61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6t/dPVFoBQv1uepPkxmWNx842JW5cVtwk3K/BsPZf0Y=;
        b=buLUynM60lw84UndmcsbohMD5kvSIgGA+lhVW4Ail2Gl1+8F2WYX90kEBfruPNFU/D
         lKWyaSogKtp3ti2RILy8m/JTukdM0GeOQ1GEXbwwbYSjJzJwe05Hv/BS+ATgJVGNjzOF
         NIyEQS7SGsQjQdgnd1nMZPMN8hYSve8cgszcvlLII9S/1B6PE33taUfwd/WpIf9SezUD
         4bZLRZaOyr+1//2s3rgFHTUg+Tc41bcuUmXs+SqiY4DtzP17v2saXFkfgYBJq8V3ccCk
         lTRsBnlkSoJyHzQTelYhsKaqjPtRV6J3O8rHQBzZGu6ilCpHT0jkAHnudZu0k0ZuC600
         CvhQ==
X-Gm-Message-State: APjAAAUAOKvHFbI27nka/DhofKeSFQpR/CIWihJmBou90c7+tbnrOnnM
        7lKaMPX/s2cU5kVLqn9GhpEgjHcAEHrqikFDvN4KdC6g
X-Google-Smtp-Source: APXvYqwpipgR33ynjiDX/ALLFu1TFmhj1jAscQGQZyJWX3Vlhx5tfT8gGdaKWxuEDtibWcEZRkU0FF9/EnUUZn+WHsI=
X-Received: by 2002:a92:d609:: with SMTP id w9mr75585620ilm.46.1582653041331;
 Tue, 25 Feb 2020 09:50:41 -0800 (PST)
MIME-Version: 1.0
From:   Dick Sites <dick.sites@gmail.com>
Date:   Tue, 25 Feb 2020 09:50:27 -0800
Message-ID: <CAJohyydLpEkTvLsO0ZPYGLBLfyCmpJgGz2845=1hNCbE9nzikQ@mail.gmail.com>
Subject: How to read actual (dynamic) CPU frequency in kernel loadable module, or
To:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[Originally sent to rafael.j.wysocki@intel.com; he suggested you instead]

How to read actual (dynamic) CPU frequency in kernel loadable module, or
how to find code that is executed at frequency changes?

I am building KUtrace for Linux, consisting of a handful of kernel
patches and lots of postprocessing to account for what every CPU core
is doing every nanosecond. I first built this for production use at
Google years ago. See this ACM article for a simplified example
  https://queue.acm.org/detail.cfm?id=3291278

The attached trace shows part of 100,000 getpid calls, with funny
timing, I think related to intel_pstate.c and its underlying
mechanism. I pulled your name [rafael] out of the Linux kernel 4.19
sources.

The first image below shows the overfall output with four CPU cores
(i3-7100) and a timeline covering about 20 msec. The thin black lines
are idle, the tall lines are kernel-mode execution, and the half-high
lines are user-mode execution. Colors vary by syscall number, PID
number, etc. [My tracing overhead for all this is well under 1%] You
see five prominent sets of timer interrupts every 4 msec and in the
middle my time_getpid program starting up and running on CPU 0.

The odd timing happens at millisecond 494.89. The second image zooms
in on that time. You see four getpid system calls on the left, then
one extremely long one, then about 25 on the right. The calls on the
left take about 210ns each (based on reading the constant-rate TSC)
and the ones on the right about 50ns. The long call takes about 13.5us
(13500ns).

I suspect that the code or the chip hardware is changing the CPU clock
frequency here, perhaps from 800 MHz to something close to the rated
3.9 GHz, but I'm not sure. Is that plausible? If not, what else could
be going on?

Assuming a change in clock frequency, I would like to capture in my
trace every change of frequency. I have added my one-line trace
patches at every call to trace_cpu_frequency in the kernel source pool
but I get no trace entries at all. How can I see the frequency
changes?

Assuming that the hardware itself is changing the frequency with no
software intervention (HWP is enabled), I would like to at least read
the CPU frequency at every timer interrupt. At my patch in
arch/x86/kernel/apic.c, routine smp_apic_timer_interrupt, I do
cpufreq_quick_get(smp_processor_id()) and put the result in my trace.
But the result is always zero.

What can you suggest that would point me to either
1) some code that already runs at every CPU clock frequency change, or
2) some low-overhead C code to read the current CPU clock frequency
from a kernel timer-interrupt patch? My time budget for each
kernel-user transition trace entry is an average of 20 nsec, but I can
take a few extra CPU cycles now and then. Formatting and then parsing
sysfs output is much too costly, and I have been unable to find the
underlying code for that that actually grabs the current clock
frequency (I am a kernel newbie).

Thanks for your help. /dick

p.s. I am sending as an attachment in the very next email the
underlying HTML output from this trace, which you can pan and zoom to
see any level of detail desired, from the full 20 msec down to 20 nsec
or less across the screen (my actual timing resolution is rdtsc >> 6
or about 16 nsec at 3.9GHz). Shift-click on any item to see what it
is. Type into the search box to find names of syscall, interrupt,
fault, or user programs. The [more] button at lower right gives more
UI details. The full HTML file is about 4.4MB. Among other things, if
you search for rcu (or expand the PID button on the left) you will see
that the rcu soft interrupt code (BH:rcu) runs about 2 msec before the
frequency change. Perhaps related -- I don't know.

p.p.s. If you have a colleague interested in the too-soon issuing of
mwait in intel_idle.c, point them to my Stanford talk earlier this
month:
  http://web.stanford.edu/class/ee380/
The February 5th talk, slides 35-37.


[ Since HTML to you bounces, I put the images and HTML file on my Google Drive:
https://drive.google.com/drive/folders/1onPwy8B-vrLLQxK9RfL0hIG3t_ogBgxP?usp=sharing

You may need to download the HTML and then open in a browser, Chrome
most-often tested. Use mouse wheel to zoom in/out, click-drag to pan,
shift-click to label things.]
