Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B60125327
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLRUWA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:22:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34831 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLRUWA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:22:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so3605447lja.2;
        Wed, 18 Dec 2019 12:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtEVFnGJINCR9qdgeNTLl9Iezjdl4uCMMEdcoYEbS70=;
        b=t0R0pnnfVQHvQIHKXmJVqEP8VKFj0cflRQOpvYWiv9pMirW+hE9PVRNNaibfCM+Qwa
         rv1ch0N/1Pjtl3pdPT6grwOxmFvXbAnV5AMUEPnFSzJt+rvEuD1q7xbtqnkWlbTfHeXX
         o9CGf4yn19WR7JCq42UE+PxOwHbGrfI/sC972Qj5ms1W6r0oxwaq2W5TtVFd8o2l8n3V
         WWT229TTMS4oTE1icMq1OZG2EAEn3TVvz1M3nfE4xPopM2uEkeTyFcyCRxIU9lPj5TR+
         D84eElz5PRLODIYAoOzv3qTPk+zK+0d9IoulhGJl+q2g8fkIG03F5hhrisA/bETwl++c
         /Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtEVFnGJINCR9qdgeNTLl9Iezjdl4uCMMEdcoYEbS70=;
        b=cP1e3MQoATt6NgiVb9B5aClgE5cdzysWG0VXb6VOr/LfqCAA+13gHLCZl7wBEl2Yrt
         X7dh4ou2P3sDQI34GYkgTlQmAaFkinFdTmhVlHQk3JPTgC31ByNrdRayt8KfFRKQZW7z
         wReBUVPBibg+UKVVIsQhO1rMyNgWqjXRji0D4c+oztnAVMhWx0z+X6zm9/7Tx88VRxsz
         6m5BQ6S2ZKFJvf7PV58PPk+cjns2frUdWEtG3McR4+qnKbS6kKqZpP+Ilal0GmhbfDI4
         sUvRaU+mmYga+nPFh/av9bpkFD9g5k4+vOTI/DKR8Xi4NczCAVDUxCWLezlOKneOGitY
         Hm+A==
X-Gm-Message-State: APjAAAU87pBDB0d/RhWH38FUpAP8B1gJxtNsbeTLwZOuqaC/Ll33HODc
        +IyKPLps8B/DBGCju2wp5YA=
X-Google-Smtp-Source: APXvYqzrXin87Hljh20uNuC15KNrulAj9wSJXynQXv6ntsEYID8IxgL1yozYoPPQFJ9/Pxn+46ojAQ==
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr3162842ljk.245.1576700517353;
        Wed, 18 Dec 2019 12:21:57 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:21:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/12] NVIDIA Tegra20 CPUFreq driver major update
Date:   Wed, 18 Dec 2019 23:21:30 +0300
Message-Id: <20191218202142.11717-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series moves intermediate-clk handling from tegra20-cpufreq into
tegra-clk driver. This allows us to switch to generic cpufreq-dt driver
which brings voltage scaling, per-hardware OPPs and Tegra30 support out
of the box. All boards need to adopt CPU OPPs in their device-trees in
order to get cpufreq support.

Changelog:

v6: - Dropped "cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs"
      patch from the series since Viresh picked up that patch separately.

    - Added two new patches to this series:

        ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
        ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30

      Previously these patches were sent out separately from this series,
      but it should be more consistent to include them into the series since
      they directly relate to enabling of the cpufreq driver on Tegra30.

v5: - The "Use generic cpufreq-dt driver (Tegra30 supported now)" patch
      is separated now into two patches by factoring out the blacklisting
      of cpufreq-dt-platdev into a standalone patch. This is done in a
      response to request from Jon Hunter to fix the warning splats during
      boot that are coming from OPP core because OPPs are unavailable. The
      OPPs will become available once tegra20-cpufreq driver will be updated
      to support the cpufreq-dt.

v4: - Updated CCLK diagram in the "Add custom CCLK implementation" patch.

    - <linux/cpu.h> is now included in the "Use generic cpufreq-dt driver"
      patch, for consistency.

    - Returned value of get_cpu_device() is now checked in the "Use generic
      cpufreq-dt driver" patch, for consistency as well.

v3: - The "Add custom CCLK implementation" patch was updated in accordance
      to the comments from Peter De Schrijver. We will not use the clock
      skipper.

    - Re added OPPs for T30 Beaver board because Thierry has that board ;)

    - Added r-b for the "DT binding" patch from Rob Herring.

v2: - Kept modularity of the tegra20-cpufreq as was requested by Viresh Kumar
      in a review comment to v1.

    - Added acks from Viresh Kumar.

    - Added tested-by from Nicolas Chauvet to the "trimslice" patch.
      Nicolas told me on IRC that it works fine.

    - Fixed compilation of the "Add custom CCLK implementation" patch. The
      error happened because v1 was based on top of yet unreviewed/unapplied
      patch "clk: tegra: divider: Support enable-bit for Super clocks".
      Thanks to Peter Geis for reporting the problem.

    - Replaced Tegra30 "beaver" board with "cardhu-a04" because turned out
      that's what NVIDIA uses in the testing farm.

Dmitry Osipenko (12):
  clk: tegra: Add custom CCLK implementation
  clk: tegra: pll: Add pre/post rate-change hooks
  clk: tegra: cclk: Add helpers for handling PLLX rate changes
  clk: tegra20: Use custom CCLK implementation
  clk: tegra30: Use custom CCLK implementation
  ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
  ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
    now)
  ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
  ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
  ARM: dts: tegra30: beaver: Add CPU Operating Performance Points

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |  56 +++++
 arch/arm/boot/dts/tegra30-beaver.dts          |  40 +++-
 arch/arm/mach-tegra/sleep-tegra30.S           |  18 +-
 arch/arm/mach-tegra/tegra.c                   |   4 +
 drivers/clk/tegra/Makefile                    |   1 +
 drivers/clk/tegra/clk-pll.c                   |  12 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c      | 212 +++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c               |   7 +-
 drivers/clk/tegra/clk-tegra30.c               |   6 +-
 drivers/clk/tegra/clk.h                       |  19 +-
 drivers/cpufreq/Kconfig.arm                   |   6 +-
 drivers/cpufreq/tegra20-cpufreq.c             | 217 +++++-------------
 12 files changed, 418 insertions(+), 180 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c

-- 
2.24.0

