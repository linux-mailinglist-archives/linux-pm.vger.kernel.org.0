Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A05AAD9F5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfIIN0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 09:26:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43169 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfIIN0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 09:26:47 -0400
Received: by mail-io1-f66.google.com with SMTP id r8so3670276iol.10;
        Mon, 09 Sep 2019 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QrvTgDBPfO8J43uuG+xyKU6BSCSttgg3QXWovfY3JrI=;
        b=LSfkK6xrKGGSWNRB7mt8N3xrf3su1VSMOh8J8xvmassLxPuuzQhrxYlnkq/i8//yWi
         1hvzbBo3DKs85RoQ/QwfU5lsLefLHZtaeS+rvXbp5EypFcF4qpPVNdJtu1cU/JfJC3zS
         rzgTdOiv0COjybPWmDelck4jcWuiYuv45jE1aLEvrRJ24cWzXsoOg7Lq1PMhCC0xWAf2
         Oln1e5RkhfUm3ADTa/VrY5/jBiZlckIO1CRkufjHMv9HZJYNxXTmBSbiZc06k1szuq0Q
         HVrmAuJ66S6O7oJg6rlRTLC79X4XjMnJ3qLq2Ht+yd8SXJc+vc72A7fY+ZbrSGyM9TgA
         1GlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QrvTgDBPfO8J43uuG+xyKU6BSCSttgg3QXWovfY3JrI=;
        b=qP1n+Uk0GCO1EtdRM9HWgVcGTJ874B8x9LA9DRfeiVLlksQav0M9ZlSo+fxrCmMHc/
         nkcsOk03afN19MGWA6malp/jga+SWYD1ENsUqHJopK7TtpHOXTJJyfQ50fqF0dlnEHVD
         NBDtkgojajRzdzWTFThLCFGxkD6M9xZINsfhC5wR1BCRcAQX9ZIkz7STRJZr2345sKK1
         OlAh6kdvM5IUvgCGHVmBuUsQ6aXTBgoVBkMaFYGhgvaBKXqc+puAHMRoCXGzuCWVvOsI
         7L1eBaxEaxeYMmk+GuVCGNecbyX5KbO6hXTQSuukUpUhdHv+gbgM9+0cpJRc7FxGs79B
         fnhw==
X-Gm-Message-State: APjAAAVwUGza2D3lXl8lQOA1KYfTqEOJ03qGkk3EVpkfyqag+98Bd4uF
        4+cuHk0WQGuHatPZjtGrsk1/yUmRr59Q/6fHkdY=
X-Google-Smtp-Source: APXvYqzTIVOWyRxV0NEkDCkD1DEs97cqaV7H2Lic+wSMp+2Mc6TJ2uFSQQ3Jnnv58gk0e46phTj8RKSX8aDTggGdVdQ=
X-Received: by 2002:a5e:de47:: with SMTP id e7mr15899786ioq.127.1568035604756;
 Mon, 09 Sep 2019 06:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567878413.git.hns@goldelico.com> <8f002b26667b91b0d13771e5a17535075e82b343.1567878413.git.hns@goldelico.com>
