Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD99213766
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 11:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgGCJOu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGCJOu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 05:14:50 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CB5C08C5DD
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 02:14:50 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id m21so5662490vkp.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2020 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjLtRECZ4xF2T8beK0iYF5HUVoGI04zGUc7fJuaUDUM=;
        b=tr1vg3PWzgcj46XCTU9K0bi6+NFfnGc+PieFv9e9XcIIxPLoTAJqDTKGVOSOVaYJDO
         0MaH93nB9up68BBkr/e/KHSCkFvYwpVIzgTBODl5Kf5BUUxoQgdBjkHwFIdEtHAhPnEZ
         TLA5quj/bgjLPmyF4a7iJCUXdMpg2qZjQ5p+S6BDb7DtKX1krZw2Ir8LAhRksXHUuZyp
         3Kr/N1KnUSqmrSkiLOw626SR1lZ3arU/kr+KsirZaCZiU470zJqDGo2Pg1NGeK6pXspy
         JS/ND+L85yDzXth/vl3tSea5Ungvw5Fql4rxDRY4MNCbCIC3iA8C2bKZpItviWaQ+XN1
         0v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjLtRECZ4xF2T8beK0iYF5HUVoGI04zGUc7fJuaUDUM=;
        b=So1DozOA8T34KyU2fQcnPCjgabZl0lMTjT3EiAQPvPGnsz/7+XDyj4VoExoQJXuZaJ
         4GEujQ/j3fZX6D3RV1FaCV1S+M/CFar6vjJ507mQBY2yHolqtE59jPyNMW6uZf3VoyaX
         gNIX40Sxj9opj4oQ7PveDz6vD7yBu0hwXsnc61GFC83iVewMNDNwd31G5K6tuo97yaVK
         EgmdD3m4S8wZjXWI1lE5BlFEvJdb190SitweGcvgE2hDBWAA/HzRQ7eAbT3V7gzdExvE
         ZD6j3vcvPwTbqhstrprpc8buXrYufYhn50yvueBu7+SpCh7eSziSGXck+dGbMOag7a5e
         DYMQ==
X-Gm-Message-State: AOAM533npYR0/KEo5pR1EmDamoaewApKdb1l0uLKmIrkX+tdnmbA6Ntm
        Osm9H0lVt5bjd9mV3Pfm39meABJ2jVrGY4g3UXyeHQ==
X-Google-Smtp-Source: ABdhPJzfbf5Nax4iS96K0l+ThgK+nVowfJb+1weNMs+rW7SolUPD+6MUGhyXzyhgTSw3v7GTRkqHJoG8Yk9mxnLxaz0=
X-Received: by 2002:a1f:d783:: with SMTP id o125mr25421584vkg.46.1593767688546;
 Fri, 03 Jul 2020 02:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200703085309.32166-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200703085309.32166-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 3 Jul 2020 14:44:37 +0530
Message-ID: <CAHLCerMu8YQZvt91qWKWBnWKZwFp=Ch-HpBK2-+Ut8nsM1S7ww@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] thermal: core: Add helpers to browse the cdev, tz
 and governor list
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 3, 2020 at 2:23 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The cdev, tz and governor list, as well as their respective locks are
> statically defined in the thermal_core.c file.
>
> In order to give a sane access to these list, like browsing all the
> thermal zones or all the cooling devices, let's define a set of
> helpers where we pass a callback as a parameter to be called for each
> thermal entity.
>
> We keep the self-encapsulation and ensure the locks are correctly
> taken when looking at the list.
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 51 ++++++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_core.h |  9 ++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index b71196eaf90e..9caaa0b6d662 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -617,6 +617,57 @@ void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
>         mutex_unlock(&thermal_list_lock);
>  }
>
> +int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
> +                             void *data)
> +{
> +       struct thermal_governor *gov;
> +       int ret = 0;
> +
> +       mutex_lock(&thermal_governor_lock);
> +       list_for_each_entry(gov, &thermal_governor_list, governor_list) {
> +               ret = cb(gov, data);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&thermal_governor_lock);
> +
> +       return ret;
> +}
> +
> +int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
> +                                             void *), void *data)
> +{
> +       struct thermal_cooling_device *cdev;
> +       int ret = 0;
> +
> +       mutex_lock(&thermal_list_lock);
> +       list_for_each_entry(cdev, &thermal_cdev_list, node) {
> +               ret = cb(cdev, data);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&thermal_list_lock);
> +
> +       return ret;
> +}
> +
> +int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
> +                         void *data)
> +{
> +       struct thermal_zone_device *tz;
> +       int ret = 0;
> +
> +       mutex_lock(&thermal_list_lock);
> +       list_for_each_entry(tz, &thermal_tz_list, node) {
> +               ret = cb(tz, data);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&thermal_list_lock);
> +
> +       return ret;
> +}
> +
>  void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
>                                           const char *cdev_type, size_t size)
>  {
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index c95689586e19..71d88dac0791 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -41,6 +41,15 @@ extern struct thermal_governor *__governor_thermal_table_end[];
>              __governor < __governor_thermal_table_end; \
>              __governor++)
>
> +int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
> +                         void *);
> +
> +int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
> +                                             void *), void *);
> +
> +int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
> +                             void *thermal_governor);
> +
>  struct thermal_attr {
>         struct device_attribute attr;
>         char name[THERMAL_NAME_LENGTH];
> --
> 2.17.1
>
