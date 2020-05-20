Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F41DA979
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 06:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgETEug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 00:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETEuf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 00:50:35 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F5AC061A0E
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 21:50:35 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 62so1098519vsi.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 21:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tbXb80+Yh7B9nFEtfOBNTUNTV7zrMR7BziU+1EVuks=;
        b=ieZw2mYVxPGUlbMGmsKSDyXIuetO2Ee3KwdBkVCfJdW0WhP8FZb1ISRNsDfGSJPf4H
         cLI/9TyJktZdy21zfRpAJDZIAHqTkpg2Pl+yRFtsG6i7k+1ylzyb8cpXoyxzAFMOdr67
         bk9C5ntEWwCmqf5Q8Yjm30aenkNW5+iBSrOQ/ncL7T0dppuNhI8Igk+qtts3nR815zwb
         bpjJ/T0IiQ77tOaHpSYsgFZskxYM5iKzqi5M6aJn9Szm+lEycFQT/YmYytUSSSr1i0o1
         rk8X8puwnJxGbDHL6t0T+BiJJm3j3cKX10Y1NddXgGpJjjrQ/nCj0pU8CAzSmqaNiWhd
         qgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tbXb80+Yh7B9nFEtfOBNTUNTV7zrMR7BziU+1EVuks=;
        b=MhhDB9JfUktLGWnLKHxJ1W+8g/7geYWTGxFcpdl7souchg627mhD5HnFJvvVBWYjZX
         2t8T1wKrpcOcoiqiAgxr58vW6KPbSqNlpynV7qE0hocFRWLhmH1zWxFJPo/z2s5+vvN1
         7WvSBPMqtoU0JN6312vyVaM7AwBzktfkFSpxA9MwrTaELLRlRumfBvGwllSQonGzw27C
         iaUDCw2qqm2oIhyrwqkRPDbf7XJl5lnTmUe6/rljF68ddv9ko/uggFZ0ipBU48r6rwbS
         b+J7f5hC/6KsVdzWfySn/Tr52zyWkEJ5dtBzknuLckeEwhY/Q2c87vZ2MxLoIw416Wbo
         lO5A==
X-Gm-Message-State: AOAM530hxvIoSwCV8eSpJTMMOsA5m9j9jHIrZwP9N2mk95y9FKDFVYQX
        e6k8lcV4i3pn2vOAblPDzU4h/VwTPaphtAXUc97bUA==
X-Google-Smtp-Source: ABdhPJwheLQGbQZyi1vcJVRylkuX2iWXhDKV8oHh618SQR2OfCNSrC7LEYrmInHyZKW6ZI0YvvywcgI5RKWxpElGx08=
X-Received: by 2002:a67:b42:: with SMTP id 63mr1965745vsl.182.1589950234641;
 Tue, 19 May 2020 21:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com> <20200504181616.175477-6-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200504181616.175477-6-srinivas.pandruvada@linux.intel.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 20 May 2020 10:19:52 +0530
Message-ID: <CAHLCerOvQYbgQDFkA9-pfx-VTZB7KckXeJeFH3sodTgohpMq0g@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/5] thermal: int340x: Use new device interface
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
> Use the new framework to send notifications for:
> - Setting temperature threshold for notification to avoid polling
> - Send THERMAL_TRIP_REACHED event on reaching threshold
> - Send THERMAL_TRIP_UPDATE when firmware change the the existing trip
> temperature

I am a little confused here. I would've expected the thermal core to
send the THERMAL_TRIP_* notifications, not platform drivers. Why
shouldn't this be done in thermal core?

