Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E72424582
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 20:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhJFSCs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 14:02:48 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:39746 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhJFSCs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 14:02:48 -0400
Received: by mail-ot1-f52.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so4153002ota.6;
        Wed, 06 Oct 2021 11:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EE0FJa1Rw2KQ5S6rS9XSqP8497Oo681sIsTxRPsfdFg=;
        b=pgFG0LDbE8xQ2WAqvbzVJhE3wGPCa0RZuXFYzzvQVNXUlcYWi284kfgEM1Qt/BbrTJ
         RNKSbLMGRdmsYByBLh35MzA2fJJxvfsY7czgotIt+dcb/CBKBzgQFKgzs+I761wMmzpd
         ndbFtRp83WXUJQE/auSaBG3xCUblb+nmzyJ6i7wMw2ub/Vfp9l+bHNXI69jDFdJvCEUF
         AjyuhZW9g71VboPZYvP+bQ/2sZflB6+/r8fPtWIjhmTaT9t/oWomLlPYoyIjL9Jq3Vat
         R8PfGO6AGISA7W1sKNQu6eA033bV2zWN9vbg/6rIbgflSaG+EJEdNoAnXQ+YZjtz9EOu
         /DHw==
X-Gm-Message-State: AOAM5319UD0gd7q331u9Hu1YdcGDtk01d9HdOyI1kkEqHEXfykeN21s7
        0ApcX6/5cyMNmURvHQn+QHPZ1icbYlL3oM6qoDo=
X-Google-Smtp-Source: ABdhPJwUirZ5+QXJUYOAB8e53AcHe23MOWIxLc0pxWDcCR8prMx0xSN9oYz8EzFDSM1sw6M7UOsELTJ5iWiOnfN7LdQ=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr60013otr.301.1633543255488;
 Wed, 06 Oct 2021 11:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210917072732.611140-1-abailon@baylibre.com> <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com> <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
 <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com> <794e62ea-d867-3827-de5f-24ddc86c3524@linaro.org>
 <4446577e-c7fa-daeb-e0fe-8a530633ef5d@baylibre.com> <d24ce6ec-eced-4e16-eb59-7c87f596ccca@linaro.org>
 <CAJZ5v0iJCS+nRcnHXiprtJsBf6Q4=k4TFcUV2ma_GiK=MttFug@mail.gmail.com> <03aeb132-bc0c-93f7-c7db-8575a665d2a7@linaro.org>
In-Reply-To: <03aeb132-bc0c-93f7-c7db-8575a665d2a7@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Oct 2021 20:00:44 +0200
Message-ID: <CAJZ5v0gVgw4qT9jmfr8U+t0j3JdmAAuVFf785NHozQxuKr56MA@mail.gmail.com>
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

On Wed, Oct 6, 2021 at 6:06 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 05/10/2021 18:45, Rafael J. Wysocki wrote:
> > On Mon, Oct 4, 2021 at 3:42 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 04/10/2021 12:24, Alexandre Bailon wrote:
> >>>
> >>> On 9/22/21 10:10 AM, Daniel Lezcano wrote:
> >>>> On 20/09/2021 15:12, Alexandre Bailon wrote:
> >>>>> On 9/17/21 4:03 PM, Daniel Lezcano wrote:
> >>>>>> On 17/09/2021 15:33, Alexandre Bailon wrote:
> >>>>>>> Hi Daniel,
> >>>>>>>
> >>>>>>> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
> >>>>>>>> On 17/09/2021 09:27, Alexandre Bailon wrote:
> >>>>>>>>> This series add a virtual thermal sensor.
> >>>>>>>>> It could be used to get a temperature using some thermal sensors.
> >>>>>>>>> Currently, the supported operations are max, min and avg.
> >>>>>>>>> The virtual sensor could be easily extended to support others
> >>>>>>>>> operations.
> >>>>>>>>>
> >>>>>>>>> Note:
> >>>>>>>>> Currently, thermal drivers must explicitly register their sensors to
> >>>>>>>>> make them
> >>>>>>>>> available to the virtual sensor.
> >>>>>>>>> This doesn't seem a good solution to me and I think it would be
> >>>>>>>>> preferable to
> >>>>>>>>> update the framework to register the list of each available sensors.
> >>>>>>>> Why must the drivers do that ?
> >>>>>>> Because there are no central place where thermal sensor are
> >>>>>>> registered.
> >>>>>>> The only other way I found was to update thermal_of.c,
> >>>>>>> to register the thermal sensors and make them available later to the
> >>>>>>> virtual thermal sensor.
> >>>>>>>
> >>>>>>> To work, the virtual thermal need to get the sensor_data the ops from
> >>>>>>> the thermal sensor.
> >>>>>>> And as far I know, this is only registered in thermal_of.c, in the
> >>>>>>> thermal zone data
> >>>>>>> but I can't access it directly from the virtual thermal sensor.
> >>>>>>>
> >>>>>>> How would you do it ?
> >>>>>> Via the phandles when registering the virtual sensor ?
> >>>>> As far I know, we can't get the ops or the sensor_data from the phandle
> >>>>> of a thermal sensor.
> >>>>> The closest solution I found so far would be to aggregate the thermal
> >>>>> zones instead of thermal sensors.
> >>>>> thermal_zone_device has the data needed and a thermal zone could be find
> >>>>> easily using its name.
> >>>> Yeah, the concept of the thermal zone and the sensor are very close.
> >>>>
> >>>> There is the function in thermal_core.h:
> >>>>
> >>>>   -> for_each_thermal_zone()
> >>>>
> >>>> You should be able for each 'slave' sensor, do a lookup to find the
> >>>> corresponding thermal_zone_device_ops.
> >>>>
> >>>>> But, using a thermal_zone_device, I don't see how to handle module
> >>>>> unloading.
> >>>> I think try_module_get() / module_put() are adequate for this situation
> >>>> as it is done on an external module and we can not rely on the exported
> >>>> symbols.
> >>> I don't see how it would be possible to use these functions.
> >>> The thermal zone doesn't have the data required to use it.
> >>
> >> Actually I was able to crash the kernel by doing:
> >>
> >> console 1:
> >>
> >> while $(true); do insmod <module> && rmmod <module>; done
> >>
> >> console 2:
> >>
> >> while $(true); cat /sys/class/thermal/thermal_zone0/temp; done
> >>
> >> So there is something wrong already in the thermal framework.
> >
> > Hmmm.
> >
> >> IMO, the first thing would be to fix this critical issue by getting the
> >> sensor module refcount when the thermal zone is enabled and dropping it
> >> when it is disabled.
> >>
> >> With that fixed, perhaps it will possible to get the device associated
> >> with the sensor and then try_module_get(dev->driver->owner)
> >>
> >>> Maybe a more easier way is to use the thermal_zone_device mutex.
> >>> If I get a lock before to use the thermal_zone_device ops, I have the
> >>> guaranty that module won't be unloaded.
> >
> > That would be my approach too.
>
> The mutex is private to the thermal core. The virtual sensor should not
> touch it :/
>
> Perhaps, it can work with a private spin_lock with a try_spinlock() ?

