Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE31EBE0
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEOKNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 06:13:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37694 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfEOKNh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 06:13:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id r10so1735577otd.4;
        Wed, 15 May 2019 03:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9xOI019t6geviZFQ6nXstXkuFlhiizAHM2keu/WCijg=;
        b=B9189US+CY0DZfZBs0ICIxuyfMjXbcsay5PasbKF9vDoiZJm8iqgfo8DdC2LyC1ZWK
         MxBgGV+vTPcCE8i6WDyxJPE34mOaZ/6a+KF2xh4XDbdl1A4nc1iJkilW/c6luZpjnIqs
         LtUxkqEIGuuAdRYwoyD8E3k060Ifgc9zK/P8/q8UutC49D8k3RnRuTiGn7ks8HEVZDqd
         FEDF7DYP61nMDfP+nuqhA1ItybtQ2Fh+2hXKD7Jg/Xw9V2+z8rMPG450X8em/wXjjKjx
         ExDMgJV8MnYWozFvFQAenJBcx/5eSsbX3fWIwGriVN9WuhI1Rj54eW7x0jMJpWTHZx/R
         tubA==
X-Gm-Message-State: APjAAAVvsrDkrbuYrVbv3ciG7R9Npf1V37Ps+1BlYAQbLblL9ENrcM1q
        m9luTKdKSh/ZDJN3xqNPUGjoX2c7lVLPg+o9p+Uz071y
X-Google-Smtp-Source: APXvYqyG/AzgMYd+lwEhkAqsw9Zwb9DgfqALGbneSlSUwkqcw4AKouh0DmlrAMleJU8+PVk/mh3mnlt7V5L4cVHhnW8=
X-Received: by 2002:a9d:6a14:: with SMTP id g20mr3744980otn.310.1557915216649;
 Wed, 15 May 2019 03:13:36 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 May 2019 12:13:25 +0200
Message-ID: <CAJZ5v0i-sU2cXVdVUW1CCvbCmaTsqphXYXocS=ufeGFAChYOag@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.2-rc1-2

with top-most commit 2a8d69f6139b605b2e36c80540cb8e8da2d016be

 Merge branches 'pm-cpufreq' and 'pm-domains'

on top of commit 8f5e823f9131a430b12f73e9436d7486e20c16f5

 Merge tag 'pm-5.2-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 5.2-rc1.

These fix a recent regression causing kernels built with CONFIG_PM
unset to crash on systems that support the Performance and Energy
Bias Hint (EPB), clean up the cpufreq core and some users of
transition notifiers and introduce a new power domain flag into
the generic power domains framework (genpd).

Specifics:

 - Fix recent regression causing kernels built with CONFIG_PM
   unset to crash on systems that support the Performance and
   Energy Bias Hint (EPB) by avoiding to compile the EPB-related
   code depending on CONFIG_PM when it is unset (Rafael Wysocki).

 - Clean up the transition notifier invocation code in the cpufreq
   core and change some users of cpufreq transition notifiers
   accordingly (Viresh Kumar).

 - Change MAINTAINERS to cover the schedutil governor as part of
   cpufreq (Viresh Kumar).

 - Simplify cpufreq_init_policy() to avoid redundant computations
   (Yue Hu).

 - Add explanatory comment to the cpufreq core (Rafael Wysocki).

 - Introduce a new flag, GENPD_FLAG_RPM_ALWAYS_ON, to the generic
   power domains (genpd) framework along with the first user of it
   (Leonard Crestez).

Thanks!


---------------

Leonard Crestez (2):
      PM / Domains: Add GENPD_FLAG_RPM_ALWAYS_ON flag
      soc: imx: gpc: Use GENPD_FLAG_RPM_ALWAYS_ON for ERR009619

Rafael J. Wysocki (2):
      x86: intel_epb: Take CONFIG_PM into account
      cpufreq: Explain the kobject_put() in cpufreq_policy_alloc()

Viresh Kumar (2):
      cpufreq: Call transition notifier only once for each policy
      cpufreq: Update MAINTAINERS to include schedutil governor

Yue Hu (1):
      cpufreq: Don't find governor for setpolicy drivers in
cpufreq_init_policy()

---------------

 MAINTAINERS                     |   2 +
 arch/arm/kernel/smp.c           |  24 ++++---
 arch/sparc/kernel/time_64.c     |  28 ++++----
 arch/x86/kernel/cpu/intel_epb.c |  22 ++++++-
 arch/x86/kernel/tsc.c           |   2 +-
 arch/x86/kvm/x86.c              |  31 +++++----
 drivers/base/power/domain.c     |   8 ++-
 drivers/cpufreq/cpufreq.c       | 140 +++++++++++++++++++++++-----------------
 drivers/soc/imx/gpc.c           |  13 +++-
 include/linux/cpufreq.h         |  14 ++--
 include/linux/pm_domain.h       |   4 ++
 11 files changed, 183 insertions(+), 105 deletions(-)
