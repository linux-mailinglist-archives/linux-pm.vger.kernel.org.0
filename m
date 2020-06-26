Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647A220B4CF
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 17:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgFZPjD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 11:39:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37250 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgFZPjC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 11:39:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id 12so1914072oir.4;
        Fri, 26 Jun 2020 08:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uw6SWLZZccFhEMxqcHMfobQGTjxadNTu6Bwdli5yUE4=;
        b=a3J/nr/ORspM80r6/0HSg/EKaebjX1umBQfwT4Y/u9/MkApqjzhipKdamQ87g009dy
         U2edAQuibbSBJ6458pjCGa+gQQ3qwal4chVH9Dxs3zdbHzsMBq9uOToeDrbdpJljssPp
         qTIszKuQVdG5a7Wu5b8+8Z3ffigdTnPlN3irCYxU/ICIl1O2rTQjDXwiT+hEihOm1l2p
         P5b+nocc3dZfPzmWgg5dzh3gZc0KRazjeir3XmdvPkMJCEc62ouxvHz92bgMwOONc4y4
         gMBTMlky6GRm3ixXlzPxzXObcKlaQbR/E/U9XMRxdMkoX0apHVHT+1+D+eYrZO3AK7L8
         gU7Q==
X-Gm-Message-State: AOAM533m6Z6p9Q6Laa3mC8jz2ELXZK5KQEtjEkxXOPnVYtpT9K6ad30a
        yEhvoa1TIlxRKkAZJ+xGTdwLzcLKBYScDK0zg4sK4eUO
X-Google-Smtp-Source: ABdhPJys2qJb9EttkZI5K9Y9m83unxshzaUmbUkamjQUq7/Vx+q6R0OEFjSX99jkll5NGNon3c1lZDFDWbpiFRV3BXc=
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr2834944oic.68.1593185941879;
 Fri, 26 Jun 2020 08:39:01 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Jun 2020 17:38:50 +0200
Message-ID: <CAJZ5v0gV3VCoJxuSZcngA2H1Nwqz2mHLtJAd2NoQE3ht9FVTHg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.8-rc3
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
 pm-5.8-rc3

with top-most commit 0e3fb2a128d81bc5baee76dddcc8ddbc8ccae95c

 Merge branches 'pm-cpufreq' and 'pm-cpuidle'

on top of commit 48778464bb7d346b47157d21ffde2af6b2d39110

 Linux 5.8-rc2

to receive power management fixes for 5.8-rc3.

These fix a recent regression that broke suspend-to-idle on some
x86 systems, fix the intel_pstate driver to correctly let the
platform firmware control CPU performance in some cases and
add __init annotations to a couple of functions.

Specifics:

 - Make sure that the _TIF_POLLING_NRFLAG is clear before entering
   the last phase of suspend-to-idle to avoid wakeup issues on some
   x86 systems (Chen Yu, Rafael Wysocki).

 - Cover one more case in which the intel_pstate driver should let
   the platform firmware control the CPU frequency and refuse to
   load (Srinivas Pandruvada).

 - Add __init annotations to 2 functions in the power management
   core (Christophe JAILLET).

Thanks!


---------------

Chen Yu (1):
      PM: s2idle: Clear _TIF_POLLING_NRFLAG before suspend to idle

Christophe JAILLET (1):
      PM: sleep: core: mark 2 functions as __init to save some memory

Rafael J. Wysocki (1):
      cpuidle: Rearrange s2idle-specific idle state entry code

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Add one more OOB control bit

---------------

 drivers/base/power/trace.c     |  4 ++--
 drivers/cpufreq/intel_pstate.c |  7 +++++--
 drivers/cpuidle/cpuidle.c      |  5 +++--
 kernel/sched/idle.c            | 15 +++++++++++----
 4 files changed, 21 insertions(+), 10 deletions(-)
