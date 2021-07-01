Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72193B8CAC
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 05:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhGADir (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 23:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhGADiq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 23:38:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F07C061756
        for <linux-pm@vger.kernel.org>; Wed, 30 Jun 2021 20:36:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q91so3416591pjk.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jun 2021 20:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CfXNvUU+7ZlUmUS/VvpvW61l6Q1EH0W11UuheIfO2kk=;
        b=kmsAqaKJu2kocfY/lhiYfPeygHmU37T7j6/IInIvhgDpQbjhShhy2V/D/cvcDtbojZ
         5ktVn1oOFMor48wxo9KMdFvtnyJvHsVqPHAgx0g7s3w/IYBBhroBTiaqan5z0kaJMytZ
         BkWC94WFlNq1ST7oNlpt+VkBaL1x/zhmny/zOzp5Fjhbz8EsEe+cV2mWduacrqSFEF8i
         heZX6/NWDru6ntlu7O6wp8fRCaa8vjp0BJ9HsUhc68yvHiHkh0OmFGb/Jjx4H6k/Btfy
         823oFalSzrFVnZqeul+9mbSd7ESCzqJwBrMG9rfjM4M+k6XzbEe5rlSykSoH9ZWGlPRr
         XdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CfXNvUU+7ZlUmUS/VvpvW61l6Q1EH0W11UuheIfO2kk=;
        b=S4PrVEJ5ixdu8AbLADRaXpGaRbauNFcFNxVinvN+OJUcde8jm6XDHcoygYQ6yxoEzn
         1fLWlN2RS2e7/CzHCIfQCJna97JleCA9YLztvazvd8q8dHfw2Ktl7WGvJzK3FYG+MCuS
         P4lbERxXv21tR6cg9Yz/cCjyUc/U19c6uhUkenaoyFBq/GKQIeC76JMHAI69YugJfOOn
         ueQffM3cY8GqW8/DdYYslMIkF8XCj1oyzrWx45IfeMgfLvp0cII36gF2wbxEGAuAtFrN
         H+ag0x10eQtHbWetJL9OKECpoeNEKWMru4wwmC6m87yPUXEMKWzRTqeuEOuYYFbhn2tN
         aKwA==
X-Gm-Message-State: AOAM53028R7nazRKJUIERaJs/Epi+0tODyV8sgDHyHMntZqS3HmnC1xE
        Uq0eEulq2Inyp0Q7CV7WIB0b2xqKewJivw==
X-Google-Smtp-Source: ABdhPJyhcWUWlR2E7xlmQfhRYhp1FMCM+c6h0Y+B3F15a7ONqt7a0G2+8FYXMVvRco0C8EVcH2yp7g==
X-Received: by 2002:a17:902:9a8c:b029:113:d891:2eaf with SMTP id w12-20020a1709029a8cb0290113d8912eafmr35156516plp.61.1625110575503;
        Wed, 30 Jun 2021 20:36:15 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id s1sm24513001pgg.49.2021.06.30.20.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:36:15 -0700 (PDT)
Date:   Thu, 1 Jul 2021 09:06:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 5.14
Message-ID: <20210701033613.ydoxbc5tydzqbln3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Add frequency invariance support for CPPC driver again and related
  fixes/changes. (This is based on commit 9357a380f90a ("cpufreq:
  CPPC: Migrate to ->exit() callback instead of ->stop_cpu()") from
  the PM tree).

- Minor changes/cleanups for Meditak driver (Fabien Parent and Seiya
  Wang), Qcom platform (Sibi Sankar), and SCMI driver (Christophe
  JAILLET).

- New bindings for generic performance domains (Sudeep Holla).

- Rename black/white-lists (Viresh Kumar).

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit 9357a380f90a89a168d505561d11f68272e0e768:

  cpufreq: CPPC: Migrate to ->exit() callback instead of ->stop_cpu() (2021-06-30 18:49:29 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to c503c193db7d7ccc0c58b1ef694eaef331318149:

  Merge branch 'cpufreq/cppc-fie' into cpufreq/arm/linux-next (2021-07-01 07:32:37 +0530)

----------------------------------------------------------------
Christophe JAILLET (1):
      cpufreq: scmi: Fix an error message

Fabien Parent (1):
      cpufreq: mediatek: add support for mt8365

Seiya Wang (2):
      clk: mediatek: remove deprecated CLK_INFRA_CA57SEL for MT8173 SoC
      dt-bindings: cpufreq: update cpu type and clock name for MT8173 SoC

Sibi Sankar (1):
      cpufreq: blacklist SC7280 in cpufreq-dt-platdev

Sudeep Holla (1):
      dt-bindings: dvfs: Add support for generic performance domains

Viresh Kumar (6):
      cpufreq: dt: Rename black/white-lists
      cpufreq: CPPC: Fix potential memleak in cppc_cpufreq_cpu_init
      cpufreq: CPPC: Pass structure instance by reference
      arch_topology: Avoid use-after-free for scale_freq_data
      cpufreq: CPPC: Add support for frequency invariance
      Merge branch 'cpufreq/cppc-fie' into cpufreq/arm/linux-next

 Documentation/devicetree/bindings/arm/cpus.yaml                |   7 ++++
 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt |   8 ++--
 Documentation/devicetree/bindings/dvfs/performance-domain.yaml |  74 ++++++++++++++++++++++++++++++++++++
 drivers/base/arch_topology.c                                   |  27 ++++++++++---
 drivers/cpufreq/Kconfig.arm                                    |  10 +++++
 drivers/cpufreq/cppc_cpufreq.c                                 | 290 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 drivers/cpufreq/cpufreq-dt-platdev.c                           |  10 +++--
 drivers/cpufreq/mediatek-cpufreq.c                             |   1 +
 drivers/cpufreq/scmi-cpufreq.c                                 |   2 +-
 include/dt-bindings/clock/mt8173-clk.h                         |   1 -
 include/linux/arch_topology.h                                  |   1 +
 kernel/sched/core.c                                            |   1 +
 12 files changed, 390 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dvfs/performance-domain.yaml


-- 
viresh
