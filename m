Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82603220C22
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 13:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgGOLue (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 07:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgGOLue (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 07:50:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6260C061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 04:50:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so5300826wme.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/T16uCv1ZWPqSW676gNIrYzGrdvCyTZGrAfC73gI1R8=;
        b=LgZ4K6EitdkgNJmIZnB6nrrkUMdllUVyNI6qfVCTSpEPlnB3ZUp9Es7UAQyhkk2ESX
         l+H779z95rR+9duhx4AG62Afia97T0hXyQ7Yv77OxoAX91FCWUAGTeA80uF2xLY9c9mA
         E2gWMQuy3uee9dr3EVtZYxqfw18y/qW4jyrI0EpsycGJpLjqdGVPIv9MCp1m+PYBEgL4
         5KPMUq/2Nn3HBz6WeL2Zp7Con55/FYRTZQo1su6tmF9R3pWakLiFpyx5vfgvRc40p55D
         01HI+OiRmOJi1hhsdeKRK7c6h30p9nu+D0KPRsoOX4dNKS7iKNT1tuChf5ixMNGUwkgE
         c1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/T16uCv1ZWPqSW676gNIrYzGrdvCyTZGrAfC73gI1R8=;
        b=IjyWocGP/3765LNZru8iVLWiIud+ycyrRP+1zjAKW+RR3JeVcDZoa3aJTdf1rYpDmA
         Cz59//IlRXVwDA5a+SmiGay97AVXPHGLc5795++OWJcaY1yuESj+tytfU5iUBF3O3SXQ
         6dEDkdEOT4mjzGjarHmyjYWemRv/rP3TgyuAOHlHYbn86H0/7f5RDWZobClree+pM5VG
         P5+kHAwMxmEely8K6Y8dmIt7fniDyspaAuluWlk7gm3orAg65vA9ruVMd4OxJ82RO27k
         MJtjKXav/34cPf4TGiy9nPJxXfFHUMqfQyUdA/OZwq61eTiWHzoxZIDIYrolq0ZLq7ez
         2F4w==
X-Gm-Message-State: AOAM5301ckCsI+Eo1z9OIpgt+aRdf41PUReXgYEHjhwidbhWNB7Dq4pi
        Pwn+aDGap2DSGMydetdgx/4ZLg==
X-Google-Smtp-Source: ABdhPJzhl1aZdPeNw+p/Oo2fOmsYKXVrisAAtybPKQQFyVqm7NZLat5RzBihKMlAoPur6B+enJR0gg==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr8624550wmo.72.1594813832408;
        Wed, 15 Jul 2020 04:50:32 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id d28sm3710893wrc.50.2020.07.15.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 04:50:31 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:50:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Message-ID: <20200715115029.GC3165313@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell>
 <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
 <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
 <20200715113433.GB3165313@dell>
 <CAJZ5v0gFwYj7KKKj806s5SdWO1Wu5exiwObKKAdQWQEKg+2CJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gFwYj7KKKj806s5SdWO1Wu5exiwObKKAdQWQEKg+2CJA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:

> On Wed, Jul 15, 2020 at 1:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> >
> > > On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 15-07-20, 08:54, Viresh Kumar wrote:
> > > > > On 14-07-20, 22:03, Lee Jones wrote:
> > > > > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > > > >
> > > > > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > > > > that they're missing, so ...
> > > > > > >
> > > > > > > Aren't they needed for automatic module loading in certain configurations?
> > > > > >
> > > > > > Any idea how that works, or where the code is for that?
> > > > >
> > > > > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > > > > product-id that the kernel keeps after boot (and so there is no static
> > > > > reference of it for the compiler), later when a device is hotplugged
> > > > > into the kernel it refers to the map to find the related driver for it
> > > > > and loads it if it isn't already loaded.
> > > > >
> > > > > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > > > > Documentation/driver-api/usb/hotplug.rst
> > > >
> > > > And you just need to add __maybe_unused to them to suppress the
> > > > warning.
> > >
> > > Wouldn't that cause the compiler to optimize them away if it doesn't
> > > see any users?
> >
> > It looks like they're only unused when !MODULE,
> 
> OK
> 
> > in which case optimising them away would be the correct thing to do, no?

It would be good if someone with a little more knowledge could provide
a second opinion though.  I would think (hope) that the compiler would
be smart enough to see when its actually in use.  After all, it is the
compiler that places the information into the device table.

If that is not the case, then the MODULE_DEVICE_TABLE() magic is
broken and will need fixing.  Removing boiler-plate is good, but not
at the expense of obfuscation.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
