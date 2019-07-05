Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABFB6053F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 13:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfGELZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 07:25:51 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40355 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfGELZv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 07:25:51 -0400
Received: by mail-wr1-f46.google.com with SMTP id r1so3235161wrl.7;
        Fri, 05 Jul 2019 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=B/ZaJZFBZY188RYtQ3H6s+uh4z50f09MZvHsCHoIxY0=;
        b=OoSby/BijD5Q8Ib/g4OAQFYYuIYvHtz6Wx3lcFnI6U4mWm/hV8mUInNd7koBDVjyjm
         uBcvlgzhW5ZsW2l3nL+apHkMoJSCXXG29l11BUdbQ9cvDGNXWqYZG/zzq3HmDR/AG6ej
         HNaqnOn6cq2Tkiag46ZL9jBroDEQEHGpxCgDTKk4OExiDk3jJ8edvkUBLziz6hlndrhX
         cpebOMpNTNlSu9s0UUVYX33CaQxR6FvoOi8N8sqx/skx56fm4Ww4gPPtkfz197t6Vts6
         8DeSrD6bwui3h1IbHMFVjdREYrnRYzOGKdKg/+P0dp7eMyGhr502G1y5I010uG/fa9XR
         4e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=B/ZaJZFBZY188RYtQ3H6s+uh4z50f09MZvHsCHoIxY0=;
        b=pb58/y+Im5uSXGjA+YFWHDFujsNgje77TZXHlsOrMWQ0lw9U8t20xqI+kCasG1rIAa
         G2jcAqNelyCiJJDk8DaFUTu79w0nOmxyeEH6jN4pY5uQMCoJ7XdBUXDgzCyJRTCqqObM
         exwQVjUS9WL3kHvkH9V8jN7JQA6mUZnP29t/71QMaH6oGEyZUHbGtHIPWmAye9cwTjiu
         my9oP68McEGjNWSvjF6xobVKdTn/9VApzrI+zLmP2HHHKx7fKKZ9Zo23sqhO9R/NbeRm
         Sm7oUWx0yEtNKAgFpeIq08jY0PG7/2SKsje8faFToRqUbk93pNY7BEbTmZg8OXA21JF4
         B6NA==
X-Gm-Message-State: APjAAAWpNJlVCCmxBhHCiPs34nTgik7sHubU9xKIgE5BadgW5yXN2dNF
        g7SH67OLuwPHJH26cOc4yXeMUayK
X-Google-Smtp-Source: APXvYqzYMEdI+tvxCvH4G8x7XzfcWDp/sPl+GKXXdOkYSPFWrIBXHPPjUCevJVehwrRu8hZ/e/Xfag==
X-Received: by 2002:adf:cf09:: with SMTP id o9mr3686214wrj.222.1562325948202;
        Fri, 05 Jul 2019 04:25:48 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-246-11.as13285.net. [89.243.246.11])
        by smtp.gmail.com with ESMTPSA id o11sm8126270wmh.37.2019.07.05.04.25.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 04:25:47 -0700 (PDT)
Subject: Re: iowait v.s. idle accounting is "inconsistent" - iowait is too low
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org
References: <2ff025f1-9a3e-3eae-452b-ef84824009b4@gmail.com>
 <000001d531a8$8931b2a0$9b9517e0$@net>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <e82b9d7c-81e5-dd80-b9c0-f5f065344e2f@gmail.com>
Date:   Fri, 5 Jul 2019 12:25:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <000001d531a8$8931b2a0$9b9517e0$@net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, scheduler experts!

My cpu "iowait" time appears to be reported incorrectly.  Do you know 
why this could happen?

Doug helped me - it was he who noticed different behaviour on v4.15 vs 
v4.16 vs v4.17+.  So I have some confirmation of this.  I don't think 
Doug mentioned what hardware he ran the kernels on.  lscpu says my 
hardware is "Intel(R) Core(TM) i5-5300U CPU @ 2.30GHz".

I tested using "dd" :-

dd if=bigfile bs=1M iflag=direct of=/dev/null

  (1) E.g. I get the expected result if I pin "dd" to the "right" cpu.  
Which cpu varies; it has often been cpu2.  At the moment I have booted 
5.2-rc5-ish.  Here I run "dd" with "taskset -c 0", and "iowait" worked 
as expected:

