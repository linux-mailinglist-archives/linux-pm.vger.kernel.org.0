Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B052264
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 07:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfFYFBO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 01:01:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47053 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfFYFBO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 01:01:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so15893905ote.13
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 22:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FiWZ2EDD0rw2uVwTPcPpwKCRYVAB2YpkUcFt/RoDHFg=;
        b=h2ZnK3LznJI6S7SAeuxH3gYSOm3Q46IkEfZYnlMHDHJSgb/D+29DRJEThb0zn697Nv
         J40HS+8xvni6r+ocl+LFtkRncQ2gYWpw59kctMX/um3yfQd6HkO4SwOSZ8sPeOMAw2Gl
         tQ8xtOV4AZMux6pVG3FEdW8lwJV7eYRAiNZGVLKEbTzfVS3UMMdzdR9rSJ3UohOdoL8F
         odRlV7D9njg28Pc766RWsvrmZXsY8oLzbeh9Z7ZXrbUFoCZ+6WasWt8fxBi9bC+6/Veu
         GuacCyrxmrLA9z6AXu2T2zIhdjT02wNCsT2N9WdaEJPyA+NgvGpOhgck4dQNol96ULhW
         QfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiWZ2EDD0rw2uVwTPcPpwKCRYVAB2YpkUcFt/RoDHFg=;
        b=mFs3QomRvbdlWhWVRVscXaNoNui8pu+dI3koq4HQL16f0BES/8+2XDuRcMMmvMoy9z
         jqPE6D/gDqEZiw+BqBTR94jVaxs0xLOonVnzV2m8Wiju1OOjjqePbHiw+ufy/qhaLPt5
         a8ynxXOLdeQGi7tS6GFH7wZlqgrvprmsn9dBcmvB4mZMWOvr1MZQuYpwXaFymXIUx8MU
         1Q6pAN/lnkLDmDGs+wFJXZiy7OI49m/GjyH8WBhmPpEkjoMFuYisvwlM/QBUe8/oTdjf
         8Vy3cH6UvzqFeRdi174wt4Qa5Ifb+EYiWkUHLjxhxATzbc4eZRMlMZ+sXlYDMa5BjwIS
         db5A==
X-Gm-Message-State: APjAAAXK78ux/QZs86R2pgPJ2x5hUdbyhyw49km2BHteo7eMBWdCWuti
        lCNb4X49v+TGp4eiEOuqqL/NuxkNRxPiFNdZMxWw5A==
X-Google-Smtp-Source: APXvYqzgdBU5Y2VM+8537LWcXwQZRNMQz9DeoMH9K9VV1vHeAJUteDxgyA7Rt5xS+P+0QXiO8vWQ6WDn6Vf8TD07OG4=
X-Received: by 2002:a9d:1909:: with SMTP id j9mr1453244ota.139.1561438872815;
 Mon, 24 Jun 2019 22:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com> <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7>
In-Reply-To: <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 24 Jun 2019 22:00:37 -0700
Message-ID: <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 24, 2019 at 9:11 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-06-19, 15:17, Saravana Kannan wrote:
> > Here's an example. This can't be done today, but can be done with this change.
> >
> > In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
> > like this with the following changes:
> >
> >         bus_g2d_400: bus0 {
> >                 compatible = "samsung,exynos-bus";
> >                 clocks = <&cmu_top CLK_ACLK_G2D_400>;
> >                 clock-names = "bus";
> >                 operating-points-v2 = <&bus_g2d_400_opp_table>;
> >                 status = "disabled";
> >         };
> >
> >         bus_noc2: bus9 {
> >                 compatible = "samsung,exynos-bus";
> >                 clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
> >                 clock-names = "bus";
> >                 operating-points-v2 = <&bus_noc2_opp_table>;
> >                 status = "disabled";
> >         };
>
> And what is the relation between these two busses ?

I can't speak for the Exynos hardware. Maybe Chanwoo knows.

But a couple of common reasons to do this between devices are:
1. These were the combination of frequencies that were
validated/screen during the manufacturing process.
2. These are the sensible performance combinations between two devices
interacting with each other. So that when one runs fast the other
doesn't become the bottleneck.
3. Hardware bugs requiring some kind of frequency ratio between devices.

All of the cases above are some real world scenarios I've come across.
CPU and L2/L3 on ARM systems are a good example of (2) but the passive
governor doesn't work with CPUs yet. But I plan to work on that later
as that's not related to this patch series.

-Saravana

> >         bus_g2d_400_opp_table: opp_table2 {
> >                 compatible = "operating-points-v2";
> >                 opp-shared;
> >
> >                 opp-400000000 {
> >                         opp-hz = /bits/ 64 <400000000>;
> >                         opp-microvolt = <1075000>;
> > +                       required-opps = <&noc2_400>;
> >                 };
> >                 opp-267000000 {
> >                         opp-hz = /bits/ 64 <267000000>;
> >                         opp-microvolt = <1000000>;
> > +                       required-opps = <&noc2_200>;
> >                 };
> >                 opp-200000000 {
> >                         opp-hz = /bits/ 64 <200000000>;
> >                         opp-microvolt = <975000>;
> > +                       required-opps = <&noc2_200>;
> >                 };
> >                 opp-160000000 {
> >                         opp-hz = /bits/ 64 <160000000>;
> >                         opp-microvolt = <962500>;
> > +                       required-opps = <&noc2_134>;
> >                 };
> >                 opp-134000000 {
> >                         opp-hz = /bits/ 64 <134000000>;
> >                         opp-microvolt = <950000>;
> > +                       required-opps = <&noc2_134>;
> >                 };
> >                 opp-100000000 {
> >                         opp-hz = /bits/ 64 <100000000>;
> >                         opp-microvolt = <937500>;
> > +                       required-opps = <&noc2_100>;
> >                 };
> >         };
> >
> >         bus_noc2_opp_table: opp_table6 {
> >                 compatible = "operating-points-v2";
> >
> > -               opp-400000000 {
> > +               noc2_400: opp-400000000 {
> >                         opp-hz = /bits/ 64 <400000000>;
> >                 };
> > -               opp-200000000 {
> > +               noc2_200: opp-200000000 {
> >                         opp-hz = /bits/ 64 <200000000>;
> >                 };
> > -               opp-134000000 {
> > +               noc2_134: opp-134000000 {
> >                         opp-hz = /bits/ 64 <134000000>;
> >                 };
> > -               opp-100000000 {
> > +               noc2_100: opp-100000000 {
> >                         opp-hz = /bits/ 64 <100000000>;
> >                 };
> >         };
> >
> > Thanks,
> > Saravana
>
> --
> viresh
