Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EEC4294E1
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 18:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhJKQ7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 12:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhJKQ7b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 12:59:31 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B71AC061570;
        Mon, 11 Oct 2021 09:57:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EFDA84206F;
        Mon, 11 Oct 2021 16:57:23 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/9] Apple SoC CPU P-state switching
Date:   Tue, 12 Oct 2021 01:56:58 +0900
Message-Id: <20211011165707.138157-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi folks, here's a first attempt at cpufreq support for the Apple M1.
I'd appreciate any feedback on this approach.

The hardware in these SoCs is very simple: you just poke a single
register to change the performance state of a CPU cluster. There's
some init required on older firmware versions, but we're going to
say that's the bootloader's responsibility. This keeps the driver
nice and simple and generic and likely to work on future SoCs too.

However, there's a catch: the memory controller config should also be
modified when higher clock states are engaged on the P-cores, to
get optimal performance.

This series implements this using two drivers, on top of the existing
cpufreq-dt infrastructure. The cpu clock driver represents the p-state
switching as if it were a standard clock driver, so it can work with
cpufreq-dt. To do this, it also needs access to the OPP table, so it can
map the incoming clock frequences back to P-State index numbers, so that
is present in the binding. This might be a bit strange, since the same
OPP table is referenced by the CPUs themselves, and by the clocks driver
that provides the actual switching for them...

The memory controller stuff is implemented as a genpd provider that
exposes two performance states that the CPU OPP tables can depend on.
Unfortunately, the cpufreq path doesn't work properly for this, since
the CPUs aren't typical devices participating in runtime-pm. So instead
I opted to put that logic in the clock driver, which means it gets a
power-domains reference to the memory controller. This required a hack
to the OPP core so that it wouldn't complain about the missing parent
domain when evaluating the OPPs in the context of the CPUs...

The actual memory controller config is two magic numbers per performance
state. I'd love to find out what they do, but this seems unlikely
without docs or a deep memory performance analysis expedition... so I
think we're going to have to settle for this way, at least for now. If
things become better understood in the future, we can modify the binding
and keep the driver backwards-compatible with old DTs at least.

I did benchmark the CPU p-state switching, so the latency numbers there
have been experimentally measured. The CPU capacity numbers are also
based on real benchmarks (oddly enough, Dhrystone was a big outlier
here that was not representative of everything else, so we didn't use
it).

Patches:
 #1:   MAINTAINERS updates, split out so this can go through the SoC
       tree so we can spare all the subsystem maintainers the merge
       conflicts, since we have a bunch of other changes here going on
       in parallel.
 #2-3: DT bindings
 #4:   The aforementioned hack for the OPP core
 #5:   Add of_genpd_add_provider_simple_noclk()
 #6:   Memory controller driver
 #7:   CPU p-state clock driver
 #8:   Add some deps for ARCH_APPLE
 #9:   DT updates (for asahi-soc tree)

Hector Martin (9):
  MAINTAINERS: apple: Add apple-mcc and clk-apple-cluster paths
  dt-bindings: memory-controller: Add apple,mcc binding
  dt-bindings: clock: Add apple,cluster-clk binding
  opp: core: Don't warn if required OPP device does not exist
  PM: domains: Add of_genpd_add_provider_simple_noclk()
  memory: apple: Add apple-mcc driver to manage MCC perf in Apple SoCs
  clk: apple: Add clk-apple-cluster driver to manage CPU p-states
  arm64: apple: Select MEMORY and APPLE_MCC
  arm64: apple: Add CPU frequency scaling support for t8103

 .../bindings/clock/apple,cluster-clk.yaml     | 115 ++++++++
 .../memory-controllers/apple,mcc.yaml         |  80 ++++++
 .../opp/apple,mcc-operating-points.yaml       |  62 +++++
 MAINTAINERS                                   |   5 +
 arch/arm64/Kconfig.platforms                  |   2 +
 arch/arm64/boot/dts/apple/t8103.dtsi          | 255 +++++++++++++++++-
 drivers/base/power/domain.c                   |  39 ++-
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-apple-cluster.c               | 184 +++++++++++++
 drivers/memory/Kconfig                        |   9 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/apple-mcc.c                    | 130 +++++++++
 drivers/opp/core.c                            |   5 +-
 include/linux/pm_domain.h                     |   8 +
 15 files changed, 887 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,cluster-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml
 create mode 100644 drivers/clk/clk-apple-cluster.c
 create mode 100644 drivers/memory/apple-mcc.c

-- 
2.33.0

