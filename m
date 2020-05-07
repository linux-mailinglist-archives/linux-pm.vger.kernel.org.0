Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764821C98DF
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGSKQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSKQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E1BC05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z11so8091918ybk.2
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sjWkrGrnU/EJtxPoXRaoT1xpbM/x0feZVAsuk0CdGxM=;
        b=phup02XyRX5qCSTgfWJ0IuC3rFaKoFAIRCaVT1BxerHyNi3c5nNxAsm0xyzl3q8+u8
         lzsrqa5sjNgVN6EpoK4iXtC8qaLxcT2DwbMO2+5W+pjNhPSXjGhZ5cdy+zouEP1AnoFx
         nrd6KrtLXXDw5LZPjtm4DXQ4VAe4WiCeS0CrDW19m0i2TMrnFz1gvJ8Hzb5VJo8Iud8t
         nsPyZX1HlbVSwXoqDacSL7QZyxwHLHD9ZATTRtRN+JMREoDoYPDvIBrsROnipw7sMaKD
         vkxRcsEqxa+89keD+o4y002kAz2t+ID92iyiWydARX6TDXVQYFHtF9l+DkkJb2YVoYfW
         c7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sjWkrGrnU/EJtxPoXRaoT1xpbM/x0feZVAsuk0CdGxM=;
        b=KwZ3RTR6qsBhGimBWzeyuDxWGZi2KiEWKO5PaTEhCC+osgVloM80qyK/eSkzIS7vFr
         Pb4kavLAShhdN6TEvsOh/6ojYDasjlHCwUkWurO6GqbpLT+xx/G3PldlmgJfAlEmFXMh
         44e2jII0x7u/IJOF+md1zQsGsCOk9WCwfmNz8RF1pbu+X68Qn+3mwHiFBT/FvtF1Rcum
         BKeKyEfUcjo9kZLcTpy9rYPErRx6cm062hMRpHZzznsqLS7aSnMqcv91tNZicB6ywdov
         oxA0327mneUmz+d6vbR/0jB5BIPhFzQQZ2xGjfaq6HLQr53rUlUM2BTxbqRaBFm7owA5
         UxJg==
X-Gm-Message-State: AGi0PuYFcntc4yvyWXLSvMPw31UC26iDTwddPGPlM4x+O7lkpSvBSyvz
        RJdh84rh93l5EmgihsXFR12H5AYj1rgl
X-Google-Smtp-Source: APiQypLF514pacRtQ1a7I3HJKFHx78pHnwzf2OvlWcJDi5aN+FX+pzeg47Q4KMrBdLGN9MtVa+GMZ0pbEecv
X-Received: by 2002:a25:12c1:: with SMTP id 184mr24597001ybs.162.1588875014916;
 Thu, 07 May 2020 11:10:14 -0700 (PDT)
Date:   Thu,  7 May 2020 19:09:58 +0100
Message-Id: <20200507181012.29791-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 00/14] Modularize schedutil
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Android is trying very hard to use a single kernel image (commonly
called Generic Kernel Image, or GKI), closely aligned with mainline, to
run on all Android devices regardless of the vendor.

The GKI project intends to not only improve the status quo for Android
users directly (less fragmentation simplifies updatability), but also
to benefit upstream by forcing all vendors to agree on one common
kernel, that we push hard to be aligned with mainline.

One challenge to implement GKI is to avoid bloating the kernel by
compiling too many things in, especially given that different devices
need different things. As such, anything that can be turned into a
module helps GKI, by offering an alternative to having that component
built-in. This is true for pretty much anything that can be made
modular, including drivers as well as other kernel components, such as
CPUFreq governors.

Indeed, in practice, Android devices often ship with only one CPUFreq
governor enabled, and don't require any other that would simply waste
memory for no benefits. All CPUFreq governors can already be built as
modules with one notable exception: schedutil. Though popular in
Android, some devices do not use schedutil, which is why it would be
preferable to not have it unconditionally built in GKI. This series is
an attempt to solve this problem, by making schedutil tristate.

While modularization is usually not something we want to see near the
scheduler, it appeared to me as I wrote those patches that the
particular case of schedutil was actually not too bad to implement.
We already have to support switching governors at run-time, simply
because userspace is free to do that, so the infrastructure for turning
sugov on and off dynamically is already there. Loading the code a little
later doesn't seem to make that a lot worse.

Patches 01-05 refactor some code to break the few dependencies on
schedutil being builtin (notably EAS). Patches 06-12 export various
symbols that schedutil needs when compiled as a module. And finally,
patches 13-14 finish off the work by making the Kconfig tristate.

---
The series is based on Peter's sched/fifo [1] branch (because sugov
uses sched_setscheduler_nocheck()).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/fifo

Quentin Perret (14):
  sched: Provide sched_set_deadline()
  sched: cpufreq: Use sched_set_deadline() from sugov
  sched: cpufreq: Introduce 'want_eas' governor flag
  sched: cpufreq: Move sched_cpufreq_governor_change()
  sched: cpufreq: Move schedutil_cpu_util()
  arch_topology: Export cpu_scale per-cpu array
  kthread: Export kthread_bind_mask()
  sched/core: Export runqueues per-cpu array
  sched/cpufreq: Export cpufreq_this_cpu_can_update()
  sched/fair: Export cpu_util_freq()
  tick/sched: Export tick_nohz_get_idle_calls_cpu
  x86: Export arch_scale_freq_key
  sched: cpufreq: Use IS_ENABLED() for schedutil
  sched: cpufreq: Modularize schedutil

 arch/x86/kernel/smpboot.c        |   1 +
 drivers/base/arch_topology.c     |   1 +
 drivers/cpufreq/Kconfig          |   2 +-
 include/linux/cpufreq.h          |   6 +-
 include/linux/sched.h            |   2 +
 include/linux/sched/sysctl.h     |   2 +-
 kernel/kthread.c                 |   1 +
 kernel/sched/core.c              |  18 ++++
 kernel/sched/cpufreq.c           |  34 ++++++
 kernel/sched/cpufreq_schedutil.c | 176 +++----------------------------
 kernel/sched/fair.c              | 119 ++++++++++++++++++++-
 kernel/sched/sched.h             |  36 ++-----
 kernel/sched/topology.c          |  16 +--
 kernel/sysctl.c                  |   2 +-
 kernel/time/tick-sched.c         |   1 +
 15 files changed, 212 insertions(+), 205 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

