Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9031F40FF1A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbhIQSXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 14:23:06 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39714 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhIQSXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 14:23:03 -0400
Received: by mail-ot1-f51.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so14035899otf.6;
        Fri, 17 Sep 2021 11:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MtTALbtXM6PObJbmnLKEWXd1r3ADFCs2TpTZwf4bkBM=;
        b=vEIrgd2wyaRWwg3BiCOaiVUthng1KlssjDPPOCyFesFo6inD7IjAB24q2bfZ34ORrw
         jLb6La9WtUMsE0tYC2y55c6bOGekekTP15CjROu1ylHaDYzF6hmhONg4eQwCJBa4mJ+H
         tPSPbWEgvNOYJ2Zn9Ny4yoDnS4uJWrAHU9LnEeQZR84UIKpllkQXWndqO+5K2vEFwUiN
         s1mm/0C7stdwEgt0yDATb3cLF8fUOtslvnqHjvtv/dqFyS/6aJYnl5euSMdr4YRlqS6+
         bEeQr7r6MmqxBa8+KdaMgm+yAfasDQTURZXc5SUMVDe86fVf+ZUQv7bQGM5jwdJLprAw
         itZg==
X-Gm-Message-State: AOAM5334uOLSs9A10hYjOZMf/dQckQh2DqthXUow2tGLop0t1zG6c0oq
        8MdqwGwsaE4kCXjWDUdDT2/viXK8DIimZTCpxqWdjpXyXMA=
X-Google-Smtp-Source: ABdhPJxtRPgmy11EJNiV2sYS6uQeTpyeLzJb2JYM7JssdXrRZZwoN2y7dOaYWGAxECQO31Owa2EykqgsNmt89jw2KfE=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr10896232ote.319.1631902900355;
 Fri, 17 Sep 2021 11:21:40 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Sep 2021 20:21:29 +0200
Message-ID: <CAJZ5v0jjPkRrtS0qG7vx=Od6MiOixC1UyxjcLeQzfpegGtu9fQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.15-rc2
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
 pm-5.15-rc2

with top-most commit cdef1196608892b9a46caa5f2b64095a7f0be60c

 cpufreq: schedutil: Destroy mutex before kobject_put() frees the memory

on top of commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f

 Linux 5.15-rc1

to receive power management fixes for 5.15-rc2.

These fix two cpufreq issues, one in the intel_pstate driver and one
in the core.

Specifics:

 - Prevent intel_pstate from avoiding to use HWP, even if instructed
   to do so via the kernel command line, when HWP has been enabled
   already by the platform firmware (Doug Smythies).

 - Prevent use-after-free from occurring in the schedutil cpufreq
   governor on exit by fixing a core helper function that attempts
   to access memory associated with a kobject after calling
   kobject_put() on it (James Morse).

Thanks!


---------------

Doug Smythies (1):
      cpufreq: intel_pstate: Override parameters if HWP forced by BIOS

James Morse (1):
      cpufreq: schedutil: Destroy mutex before kobject_put() frees the memory

---------------

 drivers/cpufreq/cpufreq_governor_attr_set.c |  2 +-
 drivers/cpufreq/intel_pstate.c              | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)
