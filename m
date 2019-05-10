Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE919CC0
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfEJLcr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 07:32:47 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40506 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfEJLcq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 07:32:46 -0400
Received: by mail-vs1-f67.google.com with SMTP id c24so3409806vsp.7
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2019 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZ6jdrso6YQALlBTVPqF+EIbIXa/5T6qU7atBIjlHzE=;
        b=bmS478xntfqH8sBnIfU0e8lUZ+IyJrNyjuKlvqHnRfKi6EW1w+GTj1v0vKCz9XqnLZ
         Ax6dlcJJbw5ZhA8Z5+9m9quq8smi7gN/io/ZBbW1VJE4d1IT1bLeDwRcQqddIOnly++7
         UDaesyMK53z6umFQeMQkjirZAR+wjSjy99YnOX5tqgXEQrxi0oEirU6tP+xVqiizrhhz
         +fFIDs+wo6aeCxRnu/g7weKH26jovcsH1/xDu9FLyiUPhlQe1XtOGHpJjeKXRegCkojD
         woBhUloWtO9g9l+vRs3YDmAiegrNq1IECF81rc7nMc3gn6gG/G4BCTtE+hDoVU32rJ4q
         +1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZ6jdrso6YQALlBTVPqF+EIbIXa/5T6qU7atBIjlHzE=;
        b=iXW/BJp3GiFklYCKR9XqsPm81JiJq28/Y2ZHI48nQwq+EISuL87GJSz95ZeFsNRAKT
         x1u7xySyEC/11qWCL3thpwygA4j3+NGxQeXKf4XjmJeevybwGOHZ0yP3DpMhdPm+DOOC
         /uNLoNNEZEV782vq8bn58AqqqgQlL9jSCaCh15vEjPlvTpkcEzCID0+QXiUlivBi5qZd
         TTEBE9faYrT6Z4assb0GS+AOHn2aW8y7H/yvrlKw73TSPANQH6ONgj95UqKW+BWIIu2j
         ghHmM1TV7CS/dI/TOG8Ee4BUs0nO2k30JrttIutwcY2E0utIQ5OWfju80K2Pn5L7xCDu
         MdSg==
X-Gm-Message-State: APjAAAXiwfrYpmG3XK7tqFzjBBxMWY5l/J305j+m1TbJJmYoPzGPjzOi
        oqqvOqcbI6mjF+gIaTNV1KEqGKB48ULdazzCZlY2Gw==
X-Google-Smtp-Source: APXvYqw8PYl+JTeswJ1Y+6b/ngXS9B1z8SHxtcK61kSoDXUQVdpLhLKsYWVXIQe+XEM3TMbxgk1/QH89BINLpDcgmdw=
X-Received: by 2002:a67:ad03:: with SMTP id t3mr4940787vsl.159.1557487965449;
 Fri, 10 May 2019 04:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org> <CAHLCerPi4Fd1eoPY=Gvo=FkVTGOt=ummAqHfWBi645Yb0O5-sg@mail.gmail.com>
In-Reply-To: <CAHLCerPi4Fd1eoPY=Gvo=FkVTGOt=ummAqHfWBi645Yb0O5-sg@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 10 May 2019 17:02:34 +0530
Message-ID: <CAHLCerOsQVHhFfkDX-+dJ9SZjUzW64+B85S6cLMHjqhRBoW1vw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, mkshah@codeaurora.org
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

On Wed, May 8, 2019 at 3:50 AM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> On Tue, Oct 30, 2018 at 10:53 PM Raju P.L.S.S.S.N
> <rplsssn@codeaurora.org> wrote:
> >
> > Add device bindings for cpuidle states for cpu devices.
>
> Raju: Did this patch fall through the cracks? It would be nice to land
> this while Lina works on setting up the infrastructure to do
> hierarchical power domains.

After talking offline with Raju, I've added this patch with some
cleanups to my qcom cpuidle series.

