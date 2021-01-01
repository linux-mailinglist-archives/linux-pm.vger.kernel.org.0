Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704DD2E8432
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jan 2021 17:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbhAAQwZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jan 2021 11:52:25 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39671 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbhAAQwY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jan 2021 11:52:24 -0500
Received: by mail-oi1-f180.google.com with SMTP id w124so24893229oia.6;
        Fri, 01 Jan 2021 08:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6C0H5B447SxC0+tQR+A4x4mQzaQpDNmiWJeKawHrJw4=;
        b=TJyRtRyfqY8Xb7kO0JsrXkCOV/+r3o3eQrlE5aCHmygu3ZqPLizDnJ+9uFXtRC97p2
         v7gFIwOkDErBcGHgEx+BQvYxkKrXWWV36TU9itGvsQwPmRixTLiIC3FvD7XXIfJy8e1M
         50labdu12uSrCEh3/33sU67PEyONUO1iL2k6SLDQboDUG8ou+xPRe81XIRjVDVYZazma
         OcZT7LBRJM7PmHXcafH8MUtQhaYHy127Fpq2fPjYDuF4ZbwJgLh+p2COjCMcnXukvJz9
         wH+Ior77Z9s8Ux/IaL2qzA1YDtprKmsAZ1kSL7YQewTwtHHsFLlH39SEdIgCxTh9/71D
         fzcw==
X-Gm-Message-State: AOAM532kzJMfwZzwaxob5pWKYp6ltu5phTOhN6z0cO7Et93ZYgsymsg1
        cbwIQo7hl4sK8Jbzg2klTZVQviAZvTnnzDUrcEXEirH1Ryw=
X-Google-Smtp-Source: ABdhPJwqT0DEA4vtgrGYVuZw0B8Me3Cg0BhQ43q7475HMAqJnZtggSq0Y3e7Ns35ICtWsefNMQBnpxkPY2MGPPnik6Q=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr10637508oig.69.1609519903563;
 Fri, 01 Jan 2021 08:51:43 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Jan 2021 17:51:32 +0100
Message-ID: <CAJZ5v0gTcaKg5NeP8Se-YekKDq=pT4Bu81G1RTdvhucBL3MaFg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.11-rc2
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

with top-most commit 0856ef671f314e27d42998470d07c6b428d23e64

 Merge branches 'pm-cpufreq', 'pm-cpuidle' and 'powercap'

on top of commit 5c8fe583cce542aa0b84adc939ce85293de36e5e

 Linux 5.11-rc1

to receive power management updates for 5.11-rc2.

These fix a crash in intel_pstate during resume from suspend-to-RAM
that may occur after recent changes and two resource leaks in error
paths in the operating performance points (OPP) framework, add a new
C-states table to intel_idle, update the cpuidle MAINTAINERS entry
to cover the governors too and add a new power capping facility
allowing aggregate power constraints to be applied to sets of devices
in a distributed manner.

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

 - Add new power capping facility called DTPM (Dynamic Thermal Power
   Management), based on the existing power capping framework, to
   allow aggregate power constraints to be applied to sets of devices
   in a distributed manner, along with a CPU backend driver based on
   the Energy Model (Daniel Lezcano).

Happy New Year!


---------------

Artem Bityutskiy (1):
      intel_idle: add SnowRidge C-state table

Daniel Lezcano (5):
      units: Add Watt units
      Documentation/powercap/dtpm: Add documentation for dtpm
      powercap/drivers/dtpm: Add API for dynamic thermal power management
      powercap/drivers/dtpm: Add CPU energy model based support
      powercap/drivers/dtpm: Fix __udivdi3 and __aeabi_uldivmod
unresolved symbols

Lukas Bulwahn (1):
      MAINTAINERS: include governors into CPU IDLE TIME MANAGEMENT FRAMEWORK

Quanyang Wang (1):
      opp: fix memory leak in _allocate_opp_table

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Fix fast-switch fallback path

Viresh Kumar (1):
      opp: Call the missing clk_put() on error

---------------

 Documentation/power/index.rst         |   1 +
 Documentation/power/powercap/dtpm.rst | 212 +++++++++++++++
 MAINTAINERS                           |   2 +-
 drivers/cpufreq/intel_pstate.c        |   1 -
 drivers/idle/intel_idle.c             |  41 ++-
 drivers/opp/core.c                    |   9 +-
 drivers/powercap/Kconfig              |  13 +
 drivers/powercap/Makefile             |   2 +
 drivers/powercap/dtpm.c               | 473 ++++++++++++++++++++++++++++++++++
 drivers/powercap/dtpm_cpu.c           | 257 ++++++++++++++++++
 include/asm-generic/vmlinux.lds.h     |  11 +
 include/linux/cpuhotplug.h            |   1 +
 include/linux/dtpm.h                  |  77 ++++++
 include/linux/units.h                 |   4 +
 14 files changed, 1099 insertions(+), 5 deletions(-)
