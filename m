Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7590123E8A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 05:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLREcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 23:32:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39226 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLREcq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 23:32:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id t17so526180eds.6;
        Tue, 17 Dec 2019 20:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxXoTov4PUhak7sIA8LFPrnn1qIL741x3U+CG+v//Qw=;
        b=PNJta5Nbqz67l+WfhJ6q8Hot49W1YJI3LfoAodLMJ9jxNdbMTThclATAbmQt21wZmX
         EmDbMYWNpTGzX1ZxASUlKciAg7L+OYdc97TgyUwSPB4AutoIZTQKPq57RoQtNZEueTFv
         ygygcdU1ehN1dErxudWjmjIkFkVRh7K0547ilqVDO4s6OQMUQwtmFILiXpwFItTD0JIx
         XjhWHOETRaJsTQwCOZiyRK91Af7Dvl8L4mH5T9ddlqPkiLAMm5RMRUsHq125azJXGTfR
         qsuDH2i/v6BTMtAjfYFH/IB4aCIncbe9qwMEDiiToPO5UH6FcOg2dnh8izqq690+LtXy
         DHYQ==
X-Gm-Message-State: APjAAAWseG4+CgKzGpkprtsiMI5HdKvY3Bd42t7JEUtpd4neYZPuFOwa
        Tl+pQpRjbywaVuc5jG1N1Ggfu1nC2dHTcQ==
X-Google-Smtp-Source: APXvYqxbDar5Y+D0iq8/mBc90fzADfN2yGwp15w25xEJFvab/xogfnZvY6TscEI+mddrcsgGZIOMGA==
X-Received: by 2002:a50:cd11:: with SMTP id z17mr73942edi.178.1576643563770;
        Tue, 17 Dec 2019 20:32:43 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id q3sm47486eju.88.2019.12.17.20.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 20:32:43 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id d73so370028wmd.1;
        Tue, 17 Dec 2019 20:32:43 -0800 (PST)
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr573630wmg.110.1576643562884;
 Tue, 17 Dec 2019 20:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20191218042121.1471954-1-anarsoul@gmail.com> <20191218042121.1471954-7-anarsoul@gmail.com>
In-Reply-To: <20191218042121.1471954-7-anarsoul@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 18 Dec 2019 12:32:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Qv6_KQ_MPg0u37P+o5gnnQWhbifOrY6g5FiWvnadmiw@mail.gmail.com>
Message-ID: <CAGb2v65Qv6_KQ_MPg0u37P+o5gnnQWhbifOrY6g5FiWvnadmiw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] arm64: dts: allwinner: h6: Add thermal sensor and
 thermal zones
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 18, 2019 at 12:22 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> There are two sensors, one for CPU, one for GPU.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 29824081b43b..cdcb1a36301a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/reset/sun50i-h6-ccu.h>
>  #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
>  #include <dt-bindings/reset/sun8i-de2.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         interrupt-parent = <&gic>;
> @@ -233,6 +234,12 @@ dma: dma-controller@3002000 {
>                 sid: efuse@3006000 {
>                         compatible = "allwinner,sun50i-h6-sid";
>                         reg = <0x03006000 0x400>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       ths_calibration: thermal-sensor-calibration@14 {
> +                               reg = <0x14 0x6>;

Nit: my preference is to use words as the smallest increment, so this
would have a size of 8 instead of 6. Same goes for the A64 dts.

AFAICT this doesn't impact the driver in any way.

ChenYu


> +                       };
>                 };
>
>                 watchdog: watchdog@30090a0 {
> @@ -856,5 +863,31 @@ r_i2c: i2c@7081400 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                 };
> +
> +               ths: thermal-sensor@5070400 {
> +                       compatible = "allwinner,sun50i-h6-ths";
> +                       reg = <0x05070400 0x100>;
> +                       interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_THS>;
> +                       clock-names = "bus";
> +                       resets = <&ccu RST_BUS_THS>;
> +                       nvmem-cells = <&ths_calibration>;
> +                       nvmem-cell-names = "calibration";
> +                       #thermal-sensor-cells = <1>;
> +               };
> +       };
> +
> +       thermal-zones {
> +               cpu-thermal {
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&ths 0>;
> +               };
> +
> +               gpu-thermal {
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&ths 1>;
> +               };
>         };
>  };
> --
> 2.24.1
>
