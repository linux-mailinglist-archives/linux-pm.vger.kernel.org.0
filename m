Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC41DA959
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 06:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgETEjU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 00:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgETEjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 00:39:19 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD85BC061A0E
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 21:39:18 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id i5so834894uaq.1
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 21:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bN33/t2eLeTstLrZyjcuNRb4/1M2McULreC+aBLFsKY=;
        b=KyvQdQznDyANTa17aPpiFcnsc1pQjQOaXWByaGMWwwPUJoy+Vg1dkYgIcK65pJoZF2
         VNzctzXlIZuMmoaQrWgEZKPBCOGLq+uIgzNcQu/uaC5n/G5z2bd4j2Dpg8I1J7MVJHxO
         z2tH5O19eHvt7m9LQdmxHU4qG/pA9Q5TdkIEbd4a5GLUi5YMdxG9SAVV60ltfWHtFhai
         WrMdNPkPQ7QjZ6CCTa8YrBvcVJxXQM5uODY36M63RN+4YXHmbaFXsWZF6/tXNFSlnE04
         J/6tM7QOy987xuyagLUrrR5fwb/ry/jPLNfzXL5dcDZNNXzpaszBWYWv8bzYy/Hrkr6H
         5PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bN33/t2eLeTstLrZyjcuNRb4/1M2McULreC+aBLFsKY=;
        b=Oqsvq8hiz8xOFLuSzA9nGFeR4nmfCpTnrgJ9hubuiJ/pzI2zyvwK6F/v4XMa8C4jqr
         irz8DMRh1k0VoVBJfmp85J1p02uIztr3EYHsLJ6TXpH3RjMCbpWB6zPPQXkYDfcIF48l
         wh0/fDAmFhiLR5rXevkwmwg1/27mTNm+v1acVpkMXgRmKiBOTzHc7GqYar2Wf/jl5R5W
         PHJaI0YHlbpB/CevrY8J+dcHcQGkl7BkBbMno9w7xn8qXmxuqEH/4wo1dolTCHiZwqCz
         sIoogKsQjukhIyJui+VK8rFqXB2BvyLbdtvL5mKgkzym7XPrs1Hwa1LUccz1PDUVx4Fc
         1a0g==
X-Gm-Message-State: AOAM530tbeiz69JIcGRiPvep5OGmEEeKq1qgD0rtN/AZuVAGYtTmlMFY
        QTvsAKkKPyohu5/Lfocd2o8lpjlo3LlfTkXmyHAtFQ==
X-Google-Smtp-Source: ABdhPJy6+WnxGks0sYjseLzIGFwvoRP1i7vU1VbEroClHYYOmGdvgrA1p+RMSAPKyxJTpxhEvwDROVsDcyrC1WJjYvs=
X-Received: by 2002:ab0:22c5:: with SMTP id z5mr2032418uam.48.1589949557845;
 Tue, 19 May 2020 21:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com> <20200504181616.175477-5-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200504181616.175477-5-srinivas.pandruvada@linux.intel.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 20 May 2020 10:08:35 +0530
Message-ID: <CAHLCerP5E9Ec10e6JfW=BS0wTsA-ETymCNbXLHvV0092KDgVpg@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/5] thermal: Add support for setting polling interval
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 4, 2020 at 11:47 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add new attribute in the thermal syfs for setting temperature sampling
> interval when CONFIG_THERMAL_USER_EVENT_INTERFACE is defined. The default
> value is 0, which means no polling.
>
> At this interval user space will get an event THERMAL_TEMP_SAMPLE with
> temperature sample. This reuses existing polling mecahnism when polling
> or passive delay is specified during zone registry. To avoid interference
> with passive and polling delay, this new polling attribute can't be used
> for those zones.

Why should the kernel periodically emit events for userspace when the
userspace is perfectly capable of deciding how frequently it wants to
poll a file for changes?

