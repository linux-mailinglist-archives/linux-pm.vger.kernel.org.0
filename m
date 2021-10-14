Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7780B42D7CB
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 13:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhJNLKo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 07:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhJNLKn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 07:10:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AD4C061760
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 04:08:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i24so24666904lfj.13
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2530KBw5sIa2liX0bHYNkuPyPL4C8JnDHSe5IbAiNA=;
        b=JwlNlmC84haSnTpwQ4RIB0on3sSS4sEJxPcGpt+W9YaCwF5Qy390fnT4vlujDXHgdY
         rEBclA/tnvug/HMoy0mPnRyeYqfbpOkldGE33gpJg029ojuTOC2WO/NcZI9AyGVJoMVq
         wjHjsr3q0DhWH+DlQXIcdIfYrD9FmCtj3zMBPyoyNuXDYbC00xFxN3Usye0Iv48VP4uq
         EqP5iza3B1WDzn4ws9WlTpAJZdnmEExbwedoEXgVfz3iNVxJSjU1fwBxfm7Wjt08uZcY
         gt3BEPpsFAtWSJL5GE0/wmyix2338kCvCaEqUMxtIW6zi+zq9xAO7rN5JsLS6KyDfTkB
         yUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2530KBw5sIa2liX0bHYNkuPyPL4C8JnDHSe5IbAiNA=;
        b=SYFMRHnlzAQXfN1VgWNbT/vUnbob18ZUJL/s1ArNjXVETRbbeLTTgtsKgt+gIpQu+P
         FjDeUWyJVl/Q+dJGQeRM1FvS25MVwr3Yv1Fbk6NI3N1ZnnRLvQ8aI95lYfr8duG6LeUB
         81Ea5OaWP/pzeyu54qAXKislQAH+QVtsU0Smi2xE4MWOZWjhQiOdfx3MG4BPKSc7NFUX
         gnujKCNxUB9MvIwvwQhFek44bPFaRSGXaR6pSsOosTs28TcxMAJL100rNgpA/kiSMXOI
         vSbBS5JiEpxhm9/db8dhttHSGvZ+O71OsF0gZgd9vjToKYnAWs5ND0CiZUbdLyhYa17M
         XYtg==
X-Gm-Message-State: AOAM533q5ap0/1Db+ylbBE30JXHgrLgRAFeU+j3SZ/JV/MWh8PP2N3bM
        uZeq+wG+aBTxeL1lmv6vavMtAwZUe+7KCAQbAgQqoQ==
X-Google-Smtp-Source: ABdhPJzRfdpqfgO3v5yyrdCguPoaanOykFM7wBbzG4cJ6tEEecAxIjy13q5+O7TypTn6AMNZ6c07GDGuNN6Idyb4e9E=
X-Received: by 2002:a19:5f4b:: with SMTP id a11mr4541619lfj.373.1634209717119;
 Thu, 14 Oct 2021 04:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211011165707.138157-1-marcan@marcan.st> <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7> <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7> <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <20211012092603.lkmhhjoo5v67wh44@vireshk-i7> <049FC437-EC38-4FE5-891E-5E25960892CF@marcan.st>
 <20211012093252.hb6rlcpxv5bmk7n3@vireshk-i7> <0db8e994-ac2c-8fad-55d0-1b5a9e2e21f2@marcan.st>
 <20211014065636.lkv77aqbugp3qhif@vireshk-i7> <039b77f3-d10e-bd7a-a594-b951a98bdd45@marcan.st>
 <653603bc-56bb-7eaf-e6e8-3cc7f5c5a666@marcan.st>
In-Reply-To: <653603bc-56bb-7eaf-e6e8-3cc7f5c5a666@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Oct 2021 13:08:00 +0200
Message-ID: <CAPDyKFrxea9MT4nFRjaHu-QRg2MyaRVOZO-G0i8kv+KQOrYRbA@mail.gmail.com>
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

On Thu, 14 Oct 2021 at 09:23, Hector Martin <marcan@marcan.st> wrote:
>
> On 14/10/2021 16.03, Hector Martin wrote:
> > On 14/10/2021 15.56, Viresh Kumar wrote:
> >>> +   /*
> >>> +    * Attach the CPU device to its genpd domain (if any), to allow OPP
> >>> +    * dependencies to be satisfied.
> >>> +    */
> >>> +   ret = genpd_dev_pm_attach(cpu_dev);
> >>> +   if (ret <= 0) {
> >>> +           dev_err(cpu_dev, "Failed to attach CPU device to genpd\n");
> >>> +           goto out;
> >>> +   }
> >>> +
> >>
> >> Other platform do this from some other place I think.
> >>
> >> Ulf, where should this code be moved ? cpu-clk driver ?
> >>
> >
> > I see one driver that does this is drivers/clk/qcom/apcs-sdx55.c (via
> > dev_pm_domain_attach). Though it only does it for CPU#0; we need to do
> > it for all CPUs.
>
> Looking into this further, I'm not sure I like the idea of doing this in
> the clocks driver. There might be locking issues since it gets
> instantiated twice and yet doesn't really itself know what subset of
> CPUs it applies to.

I agree. I suggest you look into using a genpd provider and hook up
all CPU's devices to it. I think that is what Viresh also suggested
earlier - and this makes most sense to me.

As a reference you may have a look at some Qcom platforms that already use this:

arch/arm64/boot/dts/qcom/qcs404.dtsi

drivers/cpufreq/qcom-cpufreq-nvmem.c:
To hook up CPU devices to their PM domains (genpds) - it calls
dev_pm_opp_attach_genpd(), which is a kind of wrapper for
dev_pm_domain_attach_by_name().

drivers/soc/qcom/cpr.c
Registers the genpd provider that is capable of dealing with
performance states/OPPs for CPUs.

>
> There's another driver that does this:
> drivers/cpuidle/cpuidle-psci-domain.c. That one specifically looks for a
> power domain called "psci". Perhaps it would make sense to make this
> generic in cpufreq-dt as per my prior patch, but explicitly request a
> "cpufreq" domain? That way only devicetrees that opt in to having this
> handled by cpufreq by naming it that way would get this behavior.

That sounds like an idea that is worth exploring. In this way, the
only thing that needs to be implemented for new cases would be the
genpd provider driver.

BTW, as you will figure out by looking at the above references, for
the qcom case we are using "cpr" as the domain name for cpufreq. Of
course, that doesn't mean we can use "cpufreq" (or whatever name that
makes sense) going forward for new cases.

>
> --
> Hector Martin (marcan@marcan.st)
> Public Key: https://mrcn.st/pub

Kind regards
Uffe