IIUC this is a case when module A refers to some memory in module B
and if the latter goes away, an access to that memory from the former
is a use-after-free, so it is not sufficient to use a local spinlock.

This can be avoided by having a lock and a flag such that the flag is
set under the lock by module B when making the memory in question
available and cleared under the lock when freeing that memory.  Then,
module A needs to check the flag under the lock on every access to
that memory.  Also, the lock and the flag must be accessible all the
time to both modules (ie. must not go away along with any of them if
they don't depend on each other).

> >>> When a "thermal of sensor" is unloaded, it calls
> >>> thermal_zone_of_sensor_unregister which takes a lock before
> >>> update ops.
> >>
> >> I'm not sure to understand. The goal is to have the refcount on the
> >> modules to be incremented when the virtual sensor is using them.
> >
> > IMO the goal is to prevent the code from crashing when modules get
> > unloaded.  I'm not really sure if refcounts alone are sufficient for
> > that.
>
> The problem is in the loop:
>
> +static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
> +{
> +       struct virtual_thermal_sensor *sensor = data;
> +       int max_temp = INT_MIN;
> +       int temp;
> +       int i;
> +
> +       for (i = 0; i < sensor->count; i++) {
> +               struct thermal_sensor_data *hw_sensor;
> +
> +               hw_sensor = &sensor->sensors[i];
> +               if (!hw_sensor->ops)
> +                       return -ENODEV;
> +
> +               hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
> +               max_temp = sensor->aggr_temp(max_temp, temp);
> +       }
> +
> +       *temperature = max_temp;
> +
> +       return 0;
> +}
>
> If one of the sensor is unloaded when get_temp is called,
> hw_sensor->ops->get_temp will crash.

Right.

Dereferencing hw_sensor itself is not safe in this loop if the module
holding the memory pointed to by it may go away.

However, presumably, the hw_sensor object needs to be registered with
the core in order to be used here and unregistered when it goes away,
so it looks like this loop could use a wrapper like
thermal_get_sensor_temp(hw_sensor, &temp) which would return a
negative error code if the sensor in question went away.

Of course, that would require the core to check the list of available
sensors every time, but that may be implemented efficiently with the
help of an xarray, for example.

> So the proposal is virtual_sensor_add_sensor() does try_get_module()
> and virtual_sensor_remove_sensor() does put_module().
>
> The ref on the 'slave' modules will be release only if the virtual
> sensor is unregistered.
>
> So until, the virtual sensor is unregistered, the 'slaves' modules can
> not be unloaded.
>
> That is what we find with eg. the wifi modules.

Yes, but that's a bit cumbersome from the sysadmin perspective IMO,
especially when one wants to unload one of the modules and doesn't
know exactly what other modules hold references to it.

IIUC ref_module() might be nicer, but it is still more convenient if
the modules can just go away independently.
