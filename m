Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7471009A6
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfKRQqu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:46:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47054 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRQqu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:46:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id o65so14366493lff.13;
        Mon, 18 Nov 2019 08:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phMD8PdGXzZHxIPzUIGGOTL/baj6HbkviILSGV70YKs=;
        b=vBpuzV4SNFWuCGyOtxImv/mAsJr7JwC4RvaOejCdwmpx56d778BFkGB5aXiMMAuwih
         w2in/AVltkhsCEwVKFHkpeCM9vVbnrXdVbASrrzAHrlp0Rrph+jejExUEylaI21QTolT
         RRb7D17SE3Ff/L8Qw5JI/1O7zR1jhAdulIH/XhAA0buMR3cw2TnipbgZRb/6QyeYRXDU
         lhxPBnJ8B5VWJEXTUYTvSK2wmmklt2W21LKbjhEtFnJ+DS8jnqfMW/SZUi/+Tvzh/OOU
         GaPp9mv2ZnFp8uQWBNvxxXHgPfEBApYJDD4S/7kO/4HMdq4z8TdMMd4xIyyYeohD6Qkd
         kMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phMD8PdGXzZHxIPzUIGGOTL/baj6HbkviILSGV70YKs=;
        b=BCmB7UDi34ZBvGfiLo//l5bUsR4CNDFaOvIz16ZQdsO76KciTu1Rih7NlLxlecRMYa
         cHfICk2fWFuBquFd7i05cXCGeEiaHebXj2tNpjUlkKe3mnTlqpNX6Q7FalfeLGUMurgy
         E3RlCqhSwqYbPiu/m5dVaAUrdgA0ZXwq+Ta21P8yLuRTniLONbdPb+h25FRPVeGg1NBt
         l7QJ0Zb2bBDvPdFo5W7imy+LMNH650PGJhdrC4zCT1/5pYgE2rbvvcvvzDGy9NT3YNwI
         Y291okZJpZxLCDWTZvFOMucUcttnCc9IzgiaL64tHcIkkF97jcI+ZIMu0Tfed/bOzHBh
         jxlg==
X-Gm-Message-State: APjAAAUAIvqid80tooc+ze5XY0QjdyxV/sM0GWuifalx0VQNSfSdc7OF
        BXwDxcM+J40paSsl+8zA8ZU=
X-Google-Smtp-Source: APXvYqwT/6HhtDPNmdYtw10DaxhKzpq/rf6PjbXXv7ZS/RPO+DeC4MueWjz2+1WYGFgnAcRQKuWqrw==
X-Received: by 2002:ac2:5930:: with SMTP id v16mr295569lfi.34.1574095605353;
        Mon, 18 Nov 2019 08:46:45 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d4sm8880307lfi.32.2019.11.18.08.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:46:44 -0800 (PST)
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
Subject: [PATCH v5 00/11] NVIDIA Tegra20 CPUFreq driver major update
Date:   Mon, 18 Nov 2019 19:45:01 +0300
Message-Id: <20191118164512.8676-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
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

Dmitry Osipenko (11):
  clk: tegra: Add custom CCLK implementation
  clk: tegra: pll: Add pre/post rate-change hooks
  clk: tegra: cclk: Add helpers for handling PLLX rate changes
  clk: tegra20: Use custom CCLK implementation
  clk: tegra30: Use custom CCLK implementation
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs
  cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
    now)
  ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
  ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
  ARM: dts: tegra30: beaver: Add CPU Operating Performance Points

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |  56 +++++
 arch/arm/boot/dts/tegra30-beaver.dts          |  40 +++-
 arch/arm/mach-tegra/tegra.c                   |   4 +
 drivers/clk/tegra/Makefile                    |   1 +
 drivers/clk/tegra/clk-pll.c                   |  12 +-
 drivers/clk/tegra/clk-tegra-super-cclk.c      | 212 +++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c               |   7 +-
 drivers/clk/tegra/clk-tegra30.c               |   6 +-
 drivers/clk/tegra/clk.h                       |  19 +-
 drivers/cpufreq/Kconfig.arm                   |   6 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/tegra20-cpufreq.c             | 217 +++++-------------
 12 files changed, 408 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c

-- 
2.23.0

