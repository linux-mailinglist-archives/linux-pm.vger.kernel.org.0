Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458762A80B7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 15:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgKEOUf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 09:20:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36761 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbgKEOUe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 09:20:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so1555025otm.3;
        Thu, 05 Nov 2020 06:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6vodcv1GXxkk+qGC/jJRzY0m4wQQ2eN/NuM0BcV/WJA=;
        b=g7StZhZzDF2DEAUI4aXh5WMF5EyIqN8va+jGIVZUJf7y+7zRhioqpoc52AdQV3P2yP
         0wStZi77J5lYt/otCOBh49OA4+zO0GEJhlMWA4X2fKaHZ82zFZ5yZDoMtilkkLYjsEVI
         +sx2mFH7egXMzvhZFtzvAUfuF+DXRblFvhZXFZCeC3dvmedKH5Rav3QrE2HmNxi7pp1y
         P7j12xLLXgjS6eKXBsu8NafcwFoaHF4LtSbZfiOvYFct4yMa3aPr2fXml//hA73rh11y
         xfJ6qOn6RnAaveDN5n2tWVOX7iPTe4wVWyurhyHhMZfidPF6dKmazjxNpOzS97ukYUWG
         QstQ==
X-Gm-Message-State: AOAM533m/cdztBDJMlLZ0uuc19qFCLdMeBjUA/boHVpSdlRlrNPb8Olv
        uHxbr4rH7NcFdhDmukPDClTbBesDaQ69G4JmnoaGJFGh7Vo=
X-Google-Smtp-Source: ABdhPJysTW+46aOUk26TcDOtJ6KrJAMxrwPcI08Nx7PRo5XDPOqDCNYF5fR1T+MZqLe3/O/sv7Do8I+qNsDw/TCahn0=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr458601otu.206.1604586033908;
 Thu, 05 Nov 2020 06:20:33 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Nov 2020 15:20:22 +0100
Message-ID: <CAJZ5v0jgoa3kLeVsZz8Ac8bkzsFdiMerwvRtCxqk9y4ABoK_6A@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.10-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.10-rc3

with top-most commit 8c14577df4cd5c6d8b799bdfb3a0e94923f17d50

 Merge branches 'pm-cpufreq', 'pm-cpuidle', 'pm-opp' and 'powercap'

on top of commit 3cea11cd5e3b00d91caf0b4730194039b45c5891

 Linux 5.10-rc2

to receive power management fixes for 5.10-rc3.

These fix the device links support in runtime PM, correct mistakes in
the cpuidle documentation, fix the handling of policy limits changes
in the schedutil cpufreq governor, fix assorted issues in the OPP
(operating performance points) framework and make one janitorial
change.

Specifics:

 - Unify the handling of managed and stateless device links in the
   runtime PM framework and prevent runtime PM references to devices
   from being leaked after device link removal (Rafael Wysocki).

 - Fix two mistakes in the cpuidle documentation (Julia Lawall).

 - Prevent the schedutil cpufreq governor from missing policy
   limits updates in some cases (Viresh Kumar).

 - Prevent static OPPs from being dropped by mistake (Viresh Kumar).

 - Prevent helper function in the OPP framework from returning
   prematurely (Viresh Kumar).

 - Prevent opp_table_lock from being held too long during removal
   of OPP tables with no more active references (Viresh Kumar).

 - Drop redundant semicolon from the Intel RAPL power capping
   driver (Tom Rix).

Thanks!


---------------

Julia Lawall (2):
      Documentation: PM: cpuidle: correct typo
      Documentation: PM: cpuidle: correct path name

Rafael J. Wysocki (3):
      PM: runtime: Drop runtime PM references to supplier on link removal
      PM: runtime: Drop pm_runtime_clean_up_links()
      PM: runtime: Resume the device earlier in __device_release_driver()

Tom Rix (1):
      powercap/intel_rapl: remove unneeded semicolon

Viresh Kumar (4):
      opp: Don't always remove static OPPs in _of_add_opp_table_v1()
      opp: Fix early exit from dev_pm_opp_register_set_opp_helper()
      opp: Reduce the size of critical section in _opp_table_kref_release()
      cpufreq: schedutil: Don't skip freq update if need_freq_update is set

---------------

 Documentation/admin-guide/pm/cpuidle.rst |  4 +--
 drivers/base/core.c                      |  6 ++--
 drivers/base/dd.c                        |  9 ++---
 drivers/base/power/runtime.c             | 57 +++++++++++---------------------
 drivers/opp/core.c                       |  9 ++---
 drivers/opp/of.c                         |  2 ++
 drivers/powercap/intel_rapl_common.c     |  2 +-
 include/linux/pm_runtime.h               |  6 ++--
 kernel/sched/cpufreq_schedutil.c         | 22 ++++++------
 9 files changed, 49 insertions(+), 68 deletions(-)
