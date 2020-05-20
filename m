Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61801DB749
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgETOnQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 10:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETOnQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 10:43:16 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D60D20884;
        Wed, 20 May 2020 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589985795;
        bh=93xiZdfQmazN0EU3A6j+wlLxKCqDuPGLCkRTQ2Xp2Dk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zqJjU+Pe293oZ6ocassxcPcA2DVflYdbghR2e84eL9bvigCMGhmQkEOCWyB9x9qMk
         tqfg3MOzrmqIwWdyGsSFsZlCwfR41ZaBdF245d85c681C2Dl3glo6eQhgQz0uzWQtO
         S6isGeYhInUenMyUNLrWaEyxfF/HwQyFKs4eh/rE=
Received: by mail-oi1-f169.google.com with SMTP id j145so3145628oib.5;
        Wed, 20 May 2020 07:43:15 -0700 (PDT)
X-Gm-Message-State: AOAM531+BIqNCKzDa8kyNYT9iHKcVz+hzG9LYtYjVpkvzmCpW0ZWbXK8
        2Wk1MTbzsQyze6n4fZOoZw17xvzizvpj3f2hZA==
X-Google-Smtp-Source: ABdhPJzyaxh/SnkAwbz5oRVIMrIQtReCF6vMmwmfUuuZxVCZFWwPmcpMMg2xoPSi8xvODJyqRQJXHWuqYsTq1+BbBwk=
X-Received: by 2002:a05:6808:24f:: with SMTP id m15mr3499546oie.152.1589985794742;
 Wed, 20 May 2020 07:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo> <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
 <20191204091703.d32to5omdm3eynon@vireshk-i7> <20191204093339.GA2784830@ulmo>
 <20191204095138.rrul5vxnkprfwmku@vireshk-i7> <20200407100520.GA1720957@ulmo>
In-Reply-To: <20200407100520.GA1720957@ulmo>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 May 2020 08:43:03 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rMYAZ=ub0U7qdHSsWgbQugodhvigFCxrFm49HwrCmAQ@mail.gmail.com>
Message-ID: <CAL_Jsq+rMYAZ=ub0U7qdHSsWgbQugodhvigFCxrFm49HwrCmAQ@mail.gmail.com>
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Sumit Gupta <sumitg@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bbasu@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 7, 2020 at 4:05 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Dec 04, 2019 at 03:21:38PM +0530, Viresh Kumar wrote:
> > On 04-12-19, 10:33, Thierry Reding wrote:
> > > Yeah, the code that registers this device is in drivers/base/cpu.c in
> > > register_cpu(). It even retrieves the device tree node for the CPU from
> > > device tree and stores it in cpu->dev.of_node, so we should be able to
> > > just pass &cpu->dev to tegra_bpmp_get() in order to retrieve a reference
> > > to the BPMP.
> > >
> > > That said, I'm wondering if perhaps we could just add a compatible
> > > string to the /cpus node for cases like this where we don't have an
> > > actual device representing the CPU complex. There are a number of CPU
> > > frequency drivers that register dummy devices just so that they have
> > > something to bind a driver to.
> > >
> > > If we allow the /cpus node to represent the CPU complex (if no other
> > > "device" does that yet), we can add a compatible string and have the
> > > cpufreq driver match on that.
> > >
> > > Of course this would be slightly difficult to retrofit into existing
> > > drivers because they'd need to remain backwards compatible with existing
> > > device trees. But it would allow future drivers to do this a little more
> > > elegantly. For some SoCs this may not matter, but especially once you
> > > start depending on additional resources this would come in handy.
> > >
> > > Adding Rob and the device tree mailing list for feedback on this idea.
> >
> > Took some time to find this thread, but something around this was
> > suggested by Rafael earlier.
> >
> > https://lore.kernel.org/lkml/8139001.Q4eV8YG1Il@vostro.rjw.lan/
>
> I gave this a try and came up with the following:
>
> --- >8 ---
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index f4ede86e32b4..e4462f95f0b3 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1764,6 +1764,9 @@ bpmp_thermal: thermal {
>         };
>
>         cpus {
> +               compatible = "nvidia,tegra194-ccplex";
> +               nvidia,bpmp = <&bpmp>;

Is there more than 1 bpmp? If not you don't need this. Just lookup the
node by compatible.


> +
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> --- >8 ---
>
> Now I can do something rougly like this, although I have a more complete
> patch locally that also gets rid of all the global variables because we
> now actually have a struct platform_device that we can anchor everything
> at:
>
> --- >8 ---
> static const struct of_device_id tegra194_cpufreq_of_match[] = {
>         { .compatible = "nvidia,tegra194-ccplex", },
>         { /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
>
> static struct platform_driver tegra194_ccplex_driver = {
>         .driver = {
>                 .name = "tegra194-cpufreq",
>                 .of_match_table = tegra194_cpufreq_of_match,
>         },
>         .probe = tegra194_cpufreq_probe,
>         .remove = tegra194_cpufreq_remove,
> };
> module_platform_driver(tegra194_ccplex_driver);
> --- >8 ---
>
> I don't think that's exactly what Rafael (Cc'ed) had in mind, since the
> above thread seems to have mostly talked about binding a driver to each
> individual CPU.
>
> But this seems a lot better than having to instantiate a device from
> scratch just so that a driver can bind to it and it allows additional
> properties to be associated with the CCPLEX device.

What additional properties? A continual stream of properties added 1
by 1 would negatively affect my opinion of this.

> Rob, any thoughts on this from a device tree point of view? The /cpus
> bindings don't mention the compatible property, but there doesn't seem
> to be anything in the bindings that would prohibit its use.

What happens when you have more than one cpu related driver in
addition to cpufreq? You may still have to end up creating child
platform devices and then gained very little.

You could solve this without DT changes. You can bind on node names.
The driver probe can then check the parent compatible and return if
not matching. I'm not sure if you could get module auto loading to
work in that case. It would have to be based on the root compatible
(rather than the driver match table) and be able to load multiple
matching modules.

Rob
