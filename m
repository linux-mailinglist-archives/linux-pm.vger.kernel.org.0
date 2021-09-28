Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA141ADEC
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 13:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbhI1LhM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 28 Sep 2021 07:37:12 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34588 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240389AbhI1LhJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 07:37:09 -0400
Received: by mail-oi1-f181.google.com with SMTP id z11so29604544oih.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 04:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R2hV/c/VscszlXLGE/Sh9mvQgcMZa6qkiqhfSOeLvkg=;
        b=LzAmIw1LBMDjXjr5MWPzZnCiDA9eb3qmxZcg4j0YC9IQrspnfd63YRJmx9qtQJs3ay
         7rmV4X2HEH+LDm0BsKL3mIPje/O+qk33kJCVTid3XdiGNxJOMk8qVMpCmjnNesK7efY9
         zNKuGBuPOQeq1BmpM8aDPTm/5g1xp0OQJRA9Q8eTKa7/UTqKkIY8oYsRwJLrcA6ypGTR
         oHalXz0LdNK7WPpjBFllL9DtxunJb5x8aJpRDw+0Kp2cDl85rFv62P6duwqxd2yNIMLU
         iXQXO3a4yi7ply4YqutAFJ2EBvsL//2o7LS0pr9AVZQStATczUMdNZWFXKK5jHgDBzwH
         +z/Q==
X-Gm-Message-State: AOAM532Rhushd3CpGvqyDPpceHgGnksLtECruePnNx3rgWU7+KSGTWfw
        9dh9MNnQ4oNHatu3+NYBrnOFJv/k98GI+Ifgxz6wWMm0
X-Google-Smtp-Source: ABdhPJyhuIpL39aBFzvF2oiOr7aZjmDvgwv9+4Ezjm47rDmAAsxmcXBXjyzBrF8VVm2d1bdBjulBjwhgrAkpGP72Zjs=
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr3148213oib.69.1632828929705;
 Tue, 28 Sep 2021 04:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210927082421.2358851-1-vadimp@nvidia.com> <9aca37cb-1629-5c67-1895-1fdc45c0244e@linaro.org>
 <BN9PR12MB53814545BAE8C5A45E81220FAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
 <942558b3-e884-a907-0cc6-5eddf07c358a@linaro.org> <BN9PR12MB5381EADD601B87E4F2C60EBFAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
 <d87227b8-57b9-fdb9-bb87-f01c6d0e23cc@linaro.org> <BN9PR12MB538128B5C2A0B04531E5775CAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
 <af9857f2-578e-de3a-e62b-6baff7e69fd4@linaro.org>
In-Reply-To: <af9857f2-578e-de3a-e62b-6baff7e69fd4@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Sep 2021 13:35:17 +0200
Message-ID: <CAJZ5v0ja1DhR_1oaPkxCOksz9vf1nZGFCZ8JTD9kz9c+BnJ1rA@mail.gmail.com>
Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device statistics
 update for configuration operation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Vadim Pasternak <vadimp@nvidia.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 27, 2021 at 11:12 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 27/09/2021 19:52, Vadim Pasternak wrote:
