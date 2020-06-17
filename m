Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1F1FC5B9
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 07:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgFQFjk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 01:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgFQFjk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 01:39:40 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9854C061573
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 22:39:39 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v6so358143uam.10
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 22:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9qIRx2tmhQ3c3ThbA5nkdagn3KrF5Ngnlh6eWWB5sQ=;
        b=tV5VmVtHEExLDAgnm3QHdrBX6Z+X2xewEeIPR6nHkE1YvO2YLuZj5m7aMMzZc0N5qn
         b+bHb3H1Pc+gT0kD2XioSKa20MP/FHGwtV/+Ku/ZtIp1b1oux3Iapejc2V8uF24wb84E
         iGb7tbt9DpISBvbBvsKSNtrp9WUTQMdXNgm5SX6l5DWFH999VJdCu1JcxskvBo+k2OZQ
         /Oz077l3N08uClrw1bPyI3kIatKaQbccwkvGEVq1gF7KwfD3tn5OMSSBypaFjkdpH7m4
         0SVo1rcoH6DlH7ilS9OSS3zJzdheVKSrfuPcWqR5TLKQeSrLrMatTJo4OiBQ9ZDSl+L5
         e/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9qIRx2tmhQ3c3ThbA5nkdagn3KrF5Ngnlh6eWWB5sQ=;
        b=NnNrJBEaKiyCKzNYRy5R0MUx3C9e4lk1S7Vt1zNyqY/laX4HFUfA0vvqRLu2d0Tw+H
         bXgbChPfaquX9h8oCdgiuxqB+797GS+A+HzVsD1ZjssjXgOyLEKx/Ga1Kq21W4H0IdjX
         mmmD8Q9fk6s99qDuLbwKh8JpclvUj1vd3HZtlyD6/WOts4QYa9TOgwwMmvp78STnEy8t
         wgaSsKgU50TcmN73SAZ8B5KU6mH4JPRfGrmCrwNXD6TiQ97SU7U6AiMMATFe5Vmbh6qC
         ARdF4lrGOrMBEh1B8m2x0SRp6iKRMcgRxGuIUgLPWy58rTCugkB7n8Ym80Y4M1+diZjQ
         /oDA==
X-Gm-Message-State: AOAM531ppzOH8OI3Z/nJB6IlBKNdxrfTZvYeiCtLhVorDCqH/fA5nlFR
        RbihuOZ9KadN/suy9f+g4N82fdVW8UJVT5qE1S29dw==
X-Google-Smtp-Source: ABdhPJz89Ef33YgEHunwRCxdjaFBZmv3URUcXF7ranAVS8kN/9HInOJDHD51KTNr0Mh1t1tL3cEoGx09WYVLD327dfg=
X-Received: by 2002:ab0:1eca:: with SMTP id p10mr4534103uak.94.1592372379134;
 Tue, 16 Jun 2020 22:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200608091739.2368-1-narmstrong@baylibre.com> <20200608091739.2368-6-narmstrong@baylibre.com>
In-Reply-To: <20200608091739.2368-6-narmstrong@baylibre.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 17 Jun 2020 11:09:28 +0530
Message-ID: <CAHLCerP+jEhZJs7yPmwPEm15FnrShJjNzOJ2UNcXVP5-WFbwVg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 8, 2020 at 2:47 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Khadas MCU node with active FAN thermal nodes for all the
> Khadas VIM3 variants.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 094ecf2222bb..3325e54ea690 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -183,6 +183,23 @@
>         hdmi-phandle = <&hdmi_tx>;
>  };
>
> +&cpu_thermal {
> +       trips {
> +               cpu_active: cpu-active {
> +                       temperature = <80000>; /* millicelsius */
> +                       hysteresis = <2000>; /* millicelsius */
> +                       type = "active";
> +               };
> +       };
> +
> +       cooling-maps {
> +               map {
> +                       trip = <&cpu_active>;
> +                       cooling-device = <&khadas_mcu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +               };
> +       };
> +};
> +
>  &ext_mdio {
>         external_phy: ethernet-phy@0 {
>                 /* Realtek RTL8211F (0x001cc916) */
> @@ -222,6 +239,12 @@
>         pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
>         pinctrl-names = "default";
>
> +       khadas_mcu: system-controller@18 {
> +               compatible = "khadas,mcu";
> +               reg = <0x18>;
> +               #cooling-cells = <2>;
> +       };
> +
>         gpio_expander: gpio-controller@20 {
>                 compatible = "ti,tca6408";
>                 reg = <0x20>;
> --
> 2.22.0
>
