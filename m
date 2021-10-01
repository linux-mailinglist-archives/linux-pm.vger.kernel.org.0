Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E238E41F293
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354613AbhJAQ74 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 12:59:56 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46968 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353953AbhJAQ7z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 12:59:55 -0400
Received: by mail-ot1-f48.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so12255055ota.13;
        Fri, 01 Oct 2021 09:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Q7Yakx1bnlDnZP0EqNwqBXdC+CI5UVFLyCydfGIqOI=;
        b=Ua14CiV5oUNIJwxbpVC6tNh8YXwLbimtRwveGhhSMBABcbr1umxxPk6mAZj9tBX4sr
         YHQ3Yi5c7zFsHWoUs/VTSXPJ+HxLl8RnbezXnASbVT/y1LJGBJFXlJCrY3pFOlJINFPd
         BMHKcYndSMXwNpfbSdxrVUvmkTxdbwtb4BOiqQtrmjwQVzyxyVOt3KsjxqnweTGXGsBp
         vvARuTm2eAqMYTJ1yTmmG4lKuDOIpyiKYsL5FM128o50iuCMqqk41aGP8CXVfvTBUmMt
         YSiklgDrSTB7b1r2dXOm4O9R2qZR1fdnT9yDZ3vYZfJGzt1AY6vWbDaghoPQ6SXF8wE0
         a9TA==
X-Gm-Message-State: AOAM530pqDfOXHL6UDxIXhnRUhLdcK+DErBrzq2Ru/RfgYm72dZS8yKW
        KmKEwlHrTZL192piZ7Zg7l3sfoCtZyMMjZJIYC4=
X-Google-Smtp-Source: ABdhPJwxFgmO5d8BqoelU8CpCnJ63tTHgrHp5DeTnh2s+RBrqa1H3RRYBdY5TRP0Do6riBN1yw1Q0YUwl+Wcg2TVOQA=
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr11082122ots.319.1633107490735;
 Fri, 01 Oct 2021 09:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632994837.git.mchehab+huawei@kernel.org> <6417aeca2f0c450545469b82f6b9bb615d1fa8ea.1632994837.git.mchehab+huawei@kernel.org>
In-Reply-To: <6417aeca2f0c450545469b82f6b9bb615d1fa8ea.1632994837.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Oct 2021 18:57:59 +0200
Message-ID: <CAJZ5v0iZ=r_jj8unogt28JcmaUYuWFSYZAGXNDyJg3tEQ3x0XA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] ABI: sysfs-class-thermal: create a file with
 thermal_zone ABI
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 30, 2021 at 11:45 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The thermal ABI is described, together with the internal
> development details at:
>
>         Documentation/driver-api/thermal/sysfs-api.rst
>
> Move the sysfs API description to Documentation/ABI,
> ensuring that scripts/get_abi.pl will properly parse it.

So the subject of the patch should be something like

thermal: Move ABI documentation do Documentation/ABI

