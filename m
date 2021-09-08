Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45763403C8F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349610AbhIHPfW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:35:22 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:38529 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbhIHPfW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Sep 2021 11:35:22 -0400
Received: by mail-oi1-f179.google.com with SMTP id bd1so3586457oib.5;
        Wed, 08 Sep 2021 08:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=83jEoiM0ZDoIZ+9YoaEUGK/l0iVM2e6CvU/M4LGLntQ=;
        b=25YT7HxeLLtY79q0uS4m1A70KfGS5pQPGXSpzRizgQ8Nc72rElabF56zz2a2rEKYO0
         PnK7mjCLmsF6qndlTHY52mJKiQu3SKUqMnDaPTwkYz3ZtfITLxicLFZcfmgHkHKlx6RB
         i1xk+GXMM02pKqX5KQxnKq67Uzc7A0SuhY+86lWhM/HYxuMSm/iA9Xg4uXKk5qbYvx1u
         IqX+vVxqLwn26JW5eOYK7MhnNXhcZ+xXJ9jDscKFBgI0zrpJsCp40to1z384fs6C5Exf
         R+ufk2Kwz86VEDqz1q4FxrO63g4YnSL7Hbp6FEoyeXsA9qhdKQAM3rrSjgSnt5wi6au2
         t07A==
X-Gm-Message-State: AOAM530W1VXwZuB66eQJvSWfm6pmeth/wbNT4sNSmRQDThFc3fOI8/F7
        5pogQrHVvSohJVHnRuP9mB/eAQmz1L+d0HSAviEYDd9s/GY=
X-Google-Smtp-Source: ABdhPJzBiNI0BWFQw0ZS7oFvDcl9cR3u7nEplbvg4S83Le5hfLdavZoDzNL0DM/eli/rI3plGXUCUEewVDS5NufunaU=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr2656528ois.69.1631115254083;
 Wed, 08 Sep 2021 08:34:14 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Sep 2021 17:34:03 +0200
Message-ID: <CAJZ5v0iscRcftKWp-mUo6ennD0iPP=dQsZ1uTueycuT5fxAF=w@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.15-rc1
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
 pm-5.15-rc1-2

with top-most commit f76c87e8c33766cc6a7bf7461dfac9cebb05b5df

 Merge branch 'pm-opp'

on top of commit 5cbba60596b1f32f637190ca9ed5b1acdadb852c

 Merge tag 'pm-5.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.15-rc1.

These are mostly ARM cpufreq driver updates, including one new
MediaTek driver that has just passed all of the reviews, with the
addition of a revert of a recent intel_pstate commit, some core
cpufreq changes and a DT-related update of the operating performance
points (OPP) support code.

Specifics:

 - Add new cpufreq driver for the MediaTek MT6779 platform called
   mediatek-hw along with corresponding DT bindings (Hector.Yuan).

 - Add DCVS interrupt support to the qcom-cpufreq-hw driver (Thara
   Gopinath).

 - Make the qcom-cpufreq-hw driver set the dvfs_possible_from_any_cpu
   policy flag (Taniya Das).

 - Blocklist more Qualcomm platforms in cpufreq-dt-platdev (Bjorn
   Andersson).

 - Make the vexpress cpufreq driver set the CPUFREQ_IS_COOLING_DEV
   flag (Viresh Kumar).

 - Add new cpufreq driver callback to allow drivers to register
   with the Energy Model in a consistent way and make several
   drivers use it (Viresh Kumar).

 - Change the remaining users of the .ready() cpufreq driver callback
   to move the code from it elsewhere and drop it from the cpufreq
   core (Viresh Kumar).

 - Revert recent intel_pstate change adding HWP guaranteed performance
   change notification support to it that led to problems, because
   the notification in question is triggered prematurely on some
   systems (Rafael Wysocki).

 - Convert the OPP DT bindings to DT schema and clean them up while
   at it (Rob Herring).

Thanks!


---------------

Bjorn Andersson (1):
      cpufreq: blocklist more Qualcomm platforms in cpufreq-dt-platdev

