Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2BD1A472C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDJOKy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 10:10:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37949 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJOKy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 10:10:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id w2so1483518oic.5
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2020 07:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iP+Lavwe7WF7LI1g42La3PRMBnLp+i0NcqVyNjj4Wk=;
        b=CIDF2UjsJILplAwk5guvOMu0jxEUX1bKipWgm7biwLywuLil4XaW3gS0KlAPQ+VrY/
         D8eTETIq0IO1GEPn/ULjW8yjH06zPnon2l4Ett7BnAJC3YJrZwDg+1BSvGX3M8NhdmCT
         G4FnN3UAQ39YrTi+LjVsnnAqyhuzVMCTvHTWw1MpVcmgGJBMha+W+jzSPRpIM7JJjd8C
         o6oHQL5dzFXfm2iGqc1yBFY0PWvBZmw7GXkRGDcPQTjBMmNaaqxUxPj7sTVejDTuO9MR
         2UG+7pIMeG+JIg1n2jYDWWAhNim8V7m8+qnnvobsE0cPYDKBTlfQOoTz57Gbh7Vjvht5
         FqQQ==
X-Gm-Message-State: AGi0PuZ5P/cNhRxz/r4O8Fl+8PQqkl+cUlAn+6i5y6Alb4gJM7gBgD6F
        RQhtwX6pNV9qsi7peyEtORKYmu128IBHaO2jhfk=
X-Google-Smtp-Source: APiQypJYPm61SbhSPLguVYmIIiR9Q4tvlglNspGCMybxAQmZFET4555XEQUV/+jISXarL7iLJXBJVs94DEfcEAddWY4=
X-Received: by 2002:aca:2209:: with SMTP id b9mr3569662oic.103.1586527854208;
 Fri, 10 Apr 2020 07:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200408041917.2329-1-rui.zhang@intel.com> <20200408041917.2329-5-rui.zhang@intel.com>
 <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org> <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
In-Reply-To: <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Apr 2020 16:10:42 +0200
Message-ID: <CAJZ5v0hocQ8Y58hzf0qdW0F_E=c7TPBwL2SV3veAYL0x25d4Zg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 10, 2020 at 10:02 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Thu, 2020-04-09 at 15:34 +0200, Daniel Lezcano wrote:
> > Hi Rui,
> >
> >
> > On 08/04/2020 06:19, Zhang Rui wrote:
> > > ACPI processor cooling device supports 1 cooling state before
> > > cpufreq
> > > driver probed, and 4 cooling states after cpufreq driver probed.
> >
> > What is this one state ?
>
> One state means its original state and we can not set it to others.
>
> ACPI processor cooling states are combined of p-state cooling states
> and a couple of optional t-state cooling states.
>
> Say, if we have a processor device supports 7 throttling states, it
> actually supports 8 cooling states with cpufreq driver unprobed, and 11
> cooling states with cpufreq driver probed.
>
> >
> > > Thus update the statistics table when the cpufeq driver is
> > > probed/unprobed.
> >
> > To be honest, the series seems to skirt a problem in the acpi
> > processor.
> >
> > If there is a new policy, then there is a new cooling device. Why not
> > unregister the old one and register the new one ?
> >
> Good point.
> IMO, the real problem is that do we support dynamic max_cooling_state
> or not in the thermal framework.
> Previously, I thought we don't have a hard rule of static
> max_cooling_state because we always invoke .get_max_state() callback
> when we need it. But after a second thought, actually we do have this
> limitation. For example, when binding cooling devices to thermal zones,
> the upper limit is set based on the return value of .get_max_state() at
> the binding time, and we never update the upper limit later.
> So this ACPI processor issue is not just about statistics table update
> issue, we actually lose some of its cooling states.
>
> Thus, a new max_state means that all the previous setting of the
> cooling_device, i.e. all the thermal instances of the cooling device,
> needs to get updated.
>
> And to fix this, it's better to
> a. unregister and re-register the cooling device as you suggested.
> or
> b. introduce an API that updates the cooling device entirely instead of
> statistics table only.
>
> For either of the above solutions, we'd better to cleanup the code to
> invoke .get_max_state() during registration/max_state_reset phase,
> once, and then always use cached value later.
> And plus, if we want to follow solution a), it's better to remove
> .get_max_state() callback and use an integer instead so that every
> driver knows this limitation.
> I'd vote for solution a) if there is no soc thermal driver that may
> return dynamic max_states.

I believe I mentioned one more option, which would be to introduce an
optional callback into struct thermal_cooling_device_ops to return the
maximum possible return value of .get_max_state(), say
.get_max_state_limit().  That would be used for the allocation of the
stats table and the drivers where the .get_max_state() return value
could not change might set the new callback to NULL.

Then, upon a change of the .get_max_state() return value, the driver
providing it would be responsible for rearranging the stats to reflect
the new set of available states.

Cheers!
