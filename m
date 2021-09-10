Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C524407197
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhIJTEQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Sep 2021 15:04:16 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41871 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJTEH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Sep 2021 15:04:07 -0400
Received: by mail-oi1-f169.google.com with SMTP id 6so4288186oiy.8;
        Fri, 10 Sep 2021 12:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BhUdTUmojGG7bc227oSTa/8pbr4rYZY6lA8dvbZo730=;
        b=s+h9kZQEZ/NsNCZQq7T3QTkTskDuj+ecHvyhbtKWA1K8lqmD7gg/FqN77TBgwX9CZb
         bGe2nk2NBG3U0EXBjckUrVWeWupVqE3A4Ok6AGVL0sFgxEVyafMWzUfTBb4F+PGkbR+S
         Stz5wnhUu8FatpYbNITT6ZzsNnUMq66k+qX4038KLDGlNMEmBzIRpu0U0UOEibRwsA+V
         VfWbg8ALU1+VjTPvXrwhv2Aff0cCkmZs2F2yhQWQ2fmpLgHgeadjqgQ4TfHFKRfQ/07E
         tSBunsXZXy036wde8X6TyibrAouOWiLmcKmmxfS/ydWzjctdqSFHZIzb6USBwUatK91e
         VXdA==
X-Gm-Message-State: AOAM5321rWeJL4JVX1WLMnUUuBJTfB5CxCxCmk84XevqLHzKPgFgfuQR
        M2ztrwsV9Wn78PrBpOHB9h2ZdjjUp4hhiW+qymG/X/+1AiU=
X-Google-Smtp-Source: ABdhPJxrrL4YEBCC/0LOip5VFSl7pdXqUyiy752Nnov2xeBt/HoPfZEzQvRpu3dnxEfxFJhNv/61VWEdk7efk/nKgX0=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr5385639oie.71.1631300576063;
 Fri, 10 Sep 2021 12:02:56 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Sep 2021 21:02:45 +0200
Message-ID: <CAJZ5v0jsnv0QYY7AeaUoxd3FsrSz_pxjjJsLk5svK4Uk7u25mw@mail.gmail.com>
Subject: [GIT PULL] Additional power management updates for v5.15-rc1
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
 pm-5.15-rc1-3

with top-most commit be2d24336f8876d60d8a4634f1a1e4753c4be124

 Merge branches 'pm-cpufreq', 'pm-sleep' and 'pm-em'

on top of commit 30f349097897c115345beabeecc5e710b479ff1e

 Merge tag 'pm-5.15-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 5.15-rc1.

These improve hybrid processors support in intel_pstate, fix an issue
in the core devices PM code, clean up the handling of dedicated wake
IRQs, update the Energy Model documentation and update MAINTAINERS.

Specifics:

 - Make the HWP performance levels calibration on hybrid processors
   in intel_pstate more straightforward (Rafael Wysocki).

 - Prevent the PM core from leaving devices in suspend after a
   failing system-wide suspend transition in some cases when driver
   PM flags are used (Prasad Sodagudi).

 - Drop unused function argument from the dedicated wake IRQs
   handling code (Sergey Shtylyov).

 - Fix up Energy Model kerneldoc comments and include them in the
   Energy Model documentation (Lukasz Luba).

 - Use my kernel.org address in MAINTAINERS insead of the personal
   one (Rafael Wysocki).

Thanks!


---------------

Lukasz Luba (2):
      PM: EM: fix kernel-doc comments
      Documentation: power: include kernel-doc in Energy Model doc

Prasad Sodagudi (1):
      PM: sleep: core: Avoid setting power.must_resume to false

Rafael J. Wysocki (3):
      ACPI: CPPC: Introduce cppc_get_nominal_perf()
      cpufreq: intel_pstate: hybrid: Rework HWP calibration
      MAINTAINERS: Change Rafael's e-mail address

Sergey Shtylyov (1):
      PM: sleep: wakeirq: drop useless parameter from dev_pm_attach_wake_irq()

---------------

 Documentation/power/energy-model.rst |  15 ++-
 MAINTAINERS                          |  20 ++--
 drivers/acpi/cppc_acpi.c             |  47 ++++++---
 drivers/base/power/main.c            |   2 +-
 drivers/base/power/wakeirq.c         |  11 +--
 drivers/cpufreq/intel_pstate.c       | 185 ++++++++++++++---------------------
 include/acpi/cppc_acpi.h             |   5 +
 include/linux/energy_model.h         |   8 +-
 8 files changed, 138 insertions(+), 155 deletions(-)
