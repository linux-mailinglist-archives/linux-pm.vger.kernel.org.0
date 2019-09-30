Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE594C1E60
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfI3JoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 05:44:21 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44176 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfI3JoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 05:44:20 -0400
Received: by mail-vs1-f67.google.com with SMTP id w195so6287703vsw.11
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8BTozkNMjXYnGvpiivu8GTcdHCRUJPKZ/tjC3wgpT0=;
        b=oTxh4MZgsxptPXRVclv9YCEHC8QBH9203XBeJgUhaxHwA4cDHCMXoCILDON1cads8S
         dvNaAO+5V5Lj16symCM+6YJcYcOBOIUEcugmXfWHDIS2/0md/kR5LbbzvMHWrzHnhUIf
         r6/AGQRoQ5n/LbNZmF2oRsY81tsnpHTCnny8jmVayNMsgdQwtj1u4BslLzLIQpbZZdFd
         O1ZHjCgyrFhdVNFDqQ4Uxxkx0olkLxZ5nG1nHZP3DOE10es5GUKDMDmMxR1waQPduiXr
         cy8bFjXXe9eRKdFCtZkxm9KUNC/I+I5/A/BjPGOye5juhaBgZr3HXLsh3qUCmVshdJYl
         nJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8BTozkNMjXYnGvpiivu8GTcdHCRUJPKZ/tjC3wgpT0=;
        b=IFod/1r+Q/GAEsAPsL0rUPQ2++pWkI13C9MOiKouPsBsWMM8yvGNdsce+DzLNaKdqA
         WNgv7VaM/IHs7/06TH/9H/F/OBkbZpdfwYYokuPfb6Cxu+K3EN9OohQpY/MxzUWdAyNF
         C+PHKsE8pGV8VZYQUtqt99AjvZaZKga1gV+3l4r52wMRSFI+ejL6elbADMAilUwGwqpr
         Y7dkewZN4cX2d5fOx8MjohEmZ+FNO0/Qijla8ykV0WyCkE5A/ILs1dwfsMBCCoYDbdey
         NpbUn7rSGgTlx7pxFpfSrVXLi4MfrNwufbe3D0f/ltZA6HiOrTMlSCC1jrbZs2mAQwz/
         MHnw==
X-Gm-Message-State: APjAAAWyrCq1NWl5pxchP4tg1k4ot92jz5NpMcE1od4rF9BMYVkqZAkH
        WsDTXkkD30aIJW5PguOI1ljr9wA/yp3tnr/+StGvsg==
X-Google-Smtp-Source: APXvYqwzrnQd5kSt976vsQTkY4fUZ0N6Cbb1QL+RprZHbapHmEx/KojW4obEsKRRN3dduvxef0Xir2Er2izaiA/bEpI=
X-Received: by 2002:a67:d789:: with SMTP id q9mr8481036vsj.159.1569836658112;
 Mon, 30 Sep 2019 02:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190927184352.28759-1-glaroque@baylibre.com> <20190927184352.28759-5-glaroque@baylibre.com>
In-Reply-To: <20190927184352.28759-5-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 30 Sep 2019 15:14:07 +0530
Message-ID: <CAHLCerOuY1cLrkN9_f1O+Uqm9fyE18+98yU6xryojcznuPMZow@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] arm64: dts: meson: g12: Add minimal thermal zone
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

On Sat, Sep 28, 2019 at 12:14 AM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Add minimal thermal zone for two temperature sensor
> One is located close to the DDR and the other one is
> located close to the PLLs (between the CPU and GPU)
>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 0660d9ef6a86..f98171949fcb 100644
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
> @@ -94,6 +95,50 @@
>                 #size-cells = <2>;
>                 ranges;
>
> +               thermal-zones {
> +                       cpu_thermal: cpu-thermal {
> +                               polling-delay = <1000>;
> +                               polling-delay-passive = <100>;
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

critical instead of hot? What is the SoC's critical shutdown temperature?

Typically, you would use 'hot' at the beginning of at up trend e.g. at
75000, 'passive' to start throttling and 'critical' for shutdown
temperature.

> +                                       };
> +
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
> @@ -2412,6 +2457,7 @@
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