> >
> >
> >> -----Original Message-----
> >> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Sent: Monday, September 27, 2021 4:56 PM
> >> To: Vadim Pasternak <vadimp@nvidia.com>; rui.zhang@intel.com
> >> Cc: linux-pm@vger.kernel.org; Ido Schimmel <idosch@nvidia.com>; Rafael J.
> >> Wysocki <rjw@rjwysocki.net>
> >> Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device statistics
> >> update for configuration operation
> >>
> >> On 27/09/2021 15:29, Vadim Pasternak wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>> Sent: Monday, September 27, 2021 3:32 PM
> >>>> To: Vadim Pasternak <vadimp@nvidia.com>; rui.zhang@intel.com
> >>>> Cc: linux-pm@vger.kernel.org; Ido Schimmel <idosch@nvidia.com>;
> >> Rafael J.
> >>>> Wysocki <rjw@rjwysocki.net>
> >>>> Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device
> >>>> statistics update for configuration operation
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> On 27/09/2021 13:22, Vadim Pasternak wrote:
> >>>>> Hi Daniel,
> >>>>>
> >>>>> Thank you for quick reply.
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>>>> Sent: Monday, September 27, 2021 1:42 PM
> >>>>>> To: Vadim Pasternak <vadimp@nvidia.com>; rui.zhang@intel.com
> >>>>>> Cc: =idosch@nvidia.com; linux-pm@vger.kernel.org
> >>>>>> Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device
> >>>>>> statistics update for configuration operation
> >>>>>>
> >>>>>>
> >>>>>> Hi Vadim,
> >>>>>>
> >>>>>>
> >>>>>> On 27/09/2021 10:24, Vadim Pasternak wrote:
> >>>>>>> The thermal subsystem maintains a transition table between states
> >>>>>>> that is allocated according to the maximum state supported by the
> >>>>>>> cooling device.
> >>>>>>>
> >>>>>>> When the table needs to be updated, the thermal subsystem does
> >> not
> >>>>>>> validate that the new state does not exceed the maximum state,
> >>>>>>> leading to out-of-bounds memory accesses [1].
> >>>>>>
> >>>>>> Actually, thermal_cooling_device_stats_update() is called if the
> >>>>>> set_cur_state is successful.
> >>>>>>
> >>>>>> With a state greater than the max state, the set_cur_state should
> >>>>>> fail and
> >>>>>> thermal_cooling_device_stats_update() is not called.
> >>>>>>
> >>>>>> Perhaps the problem is in mlxsw_thermal_set_cur_state() ?
> >>>>>
> >>>>> "mlxsw" thermal drivers has additional use of 'sysfs' 'cur_state'
> >>>>> for configuration purpose to limit minimum fan speed.
> >>>>> Fan speed minimum is enforced by setting 'cur_state' with value
> >>>>> exceeding actual fan speed maximum.
> >>>>
> >>>> Yes, and that is the problem because the driver is doing weird things
> >>>> with the cooling device state resulting in an abuse of the sysfs API
> >>>> and conflicting with the thermal internals.
> >>>>
> >>>>
> >>>>> This feature provides ability to limit fan speed according to some
> >>>>> system wise considerations, like absence of some replaceable units
> >>>>> or high system ambient temperature, or some other factors which
> >>>>> indirectly impacts system airflow.
> >>>>
> >>>> Is that a static thermal profile depending on the platform set by
> >>>> userspace or something which can be changed dynamically at runtime via
> >> eg. a daemon ?
> >>>
> >>> Yes, this is some profiles/rules, which are system specific and
> >>> according to these rules userspace can limit fan speed. Like, for example:
> >>> - if one of power supplies is removed, system fan should be enforced to
> >> full
> >>>   speed, because it makes a hole in a box, and it has hard impact on airflow.
> >>> - If port side ambient temperature reaches some threshold X1, fan speed
> >> should
> >>>   be limited by Y1%, X2 - Y2%, etcetera.
> >>> - if temperature fault is detected for any optical transceivers - some limit is
> >>>   required.
> >>
> >> I see, thanks for the information.
> >>
> >>>>> For example, if cooling devices operates at cooling levels from 1 to
> >>>>> 10
> >>>>> (1 for 10% fan speed, 10 for 100% fan speed), cooling device minimal
> >>>>> speed can be limited by setting 'cur_state' attribute through 'sysfs'
> >>>>> to the values from 'max_state' + 1 to 'max_state * 2' (from 11 to 20).
> >>>>> Following this example if value is set to 14 (40%) cooling levels
> >>>>> vector will be set to 4, 4, 4, 4, 4, 5, 6, 7, 8, 9, 10 for setting
> >>>>> device speed cooling states respectively in 40, 40, 40, 40, 40, 50,
> >>>>> 60. 70, 80, 90,
> >>>>> 100 percent. And it limits cooling device to operate only at 40%
> >>>>> speed and above.
> >>>>>
> >>>>> Maybe it would be worth adding earlier some dedicated 'cur_state_limit'
> >>>>> attribute for this feature, but it was not done.
> >>>>>
> >>>>> We have another driver required this feature and one new we are
> >>>>> developing now, which require fan minim speed limit as well.
> >>>>
> >>>> The use case is valid but I think the approach is wrong. Probably the
> >>>> simplest thing to do is to set a low trip point with a minimal fan speed.
> >>>
> >>> For "trip_point_0_temp" there is the below definition:
> >>>     {       /* In range - 0-40% PWM */
> >>>             .type           = THERMAL_TRIP_ACTIVE,
> >>>             .temp           = MLXSW_THERMAL_ASIC_TEMP_NORM,
> >>>             .hyst           = MLXSW_THERMAL_HYSTERESIS_TEMP,
> >>>             .min_state      = 0,
> >>>             .max_state      = (4 * MLXSW_THERMAL_MAX_STATE) / 10,
> >> (40%)
> >>>     },
> >>> For "trip_point_1_temp":
> >>>     {
> >>>             /* In range - 40-100% PWM */
> >>>             .type           = THERMAL_TRIP_ACTIVE,
> >>>             .temp           = MLXSW_THERMAL_ASIC_TEMP_HIGH,
> >>>             .hyst           = MLXSW_THERMAL_HYSTERESIS_TEMP,
> >>>             .min_state      = (4 * MLXSW_THERMAL_MAX_STATE) / 10,
> >> (100%)
> >>>             .max_state      = MLXSW_THERMAL_MAX_STATE,
> >>>     },
> >>>
> >>> To limit cooling device by f.e 70%, I should change dynamically 'min_state'
> >> and 'max_state'
> >>> for both trips to (70%, 70%) and (70%, 100%). I am not sure I can do it?
> >>>
> >>> And we have many customers, using this user space interface, it would
> >>> be not so good to change it.
> >>
> >> The issue is the driver is wrong here. The change you referred in the past
> >> should have not been merged. I note there is no thermal maintainer blessing
> >> in the tags.
> >>
> >>> I understand it is possible to handle this issue inside driver's
> >>> set_cur_stat() callback by returning positive value for configuration
> >> request.
> >>> But maybe this feature could you useful for other developers and it
> >>> could be some common interface to support it?
> >>
> >> I suggest to revert a421ce088ac8 and switch to hwmon to set the fan speed.
> >> At the first glance, it is already supported by the mlx driver, no ?
> >>
> >
> > Yes, hwmon is supported.
> > But setting fan trough hwmon means we'll have two owners controlling same device.
>
> Whatever the solution, there are several components acting on the device
> at the same time (userspace and in-kernel) :/
>
>
> > If speed is set through hwmon for example to 100%, thermal could decide to decrease
> > it, since it does not know what the reason was for setting full speed.
> > And it could make a completion between hwmon and thermal for cooling control.
> >
> > Maybe adding new set_min_state()/get_min_state() callback could work?
> > In such case user space can limit speed through "min_state" attrbbute.
> >
> > Maybe some other approach, but within thermal subsystem?
>
> I'm very reluctant to let the userspace to deal with the cooling device
> because that is prone to abuse. And this driver is another example :(
>
> Actually, the thermal framework should be dedicated to protect Tj,
> nothing else.

Do I understand correctly that you mean the fan should be handled by
either hwmon or thermal, but not both at the same time?

I totally agree.

If user space is allowed to control the fan via hwmon, it is
responsible for setting its speed as needed.

> However, as the hwmon is already supported, what is possible is to set
> the min state in the driver when it is set via hwmon and use this min
> state from the cooling device to prevent going below in set_cur_state.
>
> So instead of dealing with out-of-boundaries values with the state, just
> ignore requests which are below the min_state set by the hwmon in
> set_cur_state.
>
> There is no consistent mapping between what is a cooling device state
> and hwmon, so it is hard to do generic code ATM.
>
> Dealing with the state in the driver, makes the code self-encapsulate
> and consistent.
>
> Please revert commit a421ce088ac8 and check the code in mlxreg-fan.c
> which sounds the exact copy of what provided a421ce088ac8.
>
>
> >> --
> >> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter | <http://www.linaro.org/linaro-
> >> blog/> Blog
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