In-Reply-To: <8f002b26667b91b0d13771e5a17535075e82b343.1567878413.git.hns@goldelico.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 9 Sep 2019 08:26:32 -0500
Message-ID: <CAHCN7xL_cbfVwyS3qHpiiC8phRf7fy4VXB4ES_dtx87Asw-9AA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: omap3: bulk convert compatible to be
 explicitly ti,omap3430 or ti,omap3630 or ti,am3517
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Sep 7, 2019 at 12:47 PM H. Nikolaus Schaller <hns@goldelico.com> wr=
ote:
>
> For the ti-cpufreq driver we need a clear separation between omap34 and o=
map36 families
> since they have different silicon revisions and efuses.
>
> So far ti,omap3630/ti,omap36xx is just an additional flag to ti,omap3 whi=
le omap34 has no
> required entry.
>
> Therefore we can not match omap34 boards properly.
>
> This needs to add ti,omap3430 and ti,omap3630 where it is missing.
>
> We also clean up some instances of missing ti,am3517 so that we can rely =
on
> seeing either one of:
>
> ti,am3517
> ti,omap3430
> ti,omap3630
>
> in addition to ti,omap3.
>
> We leave ti,omap34xx and ti,omap36xx untouched for compatibility.
>
> The script to do the conversion is:
>
> manually fix am3517_mt_ventoux.dts
> find arch/arm/boot/dts -name '*.dts*' -exec fgrep -q '"ti,omap34xx"' {} \=
; ! -exec fgrep -q '"ti,omap3430"' {} \; -exec sed -i '' 's/"ti,omap34xx"/"=
ti,omap3430", "ti,omap34xx"/' {} \;
> find arch/arm/boot/dts -name '*.dts*' -exec fgrep -q '"ti,omap36xx"' {} \=
; ! -exec fgrep -q '"ti,omap3630"' {} \; -exec sed -i '' 's/"ti,omap36xx"/"=
ti,omap3630", "ti,omap36xx"/' {} \;
> find arch/arm/boot/dts \( -name 'omap*.dts*' -o -name 'logic*.dts*' \) -e=
xec fgrep -q '"ti,omap3"' {} \; ! -exec fgrep -q '"ti,omap3630"' {} \; ! -e=
xec fgrep -q '"ti,omap36xx"' {} \; ! -exec fgrep -q '"ti,am3517"' {} \; ! -=
exec fgrep -q '"ti,omap34xx"' {} \; ! -exec fgrep -q '"ti,omap3430"' {} \; =
-exec sed -i '' 's/"ti,omap3"/"ti,omap3430", "ti,omap3"/' {} \;
>
> So if your out-of-tree omap3 board does not show any OPPs, please check
> the compatibility entry and update if needed.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/am3517_mt_ventoux.dts            | 2 +-
>  arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts   | 2 +-
>  arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts  | 2 +-
>  arch/arm/boot/dts/omap3-beagle-xm.dts              | 2 +-
>  arch/arm/boot/dts/omap3-beagle.dts                 | 2 +-
>  arch/arm/boot/dts/omap3-cm-t3530.dts               | 2 +-
>  arch/arm/boot/dts/omap3-cm-t3730.dts               | 2 +-
>  arch/arm/boot/dts/omap3-devkit8000-lcd43.dts       | 2 +-
>  arch/arm/boot/dts/omap3-devkit8000-lcd70.dts       | 2 +-
>  arch/arm/boot/dts/omap3-devkit8000.dts             | 2 +-
>  arch/arm/boot/dts/omap3-gta04.dtsi                 | 2 +-
>  arch/arm/boot/dts/omap3-ha-lcd.dts                 | 2 +-
>  arch/arm/boot/dts/omap3-ha.dts                     | 2 +-
>  arch/arm/boot/dts/omap3-igep0020-rev-f.dts         | 2 +-
>  arch/arm/boot/dts/omap3-igep0020.dts               | 2 +-
>  arch/arm/boot/dts/omap3-igep0030-rev-g.dts         | 2 +-
>  arch/arm/boot/dts/omap3-igep0030.dts               | 2 +-
>  arch/arm/boot/dts/omap3-ldp.dts                    | 2 +-
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi            | 2 +-
>  arch/arm/boot/dts/omap3-lilly-dbb056.dts           | 2 +-
>  arch/arm/boot/dts/omap3-n9.dts                     | 2 +-
>  arch/arm/boot/dts/omap3-n950.dts                   | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-alto35.dts     | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-gallop43.dts   | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-palo35.dts     | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-palo43.dts     | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-summit.dts     | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts    | 2 +-
>  arch/arm/boot/dts/omap3-pandora-1ghz.dts           | 2 +-
>  arch/arm/boot/dts/omap3-sbc-t3530.dts              | 2 +-
>  arch/arm/boot/dts/omap3-sbc-t3730.dts              | 2 +-
>  arch/arm/boot/dts/omap3-sniper.dts                 | 2 +-
>  arch/arm/boot/dts/omap3-thunder.dts                | 2 +-
>  arch/arm/boot/dts/omap3-zoom3.dts                  | 2 +-
>  arch/arm/boot/dts/omap3430-sdp.dts                 | 2 +-
>  37 files changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/=
am3517_mt_ventoux.dts
> index e507e4ae0d88..e7d7124a34ba 100644
> --- a/arch/arm/boot/dts/am3517_mt_ventoux.dts
> +++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "TeeJet Mt.Ventoux";
> -       compatible =3D "teejet,mt_ventoux", "ti,omap3";
> +       compatible =3D "teejet,mt_ventoux", "ti,am3517", "ti,omap3";
>
>         memory@80000000 {
>                 device_type =3D "memory";
> diff --git a/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts b/arch/arm/=
boot/dts/logicpd-som-lv-35xx-devkit.dts
> index f7a841a28865..2a0a98fe67f0 100644
> --- a/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
> +++ b/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
> @@ -9,5 +9,5 @@
>
>  / {
>         model =3D "LogicPD Zoom OMAP35xx SOM-LV Development Kit";
> -       compatible =3D "logicpd,dm3730-som-lv-devkit", "ti,omap3";
> +       compatible =3D "logicpd,dm3730-som-lv-devkit", "ti,omap3430", "ti=
,omap3";
>  };
> diff --git a/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts b/arch/arm=
/boot/dts/logicpd-torpedo-35xx-devkit.dts
> index 7675bc3fa868..57bae2aa910e 100644
> --- a/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
> +++ b/arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
> @@ -9,5 +9,5 @@
>
>  / {
>         model =3D "LogicPD Zoom OMAP35xx Torpedo Development Kit";
> -       compatible =3D "logicpd,dm3730-torpedo-devkit", "ti,omap3";
> +       compatible =3D "logicpd,dm3730-torpedo-devkit", "ti,omap3430", "t=
i,omap3";
>  };

For both Logic PD OMAP35 kits,

Reviewed-by: Adam Ford <aford173@gmail.com>


> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/om=
ap3-beagle-xm.dts
> index 1aa99fc1487a..125ed933ca75 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "TI OMAP3 BeagleBoard xM";
> -       compatible =3D "ti,omap3-beagle-xm", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "ti,omap3-beagle-xm", "ti,omap3630", "ti,omap36xx"=
, "ti,omap3";
>
>         cpus {
>                 cpu@0 {
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3=
-beagle.dts
> index e3df3c166902..4ed3f93f5841 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "TI OMAP3 BeagleBoard";
> -       compatible =3D "ti,omap3-beagle", "ti,omap3";
> +       compatible =3D "ti,omap3-beagle", "ti,omap3430", "ti,omap3";
>
>         cpus {
>                 cpu@0 {
> diff --git a/arch/arm/boot/dts/omap3-cm-t3530.dts b/arch/arm/boot/dts/oma=
p3-cm-t3530.dts
> index 76e52c78cbb4..32dbaeaed147 100644
> --- a/arch/arm/boot/dts/omap3-cm-t3530.dts
> +++ b/arch/arm/boot/dts/omap3-cm-t3530.dts
> @@ -9,7 +9,7 @@
>
>  / {
>         model =3D "CompuLab CM-T3530";
> -       compatible =3D "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap=
3";
> +       compatible =3D "compulab,omap3-cm-t3530", "ti,omap3430", "ti,omap=
34xx", "ti,omap3";
>
>         /* Regulator to trigger the reset signal of the Wifi module */
>         mmc2_sdio_reset: regulator-mmc2-sdio-reset {
> diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/oma=
p3-cm-t3730.dts
> index 6e944dfa0f3d..683819bf0915 100644
> --- a/arch/arm/boot/dts/omap3-cm-t3730.dts
> +++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
> @@ -9,7 +9,7 @@
>
>  / {
>         model =3D "CompuLab CM-T3730";
> -       compatible =3D "compulab,omap3-cm-t3730", "ti,omap36xx", "ti,omap=
3";
> +       compatible =3D "compulab,omap3-cm-t3730", "ti,omap3630", "ti,omap=
36xx", "ti,omap3";
>
>         wl12xx_vmmc2: wl12xx_vmmc2 {
>                 compatible =3D "regulator-fixed";
> diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts b/arch/arm/boot=
/dts/omap3-devkit8000-lcd43.dts
> index a80fc60bc773..afed85078ad8 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000-lcd43.dts
> @@ -11,7 +11,7 @@
>  #include "omap3-devkit8000-lcd-common.dtsi"
>  / {
>         model =3D "TimLL OMAP3 Devkit8000 with 4.3'' LCD panel";
> -       compatible =3D "timll,omap3-devkit8000", "ti,omap3";
> +       compatible =3D "timll,omap3-devkit8000", "ti,omap3430", "ti,omap3=
";
>
>         lcd0: display {
>                 panel-timing {
> diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts b/arch/arm/boot=
/dts/omap3-devkit8000-lcd70.dts
> index 0753776071f8..07c51a105c0d 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000-lcd70.dts
> @@ -11,7 +11,7 @@
>  #include "omap3-devkit8000-lcd-common.dtsi"
>  / {
>         model =3D "TimLL OMAP3 Devkit8000 with 7.0'' LCD panel";
> -       compatible =3D "timll,omap3-devkit8000", "ti,omap3";
> +       compatible =3D "timll,omap3-devkit8000", "ti,omap3430", "ti,omap3=
";
>
>         lcd0: display {
>                 panel-timing {
> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/o=
map3-devkit8000.dts
> index faafc48d8f61..162d0726b008 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -7,7 +7,7 @@
>  #include "omap3-devkit8000-common.dtsi"
>  / {
>         model =3D "TimLL OMAP3 Devkit8000";
> -       compatible =3D "timll,omap3-devkit8000", "ti,omap3";
> +       compatible =3D "timll,omap3-devkit8000", "ti,omap3430", "ti,omap3=
";
>
>         aliases {
>                 display1 =3D &dvi0;
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3=
-gta04.dtsi
> index b295f6fad2a5..25b6ed9203e1 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -11,7 +11,7 @@
>
>  / {
>         model =3D "OMAP3 GTA04";
> -       compatible =3D "ti,omap3-gta04", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "ti,omap3-gta04", "ti,omap3630", "ti,omap36xx", "t=
i,omap3";
>
>         cpus {
>                 cpu@0 {
> diff --git a/arch/arm/boot/dts/omap3-ha-lcd.dts b/arch/arm/boot/dts/omap3=
-ha-lcd.dts
> index badb9b3c8897..c9ecbc45c8e2 100644
> --- a/arch/arm/boot/dts/omap3-ha-lcd.dts
> +++ b/arch/arm/boot/dts/omap3-ha-lcd.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "TI OMAP3 HEAD acoustics LCD-baseboard with TAO3530 SOM=
";
> -       compatible =3D "headacoustics,omap3-ha-lcd", "technexion,omap3-ta=
o3530", "ti,omap34xx", "ti,omap3";
> +       compatible =3D "headacoustics,omap3-ha-lcd", "technexion,omap3-ta=
o3530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
>  };
>
>  &omap3_pmx_core {
> diff --git a/arch/arm/boot/dts/omap3-ha.dts b/arch/arm/boot/dts/omap3-ha.=
dts
> index a5365252bfbe..35c4e15abeb7 100644
> --- a/arch/arm/boot/dts/omap3-ha.dts
> +++ b/arch/arm/boot/dts/omap3-ha.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "TI OMAP3 HEAD acoustics baseboard with TAO3530 SOM";
> -       compatible =3D "headacoustics,omap3-ha", "technexion,omap3-tao353=
0", "ti,omap34xx", "ti,omap3";
> +       compatible =3D "headacoustics,omap3-ha", "technexion,omap3-tao353=
0", "ti,omap3430", "ti,omap34xx", "ti,omap3";
>  };
>
>  &omap3_pmx_core {
> diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/d=
ts/omap3-igep0020-rev-f.dts
> index 03dcd05fb8a0..d134ce1cffc0 100644
> --- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
> @@ -10,7 +10,7 @@
>
>  / {
>         model =3D "IGEPv2 Rev. F (TI OMAP AM/DM37x)";
> -       compatible =3D "isee,omap3-igep0020-rev-f", "ti,omap36xx", "ti,om=
ap3";
> +       compatible =3D "isee,omap3-igep0020-rev-f", "ti,omap3630", "ti,om=
ap36xx", "ti,omap3";
>
>         /* Regulator to trigger the WL_EN signal of the Wifi module */
>         lbep5clwmc_wlen: regulator-lbep5clwmc-wlen {
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/oma=
p3-igep0020.dts
> index 6d0519e3dfd0..e341535a7162 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -10,7 +10,7 @@
>
>  / {
>         model =3D "IGEPv2 Rev. C (TI OMAP AM/DM37x)";
> -       compatible =3D "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "isee,omap3-igep0020", "ti,omap3630", "ti,omap36xx=
", "ti,omap3";
>
>         vmmcsdio_fixed: fixedregulator-mmcsdio {
>                 compatible =3D "regulator-fixed";
> diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/d=
ts/omap3-igep0030-rev-g.dts
> index 060acd1e803a..9ca1d0f61964 100644
> --- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
> @@ -10,7 +10,7 @@
>
>  / {
>         model =3D "IGEP COM MODULE Rev. G (TI OMAP AM/DM37x)";
> -       compatible =3D "isee,omap3-igep0030-rev-g", "ti,omap36xx", "ti,om=
ap3";
> +       compatible =3D "isee,omap3-igep0030-rev-g", "ti,omap3630", "ti,om=
ap36xx", "ti,omap3";
>
>         /* Regulator to trigger the WL_EN signal of the Wifi module */
>         lbep5clwmc_wlen: regulator-lbep5clwmc-wlen {
> diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/oma=
p3-igep0030.dts
> index 25170bd3c573..32f31035daa2 100644
> --- a/arch/arm/boot/dts/omap3-igep0030.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030.dts
> @@ -10,7 +10,7 @@
>
>  / {
>         model =3D "IGEP COM MODULE Rev. E (TI OMAP AM/DM37x)";
> -       compatible =3D "isee,omap3-igep0030", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "isee,omap3-igep0030", "ti,omap3630", "ti,omap36xx=
", "ti,omap3";
>
>         vmmcsdio_fixed: fixedregulator-mmcsdio {
>                 compatible =3D "regulator-fixed";
> diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ld=
p.dts
> index 9a5fde2d9bce..ec9ba04ef43b 100644
> --- a/arch/arm/boot/dts/omap3-ldp.dts
> +++ b/arch/arm/boot/dts/omap3-ldp.dts
> @@ -10,7 +10,7 @@
>
>  / {
>         model =3D "TI OMAP3430 LDP (Zoom1 Labrador)";
> -       compatible =3D "ti,omap3-ldp", "ti,omap3";
> +       compatible =3D "ti,omap3-ldp", "ti,omap3430", "ti,omap3";
>
>         memory@80000000 {
>                 device_type =3D "memory";
> diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/=
omap3-lilly-a83x.dtsi
> index c22833d4e568..73d477898ec2 100644
> --- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> +++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> @@ -7,7 +7,7 @@
>
>  / {
>         model =3D "INCOstartec LILLY-A83X module (DM3730)";
> -       compatible =3D "incostartec,omap3-lilly-a83x", "ti,omap36xx", "ti=
,omap3";
> +       compatible =3D "incostartec,omap3-lilly-a83x", "ti,omap3630", "ti=
,omap36xx", "ti,omap3";
>
>         chosen {
>                         bootargs =3D "console=3DttyO0,115200n8 vt.global_=
cursor_default=3D0 consoleblank=3D0";
> diff --git a/arch/arm/boot/dts/omap3-lilly-dbb056.dts b/arch/arm/boot/dts=
/omap3-lilly-dbb056.dts
> index fec335400074..ecb4ef738e07 100644
> --- a/arch/arm/boot/dts/omap3-lilly-dbb056.dts
> +++ b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "INCOstartec LILLY-DBB056 (DM3730)";
> -       compatible =3D "incostartec,omap3-lilly-dbb056", "incostartec,oma=
p3-lilly-a83x", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "incostartec,omap3-lilly-dbb056", "incostartec,oma=
p3-lilly-a83x", "ti,omap3630", "ti,omap36xx", "ti,omap3";
>  };
>
>  &twl {
> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.=
dts
> index 74c0ff2350d3..2495a696cec6 100644
> --- a/arch/arm/boot/dts/omap3-n9.dts
> +++ b/arch/arm/boot/dts/omap3-n9.dts
> @@ -12,7 +12,7 @@
>
>  / {
>         model =3D "Nokia N9";
> -       compatible =3D "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "nokia,omap3-n9", "ti,omap3630", "ti,omap36xx", "t=
i,omap3";
>  };
>
>  &i2c2 {
> diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n=
950.dts
> index 9886bf8b90ab..31d47a1fad84 100644
> --- a/arch/arm/boot/dts/omap3-n950.dts
> +++ b/arch/arm/boot/dts/omap3-n950.dts
> @@ -12,7 +12,7 @@
>
>  / {
>         model =3D "Nokia N950";
> -       compatible =3D "nokia,omap3-n950", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "nokia,omap3-n950", "ti,omap3630", "ti,omap36xx", =
"ti,omap3";
>
>         keys {
>                 compatible =3D "gpio-keys";
> diff --git a/arch/arm/boot/dts/omap3-overo-storm-alto35.dts b/arch/arm/bo=
ot/dts/omap3-overo-storm-alto35.dts
> index 18338576c41d..7f04dfad8203 100644
> --- a/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
> +++ b/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
> @@ -14,5 +14,5 @@
>
>  / {
>         model =3D "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Alto35";
> -       compatible =3D "gumstix,omap3-overo-alto35", "gumstix,omap3-overo=
", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "gumstix,omap3-overo-alto35", "gumstix,omap3-overo=
", "ti,omap3630", "ti,omap36xx", "ti,omap3";
>  };
> diff --git a/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts b/arch/ar=
m/boot/dts/omap3-overo-storm-chestnut43.dts
> index f204c8af8281..bc5a04e03336 100644
> --- a/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
> +++ b/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
> @@ -14,7 +14,7 @@
>
>  / {
>         model =3D "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Chestnut43";
> -       compatible =3D "gumstix,omap3-overo-chestnut43", "gumstix,omap3-o=
vero", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "gumstix,omap3-overo-chestnut43", "gumstix,omap3-o=
vero", "ti,omap3630", "ti,omap36xx", "ti,omap3";
>  };
>
>  &omap3_pmx_core2 {
> diff --git a/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts b/arch/arm/=
boot/dts/omap3-overo-storm-gallop43.dts
> index c633f7cee68e..065c31cbf0e2 100644
> --- a/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
> +++ b/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
> @@ -14,7 +14,7 @@
>
>  / {
>         model =3D "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Gallop43";
> -       compatible =3D "gumstix,omap3-overo-gallop43", "gumstix,omap3-ove=
ro", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "gumstix,omap3-overo-gallop43", "gumstix,omap3-ove=
ro", "ti,omap3630", "ti,omap36xx", "ti,omap3";
>  };
>
>  &omap3_pmx_core2 {
> diff --git a/arch/arm/boot/dts/omap3-overo-storm-palo35.dts b/arch/arm/bo=
ot/dts/omap3-overo-storm-palo35.dts
> index fb88ebc9858c..e38c1c51392c 100644
> --- a/arch/arm/boot/dts/omap3-overo-storm-palo35.dts
> +++ b/arch/arm/boot/dts/omap3-overo-storm-palo35.dts
> @@ -14,7 +14,7 @@
>
>  / {
>         model =3D "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Palo35";
> -       compatible =3D "gumstix,omap3-overo-palo35", "gumstix,omap3-overo=
", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "gumstix,omap3-overo-palo35", "gumstix,omap3-overo=
", "ti,omap3630", "ti,omap36xx", "ti,omap3";
>  };
>
>  &omap3_pmx_core2 {
> diff --git a/arch/arm/boot/dts/omap3-overo-storm-palo43.dts b/arch/arm/bo=
ot/dts/omap3-overo-storm-palo43.dts
> index 76cca00d97b6..e6dc23159c4d 100644
> --- a/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
> +++ b/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
> @@ -14,7 +14,7 @@
>
>  / {
>         model =3D "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Palo43";
> -       compatible =3D "gumstix,omap3-overo-palo43", "gumstix,omap3-overo=
", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "gumstix,omap3-overo-palo43", "gumstix,omap3-overo=
", "ti,omap3630", "ti,omap36xx", "ti,omap3";
>  };
>
>  &omap3_pmx_core2 {
> diff --git a/arch/arm/boot/dts/omap3-overo-storm-summit.dts b/arch/arm/bo=
ot/dts/omap3-overo-storm-summit.dts
> index cc081a9e4c1e..587c08ce282d 100644
> --- a/arch/arm/boot/dts/omap3-overo-storm-summit.dts
> +++ b/arch/arm/boot/dts/omap3-overo-storm-summit.dts
> @@ -14,7 +14,7 @@
>
>  / {
>         model =3D "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Summit";
> -       compatible =3D "gumstix,omap3-overo-summit", "gumstix,omap3-overo=
", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "gumstix,omap3-overo-summit", "gumstix,omap3-overo=
", "ti,omap3630", "ti,omap36xx", "ti,omap3";
>  };
>
>  &omap3_pmx_core2 {
> diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts b/arch/arm/boot=
/dts/omap3-overo-storm-tobi.dts
> index 1de41c0826e0..f57de6010994 100644
> --- a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
> +++ b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
> @@ -14,6 +14,6 @@
>
>  / {
>         model =3D "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Tobi";
> -       compatible =3D "gumstix,omap3-overo-tobi", "gumstix,omap3-overo",=
 "ti,omap36xx", "ti,omap3";
> +       compatible =3D "gumstix,omap3-overo-tobi", "gumstix,omap3-overo",=
 "ti,omap3630", "ti,omap36xx", "ti,omap3";
>  };
>
> diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts b/arch/arm/b=
oot/dts/omap3-overo-storm-tobiduo.dts
> index 9ed13118ed8e..281af6c113be 100644
> --- a/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
> +++ b/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
> @@ -14,5 +14,5 @@
>
>  / {
>         model =3D "OMAP36xx/AM37xx/DM37xx Gumstix Overo on TobiDuo";
> -       compatible =3D "gumstix,omap3-overo-tobiduo", "gumstix,omap3-over=
o", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "gumstix,omap3-overo-tobiduo", "gumstix,omap3-over=
o", "ti,omap3630", "ti,omap36xx", "ti,omap3";
>  };
> diff --git a/arch/arm/boot/dts/omap3-pandora-1ghz.dts b/arch/arm/boot/dts=
/omap3-pandora-1ghz.dts
> index 81b957f33c9f..ea509956d7ac 100644
> --- a/arch/arm/boot/dts/omap3-pandora-1ghz.dts
> +++ b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
> @@ -16,7 +16,7 @@
>  / {
>         model =3D "Pandora Handheld Console 1GHz";
>
> -       compatible =3D "openpandora,omap3-pandora-1ghz", "ti,omap36xx", "=
ti,omap3";
> +       compatible =3D "openpandora,omap3-pandora-1ghz", "ti,omap3630", "=
ti,omap36xx", "ti,omap3";
>  };
>
>  &omap3_pmx_core2 {
> diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/om=
ap3-sbc-t3530.dts
> index ae96002abb3b..24bf3fd86641 100644
> --- a/arch/arm/boot/dts/omap3-sbc-t3530.dts
> +++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "CompuLab SBC-T3530 with CM-T3530";
> -       compatible =3D "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t35=
30", "ti,omap34xx", "ti,omap3";
> +       compatible =3D "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t35=
30", "ti,omap3430", "ti,omap34xx", "ti,omap3";
>
>         aliases {
>                 display0 =3D &dvi0;
> diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/om=
ap3-sbc-t3730.dts
> index 7de6df16fc17..eb3893b9535e 100644
> --- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
> +++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "CompuLab SBC-T3730 with CM-T3730";
> -       compatible =3D "compulab,omap3-sbc-t3730", "compulab,omap3-cm-t37=
30", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "compulab,omap3-sbc-t3730", "compulab,omap3-cm-t37=
30", "ti,omap3630", "ti,omap36xx", "ti,omap3";
>
>         aliases {
>                 display0 =3D &dvi0;
> diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3=
-sniper.dts
> index 40a87330e8c3..b6879cdc5c13 100644
> --- a/arch/arm/boot/dts/omap3-sniper.dts
> +++ b/arch/arm/boot/dts/omap3-sniper.dts
> @@ -9,7 +9,7 @@
>
>  / {
>         model =3D "LG Optimus Black";
> -       compatible =3D "lg,omap3-sniper", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "lg,omap3-sniper", "ti,omap3630", "ti,omap36xx", "=
ti,omap3";
>
>         cpus {
>                 cpu@0 {
> diff --git a/arch/arm/boot/dts/omap3-thunder.dts b/arch/arm/boot/dts/omap=
3-thunder.dts
> index 6276e7079b36..64221e3b3477 100644
> --- a/arch/arm/boot/dts/omap3-thunder.dts
> +++ b/arch/arm/boot/dts/omap3-thunder.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "TI OMAP3 Thunder baseboard with TAO3530 SOM";
> -       compatible =3D "technexion,omap3-thunder", "technexion,omap3-tao3=
530", "ti,omap34xx", "ti,omap3";
> +       compatible =3D "technexion,omap3-thunder", "technexion,omap3-tao3=
530", "ti,omap3430", "ti,omap34xx", "ti,omap3";
>  };
>
>  &omap3_pmx_core {
> diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-=
zoom3.dts
> index db3a2fe84e99..d240e39f2151 100644
> --- a/arch/arm/boot/dts/omap3-zoom3.dts
> +++ b/arch/arm/boot/dts/omap3-zoom3.dts
> @@ -9,7 +9,7 @@
>
>  / {
>         model =3D "TI Zoom3";
> -       compatible =3D "ti,omap3-zoom3", "ti,omap36xx", "ti,omap3";
> +       compatible =3D "ti,omap3-zoom3", "ti,omap3630", "ti,omap36xx", "t=
i,omap3";
>
>         cpus {
>                 cpu@0 {
> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3=
430-sdp.dts
> index 0abd61108a53..7bfde8aac7ae 100644
> --- a/arch/arm/boot/dts/omap3430-sdp.dts
> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
> @@ -8,7 +8,7 @@
>
>  / {
>         model =3D "TI OMAP3430 SDP";
> -       compatible =3D "ti,omap3430-sdp", "ti,omap3";
> +       compatible =3D "ti,omap3430-sdp", "ti,omap3430", "ti,omap3";
>
>         memory@80000000 {
>                 device_type =3D "memory";
> --
> 2.19.1
>
