Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E89220CBA
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 14:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgGOMLh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jul 2020 08:11:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42544 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgGOMLg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 08:11:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id g37so1250187otb.9;
        Wed, 15 Jul 2020 05:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3cag8LrwMjM3xe6EZSlrz4EBUBRpTmPKD/ABz0zsn30=;
        b=jEJzl2u/jvooFwgPzbcGNhIyAKUL/N2Uxdfo3SoIEnEI0D1Eml/Lm/8fSkBiGPFWWZ
         YktRJGKZ1Se099A+RQmwzuquJfJWr2Ahnor2Lvqs84gePsruUtA7XfX3V8LoKuodHIzz
         GiEMCzFLwEaI6UDww6jtA5tQlZgmfXMkP4e76HPakFXZUmgyVuDVBycGFRC2TIvzEVXG
         9Or/xTN63OCbReUII5LU6xVPHcodco1bybCAmwquseQ7+oMDPLKr6uBsBggwGxRABZLq
         GPM5zIIgLYrmSO2FBxfaS47h8rU0ZDk93JjXZ5GdAKdDi3rJIEFH8V+C77hbXr8xdR8A
         B7pQ==
X-Gm-Message-State: AOAM530boF05xDlLhMRvjKfQCc2T03vQuJaMi/bt3UgACQ4Up1oG/gPz
        91hyVbbYLEj+D6CdnXP5y79W2CfG3rBgfcm/Crk=
X-Google-Smtp-Source: ABdhPJwHW42/HPcNLnkN0GUVwuSkpH45wKSqeoBtesXsaKKCMSGwCyfwn0t0YZsdDwmvmoGpSB8/H5RWdVb+nY27lUg=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr8619498oth.262.1594815095838;
 Wed, 15 Jul 2020 05:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org> <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell> <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7> <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
 <20200715113433.GB3165313@dell> <CAJZ5v0gFwYj7KKKj806s5SdWO1Wu5exiwObKKAdQWQEKg+2CJA@mail.gmail.com>
 <20200715115029.GC3165313@dell> <20200715120742.GD3165313@dell>
In-Reply-To: <20200715120742.GD3165313@dell>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 14:11:24 +0200
Message-ID: <CAJZ5v0jVvzCuxOa=xDXWw4Js0J5PfKb6aM4W-g=bAPz43JNqQg@mail.gmail.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dominik Brodowski <linux@brodo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 2:07 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 15 Jul 2020, Lee Jones wrote:
>
> > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> >
> > > On Wed, Jul 15, 2020 at 1:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> > > >
> > > > > On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > >
> > > > > > On 15-07-20, 08:54, Viresh Kumar wrote:
> > > > > > > On 14-07-20, 22:03, Lee Jones wrote:
> > > > > > > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > > > > > >
> > > > > > > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > > > > > > that they're missing, so ...
> > > > > > > > >
> > > > > > > > > Aren't they needed for automatic module loading in certain configurations?
> > > > > > > >
> > > > > > > > Any idea how that works, or where the code is for that?
> > > > > > >
> > > > > > > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > > > > > > product-id that the kernel keeps after boot (and so there is no static
> > > > > > > reference of it for the compiler), later when a device is hotplugged
> > > > > > > into the kernel it refers to the map to find the related driver for it
> > > > > > > and loads it if it isn't already loaded.
> > > > > > >
> > > > > > > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > > > > > > Documentation/driver-api/usb/hotplug.rst
> > > > > >
> > > > > > And you just need to add __maybe_unused to them to suppress the
> > > > > > warning.
> > > > >
> > > > > Wouldn't that cause the compiler to optimize them away if it doesn't
> > > > > see any users?
> > > >
> > > > It looks like they're only unused when !MODULE,
> > >
> > > OK
> > >
> > > > in which case optimising them away would be the correct thing to do, no?
> >
> > It would be good if someone with a little more knowledge could provide
> > a second opinion though.  I would think (hope) that the compiler would
> > be smart enough to see when its actually in use.  After all, it is the
> > compiler that places the information into the device table.
> >
> > If that is not the case, then the MODULE_DEVICE_TABLE() magic is
> > broken and will need fixing.  Removing boiler-plate is good, but not
> > at the expense of obfuscation.
>
> Okay, I'm satisfied.  This test build is without __maybe_unused:
>
> # All configs built as modules (MODULE) - the compiler knows to use the tables
>
>  $ ccache make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86 allmodconfig
>  $ ccache make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86  W=1  drivers/cpufreq/
>  [...]
>    CC [M]  drivers/cpufreq/pcc-cpufreq.o
>
> # All configs built-in (!MODULE) - the compiler sees that they are unused
>
>  $ ccache make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86 allyesconfig
>  $ ccache make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86  W=1  drivers/cpufreq/
>    CC      drivers/cpufreq/pcc-cpufreq.o
>   drivers/cpufreq/pcc-cpufreq.c:619:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
>   619 | static const struct acpi_device_id processor_device_ids[] = {
>       |                                    ^~~~~~~~~~~~~~~~~~~~
>

OK

I thought that this would be the case. :-)
