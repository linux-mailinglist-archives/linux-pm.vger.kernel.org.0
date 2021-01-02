Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E347F2E86DA
	for <lists+linux-pm@lfdr.de>; Sat,  2 Jan 2021 10:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbhABJ0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Jan 2021 04:26:19 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37156 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABJ0R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2021 04:26:17 -0500
Received: by mail-ot1-f53.google.com with SMTP id o11so21614922ote.4;
        Sat, 02 Jan 2021 01:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KK5Gao4CZ5cdO93e1SzQVnT1gWmX9YctRj6a2D3bYFQ=;
        b=uXYHGDzaIRSnoXm5JWGEmgu0KCvwH0ObzQmVQ5f2++wG67T5eMk8vvUmxZz2ZEA5Kw
         9iPMOiYrsA7NdQqJAa1GV8qS0rwnQNndcCAS1lvNKHzYz9iSmLtgCvj2JTj7680pV6dh
         GM1Co5yXpotybPV2lATWAbsDJNfcWEaUST9NiJSCP1uQCrhPHel8jfptfC6khEsSrVEj
         80+lepY/loXLxoBs9gdK435ZpcOJlDnnJ0SCgk9Oya+IZzvlCcpKSy5tkyFDw0X3r2+/
         FzGcNAZ/8cDDM8JDhCwCYxMK9250YKvDZVhDfX73Tej7Pz/LuCIFpQfkTfvKSYsYMj8M
         sXhQ==
X-Gm-Message-State: AOAM530W3r2eu24HsXgBVZBBu/BROj+jgviigxDHVo43YL5vgOL2OmZl
        hpV1QSSD/nVEPvmxFFgLx2ClEvRd0/IA69EjsV94GjeRYPU=
X-Google-Smtp-Source: ABdhPJxDkL8dxXpHTyOdCdI4k2DQ0nk6KBU9hzmiFARyueJt8m7Yuv6hNwk9yr/AWPoUj7PwLmxmkiZS4azU7UiK10o=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr47684597otn.321.1609579536875;
 Sat, 02 Jan 2021 01:25:36 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 2 Jan 2021 10:25:25 +0100
Message-ID: <CAJZ5v0j-4z07zeqcMNKCjG5dt59GAbKHq2xGnzAxUnNnFf3soA@mail.gmail.com>
Subject: [GIT PULL][Resend] Power management updates for v5.11-rc2
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
 pm-5.11-rc2

with top-most commit 89ecf09e0b93de54415de45be241649ec1b162de

 Merge branches 'pm-cpufreq' and 'pm-cpuidle'

on top of commit 5c8fe583cce542aa0b84adc939ce85293de36e5e

 Linux 5.11-rc1

to receive power management updates for 5.11-rc2.

These fix a crash in intel_pstate during resume from suspend-to-RAM
that may occur after recent changes and two resource leaks in error
paths in the operating performance points (OPP) framework, add a new
C-states table to intel_idle and update the cpuidle MAINTAINERS entry
to cover the governors too.

Specifics:

 - Fix recently introduced crash in the intel_pstate driver that
   occurs if scale-invariance is disabled during resume from
   suspend-to-RAM due to inconsistent changes of APERF or MPERF
   MSR values made by the platform firmware (Rafael Wysocki).

 - Fix a memory leak and add a missing clk_put() in error paths in
   the OPP framework (Quanyang Wang, Viresh Kumar).

 - Add new C-states table for SnowRidge processors to the intel_idle
   driver (Artem Bityutskiy).

 - Update the MAINTAINERS entry for cpuidle to make it clear that
   the governors are covered by it too (Lukas Bulwahn).

Thanks!


---------------

Artem Bityutskiy (1):
      intel_idle: add SnowRidge C-state table

Lukas Bulwahn (1):
      MAINTAINERS: include governors into CPU IDLE TIME MANAGEMENT FRAMEWORK

Quanyang Wang (1):
      opp: fix memory leak in _allocate_opp_table

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Fix fast-switch fallback path

Viresh Kumar (1):
      opp: Call the missing clk_put() on error

---------------

 MAINTAINERS                    |  2 +-
 drivers/cpufreq/intel_pstate.c |  1 -
 drivers/idle/intel_idle.c      | 41 ++++++++++++++++++++++++++++++++++++++++-
 drivers/opp/core.c             |  9 +++++++--
 4 files changed, 48 insertions(+), 5 deletions(-)
