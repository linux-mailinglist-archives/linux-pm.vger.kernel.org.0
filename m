Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924DD35B9EC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 07:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhDLFsy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhDLFsx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 01:48:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3FC061574
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 22:48:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w10so8521791pgh.5
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 22:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=1ZDEIPC4lhuF2vPy1dlt6jULZrDyKQoqH+8iH2kFXMg=;
        b=k5+oaqSwmzCWbu88vLcy4s57eLb7ceeqUwDlKHLhfdChmfeumntBnSs8Gw3hvEPPkw
         ymDngDszgPmlBSUhw3FhRhlzNNoJ36gYvB4RXJzGx0C/QDVMM+dYnycGcYo0BH+FE9AT
         x3vDQRN2qJNsaxvWFEHvlH/APBdKlbM30jxffUN/mDdeKARvOHRLj35/56wygmnOlEC2
         Ztm3HiEqjqJP4UVntI+wDJfnZLwsxNDZAeDaZgfXIHz41/QNk0Y8evNIpWJQj+Wh8z2d
         Vagctr+Zg2iunIjpu61evgg/TqU1dWU77J1W1S9qQ2+MCmAxOAW7joeEbAWDic1lpRR1
         85yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=1ZDEIPC4lhuF2vPy1dlt6jULZrDyKQoqH+8iH2kFXMg=;
        b=S/FIhver9JtvDykSVOSsnXrKU28KQtZKqIGkfomSs+PMtBA9MQXa7Af3cRCbqLAUqu
         DOKkrpqmRHhETlo5J8mh2X3j/PMScBW1LKNFFeA7RJDHcjchi4F8pSWYj6fijL1bB9vx
         fcceN14tMuej3K7REyrByba9SOpZzViZPO/hP0qnmxyKnEF7wupo2tJqiGV7FwjgxXte
         fBBsFGDT4NQjQ2YC1DyLZVFsjQjSrFMBaw++tmoR1wX3yt2xpBbAdelNPUOqKJm1jLEP
         jC4Jqblj/jpcairMERedSDZp0zyBjfAja2RZaffOGXdqN5pOODVI/vddFSlRjq3R6vuy
         Cw7A==
X-Gm-Message-State: AOAM533VjtaHwjp3FWrBxBwFUwk58WBewQYFVZ41ZELjpegdlpcmEIYW
        /nkC5KEqFLEwEVvkb1/UO8JYYJ+uuP3i+g==
X-Google-Smtp-Source: ABdhPJx9fu7atMZain8PqcpwGLT1HCuMIbR681JL5/3MctfhyYMiZdpO58l+1nQpMKf7Gu86FY9Q/Q==
X-Received: by 2002:a63:c741:: with SMTP id v1mr24722019pgg.207.1618206515602;
        Sun, 11 Apr 2021 22:48:35 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id i17sm8644845pfd.84.2021.04.11.22.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 22:48:35 -0700 (PDT)
Date:   Mon, 12 Apr 2021 11:18:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 5.13
Message-ID: <20210412054832.6wxa7b5weu6upmxb@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Fix typos in s5pv210 cpufreq driver (Bhaskar Chowdhury).

- Armada 37xx: Fix cpufreq changing base CPU speed to 800 MHz from 1000 MHz
  (Pali Rohár and Marek Behún).

- cpufreq-dt: Return -EPROBE_DEFER on failure to add table (Quanyang Wang).

- Minor cleanup in cppc driver (Tom Saeger).

- Add frequency invariance support for CPPC driver and generalize freq
  invariance support arch-topology driver (Viresh Kumar).

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit fbb31cb805fd3574d3be7defc06a7fd2fd9af7d2:

  cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev (2021-03-08 16:20:07 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to dbbd49bade0548db87ceb1943951dea456af2e22:

  cpufreq: armada-37xx: Fix module unloading (2021-04-09 15:17:33 +0530)

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      cpufreq: Rudimentary typos fix in the file s5pv210-cpufreq.c

Marek Behún (2):
      cpufreq: armada-37xx: Fix setting TBG parent for load levels
      clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM clock

Pali Rohár (7):
      cpufreq: armada-37xx: Fix the AVS value for load L1
      clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to 1 GHz
      clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1 to L0
      cpufreq: armada-37xx: Fix driver cleanup when registration failed
      cpufreq: armada-37xx: Fix determining base CPU frequency
      cpufreq: armada-37xx: Remove cur_frequency variable
      cpufreq: armada-37xx: Fix module unloading

Quanyang Wang (1):
      cpufreq: dt: dev_pm_opp_of_cpumask_add_table() may return -EPROBE_DEFER

Tom Saeger (1):
      cpufreq: cppc: simplify default delay_us setting

Viresh Kumar (4):
      arch_topology: Rename freq_scale as arch_freq_scale
      arch_topology: Allow multiple entities to provide sched_freq_tick() callback
      arch_topology: Export arch_freq_scale and helpers
      cpufreq: CPPC: Add support for frequency invariance

 arch/arm64/include/asm/topology.h      |  10 +-
 arch/arm64/kernel/topology.c           | 109 ++++++--------
 drivers/base/arch_topology.c           |  89 ++++++++++-
 drivers/clk/mvebu/armada-37xx-periph.c |  83 ++++++-----
 drivers/cpufreq/Kconfig.arm            |  10 ++
 drivers/cpufreq/armada-37xx-cpufreq.c  | 111 +++++++++++---
 drivers/cpufreq/cppc_cpufreq.c         | 259 ++++++++++++++++++++++++++++++---
 drivers/cpufreq/cpufreq-dt.c           |   9 +-
 drivers/cpufreq/s5pv210-cpufreq.c      |  14 +-
 include/linux/arch_topology.h          |  19 ++-
 kernel/sched/core.c                    |   1 +
 11 files changed, 534 insertions(+), 180 deletions(-)


-- 
viresh
