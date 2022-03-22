Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8CD4E3D6D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Mar 2022 12:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiCVLV6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiCVLV5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 07:21:57 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC197EA36
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 04:20:29 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id u103so32991475ybi.9
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 04:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEc3Tx075iMsi9ykdazvsmlWTJGzU3Xq/yTfkHQ2YOo=;
        b=Cc6nHBKJAapRnJtT9+tiOtR6TQ1OzhbYYRNSb2xyVnC0WaBAxwRc5Yl1HYRdTGg3Vy
         pKiYsXZ2ARQ6gBCuw3xjHqw50yl6FvImig08ibQ5opBawuF3Yw962pV6z2xHY6y5b07S
         YDzFDncTU/U9XNxfSzHf5/gCTXYLDGzsNtgJ8OYPB5oYKvzB9YyiBIWP8z144Tuxi12/
         eFWg5fuKxlue+J7QkbJGedsy4G8d5jM7tJoXS6eZckm3oq3+ui2+oU5RQdYZM+NiFWWK
         E4IzqnSVG4DwirJ13gSE3QomPlg54CxfjeKnoZJShTcnYldUabwlFrH6oV82jaHHanbH
         cPdw==
X-Gm-Message-State: AOAM531Yw58PYgZc9zNDhGM6q4AfVnGUHDZipwGEfia6bAbSy5U6YVN6
        EkKByT7K63DhKMPzgMFW0LoOgAZV74k6MzEZO2yVGjFv
X-Google-Smtp-Source: ABdhPJzpQq36IgAfurW/1JnzeXggxY9+BwehsqShzBbPWV/eSzBx1QgsYp9EeRv07NTtcYZFBlnauDRJ5Sq0XN7D7aQ=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr25881621ybe.365.1647948028952; Tue, 22
 Mar 2022 04:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220322061404.bqrg2ztb5ibdf6dw@vireshk-i7>
In-Reply-To: <20220322061404.bqrg2ztb5ibdf6dw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Mar 2022 12:20:16 +0100
Message-ID: <CAJZ5v0i+U_p7JE6vte-0nZmbZMtYYvt+D0TpYk5cM-e1MSw0Yg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.18
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

On Tue, Mar 22, 2022 at 7:14 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request:
>
> - adds per core dvfs support for qcom Soc (Bjorn Andersson), convert to yaml
>   binding (Manivannan Sadhasivam) and various other fixes to the qcom drivers
>   (Luca Weiss).
>
> - adds OPP table for imx7s SoC (Denys Drozdov) and minor fixes (Stefan Agner).
>
> - fix CPPC driver's freq/performance conversions (Pierre Gondois).
>
> - minor generic cleanups (Yury Norov).
>
> Thanks.
>
> -------------------------8<-------------------------
>
> The following changes since commit ef8ee1cb8fc8976a68f5e89cd5f7b6f7de80c66f:
>
>   cpufreq: qcom-hw: Delay enabling throttle_irq (2022-02-09 13:18:49 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to b7f2b0d3511a6bbf9387f08f370f9125663e18d8:
>
>   dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings (2022-03-11 09:00:26 +0530)
>
> ----------------------------------------------------------------
> Bjorn Andersson (2):
>       cpufreq: qcom-hw: Add support for per-core-dcvs
>       cpufreq: blocklist Qualcomm sc8280xp and sa8540p in cpufreq-dt-platdev
>
> Denys Drozdov (1):
>       ARM: dts: imx7s: Define operating points table for cpufreq
>
> Luca Weiss (1):
>       cpufreq: qcom-cpufreq-nvmem: fix reading of PVS Valid fuse
>
> Manivannan Sadhasivam (2):
>       dt-bindings: dvfs: Use MediaTek CPUFREQ HW as an example
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings
>
> Pierre Gondois (1):
>       cpufreq: CPPC: Fix performance/frequency conversion
>
> Stefan Agner (1):
>       cpufreq: Add i.MX7S to cpufreq-dt-platdev blocklist
>
> Yury Norov (1):
>       cpufreq: replace cpumask_weight with cpumask_empty where appropriate
>
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 ------------------
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 201 +++++++++++++++++++++
>  .../bindings/dvfs/performance-domain.yaml          |  14 +-
>  arch/arm/boot/dts/imx7s.dtsi                       |  16 ++
>  drivers/cpufreq/cppc_cpufreq.c                     |  43 +++--
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
>  drivers/cpufreq/qcom-cpufreq-hw.c                  |  20 +-
>  drivers/cpufreq/qcom-cpufreq-nvmem.c               |   2 +-
>  drivers/cpufreq/scmi-cpufreq.c                     |   2 +-
>  9 files changed, 272 insertions(+), 201 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
>
>
> --

Pulled, thanks!
