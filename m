Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7185B42D68E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJNJ6D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhJNJ6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 05:58:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AD2C061753
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 02:55:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so24273033lfa.9
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmYUMK/UpCPTQkNa2eHt3u3bSnQ6UeJZgf9fcyINgsU=;
        b=mVYlAwjTxWDUaBNLDN0kgN/g/YvJGNU+qqXTHe/yDPKOT7wKUmz2VhEvsDmJpaLbUF
         JzmX5SOBfopOFWv4MMobCXKvOtq35pi9+Tv2h99NRH7LDKiMgD13AGFjtqXdfZVmA3/2
         LBBEQ24GND2moC7wMKG2krrUoGENkEJdY9LuvzsJIAXnUZ+qbQGNJhMBv7F4Zf5OLuFw
         0X+9oY7KpkjEJuBfbYCGHYr/2+Fx3OyQ9M/4ihjNNdGXU+RQYM5EfLcbh/75NClaUyHQ
         swSYYlaB6z+O2nPtdN8qjfZdFJUykeYjnZHyWiWQnuIHIDEf/QNrD9FadDjd70wRTuZZ
         eEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmYUMK/UpCPTQkNa2eHt3u3bSnQ6UeJZgf9fcyINgsU=;
        b=s+H6d3v4bqFDDugbce0GND2BXdbi/0O1Z0Dtp1O5RgPpqldTYM8wodUW72q2ktwFae
         1rHeu9Y2vZ1yUK4/oUsjZZJ+v5ZgbqsvfU9ZBZBEdttbM6dpSFSJF1HWXF8rCSV+7Mjz
         ktIxEeSLW18B7+V0X2TCNaWIeL+dCrQjUBYEmZas/3Mw4MSIqo0A+TE8p409kfmxnw66
         QDHNRqj2KzqkwIKg42gi9UwpoxyNYGxhz0THkvMOKGHHsCt8/aGNf7vvZKHeYScWXqx9
         Nc1SPKKcjroz0TTvNkZ+1PyFCyQLNJ88tthPWII4WJScXonajllXBk978jjA6QlgUEup
         aTzw==
X-Gm-Message-State: AOAM533Ld4JBTcB+rNRBDg+0/fD65KOIsuDhXu8p0s7le0a0cjG/HdAh
        l9WmWBmUCTLaYmgh59i0VrMzXRUBsUalWXie//Vrxw==
X-Google-Smtp-Source: ABdhPJzfcuLOXluZNCiIFiHuEMZOmaPq4SFwqJhe51BVnbLOcrMdlfjEobokM/9rmKz908yjKMJDYvKU8LEE1TjdTto=
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr5021872ljj.4.1634205356539;
 Thu, 14 Oct 2021 02:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211011165707.138157-1-marcan@marcan.st> <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7> <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7> <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
In-Reply-To: <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Oct 2021 11:55:16 +0200
Message-ID: <CAPDyKFoVjVYkc4+v-=eD+JbC10GazGt8A1LtD1so3PKMmVcyMg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device does
 not exist
To:     Hector Martin <marcan@marcan.st>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 12 Oct 2021 at 07:57, Hector Martin <marcan@marcan.st> wrote:
>
> On 12/10/2021 14.51, Viresh Kumar wrote:
> > On 12-10-21, 14:34, Hector Martin wrote:
> >> The table *is* assigned to a genpd (the memory controller), it's just that
> >> that genpd isn't actually a parent of the CPU device. Without the patch you
> >> end up with:
> >>
> >> [    3.040060] cpu cpu4: Failed to set performance rate of cpu4: 0 (-19)
> >> [    3.042881] cpu cpu4: Failed to set required opps: -19
> >> [    3.045508] cpufreq: __target_index: Failed to change cpu frequency: -19
> >
> > Hmm, Saravana and Sibi were working on a similar problem earlier and decided to
> > solve this using devfreq instead. Don't remember the exact series which got
> > merged for this, Sibi ?
> >
> > If this part fails, how do you actually set the performance state of the memory
> > controller's genpd ?
>
> The clock controller has the genpd as an actual power-domain parent, so
> it does it instead. From patch #7:
>
> > +     if (cluster->has_pd)
> > +             dev_pm_genpd_set_performance_state(cluster->dev,
> > +                                                dev_pm_opp_get_required_pstate(opp, 0));
> > +
>
> This is arguably not entirely representative of how the hardware works,
> since technically the cluster switching couldn't care less what the
> memory controller is doing; it's a soft dependency, states that should
> be switched together but are not interdependent (in fact, the clock code
> does this unconditionally after the CPU p-state change, regardless of
> whether we're shifting up or down; this is, FWIW, the same order macOS
> uses, and it clearly doesn't matter which way you do it).

Yes, this sounds like you should move away from modeling the memory
part as a parent genpd for the CPUs' genpd.

As Viresh pointed out, a devfreq driver seems like a better way to do
this. As a matter of fact, there are already devfreq drivers that do
this, unless I am mistaken.

It looks like devfreq providers are listening to opp/cpufreq
notifiers, as to get an indication of when it could make sense to
change a performance state.

In some cases the devfreq provider is also modeled as an interconnect
provider, allowing consumers to specify memory bandwidth constraints,
which may trigger a new performance state to be set for the memory
controller.

In the tegra case, the memory controller is modelled as an
interconnect provider and the devfreq node is modelled as an
interconnect-consumer of the memory controller. Perhaps this can work
for apple SoCs too?

That said, perhaps as an option to move forward, we can try to get the
cpufreq pieces solved first. Then as a step on top, add the
performance scaling for the memory controller?

>
> --
> Hector Martin (marcan@marcan.st)
> Public Key: https://mrcn.st/pub

Kind regards
Uffe
