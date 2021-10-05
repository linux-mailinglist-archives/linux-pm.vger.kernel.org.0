Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A178422E3B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhJEQrM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:47:12 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34541 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhJEQrM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 12:47:12 -0400
Received: by mail-ot1-f48.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so26672792otb.1;
        Tue, 05 Oct 2021 09:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZ+O93dc00Oy4/Bl6+HJwNRn0vAP4IQeYkixoCSt31k=;
        b=rZQ2caFrlxpWtC3v8Z/SaqOGbnXLhAFfcy7NqB8pMfs3+SHi9Hnx4yp75ABpb/oXcj
         q4Q972GfyVRO7aDnqvizkoFIT9w5bVqATLBtkkf4O9mJ6ttJIn+aR7z/KmD8n9xPjAQe
         wH+Cp8gm5mnr02hXIkg0odfuvBGhMc+26FqPNufRxubjh40O3C6gmckl+JJruJ5MlLnJ
         i8xgwd0CIsz5Y9mTPBkIGOQjOWksPM7hV23nNQXJYlzbZLH54+QjEkrODbJ+pL4Vyf5/
         rYq1VfQugpSoxt4KT+GF5SKErsM+R2fSfjr2zwNgsozLJy4n1MDphZ3Uaj9kBnPptiS1
         Fjyg==
X-Gm-Message-State: AOAM5309y9uC+zwhwcW5d/QXYjLFWsC7i3gb6dGo4Hl8eCttA8jYKU8y
        rvPeJoV5QAHFWgI3tN40IONJkiwfTNFlHwiyIGY=
X-Google-Smtp-Source: ABdhPJxtceUxFuWUSc1lOO7hj+/IEa10kg7xpCjC1bo+sEzwLOqUnzUqosWspjLtKj8GdCVmeFMoj48Js14ZLZmXLu0=
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr15332609otu.86.1633452321456;
 Tue, 05 Oct 2021 09:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210917072732.611140-1-abailon@baylibre.com> <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com> <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
 <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com> <794e62ea-d867-3827-de5f-24ddc86c3524@linaro.org>
 <4446577e-c7fa-daeb-e0fe-8a530633ef5d@baylibre.com> <d24ce6ec-eced-4e16-eb59-7c87f596ccca@linaro.org>
In-Reply-To: <d24ce6ec-eced-4e16-eb59-7c87f596ccca@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 18:45:10 +0200
Message-ID: <CAJZ5v0iJCS+nRcnHXiprtJsBf6Q4=k4TFcUV2ma_GiK=MttFug@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Kevin Hilman <khilman@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 4, 2021 at 3:42 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 04/10/2021 12:24, Alexandre Bailon wrote:
> >
> > On 9/22/21 10:10 AM, Daniel Lezcano wrote:
> >> On 20/09/2021 15:12, Alexandre Bailon wrote:
> >>> On 9/17/21 4:03 PM, Daniel Lezcano wrote:
> >>>> On 17/09/2021 15:33, Alexandre Bailon wrote:
> >>>>> Hi Daniel,
> >>>>>
> >>>>> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
> >>>>>> On 17/09/2021 09:27, Alexandre Bailon wrote:
> >>>>>>> This series add a virtual thermal sensor.
> >>>>>>> It could be used to get a temperature using some thermal sensors.
> >>>>>>> Currently, the supported operations are max, min and avg.
> >>>>>>> The virtual sensor could be easily extended to support others
> >>>>>>> operations.
> >>>>>>>
> >>>>>>> Note:
> >>>>>>> Currently, thermal drivers must explicitly register their sensors to
> >>>>>>> make them
> >>>>>>> available to the virtual sensor.
> >>>>>>> This doesn't seem a good solution to me and I think it would be
> >>>>>>> preferable to
> >>>>>>> update the framework to register the list of each available sensors.
> >>>>>> Why must the drivers do that ?
> >>>>> Because there are no central place where thermal sensor are
> >>>>> registered.
> >>>>> The only other way I found was to update thermal_of.c,
> >>>>> to register the thermal sensors and make them available later to the
> >>>>> virtual thermal sensor.
> >>>>>
> >>>>> To work, the virtual thermal need to get the sensor_data the ops from
> >>>>> the thermal sensor.
> >>>>> And as far I know, this is only registered in thermal_of.c, in the
> >>>>> thermal zone data
> >>>>> but I can't access it directly from the virtual thermal sensor.
> >>>>>
> >>>>> How would you do it ?
> >>>> Via the phandles when registering the virtual sensor ?
> >>> As far I know, we can't get the ops or the sensor_data from the phandle
> >>> of a thermal sensor.
> >>> The closest solution I found so far would be to aggregate the thermal
> >>> zones instead of thermal sensors.
> >>> thermal_zone_device has the data needed and a thermal zone could be find
> >>> easily using its name.
> >> Yeah, the concept of the thermal zone and the sensor are very close.
> >>
> >> There is the function in thermal_core.h:
> >>
> >>   -> for_each_thermal_zone()
> >>
> >> You should be able for each 'slave' sensor, do a lookup to find the
> >> corresponding thermal_zone_device_ops.
> >>
> >>> But, using a thermal_zone_device, I don't see how to handle module
> >>> unloading.
> >> I think try_module_get() / module_put() are adequate for this situation
> >> as it is done on an external module and we can not rely on the exported
> >> symbols.
> > I don't see how it would be possible to use these functions.
> > The thermal zone doesn't have the data required to use it.
>
> Actually I was able to crash the kernel by doing:
>
> console 1:
>
> while $(true); do insmod <module> && rmmod <module>; done
>
> console 2:
>
> while $(true); cat /sys/class/thermal/thermal_zone0/temp; done
>
> So there is something wrong already in the thermal framework.

Hmmm.

> IMO, the first thing would be to fix this critical issue by getting the
> sensor module refcount when the thermal zone is enabled and dropping it
> when it is disabled.
>
> With that fixed, perhaps it will possible to get the device associated
> with the sensor and then try_module_get(dev->driver->owner)
>
> > Maybe a more easier way is to use the thermal_zone_device mutex.
> > If I get a lock before to use the thermal_zone_device ops, I have the
> > guaranty that module won't be unloaded.

That would be my approach too.

> > When a "thermal of sensor" is unloaded, it calls
> > thermal_zone_of_sensor_unregister which takes a lock before
> > update ops.
>
> I'm not sure to understand. The goal is to have the refcount on the
> modules to be incremented when the virtual sensor is using them.

IMO the goal is to prevent the code from crashing when modules get
unloaded.  I'm not really sure if refcounts alone are sufficient for
that.

> Until the virtual sensor is registered, it will prevent the other
> modules to be unloaded.

Unless they are forced to unload that is, AFAICS.

IMO it would be better to make the code survive unloading of a module.
