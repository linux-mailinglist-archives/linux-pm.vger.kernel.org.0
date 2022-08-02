Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C33587668
	for <lists+linux-pm@lfdr.de>; Tue,  2 Aug 2022 06:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiHBEe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Aug 2022 00:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHBEe1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2022 00:34:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8124BC1
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 21:34:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f28so4243616pfk.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 21:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JI+eqE353MDAz6L3or4qBaQUtKneF05h56EqpfNDy5I=;
        b=ETMIEc1ZYeIR2ARoFeybTRBkxc5jK7jQA6sBJmE/tOPbN6jNOjLn0dH8+naGs0Uep7
         NVxeqgTltmqgmgSIQKA2GtKNT+y0A5LYOc4tQCuEy6JsyQ475fC5axxmADIZgcCfrI0c
         MBe7bSA3Dpg43MDbq5424qvUfhIvIukqS4m+27fotmx8f3GtS0GTqBwC0MeO8EQ9/55y
         qGkpVUXuVi/TEwIXMNCxNsEdsKammPjNuctjmyVC7VxUYMNTmcD96sFAEeW54Nvg9tMR
         +xjlTfky7IMsg6sR0gkrJFuDoKT+4iveX9DWe/yNQyi/+jpCO/beFg9Mgs+46SAt4F3v
         YCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JI+eqE353MDAz6L3or4qBaQUtKneF05h56EqpfNDy5I=;
        b=NPISxLyGkjdz2LDeoOWqbYqhC3GPGmKLN7QKf6+9EoeEpq+gh6nnpHga8RYcB/TIkT
         /5bsO2C3PxkumfZPGc3j51MITeRysmwbFN59hjj/+qnh/iWAtbbsFc9msx3SkvDtvBi4
         8O3guU2DjHrjJotZzwglQS9PwQax8PQ92Xf4Bm4Gp4OfxPvFsQsrFxnQBNvl+8vTu3NI
         EW+b286r4osXa8jRmeZcBUXoahSy1GfTTuCGJNcW+6PCx/iDJCNy1tbyrPMl0fxdTKGF
         Zv2qd2xXASNl7OfBckT3aex7nCPiTG+L/Vxql7lVVUPvolsPMRSrk2dfuIbRMysCdp9N
         wMqw==
X-Gm-Message-State: AJIora9mMGjRK/bvAGrMRmOB8X/piQhc7Hb9oSlNL6qF0NiF2Ip04y4Z
        MA+JPMyOyNCkjgQu5myXbaV3BXwThaU1YA==
X-Google-Smtp-Source: AGRyM1tvrrC974xIpV4P+UtkXMmjU/Hjdfsc31TndIjSdxlsYX3e27zDmbIVABO8yJQIBd4xM7NWkQ==
X-Received: by 2002:a63:4857:0:b0:41a:d6ca:9975 with SMTP id x23-20020a634857000000b0041ad6ca9975mr15677778pgk.102.1659414865893;
        Mon, 01 Aug 2022 21:34:25 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79410000000b0052d543b72cdsm4043948pfo.189.2022.08.01.21.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 21:34:25 -0700 (PDT)
Date:   Tue, 2 Aug 2022 10:04:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 5.20-rc1
Message-ID: <20220802043421.q6zykqujdyutt67k@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit d2394860b45c3c1484e4b0a5d09909a1e3f6569e:

  cpufreq: mediatek: Handle sram regulator probe deferral (2022-07-13 16:51:32 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-5.20-rc1

for you to fetch changes up to 33fe1cb20cf44af9c12048b2bfdebae0408cd4aa:

  cpufreq: tegra194: Staticize struct tegra_cpufreq_soc instances (2022-07-18 12:27:00 +0530)

----------------------------------------------------------------
Cpufreq/arm updates for 5.20-rc1

- Fix return error code in mtk_cpu_dvfs_info_init (Yang Yingliang).

- Minor cleanups and support for new boards for Qcom cpufreq drivers
  (Bryan O'Donoghue, Konrad Dybcio, Pierre Gondois, and Yicong Yang).

- Fix sparse warnings for Tegra driver (Viresh Kumar).

----------------------------------------------------------------
Bryan O'Donoghue (3):
      dt-bindings: opp: opp-v2-kryo-cpu: Fix example binding checks
      dt-bindings: opp: Add missing compat devices
      dt-bindings: opp: Add msm8939 to the compatible list

Konrad Dybcio (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM6375 compatible

Pierre Gondois (4):
      cpufreq: qcom-hw: Reset cancel_throttle when policy is re-enabled
      cpufreq: qcom-hw: Disable LMH irq when disabling policy
      cpufreq: qcom-hw: Remove deprecated irq_set_affinity_hint() call
      cpufreq: Change order of online() CB and policy->cpus modification

Viresh Kumar (1):
      cpufreq: tegra194: Staticize struct tegra_cpufreq_soc instances

Yang Yingliang (1):
      cpufreq: mediatek: fix error return code in mtk_cpu_dvfs_info_init()

Yicong Yang (1):
      cpufreq: qcom-cpufreq-hw: use HZ_PER_KHZ macro in units.h

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml    |  1 +
 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml |  7 +++++++
 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml        | 15 +++++++++++++++
 drivers/cpufreq/cpufreq.c                                         |  6 +++---
 drivers/cpufreq/mediatek-cpufreq.c                                |  1 +
 drivers/cpufreq/qcom-cpufreq-hw.c                                 | 14 +++++++++-----
 drivers/cpufreq/tegra194-cpufreq.c                                |  4 ++--
 7 files changed, 38 insertions(+), 10 deletions(-)

-- 
viresh
