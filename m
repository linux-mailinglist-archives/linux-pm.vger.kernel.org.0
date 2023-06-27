Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975DC73F0D6
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jun 2023 04:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjF0CaU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 22:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjF0CaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 22:30:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84124173B
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 19:30:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so2020070a12.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687833018; x=1690425018;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4NgiPWxQbLcHsHUVphqSd0vzI4GYPoNScDIDWFoaLY=;
        b=oi7Oe72oZTSvvTnFyo2oyVAZogwp2EGhKW8Qp1fRSsceO9lQnvtyXWr62QfwDMJrNK
         TrflhkBLO6EO2iODGaTptCsul66wMX/5WXiAY84TMw8zbYNIDzcHDGoahnUl7fQihNQ+
         fka5NVBL6/Nun5emaOWsBRih0skVAb6iPsnEHqF/LEuRlqRA574sWRJfvLsseUQ+rwFR
         IQ1qKu0RzZu2HRAtVdIP2IBS+3jWHpyexXBRZ/fzfXBq/xSAJ0DMlDg3LOC60n+HchOa
         +4xhu4jrh3g94EMHDriXcBYMrRnqUQlrdrfYr3GuRkZgrbjzc+uJr5Y5OXpnd60PAqHm
         WzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687833018; x=1690425018;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4NgiPWxQbLcHsHUVphqSd0vzI4GYPoNScDIDWFoaLY=;
        b=E/ZUR9aC6lDKTWPbf6nedd5cLdbUPmWFWfJwiUCeEmLjWeOFW39+2z2AwQJTioVske
         bb6sngvcFOTe2dxe2/1IfsbHd+F5dNn7GVt9VYrobkIp6V6asK43+vIUWjnf5LrS8RC2
         5pFyAT7eu3Q8q7YJtZoluc77mh/nQjCfJM8iHoCAcVeTREsqsbszyHfzCWEl/3XoP2T6
         4awF2GlmV65QpKp8yUWvc0DNrbYNMdFMGntn57fEaThUfdWR5U1LllGeGoqAdR6KKJzH
         yFydP05p7CvD3zH9plUkKZfXo2dBEF2fJiVqL8ns3+JR8xcu6/t8N/0wogDs8coPAz+x
         dcCQ==
X-Gm-Message-State: AC+VfDyMrNLrtuGjBSoxMo5luVgNYtPhvi+xpz1dWi7jKi2SQRHyZP+1
        VW8UH/e3leOaYtu7Jq8W3/CqSw==
X-Google-Smtp-Source: ACHHUZ61kwJYwmqR5Izlc4A3E7AFTjCPFRGLtB4/MzACEodDTQHdUN62GQ/twb1DDYGpg240/FvKIQ==
X-Received: by 2002:a05:6a20:734e:b0:110:2d7f:8eb9 with SMTP id v14-20020a056a20734e00b001102d7f8eb9mr27447123pzc.40.1687833017975;
        Mon, 26 Jun 2023 19:30:17 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b001ab2b4105ddsm4835662pla.60.2023.06.26.19.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 19:30:17 -0700 (PDT)
Date:   Tue, 27 Jun 2023 08:00:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.5
Message-ID: <20230627023015.gltrc6xxmjdkhkqa@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.5

for you to fetch changes up to 5ee64250286e8c5162808667a9a8668488d9f577:

  cpufreq: qcom-cpufreq-hw: Use dev_err_probe() when failing to get icc paths (2023-06-26 12:09:47 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.5

- Add support to build cpufreq-dt-platdev as module (Zhipeng Wang).

- Don't allocate Sparc's cpufreq_driver dynamically (Viresh Kumar).

- Add support for TI's AM62A7 platform (Vibhore Vardhan).

- Add support for Armada's ap807 platform (Russell King (Oracle)).

- Add support for StarFive JH7110 SoC (Mason Huo).

- Fix voltage selection for Mediatek Socs (Daniel Golle).

- Fix error handling in Tegra's cpufreq driver (Christophe JAILLET).

- Document Qualcomm's IPQ8074 in DT bindings (Robert Marko).

- Don't warn for disabling a non-existing frequency for imx6q cpufreq
  driver (Christoph Niedermaier).

- Use dev_err_probe() in Qualcomm's cpufreq driver (Andrew Halaney).

----------------------------------------------------------------
Andrew Halaney (1):
      cpufreq: qcom-cpufreq-hw: Use dev_err_probe() when failing to get icc paths

Christoph Niedermaier (1):
      cpufreq: imx6q: don't warn for disabling a non-existing frequency

Christophe JAILLET (1):
      cpufreq: tegra194: Fix an error handling path in tegra194_cpufreq_probe()

Daniel Golle (1):
      cpufreq: mediatek: correct voltages for MT7622 and MT7623

Mason Huo (1):
      cpufreq: dt-platdev: Add JH7110 SOC to the allowlist

Robert Marko (1):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ8074

Russell King (Oracle) (1):
      cpufreq: armada-8k: add ap807 support

Vibhore Vardhan (2):
      cpufreq: ti-cpufreq: Add support for AM62A7
      cpufreq: dt-platdev: Blacklist ti,am62a7 SoC

Viresh Kumar (1):
      cpufreq: sparc: Don't allocate cpufreq_driver dynamically

Zhipeng Wang (1):
      cpufreq: dt-platdev: Support building as module

 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml |  1 +
 drivers/cpufreq/Kconfig                                           |  2 +-
 drivers/cpufreq/armada-8k-cpufreq.c                               | 16 +++++++++-------
 drivers/cpufreq/cpufreq-dt-platdev.c                              |  5 +++++
 drivers/cpufreq/imx6q-cpufreq.c                                   | 30 ++++++++++++++++--------------
 drivers/cpufreq/mediatek-cpufreq.c                                | 13 ++++++++++---
 drivers/cpufreq/qcom-cpufreq-hw.c                                 |  2 +-
 drivers/cpufreq/sparc-us2e-cpufreq.c                              | 58 +++++++++++++++++-----------------------------------------
 drivers/cpufreq/sparc-us3-cpufreq.c                               | 58 +++++++++++++++++-----------------------------------------
 drivers/cpufreq/tegra194-cpufreq.c                                |  6 ++++--
 drivers/cpufreq/ti-cpufreq.c                                      |  1 +
 11 files changed, 82 insertions(+), 110 deletions(-)

-- 
viresh
