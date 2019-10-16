Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF56D8C37
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 11:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbfJPJJc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 05:09:32 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33425 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390069AbfJPJJc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 05:09:32 -0400
Received: by mail-vk1-f196.google.com with SMTP id s21so5005592vkm.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLC2Bd8aTQlMgTV7BobgAGWFlGh3ztvsn8nW9/bKZV0=;
        b=TxAUvPHmWlpqZquEhMqD+x3551R1EZwVaKusNrROTNOeGYR0WQl7D+tujtdR8FSyyF
         2VeE5hAYMcMy3oMmSGWr1wAiipgs7pUOxgq6jJxs33Tx3MPjfT9ckCrvv/C+5gve3kV0
         tNEy86FFXR6/dHrqdTnSg3Gmnr5Asphn8ZSpJJnE+BsLyrAJscBCCdkt4XLiSb5oBFHQ
         RgPAmHOZgQ6FKVhO7pLWmEc3uBpSmSd5Gmud8YcSKygyyn3Y6Fsn7Mu8MGT93UWDJdwe
         QAE2jYUkX6PeuIbZoOt0oyrLbStPJgrPvJ5MOGHT4p02Lgzg6Pg9cqKTEpawJNUUsutW
         5q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLC2Bd8aTQlMgTV7BobgAGWFlGh3ztvsn8nW9/bKZV0=;
        b=OtRhjL5bwSyPxddmNUJ1Lzgb9eAhJIjoNbY2OhaOhjJLamQVhXGIgc6Ukbr16wckVj
         FITU1xMZ3ZxzjJnAwuNTMz3BlcSPs8fXqShZAVr5LEK4pvKEz4MkkaMCHXxyLOdpnJDk
         wKMTmIfFH+OVuQ4ewGyhMhRaZvfAe2lYK/LTAD87bpTilV/6rY6VF5AY/FKCv9/2H9TC
         8Afh4xNK2eJmTMUuYYS9CF66GSJOQWEQPBpnZuuXTBdCKzrg+8NO16Eq6gcNFbMjTsmN
         GXaEsal9Itg/VYwKmqgssdikRjCrxpplxVZo6ILZAUTiTtKRIMHEz8pEmDgUHs7wh00M
         Q3Sg==
X-Gm-Message-State: APjAAAWBqkionMSfFxMKCGp3uVx7bkyyZBiFQ9nYvFziFwpdSnjKlmUm
        0RZmSZMfU+ZzsvvDSwiwFN5KzDXrDgEfUP3U3L5siA==
X-Google-Smtp-Source: APXvYqww+h+Iq3oDN0oTKBVKfMcWMcfwYY7YU64RQBVmcDpEJ/mf+loxbnHvtZCcDTC1U4TMBxnPsF30uUlEr20CN5E=
X-Received: by 2002:a1f:f8cd:: with SMTP id w196mr21577811vkh.73.1571216970789;
 Wed, 16 Oct 2019 02:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191004090114.30694-1-glaroque@baylibre.com> <20191004090114.30694-6-glaroque@baylibre.com>
In-Reply-To: <20191004090114.30694-6-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 16 Oct 2019 14:39:19 +0530
Message-ID: <CAHLCerMp8K7Gs6cAfDVPGa8zSNEOjyQghy-LoauGB15if0EjKg@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] arm64: dts: amlogic: g12a: add cooling properties
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
> Add missing #colling-cells field for G12A SoC
> Add cooling-map for passive and hot trip point
>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index 733a9d46fc4b..3ab6497548ca 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -18,6 +18,7 @@
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu1: cpu@1 {
> @@ -26,6 +27,7 @@
>                         reg = <0x0 0x1>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu2: cpu@2 {
> @@ -34,6 +36,7 @@
>                         reg = <0x0 0x2>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu3: cpu@3 {
> @@ -42,6 +45,7 @@
>                         reg = <0x0 0x3>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 l2: l2-cache0 {
> @@ -113,3 +117,23 @@
>  &sd_emmc_a {
>         amlogic,dram-access-quirk;
>  };
> +
> +&cpu_thermal {
> +       cooling-maps {
> +               map0 {
> +                       trip = <&cpu_passive>;
> +                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +               };
> +
> +               map1 {
> +                       trip = <&cpu_hot>;
> +                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +               };
> +       };
> +};
> --
> 2.17.1
>
