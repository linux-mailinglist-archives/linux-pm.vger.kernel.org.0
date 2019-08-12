Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807258A565
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 20:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfHLSJ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 14:09:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45949 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLSJ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 14:09:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id m24so9327278otp.12;
        Mon, 12 Aug 2019 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QcxG+y7uUMimiO/pMRblr0nxvjdwfHSC6ubDdIrvAY=;
        b=fuz3IDi2CHnDwBAgnOX/DqTGjTs3nNMhTLi8a+4MBC4JvaZtIf/AXR0RTZMq1Ci4yT
         DVuVjirlqcHJ6alHRJ+MzctL6YGDUXtSSTXoQtS1c20O9CE5CrRKqG4n5877qy5y7ZY/
         imbn41271Q3nH7lr7OXXDfUPxy/44B6JBpNaQcv4f9gcXtgFIy72XOS5XYo2pvKNcgZA
         WMZoEjVC8+D+7sUuNd0aQHllsNuoxnjWphZk5rGGLUeJIq1OPGGf/S174XSXV0KVJrjZ
         fSNjewZucdPsd+4ZVheYDBAXpGtavwho+MHHtsAB58zzu4tW6l+WnO8kh2SSnGqdtLlL
         ba1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QcxG+y7uUMimiO/pMRblr0nxvjdwfHSC6ubDdIrvAY=;
        b=R+WeG+uYcm5KHA/1uTSuPGUKZNksohFmzUGWQH+OBayg5NRr6sNZ6tOge2Y1SBrWLz
         qcIBmtYmTnt0bGSd5aZ8nukBpE/Fq/NEu+9apKNE+curaCHsSOwwBKSJTO8PZ2+4LbT0
         n0YFvSBYPON3TkZDzHSLWXo5M0bsj1He/2guJ3sd1xNxG7fYP/2r4+peVh02jF6oKgeQ
         TP0iAbGPISCxldoqdgWIjGICOJU5YTHbdr9QRbUoOEUxXN3JrPU13ElFkdrt/OonBg4V
         iI39rr++6GRnuOEi9pu4FctnUEVkBcOZ00EsWxCEkpqYYfIa7kJoNC+EJhCyQDwcB2S9
         bNmQ==
X-Gm-Message-State: APjAAAURK+p8xPGZH8PJsNY3nepsWDtpLCprcaO3GQKy+r9PXzJvEZAk
        6z8mbwSjv34aFvgRIxiHLcuMqfL5H/h0htFiY/I=
X-Google-Smtp-Source: APXvYqych12uoPQYE7uuZ8a1AC5thPiDjPijuWFFmC5taSfdClmoUGYk9Jlug2BMANoD67mIwsAS0n9ZKcYVfw49Mbc=
X-Received: by 2002:a5d:9711:: with SMTP id h17mr35204728iol.280.1565633395709;
 Mon, 12 Aug 2019 11:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 12 Aug 2019 11:09:44 -0700
Message-ID: <CAHQ1cqH29NaKTjere6DiuT=KmuhQ3YAphs4LZKN576vdA-KSEg@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] QorIQ TMU multi-sensor and HWMON support
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 17, 2019 at 9:15 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Everyone:
>
> This series contains patches adding support for HWMON integration, bug
> fixes and general improvements (hopefully) for TMU driver I made while
> working on it on i.MX8MQ.n
>
> Feedback is welcome!
>
> Thanks,
> Andrey Smirnov
>

Eduardo:

Do you have any comment on this series?

Thanks,
Andrey Smirnov

> Changes since [v5]
>
>     - Rebased on recent linux-next, dropped "thermal: qoriq: Remove
>       unnecessary DT node is NULL check" since it is already in the
>       tree
>
>     - Dropped dependency on [rfc]
>
> Changes since [v4]
>
>     - Collected Tested-by from Lucas
>
>     - Collected Reviewed-by from Daniel
>
>     - Converted "thermal: qoriq: Enable all sensors before registering
>       them" to use if instead of switch statement for error checking
>
> Changes since [v3]
>
>     - Series reabse on top of [rfc]
>
>     - Fixed incorrect goto label in "thermal: qoriq: Pass data to
>       qoriq_tmu_calibration()"
>
>     - Added REGS_TRITSR() register description to "thermal: qoriq: Do
>       not report invalid temperature reading"
>
>     - Reworded commit message of "thermal: qoriq: Remove unnecessary
>       DT node is NULL check"
>
> Changes since [v2]
>
>     - Patches rebased on v5.1-rc1
>
> Changes since [v1]
>
>     - Rebased on "linus" branch of
>       git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
>       that included latest chagnes adding multi-sensors support
>
>     - Dropped
>
>         thermal: qoriq: Add support for multiple thremal sites
>         thermal: qoriq: Be more strict when parsing
>         thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()
>
>       since they are no longer relevant
>
>     - Added
>
>         thermal: qoriq: Don't store struct thermal_zone_device reference
>         thermal: qoriq: Add local struct qoriq_sensor pointer
>         thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
>         thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
>
>       to simplify latest codebase
>
>     - Changed "thermal: qoriq: Do not report invalid temperature
>       reading" to use regmap_read_poll_timeout() to make sure that
>       tmu_get_temp() waits for fist sample to be ready before
>       reporting it. This case is triggered on my setup if
>       qoriq_thermal is compiled as a module
>
> [v1] lore.kernel.org/lkml/20190218191141.3729-1-andrew.smirnov@gmail.com
> [v2] lore.kernel.org/lkml/20190222200508.26325-1-andrew.smirnov@gmail.com
> [v3] lore.kernel.org/lkml/20190401041418.5999-1-andrew.smirnov@gmail.com
> [v4] lore.kernel.org/lkml/20190413082748.29990-1-andrew.smirnov@gmail.com
> [v5] lore.kernel.org/lkml/20190424064830.18179-1-andrew.smirnov@gmail.com
> [rfc] lore.kernel.org/lkml/20190404080647.8173-1-daniel.lezcano@linaro.org
>
>
> Andrey Smirnov (12):
>   thermal: qoriq: Add local struct device pointer
>   thermal: qoriq: Don't store struct thermal_zone_device reference
>   thermal: qoriq: Add local struct qoriq_sensor pointer
>   thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
>   thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
>   thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
>   thermal: qoriq: Convert driver to use devm_ioremap()
>   thermal: qoriq: Convert driver to use regmap API
>   thermal: qoriq: Enable all sensors before registering them
>   thermal: qoriq: Do not report invalid temperature reading
>   thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
>   thermal: qoriq: Add hwmon support
>
>  drivers/thermal/qoriq_thermal.c | 272 ++++++++++++++++----------------
>  drivers/thermal/thermal_hwmon.c |  28 ++++
>  drivers/thermal/thermal_hwmon.h |   7 +
>  3 files changed, 175 insertions(+), 132 deletions(-)
>
> --
> 2.21.0
>
