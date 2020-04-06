Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC3219FDD2
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 21:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgDFTEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 15:04:30 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40038 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDFTEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 15:04:30 -0400
Received: by mail-ua1-f66.google.com with SMTP id a10so356590uad.7
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2020 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKSOuUapGnWf3Hq2VKiORYvF7/gi1e0olK/3vh44kQQ=;
        b=bOB0LqZRTfAo6bdJQM33HQTyFUvLOR2z0Foi8Jb7TOSz1Og4RBWGZeKA4kZ/KpEEAp
         lAEpgpzt0q6aG5DTLjV4xRZnSYIp0ZzUTqyGwsDsiCON6vSw4wMh362yvErfWIEjIFtE
         Wa+l+6HD1L6snPqXyu03v/xIPeJB9BnUfoLrY6RgTLjRXZdnoRb04+OZOWBvFSzLCXmG
         Lczq/lgonbLYzFjzZZBUwzc41Ae9iurYnVUxNbq3GDCxYejuuHJkSx8X/MQ2/WEHfbVC
         Y/gPn+28cj89NxAFAFKPa/J8wNu1zga0PppWe0Z6j9DtuYOUV0tBIJCUQnHtf0qtUtqy
         mRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKSOuUapGnWf3Hq2VKiORYvF7/gi1e0olK/3vh44kQQ=;
        b=CNVPwuCBdRUwCJbKLSlxsKyXXwFGTUu0ZrHXnZ71OL0VL7HF+2PjNxFEJVEZdn+wiR
         FynkgLVczUWB9taBJnL8O1pcfHTA7kuVFhZ2E5fpERQZZx1RJckDUqCF8O5RsIT9U6WW
         Sgnx0y/b4eMyEn0U0qtnHSn5tsaDAD2oVG97jgdnXD8yCHiLfDWayAQ8o7ep6nmutE2y
         3krhvNJq4TMc8xveFh77iT+XaSx3feCp1VGblLcMwBcpxv+CoibNmlZhR1LPW44A2G6K
         VLGF4UAO14p8hSKXo8SY9TO0t/SWovkDqJP1DjeLP5xyEmxJNqiU3mwuqp6N1RtW0DH+
         H0Yw==
X-Gm-Message-State: AGi0PuYyAPiTkw+hkj3CqnZZbwrZujvBLNDN9IJ6RBfMRyCZh/TTYpJY
        LHRGovz/qoQDD3/GeChPvoCRVkJaSEf36Pl4x0of7A==
X-Google-Smtp-Source: APiQypIK/YDmw7c24JNIRU7dH38DelSt/uLu7XVUJgDjKlcvdhZlf2ykNjo+z5hkGjCXR2mqiEa0SbEjT9HPUmZGtmU=
X-Received: by 2002:ab0:5f90:: with SMTP id b16mr805358uaj.77.1586199867533;
 Mon, 06 Apr 2020 12:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200331075356.19171-1-j-keerthy@ti.com> <20200331075356.19171-4-j-keerthy@ti.com>
In-Reply-To: <20200331075356.19171-4-j-keerthy@ti.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 7 Apr 2020 00:34:16 +0530
Message-ID: <CAHLCerP3usTcNeRwGekWG6xGdAQedZfoegtfsda8O-OHW9i-oQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] arm64: dts: ti: am654: Add thermal zones
To:     Keerthy <j-keerthy@ti.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, t-kristo@ti.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 31, 2020 at 1:24 PM Keerthy <j-keerthy@ti.com> wrote:
>
> The am654 SoC has three thermal zones namely MPU0, MPU1 and MCU
> zones
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../dts/ti/k3-am654-industrial-thermal.dtsi   | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> new file mode 100644
> index 000000000000..cdc3d40c3f60
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +mpu0_thermal: mpu0_thermal {
> +       polling-delay-passive = <250>; /* milliseconds */
> +       polling-delay = <500>; /* milliseconds */
> +       thermal-sensors = <&wkup_vtm0 0>;

You are referencing the wkup_vtm0 node before defining it in the next patch.

Swap the order of the patches and move the include for thermal zones
to this patch.

> +
> +       trips {
> +               mpu0_crit: mpu0_crit {
> +                       temperature = <125000>; /* milliCelsius */
> +                       hysteresis = <2000>; /* milliCelsius */
> +                       type = "critical";
> +               };
> +       };
> +};
> +
> +mpu1_thermal: mpu1_thermal {
> +       polling-delay-passive = <250>; /* milliseconds */
> +       polling-delay = <500>; /* milliseconds */
> +       thermal-sensors = <&wkup_vtm0 1>;
> +
> +       trips {
> +               mpu1_crit: mpu1_crit {
> +                       temperature = <125000>; /* milliCelsius */
> +                       hysteresis = <2000>; /* milliCelsius */
> +                       type = "critical";
> +               };
> +       };
> +};
> +
> +mcu_thermal: mcu_thermal {
> +       polling-delay-passive = <250>; /* milliseconds */
> +       polling-delay = <500>; /* milliseconds */
> +       thermal-sensors = <&wkup_vtm0 2>;
> +
> +       trips {
> +               mcu_crit: mcu_crit {
> +                       temperature = <125000>; /* milliCelsius */
> +                       hysteresis = <2000>; /* milliCelsius */
> +                       type = "critical";
> +               };
> +       };
> +};
> --
> 2.17.1
>
