Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22158F6EBA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 07:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfKKGwV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 01:52:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42803 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfKKGwV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 01:52:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id j12so7385566plt.9
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2019 22:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KRI1XTx3ScnO9o6hd8WFFLokdnrudXto4YZVvY+IIlE=;
        b=G5bZQ6wheJbnwPA1TWJbFmeyqZXSsp8hy8or4FsalmBamAhHXN1aGZ4BDhgbv+F0w3
         Sz7LCJyWpjIE9ODToR5ZkxAMJYRiI7F5w8kcCFsqCQtaOdR7B5PMimzq8wLtnjeXNvJt
         yX6Qpey+2Yy4eUrpvUWp7Y6rY6VoWxBeH8rBDSJ1i62j79WP4RgtKP9gDkBTXr2ivUmj
         VeoKprXaP63KTQwNIgnh4jNeIc2f07axJXfxzx5eWlRFCjjBcLImT/yDJqZo84C0/8Q9
         uvfbyTN7HhgIh+Mli1/DyjTsmseTuFx0+ZGkhk71B5nlTxqLhRN9sx7106uVmXsfcoGM
         rJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KRI1XTx3ScnO9o6hd8WFFLokdnrudXto4YZVvY+IIlE=;
        b=QKwEwkDnuX/oJMkIflQgfNmVY+2q6SN4qSfNPQwF9siGalMU3rtaNObAGT4RNGMJ5T
         N5sa85ExLRPfKl+uV2yybCW/OgB7zCtRNyW3Mf4p0D6Fjeyl7sGV0bJPiXf0mxdFyzpv
         +YOkEwPVllTpjN21eqDLwzctBOtti6zD3XMc38Em/leytLyHrfZZTg4VmtYHU7Nxl8gv
         8hwhjul5AZAckdWhdn3xevGsTYet4tgFIeNPRClaxXn7znoLMxRCFAN06Sm9+dwndiKR
         93+/61KIVzbCy6AXOd5iH5vmKEqvt1P68l5ufFPorVCSxkCfU3GG1PWhP1HssL2bolW7
         Eohg==
X-Gm-Message-State: APjAAAU0RpChk69P+7gGz/lBhjlvk1nUCcY0KGsA1ZrA3fBOl2q/7IxM
        jBzd160O7hUKegdyYFHPEDHswQ==
X-Google-Smtp-Source: APXvYqzIuJUteepvgHS33tgjIVqvWWUi53X45p7ZcUcm0NsZsAUoBn6FOyR3q0tcCws3bz+md+T1QQ==
X-Received: by 2002:a17:902:74c6:: with SMTP id f6mr24645391plt.167.1573455139599;
        Sun, 10 Nov 2019 22:52:19 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id c21sm12957327pgh.25.2019.11.10.22.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:52:18 -0800 (PST)
Date:   Mon, 11 Nov 2019 12:22:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm changes for 5.5
Message-ID: <20191111065213.zorc3mk6pz73xfl2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Updates to ti-cpufreq driver and DT files to support new platforms
  and migrate from opp-v1 bindings to opp-v2 bindings (H. Nikolaus
  Schaller and Adam Ford).

- Merging of arm_big_little and vexpress-spc drivers and related
  cleanup (Sudeep Holla).

- Fix for imx's default speed grade value (Anson Huang).

- Minor cleanup patch for s3c64xx (Nathan Chancellor).

- Fix CPU speed bin detection for sun50i (Ondrej Jirman).

--
viresh

-------------------------8<-------------------------

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to c23734487fb44ee16c1b007ba72d793c085e4ec4:

  cpufreq: sun50i: Fix CPU speed bin detection (2019-11-05 15:06:49 +0530)

----------------------------------------------------------------
Adam Ford (2):
      cpufreq: ti-cpufreq: Add support for AM3517
      ARM: dts: Add OPP-V2 table for AM3517

Anson Huang (1):
      cpufreq: imx-cpufreq-dt: Correct i.MX8MN's default speed grade value