Also please mention the MAINTAINERS update in the changelog.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>
> See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1632994837.git.mchehab+huawei@kernel.org/
>
>  Documentation/ABI/testing/sysfs-class-thermal | 259 ++++++++++++++++++
>  .../driver-api/thermal/sysfs-api.rst          | 225 +--------------
>  MAINTAINERS                                   |   2 +
>  3 files changed, 264 insertions(+), 222 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-thermal
>
> diff --git a/Documentation/ABI/testing/sysfs-class-thermal b/Documentation/ABI/testing/sysfs-class-thermal
> new file mode 100644
> index 000000000000..2c52bb1f864c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-thermal
> @@ -0,0 +1,259 @@
> +What:          /sys/class/thermal/thermal_zoneX/type
> +Description:
> +               Strings which represent the thermal zone type.
> +               This is given by thermal zone driver as part of registration.
> +               E.g: "acpitz" indicates it's an ACPI thermal device.
> +               In order to keep it consistent with hwmon sys attribute; this
> +               shouldbe a short, lowercase string, not containing spaces nor
> +               dashes.
> +
> +               RO, Required
> +
> +What:          /sys/class/thermal/thermal_zoneX/temp
> +Description:
> +               Current temperature as reported by thermal zone (sensor).
> +
> +               Unit: millidegree Celsius
> +
> +               RO, Required
> +
> +What:          /sys/class/thermal/thermal_zoneX/mode
> +Description:
> +               One of the predefined values in [enabled, disabled].
> +               This file gives information about the algorithm that is
> +               currently managing the thermal zone. It can be either default
> +               kernel based algorithm or user space application.
> +
> +               enabled
> +                               enable Kernel Thermal management.
> +               disabled
> +                               Preventing kernel thermal zone driver actions upon
> +                               trip points so that user application can take full
> +                               charge of the thermal management.
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/policy
> +Description:
> +               One of the various thermal governors used for a particular zone.
> +
> +               RW, Required
> +
> +What:          /sys/class/thermal/thermal_zoneX/available_policies
> +Description:
> +               Available thermal governors which can be used for a
> +               particular zone.
> +
> +               RO, Required
> +
> +What:          /sys/class/thermal/thermal_zoneX/trip_point_Y_temp
> +Description:
> +               The temperature above which trip point will be fired.
> +
> +               Unit: millidegree Celsius
> +
> +               RO, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/trip_point_Y_type
> +Description:
> +               Strings which indicate the type of the trip point.
> +
> +               E.g. it can be one of critical, hot, passive, `active[0-*]`
> +               for ACPI thermal zone.
> +
> +               RO, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/trip_point_Y_hyst
> +Description:
> +               The hysteresis value for a trip point, represented as an
> +               integer.
> +
> +               Unit: Celsius
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/cdevY
> +Description:
> +       Sysfs link to the thermal cooling device node where the sys I/F
> +       for cooling device throttling control represents.
> +
> +       RO, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/cdevY_trip_point
> +Description:
> +               The trip point in this thermal zone which `cdev[0-*]` is
> +               associated with; -1 means the cooling device is not
> +               associated with any trip point.
> +
> +               RO, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/cdevY_weight
> +Description:
> +               The influence of `cdev[0-*]` in this thermal zone. This value
> +               is relative to the rest of cooling devices in the thermal
> +               zone. For example, if a cooling device has a weight double
> +               than that of other, it's twice as effective in cooling the
> +               thermal zone.
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/emul_temp
> +Description:
> +               Interface to set the emulated temperature method in thermal zone
> +               (sensor). After setting this temperature, the thermal zone may
> +               pass this temperature to platform emulation function if
> +               registered or cache it locally. This is useful in debugging
> +               different temperature threshold and its associated cooling
> +               action. This is write only node and writing 0 on this node
> +               should disable emulation.
> +
> +               Unit: millidegree Celsius
> +
> +               WO, Optional
> +
> +               WARNING:
> +                   Be careful while enabling this option on production systems,
> +                   because userland can easily disable the thermal policy by simply
> +                   flooding this sysfs node with low temperature values.
> +
> +
> +What:          /sys/class/thermal/thermal_zoneX/k_d
> +Description:
> +               The derivative term of the power allocator governor's PID
> +               controller. For more information see
> +               Documentation/driver-api/thermal/power_allocator.rst
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/k_i
> +Description:
> +               The integral term of the power allocator governor's PID
> +               controller. This term allows the PID controller to compensate
> +               for long term drift. For more information see
> +               Documentation/driver-api/thermal/power_allocator.rst
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/k_po
> +Description:
> +               The proportional term of the power allocator governor's PID
> +               controller during temperature overshoot. Temperature overshoot
> +               is when the current temperature is above the "desired
> +               temperature" trip point. For more information see
> +               Documentation/driver-api/thermal/power_allocator.rst
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/k_pu
> +Description:
> +               The proportional term of the power allocator governor's PID
> +               controller during temperature undershoot. Temperature undershoot
> +               is when the current temperature is below the "desired
> +               temperature" trip point. For more information see
> +               Documentation/driver-api/thermal/power_allocator.rst
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/integral_cutoff
> +Description:
> +               Temperature offset from the desired temperature trip point
> +               above which the integral term of the power allocator
> +               governor's PID controller starts accumulating errors. For
> +               example, if integral_cutoff is 0, then the integral term only
> +               accumulates error when temperature is above the desired
> +               temperature trip point. For more information see
> +               Documentation/driver-api/thermal/power_allocator.rst
> +
> +               Unit: millidegree Celsius
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/slope
> +Description:
> +               The slope constant used in a linear extrapolation model
> +               to determine a hotspot temperature based off the sensor's
> +               raw readings. It is up to the device driver to determine
> +               the usage of these values.
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/offset
> +Description:
> +               The offset constant used in a linear extrapolation model
> +               to determine a hotspot temperature based off the sensor's
> +               raw readings. It is up to the device driver to determine
> +               the usage of these values.
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/thermal_zoneX/sustainable_power
> +Description:
> +               An estimate of the sustained power that can be dissipated by
> +               the thermal zone. Used by the power allocator governor. For
> +               more information see
> +               Documentation/driver-api/thermal/power_allocator.rst
> +
> +               Unit: milliwatts
> +
> +               RW, Optional
> +
> +What:          /sys/class/thermal/cooling_deviceX/type
> +Description:
> +               String which represents the type of device, e.g:
> +
> +               - for generic ACPI: should be "Fan", "Processor" or "LCD"
> +               - for memory controller device on intel_menlow platform:
> +               should be "Memory controller".
> +
> +               RO, Required
> +
> +What:          /sys/class/thermal/cooling_deviceX/max_state
> +Description:
> +               The maximum permissible cooling state of this cooling device.
> +
> +               RO, Required
> +
> +What:          /sys/class/thermal/cooling_deviceX/cur_state
> +Description:
> +               The current cooling state of this cooling device.
> +               The value can any integer numbers between 0 and max_state:
> +
> +               - cur_state == 0 means no cooling
> +               - cur_state == max_state means the maximum cooling.
> +
> +               RW, Required
> +
> +What:          /sys/class/thermal/cooling_deviceX/stats/reset
> +Description:
> +               Writing any value resets the cooling device's statistics.
> +
> +               WO, Required
> +
> +What:          /sys/class/thermal/cooling_deviceX/stats/time_in_state_ms:
> +Description:
> +               The amount of time spent by the cooling device in various
> +               cooling states. The output will have "<state> <time>" pair
> +               in each line, which will mean this cooling device spent <time>
> +               msec of time at <state>.
> +
> +               Output will have one line for each of the supported states.
> +
> +               RO, Required
> +
> +What:          /sys/class/thermal/cooling_deviceX/stats/total_trans
> +Description:
> +               A single positive value showing the total number of times
> +               the state of a cooling device is changed.
> +
> +               RO, Required
> +
> +What:          /sys/class/thermal/cooling_deviceX/stats/trans_table
> +Description:
> +               This gives fine grained information about all the cooling state
> +               transitions. The cat output here is a two dimensional matrix,
> +               where an entry <i,j> (row i, column j) represents the number
> +               of transitions from State_i to State_j. If the transition
> +               table is bigger than PAGE_SIZE, reading this will return
> +               an -EFBIG error.
> +
> +               RO, Required
> diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> index c93fa5e961a0..2e0f79a9e2ee 100644
> --- a/Documentation/driver-api/thermal/sysfs-api.rst
> +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> @@ -428,6 +428,9 @@ of thermal zone device. E.g. the generic thermal driver registers one hwmon
>  class device and build the associated hwmon sysfs I/F for all the registered
>  ACPI thermal zones.
>
> +Please read Documentation/ABI/testing/sysfs-class-thermal for thermal
> +zone and cooling device attribute details.
> +
>  ::
>
>    /sys/class/hwmon/hwmon[0-*]:
> @@ -437,228 +440,6 @@ ACPI thermal zones.
>
>  Please read Documentation/hwmon/sysfs-interface.rst for additional information.
>
> -Thermal zone attributes
> ------------------------
> -
> -type
> -       Strings which represent the thermal zone type.
> -       This is given by thermal zone driver as part of registration.
> -       E.g: "acpitz" indicates it's an ACPI thermal device.
> -       In order to keep it consistent with hwmon sys attribute; this should
> -       be a short, lowercase string, not containing spaces nor dashes.
> -       RO, Required
> -
> -temp
> -       Current temperature as reported by thermal zone (sensor).
> -       Unit: millidegree Celsius
> -       RO, Required
> -
> -mode
> -       One of the predefined values in [enabled, disabled].
> -       This file gives information about the algorithm that is currently
> -       managing the thermal zone. It can be either default kernel based
> -       algorithm or user space application.
> -
> -       enabled
> -                         enable Kernel Thermal management.
> -       disabled
> -                         Preventing kernel thermal zone driver actions upon
> -                         trip points so that user application can take full
> -                         charge of the thermal management.
> -
> -       RW, Optional
> -
> -policy
> -       One of the various thermal governors used for a particular zone.
> -
> -       RW, Required
> -
> -available_policies
> -       Available thermal governors which can be used for a particular zone.
> -
> -       RO, Required
> -
> -`trip_point_[0-*]_temp`
> -       The temperature above which trip point will be fired.
> -
> -       Unit: millidegree Celsius
> -
> -       RO, Optional
> -
> -`trip_point_[0-*]_type`
> -       Strings which indicate the type of the trip point.
> -
> -       E.g. it can be one of critical, hot, passive, `active[0-*]` for ACPI
> -       thermal zone.
> -
> -       RO, Optional
> -
> -`trip_point_[0-*]_hyst`
> -       The hysteresis value for a trip point, represented as an integer
> -       Unit: Celsius
> -       RW, Optional
> -
> -`cdev[0-*]`
> -       Sysfs link to the thermal cooling device node where the sys I/F
> -       for cooling device throttling control represents.
> -
> -       RO, Optional
> -
> -`cdev[0-*]_trip_point`
> -       The trip point in this thermal zone which `cdev[0-*]` is associated
> -       with; -1 means the cooling device is not associated with any trip
> -       point.
> -
> -       RO, Optional
> -
> -`cdev[0-*]_weight`
> -       The influence of `cdev[0-*]` in this thermal zone. This value
> -       is relative to the rest of cooling devices in the thermal
> -       zone. For example, if a cooling device has a weight double
> -       than that of other, it's twice as effective in cooling the
> -       thermal zone.
> -
> -       RW, Optional
> -
> -emul_temp
> -       Interface to set the emulated temperature method in thermal zone
> -       (sensor). After setting this temperature, the thermal zone may pass
> -       this temperature to platform emulation function if registered or
> -       cache it locally. This is useful in debugging different temperature
> -       threshold and its associated cooling action. This is write only node
> -       and writing 0 on this node should disable emulation.
> -       Unit: millidegree Celsius
> -
> -       WO, Optional
> -
> -         WARNING:
> -           Be careful while enabling this option on production systems,
> -           because userland can easily disable the thermal policy by simply
> -           flooding this sysfs node with low temperature values.
> -
> -sustainable_power
> -       An estimate of the sustained power that can be dissipated by
> -       the thermal zone. Used by the power allocator governor. For
> -       more information see Documentation/driver-api/thermal/power_allocator.rst
> -
> -       Unit: milliwatts
> -
> -       RW, Optional
> -
> -k_po
> -       The proportional term of the power allocator governor's PID
> -       controller during temperature overshoot. Temperature overshoot
> -       is when the current temperature is above the "desired
> -       temperature" trip point. For more information see
> -       Documentation/driver-api/thermal/power_allocator.rst
> -
> -       RW, Optional
> -
> -k_pu
> -       The proportional term of the power allocator governor's PID
> -       controller during temperature undershoot. Temperature undershoot
> -       is when the current temperature is below the "desired
> -       temperature" trip point. For more information see
> -       Documentation/driver-api/thermal/power_allocator.rst
> -
> -       RW, Optional
> -
> -k_i
> -       The integral term of the power allocator governor's PID
> -       controller. This term allows the PID controller to compensate
> -       for long term drift. For more information see
> -       Documentation/driver-api/thermal/power_allocator.rst
> -
> -       RW, Optional
> -
> -k_d
> -       The derivative term of the power allocator governor's PID
> -       controller. For more information see
> -       Documentation/driver-api/thermal/power_allocator.rst
> -
> -       RW, Optional
> -
> -integral_cutoff
> -       Temperature offset from the desired temperature trip point
> -       above which the integral term of the power allocator
> -       governor's PID controller starts accumulating errors. For
> -       example, if integral_cutoff is 0, then the integral term only
> -       accumulates error when temperature is above the desired
> -       temperature trip point. For more information see
> -       Documentation/driver-api/thermal/power_allocator.rst
> -
> -       Unit: millidegree Celsius
> -
> -       RW, Optional
> -
> -slope
> -       The slope constant used in a linear extrapolation model
> -       to determine a hotspot temperature based off the sensor's
> -       raw readings. It is up to the device driver to determine
> -       the usage of these values.
> -
> -       RW, Optional
> -
> -offset
> -       The offset constant used in a linear extrapolation model
> -       to determine a hotspot temperature based off the sensor's
> -       raw readings. It is up to the device driver to determine
> -       the usage of these values.
> -
> -       RW, Optional
> -
> -Cooling device attributes
> --------------------------
> -
> -type
> -       String which represents the type of device, e.g:
> -
> -       - for generic ACPI: should be "Fan", "Processor" or "LCD"
> -       - for memory controller device on intel_menlow platform:
> -         should be "Memory controller".
> -
> -       RO, Required
> -
> -max_state
> -       The maximum permissible cooling state of this cooling device.
> -
> -       RO, Required
> -
> -cur_state
> -       The current cooling state of this cooling device.
> -       The value can any integer numbers between 0 and max_state:
> -
> -       - cur_state == 0 means no cooling
> -       - cur_state == max_state means the maximum cooling.
> -
> -       RW, Required
> -
> -stats/reset
> -       Writing any value resets the cooling device's statistics.
> -       WO, Required
> -
> -stats/time_in_state_ms:
> -       The amount of time spent by the cooling device in various cooling
> -       states. The output will have "<state> <time>" pair in each line, which
> -       will mean this cooling device spent <time> msec of time at <state>.
> -       Output will have one line for each of the supported states.
> -       RO, Required
> -
> -
> -stats/total_trans:
> -       A single positive value showing the total number of times the state of a
> -       cooling device is changed.
> -
> -       RO, Required
> -
> -stats/trans_table:
> -       This gives fine grained information about all the cooling state
> -       transitions. The cat output here is a two dimensional matrix, where an
> -       entry <i,j> (row i, column j) represents the number of transitions from
> -       State_i to State_j. If the transition table is bigger than PAGE_SIZE,
> -       reading this will return an -EFBIG error.
> -       RO, Required
> -
>  3. A simple implementation
>  ==========================
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b765cbc90d1..179eadaebe76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18653,7 +18653,9 @@ L:      linux-pm@vger.kernel.org
>  S:     Supported
>  Q:     https://patchwork.kernel.org/project/linux-pm/list/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> +F:     Documentation/ABI/testing/sysfs-class-thermal
>  F:     Documentation/devicetree/bindings/thermal/
> +F:     Documentation/driver-api/thermal/
>  F:     drivers/thermal/
>  F:     include/linux/cpu_cooling.h
>  F:     include/linux/thermal.h
> --
> 2.31.1
>
