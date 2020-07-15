Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF2220CA9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 14:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgGOMJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 08:09:20 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:46470 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgGOMJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 08:09:20 -0400
Received: by mail-oo1-f67.google.com with SMTP id s190so403230ooa.13;
        Wed, 15 Jul 2020 05:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLPIoPCWX/2y/tjhSwNs4ynh2yh9mmc4HFXmFaRS20o=;
        b=jDZVhF9MQ82b6zgvydVnT2Q6Q4VYVrwcMWgai09sxS44j1rb+egc6R8UibZhNchQ2N
         Hr598KW1Ti1sgMfVh0R1wdq2fItiWy1WO2qAlv8obQeKAh8E9WlYVqAsVoRP98v49sS3
         iFFmtH4H1pcZfyzxVmPnFhLr6W9v+dEfdJsNP9JaJ9Ge0VenYGGNfvFbXkUAb7CQB17V
         t1+csOrgj8hxaXqIGBoxB4rtBZzCXBQaTwREbvRGtKKuID1zET77BquanQV5Bxf44Qha
         V8au6/5a4ghH9Oc9EBmkJwBjJuA0RTnhqam3XQKg5lCSyuXc0q8xI7TETRtJCch3+IBY
         9BaA==
X-Gm-Message-State: AOAM531na6ZPgce0RdbCncMnVFlr3AFRPqtD2gNkHaYrmiuhpO/wZuRH
        rSEpB+mA6EF7r9ehqGe2b6bDZBOGLbtI8VtO+iA=
X-Google-Smtp-Source: ABdhPJzhuH+9Zrju5mwFlmKrjVgDgi8NrlfM121ZkbvRz/q0nnaYaOaetm9dOKKvsw8jaadpotSDzsXSuJpbTVm7Q8Q=
X-Received: by 2002:a4a:3e48:: with SMTP id t69mr9173593oot.38.1594814959632;
 Wed, 15 Jul 2020 05:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org> <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell> <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7> <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
 <20200715113433.GB3165313@dell> <CAJZ5v0gFwYj7KKKj806s5SdWO1Wu5exiwObKKAdQWQEKg+2CJA@mail.gmail.com>
 <20200715115029.GC3165313@dell>
In-Reply-To: <20200715115029.GC3165313@dell>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 14:09:08 +0200
Message-ID: <CAJZ5v0hJf2BwDvmtD6UEyyxm-CGcA=SLmAt+F8Sr0ceDZji0jw@mail.gmail.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 1:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
>
> > On Wed, Jul 15, 2020 at 1:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> > >
> > > > On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > On 15-07-20, 08:54, Viresh Kumar wrote:
> > > > > > On 14-07-20, 22:03, Lee Jones wrote:
> > > > > > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > > > > >
> > > > > > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > > > > > that they're missing, so ...
> > > > > > > >
> > > > > > > > Aren't they needed for automatic module loading in certain configurations?
> > > > > > >
> > > > > > > Any idea how that works, or where the code is for that?
> > > > > >
> > > > > > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > > > > > product-id that the kernel keeps after boot (and so there is no static
> > > > > > reference of it for the compiler), later when a device is hotplugged
> > > > > > into the kernel it refers to the map to find the related driver for it
> > > > > > and loads it if it isn't already loaded.
> > > > > >
> > > > > > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > > > > > Documentation/driver-api/usb/hotplug.rst
> > > > >
> > > > > And you just need to add __maybe_unused to them to suppress the
> > > > > warning.
> > > >
> > > > Wouldn't that cause the compiler to optimize them away if it doesn't
> > > > see any users?
> > >
> > > It looks like they're only unused when !MODULE,
> >
> > OK
> >
> > > in which case optimising them away would be the correct thing to do, no?
>
> It would be good if someone with a little more knowledge could provide
> a second opinion though.  I would think (hope) that the compiler would
> be smart enough to see when its actually in use.  After all, it is the
> compiler that places the information into the device table.
>
> If that is not the case, then the MODULE_DEVICE_TABLE() magic is
> broken and will need fixing.

I'm not sure why that would be the case?

> Removing boiler-plate is good, but not at the expense of obfuscation.

I'm not following you here to be honest.

BTW, I'm wondering if removing the "static" modifier from the
definitions of the structures in question makes the warnings you want
to get rid of go away.