>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel/int340x_thermal/int3403_thermal.c   |  3 ++
>  .../int340x_thermal/int340x_thermal_zone.c    | 29 +++++++++++++++++++
>  .../int340x_thermal/int340x_thermal_zone.h    |  7 +++++
>  .../processor_thermal_device.c                |  1 +
>  4 files changed, 40 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> index f86cbb125e2f..77c014a113a4 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> @@ -63,15 +63,18 @@ static void int3403_notify(acpi_handle handle,
>
>         switch (event) {
>         case INT3403_PERF_CHANGED_EVENT:
> +               int340x_thermal_send_user_event(obj->int340x_zone, THERMAL_PERF_CHANGED, 0);
>                 break;
>         case INT3403_THERMAL_EVENT:
>                 int340x_thermal_zone_device_update(obj->int340x_zone,
>                                                    THERMAL_TRIP_VIOLATED);
> +               int340x_thermal_send_user_event(obj->int340x_zone, THERMAL_TRIP_REACHED, 0);
>                 break;
>         case INT3403_PERF_TRIP_POINT_CHANGED:
>                 int340x_thermal_read_trips(obj->int340x_zone);
>                 int340x_thermal_zone_device_update(obj->int340x_zone,
>                                                    THERMAL_TRIP_CHANGED);
> +               int340x_thermal_send_user_event(obj->int340x_zone, THERMAL_TRIP_UPDATE, 0);
>                 break;
>         default:
>                 dev_err(&priv->pdev->dev, "Unsupported event [0x%x]\n", event);
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 432213272f1e..9568a2db7afd 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -146,12 +146,41 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
>         return 0;
>  }
>
> +static int int340x_thermal_get_thres_low(struct thermal_zone_device *zone, int *temp)
> +{
> +       struct int34x_thermal_zone *d = zone->devdata;
> +
> +       *temp = d->aux_trips[0];
> +
> +       return 0;
> +}
> +
> +static int int340x_thermal_set_thres_low(struct thermal_zone_device *zone, int temp)
> +{
> +       struct int34x_thermal_zone *d = zone->devdata;
> +       acpi_status status;
> +
> +       if (d->override_ops && d->override_ops->set_trip_temp)
> +               return d->override_ops->set_trip_temp(zone, 0, temp);
> +
> +       status = acpi_execute_simple_method(d->adev->handle, "PAT0",
> +                       millicelsius_to_deci_kelvin(temp));
> +       if (ACPI_FAILURE(status))
> +               return -EIO;
> +
> +       d->aux_trips[0] = temp;
> +
> +       return 0;
> +}
> +
>  static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
>         .get_temp       = int340x_thermal_get_zone_temp,
>         .get_trip_temp  = int340x_thermal_get_trip_temp,
>         .get_trip_type  = int340x_thermal_get_trip_type,
>         .set_trip_temp  = int340x_thermal_set_trip_temp,
>         .get_trip_hyst =  int340x_thermal_get_trip_hyst,
> +       .set_temp_thres_low = int340x_thermal_set_thres_low,
> +       .get_temp_thres_low = int340x_thermal_get_thres_low,
>  };
>
>  static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> index 3b4971df1b33..142027e4955f 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> @@ -58,4 +58,11 @@ static inline void int340x_thermal_zone_device_update(
>         thermal_zone_device_update(tzone->zone, event);
>  }
>
> +static inline void int340x_thermal_send_user_event(
> +                                       struct int34x_thermal_zone *tzone,
> +                                       enum thermal_device_events event,
> +                                       u64 data)
> +{
> +       thermal_dev_send_event(tzone->zone->id, event, data);
> +}
>  #endif
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 297db1d2d960..e25f01948d33 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -340,6 +340,7 @@ static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
>                 proc_thermal_read_ppcc(proc_priv);
>                 int340x_thermal_zone_device_update(proc_priv->int340x_zone,
>                                 THERMAL_DEVICE_POWER_CAPABILITY_CHANGED);
> +               int340x_thermal_send_user_event(proc_priv->int340x_zone, THERMAL_PERF_CHANGED, 0);
>                 break;
>         default:
>                 dev_dbg(proc_priv->dev, "Unsupported event [0x%x]\n", event);
> --
> 2.25.4
>
