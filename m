Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9650319E34E
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 09:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDDHb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 03:31:28 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36609 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgDDHb2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 03:31:28 -0400
Received: by mail-ua1-f67.google.com with SMTP id m15so2875970uao.3
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2020 00:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXNBeLfM6R3R19w3bxqedjhSw7Yhw0sbY/Bu8wxHhNM=;
        b=K9YbTwiiwL/a4VLDnpu5F3Hq8KeS8sp2Bogf3BWS8wg6wCIlaDysaRLwg2ST82QLUR
         nUQpTR/v1zRda+156B0X8ftbXO2WUt6H26B8+4YfKy43SMkveIuOnbwDuihA4edy+PzM
         WW2xHUZjnYmwUS4RJwf7/q8cV3nzbsfFQi+xqKtsIDuKJl2qsk3YdmCkxBoe96HfyzVa
         hOha+K3Crr31w3B/0eXDmTQwhbr5xXgEP+GwVrdbJsaTPImW/qnL6DZUfMwMnUOvDNR/
         LkImfM5LUM0Vzas4XekGUg8OljE0XwgWF4krPz/WrqRzhqyYCJwwfVpRBIaC81uGjvgf
         k1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXNBeLfM6R3R19w3bxqedjhSw7Yhw0sbY/Bu8wxHhNM=;
        b=pC3bhxiUtk28TqYfcFp2LCvtY+OAdxj6g+tlukkEevEis8wHWOVyTRdfzu523pa21d
         0lgyhdaCwpX1AyPRSaq8q2MuSO+mO/XRAZPCNt7TlhjfcqPSB7c/Qllv98Iq37Pt8efL
         XMRbqY4OIJu9Jbf+wCaTrIsMeYjRO25vgBHZR25y+Zi4iyM5sKoVjFUC//rtGT6O3fof
         i+V+XCcXLs/RtCPPmU26nAm29tIylO5H1MEp2rvIr1tx3YrPdkjtFucezGKfkfthrqIX
         K6Pymept7/lRG8SzV0XA/zQ6o1RrsmFSb1kf2hbDczpf2rHZ90CRN3B26uZrUS4MgtI+
         kaUA==
X-Gm-Message-State: AGi0PubbALSCstDhXtpfNfA4Yxrby+1ieBMQ4SxErsJzSaZL3JnDKdak
        JWQASl95p0TnzsJjfT0R46+6yy6n2nPRHvkSCnrAAA==
X-Google-Smtp-Source: APiQypIq2cyCGz5JZIv/r8tGEb/BpinV5GrEfcNrT3/vbI5ddO5WB/a7RzCBv4uPhl0soQO+cllbNeAjHq87RdpoFB0=
X-Received: by 2002:ab0:70d9:: with SMTP id r25mr9801332ual.67.1585985486878;
 Sat, 04 Apr 2020 00:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerOXZBA9aoH0Ef9tzcsSnKAQUKwuaCNOyJTakf6uCG+11A@mail.gmail.com>
Subject: Re: [PATCH V2 1/9] thermal: Move default governor config option to
 the internal header
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 2, 2020 at 7:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The default governor set at compilation time is a thermal internal
> business, no need to export to the global thermal header.
>
> Move the config options to the internal header.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.h | 11 +++++++++++
>  include/linux/thermal.h        | 11 -----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 37cd4e2bead2..828305508556 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -12,6 +12,17 @@
>  #include <linux/device.h>
>  #include <linux/thermal.h>
>
> +/* Default Thermal Governor */
> +#if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
> +#define DEFAULT_THERMAL_GOVERNOR       "step_wise"
> +#elif defined(CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE)
> +#define DEFAULT_THERMAL_GOVERNOR       "fair_share"
> +#elif defined(CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE)
> +#define DEFAULT_THERMAL_GOVERNOR       "user_space"
> +#elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
> +#define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
> +#endif
> +
>  /* Initial state of a cooling device during binding */
>  #define THERMAL_NO_TARGET -1UL
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 448841ab0dca..71cff87dcb46 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -32,17 +32,6 @@
>  /* use value, which < 0K, to indicate an invalid/uninitialized temperature */
>  #define THERMAL_TEMP_INVALID   -274000
>
> -/* Default Thermal Governor */
> -#if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
> -#define DEFAULT_THERMAL_GOVERNOR       "step_wise"
> -#elif defined(CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE)
> -#define DEFAULT_THERMAL_GOVERNOR       "fair_share"
> -#elif defined(CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE)
> -#define DEFAULT_THERMAL_GOVERNOR       "user_space"
> -#elif defined(CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR)
> -#define DEFAULT_THERMAL_GOVERNOR       "power_allocator"
> -#endif
> -
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
>  struct thermal_instance;
> --
> 2.17.1
>
