Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C1B16D81
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 00:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEGWUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 18:20:54 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46709 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEGWUx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 18:20:53 -0400
Received: by mail-ua1-f68.google.com with SMTP id a95so1568249uaa.13
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2019 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kG2WwpyR7pHycbjDjCi479hB08AsdI45LDcaIB/Ay64=;
        b=hjN9Yj59LATp2bF3ohozr0h4VitiflbvzeOSSbSaBGOTZncsE7cab9AvJ68MTAf1J8
         AigRqhDNeiAuuGqitKYp/2M77PEINn2xOVFTboK++LZvbxCTNMTYZgwMBtdOQm1X1eG9
         4C6IMmkj2+4bQd5SP+0N/ZyMHWP9b86jy3rIH84FOb0vMCDIA5WZ+ndL74A0c9bAQ2SA
         9kccjisOJ6osEzEdxaxcxA4iQGkx/X2L6heAONlMtlyU766jXtqbhtoUE5Pi5AAA9ElW
         36e/N46YOH+pvb322fsrB0QNHmsFDi9PWJLbt4DYxsh+kDAH5JHvq+c0F5rGJgHMD087
         Vwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kG2WwpyR7pHycbjDjCi479hB08AsdI45LDcaIB/Ay64=;
        b=r09yxAul2DEDF0o+TOaLDD5fkiN+GbXx/IBfq9N830tUUReodZ+li7XUiG/7hHQlJp
         P7BMWQSZdx1AUnUPnfeIBH/dItJUUKaZUSEKgafNeVr0Sh5bDRGSF6ICf5XZolKdjZ7N
         OfpjGZkvFCV62uonXmZ1FiVwoDMOWNBqgJa/gFdYPZuo6WwHaC3t9ShrXBE8raJDIQ4B
         1UcZZPqQPG2L7TnAEnvfC7/i3XVO/MS5p+PXAR1UOqfuAtn8QxXlQ8Jo5p+14EXvXg/I
         VhVWhCvYLDhslTCXtvE8ub9lwcrtLMkja2nKq/CHf/7ZxOZOeNfd7VQYc/0Az3EoNE8K
         NESg==
X-Gm-Message-State: APjAAAVqthCwX8R//JksohGXeeO4TPrBBUuSK+t816GyCZTCUoIhiC9R
        CqrmWHd5u1wNtP07KBb156rk67b6ne76XlWJ2bn4kg==
X-Google-Smtp-Source: APXvYqwrszAopFQoWDWwRSifkvHAk3lphGUdOi1S0fZjHRLaae+7hRt/vMsz3eDDRvkDSU+RSKY7jYNP9xERgU+voI8=
X-Received: by 2002:ab0:70d4:: with SMTP id r20mr16052105ual.67.1557267652335;
 Tue, 07 May 2019 15:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
In-Reply-To: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 8 May 2019 03:50:40 +0530
Message-ID: <CAHLCerPi4Fd1eoPY=Gvo=FkVTGOt=ummAqHfWBi645Yb0O5-sg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, ilina@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 30, 2018 at 10:53 PM Raju P.L.S.S.S.N
<rplsssn@codeaurora.org> wrote:
>
> Add device bindings for cpuidle states for cpu devices.

Raju: Did this patch fall through the cracks? It would be nice to land
this while Lina works on setting up the infrastructure to do
hierarchical power domains.

> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
> Changes in v2
>  - Address comments from Doug
> ---
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0c9a2aa..3a8381e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -96,6 +96,7 @@
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_0>;
> +                       cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;

May I suggest using more generic names here instead of C0_CPU_PD and
move the QC-specific description to the idle-state-name property? C0
and C4 isn't easy to understand at a glance. Neither is PD and RPD.

Something like big_cpu_retention, big_cpu_sleep, little_cpu_retention,
little_cpu_sleep, cluster_sleep?
Or big_cpu_idle_0, big_cpu_idle_1, big_cpu_idle_2 for states with
increasing breakeven times.

