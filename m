Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5445F544
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 20:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhKZTlo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 14:41:44 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34366 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhKZTjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 14:39:44 -0500
Received: by mail-ot1-f49.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso15332640otj.1;
        Fri, 26 Nov 2021 11:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=glw+Kw+qAlQl558xudGtlPvGeHEeJq6ZUeY+roOhbWI=;
        b=08aHGlvHP/X2JEt4ZybKNSpqGkFpBOT147NPhyYUMT+2NluYGO0FkrNDdA9zEEzhmD
         WW2b0IGowVyln0pm1667vuu+16c5/MO+5TFbB/m0QFZOgPD9jeVzCNuxQcl+9AC2Dq8z
         FBReq5aL2GsBodvxv3k6D7KWxQCHFxgARyH+zQOAeAf/f4yX/7A64wmNB9tBkcqWEUY/
         5EBBWzU2EBX2bj4LZqSXdUgfLP7BdYF08ZxJD3bJHxabx4IbXgKNlPyFSt2ctqoDhImc
         jXmIxSOrzp/pC41U/f+qsO+7w1kAxjX4kBhDxw4Gjt5WJRt+ziULqO26fyRlF71ZQHPB
         YoHA==
X-Gm-Message-State: AOAM530353kqRLIwsCCf0gIRtlB5gFWMN42L9DdsTcMh1cjR1Z5fptbI
        N/x8+3fjjI2HExGhFL769CGK5AFwhBabod04sNutmUgzE+o=
X-Google-Smtp-Source: ABdhPJz50cOaIYD3OvSmD107GGMQcdk82DQ6jfjK96cnQ6C+f7ZtYCr5I6GMqROiichrZ1d0qMFhDgSfX6nzzrFTH4I=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr29606122otj.16.1637955390721;
 Fri, 26 Nov 2021 11:36:30 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Nov 2021 20:36:20 +0100
Message-ID: <CAJZ5v0jNK=LfKcXDR+ibnczM3+D+GHH_-UCMi=sj47aaLxXoJA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.16-rc3
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
 pm-5.16-rc3

with top-most commit 7803516dbe26518115408d53a500ccb4d6a7d1c7

 Merge branch 'pm-sleep'

on top of commit 136057256686de39cc3a07c2e39ef6bc43003ff6

 Linux 5.16-rc2

to receive power management fixes for 5.16-rc3.

These address 3 issues in the intel_pstate driver and fix 2 problems
related to hibernation.

Specifics:

 - Make intel_pstate work correctly on Ice Lake server systems with
   out-of-band performance control enabled (Adamos Ttofari).

 - Fix EPP handling in intel_pstate during CPU offline and online in
   the active mode (Rafael Wysocki).

 - Make intel_pstate support ITMT on asymmetric systems with
   overclocking enabled (Srinivas Pandruvada).

 - Fix hibernation image saving when using the user space interface
   based on the snapshot special device file (Evan Green).

 - Make the hibernation code release the snapshot block device using
   the same mode that was used when acquiring it (Thomas Zeitlhofer).

Thanks!


---------------

Adamos Ttofari (1):
      cpufreq: intel_pstate: Add Ice Lake server to out-of-band IDs

Evan Green (1):
      PM: hibernate: Fix snapshot partial write lengths

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Fix active mode offline/online EPP handling

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: ITMT support for overclocked system

Thomas Zeitlhofer (1):
      PM: hibernate: use correct mode for swsusp_close()

---------------

 drivers/cpufreq/intel_pstate.c | 17 +++++++++++++++++
 kernel/power/hibernate.c       |  6 +++---
 kernel/power/user.c            |  2 +-
 3 files changed, 21 insertions(+), 4 deletions(-)
