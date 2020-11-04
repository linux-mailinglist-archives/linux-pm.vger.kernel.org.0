Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18B22A6465
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgKDMbs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 07:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgKDMbq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 07:31:46 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA7C0613D3;
        Wed,  4 Nov 2020 04:31:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 126so26869767lfi.8;
        Wed, 04 Nov 2020 04:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=eGRfu7cZeqB9YUMW6wjYUN4TCDuvZCIBiy+8r0Kdrlk=;
        b=eShQiJoD1/m8u+97eU87dp/yafAb16bUfFTVdkZuqkOzdCTmSurMyIKCih2nJi8WnJ
         gC8krvS3buQBVbx3pcHyWXmQ6VBS467Ff8gd2dSdD67wPJlqXLsysPTK+RyqdVs4Kseq
         A2BJxsVaaH3p6aeHBR8Yb5EQt5RIOuU2vYdR4f1IdvaBC9tQZ3JIhMGn/5KczIfHSYI2
         4zPS6rSPgQVeSHVyz5/wR9jMc7uEAqXN4AI4A40hO2A8ptyMWvH8AxuotxNao8DpfzNP
         bUh51sJEcqaTeLKnrWuJRB/SEUghmhjSX2sAb6x1qgqaHbYqAX4DYyWTrwbYUP2ij3Ie
         Ye1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=eGRfu7cZeqB9YUMW6wjYUN4TCDuvZCIBiy+8r0Kdrlk=;
        b=DjTx85IliW6vx4suT8x52N59rHM/Si1kor3Xx/hA8/33FHpHK8HS384q0Jt3E0Q+OW
         WHx9I6PPF1qgge1JiX+uyZ1PmW6JOPCNzzc9t/u8NO3N2S+eG7BRLnLOGmoxfVfyhDKW
         sjwuk4s8x6pBBjuTnPdxpeXPyTSEkSyVtu/iidIZ4daNAkDYElOy43EHJv0L1tEPCdTO
         r5JcJS3v4vovhMOL7P3uGU1CI4GWfGlb1CjEXrTalWSb3nJ59LnxVfUanjXB4c2GKugH
         Li9sFg8H5R9bfFhN7bODgkTyin5Uvt9eieVdwvnt/AiaJhvjN5YHSuc7pgQ6Gcz6fWx9
         vV6g==
X-Gm-Message-State: AOAM533yYPZhnsfasLfTGSFgnxKMo7wvSO5js+85Nz/jiswe54hIbqxS
        EDUXSkOU8+u2/zBnJquQ1DBfzTGkKGhFubPYNWPiJdttJIc=
X-Google-Smtp-Source: ABdhPJxYcnhLMr5T9ylhOB5yD+qW82hWOXmFvCpNYKZkAw45ROiHQe9/VagZPfb0cKmlftPPAx1vUh+o6owLdQSPzD0=
X-Received: by 2002:a05:6512:290:: with SMTP id j16mr9147999lfp.62.1604493104713;
 Wed, 04 Nov 2020 04:31:44 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201104103726eucas1p248b51b25f5ee42898bf03e9cb2229c5d@eucas1p2.samsung.com>
 <20201104103657.18007-1-s.nawrocki@samsung.com> <20201104103657.18007-6-s.nawrocki@samsung.com>
In-Reply-To: <20201104103657.18007-6-s.nawrocki@samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 4 Nov 2020 21:31:08 +0900
Message-ID: <CAGTfZH2uSYesGdOikGZ_2qBWe4i+yZ6RnczJyn5ML=pvusC+iw@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] ARM: dts: exynos: Add interconnect properties to
 Exynos4412 bus nodes
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On Wed, Nov 4, 2020 at 7:37 PM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> This patch adds the following properties for Exynos4412 interconnect
> bus nodes:
>  - interconnects: to declare connections between nodes in order to
>    guarantee PM QoS requirements between nodes,
>  - #interconnect-cells: required by the interconnect framework,
>  - samsung,data-clk-ratio: which allows to specify minimum data clock
>    frequency corresponding to requested bandwidth for each bus.
>
> Note that #interconnect-cells is always zero and node IDs are not
> hardcoded anywhere.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v8:
>  - none.
>
> Changes for v7:
>  - adjusted to the DT property changes: "interconnects" instead
>    of "samsung,interconnect-parent", "samsung,data-clk-ratio"
>    instead of "bus-width".
>
> Changes for v6:
>  - added bus-width property in bus_dmc node.
>
> Changes for v5:
>  - adjust to renamed exynos,interconnect-parent-node property,
>  - add properties in common exynos4412.dtsi file rather than
>    in Odroid specific odroid4412-odroid-common.dtsi.
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos=
4412.dtsi
> index e76881d..4999e68 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -383,6 +383,8 @@
>                         clocks =3D <&clock CLK_DIV_DMC>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_dmc_opp_table>;
> +                       samsung,data-clock-ratio =3D <4>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -452,6 +454,8 @@
>                         clocks =3D <&clock CLK_DIV_GDL>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_leftbus_opp_table>;
> +                       interconnects =3D <&bus_dmc>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -468,6 +472,8 @@
>                         clocks =3D <&clock CLK_ACLK160>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_display_opp_table>;
> +                       interconnects =3D <&bus_leftbus &bus_dmc>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

--=20
Best Regards,
Chanwoo Choi
