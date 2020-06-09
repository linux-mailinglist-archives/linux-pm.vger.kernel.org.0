Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A11F3254
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 04:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgFIChs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 22:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgFIChp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 22:37:45 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8CCC03E969
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 19:37:43 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 69so15421363otv.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2020 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIREOCncp+kCLejh9A1JytrjVRseDJ9dDmzpsV7xNws=;
        b=I9F+MzX3keiz7H+vq67DtBb3j76mL76MQZ+r9HgbdfDur2wVNf7HxaK0JjLFewpHIl
         JEhC5yhS5eeZK9YbS3L3jGKgKUclvO6bqli/E4ozAVwZVdJgis0MsPi2Hgadsfexdkyc
         GQTSjl2rMRA+2wxu7vGskuJxaXnulBsJwF/CHu4/mdeUno+caXYvieZFZA1/QyVtcSTt
         ba+bxnnpUhC9mBSo7ZJyb9pprv1xeGOatgMlVbhKrztR3z14T4p1ND3KzH1BDo0e0g2K
         M1AheK59avMkAVhIcd1aAvO6N3Spb+jYpTbN1OYYTIMGLhhtvRmDgj209cPg9F7OO+9B
         IZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIREOCncp+kCLejh9A1JytrjVRseDJ9dDmzpsV7xNws=;
        b=fXcSG3rSu8cafJEN2jv5z6rPLq6fwfZIEO2tt7U5xC5rIYkZryqQv18MG3kYw7IVMy
         hxA7/MPkAAHp2aplOy56+tQjbijmN6VrkcQIMpYzgMU566husXCmEb50YsAd6CbV+mNT
         4nDFBlTANT2XzL17Eel9u24B1SRG8G79M2ITxA2RSmWVbP/tTsW/zzX55cLb9TX7wDFn
         c2qbAiVD+8VI7hc778CUDcRQk2F0DLeI2QVPDmx3VR2u/Osh9CPSVUD0/Z0fiOKymyHL
         gz099oH+9et1QgaEo3Tn/uNoE/QQJ0l3MjJJJWqzmkuN3XIpkX6vQFlo4KBrCRfhez0F
         l8mw==
X-Gm-Message-State: AOAM533ktMLrwtFSG4CTo2X8ZTmJTLFyPGfXscFHSYvRZ9LJS+rQqTqL
        Ia2NhozS3FKjAaXBuBOwx4yEOO8eJQD0T3NwlrGLEQ==
X-Google-Smtp-Source: ABdhPJyNcC5SuTdnFrtUT/J1vHIVd1tebb9cmCY1PZhbEnXealjVBrgi7u4Qxgwn4MSraDU9LrRx5Xm6eUPmfkqlABk=
X-Received: by 2002:a9d:6048:: with SMTP id v8mr14796461otj.231.1591670262910;
 Mon, 08 Jun 2020 19:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6@eucas1p2.samsung.com>
 <20200605063724.9030-1-m.szyprowski@samsung.com> <20200605102018.GA5413@sirena.org.uk>
 <2f0e021d-387a-4693-882d-aba66e20dd2b@samsung.com> <20200605155903.GI5413@sirena.org.uk>
In-Reply-To: <20200605155903.GI5413@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 8 Jun 2020 19:37:07 -0700
Message-ID: <CAGETcx8asyFRz5LmU4LSMJuPWvcWdvi1GHAhQ85AWdd6jcmdiA@mail.gmail.com>
Subject: Re: [PATCH] regulator: do not balance 'boot-on' coupled regulators
 without constraints
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 5, 2020 at 8:59 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jun 05, 2020 at 03:37:32PM +0200, Marek Szyprowski wrote:
> > On 05.06.2020 12:20, Mark Brown wrote:
>
> > > No, this is not what boot-on means at all.  It is there for cases where
> > > we can't read the enable status from the hardware.  Trying to infer
> > > *anything* about the runtime behaviour from it being present or absent
> > > is very badly broken.
>
> > Okay, what about the 'always-on' property? I don't think that we need
> > another property for annotating this behavior, as in my opinion this is
>
> No, that's just as disconnected from the need - we may as well do it
> based on the regulator name being an odd number of characters.
>
> > just an implementation issue on the Linux kernel and regulator
> > framework. Alternatively I can drop the property check, but then it
> > won't be possible to have a regulator without a consumer, which follows
> > the other one (although we still don't have a real use case for it).
>
> > If you don't like this idea at all, I will try to move this logic to the
> > custom coupler again, although it would mean some code copying.
>
> I think that's better TBH.
>
> > > Saravana (CCed) was working on some patches which tried to deal with
> > > some stuff around this for enables using the sync_state() callback.
> > > Unfortunately there's quite a few problems with the current approach
> > > (the biggest one from my point of view being that it's implemented so
> > > that it requires every single consumer of every device on the PMIC to
> > > come up but there's others at more of an implementation level).
>
> > I'm not sure if we really need such complex solution for this...
>
> So I think that the specific approach there is overly heavyweight and
> restrictive but I do see the general use case here for something per
> regulator providing we can avoid breaking anything that does actually
> need to change the regulator state (eg, raising the voltage for
> cpufreq).

The changes I propose won't prevent anything from asking for more
power/energy (will always allow turning on stuff, increasing voltage,
increasing current, etc). It'll only prevent reducing power lower than
what was provided when the bootloader left stuff on. This shouldn't
break most boards -- because any other consumer could be setting
similar limits and things don't break then. But even if that's a
concern, we can still default to a timeout behavior and then give
folks the choice of disabling the timeout if they know all their
devices will probe.

Btw, the patch series I sent fixes a lot of subtle use cases even with
the timeout enabled. For example, in one hardware platform, a LDO is
shared between camera, display, UFS and USB. The camera driver would
probe first, enable the regulator, poll its HW and then disable the
regulator. This causes the regulator to be disabled before display,
UFS, and USB could probe and this caused hardware faults for those.

> Previously to the past week I'd only really heard about it
> causing problems in the context of displays left on by the bootloader
> glitching during boot but this is a concrete

Ah, finally! I have examples of pretty much the same issue in some
downstream kernels -- the CPU and memory shares rails with other
hardware blocks and things fail if this isn't taken care of. Glad that
someone else found an example for me in the upstream kernel.

> use case and we already
> have the infrastructure to track dependencies at the device model level
> if we use it well.

I'll send out a v3 series in a couple of days to address Mark's
earlier comments and also add the voltage support to address Marek's
case. We can take it from there.

-Saravana
