Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C521A1CB3
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 09:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgDHHbZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 03:31:25 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40345 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgDHHbZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 03:31:25 -0400
Received: by mail-ua1-f68.google.com with SMTP id a10so2328019uad.7
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2020 00:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCVp9cQtOdkPaCURq2lbHA0T3kiz0brcw8uKYGlf6rE=;
        b=GJyBXQjX1Zxk4QMXXm55+mVCa0T6jEynLfonSJhvT/PhtYJY5aHXll0K16TXLyYzxW
         wB2TYqrKi7jcrZs6mOOiL530et3RVXg5+vXx3v4/DT3FJAhEc64g+odV/VaUZTNgddsw
         06fEeBgcv3HLCy1NLRcuRaxVii7yS+OB8d+nwJ7h8Sy9I2O3rnAqftNuSdnf9xcU6PKU
         AEyK529xCrWBpMDN8b3r4zWYg2rDo0+YOFL6qb/8wd6EYmN6SmEMqYtcaIKQ8ADWX9qC
         xJ6g83KNqBNbeogF1wjE4tDrcbabIAiqN690IUMRi53qR8A3M0c93vQzDdJ2iL8InRPi
         JM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCVp9cQtOdkPaCURq2lbHA0T3kiz0brcw8uKYGlf6rE=;
        b=fVUfwzW1D0IMM6Q4ItCbD18qRk/BBKP5v3w35YBu1MikpjIwHeUJ4ZvWBpEIc7uJEB
         nhK43qXxJZpc+yp8IR2c/+p6JYs+Pi7tY5mM3lieckZZPCNNIO03tehOJCEy/dfcEzN9
         nkt8TtaaMX9+SmUDQyRb/34YytBrN9EtxmbfIsFhAwO6Dw1S394TkrbC3Oi2pGgKzE5p
         QKr9wyAxgn/FF3O4WUwFmqfB8xlUMhTgEAjGCBLvRV5gB+zxXtomrIv2p4kIGCGECjzr
         lQqSzbw0/hG5o7ryyboayhfEXtQpdmU51CB/+5enBvNyuVfdo3HHcCpk8IFGrch9oGiB
         2m+Q==
X-Gm-Message-State: AGi0PuYoqQmnOZJkthIhSammFqOw5jWUy4SwNxBp+iNZt/v9kAm5571H
        c4NC8myEvT3zD3hPOpNQyCWrELgqwIKQ188p9TSfBg==
X-Google-Smtp-Source: APiQypLd/k1ADI3b3/7gpiUW51OxpbWTZC3P4zU2FxImWXd0zUYVWWqtRdMeSEaxTnp+5juiZP/Es7UhrHsCpLo20M8=
X-Received: by 2002:ab0:608b:: with SMTP id i11mr4339623ual.94.1586331084097;
 Wed, 08 Apr 2020 00:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200407055116.16082-1-j-keerthy@ti.com> <20200407055116.16082-4-j-keerthy@ti.com>
In-Reply-To: <20200407055116.16082-4-j-keerthy@ti.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 8 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerN4m4um2w1rfKut=R8FX_maDfvLebRcyiSL+=FzJsp1zA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] arm64: dts: ti: am65-wakeup: Add VTM node
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

On Tue, Apr 7, 2020 at 11:21 AM Keerthy <j-keerthy@ti.com> wrote:
>
> VTM stands for voltage and thermal management.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index f4227e2743f2..98b89cf0ccdf 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -89,4 +89,11 @@
>                 clocks = <&k3_clks 59 0>;
>                 clock-names = "gpio";
>         };
> +
> +       wkup_vtm0: thermal@42050000 {
> +               compatible = "ti,am654-vtm";
> +               reg = <0x42050000 0x25c>;
> +               power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> +               #thermal-sensor-cells = <1>;
> +       };
>  };
> --
> 2.17.1
>
