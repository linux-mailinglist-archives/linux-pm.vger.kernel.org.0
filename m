Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD56441F0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Dec 2022 12:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiLFLRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Dec 2022 06:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiLFLRa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2022 06:17:30 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C324F17
        for <linux-pm@vger.kernel.org>; Tue,  6 Dec 2022 03:17:29 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id p12so10144737qvu.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2022 03:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyM92lwgC+wq7Yv52eP4igek3NPEKur8jvXL6ZOPoaI=;
        b=Xl8/lHE82EB+B1v7a4wiTjOWpOdYUmrfhD+r9vdHdav0n7VwvCf5yDZAGFPoZ4MQwB
         juIOe8QONjSwGgoqewth9IqsQG63q01PRzVmFGDAKjC2qBtId7eM3wR/mawKMuuTFWjp
         2DE42NhgsrspOh7C0Qf4wYtEJ+QN1E/42u/LB0xLV0kc44M9nV0ALy4QCGeoICYU3J5s
         S89sH55NluriVReZH03mDn4deksw4Ur17/gX5HYWjJ9BvGvi/hjT9iEmmyHXdu6/zxRm
         pdfSr67nAQ0zjctKKRb+Ys68tb+NUuB/Hsairu91A0C/pM5go6eXjQlPE0EPxeRfyFOk
         DOaA==
X-Gm-Message-State: ANoB5pmW5LhG5DhcWJVlbLVHUYT7xm2Gle4Mul7Hf0/PHSRUk62Mrec1
        HKrQ3EUNW0jN6gZWAiaCBzbRlHFtGz210a+5AHvggWxi
X-Google-Smtp-Source: AA0mqf5I0XUQZ4vUcJXJtB18N+uw07pbheor3qBgS+O+KYkUK808pVYOra0y9v7NTYmojyr9HHBpZoI/IgdMSqQUuBc=
X-Received: by 2002:ad4:534b:0:b0:4b1:8429:a8a7 with SMTP id
 v11-20020ad4534b000000b004b18429a8a7mr61151259qvs.52.1670325449016; Tue, 06
 Dec 2022 03:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20221205235341.bs7v3nr5bnhllteu@vireshk-i7>
In-Reply-To: <20221205235341.bs7v3nr5bnhllteu@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Dec 2022 12:17:16 +0100
Message-ID: <CAJZ5v0hNOs63gGUKGxR2-OGm8yJNrwmmXJGPOjW+VO2k7oxwbw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 6, 2022 at 12:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:
>
>   Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.2
>
> for you to fetch changes up to 8ff150aa6fe252e9b7713cf737c4dc5cbaa263ab:
>
>   dt-bindings: cpufreq: cpufreq-qcom-hw: Add QDU1000/QRU1000 cpufreq (2022-12-01 14:50:47 +0530)
>
> ----------------------------------------------------------------
> Cpufreq arm updates for 6.2
>
> - Generalize of_perf_domain_get_sharing_cpumask phandle format (Hector Martin).
>
> - New cpufreq driver for Apple SoC CPU P-states (Hector Martin).
>
> - Lots of Qualcomm cpufreq driver updates, that include CPU clock
>   provider support, generic cleanups or reorganization, fixed a
>   potential memleak and the return value of cpufreq_driver->get()
>   (Manivannan Sadhasivam, and Chen Hui).
>
> - Few updates to Qualcomm cpufreq driver's DT bindings, that include
>   support for CPU clock provider, fixing missing cache related
>   properties, and support for QDU1000/QRU1000 (Manivannan Sadhasivam,
>   Rob Herring, and Melody Olvera).
>
> - Add support for ti,am625 SoC and enable build of ti-cpufreq for
>   ARCH_K3 (Dave Gerlach, and Vibhore Vardhan).
>
> - tegra186: Use flexible array to simplify memory allocation (Christophe
>   JAILLET).
>
> ----------------------------------------------------------------
> Chen Hui (1):
>       cpufreq: qcom-hw: Fix memory leak in qcom_cpufreq_hw_read_lut()
>
> Christophe JAILLET (1):
>       cpufreq: tegra186: Use flexible array to simplify memory allocation
>
> Dave Gerlach (4):
>       cpufreq: ti-cpufreq: Add support for AM625
>       cpufreq: dt-platdev: Blacklist ti,am625 SoC
>       arm64: dts: ti: k3-am625: Introduce operating-points table
>       cpufreq: ti: Enable ti-cpufreq for ARCH_K3
>
> Hector Martin (2):
>       cpufreq: Generalize of_perf_domain_get_sharing_cpumask phandle format
>       cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
>
> Manivannan Sadhasivam (7):
>       cpufreq: qcom-hw: Remove un-necessary cpumask_empty() check
>       cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe
>       cpufreq: qcom-hw: Use cached dev pointer in probe()
>       cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq
>       cpufreq: qcom-hw: Fix the frequency returned by cpufreq_driver->get()
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
>       cpufreq: qcom-hw: Add CPU clock provider support
>
> Melody Olvera (1):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add QDU1000/QRU1000 cpufreq
>
> Rob Herring (1):
>       dt-bindings: cpufreq: qcom: Add missing cache related properties
>
> Vibhore Vardhan (1):
>       arm64: dts: ti: k3-am625-sk: Add 1.4GHz OPP
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml |  31 +++++++++++++
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts                         |   9 ++++
>  arch/arm64/boot/dts/ti/k3-am625.dtsi                           |  51 +++++++++++++++++++++
>  drivers/cpufreq/Kconfig.arm                                    |  13 +++++-
>  drivers/cpufreq/Makefile                                       |   1 +
>  drivers/cpufreq/apple-soc-cpufreq.c                            | 352 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c                           |   3 ++
>  drivers/cpufreq/mediatek-cpufreq-hw.c                          |  14 ++++--
>  drivers/cpufreq/qcom-cpufreq-hw.c                              | 206 ++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
>  drivers/cpufreq/tegra186-cpufreq.c                             |  11 ++---
>  drivers/cpufreq/ti-cpufreq.c                                   |  36 +++++++++++++++
>  include/linux/cpufreq.h                                        |  28 +++++++-----
>  12 files changed, 650 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/cpufreq/apple-soc-cpufreq.c
>
> --

Pulled and added to my linux-next branch, thanks!
