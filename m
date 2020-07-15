Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68B220C11
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgGOLoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 07:44:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36055 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgGOLoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 07:44:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id 72so1215033otc.3;
        Wed, 15 Jul 2020 04:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaBDIw1z/eEqdf0QQ4ZUt0oW4z4lCjYpMBZZDcbuR0c=;
        b=RrtCkGNRfH3fAsP1WY6uPp7osIGCxNk8Tm6aqLZWdMTXfwTpMFhnluX/Nq/gJghiSK
         5Lblc8Zn0QOqpxvlA/Qq3ZORXjUicOyxJSgF9ffio5/frR8QNEOfNc0pBv3Z8Ffldj+w
         oAHFROAcRvC25+JAu4OJkdHwAlZYvSLSxQFpL4uwincr/N/5ZjV27iuuZWIJ6XiF/Mup
         4hkfP8R3xVppNM94d9TGftX0tDOx7G2pOdZH2sV6laQL3RrvBP4kpE/18y5bGCPKxsk3
         kRtDVTl/AVKVRIrsxv354n3fvL0F3g8v7VlqxyX2gGcLEs1S4iRNPrvl3rcyBcWjpRAh
         9xUQ==
X-Gm-Message-State: AOAM533VDzvw7e1pe2BF8txx1kJAxV6MubGCHYyMLnkE0yVJnDzgF3xm
        Q+ouXuogLQDbxt/+kxoITWapWe5AnnDuAvj6S1w=
X-Google-Smtp-Source: ABdhPJxEcoP6okwQqNr/RlRkCB0Aw3hNucn3W2acw4J2SJUqB280r/rPKtFMA2T/K62rr7Bm4/+fKhqo/8OcKnWTGb0=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr8192356ota.167.1594813453344;
 Wed, 15 Jul 2020 04:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org> <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell> <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7> <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
 <20200715113433.GB3165313@dell>
In-Reply-To: <20200715113433.GB3165313@dell>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 13:44:01 +0200
Message-ID: <CAJZ5v0gFwYj7KKKj806s5SdWO1Wu5exiwObKKAdQWQEKg+2CJA@mail.gmail.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 1:34 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
>
> > On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 15-07-20, 08:54, Viresh Kumar wrote:
> > > > On 14-07-20, 22:03, Lee Jones wrote:
> > > > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > > >
> > > > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > >
> > > > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > > > that they're missing, so ...
> > > > > >
> > > > > > Aren't they needed for automatic module loading in certain configurations?
> > > > >
> > > > > Any idea how that works, or where the code is for that?
> > > >
> > > > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > > > product-id that the kernel keeps after boot (and so there is no static
> > > > reference of it for the compiler), later when a device is hotplugged
> > > > into the kernel it refers to the map to find the related driver for it
> > > > and loads it if it isn't already loaded.
> > > >
> > > > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > > > Documentation/driver-api/usb/hotplug.rst
> > >
> > > And you just need to add __maybe_unused to them to suppress the
> > > warning.
> >
> > Wouldn't that cause the compiler to optimize them away if it doesn't
> > see any users?
>
> It looks like they're only unused when !MODULE,

OK

> in which case optimising them away would be the correct thing to do, no?
