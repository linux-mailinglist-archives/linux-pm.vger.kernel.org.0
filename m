Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015DE220BEA
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 13:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGOL1m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 07:27:42 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:46588 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGOL1l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 07:27:41 -0400
Received: by mail-oo1-f66.google.com with SMTP id s190so381945ooa.13;
        Wed, 15 Jul 2020 04:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7njhZcRiM2sRqY3EYrQ0MT8Q3CbhSIjshaIrri9+9lE=;
        b=JBYGGJO5MD1PAdWcW41TuXOBPeTSnUO1y8I8Dn6LZW6iWdK+qyFTeXOx16WoE0HT6M
         k+JgBLtgrmsWBDds15KPvrMOvUpLuV6G8A/a8rx9g3CvoBugNgyTq83Dtlht/I8Mp4ue
         vlPSR1ZfKQt1u1LWN1yNlG9AfDu0WS1rsHRQss0/GbWFQjvyKCzAjjUxSIrJV5jhoH+9
         V+blE/ldrcZ3J0UqEIXE6A0ngITQmeGX9oqdnf8Pv1/BSadAu157xNJI8KijGN1eg9My
         lkwOHA9yn5LqLeLafHwPHR0QvnDfRK7jNnuxh5ut/nbXO7e2IEaWWuKGn6DtvQ7N+2YE
         OW7Q==
X-Gm-Message-State: AOAM533Vy1LrT8KJn2b66typAzRzlZK75WJj2+0TfjyZINLxk/0WiaH9
        eFOPUZmqiiUU9SM99QPckrh0fyrPPFMk+ARFsH/mcA==
X-Google-Smtp-Source: ABdhPJyUby3Zaje0s1iYVi9/BxNQt7X4gzAFmBQUR8xvHkMD72fFwwDx8Tc+cOIeGaZ6a4czXOsOaNeBeIEPnbaHvAI=
X-Received: by 2002:a4a:2459:: with SMTP id v25mr8922945oov.75.1594812460660;
 Wed, 15 Jul 2020 04:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org> <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell> <20200715032442.gh2cliiddhv35fdj@vireshk-i7> <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
In-Reply-To: <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 13:27:28 +0200
Message-ID: <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 15-07-20, 08:54, Viresh Kumar wrote:
> > On 14-07-20, 22:03, Lee Jones wrote:
> > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > >
> > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > that they're missing, so ...
> > > >
> > > > Aren't they needed for automatic module loading in certain configurations?
> > >
> > > Any idea how that works, or where the code is for that?
> >
> > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > product-id that the kernel keeps after boot (and so there is no static
> > reference of it for the compiler), later when a device is hotplugged
> > into the kernel it refers to the map to find the related driver for it
> > and loads it if it isn't already loaded.
> >
> > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > Documentation/driver-api/usb/hotplug.rst
>
> And you just need to add __maybe_unused to them to suppress the
> warning.

Wouldn't that cause the compiler to optimize them away if it doesn't
see any users?
