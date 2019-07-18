Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2D6CCFB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfGRKsv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 06:48:51 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43446 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfGRKsv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 06:48:51 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so18773039vsn.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NppfMkA9YSp2bcd8lowDgozs69+YWUjU8R8XC2mh2Ng=;
        b=EMo3sNQfR8AxwQbc/nsBmFB2MttmgcYpKR6+imTy+1EG/hxf2H1FX4coJIjBZs9MU4
         T5gfuRfY0RJvbYIUjVknrZr6Eg6Zw3N5HG7aed/9UdUeTX7a1AlUZLU0w2OsoUoEoMMt
         rNcp0hzFlDtjweQ0S7IYVyCrtnbDY7fv+TpkkRIQfdT9q0pWwfYCh9v0s/AYlWjWKojb
         Q+FcvGHicvaXo3IiVCcV9apv0MI03oWm1qSfSilrp9K00e6Am331V9AMy4viOYZqv9JI
         kKEBYgZiDcA6zHuKe3PNvCPdq/SzEDbDaWOug2ZuxcVj6N1EZ6a6yqkw7R+JUtFUrKoi
         rCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NppfMkA9YSp2bcd8lowDgozs69+YWUjU8R8XC2mh2Ng=;
        b=fKcPdl7BBp6ltP5kIjt5pINvU+JYMBNTvSQN1h7QKtt5V48sFCErs5UAmO7QeVVAJX
         BbiMq5N5rUcHrZmSklKFf7vOwhR8mt1WPnWwsBWWqbemam20YWpKUJTWfbS8aVyhN7uN
         8+j7rBWag/hTGr7VOOCHRAmw+3LDcqWOUC16OXb3sDEzvJFw2nmkbzsVb86ChFCMkIOb
         l1JBf8KgQuuifLb8skdS1U2fPSww8WzqemkL4FktBwFKMYf63+dstK6UwYLCo7cW5zRq
         vOgIbYbG9cRPVJ6e/dpFGnP84RQf4BT48tNwLSBl6am3ubeHSF6Rgoxf/7wKHyZd6+3+
         Plrw==
X-Gm-Message-State: APjAAAWQ4b/sXyGHn+y7ghDjAP1dG14hJvo4NyCO4pUZnylcqfL7MseI
        CisR3Xd3sbYTt9AmG5zOYSduuXeLTWBKa5cORkVMBA==
X-Google-Smtp-Source: APXvYqztqpfIkQ19AlRQPrqfsqTvP4cIR4ExKB8fsNIFkHPM8GZNpANZzIhR9gX186T9JnVglUf6rgxAB2sJLtT7RWg=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr28577969vsp.191.1563446930654;
 Thu, 18 Jul 2019 03:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-19-ulf.hansson@linaro.org>
 <20190716144744.GB7250@e107155-lin>
In-Reply-To: <20190716144744.GB7250@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Jul 2019 12:48:14 +0200
Message-ID: <CAPDyKFpc26yL6rOnfwawL=eL649NsgTMrF1WrMHZv7AVd=3PCA@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: dts: hikey: Convert to the hierarchical CPU
 topology layout
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 16 Jul 2019 at 16:47, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:23:00PM +0200, Ulf Hansson wrote:
> > To enable the OS to manage last-man standing activities for a CPU, while an
> > idle state for a group of CPUs is selected, let's convert the Hikey
> > platform into using the hierarchical CPU topology layout.
> >
> > Cc: Wei Xu <xuwei5@hisilicon.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes:
> >       - None.
> >
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 87 ++++++++++++++++++++---
> >  1 file changed, 76 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > index 108e2a4227f6..36ff460f428f 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> >       cpus {
>
> [...]
>
> > @@ -70,9 +128,8 @@
> >                       };
> >
> >                       CLUSTER_SLEEP: cluster-sleep {
> > -                             compatible = "arm,idle-state";
> > -                             local-timer-stop;
> > -                             arm,psci-suspend-param = <0x1010000>;
> > +                             compatible = "domain-idle-state";
> > +                             arm,psci-suspend-param = <0x1000000>;
> >                               entry-latency-us = <1000>;
> >                               exit-latency-us = <700>;
> >                               min-residency-us = <2700>;
>
> Again this must be original format and as per PSCI spec, your patch
> changes this cluster sleep state into cluster retention state which I
> think is not what you intended.

If the hierarchical topology is used, the parameter for cluster states
are ORed with the deepest idle state for the CPU.

CPU_SLEEP: 0x0010000
CLUSTER_SLEEP: 0x1000000

After the ORed operation
CLUSTER_SLEEP: 0x1010000

So, this indeed works as expected.

However, are you saying that ORing the state parameters like above has
other problems? I am reading your other replies...

Kind regards
Uffe
