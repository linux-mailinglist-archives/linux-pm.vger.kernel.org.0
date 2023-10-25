Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232187D68A1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjJYKeB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 06:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjJYKeA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 06:34:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE0910A
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 03:33:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9e95aa02dso5801685ad.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698230038; x=1698834838; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7VRZlMGuaAUjHNaqslgWRqo/FpUm7giLXcNiARJgUU=;
        b=zsZzATrW3H/KVGjgmLkxWJbX10pIFtb0TKfS1mwYEwDjd2ccGMeOUlmN2DpNeHEgSZ
         Ydbz1D29syu4zGyqylu9G/PjYlhYlH3gLgoL7/i8aAZgH5iSlSafQvwRYD4Ek48+lWiJ
         V0dCW9EwMxzL/+eMAnMtoGgJ5Du4xj+8XQHTeJkPIgLECGDnGFpxS0IhoPsMn5hmv3KX
         dzJ7oevS2YZmXJ3CkHrncu6a425r3/HpXiktUOxk5FgNIpXXtZ8RG849FvZWZ19Qlhph
         ukUJX5dwjOMXWE86RZ9dM1zsSLIPWUACNIe9AqDbBJYmmI9Pzii4s+IZtyzFP942BHOK
         vXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698230038; x=1698834838;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7VRZlMGuaAUjHNaqslgWRqo/FpUm7giLXcNiARJgUU=;
        b=X5qqlbh2+SqWRIVAk3S9FL5zUAs0Phskl3N4L8HzRlcJPS4O9jcvfXgQ1GbpGueWaZ
         aaDFWlvxJdwsA93FfNQgPoHpc1QN3hq9UAfiRRAJFKI1cFK+Yxs3qqNKuQmkj7Km9Et7
         ilHBooOkc6ZtNyDwo2qT7pau9Z8umlp3+fN8R8EZkwcVhUVvA7OQZ8kKUObaYHEoKO3i
         2Sh1x12VOJvwoFRFXas6rr/1uztYFH/eWWdOcqySTg3d0yoQPPRVq4JsEbkHJaOwGPJ9
         hTlEHmorrxhKdAOyrdx1Vq4KWJY+u1BvGiDZr0LCi6vqDWvkuU0r8hz7xbGiFerqimC3
         Vbiw==
X-Gm-Message-State: AOJu0YxJSBp19v+F9MCvmuml20Br3o3msDETgxeslAATA2yv8v8A0f3L
        up0ljnw7wI43WB26/8AwiHcHWQ==
X-Google-Smtp-Source: AGHT+IGY5bwduHQgqupo37b3t9AuV5xGkBM/yl+PyfzcfsTh+LugYRykm5lDfB7nnypG/8rPVzwWIw==
X-Received: by 2002:a17:902:ce85:b0:1ca:c490:8548 with SMTP id f5-20020a170902ce8500b001cac4908548mr22825650plg.19.1698230038185;
        Wed, 25 Oct 2023 03:33:58 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id m26-20020a6562da000000b0059ce3d1def5sm7392301pgv.45.2023.10.25.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:33:57 -0700 (PDT)
Date:   Wed, 25 Oct 2023 16:03:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.7
Message-ID: <20231025103355.e53du4qk53d52fwn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.7

for you to fetch changes up to 038ef0d990a0a5fbc2024084f51e8af7d9bc95a2:

  dt-bindings: cpufreq: qcom-hw: document SM8650 CPUFREQ Hardware (2023-10-25 15:51:22 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.7

- Add support for several Qualcomm SoC versions and other similar
  changes (Christian Marangi, Dmitry Baryshkov, Luca Weiss, Neil
  Armstrong, Richard Acayan, Robert Marko, Rohit Agarwal, Stephan
  Gerhold and Varadarajan Narayanan).

- Cleanups to the tegra cpufreq driver (Sumit Gupta).

- Use of_property_read_reg() to parse "reg" in pmac32 driver (Rob Herring).

- Add support for TI's am62p5 Soc (Bryan Brattlof).

- Make ARM_BRCMSTB_AVS_CPUFREQ depends on !ARM_SCMI_CPUFREQ (Florian
  Fainelli).

- Update Kconfig to mention i.MX7 as well (Alexander Stein).

----------------------------------------------------------------
Alexander Stein (1):
      cpufreq: arm: Kconfig: Add i.MX7 to supported SoC for ARM_IMX_CPUFREQ_DT

Bryan Brattlof (2):
      cpufreq: dt-platdev: add am62p5 to blocklist
      cpufreq: ti-cpufreq: Add opp support for am62p5 SoCs

Christian Marangi (2):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: Document krait-cpu
      cpufreq: qcom-nvmem: add support for IPQ8064

Dmitry Baryshkov (2):
      cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
      cpufreq: qcom-nvmem: also accept operating-points-v2-krait-cpu

Florian Fainelli (1):
      cpufreq: ARM_BRCMSTB_AVS_CPUFREQ cannot be used with ARM_SCMI_CPUFREQ

Luca Weiss (1):
      cpufreq: Add QCM6490 to cpufreq-dt-platdev blocklist

Neil Armstrong (1):
      dt-bindings: cpufreq: qcom-hw: document SM8650 CPUFREQ Hardware

Richard Acayan (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: add SDM670 compatible

Rob Herring (1):
      cpufreq: pmac32: Use of_property_read_reg() to parse "reg"

Robert Marko (2):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ6018
      cpufreq: qcom-nvmem: add support for IPQ6018

Rohit Agarwal (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75 compatible

Stephan Gerhold (4):
      cpufreq: dt: platdev: Add MSM8909 to blocklist
      dt-bindings: cpufreq: qcom-nvmem: Document MSM8909
      cpufreq: qcom-nvmem: Simplify driver data allocation
      cpufreq: qcom-nvmem: Add MSM8909

Sumit Gupta (4):
      cpufreq: tegra194: fix warning due to missing opp_put
      cpufreq: tegra194: save CPU data to avoid repeated SMP calls
      cpufreq: tegra194: use refclk delta based loop instead of udelay
      cpufreq: tegra194: remove redundant AND with cpu_online_mask

Varadarajan Narayanan (2):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ5332
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ9574

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml    |   4 +++
 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml |   8 +++++-
 drivers/cpufreq/Kconfig.arm                                       |   6 ++--
 drivers/cpufreq/cpufreq-dt-platdev.c                              |   4 +++
 drivers/cpufreq/pmac32-cpufreq.c                                  |   7 ++---
 drivers/cpufreq/qcom-cpufreq-nvmem.c                              | 208 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 drivers/cpufreq/tegra194-cpufreq.c                                | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 drivers/cpufreq/ti-cpufreq.c                                      |   1 +
 8 files changed, 302 insertions(+), 89 deletions(-)

-- 
viresh
