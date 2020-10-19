Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F55292DAE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 20:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgJSSn0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 14:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbgJSSnZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 14:43:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674A4C0613D0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 11:43:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b15so839557iod.13
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XS0b41HJUJUqgJ5lkLHS/Jz0mUrtabIGSzld1xEhiLY=;
        b=ir9bJ0Xz8Qh7mhbng1X4z3mYPFaJwefOpeicuAqbfOrUlnrKft0l4Y+orq5vragl/i
         g0cIy90g/N9UBPEVsyrSPed6Pb9dhgG88ex4yUpPLuko5abT3E/Q0MmcS9WDO9xoitbM
         KVbI//mNp5qBrEPTf+4pDS2i1lAf/nm08NGo0b1MrcnUXVk/wwnbTbkpHUJVm9kXfW//
         M+w7+oBcgI/w7+cxteVTEfuHYo3M/nGcXw3/jNiIeQG6CAwK/rJdNoi+CCCBtHkegfp/
         pvKLJsGqDQ2qGltmC25UQbObpMlP1nxjziF4yqc2bA8M/YnUZlNffjB5/PZIUhhL1Fk5
         Uvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XS0b41HJUJUqgJ5lkLHS/Jz0mUrtabIGSzld1xEhiLY=;
        b=MVl2VQxQdz5e5e1E/wnHwVoh4rRyQWRs0cKd9ElG8xiD5fu0ZnWVLX3knAZz/CLKE+
         SelxR1aKWTb46yYvAHb06aLFS5f1CxeIbIOkMFDQZsdbZ41HLGR4GEZiR0xZEF03BtZ5
         ptTNISVAkL+2mvznGLevV90BEJaD+40Dx07UyN6EqLrJM8KJpqNxwQnb47eeGk5EH3UX
         ReUkjCVOvbsVzFQnh/vt5nfSEd4vqdQd9sIlnfA74JiPI+s1858HCoeYmExzzWJBhU6z
         Qrf+1yoDJK6kMCDNPco1LpnNESP2l4JXsue6IAXZ/DKzUo6SYMrUmT8lrIkuh6VBoPSv
         QvtQ==
X-Gm-Message-State: AOAM531XQ/uZSZ7z/6CDqHfuAyZ0exSCjWh4mlpa/SF84Kg0s29nACCY
        pCoWW7XfIYSxt5g9n1WZMeeNUaNBg3YKIPmquCIWWA==
X-Google-Smtp-Source: ABdhPJxJAhL3IVfX23GRdC+ITCUP/phL4EJ1fYf/dYu5u9+SppORNH4yVRdNUGLOsnSubsAxikaKvN6MUW8UjZo5oW4=
X-Received: by 2002:a05:6638:d49:: with SMTP id d9mr1165361jak.85.1603133004559;
 Mon, 19 Oct 2020 11:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
In-Reply-To: <20200917032226.820371-1-thara.gopinath@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Date:   Mon, 19 Oct 2020 14:42:48 -0400
Message-ID: <CALD-y_wQeuUq=0+_TGWYwOAcM4zdmGbtCMYZ+Oa587HtzHHqVQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] Introduce warming in thermal framework
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lukasz.luba@arm.com, amitk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 16 Sep 2020 at 23:22, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Thermal framework today supports monitoring for rising temperatures and
> subsequently initiating cooling action in case of a thermal trip point
> being crossed. There are scenarios where a SoC need warming mitigating
> action to be activated if the temperature falls below a cetain permissible
> limit.  Since warming action can be considered mirror opposite of cooling
> action, most of the thermal framework can be re-used to achieve this. The
> key assumption in this patch series is that a device can act either as a
> warming device or a cooling device and not as both.
>
> In order to support warming three extensions are needed in the thermal
> framework.
>
> 1. Indication that a trip point is being monitored for falling temperature
> and not rising temperature. We discussed two different ways to achieve this
> during LPC. First option is to introduce a new trip type to indicate that a
> trip is a cold trip(THERMAL_TRIP_COLD). The second option is to introduce a
> new property for trip point that will indicate whether a trip point is
> being monitored for rising temperature or falling temperature. The patch
> series(patches 1-4) chooses the second approach since it allows trip points
> of any type to be monitored for rising or falling temperature.Also this was
> the preferred approach when discussed during LPC. The approach that
> introduces a new cold trip type was posted on the list earlier as a RFC and
> can be found at [1].
>
> 2. Extend the exisitng governors to handle monitoring of falling
> temperature. The patch series(patches 5 & 6) extends the step wise governor
> to monitor the falling temperature.Other governors return doing nothing if
> the trip point they are being called for is being monitored for falling
> temperature. The governors' mitigate function is called "throttle" in the
> thermal framework and with this patch series it is a misnomer as the
> function is called for both throttling and warming up. Ideally
> "throttle" should be renamed to "mitigate" to improve readability of code.
> The renaming is not part of this series.
>
> 3. Finally, the cooling device framework itself can be reused for a warming
> device. As stated before a device can act either as a warming device or a
> cooling device and not as both.  With this the cooling state in the
> framework can be considered as mitigating state with 0 as the state with no
> thermal mitigation and higher the number higher the thermal mitigation.
> Again what affects the code readability and comprehension is the term
> "cooling" which is a misnomer here. Ideally the term "cooling" should be
> renamed to "mitigating" and hence thermal_cooling_device will become
> thermal_mitgating_device. The renaming is not part of the patch series as
> even though the renaming is a simple search-replace, it will change a lot
> of files.  The patch series(patches 7 & 8) instead introduces a minimal set
> of _warming_device_ apis to register and unregister warming devices which
> internally is identical to the _cooling_device_ counterpart.

Gentle ping for review..

>
> 1. https://lkml.org/lkml/2020/7/10/639
>
> Thara Gopinath (8):
>   dt-bindings: thermal: Introduce monitor-falling parameter to thermal
>     trip point binding
>   thermal: Introduce new property monitor_type for trip point.
>   thermal: thermal_of: Extend thermal dt driver to support
>     bi-directional monitoring of a thermal trip point.
>   thermal:core:Add genetlink notifications for monitoring falling
>     temperature
>   thermal: gov_step_wise: Extend thermal step-wise governor to monitor
>     falling temperature.
>   thermal: Modify thermal governors to do nothing for trip points being
>     monitored for falling temperature
>   thermal:core: Add is_warming_dev and supporting warming device api's
>     to the cooling dev framework.
>   soc:qcom:qcom_aoss: Change cooling_device_register to
>     warming_device_register
>
>  .../bindings/thermal/thermal-zones.yaml       |   7 ++
>  drivers/soc/qcom/qcom_aoss.c                  |   6 +-
>  drivers/thermal/gov_bang_bang.c               |  12 ++
>  drivers/thermal/gov_fair_share.c              |  12 ++
>  drivers/thermal/gov_power_allocator.c         |  12 ++
>  drivers/thermal/gov_step_wise.c               |  62 +++++++---
>  drivers/thermal/thermal_core.c                | 113 +++++++++++++++---
>  drivers/thermal/thermal_core.h                |   2 +
>  drivers/thermal/thermal_of.c                  |  22 ++++
>  include/linux/thermal.h                       |   9 ++
>  include/uapi/linux/thermal.h                  |   5 +
>  11 files changed, 226 insertions(+), 36 deletions(-)
>
> --
> 2.25.1
>


-- 
Warm Regards
Thara