top - 11:01:47 up 15:10,  2 users,  load average: 1.07, 0.86, 0.86
Tasks: 288 total,   1 running, 287 sleeping,   0 stopped,   0 zombie
%Cpu0  :  0.3 us,  3.3 sy,  0.0 ni,  0.0 id, 94.3 wa,  0.7 hi,  1.3 si,  0.0 st
%Cpu1  :  0.3 us,  0.7 sy,  0.0 ni, 98.7 id,  0.0 wa,  0.3 hi,  0.0 si,  0.0 st
%Cpu2  :  1.0 us,  0.7 sy,  0.0 ni, 98.0 id,  0.0 wa,  0.3 hi,  0.0 si,  0.0 st
%Cpu3  :  0.7 us,  0.3 sy,  0.0 ni, 99.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   7854.0 total,    432.2 free,   4616.4 used,   2805.4 buff/cache
MiB Swap:   2048.0 total,   1978.2 free,     69.8 used.   2498.0 avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
31849 alan-sy+  20   0  216052   2836   1800 D   3.0   0.0   0:00.58 dd
24220 alan-sy+  20   0 3339828 232160 126720 S   0.7   2.9   1:53.14 gnome-shell
...

(I have also used "atop" and "vmstat 3". "atop" shows both total and 
per-cpu iowait, idle, etc. "vmstat 3" just shows a total, but all the 
old values stay on-screen).

  (2) But compare running "dd" with "taskset -c 1":

%Cpu0  :  0.3 us,  0.3 sy,  0.0 ni, 97.3 id,  0.0 wa,  0.7 hi,  1.3 si,  0.0 st
%Cpu1  :  0.3 us,  3.0 sy,  0.0 ni, 83.7 id, 12.6 wa,  0.0 hi,  0.3 si,  0.0 st
%Cpu2  :  1.0 us,  0.3 sy,  0.0 ni, 98.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  :  1.3 us,  0.7 sy,  0.0 ni, 98.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st

  (3) If I don't use "taskset", "dd" generally doesn't sit on the 
"right" cpu, and so I get don't see the right "iowait".  Here's "top -d 
30".  Over this longer interval, "dd" appears to spend a quarter of its 
time on the "right" cpu:

%Cpu0  :  0.5 us,  1.2 sy,  0.0 ni, 74.4 id, 22.2 wa,  0.5 hi,  1.3 si,  0.0 st
%Cpu1  :  0.7 us,  1.3 sy,  0.0 ni, 92.3 id,  5.7 wa,  0.1 hi,  0.0 si,  0.0 st
%Cpu2  :  0.5 us,  0.9 sy,  0.0 ni, 95.1 id,  3.3 wa,  0.1 hi,  0.0 si,  0.0 st
%Cpu3  :  0.7 us,  0.9 sy,  0.0 ni, 94.6 id,  3.6 wa,  0.1 hi,  0.0 si,  0.0 st

This point (3) does not apply to 4.15.  On 4.15, it seems "dd" naturally 
sits on the "right" cpu, so I get the "right" iowait". But if I pin "dd" 
to a different cpu, I get the "wrong" iowait again.

I bisected 4.15-4.16.  The first "bad" commit was 806486c377e3 
"sched/fair: Do not migrate if the prev_cpu is idle"

  (4) I can get the "right" iowait regardless of which cpu, if I boot 
with "nohz=off", or if I suppress nohz by dynamically disabling all 
cpuidle states except for state0 (POLL).

This point (4) does not apply to 4.16. On 4.15 and 4.16, suppressing 
nohz does not help.  (So far, I did not test 4.15).

I bisected 4.16-4.17.    The first "new" commit was 554c8aa8ecad "sched: 
idle: Select idle state before stopping the tick"

  (5) I seem to get the "right" iowait regardless of which cpu, if I run 
inside a virtual machine.  I tested stock Fedora v5.1.? inside a KVM 
(virt-manager) virtual machine, which also had 4 cpus.  Whereas 
un-virtualized Fedora v5.1.? on my laptop, behaves as per points 1-4.

I read the documented limitations for "iowait" time. As far as I 
understand them, they don't explain such inconsistent values.

> - iowait: In a word, iowait stands for waiting for I/O to complete. But there
> are several problems:
>
> 1. Cpu will not wait for I/O to complete, iowait is the time that a task is
>    waiting for I/O to complete. When cpu goes into idle state for
>    outstanding task io, another task will be scheduled on this CPU.
>
> 2. In a multi-core CPU, the task waiting for I/O to complete is not running
>    on any CPU, so the iowait of each CPU is difficult to calculate.
>
> 3. The value of iowait field in /proc/stat will decrease in certain
>    conditions


Thanks for all the kernels
Alan
