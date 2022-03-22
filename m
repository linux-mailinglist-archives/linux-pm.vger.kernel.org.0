Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D7A4E3DAC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Mar 2022 12:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiCVLfz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 07:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiCVLfy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 07:35:54 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28A9FEC
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 04:34:27 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2e6650cde1bso34746947b3.12
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 04:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQdvCLHyPXsUW6sY4nTv0pUYi5vO70uw/5ERO6ejFyM=;
        b=uFM6QNpbdGKKRuLryKKNBaC+bQ7DFCrTErIGLdPmR6B6ClnOfL9VRo14irpDEdhgv1
         ctdhPhUeuqYdkVMgI2mF/PxctMd2pVcd0Tr5VUujhJAoHqP5me4IW+tCfq2NAFZHP2tn
         kdaGdRhRQNlhri2Kr6KQeL9Wi7Q+xXoW4o+EiXUPuqO7PsKeLvMsnqCF97VfP29qHqIt
         9x4n8TL125ceWAid2MjXNEaPwqwYoLiPRFa2J9XdgLVIJaZ9Mgc8gVfmHUbVE8xbjZmJ
         T1I8LDqcRfxc5ia4iSDCWpV2WM8ZFAZoodWWelynC4e/bd8ic/4iJQoWCutQA/dc09PR
         5Dhg==
X-Gm-Message-State: AOAM531FABG8D4Ae3PdJoEnETk6f4s+Ji4+p1nGPdSb+gJXbqPx9QSdq
        Aex3xX65hkGge0P0L+2JFnnfBrCLd4wUgGrbgn3m2x0P
X-Google-Smtp-Source: ABdhPJyy1SBfxihZ4s3gG1uCtYhBfQioVwcW2uiG5yIZcPAM8l5PIr1SfoVMcf/gMynJ0Uu9wpT3MQqdIrXit+rfCQc=
X-Received: by 2002:a81:5cf:0:b0:2e5:7477:168e with SMTP id
 198-20020a8105cf000000b002e57477168emr28495323ywf.149.1647948866859; Tue, 22
 Mar 2022 04:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220322060900.jbghsxop4xe7x6wi@vireshk-i7>
In-Reply-To: <20220322060900.jbghsxop4xe7x6wi@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Mar 2022 12:34:14 +0100
Message-ID: <CAJZ5v0i8-YE+qOqFt_wR0WhbCe_gsO1giA61rm7pToKCbY26wA@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 5.18
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 22, 2022 at 7:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> Please pull OPP changes for 5.18. The request:
>
> - introduces opp-microwatt property to the OPP core, bindings, etc (Lukasz Luba).
>
> - Converts DT bindings to schema format and various related fixes (Yassine
>   Oudjana).
>
> - Expose OPP's OF node in debugfs (Viresh Kumar).
>
> Thanks.
>
> -------------------------8<-------------------------
>
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
>
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to f48a0c475c2aec8f2274703e1dc7be503f40f7cc:
>
>   Documentation: EM: Describe new registration method using DT (2022-03-03 09:35:04 +0530)
>
> ----------------------------------------------------------------
> Lukasz Luba (5):
>       dt-bindings: opp: Add "opp-microwatt" entry in the OPP
>       OPP: Add "opp-microwatt" supporting code
>       PM: EM: add macro to set .active_power() callback conditionally
>       OPP: Add support of "opp-microwatt" for EM registration
>       Documentation: EM: Describe new registration method using DT
>
> Viresh Kumar (1):
>       opp: Expose of-node's name in debugfs
>
> Yassine Oudjana (7):
>       dt-bindings: arm: qcom: Add msm8996 and apq8096 compatibles
>       arm64: dts: qcom: msm8996-mtp: Add msm8996 compatible
>       dt-bindings: opp: qcom-opp: Convert to DT schema
>       dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema
>       arm64: dts: qcom: msm8996: Rename cluster OPP tables
>       arm64: dts: qcom: qcs404: Rename CPU and CPR OPP tables
>       dt-bindings: power: avs: qcom,cpr: Convert to DT schema
>
>  Documentation/devicetree/bindings/arm/qcom.yaml    |  16 +-
>  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       | 166 +++++
>  .../devicetree/bindings/opp/opp-v2-base.yaml       |  23 +
>  .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 257 +++++++
>  .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |  60 ++
>  .../devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 796 ---------------------
>  Documentation/devicetree/bindings/opp/qcom-opp.txt |  19 -
>  .../devicetree/bindings/power/avs/qcom,cpr.txt     | 130 ----
>  .../devicetree/bindings/power/avs/qcom,cpr.yaml    | 160 +++++
>  Documentation/power/energy-model.rst               |  10 +
>  MAINTAINERS                                        |   5 +-
>  arch/arm64/boot/dts/qcom/msm8996-mtp.dts           |   2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              |   4 +-
>  arch/arm64/boot/dts/qcom/qcs404.dtsi               |   4 +-
>  drivers/opp/core.c                                 |  25 +
>  drivers/opp/debugfs.c                              |   8 +
>  drivers/opp/of.c                                   | 108 ++-
>  drivers/opp/opp.h                                  |   1 +
>  include/linux/energy_model.h                       |   2 +
>  include/linux/pm_opp.h                             |  12 +-
>  20 files changed, 851 insertions(+), 957 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
>  delete mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
>  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
>
> --

Pulled, thanks!