>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/thermal_core.c  |  7 +++++++
>  drivers/thermal/thermal_sysfs.c | 36 +++++++++++++++++++++++++++++++--
>  include/linux/thermal.h         |  1 +
>  3 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 14770d882d42..17cd799b0073 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -313,6 +313,8 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
>                 thermal_zone_device_set_polling(tz, tz->passive_delay);
>         else if (tz->polling_delay)
>                 thermal_zone_device_set_polling(tz, tz->polling_delay);
> +       else if (tz->temp_polling_delay)
> +               thermal_zone_device_set_polling(tz, tz->temp_polling_delay);
>         else
>                 thermal_zone_device_set_polling(tz, 0);
>
> @@ -446,6 +448,11 @@ static void update_temperature(struct thermal_zone_device *tz)
>         tz->temperature = temp;
>         mutex_unlock(&tz->lock);
>
> +       if (tz->temp_polling_delay) {
> +               thermal_dev_send_event(tz->id, THERMAL_TEMP_SAMPLE, temp);
> +               monitor_thermal_zone(tz);
> +       }
> +
>         trace_thermal_temperature(tz);
>         if (tz->last_temperature == THERMAL_TEMP_INVALID)
>                 dev_dbg(&tz->device, "last_temperature N/A, current_temperature=%d\n",
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa85424c3ac4..0df7997993fe 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -248,6 +248,36 @@ create_thres_attr(temp_thres_low);
>  create_thres_attr(temp_thres_high);
>  create_thres_attr(temp_thres_hyst);
>
> +static ssize_t
> +temp_polling_delay_store(struct device *dev, struct device_attribute *attr,
> +                  const char *buf, size_t count)
> +{
> +       struct thermal_zone_device *tz = to_thermal_zone(dev);
> +       int val;
> +
> +       if (kstrtoint(buf, 10, &val))
> +               return -EINVAL;
> +
> +       if (val && val < 1000)
> +               return -EINVAL;
> +
> +       tz->temp_polling_delay = val;
> +       thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +
> +       return count;
> +}
> +
> +static ssize_t
> +temp_polling_delay_show(struct device *dev, struct device_attribute *attr,
> +                    char *buf)
> +{
> +       struct thermal_zone_device *tz = to_thermal_zone(dev);
> +
> +       return sprintf(buf, "%d\n", tz->temp_polling_delay);
> +}
> +
> +static DEVICE_ATTR_RW(temp_polling_delay);
> +
>  static int create_user_events_attrs(struct thermal_zone_device *tz)
>  {
>         struct attribute **attrs;
> @@ -260,8 +290,8 @@ static int create_user_events_attrs(struct thermal_zone_device *tz)
>         if (tz->ops->get_temp_thres_high)
>                 ++index;
>
> -       /* One additional space for NULL */
> -       attrs = kcalloc(index + 1, sizeof(*attrs), GFP_KERNEL);
> +       /* One additional space for NULL and temp_pollling_delay */
> +       attrs = kcalloc(index + 2, sizeof(*attrs), GFP_KERNEL);
>         if (!attrs)
>                 return -ENOMEM;
>
> @@ -312,6 +342,8 @@ static int create_user_events_attrs(struct thermal_zone_device *tz)
>                 attrs[index] = &tz->threshold_attrs[index].attr.attr;
>                 ++index;
>         }
> +       if (!tz->polling_delay && !tz->passive_delay)
> +               attrs[index++] = &dev_attr_temp_polling_delay.attr;
>         attrs[index] = NULL;
>         tz->threshold_attribute_group.attrs = attrs;
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index ee9d79ace7ce..0ec4bd8c9c5c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -216,6 +216,7 @@ struct thermal_zone_device {
>         enum thermal_notify_event notify_event;
>         struct attribute_group threshold_attribute_group;
>         struct thermal_attr *threshold_attrs;
> +       int temp_polling_delay;
>  };
>
>  /**
> --
> 2.25.4
>
