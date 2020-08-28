Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90794256180
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgH1TuC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 15:50:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45271 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1TuB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 15:50:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id 5so206606otp.12;
        Fri, 28 Aug 2020 12:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=V4kU8rE5CwRTb5R/8vCrL617SRo/ITfGbXVpB6N3JKs=;
        b=pX/9yw8Am5e6ZBmPmU49qUlZSzvAn6D9oVommGJv4/orfNqpWT81Fh4ZTBdf/WDRb6
         0o7iqaa9c+flIZgmnGnjIOR3/7+2Sw/ZnJowVpkylnABoL40VUGbI8tv8vuFRg6+enTV
         D5ewPqN1+3jlz2SF1Y1c/+4jJcUHD0Tq4V2u3Qe6gLwswyDLG+GofSE9otg16A75jD3j
         OG+0iC8KDROcKZgDtZtiudjaxGFjU981UdOdArLkf0LQ38gM7aKcXAeRA8owurcGZ139
         0dFSJzZiejzlebnH1QA73C4trttzCQJQP2Aw4ncPapUqk6nCAHNKh54cwy0o/elykPWX
         8w6w==
X-Gm-Message-State: AOAM530u3E+70lK8LIR04Mo9rG1JYrV3jweDiwc9Xp82Xlh/AGuYQpvo
        FnJjWqWiWEgsxl2eqr0vFhZTUnDmY8kqnAqNOZ5MR7V1N2U=
X-Google-Smtp-Source: ABdhPJxTzJbLTgme/kBS4TSGRXCqhBAOsKmy3D3rKmEatSmjplXtjbkxIMnz0pH/V564niLBorliFBWqeDgLBRiAcEA=
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr204687otp.118.1598644200010;
 Fri, 28 Aug 2020 12:50:00 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Aug 2020 21:49:49 +0200
Message-ID: <CAJZ5v0hYtUUKQmMi4P1-m+R5EDUsbzBySfFMDK6k48QZw2WrqQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.9-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.9-rc3

with top-most commit ef7d960403ecd87276e12b69c26bf0fdd5f21a0e

 Merge branch 'pm-cpufreq'

on top of commit d012a7190fc1fd72ed48911e77ca97ba4521bccd

 Linux 5.9-rc2

to receive power management fixes for 5.9-rc3.

These fix the recently added Tegra194 cpufreq driver and the handling
of devices using runtime PM during system-wide suspend, improve the
intel_pstate driver documentation and clean up the cpufreq core.

Specifics:

 - Make the recently added Tegra194 cpufreq driver use
   read_cpuid_mpir() instead of cpu_logical_map() to avoid
   exporting logical_cpu_map (Sumit Gupta).

 - Drop the automatic system wakeup event reporting for devices
   with pending runtime-resume requests during system-wide suspend
   to avoid spurious aborts of the suspend flow (Rafael Wysocki).

 - Fix build warning in the intel_pstate driver documentation and
   improve the wording in there (Randy Dunlap).

 - Clean up two pieces of code in the cpufreq core (Viresh Kumar).

Thanks!


---------------

Rafael J. Wysocki (1):
      PM: sleep: core: Fix the handling of pending runtime resume requests

Randy Dunlap (1):
      Documentation: fix pm/intel_pstate build warning and wording

Sumit Gupta (1):
      cpufreq: replace cpu_logical_map() with read_cpuid_mpir()

Viresh Kumar (2):
      cpufreq: No need to verify cpufreq_driver in show_scaling_cur_freq()
      cpufreq: Use WARN_ON_ONCE() for invalid relation

---------------

 Documentation/admin-guide/pm/intel_pstate.rst |  4 ++--
 drivers/base/power/main.c                     | 16 ++++++++++------
 drivers/cpufreq/cpufreq.c                     |  3 +--
 drivers/cpufreq/tegra194-cpufreq.c            | 10 +++++++---
 include/linux/cpufreq.h                       |  4 ++--
 5 files changed, 22 insertions(+), 15 deletions(-)
