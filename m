Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535EA425531
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbhJGOT7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 10:19:59 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35423 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbhJGOT7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 10:19:59 -0400
Received: by mail-oi1-f170.google.com with SMTP id n64so9248103oih.2;
        Thu, 07 Oct 2021 07:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUuKvP7McEiH/2qrThuKxg/iRjLtaPX3FoPmr3dvODk=;
        b=yJXEebyNH8NtTtmWJN6hlUMWDeWD6MroXX+vAaPiZhmr73mA3tUI1UIIfvzBnX16bz
         Jrzu3v2SgNL1TNON1YtncPtak17TWUuQUEwzhxYrPLbrGmf9Nobz2n/TdGiWS4zBx/st
         vJUZwYzB3SMor3DDheeW6Kh8c6yNid11WEZzZQAUFd91MsYM0D2onDRVcpdg5YkS24gg
         JdrlzIi9qnaxw6jtvFXwB8Y5UQr+UBeDwwLsrModGijYVCrjYEPcDciBkHUDjLQ8utzD
         xeKxDo1tnHWhvZyD2kBuL0o+YZk1Dqrpfd8G3u0BIdfR4aN7kcV4P2qdwjLJP7sblUfY
         Sy/Q==
X-Gm-Message-State: AOAM532GyZf+AUC2U855Ruzthcu7c6vvLnMvDkVE1RbuMWzpLJmDYlyk
        pb18iksRLFhl0fjs9Q1mZBQbrqyDKaSXIbtt0Kg=
X-Google-Smtp-Source: ABdhPJzp+hAA4i0v+Q6m3uBwIrRd0bV6DM9jYnr2OTr2nEYW4FWptEGdI2RLCE7LuXBvecrvYF4x+iogguQ1nGg5+w4=
X-Received: by 2002:aca:d1a:: with SMTP id 26mr3246401oin.166.1633616285156;
 Thu, 07 Oct 2021 07:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210917072732.611140-1-abailon@baylibre.com> <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com> <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
 <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com> <794e62ea-d867-3827-de5f-24ddc86c3524@linaro.org>
 <4446577e-c7fa-daeb-e0fe-8a530633ef5d@baylibre.com> <d24ce6ec-eced-4e16-eb59-7c87f596ccca@linaro.org>
 <CAJZ5v0iJCS+nRcnHXiprtJsBf6Q4=k4TFcUV2ma_GiK=MttFug@mail.gmail.com>
 <03aeb132-bc0c-93f7-c7db-8575a665d2a7@linaro.org> <CAJZ5v0gVgw4qT9jmfr8U+t0j3JdmAAuVFf785NHozQxuKr56MA@mail.gmail.com>
 <566c8f70-1445-caef-811d-398729869719@linaro.org>
