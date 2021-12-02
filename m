Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA194665B2
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 15:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358749AbhLBOtf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 09:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358741AbhLBOte (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 09:49:34 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A026C061758
        for <linux-pm@vger.kernel.org>; Thu,  2 Dec 2021 06:46:11 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id i63so175846lji.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Dec 2021 06:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxPnHdJ+aJ9D33iSxb5HbYdKxpIsMl+fKEKkdpainPE=;
        b=mIeUQBnIwa+LR+DWD6zB8iXWvNe82vquVBzQ/4uKsPN/cV3MyjJG29z+LW1R/v+qG1
         +SxMk6tTwmfOd1hDqDr0LpEtlsimwo1hudzbVrN9UIXHTJQY+zgrD2qBc+nlAxNKIn/a
         C+F2KxKjS7AKpWw7EkLE9zH8r+0zp990VkAu26nwz0wJZLTRZyEQmcQlKHHDRj7jv/QV
         +7m5sI6HWXCWS4Yq/kn4PP9/CB5yQEAYVF+4RcO37o2w52wX6qIl0Ev+Ktvqzajuw16o
         sjfHXUlw1XQQQXrhXQtR6dTlFA3bW/LuS31w7jyu/ENVQLSi/kx3iUJBr9esEdWQgl5z
         Tnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxPnHdJ+aJ9D33iSxb5HbYdKxpIsMl+fKEKkdpainPE=;
        b=fSg4tOaOPIUtR14Yh2TcqMgs11uMAQQ7BuPnWqLaOgNSmVMIQAbhlA1+ExXSA1AW7Z
         NqxXhh5dYAG/TotQeqB05SdzK1sJ75EwncudMnonU2zVidSdrKp55BCoe6xl7PuvJ1oi
         yfdGdjavfGAMe2OZxfbn2lu7Z2cKUasKTuOm5kav9m/q2KDPhNlEnBxuJRDLb8OPC7up
         6maJRFZeoz/oQK4O5DJM3ueOhAMKH8bUkxhn4riTH+p7xAqf2fFLX4UTBbVXwAG1nlBk
         NgFtSGLogfyFNGgjbc8aijsQaHkHYIkTwtwIMOnbi3smFnMkHmE98FLE0yLRGCa8IBwL
         4imw==
X-Gm-Message-State: AOAM531ek31bOX8CfnrI8KpOeTbgQC2r8ny9+GcCssE80HGwM0a5IPHg
        iRcLfGCNXt5bM0kVt47VUciW4+woZiSMwUeRaFgVAA==
X-Google-Smtp-Source: ABdhPJyQIM753aEFPLW9JOZqu+gb1592ytFHS/P+BaHRLTTB+e5vALHEOang9gu8VNBPTccwpNku8gvj4H03BAXaHbM=
X-Received: by 2002:a2e:b6d1:: with SMTP id m17mr12082827ljo.273.1638456369776;
 Thu, 02 Dec 2021 06:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20211201163856.41419-1-daniel.lezcano@linaro.org> <20211201163856.41419-2-daniel.lezcano@linaro.org>
In-Reply-To: <20211201163856.41419-2-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Dec 2021 15:45:33 +0100
Message-ID: <CAPDyKFrx4vyiv6evTPn-j5zn_g1Rc2Azd_XX5NnXzN19NOdHQw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: rockchip: Add powerzones definition
 for rock960
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 1 Dec 2021 at 17:42, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Add the powerzones description. This first step introduces the big,
> the little as powerzone places.
>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>    V3:
>      - Remove GPU section as no power is available (yet)
>      - Remove '#powerzone-cells' conforming to the bindings change
>    V2:
>      - Move description in the SoC dtsi specific file
>    V1: Initial post
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index d3cdf6f42a30..c41b20888a44 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -76,6 +76,7 @@ cpu_l0: cpu@0 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <100>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       powerzone = <&PKG_PZ>;
>                 };
>
>                 cpu_l1: cpu@1 {
> @@ -88,6 +89,7 @@ cpu_l1: cpu@1 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <100>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       powerzone = <&PKG_PZ>;
>                 };
>
>                 cpu_l2: cpu@2 {
> @@ -100,6 +102,7 @@ cpu_l2: cpu@2 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <100>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       powerzone = <&PKG_PZ>;
>                 };
>
>                 cpu_l3: cpu@3 {
> @@ -112,6 +115,7 @@ cpu_l3: cpu@3 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <100>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       powerzone = <&PKG_PZ>;
>                 };
>
>                 cpu_b0: cpu@100 {
> @@ -124,6 +128,7 @@ cpu_b0: cpu@100 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <436>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       powerzone = <&PKG_PZ>;
>
>                         thermal-idle {
>                                 #cooling-cells = <2>;
> @@ -142,6 +147,7 @@ cpu_b1: cpu@101 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <436>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       powerzone = <&PKG_PZ>;
>
>                         thermal-idle {
>                                 #cooling-cells = <2>;
> @@ -791,6 +797,17 @@ spi5: spi@ff200000 {
>                 status = "disabled";
>         };
>
> +       powerzones {
> +
> +               PKG_PZ: pkg {
> +                       #powerzone-cells = <0>;
> +                        powerzone = <&SOC_PZ>;
> +               };
> +
> +               SOC_PZ: soc {

This needs "#powerzone-cells = <0>;"

> +               };
> +       };
> +
>         thermal_zones: thermal-zones {
>                 cpu_thermal: cpu-thermal {
>                         polling-delay-passive = <100>;
> --
> 2.25.1
>

Other than the minor thing above, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
