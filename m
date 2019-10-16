Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A01D8C2E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391877AbfJPJIv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 05:08:51 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42528 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389980AbfJPJIv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 05:08:51 -0400
Received: by mail-vs1-f68.google.com with SMTP id m22so15084247vsl.9
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+cbAAT/Sf2rErLhd62NV0+wHrRpwzDTpuV1QL+WgT0=;
        b=WkQCEGe/JAlMlgRGB7nm+sPGEBKCVm2NHJCVmMGXfIYgzeKUN3my5cJrAPT2mNJVkb
         fpEN30qA5FLHU5uCRa0DaQr2t6p3BpsDX7lgLuldrPYzWo7TX7WyhiEemNZWiMpWAl6D
         S3LkJwnFcv+UrH/tOvfu2o4TPqWrUh9Zbv0hZrp8uL4K1mIKneqUwLhV+Jslu423nKSH
         TMsl0r4WiGv/koqvQRiM49mFdqg31ufBtMedL4v9eLtp2a1WkTf5UaX8UXKbLsdJhbOg
         AvpE37hKsWvyZpkCGedlDeYcXFROMfTaGrUX2fgkhK4Bgn0019hnDfwJZ8k2UA25ivTK
         SlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+cbAAT/Sf2rErLhd62NV0+wHrRpwzDTpuV1QL+WgT0=;
        b=ekBDy/sprIHYZBvqTXnpiImkLYOli4ECNNj9tsHXvtnMNwBIcNMrxrZr5NxkaXmWXs
         jV5JIlY/BwupmyQcVuciqb7ynDeDEdMo3AUp5ICqdP5obgTbrIAuV4zd9oQNnSr5KuZW
         OLjgSzUuyEFbZrxpdUccBo03Ej9s7ipLI9fTYQIrW/RPpg+PUgniMCiIOUocN8t017ho
         3YU+5hadTfmghgpWhN0F9ED2TCd36QcC9DX0DSC93vsctjI00CuRHpzUUbUndb4xVDeD
         IOKkEvBhCBKdcaWOg3y/2RmqHyNijuuJcA62FwnGqPfzR9CDJ3l0/b0UBcva9orAQLGq
         937w==
X-Gm-Message-State: APjAAAVr+GU9l1kjPv9seYzRUyNDTolosby9X2blekoyRV9hAYkibC6Y
        8OcMVR32q1AeozOm7cGo10PWia3tyIMDVJtOo2u/biFZY9CuryeI
X-Google-Smtp-Source: APXvYqys96QtP/a589oj4qhDSHoh3ceKxXMx8205sD/iOsFacZUanmKIFgQRgZbT9Fci7ihZ25YAPhZkM6grwM2/Kv8=
X-Received: by 2002:a67:df0d:: with SMTP id s13mr4375026vsk.95.1571216930772;
 Wed, 16 Oct 2019 02:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191004090114.30694-1-glaroque@baylibre.com> <20191004090114.30694-7-glaroque@baylibre.com>
In-Reply-To: <20191004090114.30694-7-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 16 Oct 2019 14:38:39 +0530
Message-ID: <CAHLCerOcHoMLc8kjBvG3ssiro31sr2Fsv5dGscqCTD72xdaLMQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] arm64: dts: amlogic: g12b: add cooling properties
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
> Add missing #colling-cells field for G12B SoC
> Add cooling-map for passive and hot trip point
>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 29 +++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> index 98ae8a7c8b41..4bb89bce758f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> @@ -49,6 +49,7 @@
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu1: cpu@1 {
> @@ -57,6 +58,7 @@
>                         reg = <0x0 0x1>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu100: cpu@100 {
> @@ -65,6 +67,7 @@
>                         reg = <0x0 0x100>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu101: cpu@101 {
> @@ -73,6 +76,7 @@
>                         reg = <0x0 0x101>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu102: cpu@102 {
> @@ -81,6 +85,7 @@
>                         reg = <0x0 0x102>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu103: cpu@103 {
> @@ -89,6 +94,7 @@
>                         reg = <0x0 0x103>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 l2: l2-cache0 {
> @@ -219,3 +225,26 @@
>  &sd_emmc_a {
>         amlogic,dram-access-quirk;
>  };
> +
> +&cpu_thermal {
> +       cooling-maps {
> +               map0 {
> +                       trip = <&cpu_passive>;
> +                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +               };
> +               map1 {
> +                       trip = <&cpu_hot>;
> +                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                        <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +               };
> +       };
> +};
> --
> 2.17.1
>
