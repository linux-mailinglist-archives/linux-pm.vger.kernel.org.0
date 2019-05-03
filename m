Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9853B1288C
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 09:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfECHQl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 03:16:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34510 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfECHQl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 03:16:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id j6so5654287qtq.1
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2019 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlnuPNTSqAOsReFStbtqUTb18X37z9g45qyDj7kddRA=;
        b=hEJ22Rh6lnEcmSMaMMuUlZdfXJ7KCYTX3AM2srreiE8Sf6OAnRXfVnZRnjcSn4jHPY
         3p24HRD5HVSh44RxdFmCpqu/1sYnULlRTl0XRo2uF6K5RVegrPF0550505OwkW0+qT+m
         5FmONnZuEwLBqfg9dGyH0yJSkdmST31cbhVaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlnuPNTSqAOsReFStbtqUTb18X37z9g45qyDj7kddRA=;
        b=COpvPYkYBjFp/UlmQ47czQCzyFzENjHtuFFF+6ayWpMMT54pmItOg82QDsyxB8m4gg
         zKqhcD6LHQ0mUJp6IvD9LxilSxC1h/s/2xqcA5a2XcJ10n6IK/L0rATjGSMlFd5Oi/Ra
         cLSgEFjR9iA3dGmaNDltORJf0BPVSiqHrIRMEoS+1w6qF5+Rpi86DPx0bxaw7k3RzqJD
         rdF5xE7ennHOe6fyaWLXfMkHQL85pCS3fb64bdNjCbJbke7YA9erFFWgJYf13k4G7+BF
         PVzsQqiH/eIflN5ohRVR/BpHH2Ci/P2CKqUocfhQSI2AZYeHHU5uWYlSFcZq/8zdKUuu
         95mw==
X-Gm-Message-State: APjAAAUiy/AXtPZ+XvYOHGUWrxrpv0ojJ5HqiPimdhaTI5G4VtEBHLkI
        p1YjoSyWjGxwyBN3iFePFuB90V+iytJQjXIu7L7RkA==
X-Google-Smtp-Source: APXvYqwhRV3TvOuByNuwZ+DDBwx1hJ5Ye6qvgO/XvXATKgGv9cIvbe0igodjrM3jyeRk2df7QWBovKlHBg7m9FObZ4Q=
X-Received: by 2002:ad4:534b:: with SMTP id v11mr6824906qvs.31.1556867800383;
 Fri, 03 May 2019 00:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-3-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1556793795-25204-3-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 3 May 2019 15:16:29 +0800
Message-ID: <CAJMQK-jujDXt18M8610G4GpHdrikTD0ZZG_=C2YTt63UfxuHuQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] arm64: dts: mt8183: add/update dynamic power coefficients
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     fan.chen@mediatek.com, jamesjj.liao@mediatek.com,
        dawei.chien@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
>
> Add dynamic power coefficients for all cores and update those of
> CPU0 and CPU4.
>
> Signed-off-by: Michael.Kao <michael.kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index b92116f..5668fb8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -58,6 +58,8 @@
>                         compatible = "arm,cortex-a53";
>                         reg = <0x000>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <84>;
> +                       #cooling-cells = <2>;
Should this line be in [3/8] arm64: dts: mt8183: Add #cooling-cells to
CPU nodes?

>                 };
>
>                 cpu1: cpu@1 {
> @@ -65,6 +67,8 @@
>                         compatible = "arm,cortex-a53";
>                         reg = <0x001>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <84>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu2: cpu@2 {
> @@ -72,6 +76,8 @@
>                         compatible = "arm,cortex-a53";
>                         reg = <0x002>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <84>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu3: cpu@3 {
> @@ -79,6 +85,8 @@
>                         compatible = "arm,cortex-a53";
>                         reg = <0x003>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <84>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu4: cpu@100 {
> @@ -86,6 +94,8 @@
>                         compatible = "arm,cortex-a73";
>                         reg = <0x100>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <211>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu5: cpu@101 {
> @@ -93,6 +103,8 @@
>                         compatible = "arm,cortex-a73";
>                         reg = <0x101>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <211>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu6: cpu@102 {
> @@ -100,6 +112,8 @@
>                         compatible = "arm,cortex-a73";
>                         reg = <0x102>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <211>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu7: cpu@103 {
> @@ -107,6 +121,8 @@
>                         compatible = "arm,cortex-a73";
>                         reg = <0x103>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <211>;
> +                       #cooling-cells = <2>;
>                 };
>         };
>
