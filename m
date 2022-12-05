Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED16439AE
	for <lists+linux-pm@lfdr.de>; Tue,  6 Dec 2022 00:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLEXxt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Dec 2022 18:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiLEXxs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2022 18:53:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2951D0FD
        for <linux-pm@vger.kernel.org>; Mon,  5 Dec 2022 15:53:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 62so11872198pgb.13
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2022 15:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4ie4UMV0uG2oaXDURy++NSgKMjRLAwxHyFCEQOdgRk=;
        b=yA1xHL8jbbrBbQH1b7lv3D7gJMDtUNaDoicb62Lymjy7UqjEKXM7RNFCMQbA7jr5fE
         9Hndjd22dt1a5x9N9CVffcAMnA+TZ6/4EXP+Kbnlitn8bz7nK6MbpW+rRPLU4QgpZcPq
         0Nv1dWdancmeKecLDe2hFgWMO+BeilXsphaBocwvXSHQSOcoZF5fHO7BOHGJHdNjXtfW
         G7oE8o7qiSU2NUXbK3XtInJrFYD7gViYMWrwgbPiuQ6Ikd/sF1X2p7k/Ha5Y5omiYqUR
         MiTq7gtru/q5+hmADI4kI/CX98NDPNKZnMJULOcErssfPWG6qPfdQucK91Es+V6mnmlU
         nRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4ie4UMV0uG2oaXDURy++NSgKMjRLAwxHyFCEQOdgRk=;
        b=ONRHcpbrmN6oJmsKbknD24N6NIQv2OKGtAdQqzZ4lM3BXpuCtdrL3jVvTPBRRzP8lL
         rW6XSAChlmCpnkOfSEiM9dci6hOAO0rBsWEEc2yCI/20RPEyGXSUJH6sFUTd/x+fY9gN
         aWd4pGpKlsAmQg0mFOp564Zs42r1Xceg4OwmJI7eq4TDjelPNRTj8aLozyWiveEbtUT3
         k3YRrhsdfQqRdI1m5Np5b+yZ0CLX8gRpcoq+cTnZil7Hv3e6I0LrDBzK6i4r5RgSgSuO
         703cXy1kXzLUyNhV/HRt+DNmzlsh43hZBvfQCERw0543DM2d1+wMq7xQK/8Et+6zHHKc
         iVdw==
X-Gm-Message-State: ANoB5pmAMn7Q9DPAOCCKR8LuTptGUuXE63okJHD7/QtsTG2WlEln4VoU
        OYwYvFNVl2GueNQt+athB1B/0g==
X-Google-Smtp-Source: AA0mqf7ei0eDlwKzskIaQPa14ViXVyUcNPCtBuTxowEnbLrCVqOly+bVQ/x26yoqi94btJDsBq1IEg==
X-Received: by 2002:a63:5560:0:b0:478:c3a4:4568 with SMTP id f32-20020a635560000000b00478c3a44568mr5085696pgm.94.1670284427186;
        Mon, 05 Dec 2022 15:53:47 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id g5-20020a63e605000000b004785c24ffb4sm8750641pgh.26.2022.12.05.15.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:53:46 -0800 (PST)
Date:   Tue, 6 Dec 2022 05:23:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.2
Message-ID: <20221205235341.bs7v3nr5bnhllteu@vireshk-i7>
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

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.2

for you to fetch changes up to 8ff150aa6fe252e9b7713cf737c4dc5cbaa263ab:

  dt-bindings: cpufreq: cpufreq-qcom-hw: Add QDU1000/QRU1000 cpufreq (2022-12-01 14:50:47 +0530)

----------------------------------------------------------------
Cpufreq arm updates for 6.2

- Generalize of_perf_domain_get_sharing_cpumask phandle format (Hector Martin).

- New cpufreq driver for Apple SoC CPU P-states (Hector Martin).

- Lots of Qualcomm cpufreq driver updates, that include CPU clock
  provider support, generic cleanups or reorganization, fixed a
  potential memleak and the return value of cpufreq_driver->get()
  (Manivannan Sadhasivam, and Chen Hui).

- Few updates to Qualcomm cpufreq driver's DT bindings, that include
  support for CPU clock provider, fixing missing cache related
  properties, and support for QDU1000/QRU1000 (Manivannan Sadhasivam,
  Rob Herring, and Melody Olvera).

- Add support for ti,am625 SoC and enable build of ti-cpufreq for
  ARCH_K3 (Dave Gerlach, and Vibhore Vardhan).

- tegra186: Use flexible array to simplify memory allocation (Christophe
  JAILLET).

----------------------------------------------------------------
Chen Hui (1):
      cpufreq: qcom-hw: Fix memory leak in qcom_cpufreq_hw_read_lut()

Christophe JAILLET (1):
      cpufreq: tegra186: Use flexible array to simplify memory allocation

Dave Gerlach (4):
      cpufreq: ti-cpufreq: Add support for AM625
      cpufreq: dt-platdev: Blacklist ti,am625 SoC
      arm64: dts: ti: k3-am625: Introduce operating-points table
      cpufreq: ti: Enable ti-cpufreq for ARCH_K3

Hector Martin (2):
      cpufreq: Generalize of_perf_domain_get_sharing_cpumask phandle format
      cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states

Manivannan Sadhasivam (7):
      cpufreq: qcom-hw: Remove un-necessary cpumask_empty() check
      cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe
      cpufreq: qcom-hw: Use cached dev pointer in probe()
      cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq
      cpufreq: qcom-hw: Fix the frequency returned by cpufreq_driver->get()
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
      cpufreq: qcom-hw: Add CPU clock provider support

Melody Olvera (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QDU1000/QRU1000 cpufreq

Rob Herring (1):
      dt-bindings: cpufreq: qcom: Add missing cache related properties

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am625-sk: Add 1.4GHz OPP

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml |  31 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                         |   9 ++++
 arch/arm64/boot/dts/ti/k3-am625.dtsi                           |  51 +++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                                    |  13 +++++-
 drivers/cpufreq/Makefile                                       |   1 +
 drivers/cpufreq/apple-soc-cpufreq.c                            | 352 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c                           |   3 ++
 drivers/cpufreq/mediatek-cpufreq-hw.c                          |  14 ++++--
 drivers/cpufreq/qcom-cpufreq-hw.c                              | 206 ++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
 drivers/cpufreq/tegra186-cpufreq.c                             |  11 ++---
 drivers/cpufreq/ti-cpufreq.c                                   |  36 +++++++++++++++
 include/linux/cpufreq.h                                        |  28 +++++++-----
 12 files changed, 650 insertions(+), 105 deletions(-)
 create mode 100644 drivers/cpufreq/apple-soc-cpufreq.c

-- 
viresh