In-Reply-To: <566c8f70-1445-caef-811d-398729869719@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Oct 2021 16:17:53 +0200
Message-ID: <CAJZ5v0i1U5+gBHtSeamFMDovyTrpTMk+xGTatuQSVjrxrC8Uzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Kevin Hilman <khilman@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 6, 2021 at 9:51 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 06/10/2021 20:00, Rafael J. Wysocki wrote:
> > On Wed, Oct 6, 2021 at 6:06 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 05/10/2021 18:45, Rafael J. Wysocki wrote:
> >>> On Mon, Oct 4, 2021 at 3:42 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 04/10/2021 12:24, Alexandre Bailon wrote:
> >>>>>
> >>>>> On 9/22/21 10:10 AM, Daniel Lezcano wrote:
> >>>>>> On 20/09/2021 15:12, Alexandre Bailon wrote:
> >>>>>>> On 9/17/21 4:03 PM, Daniel Lezcano wrote:
> >>>>>>>> On 17/09/2021 15:33, Alexandre Bailon wrote:
> >>>>>>>>> Hi Daniel,
> >>>>>>>>>
> >>>>>>>>> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
> >>>>>>>>>> On 17/09/2021 09:27, Alexandre Bailon wrote:
> >>>>>>>>>>> This series add a virtual thermal sensor.
> >>>>>>>>>>> It could be used to get a temperature using some thermal sensors.
> >>>>>>>>>>> Currently, the supported operations are max, min and avg.
> >>>>>>>>>>> The virtual sensor could be easily extended to support others
> >>>>>>>>>>> operations.
> >>>>>>>>>>>
> >>>>>>>>>>> Note:
> >>>>>>>>>>> Currently, thermal drivers must explicitly register their sensors to
> >>>>>>>>>>> make them
> >>>>>>>>>>> available to the virtual sensor.
> >>>>>>>>>>> This doesn't seem a good solution to me and I think it would be
> >>>>>>>>>>> preferable to
> >>>>>>>>>>> update the framework to register the list of each available sensors.
> >>>>>>>>>> Why must the drivers do that ?
> >>>>>>>>> Because there are no central place where thermal sensor are
> >>>>>>>>> registered.
> >>>>>>>>> The only other way I found was to update thermal_of.c,
> >>>>>>>>> to register the thermal sensors and make them available later to the
> >>>>>>>>> virtual thermal sensor.
> >>>>>>>>>
> >>>>>>>>> To work, the virtual thermal need to get the sensor_data the ops from
> >>>>>>>>> the thermal sensor.
> >>>>>>>>> And as far I know, this is only registered in thermal_of.c, in the
> >>>>>>>>> thermal zone data
> >>>>>>>>> but I can't access it directly from the virtual thermal sensor.
> >>>>>>>>>
> >>>>>>>>> How would you do it ?
> >>>>>>>> Via the phandles when registering the virtual sensor ?
> >>>>>>> As far I know, we can't get the ops or the sensor_data from the phandle
> >>>>>>> of a thermal sensor.
> >>>>>>> The closest solution I found so far would be to aggregate the thermal
> >>>>>>> zones instead of thermal sensors.
> >>>>>>> thermal_zone_device has the data needed and a thermal zone could be find
> >>>>>>> easily using its name.
> >>>>>> Yeah, the concept of the thermal zone and the sensor are very close.
> >>>>>>
> >>>>>> There is the function in thermal_core.h:
> >>>>>>
> >>>>>>   -> for_each_thermal_zone()
> >>>>>>
> >>>>>> You should be able for each 'slave' sensor, do a lookup to find the
> >>>>>> corresponding thermal_zone_device_ops.
> >>>>>>
> >>>>>>> But, using a thermal_zone_device, I don't see how to handle module
> >>>>>>> unloading.
> >>>>>> I think try_module_get() / module_put() are adequate for this situation
> >>>>>> as it is done on an external module and we can not rely on the exported
> >>>>>> symbols.
> >>>>> I don't see how it would be possible to use these functions.
> >>>>> The thermal zone doesn't have the data required to use it.
> >>>>
> >>>> Actually I was able to crash the kernel by doing:
> >>>>
> >>>> console 1:
> >>>>
> >>>> while $(true); do insmod <module> && rmmod <module>; done
> >>>>
> >>>> console 2:
> >>>>
> >>>> while $(true); cat /sys/class/thermal/thermal_zone0/temp; done
> >>>>
> >>>> So there is something wrong already in the thermal framework.
> >>>
> >>> Hmmm.
> >>>
> >>>> IMO, the first thing would be to fix this critical issue by getting the
> >>>> sensor module refcount when the thermal zone is enabled and dropping it
> >>>> when it is disabled.
> >>>>
> >>>> With that fixed, perhaps it will possible to get the device associated
> >>>> with the sensor and then try_module_get(dev->driver->owner)
> >>>>
> >>>>> Maybe a more easier way is to use the thermal_zone_device mutex.
> >>>>> If I get a lock before to use the thermal_zone_device ops, I have the
> >>>>> guaranty that module won't be unloaded.
> >>>
> >>> That would be my approach too.
> >>
> >> The mutex is private to the thermal core. The virtual sensor should not
> >> touch it :/
> >>
> >> Perhaps, it can work with a private spin_lock with a try_spinlock() ?
> >
> > IIUC this is a case when module A refers to some memory in module B
> > and if the latter goes away, an access to that memory from the former
> > is a use-after-free, so it is not sufficient to use a local spinlock.
>
> > This can be avoided by having a lock and a flag such that the flag is
> > set under the lock by module B when making the memory in question
> > available and cleared under the lock when freeing that memory.  Then,
> > module A needs to check the flag under the lock on every access to
> > that memory.  Also, the lock and the flag must be accessible all the
> > time to both modules (ie. must not go away along with any of them if
> > they don't depend on each other).
>
> Just to clarify, the idea behind the virtual sensor is the same as the
> network bridge: the network interfaces are not aware they are attached
> to a bridge.

But there's no code handling the bridge that needs to access memory
controlled by network interface driver modules.

> The virtual sensor should attach and detach the physical sensors.
>
> The sensors should not un|register themselves from|to the virtual
> sensor, nor having specific code related to the virtual sensor. De
> facto, all the existing sensors will be compatible with the virtual sensor.

If I understand this patch series correctly, somebody is expected to
call thermal_virtual_sensor_register() (or the devm_ variant of it) in
order to add a sensor to the thermal_sensors list (which appears to be
racy given the lack of locking or any kind of synchronization
whatsoever).

This appears to assume that all of the sensors will be added before
running virtual_thermal_sensor_probe() which effectively is the only
reader of the thermal_sensors list and runs as a ->probe() callbacks
of virtual_thermal_sensor (there is a name clash between this and a
struct data type which isn't useful) which gets registered as a
platform driver when the module loads, as per
module_platform_driver().

So whoever called thermal_virtual_sensor_register() to register a
sensor, will be required to call thermal_virtual_sensor_unregister()
or devm_thermal_virtual_sensor_release() will be called for them when
they are going away (again, no locking there).  That should also
reconfigure all of the virtual sensors using the given sensor going
away and which should take care of the problem we are discussing,
shouldn't it?

Let me respond to the patches, though.
