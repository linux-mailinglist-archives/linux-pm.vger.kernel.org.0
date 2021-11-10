Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30BA44C2FF
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 15:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhKJOey (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 09:34:54 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:39487 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhKJOey (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 09:34:54 -0500
Received: by mail-oi1-f169.google.com with SMTP id bf8so5559161oib.6;
        Wed, 10 Nov 2021 06:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/02Exx/ph/UcNJNTQkGez12UzJqq82J9H0P+Kmhe9ik=;
        b=H5xI42tOcjWG88i17eu80KW/8+8xGgqvoh3NPlYn9laLBJVRar1vHYjqmf1rkJhxmg
         WlG7TU+pnbPkKzj6U7oR7/Dm3xeqdy+7FVr1LXWi/f+pDxY0EHDDCC5Z8rOBpeCaLQRC
         0EgHV3huxn8AURLD6LwbWVLorZf4jWhT+4vYKHpUicmoSkVgFrlbfXYqA4zU5RHZKF2/
         xACEwmJgNcNWwiUDO5c992Ua6Ieuen/7qiSLMFxgIHFmrmmXLou7iSggZRqf9MSxqqp7
         dsPxXLT3khJ3vfzyKrmWh1clXht8AySPz7KxJ87EKBuLhnI/QUEadXhzGdIdy2ZY45+K
         saQg==
X-Gm-Message-State: AOAM532f4nCt0keAWyR0J1hcA5F7dWhiaqK9bfglMO/060yPXYG5YBLE
        bJpoNRh8G24aSSHW7qrxTuI6lbU2dfPPYswU+aSFuRmSrq8=
X-Google-Smtp-Source: ABdhPJzpPxPWj610km0kVDhyoJvd8Sm63jEpZ9VWQntHjhS3aR57WlQKbef4tlhe/Yy0GEfQtFY8habtiV8JK4t+Z5U=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr24097oif.154.1636554726515;
 Wed, 10 Nov 2021 06:32:06 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Nov 2021 15:31:55 +0100
Message-ID: <CAJZ5v0jfXr+6YaQpeAeEN11R47BdvjiM1_JsWfrCSLNpVpt1pw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.16-rc1
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
 pm-5.16-rc1-2

with top-most commit dcc0b6f2e63ac3bdcea5c9686de4cb1684f2eb33

 Merge branches 'pm-opp' and 'pm-cpufreq'

on top of commit 833db72142b93a89211c1e43ca0a1e2e16457756

 Merge tag 'pm-5.16-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.16-rc1.

These fix 3 intel_pstate driver regressions, fix locking in the core
code suspending and resuming devices during system PM transitions, fix
the handling of cpuidle drivers based on runtime PM during system-wide
suspend, fix 2 issues in the operating performance points (OPP)
framework and resource-managed helpers to it.

Specifics:

 - Fix 2 intel_pstate driver regressions related to the HWP interrupt
   handling added recently (Srinivas Pandruvada).

 - Fix intel_pstate driver regression introduced during the 5.11
   cycle and causing HWP desired performance to be mishandled in
   some cases when switching driver modes and during system
   suspend and shutdown (Rafael Wysocki).

 - Fix system-wide device suspend and resume locking to avoid
   deadlocks when device objects are deleted during a system-wide
   PM transition (Rafael Wysocki).

 - Modify system-wide suspend of devices to prevent cpuidle drivers
   based on runtime PM from misbehaving during the "no IRQ" phase of
   it (Ulf Hansson).

 - Fix return value of _opp_add_static_v2() helper (YueHaibing).

 - Fix required-opp handle count (Pavankumar Kondeti).

 - Add resource managed OPP helpers, update dev_pm_opp_attach_genpd(),
   update their devfreq users, and make minor DT binding change (Dmitry
   Osipenko).

Thanks!


---------------

Dmitry Osipenko (6):
      opp: Change type of dev_pm_opp_attach_genpd(names) argument
      opp: Add more resource-managed variants of dev_pm_opp_of_add_table()
      PM / devfreq: Add devm_devfreq_add_governor()
      PM / devfreq: tegra30: Use resource-managed helpers
      PM / devfreq: tegra30: Check whether clk_round_rate() returns zero rate
      dt-bindings: opp: Allow multi-worded OPP entry name

Pavankumar Kondeti (1):
      opp: Fix required-opps phandle array count check

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Clear HWP desired on suspend/shutdown and offline
      PM: sleep: Avoid calling put_device() under dpm_list_mtx

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Fix unchecked MSR 0x773 access
      cpufreq: intel_pstate: Clear HWP Status during HWP Interrupt enable

Ulf Hansson (1):
      PM: sleep: Fix runtime PM based cpuidle support

YueHaibing (1):
      opp: Fix return in _opp_add_static_v2()

---------------

 .../devicetree/bindings/opp/opp-v2-base.yaml       |   2 +-
 drivers/base/power/main.c                          |  85 +++++++++++-----
 drivers/cpufreq/intel_pstate.c                     |  36 ++++++-
 drivers/devfreq/devfreq.c                          |  26 +++++
 drivers/devfreq/governor.h                         |   3 +
 drivers/devfreq/tegra30-devfreq.c                  | 109 +++++++++------------
 drivers/opp/core.c                                 |   6 +-
 drivers/opp/of.c                                   |  50 ++++++++--
 include/linux/pm_opp.h                             |  20 +++-
 9 files changed, 229 insertions(+), 108 deletions(-)
