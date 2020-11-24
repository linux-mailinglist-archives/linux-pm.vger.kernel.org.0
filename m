Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997A62C1FCF
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 09:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgKXIZf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 03:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgKXIZe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 03:25:34 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909EEC0613CF
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 00:25:34 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id m13so21013694ioq.9
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 00:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KMNdadd9ZvFWTuVoNLHMWm8n/oEimDIAyR8rcds6pZI=;
        b=ITNkjmgb/YsTR2TlPkZnlmXo0uqq5uhiwHqyCtKh9zv2302HUv0EOxTI6zIuX27HOF
         Kj33WUb/MHzZGMRvP05GlvHO/yxIvW2dofPEUVo16ucBZLNJ300vkO7ksi0OMvtqhp58
         pQBKHdVHP75bsR9+H1njI04/dgI2F8y8ocIpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KMNdadd9ZvFWTuVoNLHMWm8n/oEimDIAyR8rcds6pZI=;
        b=ECPPRS0wKqUSmohUMs4LlB9Xz2nKXIqkH9GsJmbDQ4JB6euHbV91lZ+15+yTcPC7I1
         QkAVOs42G5UOIbi2fb+1urE8rQspkkZzNuqR0vZ8afmt8DFv/9J2lTe9/IeYyNxFCQ86
         tCWByxRT/KSrexj21ZhMW/QXxJaMhb8Ob+cmUNsxsIAg1DIOgV6y5F9iF1TGc8rq1vIY
         atrrRQVCyP/Fr7QYHe+cfFncNXDeyaJrSfYUz4Kls6kaeqRHDd9v4fNZrRz/4r2xaqFj
         tahT9kJUdCJz/ewZMToj1HkpFjgVUunSnTf1NDru47aL80uiRdnY38paivAzxZZE63xU
         sYWQ==
X-Gm-Message-State: AOAM533eVyRCvmADi+3b6goYhV8E3xMV8a94kvl0At4m9v14rK0y4/4k
        +r4wQPnx1v0nEkZhy8fwJaZmBHfLnMjqH72T9VbNRw==
X-Google-Smtp-Source: ABdhPJyva+3URDRSrpHxrcTh7uFP7kWdZNum/UXJ9zFv+P/ZN3AGrq1Y/T6jPrsBuSoVIiiqRr8BGnw2YdEdTuRhZ1w=
X-Received: by 2002:a05:6602:314c:: with SMTP id m12mr3172286ioy.100.1606206333961;
 Tue, 24 Nov 2020 00:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20201013102358.22588-1-michael.kao@mediatek.com> <20201013102358.22588-3-michael.kao@mediatek.com>
In-Reply-To: <20201013102358.22588-3-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 24 Nov 2020 16:25:08 +0800
Message-ID: <CAJMQK-gXFBbpmxugme3U0bJ_7TtWdibWWqQHSZLWy0jyeVuUuw@mail.gmail.com>
Subject: Re: [v5 2/3] arm64: dts: mt8183: Configure CPU cooling
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        srv_heupstream@mediatek.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 6:24 PM Michael Kao <michael.kao@mediatek.com> wrot=
e:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> Add two passive trip points at 68=C2=B0C and 80=C2=B0C for the CPU temper=
ature.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 56 ++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8183.dtsi
> index 1cd093cf33f3..0614f18a1ea2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/reset-controller/mt8183-resets.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/thermal/thermal.h>
>  #include "mt8183-pinfunc.h"
>
>  / {
> @@ -450,6 +451,61 @@
>                                 polling-delay =3D <500>;
>                                 thermal-sensors =3D <&thermal 0>;
>                                 sustainable-power =3D <5000>;
> +
> +                               trips {
> +                                       threshold: trip-point@0 {
> +                                               temperature =3D <68000>;
> +                                               hysteresis =3D <2000>;
> +                                               type =3D "passive";
> +                                       };
> +
> +                                       target: trip-point@1 {
> +                                               temperature =3D <80000>;
> +                                               hysteresis =3D <2000>;
> +                                               type =3D "passive";
> +                                       };
> +
> +                                       cpu_crit: cpu-crit {
> +                                               temperature =3D <115000>;
> +                                               hysteresis =3D <2000>;
> +                                               type =3D "critical";
> +                                       };
> +                               };
> +
> +                               cooling-maps {
> +                                       map0 {
> +                                               trip =3D <&target>;
> +                                               cooling-device =3D <&cpu0
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu1
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu2
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu3
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
;
> +                                               contribution =3D <3072>;
> +                                       };
> +                                       map1 {
> +                                               trip =3D <&target>;
> +                                               cooling-device =3D <&cpu4
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu5
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu6
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu7
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
;
> +                                               contribution =3D <1024>;
> +                                       };
> +                               };
>                         };
>
>                         /* The tzts1 ~ tzts6 don't need to polling */
> --
> 2.18.0
