Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16D42EFB8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 13:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhJOL3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhJOL3S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 07:29:18 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2CC061570
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 04:27:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o4so12575981oia.10
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKgeFjMzQGbOlv7b4giRKfd3xluRkC6Y3aCMzdKTmcI=;
        b=Wm4Wd6dvvDFnTkE00hxoA1bUki0lOHa+WoFWUIXZWiyl6BYiN/VJMfw+VnMnOCFaCL
         jQ/04aPgGreSwDm51jxnPJc9pkqywXE26egdgnLAAok719vghfDASfmYTOjn+J9+fwG+
         q/10lDtvDgAT1UYJHz5rI7tM4bgXHiMlTFU0bfwd97rrUQBuH+ZcmSEP+7HO6CUo/zZr
         CYvsbAtjc89xss/CKzqeHdvLDimYn1hwLBeYUoQqfujZ+roY4R1sCnIjQGg7W3W/Tmsf
         Xo/iQrJTbgRFodmMVP5Xapec+3WlJ78UAXbtc9fa6D6bWDahM/6PJbdWmF+2ol5JsZXE
         T1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKgeFjMzQGbOlv7b4giRKfd3xluRkC6Y3aCMzdKTmcI=;
        b=X7Mw75XCPUa0Wvp9biy3DVh+tGbvgTOmXvg0l/ApzMwDn3ogElaGaFfUs+ILA2clPN
         SkEOuYdXzytg2OZdocKwQKlDT4Hepbmn1Cj3GtpNuuIpJ3X5gXSJ+lrIuNsdB5lz1ioq
         jNE3f6/CsYU/GIBJD6pcoP9Ys4vdXh+CtEOJHh5F81z0+bsSQkH+TJ4r7QYpbr+gWWz7
         7CyVAM/4AIaKhDQY6E3xU5KYDrM+tuJke1qHvgPS562gy5rzNBFvuO0lNixIU1z449vs
         +ApyE1CM/oZg+LcpzMnk6M1pJlcspm/vgVJJIerFABkJWXdjSNQM60HweIhxP5iAGMH3
         9o/Q==
X-Gm-Message-State: AOAM530949EmRh8vkNLoUMhs7rW+pCRuU0CzfYIsiCWRMzE8yaJ79f8K
        fZGX7SYPUTR3u3EaaOjRuTpuze/S7PH31rE3Jun6aA==
X-Google-Smtp-Source: ABdhPJyDcpqGbwskrQSivF3Hrk9czLe3jAaUJI090sO0PPQ/+jfBKyc4oV3D64eX1CbrHycowOE0cMxWzV6ZAtM7o8E=
X-Received: by 2002:a05:6808:2218:: with SMTP id bd24mr513771oib.94.1634297231969;
 Fri, 15 Oct 2021 04:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211011165707.138157-1-marcan@marcan.st> <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7> <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7> <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <CAPDyKFoVjVYkc4+v-=eD+JbC10GazGt8A1LtD1so3PKMmVcyMg@mail.gmail.com>
 <bd07f4b3-6ebf-e074-c1cd-0ef501e8324f@marcan.st> <CAPDyKFrFX93XV8a7e7oo1N5weWp2auq=_94fTnzr2EkO3c37Ug@mail.gmail.com>
 <ca820b86-fc12-63b9-ec6b-5823ddd73aba@marcan.st>
In-Reply-To: <ca820b86-fc12-63b9-ec6b-5823ddd73aba@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Oct 2021 13:26:35 +0200
Message-ID: <CAPDyKFpCw1M8bK5T6a+=x-kHaCco88wiRnvUm5Dy90XU360=4A@mail.gmail.com>
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

On Thu, 14 Oct 2021 at 19:02, Hector Martin <marcan@marcan.st> wrote:
>
> On 14/10/2021 21.55, Ulf Hansson wrote:
> > On Thu, 14 Oct 2021 at 13:43, Hector Martin <marcan@marcan.st> wrote:
> >> I was poking around and noticed the OPP core can already integrate with
> >> interconnect requirements, so perhaps the memory controller can be an
> >> interconnect provider, and the CPU nodes can directly reference it as a
> >> consumer? This seems like a more accurate model of what the hardware
> >> does, and I think I saw some devices doing this already.
> >
> > Yeah, that could work too. And, yes, I agree, it may be a better
> > description of the HW.
> >
> >>
> >> (only problem is I have no idea of the actual bandwidth numbers involved
> >> here... I'll have to run some benchmarks to make sure this isn't just
> >> completely dummy data)
> >>
>
> So... I tried getting bandwidth numbers and failed. It seems these
> registers don't actually affect peak performance in any measurable way.
> I'm also getting almost the same GeekBench scores on macOS with and
> without this mechanism enabled, although there is one subtest that seems
> to show a measurable difference.
>
> My current guess is this is something more subtle (latencies? idle
> timers and such?) than a performance state. If that is the case, do you
> have any ideas as to the best way to model it in Linux? Should we even
> bother if it mostly has a minimal performance gain for typical workloads?

For latency constraints, we have dev_pm_qos. This will make the genpd
governor, to prevent deeper idle states for the device and its
corresponding PM domain (genpd). But that doesn't sound like a good
fit here.

If you are right, it rather sounds like there is some kind of
quiescence mode of the memory controller that can be prevented. But I
have no clue, of course. :-)

>
> I'll try to do some latency tests, see if I can make sense of what it's
> actually doing.
>

Kind regards
Uffe