Hector.Yuan (3):
      dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
      cpufreq: Add of_perf_domain_get_sharing_cpumask
      cpufreq: mediatek-hw: Add support for CPUFREQ HW

Rafael J. Wysocki (1):
      Revert "cpufreq: intel_pstate: Process HWP Guaranteed change notification"

Rob Herring (3):
      ARM: dts: omap: Drop references to opp.txt
      dt-bindings: Clean-up OPP binding node names in examples
      dt-bindings: opp: Convert to DT schema

Taniya Das (1):
      cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu cpufreq driver flag

Thara Gopinath (1):
      cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support

Viresh Kumar (13):
      cpufreq: vexpress: Set CPUFREQ_IS_COOLING_DEV flag
      cpufreq: Add callback to register with energy model
      cpufreq: dt: Use .register_em() to register with energy model
      cpufreq: imx6q: Use .register_em() to register with energy model
      cpufreq: mediatek: Use .register_em() to register with energy model
      cpufreq: omap: Use .register_em() to register with energy model
      cpufreq: qcom-cpufreq-hw: Use .register_em() to register with energy model
      cpufreq: scpi: Use .register_em() to register with energy model
      cpufreq: vexpress: Use .register_em() to register with energy model
      cpufreq: scmi: Use .register_em() to register with energy model
      cpufreq: acpi: Remove acpi_cpufreq_cpu_ready()
      cpufreq: sh: Remove sh_cpufreq_cpu_ready()
      cpufreq: Remove ready() callback

---------------

 Documentation/cpu-freq/cpu-drivers.rst             |   3 -
 .../devicetree/bindings/cpufreq/cpufreq-dt.txt     |   2 +-
 .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  70 +++
 .../bindings/cpufreq/cpufreq-mediatek.txt          |   2 +-
 .../devicetree/bindings/cpufreq/cpufreq-st.txt     |   6 +-
 .../bindings/cpufreq/nvidia,tegra20-cpufreq.txt    |   2 +-
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     |   2 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |   2 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |   2 +-
 .../bindings/interconnect/fsl,imx8m-noc.yaml       |   4 +-
 .../opp/allwinner,sun50i-h6-operating-points.yaml  |   4 +
 Documentation/devicetree/bindings/opp/opp-v1.yaml  |  51 ++
 .../devicetree/bindings/opp/opp-v2-base.yaml       | 214 +++++++
 Documentation/devicetree/bindings/opp/opp-v2.yaml  | 475 ++++++++++++++++
 Documentation/devicetree/bindings/opp/opp.txt      | 622 ---------------------
 Documentation/devicetree/bindings/opp/qcom-opp.txt |   2 +-
 .../bindings/opp/ti-omap5-opp-supply.txt           |   2 +-
 .../devicetree/bindings/power/power-domain.yaml    |   2 +-
 .../translations/zh_CN/cpu-freq/cpu-drivers.rst    |   2 -
 arch/arm/boot/dts/omap34xx.dtsi                    |   1 -
 arch/arm/boot/dts/omap36xx.dtsi                    |   1 -
 drivers/base/arch_topology.c                       |   2 +
 drivers/cpufreq/Kconfig.arm                        |  12 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/acpi-cpufreq.c                     |  14 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   4 +
 drivers/cpufreq/cpufreq-dt.c                       |   3 +-
 drivers/cpufreq/cpufreq.c                          |  17 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   2 +-
 drivers/cpufreq/intel_pstate.c                     |  39 --
 drivers/cpufreq/mediatek-cpufreq-hw.c              | 308 ++++++++++
 drivers/cpufreq/mediatek-cpufreq.c                 |   3 +-
 drivers/cpufreq/omap-cpufreq.c                     |   2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 151 ++++-
 drivers/cpufreq/scmi-cpufreq.c                     |  65 ++-
 drivers/cpufreq/scpi-cpufreq.c                     |   3 +-
 drivers/cpufreq/sh-cpufreq.c                       |  11 -
 drivers/cpufreq/vexpress-spc-cpufreq.c             |  25 +-
 include/linux/cpufreq.h                            |  75 ++-
 39 files changed, 1441 insertions(+), 767 deletions(-)