> > Cc: <devicetree@vger.kernel.org>
> > Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> > ---
> > Changes in v2
> >  - Address comments from Doug
> > ---
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 0c9a2aa..3a8381e 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -96,6 +96,7 @@
> >                         reg = <0x0 0x0>;
> >                         enable-method = "psci";
> >                         next-level-cache = <&L2_0>;
> > +                       cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
>
> May I suggest using more generic names here instead of C0_CPU_PD and
> move the QC-specific description to the idle-state-name property? C0
> and C4 isn't easy to understand at a glance. Neither is PD and RPD.
>
> Something like big_cpu_retention, big_cpu_sleep, little_cpu_retention,
> little_cpu_sleep, cluster_sleep?
> Or big_cpu_idle_0, big_cpu_idle_1, big_cpu_idle_2 for states with
> increasing breakeven times.
>
> I've commented below on what it might look like.
>
> >                         L2_0: l2-cache {
> >                                 compatible = "cache";
> >                                 next-level-cache = <&L3_0>;
> > @@ -111,6 +112,7 @@
> >                         reg = <0x0 0x100>;
> >                         enable-method = "psci";
> >                         next-level-cache = <&L2_100>;
> > +                       cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> >                         L2_100: l2-cache {
> >                                 compatible = "cache";
> >                                 next-level-cache = <&L3_0>;
> > @@ -123,6 +125,7 @@
> >                         reg = <0x0 0x200>;
> >                         enable-method = "psci";
> >                         next-level-cache = <&L2_200>;
> > +                       cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> >                         L2_200: l2-cache {
> >                                 compatible = "cache";
> >                                 next-level-cache = <&L3_0>;
> > @@ -135,6 +138,7 @@
> >                         reg = <0x0 0x300>;
> >                         enable-method = "psci";
> >                         next-level-cache = <&L2_300>;
> > +                       cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
> >                         L2_300: l2-cache {
> >                                 compatible = "cache";
> >                                 next-level-cache = <&L3_0>;
> > @@ -147,6 +151,7 @@
> >                         reg = <0x0 0x400>;
> >                         enable-method = "psci";
> >                         next-level-cache = <&L2_400>;
> > +                       cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> >                         L2_400: l2-cache {
> >                                 compatible = "cache";
> >                                 next-level-cache = <&L3_0>;
> > @@ -159,6 +164,7 @@
> >                         reg = <0x0 0x500>;
> >                         enable-method = "psci";
> >                         next-level-cache = <&L2_500>;
> > +                       cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> >                         L2_500: l2-cache {
> >                                 compatible = "cache";
> >                                 next-level-cache = <&L3_0>;
> > @@ -171,6 +177,7 @@
> >                         reg = <0x0 0x600>;
> >                         enable-method = "psci";
> >                         next-level-cache = <&L2_600>;
> > +                       cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> >                         L2_600: l2-cache {
> >                                 compatible = "cache";
> >                                 next-level-cache = <&L3_0>;
> > @@ -183,11 +190,66 @@
> >                         reg = <0x0 0x700>;
> >                         enable-method = "psci";
> >                         next-level-cache = <&L2_700>;
> > +                       cpu-idle-states = <&C4_CPU_PD &C4_CPU_RPD &CLUSTER_PD>;
> >                         L2_700: l2-cache {
> >                                 compatible = "cache";
> >                                 next-level-cache = <&L3_0>;
> >                         };
> >                 };
> > +
> > +               idle-states {
> > +                       entry-method = "psci";
> > +
> > +                       C0_CPU_PD: c0-power-down {
>
> big_cpu_retention: big-cpu-retention
>
> > +                               compatible = "arm,idle-state";
> > +                               arm,psci-suspend-param = <0x40000003>;
> > +                               entry-latency-us = <350>;
> > +                               exit-latency-us = <461>;
> > +                               min-residency-us = <1890>;
> > +                               local-timer-stop;
> > +                               idle-state-name = "power-down";
>
> "big-cpu-power-down"
>
> > +                       };
> > +
> > +                       C0_CPU_RPD: c0-rail-power-down {
>
> big_cpu_sleep: big-cpu-sleep
>
> > +                               compatible = "arm,idle-state";
> > +                               arm,psci-suspend-param = <0x40000004>;
> > +                               entry-latency-us = <360>;
> > +                               exit-latency-us = <531>;
> > +                               min-residency-us = <3934>;
> > +                               local-timer-stop;
> > +                               idle-state-name = "rail-power-down";
>
> "big-cpu-rail-power-down"
>
> > +                       };
> > +
> > +                       C4_CPU_PD: c4-power-down {
>
> little_cpu_retention: little-cpu-retention
>
> > +                               compatible = "arm,idle-state";
> > +                               arm,psci-suspend-param = <0x40000003>;
> > +                               entry-latency-us = <264>;
> > +                               exit-latency-us = <621>;
> > +                               min-residency-us = <952>;
> > +                               local-timer-stop;
> > +                               idle-state-name = "power-down";
>
> "little-cpu-power-down" and so and so forth. You get the idea.
>
> > +                       };
> > +
> > +                       C4_CPU_RPD: c4-rail-power-down {
> > +                               compatible = "arm,idle-state";
> > +                               arm,psci-suspend-param = <0x40000004>;
> > +                               entry-latency-us = <702>;
> > +                               exit-latency-us = <1061>;
> > +                               min-residency-us = <4488>;
> > +                               local-timer-stop;
> > +                               idle-state-name = "rail-power-down";
> > +                       };
> > +
> > +                       CLUSTER_PD: cluster-power-down {
> > +                               compatible = "arm,idle-state";
> > +                               arm,psci-suspend-param = <0x400000F4>;
> > +                               entry-latency-us = <3263>;
> > +                               exit-latency-us = <6562>;
> > +                               min-residency-us = <9987>;
> > +                               local-timer-stop;
> > +                               idle-state-name = "cluster-power-down";
> > +                       };
> > +               };
> >         };
> >
> >         pmu {
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of the Code Aurora Forum, hosted by The Linux Foundation.
> >
