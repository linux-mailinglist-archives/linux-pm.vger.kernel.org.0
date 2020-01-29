Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C209314C4BF
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 03:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgA2Cye (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jan 2020 21:54:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34955 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgA2Cye (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 21:54:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so17064695edv.2;
        Tue, 28 Jan 2020 18:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UEKMceVTDeB9yuXPP3B3U0Lv4PO/8mWNZmTu3sg4+U=;
        b=neRzTTTyUeMpgqsSkWRkEs+p0oKLQ6Godsht51e6owlTJDNHTwx6OEqfSQRezFoK7U
         Ut9L558vW3ST/FKKG6GZtXODPkrZ75IdnwEUEHfRHUkE8YRe9pNTr/ba5WMi7LptuXez
         ePeV56eQnlKt+P2MLiAbmzf7qsJphjyXfVOCAKfwn2rNt/tOxnWCpQknKgVa4WqeH0Sc
         LrMPvtXhDa1/parW3mL7auJvOocb3zi7xnn/ijOAHHRRgw1jiFSXivB8EaMQMEgQq3Oi
         Z5PGpEGJX2Meg8CpM5UcJuwObycRatXOK8FubV4NRv95g1Ilm1sBLiRPjLUF1+cBUkZ/
         2GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UEKMceVTDeB9yuXPP3B3U0Lv4PO/8mWNZmTu3sg4+U=;
        b=ZBtQC2jc14cfwU02h+Nz9xVMw9NprI1jMbklfpEGMwuwLU2bk+tLwn6niHljYlk7bq
         aX4zfZ245SkjOxw4YOSFl4tKnnlFMyVQkrt172Lq2j3zCI+BRTgq9OzducB0gM9gE/10
         sOM5XD5kDM311iPGQPm6aImEQ3JFbbxfwHFwYdSx8M3Dh/8eMzbNjvBZHSJk81XPxwax
         ZYk15aNYbLbtDrji8iegO+Yv/IhrrB38Fly/1MuwYu07Olby3gMB8EJ2Ppwk/665wRNS
         EnBdLW0Dwgj/XNK6KkaqBvseqV8RpUvuScAeq9z/5Kw1SVaHZPfiTp+6pEYqB+ciWyOY
         gkVw==
X-Gm-Message-State: APjAAAWufsw/+KhmwZj7ERgwbQ3i+3BumX1bK/SwBFbEi7viw8pYFmLK
        8/ebEn6rpSqfZ1MdmoFqJn+AJiMh1fp9xItOaHc=
X-Google-Smtp-Source: APXvYqyuYCqDvz4wF4LYrzNOvM8tT5rEcO75E+OnBxkO92K6IPXIA8g8CdWljATcO/1tx92SHU7wAFCZv5anphyGpWA=
X-Received: by 2002:a17:906:604c:: with SMTP id p12mr5667403ejj.202.1580266472040;
 Tue, 28 Jan 2020 18:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20200127200350.24465-1-sibis@codeaurora.org>
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 28 Jan 2020 18:54:20 -0800
Message-ID: <CAF6AEGuhKKbmK7xGX2RT=LbGz_r_4LsPOuU3-mj4gfhX3EBU-Q@mail.gmail.com>
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>, saravanak@google.com,
        "Menon, Nishanth" <nm@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 27, 2020 at 12:05 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> This RFC series aims to extend cpu based scaling support to L3/DDR on
> SDM845 and SC7180 SoCs.
>
> Patches [1-3] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
> Patches [5-7] - Hack in a way to add/remove multiple opp tables to
>                 a single device. I am yet to fix the debugfs to
>                 support multiple opp_tables per device but wanted to
>                 send what was working upstream to get an idea if multiple
>                 opp tables per device is a feature that will be useful
>                 upstream.
> Patches [9-10] - Add the cpu/cpu-ddr/cpu-l3 opp tables for SDM845
>                  and SC7180 SoCs.
>
> v3:
>  * Migrated to using Saravana's opp-kBps bindings [1]
>  * Fixed some misc comments from Rajendra
>  * Added support for SC7180
>
> v2:
>  * Incorporated Viresh's comments from:
>  https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
>  https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
>  * Dropped cpufreq-map passive governor
>
> Git-branch: https://github.com/QuinAsura/linux/tree/lnext-012420
>
> Some alternate ways of hosting the opp-tables:
> https://github.com/QuinAsura/linux/commit/50b92bfaadc8f9a0d1e12249646e018bd6d1a9d3
> https://github.com/QuinAsura/linux/commit/3d23d1eefd16ae6d9e3ef91e93e78749d8844e98
> Viresh didn't really like ^^ bindings and they dont really scale well. Just
> including them here for completeness.
>
> Depends on the following series:
> [1] https://patchwork.kernel.org/cover/11277199/
> [2] https://patchwork.kernel.org/cover/11055499/
> [3] https://patchwork.kernel.org/cover/11326381/

So drive-by question, from the perspective of someone who cares about
a non-cpu device that frequently enjoys a lot of bandwidth (ie. the
GPU).. any thoughts on how ddr scaling would/should work for workloads
where the CPU is not particularly busy?

BR,
-R

>
> Sibi Sankar (10):
>   arm64: dts: qcom: sdm845: Add SoC compatible to MTP
>   cpufreq: blacklist SDM845 in cpufreq-dt-platdev
>   cpufreq: blacklist SC7180 in cpufreq-dt-platdev
>   OPP: Add and export helper to update voltage
>   opp: of: export _opp_of_get_opp_desc_node
>   opp: Allow multiple opp_tables to be mapped to a single device
>   opp: Remove multiple attached opp tables from a device
>   cpufreq: qcom: Update the bandwidth levels on frequency change
>   arm64: dts: qcom: sdm845: Add cpu OPP tables
>   arm64: dts: qcom: sc7180: Add cpu OPP tables
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 287 +++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 453 ++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c    |   2 +
>  drivers/cpufreq/qcom-cpufreq-hw.c       | 246 +++++++++++--
>  drivers/opp/core.c                      | 111 +++++-
>  drivers/opp/of.c                        |   3 +-
>  drivers/opp/opp.h                       |   2 +
>  include/linux/pm_opp.h                  |  10 +
>  9 files changed, 1083 insertions(+), 33 deletions(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