H. Nikolaus Schaller (6):
      cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
      ARM: dts: omap34xx & omap36xx: replace opp-v1 tables by opp-v2 for
      DTS: bindings: omap: update bindings documentation
      ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap3630 or ti,am3517
      cpufreq: ti-cpufreq: omap36xx use "cpu0","vbb" if run in multi_regulator mode
      ARM: dts: omap36xx: using OPP1G needs to control the abb_ldo

Nathan Chancellor (1):
      cpufreq: s3c64xx: Remove pointless NULL check in s3c64xx_cpufreq_driver_init

Ondrej Jirman (1):
      cpufreq: sun50i: Fix CPU speed bin detection

Sudeep Holla (7):
      cpufreq: scpi: remove stale/outdated comment about the driver
      cpufreq: merge arm_big_little and vexpress-spc
      cpufreq: vexpress-spc: drop unnessary cpufreq_arm_bL_ops abstraction
      cpufreq: vexpress-spc: remove lots of debug messages
      cpufreq: vexpress-spc: fix some coding style issues
      cpufreq: vexpress-spc: use macros instead of hardcoded values for cluster ids
      cpufreq: vexpress-spc: find and skip duplicates when merging frequencies

 .../devicetree/bindings/arm/omap/omap.txt          |  30 +-
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     |   6 +-
 MAINTAINERS                                        |   5 +-
 arch/arm/boot/dts/am3517.dtsi                      |  31 +
 arch/arm/boot/dts/am3517_mt_ventoux.dts            |   2 +-
 arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts   |   2 +-
 arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts  |   2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   2 +-
 arch/arm/boot/dts/omap3-cm-t3530.dts               |   2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts               |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts       |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts       |   2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts             |   2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   2 +-
 arch/arm/boot/dts/omap3-ha-lcd.dts                 |   2 +-
 arch/arm/boot/dts/omap3-ha.dts                     |   2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts         |   2 +-
 arch/arm/boot/dts/omap3-igep0020.dts               |   2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts         |   2 +-
 arch/arm/boot/dts/omap3-igep0030.dts               |   2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts           |   2 +-
 arch/arm/boot/dts/omap3-n9.dts                     |   2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |   7 -
 arch/arm/boot/dts/omap3-n950.dts                   |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-alto35.dts     |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-gallop43.dts   |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-palo35.dts     |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-palo43.dts     |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-summit.dts     |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts    |   2 +-
 arch/arm/boot/dts/omap3-pandora-1ghz.dts           |   2 +-
 arch/arm/boot/dts/omap3-sbc-t3530.dts              |   2 +-
 arch/arm/boot/dts/omap3-sbc-t3730.dts              |   2 +-
 arch/arm/boot/dts/omap3-sniper.dts                 |   2 +-
 arch/arm/boot/dts/omap3-thunder.dts                |   2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  |   2 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |   2 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |  66 ++-
 arch/arm/boot/dts/omap36xx.dtsi                    |  65 +-
 drivers/cpufreq/Kconfig.arm                        |  12 +-
 drivers/cpufreq/Makefile                           |   2 -
 drivers/cpufreq/arm_big_little.c                   | 658 ---------------------
 drivers/cpufreq/arm_big_little.h                   |  43 --
 drivers/cpufreq/cpufreq-dt-platdev.c               |   2 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |  20 +-
 drivers/cpufreq/s3c64xx-cpufreq.c                  |   7 -
 drivers/cpufreq/scpi-cpufreq.c                     |   2 -
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |  25 +-
 drivers/cpufreq/ti-cpufreq.c                       | 119 +++-
 drivers/cpufreq/vexpress-spc-cpufreq.c             | 584 +++++++++++++++++-
 55 files changed, 904 insertions(+), 854 deletions(-)
 delete mode 100644 drivers/cpufreq/arm_big_little.c
 delete mode 100644 drivers/cpufreq/arm_big_little.h

