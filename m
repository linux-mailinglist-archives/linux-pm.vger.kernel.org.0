Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F415B502
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgBLXqc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:46:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43397 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLXqb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so4415561ljm.10;
        Wed, 12 Feb 2020 15:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZN0eR+MlbTG+jtIAem/YdJyWllF55za1q3k6zHdgMmU=;
        b=J8YMlsQRXh/PWKTkaxJT8iR3O87HjnuuCR62rrp0vDQuZ9hGclVV3JphgpZC5LyOQM
         dZEoGBQEU+SyMTAAqNfMqqGkDTqNze9AcZ3XQmU0FlmmWySYxW5xGFGwaK7tuwyTWHR/
         vxM/PtASB86La0/IUPul2idxkzdrX5HdNTigy7s/VygP1gLn8ulggOFVcUPGs6vTgG9b
         ee/MHKOKj+KUAA/jql78A9nlk1j/MBM9Kc6tuUMRVhvfqvU0Q0O6xRTpNeOPKCNdclcV
         eqMIO5y+1bEQXZqda3uYxrSKS0PW7FrFtSqTKbTxLD4eFkcBhYnOsic0FByhWDxp21/m
         6QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZN0eR+MlbTG+jtIAem/YdJyWllF55za1q3k6zHdgMmU=;
        b=J9eWFmdZa13VBo0JgT5h5L70IjQPCvrnW97KXXd1iaFI/Sh313Y67UWKWSNmMJbkrT
         +vI5MSDTBc9QFvfHF44YboAT6geKx36TKIFp6ilgZuK6lTyXmxFPjr+JBrCkwAU+j3Ak
         tjRTAIouol60KWQsdIcqsYP6Ag3GAw4IZs3+EQ4wI/nanOt434Bh7LbEYYhfUbUcGGzM
         mV5UcCuMWktvUSUe2hQ4V6+l1q3CuCF6L/PS7xJWMF41pomgoE9ikzOlTMHQO6ZZpbZQ
         AqhKXlgcDaI2chpCpmqbuSoqG6Fy0NOqjTduSLqYJXd0Ttg6/LvjkUBTqtqMEgwRZKxN
         Aogg==
X-Gm-Message-State: APjAAAUSEUSsUz8Ekr2otNwba3XG6lIJ9rfnZWLVKpDXAfAl9s9oiZ2J
        xQ2zWUtCX+GzrWJvnSbl8FY=
X-Google-Smtp-Source: APXvYqxHWD54LlyxDzOWUXKmLuxx2rMLtoPbna7MGldJwQmMmyPSOO/X0wGnoktRJWGi8Es22UreIQ==
X-Received: by 2002:a2e:9618:: with SMTP id v24mr9204006ljh.181.1581551188927;
        Wed, 12 Feb 2020 15:46:28 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:28 -0800 (PST)
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/12] NVIDIA Tegra20 CPUFreq driver major update
Date:   Thu, 13 Feb 2020 02:45:55 +0300
Message-Id: <20200212234607.11521-1-digetx@gmail.com>
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

v7: - Added acks from Peter De Schrijver.

    - Added tested-by from Marcel Ziswiler, Peter Geis, Jasper Korten and
      David Heidelberg who tested these patches on Apalis/Colibri devboards,
      Ouya, TF300T and Nexus 7 devices respectively.

    - Rebased series on top of recent linux-next.

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
 arch/arm/mach-tegra/sleep-tegra30.S           |  16 +-
 arch/arm/mach-tegra/tegra.c                   |   4 +
 drivers/clk/tegra/Makefile                    |   1 +
 drivers/clk/tegra/clk-pll.c                   |  12 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c      | 212 +++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c               |   7 +-
 drivers/clk/tegra/clk-tegra30.c               |   6 +-
 drivers/clk/tegra/clk.h                       |  19 +-
 drivers/cpufreq/Kconfig.arm                   |   6 +-
 drivers/cpufreq/tegra20-cpufreq.c             | 217 +++++-------------
 12 files changed, 415 insertions(+), 181 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c

-- 
2.24.0

