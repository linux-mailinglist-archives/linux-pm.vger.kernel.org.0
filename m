Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7D23B2BE
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 04:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHDC21 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 22:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHDC21 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 22:28:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764AC06174A
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 19:28:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id lx9so1186800pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6GVUv+9Fssf3xKqRVKcpxPPsCcpq2Nc/tJstBMhX99Y=;
        b=rWlgg4urYnB+1iu37AEaNTNTFO8yrBiF/WxRrJ9X8uESfEmqAhDoIFdjGuh4L87zCU
         8LA3R1qao/WbnsGPLKGESriXseRp79ZNGQUf0WCAGbkJIasE1HFAhY+YifOoM9Dvzip+
         Obw9boXwoVC4RyKx46xYjKVywZkqdruHO+NQig+xkqF+ImW7KPSSvSKHv6cdtY885rCm
         peK7xn/WsjAHhWkzRbb4mjg5mccMQ0bzlgkL9rf5DGU6dlT/Vj7d3E1JXxAeNYSn6dfy
         CrVQ5fLtqWq10/4vk8Q7rwjdXS16zMv+ciexIkw3RBK+RNx9weZsD3mA0MNa6RZxXUG8
         oZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6GVUv+9Fssf3xKqRVKcpxPPsCcpq2Nc/tJstBMhX99Y=;
        b=SUaXfgiZlF36gYGjy87zamUxJmWvTRkxeNovWcS/lES2hwJRJ7GPnfluh25idHSujY
         nzZXyIP9CNMgYRwdwTkKrrLvsgSqbynjmw3+pcS5AtSwmiqj2W8AW0cDZ78sVv27/aag
         w8e8EG8xFvrNZc8SnkZobKT6jWbI78uevFliRXtCHoThb/uRO6fVt4iQZglZeHmRjj3w
         qwXUs6sLH9Nqi8iSeOZoPxtjOvWb2XXbxZCLdmzYgRrybPcyjIyd6uJvqovdFcAPYGvL
         e7KFKRhAp4G0IDtfGUK+QkGhpSpIEwaA6moVq2HXa/fjw17ujFfG6wBwTh+Ze5kG690p
         bn1Q==
X-Gm-Message-State: AOAM533qUXipClIOA2VTpUQpKmBaCjR4EIrbxvHCCNcV6cYoj/g19fqd
        x5+nQgR5C8RTNu8ivls7HrRoqQTCLyY=
X-Google-Smtp-Source: ABdhPJzTb0OHaHSoPAglvEIUEt/K95T0Nfir0S/vMoOeJE8k6Qdu9BLSI9YdthVkeZPsAYg1WC+MXA==
X-Received: by 2002:a17:902:16a:: with SMTP id 97mr17200774plb.207.1596508106433;
        Mon, 03 Aug 2020 19:28:26 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id i66sm20424577pfc.12.2020.08.03.19.28.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 19:28:25 -0700 (PDT)
Date:   Tue, 4 Aug 2020 07:58:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm changes for 5.9
Message-ID: <20200804022822.raefjhxjvyqzrmho@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

I wanted to do this last week, but couldn't as some conflict came in
for the OPP patch which multiple trees wanted for dependencies.

Here are the details:

- Adaptive voltage scaling (AVS) support and minor cleanups for
  brcmstb driver (Florian Fainelli and Markus Mayer).

- A new tegra driver and cleanup for the existing one (Sumit Gupta and
  Jon Hunter).

- Bandwidth level support for Qcom driver along with OPP changes (Sibi
  Sankar).

- Cleanups to sti, cpufreq-dt, ap806, CPPC drivers (Viresh Kumar, Lee
  Jones, Ivan Kokshaysky, Sven Auhagen, and Xin Hao).

- Make schedutil default governor for ARM (Valentin Schneider).

- Fix dependency issues for imx (Walter Lozano).

- Cleanup around cached_resolved_idx in cpufreq core (Viresh Kumar).

--
viresh

-------------------------8<-------------------------

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to f259eab3ea0e7ed73db91f6358274dd3a9a27d79:

  cpufreq: make schedutil the default for arm and arm64 (2020-07-30 11:40:29 +0530)

----------------------------------------------------------------
Florian Fainelli (1):
      cpufreq: brcmstb-avs-cpufreq: Support polling AVS firmware

Ivan Kokshaysky (1):
      cpufreq: dt: fix oops on armada37xx

Jon Hunter (1):
      cpufreq: tegra186: Simplify probe return path

Lee Jones (1):
      cpufreq: sti-cpufreq: Fix some formatting and misspelling issues

Markus Mayer (2):
      cpufreq: brcmstb-avs-cpufreq: more flexible interface for __issue_avs_command()
      cpufreq: brcmstb-avs-cpufreq: send S2_ENTER / S2_EXIT commands to AVS

Sibi Sankar (5):
      cpufreq: blacklist SDM845 in cpufreq-dt-platdev
      cpufreq: blacklist SC7180 in cpufreq-dt-platdev
      OPP: Add and export helper to set bandwidth
      cpufreq: qcom: Update the bandwidth levels on frequency change
      cpufreq: qcom: Disable fast switch when scaling DDR/L3

Sumit Gupta (2):
      dt-bindings: arm: Add NVIDIA Tegra194 CPU Complex binding
      cpufreq: Add Tegra194 cpufreq driver

Sven Auhagen (1):
      cpufreq: ap806: fix cpufreq driver needs ap cpu clk

Valentin Schneider (1):
      cpufreq: make schedutil the default for arm and arm64

Viresh Kumar (2):
      cpufreq: cppc: Reorder code and remove apply_hisi_workaround variable
      cpufreq: cached_resolved_idx can not be negative

Walter Lozano (1):
      cpufreq: imx: Select NVMEM_IMX_OCOTP

Xin Hao (1):
      cpufreq: CPPC: Reuse caps variable in few routines

 .../bindings/arm/nvidia,tegra194-ccplex.yaml       |  69 ++++
 drivers/cpufreq/Kconfig                            |   2 +-
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/armada-37xx-cpufreq.c              |   1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |  89 +++--
 drivers/cpufreq/cppc_cpufreq.c                     |  95 +++--
 drivers/cpufreq/cpufreq-dt-platdev.c               |   2 +
 drivers/cpufreq/cpufreq.c                          |   2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  91 ++++-
 drivers/cpufreq/sti-cpufreq.c                      |   8 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |   6 -
 drivers/cpufreq/tegra194-cpufreq.c                 | 390 +++++++++++++++++++++
 drivers/opp/core.c                                 |  31 ++
 include/linux/cpufreq.h                            |   2 +-
 include/linux/pm_opp.h                             |   6 +
 16 files changed, 702 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
 create mode 100644 drivers/cpufreq/tegra194-cpufreq.c

-- 
viresh
