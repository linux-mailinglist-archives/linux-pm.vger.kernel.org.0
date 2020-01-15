Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF61613B949
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 06:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgAOF6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 00:58:14 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38951 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOF6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 00:58:14 -0500
Received: by mail-ua1-f65.google.com with SMTP id 73so5809026uac.6
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 21:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5xJRkqeZeVuqWjzuTjcTAvJI4fzZrcr+Isw3uqYLKg=;
        b=o+vsV3oMBFRJ1mv7DjQiU8XPXWxqrhMJgML2HsKufa6V56I+MLrFTdPDjwZPSsgTGb
         RPljyQh7++xAIXl+sjGHAcqYF7B8DzcB6Oo1DobaDz5W3DISZkeQpCFAmjS/FVTzaYfX
         Lv4sSGxgPS+oxOZUR98FZokoBK0xXYuvPjAG/rV/Q+TOE5lOD9un0NuMfpcsCn3ySND0
         AihW5IkU4QPEm66XCcNbaNWP82U5XaVpK/uGPVa4LI14xAFQVafishSL6JyPxtozxAgL
         5lw5wlrwYUp0QXBNutVanw8TNPbMb5mYYPFGp1yOm9cZ2Inl7eOyR6eD7frdc9XswOGW
         sY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5xJRkqeZeVuqWjzuTjcTAvJI4fzZrcr+Isw3uqYLKg=;
        b=aBUEFBP0+liyDH4aRJ4DVL8BKYVVpAK/5HyM3rMe51xl7hO+nNcDU6S65JJM9Me0pD
         VETQVR1pMIm6loUwrLx6/gQU9Y/vp+20sW9WeLoUFh51Hs8RyScnvJFAnW+5Hbd5mGoP
         yn/6TrZPiqYxDkrr7sGCNEkiA5CjwY0NKGBvco0o2m6yzk3QZu8TJyNSBrEl6BmLhLAP
         wu3oRGOXTjpdQBjVoxvi+yp5sM2fiYlEIsP9zAqOs8rmrapYDqOBzEvG09PaIbvJPVDm
         sx8fofSmJtGbLBl284moU/pGmaMP/A/bQnMulRjjXc/+7LyvhdBdtnwfMnaZ2fLMH2U9
         yUkw==
X-Gm-Message-State: APjAAAVDbpp5Sgq3XhJj8gJEayu8O7VExHeIRDF+ceHcm4XqTbk7QSoz
        xM6onzb4eEWa0CxbCyB/veW10/Brxabyk9K+QQIwwQ==
X-Google-Smtp-Source: APXvYqyHRDquLaL0bEm7oQ9JtTMteQmR4X4JG9yvX/H3A2qtA1O/wnBD9raOEACyIMcJLv3MZehD7pa6uUYuo68Tdw4=
X-Received: by 2002:ab0:2252:: with SMTP id z18mr12952463uan.60.1579067893051;
 Tue, 14 Jan 2020 21:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20200114190607.29339-1-f.fainelli@gmail.com> <20200114190607.29339-2-f.fainelli@gmail.com>
In-Reply-To: <20200114190607.29339-2-f.fainelli@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 15 Jan 2020 11:28:02 +0530
Message-ID: <CAHLCerO1OARY9OMDpGudSfBdmtRfeP_pYaE9=-Sn-10ZVjgXKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] thermal: brcmstb_thermal: Do not use DT coefficients
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 15, 2020 at 12:36 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> At the time the brcmstb_thermal driver and its binding were merged, the
> DT binding did not make the coefficients properties a mandatory one,
> therefore all users of the brcmstb_thermal driver out there have a non
> functional implementation with zero coefficients. Even if these
> properties were provided, the formula used for computation is incorrect.
>
> The coefficients are entirely process specific (right now, only 28nm is
> supported) and not board or SoC specific, it is therefore appropriate to
> hard code them in the driver given the compatibility string we are
> probed with which has to be updated whenever a new process is
> introduced.
>
> We remove the existing coefficients definition since subsequent patches
> are going to add support for a new process and will introduce new
> coefficients as well.
>
> Fixes: 9e03cf1b2dd5 ("thermal: add brcmstb AVS TMON driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 31 +++++++---------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 5825ac581f56..680f1a070606 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -49,7 +49,7 @@
>  #define AVS_TMON_TP_TEST_ENABLE                0x20
>
>  /* Default coefficients */
> -#define AVS_TMON_TEMP_SLOPE            -487
> +#define AVS_TMON_TEMP_SLOPE            487
>  #define AVS_TMON_TEMP_OFFSET           410040
>
>  /* HW related temperature constants */
> @@ -108,23 +108,12 @@ struct brcmstb_thermal_priv {
>         struct thermal_zone_device *thermal;
>  };
>
> -static void avs_tmon_get_coeffs(struct thermal_zone_device *tz, int *slope,
> -                               int *offset)
> -{
> -       *slope = thermal_zone_get_slope(tz);
> -       *offset = thermal_zone_get_offset(tz);
> -}
> -
>  /* Convert a HW code to a temperature reading (millidegree celsius) */
>  static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
>                                         u32 code)
>  {
> -       const int val = code & AVS_TMON_TEMP_MASK;
> -       int slope, offset;
> -
> -       avs_tmon_get_coeffs(tz, &slope, &offset);
> -
> -       return slope * val + offset;
> +       return (AVS_TMON_TEMP_OFFSET -
> +               (int)((code & AVS_TMON_TEMP_MAX) * AVS_TMON_TEMP_SLOPE));
>  }
>
>  /*
> @@ -136,20 +125,18 @@ static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
>  static inline u32 avs_tmon_temp_to_code(struct thermal_zone_device *tz,
>                                         int temp, bool low)
>  {
> -       int slope, offset;
> -
>         if (temp < AVS_TMON_TEMP_MIN)
> -               return AVS_TMON_TEMP_MAX; /* Maximum code value */
> -
> -       avs_tmon_get_coeffs(tz, &slope, &offset);
> +               return AVS_TMON_TEMP_MAX;       /* Maximum code value */
>
> -       if (temp >= offset)
> +       if (temp >= AVS_TMON_TEMP_OFFSET)
>                 return 0;       /* Minimum code value */
>
>         if (low)
> -               return (u32)(DIV_ROUND_UP(offset - temp, abs(slope)));
> +               return (u32)(DIV_ROUND_UP(AVS_TMON_TEMP_OFFSET - temp,
> +                                         AVS_TMON_TEMP_SLOPE));
>         else
> -               return (u32)((offset - temp) / abs(slope));
> +               return (u32)((AVS_TMON_TEMP_OFFSET - temp) /
> +                             AVS_TMON_TEMP_SLOPE);
>  }
>
>  static int brcmstb_get_temp(void *data, int *temp)
> --
> 2.17.1
>
