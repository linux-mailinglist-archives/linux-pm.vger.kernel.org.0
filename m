Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBA1D1307
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 14:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgEMMpm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 08:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgEMMpl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 08:45:41 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667CBC061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 05:45:40 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id v23so4205085vke.13
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k11BgFusq+CX9TNx60IPVumpsVXTUwt92riMb0DYJaE=;
        b=YJI+EcfWZ+8ylhZCVkUoBRMa8Z8DZ/3ThWEx6jyQur/MiopMoKnrw1dIxN56w2H9EV
         bUXSkMqwpjIzud3gS2+P/bKb6OiI/qK/Vp8/z3EkOLUeysa1+CNNt2l18n1RCoOK6OJN
         7zpGLb5JBSSHF0XI0Z+lCVrlBkHHIrtzpey0E35lyvP8xMEjmZtpeDd6qKb7dJQaxj1y
         CZOqLo2AeHKgnkXb1fq+8PRSK9WGv0sQ/kSnLRe2E+sc5LHuYiQvMpRDfj9C1NGmNuSA
         dYW/m+tjAhBdOFpH2GrLijhZp+wQQSpXix1p1tDwxvsEG9DdAogbZ17s2ZSRkmUdJF/H
         ETFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k11BgFusq+CX9TNx60IPVumpsVXTUwt92riMb0DYJaE=;
        b=BSNuOAgSR/KBPobm7hFvdeuSEjHuxa0UUwFtpvUVUJqiQGHuPmJRS/wTzhf11ZT1G+
         xNtkeOMurxIA/cTfaWVRTmubqHARxho8gUkXfvDkyJH4dLiQVQFcXKcR5VQP3hGqUcsK
         vtrl5nEBmX5Fj1/YSmoBVJMaP6qy8wlnmG24xdVAaHHBlxWQOVq6HKUwc/QVb6fdywjE
         A2TmB8j+KYqfxj3tFsdwEmM6eFNaD7gCVnBeT+UUYsk4DYXZmLwZCaLppE6N6HPmj32d
         8/4O3BaAap4D4g9QuZmUEv2B/61GrWbjZdv/rVeDPmXCCINZv3tcDJYYES7WvooGd3s2
         rdWA==
X-Gm-Message-State: AGi0Pua4RsvGOvIpETuJHB5QiGHBFS9gpwibW1BRIIMUn9+Gt3QUo3+7
        /W09w/w1ZSIdl4e/44Ulkw17ftYP72YhiE2pkl4oDQ==
X-Google-Smtp-Source: APiQypIQG3j4P/rzKiQcQ4kGJT069T+ctVjpibYNH8k+0wyHHeTJZ1refW15mY214zy4C9RZ7h7YRvR/frH66n5CnfA=
X-Received: by 2002:a1f:ccc7:: with SMTP id c190mr21118181vkg.79.1589373939526;
 Wed, 13 May 2020 05:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
 <1587455093-33876-3-git-send-email-shenyang39@huawei.com> <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
 <0be585d3-1180-7b42-8b51-392a34793f70@huawei.com> <b1739246-3639-a6c1-6c0d-275eb2ab0d16@linaro.org>
 <5EB65D33.80105@hisilicon.com> <96c7578e-25cf-d258-6505-8c1c631dbe82@linaro.org>
 <5EB8A9DC.9030004@hisilicon.com> <85f9f90f-2b67-4cfd-cc28-b14e037755b7@linaro.org>
In-Reply-To: <85f9f90f-2b67-4cfd-cc28-b14e037755b7@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 13 May 2020 18:15:01 +0530
Message-ID: <CAHLCerMfbJ3cAD32DHmYjEHPTa85a=ocYiPi3C9Ew5ctj-rVvQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] thermal: Add HiSilicon Kunpeng thermal driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        "shenyang (M)" <shenyang39@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 11, 2020 at 1:44 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/05/2020 03:26, Zhou Wang wrote:
> > On 2020/5/10 13:04, Daniel Lezcano wrote:
> >> On 09/05/2020 09:35, Zhou Wang wrote:
> >>> On 2020/4/28 22:02, Daniel Lezcano wrote:
> >>>> On 28/04/2020 13:58, shenyang (M) wrote:
> >>>>> On 2020/4/27 20:13, Daniel Lezcano wrote:
> >>>>>> On 21/04/2020 09:44, Yang Shen wrote:
> >>>>>>> Support HiSilicon Kunpeng tsensor. the driver will report the max
> >>>>>>> temperature for each core.
> >>>>>>
> >>>>>> As this is a new driver, can you give a bit more details of the hardware
> >>>>>> in this description.
> >>>>>>
> >>>>>> A subsidiary question, why do you want to aggregate the temperatures in
> >>>>>> this driver ?
> >>>>>>
> >>>>>
> >>>>> OK. In fact, there are five temperature sensors distributed in the SOC.
> >>>>> And our strategy is to collect all temperatures and return the max to
> >>>>> the interface.
> >>>>
> >>>> The aggregation should be done in the thermal framework not in the driver.
> >>>>
> >>>> Why not create one sensor per thermal zone, so giving the opportunity to
> >>>> create different configurations with different cooling device ?
> >>>
> >>> Hi Daniel,
> >>>
> >>> In our SoC, we use IMU(Intelligent Management Unit) which is an out of band
> >>> management processor to control cooling device. We use fans to cool CPU, one
> >>> fan is for one SoC. So getting one temperature for one SoC is enough here.
> >>>
> >>> We also want to report temperature of the SoC from kernel thermal subsystem,
> >>> so users get get SoC temperature from sysfs or user space tool, like Im-sensor.
> >>> The goal of this driver is just to do this.
> >>
> >> Are you saying you don't care of any cooling devices from the kernel as
> >> the IMU is taking care of it ?
> >
> > Yes.
> >
> >>
> >> Do you have a pointer to a DT where the thermal zones are defined?
> >
> > These sensors are in an aarch64 server system(Kunpeng920), which is based on ACPI.
>
> Ah right.
>
> What is the benefit of hiding the real hardware by taking the max value
> of all the sensors and providing to the userspace a truncated view of
> what is happening on the system?
>
> Why not simply register a thermal_zone_device per sensor and get rid of
> the 'max' value? So the userspace can have a correct view of the thermal
> behavior of its system.
>

They're simply using the thermal framework to show some temperatures
in sysfs. It seems they have no use for any of the other features of
the thermal framework, all that is handled in ACPI firmware.

I do wonder if such drivers would be better off registering a hwmon
driver instead.

Regards,
Amit