I've commented below on what it might look like.

>                         L2_0: l2-cache {
>                                 compatible = "cache";
>                                 next-level-cache = <&L3_0>;
> @@ -111,6 +112,7 @@
>                         reg = <0x0 0x100>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_100>;
> +                       cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
>                         L2_100: l2-cache {
>                                 compatible = "cache";
>                                 next-level-cache = <&L3_0>;
> @@ -123,6 +125,7 @@
>                         reg = <0x0 0x200>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_200>;
> +                       cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
>                         L2_200: l2-cache {
>                                 compatible = "cache";
>                                 next-level-cache = <&L3_0>;
> @@ -135,6 +138,7 @@
>                         reg = <0x0 0x300>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_300>;
> +                       cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
>                         L2_300: l2-cache {
>                                 compatible = "cache";
>                                 next-level-cache = <&L3_0>;
> @@ -147,6 +151,7 @@
>                         reg = <0x0 0x400>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_400>;
> +                       cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
>                         L2_400: l2-cache {
>                                 compatible = "cache";
>                                 next-level-cache = <&L3_0>;
> @@ -159,6 +164,7 @@
>                         reg = <0x0 0x500>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_500>;
> +                       cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
>                         L2_500: l2-cache {
>                                 compatible = "cache";
>                                 next-level-cache = <&L3_0>;
> @@ -171,6 +177,7 @@
>                         reg = <0x0 0x600>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_600>;
> +                       cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
>                         L2_600: l2-cache {
>                                 compatible = "cache";
>                                 next-level-cache = <&L3_0>;
> @@ -183,11 +190,66 @@
>                         reg = <0x0 0x700>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_700>;
> +                       cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
>                         L2_700: l2-cache {
>                                 compatible = "cache";
>                                 next-level-cache = <&L3_0>;
>                         };
>                 };
> +
> +               idle-states {
> +                       entry-method = "psci";
> +
> +                       C0_CPU_PD: c0-power-down {

big_cpu_retention: big-cpu-retention

> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x40000003>;
> +                               entry-latency-us = <350>;
> +                               exit-latency-us = <461>;
> +                               min-residency-us = <1890>;
> +                               local-timer-stop;
> +                               idle-state-name = "power-down";

"big-cpu-power-down"

> +                       };
> +
> +                       C0_CPU_RPD: c0-rail-power-down {

big_cpu_sleep: big-cpu-sleep

> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x40000004>;
> +                               entry-latency-us = <360>;
> +                               exit-latency-us = <531>;
> +                               min-residency-us = <3934>;
> +                               local-timer-stop;
> +                               idle-state-name = "rail-power-down";

"big-cpu-rail-power-down"

> +                       };
> +
> +                       C4_CPU_PD: c4-power-down {

little_cpu_retention: little-cpu-retention

> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x40000003>;
> +                               entry-latency-us = <264>;
> +                               exit-latency-us = <621>;
> +                               min-residency-us = <952>;
> +                               local-timer-stop;
> +                               idle-state-name = "power-down";

"little-cpu-power-down" and so and so forth. You get the idea.

> +                       };
> +
> +                       C4_CPU_RPD: c4-rail-power-down {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x40000004>;
> +                               entry-latency-us = <702>;
> +                               exit-latency-us = <1061>;
> +                               min-residency-us = <4488>;
> +                               local-timer-stop;
> +                               idle-state-name = "rail-power-down";
> +                       };
> +
> +                       CLUSTER_PD: cluster-power-down {
> +                               compatible = "arm,idle-state";
> +                               arm,psci-suspend-param = <0x400000F4>;
> +                               entry-latency-us = <3263>;
> +                               exit-latency-us = <6562>;
> +                               min-residency-us = <9987>;
> +                               local-timer-stop;
> +                               idle-state-name = "cluster-power-down";
> +                       };
> +               };
>         };
>
>         pmu {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of the Code Aurora Forum, hosted by The Linux Foundation.
>
