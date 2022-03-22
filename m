Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE03B4E38BB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Mar 2022 07:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiCVGPe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 02:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiCVGPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 02:15:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A347544
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 23:14:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m22so14884117pja.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 23:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=T4r3kSycPG+Qr5qHkDwYYevefpEEwvGWy8QwKMoNwmQ=;
        b=EuIlNHAqv5NC+VJERib+Z0TvkKK+l9oZC6j3uzeuMucfqTu1TLCzGc9UvyzozuNn6v
         waeC+B3/FZ9yCkCdIwibvz0vTfWzDG9+g6Xw6hXmqEbEIxGKWb60jAjxFz6gcMgYMzMg
         FOyUnfgwGjL3h9qnN/PLAZBzj/pE5yzssjSAjMIVr8imOeTH2E0uauykpcESjcv6wx5p
         FDijJtq/jROSP5edW0GOgTbtm3xo8Y3iV138bQd5m+qk62debJw4+Rp+56FGY3fWMX3X
         3CWYqFDv65pqjP37oM54kuoyCWIAECKSSLoceLRs3uOYQQVgxarUA2dgczw+rAz4G7y2
         71YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=T4r3kSycPG+Qr5qHkDwYYevefpEEwvGWy8QwKMoNwmQ=;
        b=ZjVC9VWVRQSqf1s8tJnFy2Ksi/VdkoaRyES46JZ5eaGfN/8iD/lkIUyAvYaT6OHntI
         guiDwpEeru8B6M17h12nAbNnFioHtsTsGjcSmJyRlYdy++Zine8RtuzrmVsqOpnZvkkw
         3mWv3pxNulZcDCxJHQ0H2hhPytlKP2ZZLZ771+Jp/sd2Fiaa4VQECL6Gruji23TKTy+S
         wjiXRXLUKjRgf2+dVfGgD2FcS4FlbDDQcexY8M5dXjxCKfeAv1L4aK6Rw52Xn+HbPkCF
         Mao0ID6ieLZO+taBjAVMT5fhF3+DVQKdHOKWucc1VMRUW/L91mlb814iTHDCElLd7EDG
         uz6Q==
X-Gm-Message-State: AOAM530VBTFSah4cgKh7yja5oWrfxnZYLFknrtaKOis9/n2qeEVXYagc
        7JqdN0pqxAQb1/OGjBLqLLJ4AA==
X-Google-Smtp-Source: ABdhPJwbhZdMPtCNAHrvx92kYcgG8aZUsKEvKsICILwKmRhIL6LVaCjxckGoFvDl/WjXelLxN9ip7Q==
X-Received: by 2002:a17:90b:3e88:b0:1bf:3a96:54c1 with SMTP id rj8-20020a17090b3e8800b001bf3a9654c1mr3136118pjb.244.1647929646202;
        Mon, 21 Mar 2022 23:14:06 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id x39-20020a056a0018a700b004fa7e6ceafesm11950255pfh.169.2022.03.21.23.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 23:14:05 -0700 (PDT)
Date:   Tue, 22 Mar 2022 11:44:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 5.18
Message-ID: <20220322061404.bqrg2ztb5ibdf6dw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request:

- adds per core dvfs support for qcom Soc (Bjorn Andersson), convert to yaml
  binding (Manivannan Sadhasivam) and various other fixes to the qcom drivers
  (Luca Weiss).

- adds OPP table for imx7s SoC (Denys Drozdov) and minor fixes (Stefan Agner).

- fix CPPC driver's freq/performance conversions (Pierre Gondois).

- minor generic cleanups (Yury Norov).

Thanks.

-------------------------8<-------------------------

The following changes since commit ef8ee1cb8fc8976a68f5e89cd5f7b6f7de80c66f:

  cpufreq: qcom-hw: Delay enabling throttle_irq (2022-02-09 13:18:49 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to b7f2b0d3511a6bbf9387f08f370f9125663e18d8:

  dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings (2022-03-11 09:00:26 +0530)

----------------------------------------------------------------
Bjorn Andersson (2):
      cpufreq: qcom-hw: Add support for per-core-dcvs
      cpufreq: blocklist Qualcomm sc8280xp and sa8540p in cpufreq-dt-platdev

Denys Drozdov (1):
      ARM: dts: imx7s: Define operating points table for cpufreq

Luca Weiss (1):
      cpufreq: qcom-cpufreq-nvmem: fix reading of PVS Valid fuse

Manivannan Sadhasivam (2):
      dt-bindings: dvfs: Use MediaTek CPUFREQ HW as an example
      dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings

Pierre Gondois (1):
      cpufreq: CPPC: Fix performance/frequency conversion

Stefan Agner (1):
      cpufreq: Add i.MX7S to cpufreq-dt-platdev blocklist

Yury Norov (1):
      cpufreq: replace cpumask_weight with cpumask_empty where appropriate

 .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 ------------------
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 201 +++++++++++++++++++++
 .../bindings/dvfs/performance-domain.yaml          |  14 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  16 ++
 drivers/cpufreq/cppc_cpufreq.c                     |  43 +++--
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  20 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   2 +-
 drivers/cpufreq/scmi-cpufreq.c                     |   2 +-
 9 files changed, 272 insertions(+), 201 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml


-- 
viresh
