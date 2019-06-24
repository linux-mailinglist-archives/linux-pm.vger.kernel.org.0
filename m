Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8032951E13
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 00:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFXWRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 18:17:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46820 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFXWRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 18:17:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so10965411oid.13
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyZtJbcLWTPh/r2aMOqaTZJx82vxwJ/WY4Wjw83iZpY=;
        b=shTVoSS2XF2z+5OjiXnPdpQNeCEMWeGPtAs7//zeOzORNDFb9q5ViyY1xp6ezKCq0W
         XwwqyCJ2zfHsHrYOFIlsV9OqWweSRHXF1mvq+OhyWhgzeKr71SD/Rc/h/1XqeT4EKTKj
         /4SPpaXk7yzD9NVyU+4qg9iEFXFbHeaJw6mbAzXlhDK6emEJOaeBl81kHCCJ2Wx6wuEQ
         t/gUxhtFVfDk4P+bdfARYQ/MfxwnZZifmXnwNtG3ZsYYtKR7m7vKNAt5K0Bm3OGYVx5L
         7lmRiM6g2OTicSiZr98RUXrRaLq58K3rh9nloQNLCr6NkApaHrb5su8T7eLqOTHperBT
         qVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyZtJbcLWTPh/r2aMOqaTZJx82vxwJ/WY4Wjw83iZpY=;
        b=Fnz+sld64hJCk8PdD6Jaa4tIlioxB0+1LjigTr+m/z8cJ5V4KHx6acGNJsMZXYMZuB
         UmF944gptmb7pvTSC3dLXWMSmw9iahrvdWEs8ZbPcShzk01mResnoP7KsPJOt/zNZLBI
         Ag12scIgFyOFElYKhcwNR1Z2+HcVlZbyXK9P1UFrWhwUTlJSGN5/7KXuHq1KHi6vcs9x
         LwFNR8DgqqQ6Yt4kZJreKmChxc70MI2UkT+fFvVfcGgAF5Vvo+EJwcdjbLPU0DaJ1vrH
         zwN3a0cP46fcppEb9+9jkA48027j4Fh47LBU99WoXtrHfbE7WtgpHzE/CGZC/XDM4yXP
         k3Og==
X-Gm-Message-State: APjAAAX2WrhGfGTZkUq8GrJcB/M4SxIGZ9jkXbDshQW6GWYXkxhBaX2O
        Vhl9aypgJwytLEZTXpHRLS5g1BZIC7PoWEiopLGXAA==
X-Google-Smtp-Source: APXvYqzNRa1SDtLuepKsEqIVimP3WUsxe43gNIRcxXWSJxVlgx1+CG0a2uP3Ow4kd/dieKuxWRi6HY1aLU+xIacMwzk=
X-Received: by 2002:aca:e641:: with SMTP id d62mr12090301oih.24.1561414664083;
 Mon, 24 Jun 2019 15:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
In-Reply-To: <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 24 Jun 2019 15:17:08 -0700
Message-ID: <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
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

On Mon, Jun 24, 2019 at 2:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-06-19, 17:34, Saravana Kannan wrote:
> > The devfreq passive governor scales the frequency of a "child" device
> > based on the current frequency of a "parent" device (not parent/child in
> > the sense of device hierarchy). As of today, the passive governor
> > requires one of the following to work correctly:
> > 1. The parent and child device have the same number of frequencies
> > 2. The child device driver passes a mapping function to translate from
> >    parent frequency to child frequency.
> >
> > When (1) is not true, (2) is the only option right now. But often times,
> > all that is required is a simple mapping from parent's frequency to
> > child's frequency.
> >
> > Since OPPs already support pointing to other "required-opps", add
> > support for using that to map from parent device frequency to child
> > device frequency. That way, every child device driver doesn't have to
> > implement a separate mapping function anytime (1) isn't true.
>
> Can you please provide a real world example with DT code here so I
> can understand it better ?
>

Here's an example. This can't be done today, but can be done with this change.

In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
like this with the following changes:

        bus_g2d_400: bus0 {
                compatible = "samsung,exynos-bus";
                clocks = <&cmu_top CLK_ACLK_G2D_400>;
                clock-names = "bus";
                operating-points-v2 = <&bus_g2d_400_opp_table>;
                status = "disabled";
        };

        bus_noc2: bus9 {
                compatible = "samsung,exynos-bus";
                clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
                clock-names = "bus";
                operating-points-v2 = <&bus_noc2_opp_table>;
                status = "disabled";
        };

        bus_g2d_400_opp_table: opp_table2 {
                compatible = "operating-points-v2";
                opp-shared;

                opp-400000000 {
                        opp-hz = /bits/ 64 <400000000>;
                        opp-microvolt = <1075000>;
+                       required-opps = <&noc2_400>;
                };
                opp-267000000 {
                        opp-hz = /bits/ 64 <267000000>;
                        opp-microvolt = <1000000>;
+                       required-opps = <&noc2_200>;
                };
                opp-200000000 {
                        opp-hz = /bits/ 64 <200000000>;
                        opp-microvolt = <975000>;
+                       required-opps = <&noc2_200>;
                };
                opp-160000000 {
                        opp-hz = /bits/ 64 <160000000>;
                        opp-microvolt = <962500>;
+                       required-opps = <&noc2_134>;
                };
                opp-134000000 {
                        opp-hz = /bits/ 64 <134000000>;
                        opp-microvolt = <950000>;
+                       required-opps = <&noc2_134>;
                };
                opp-100000000 {
                        opp-hz = /bits/ 64 <100000000>;
                        opp-microvolt = <937500>;
+                       required-opps = <&noc2_100>;
                };
        };

        bus_noc2_opp_table: opp_table6 {
                compatible = "operating-points-v2";

-               opp-400000000 {
+               noc2_400: opp-400000000 {
                        opp-hz = /bits/ 64 <400000000>;
                };
-               opp-200000000 {
+               noc2_200: opp-200000000 {
                        opp-hz = /bits/ 64 <200000000>;
                };
-               opp-134000000 {
+               noc2_134: opp-134000000 {
                        opp-hz = /bits/ 64 <134000000>;
                };
-               opp-100000000 {
+               noc2_100: opp-100000000 {
                        opp-hz = /bits/ 64 <100000000>;
                };
        };

Thanks,
Saravana
