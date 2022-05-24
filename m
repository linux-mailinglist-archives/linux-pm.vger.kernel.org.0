Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D531553225F
	for <lists+linux-pm@lfdr.de>; Tue, 24 May 2022 07:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiEXFRg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 May 2022 01:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiEXFRf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 01:17:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571317355F
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2022 22:17:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso1039969pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2022 22:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=anY7DjmGS+WrYkgKGxGHc0VNWGNlthTk4t7+0tHvsSM=;
        b=haWOr+vW69kmMwIA4+m2reJl/Q+kX6KXcVw80nDNLRqdWpkao5FMTTbQR9M7toYT4G
         D7gJqoyyzn47b2dlAzJxAJTqnIg1rDKSowdqtTBbkch+XLoCN7Ae72AAWHn2oTk3T2Pr
         DsmiyOot7of/Dn82Pfi3BLcCqfYR449nf1G1FJs6bx/4zqd62klr+kGQzLs7mKnwL/QD
         Uoy2bRR9mKXCIrtzGp+JDB9pzXX+lFyk0SK9hDnKJxB2hZmjo4iFQWXbDc+LAz4WES6l
         fqZi4GqEenOTDTqe3znNiOJxyM8P9yIoV6dUpcmklalUY6WNMNjV0U/Uq/Ft6ndL1vsl
         moyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=anY7DjmGS+WrYkgKGxGHc0VNWGNlthTk4t7+0tHvsSM=;
        b=tdMfJimZXaqhTa1AKY05GNzFzw+2uLkk+5dBh8G79C22HA8zw3K10LTysc77u+XnzM
         tUfkiLHma8cJIMVaXCX1+SfHgwUwhpkqoE99cIgLBOKibAYByTzUtMN//0UAUQzG5abU
         7imuIdQhe0+dOtxwZ9oqFNtIzGKG24X6LjSPqvQPF9VBejIx6330xtvUtIeDn/skPwoe
         P+NI6DxdYT+yeMYYQgyK2tQEscjx5fArBcRVBM2QIaDuRyb9DI6s5ukNxrpLIDytoidf
         J6zVusuB+YT+3McFpdPzEkxyVsK04eWtLKwUkHtuTZgrH61GLgC68ceolLNxJaX8/mll
         gLNQ==
X-Gm-Message-State: AOAM532WDc9yKMVSZQBhdVmRwjBazez+uHb1YExXenMPoTQQ/eRm7Ss/
        r4IJq9+LBjhqF6CScwAidhMDX8T9tNzvuw==
X-Google-Smtp-Source: ABdhPJzQEcF3WDXh1+VwYSgPzUIHGAqK4f9+ff5elaSJT3SGTJPXRyeuwYldQbGXLB2RZjAprzUCiA==
X-Received: by 2002:a17:90a:7847:b0:1df:a16d:2bfb with SMTP id y7-20020a17090a784700b001dfa16d2bfbmr2791528pjl.71.1653369453833;
        Mon, 23 May 2022 22:17:33 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902c95200b0015e8d4eb287sm6103539pla.209.2022.05.23.22.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 22:17:33 -0700 (PDT)
Date:   Tue, 24 May 2022 10:47:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 5.19-rc1
Message-ID: <20220524051731.lm2qg5ld34ss56hr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit e4e6448638a01905faeda9bf96aa9df7c8ef463c:

  cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts (2022-04-26 12:08:31 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-5.19-rc1

for you to fetch changes up to 39b360102f3ac6b12cafac9db25762071eb0418c:

  cpufreq: mediatek: Add support for MT8186 (2022-05-12 10:39:31 +0530)

----------------------------------------------------------------
cpufreq arm updates for 5.19-rc1

- Tegra234 cpufreq support (Sumit Gupta).

- Mediatek cleanups and enhancements (Wan Jiabing, Rex-BC Chen, and
  Jia-Wei Chang).

----------------------------------------------------------------
Jia-Wei Chang (8):
      cpufreq: mediatek: Use module_init and add module_exit
      cpufreq: mediatek: Cleanup variables and error handling in mtk_cpu_dvfs_info_init()
      cpufreq: mediatek: Remove unused headers
      cpufreq: mediatek: Enable clocks and regulators
      cpufreq: mediatek: Record previous target vproc value
      cpufreq: mediatek: Make sram regulator optional
      cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()
      cpufreq: mediatek: Add support for MT8186

Rex-BC Chen (7):
      cpufreq: mediatek: Use device print to show logs
      cpufreq: mediatek: Replace old_* with pre_*
      cpufreq: mediatek: Unregister platform device on exit
      cpufreq: mediatek: Move voltage limits to platform data
      cpufreq: mediatek: Add opp notification support
      dt-bindings: cpufreq: mediatek: Add MediaTek CCI property
      cpufreq: mediatek: Link CCI device to CPU

Sumit Gupta (4):
      dt-bindings: Document Tegra CCPLEX Cluster
      cpufreq: tegra194: add soc data to support multiple soc
      cpufreq: tegra194: Add support for Tegra234
      arm64: tegra: add node for tegra234 cpufreq

Wan Jiabing (2):
      cpufreq: mediatek: Fix NULL pointer dereference in mediatek-cpufreq
      cpufreq: mediatek: Fix potential deadlock problem in mtk_cpufreq_set_target

 .../arm/tegra/nvidia,tegra-ccplex-cluster.yaml     |  52 ++
 .../bindings/cpufreq/cpufreq-mediatek.txt          |   7 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   7 +
 drivers/cpufreq/mediatek-cpufreq.c                 | 636 ++++++++++++++-------
 drivers/cpufreq/tegra194-cpufreq.c                 | 246 ++++++--
 5 files changed, 689 insertions(+), 259 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml

-- 
viresh
