Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8417D8462
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 01:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbfJOXUo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 19:20:44 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36263 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfJOXUo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 19:20:44 -0400
Received: by mail-vs1-f66.google.com with SMTP id v19so14368754vsv.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Luzeu61JUpCQk5lttonbL70KSFby5OvdNNxzg/MFQ8=;
        b=eDOzDhVMybk0i/+feqo0X+49gsS5JqJW8Ry8hE/JpXVc3WdVLD8WqJn9dDxRuwCehy
         QvBk66yW4mH2kDlYuzMBwPUkP7IEFj9ZOCyD/4jTGGzyqm14Z6beV+SiRvogqh3bul4S
         iB5C2XFuK7HRXnTP1fLCtCvORAdxwIVNNPgEfK7/yPQBrFJLj5U8IlVLAnGbma2My+bA
         WBSOGcGHMJNm8DROoKh3HDAVOdcniv422vxJwA1eHO+j7o/CCl3KJUcbsWYelqWlID+T
         ADHbasV+eQpUbByIGOW8dLaZ/+35eAnKAiGRw80ERMmbEtCmUY0OfB7tcC1PPQ9bI1JZ
         KYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Luzeu61JUpCQk5lttonbL70KSFby5OvdNNxzg/MFQ8=;
        b=RlWn+4WUF2F0aUqFiuWrsAv/tM23+8cSBoGvexx/VAxtOsrqteecLLD270iR8OMexa
         rPKX8BeNDO31xo4KCSha+sXgUvJSGj02Jjc60FgSTCgrt63SVNi1zWrfPjNUvzz72seZ
         vKqfOSL3QMXzUf4ANJfPkx4PBQKP/ymrTA39HtwYCEESwEZloGgI6I9G4xMOVRnkmoS+
         mC8deHTB+fGP+nr066BxEddcmxnw6VkWtYNwnG/GO2G9+YBiGGQ0xnfS3je2kNoBUkAM
         Pgr1wY8ZHa1D4yo/8l+Mw4r5VPbR4elr0IIlCq4bz1HN18MoAnvb7iTlT0j40JcDz3wO
         EU2Q==
X-Gm-Message-State: APjAAAVyMNGUnlWkdB5uY4QoELvoVkwSTBEgUkfnW/zogJ6K/PurytGt
        xvFPvuYDbx1w4PgNSfekHLUMBC8Gn+jbztXd1Ic/0A==
X-Google-Smtp-Source: APXvYqygrun7u9zevVDKfu0sa7amxsriNbVYF4wbVRpuSP6Re4yc+jB0Mmyyr6iQQ2WpPrkisEClAIRglX6AbvGsZDk=
X-Received: by 2002:a67:dc16:: with SMTP id x22mr1767729vsj.159.1571181642542;
 Tue, 15 Oct 2019 16:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191004090114.30694-1-glaroque@baylibre.com> <20191004090114.30694-5-glaroque@baylibre.com>
In-Reply-To: <20191004090114.30694-5-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 16 Oct 2019 04:50:31 +0530
Message-ID: <CAHLCerOzZ6kc0nrGL+XMi37WuBKUv6E0yzE26wUZ5XoRMS8q6w@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] arm64: dts: meson: g12: Add minimal thermal zone
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 4, 2019 at 2:31 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Add minimal thermal zone for two temperature sensor
> One is located close to the DDR and the other one is
> located close to the PLLs (between the CPU and GPU)
>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 0660d9ef6a86..a98c16e163c2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>  #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         interrupt-parent = <&gic>;
> @@ -94,6 +95,61 @@
>                 #size-cells = <2>;
>                 ranges;
>
> +               thermal-zones {
> +                       cpu_thermal: cpu-thermal {
> +                               polling-delay = <1000>;
> +                               polling-delay-passive = <100>;

Ordinarily, you would need to set these delays to 0 in interrupt mode
to prevent polling overhead. I've just submitted a patch to of-thermal
that should fix this requirement. Could you check if it works for you?

> +                               thermal-sensors = <&cpu_temp>;
> +
> +                               trips {
> +                                       cpu_passive: cpu-passive {
> +                                               temperature = <85000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "passive";
> +                                       };
> +
> +                                       cpu_hot: cpu-hot {
> +                                               temperature = <95000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "hot";
> +                                       };
> +
> +                                       cpu_critical: cpu-critical {
> +                                               temperature = <110000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "critical";
> +                                       };
> +                               };
> +                       };
> +
> +                       ddr_thermal: ddr-thermal {
> +                               polling-delay = <1000>;
> +                               polling-delay-passive = <100>;
> +                               thermal-sensors = <&ddr_temp>;
> +
> +                               trips {
> +                                       ddr_passive: ddr-passive {
> +                                               temperature = <85000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "passive";
> +                                       };
> +
> +                                       ddr_critical: ddr-critical {
> +                                               temperature = <110000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "critical";
> +                                       };
> +                               };
> +
> +                               cooling-maps {
> +                                       map {
> +                                               trip = <&ddr_passive>;
> +                                               cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
>                 ethmac: ethernet@ff3f0000 {
>                         compatible = "amlogic,meson-axg-dwmac",
>                                      "snps,dwmac-3.70a",
> @@ -2412,6 +2468,7 @@
>                         assigned-clock-rates = <0>, /* Do Nothing */
>                                                <800000000>,
>                                                <0>; /* Do Nothing */
> +                       #cooling-cells = <2>;
>                 };
>         };
>
> --
> 2.17.1
>
