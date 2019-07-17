Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F79D6BF5D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGQPyM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 11:54:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:62552 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfGQPyL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jul 2019 11:54:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 08:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="191305404"
Received: from hongfuwa-mobl.ccr.corp.intel.com ([10.249.175.161])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2019 08:54:10 -0700
Message-ID: <1563378848.2363.17.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v5.3-rc1
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Date:   Wed, 17 Jul 2019 23:54:08 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v5.3-rc1 with
top-most commit 6c395f66e98c895cf3ebf87c0b2fc63b6a57a196:

  drivers: thermal: processor_thermal_device: Fix build warning (2019-
07-09 21:19:12 +0800)

on top of commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

Specifics:
 - Covert thermal documents to ReST. (Mauro Carvalho Chehab)
 - Fix a cyclic depedency in between thermal core and governors.
(Daniel Lezcano)
 - Fix processor_thermal_device driver to re-evaluate power limits
after resume. (Srinivas Pandruvada, Zhang Rui)

thanks,
rui


----------------------------------------------------------------
Daniel Lezcano (2):
      thermal/drivers/core: Add init section table for self-
encapsulation
      thermal/drivers/core: Use governor table to initialize

Mauro Carvalho Chehab (1):
      docs: thermal: convert to ReST

Srinivas Pandruvada (1):
      drivers: thermal: processor_thermal: Read PPCC on resume

Zhang Rui (2):
      Merge branches 'thermal-core' and 'thermal-intel' into next
      drivers: thermal: processor_thermal_device: Fix build warning

 .../{cpu-cooling-api.txt => cpu-cooling-api.rst}   |  39 +-
 .../thermal/{exynos_thermal => exynos_thermal.rst} |  47 +-
 Documentation/thermal/exynos_thermal_emulation     |  53 ---
 Documentation/thermal/exynos_thermal_emulation.rst |  61 +++
 Documentation/thermal/index.rst                    |  18 +
 .../{intel_powerclamp.txt => intel_powerclamp.rst} | 183 ++++----
 .../{nouveau_thermal => nouveau_thermal.rst}       |  54 ++-
 .../{power_allocator.txt => power_allocator.rst}   | 144 +++---
 .../thermal/{sysfs-api.txt => sysfs-api.rst}       | 488
++++++++++++++-------
 ...ure_thermal => x86_pkg_temperature_thermal.rst} |  28 +-
 MAINTAINERS                                        |   2 +-
 drivers/thermal/fair_share.c                       |  12 +-
 drivers/thermal/gov_bang_bang.c                    |  11 +-
 .../int340x_thermal/processor_thermal_device.c     |  18 +
 drivers/thermal/power_allocator.c                  |  11 +-
 drivers/thermal/step_wise.c                        |  11 +-
 drivers/thermal/thermal_core.c                     |  52 ++-
 drivers/thermal/thermal_core.h                     |  55 +--
 drivers/thermal/user_space.c                       |  12 +-
 include/asm-generic/vmlinux.lds.h                  |  11 +
 include/linux/thermal.h                            |   4 +-
 21 files changed, 771 insertions(+), 543 deletions(-)
 rename Documentation/thermal/{cpu-cooling-api.txt => cpu-cooling-
api.rst} (82%)
 rename Documentation/thermal/{exynos_thermal => exynos_thermal.rst}
(67%)
 delete mode 100644 Documentation/thermal/exynos_thermal_emulation
 create mode 100644 Documentation/thermal/exynos_thermal_emulation.rst
 create mode 100644 Documentation/thermal/index.rst
 rename Documentation/thermal/{intel_powerclamp.txt =>
intel_powerclamp.rst} (76%)
 rename Documentation/thermal/{nouveau_thermal => nouveau_thermal.rst}
(64%)
 rename Documentation/thermal/{power_allocator.txt =>
power_allocator.rst} (74%)
 rename Documentation/thermal/{sysfs-api.txt => sysfs-api.rst} (66%)
 rename Documentation/thermal/{x86_pkg_temperature_thermal =>
x86_pkg_temperature_thermal.rst} (80%)
