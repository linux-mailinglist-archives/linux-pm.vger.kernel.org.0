Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA642A6450
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 13:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgKDM2l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 07:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbgKDM2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 07:28:41 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E25C0613D3;
        Wed,  4 Nov 2020 04:28:40 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id h6so26881085lfj.3;
        Wed, 04 Nov 2020 04:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7RApEAIaUf6wDTnqq0BAlylI/sI1v2LiQccVP7zRzN0=;
        b=FR9j+plFjwWbPLzQUZmU7h+wKoQHND7B3nJQww2YeAdpJIdffi0Cp9tkRVmtzBOPuv
         rD1CPUVNeoLi+avI/RQrA8KrpSMnNP+ZpEcrB5HJ7uM4XRvJqElH50scVQ0sWcxbovB6
         zVjLWVGtfucH4JLljo99LCBx98mutL430pd4H1VLfC1u/aXwk6yWdICe6uLO9GTGU+kM
         VgqY8RESm9bPbsB5rE1ivoyfvrEBfE1U6iTF906Irt3lia+hJqAJkNRwtQ7nhlW1H1Ys
         JwMKl2ViTPT5sUOQ7x9xWzFx5I39FgEc38jUfT4n5+pb2nUDAVaS3kAx+iLSaGtCvuJx
         XJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7RApEAIaUf6wDTnqq0BAlylI/sI1v2LiQccVP7zRzN0=;
        b=fM91XfrdeE0qYU56VqR9YvFP0QnwrDJrbfQibZ8SzjaUJeUahDQnIjfiH50fIJHCOZ
         jonqhU9PVb04iGVslIy8vsWO9CmV7tTuE5NAQMq9UkJ9zIzMuhvF3nR0cuNWzVe7hVja
         pGCbddB2Tn1Q6hGvhbqVC6JDY+NsayU7rdQjbYyuoHrChko3oOC295dlm0hyw6ZuYxA3
         9mVeUqK42KrQAJFnLVE4aacvmhCzL8KLfmTOgPFFLJhJ+yY9scTWvf6JpQd1VV8Y/52k
         nqys9kXpcUntenT8RoJOHGWOI0v7ev11QKV0IKpmxvj+B1Idme9HV04mP9VcqCj0Ruqb
         8CaQ==
X-Gm-Message-State: AOAM5324JVAXhr4OFypXGSUbjSw2Anocg0sVquMENKJBp39T+kust2z1
        rRb8+a7QNq5loS2lj4p2FTUCUaacU/5aimeR10Yp6FQnXVo=
X-Google-Smtp-Source: ABdhPJy4KiPl/dXVehNGaS1+QByrntha0Fu99akt2u0EBECzU5EFwsavVXn7hO1T3He7SXXOqdbARbnQM3YiaiLLgBw=
X-Received: by 2002:a05:6512:322d:: with SMTP id f13mr8976937lfe.571.1604492918961;
 Wed, 04 Nov 2020 04:28:38 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201104103718eucas1p1c103f1a96499b03c72e5457ac2542c3d@eucas1p1.samsung.com>
 <20201104103657.18007-1-s.nawrocki@samsung.com> <20201104103657.18007-2-s.nawrocki@samsung.com>
In-Reply-To: <20201104103657.18007-2-s.nawrocki@samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 4 Nov 2020 21:28:02 +0900
Message-ID: <CAGTfZH3qf-6bU_vYj_p6PS=hkvAWAmo-PWQVQgN-Ry=sP9u79Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] dt-bindings: devfreq: Add documentation for the
 interconnect properties
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
> Add documentation for new optional properties in the exynos bus nodes:
> interconnects, #interconnect-cells, samsung,data-clock-ratio.
> These properties allow to specify the SoC interconnect structure which
> then allows the interconnect consumer devices to request specific
> bandwidth requirements.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v8:
>  - updated description of the interconnects property,
>  - fixed typo in samsung,data-clk-ratio property description.
>
> Changes for v7:
>  - bus-width property replaced with samsung,data-clock-ratio,
>  - the interconnect consumer bindings used instead of vendor specific
>    properties
>
> Changes for v6:
>  - added dts example of bus hierarchy definition and the interconnect
>    consumer,
>  - added new bus-width property.
>
> Changes for v5:
>  - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 71 ++++++++++++++++=
+++++-
>  1 file changed, 69 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/D=
ocumentation/devicetree/bindings/devfreq/exynos-bus.txt
> index e71f752..bcaa2c0 100644
> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -51,6 +51,19 @@ Optional properties only for parent bus device:
>  - exynos,saturation-ratio: the percentage value which is used to calibra=
te
>                         the performance count against total cycle count.
>
> +Optional properties for the interconnect functionality (QoS frequency
> +constraints):
> +- #interconnect-cells: should be 0.
> +- interconnects: as documented in ../interconnect.txt, describes a path =
at the
> +  higher level interconnects used by this interconnect provider.
> +  If this interconnect provider is directly linked to a top level interc=
onnect
> +  provider the property contains only one phandle. The provider extends
> +  the interconnect graph by linking its node to a node registered by pro=
vider
> +  pointed to by first phandle in the 'interconnects' property.
> +
> +- samsung,data-clock-ratio: ratio of the data throughput in B/s to minim=
um data
> +   clock frequency in Hz, default value is 8 when this property is missi=
ng.
> +
>  Detailed correlation between sub-blocks and power line according to Exyn=
os SoC:
>  - In case of Exynos3250, there are two power line as following:
>         VDD_MIF |--- DMC
> @@ -135,7 +148,7 @@ Detailed correlation between sub-blocks and power lin=
e according to Exynos SoC:
>                 |--- PERIC (Fixed clock rate)
>                 |--- FSYS  (Fixed clock rate)
>
> -Example1:
> +Example 1:
>         Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buse=
s to
>         power line (regulator). The MIF (Memory Interface) AXI bus is use=
d to
>         transfer data between DRAM and CPU and uses the VDD_MIF regulator=
.
> @@ -184,7 +197,7 @@ Example1:
>         |L5   |200000 |200000  |400000 |300000 |       ||1000000 |
>         ----------------------------------------------------------
>
> -Example2 :
> +Example 2:
>         The bus of DMC (Dynamic Memory Controller) block in exynos3250.dt=
si
>         is listed below:
>
> @@ -419,3 +432,57 @@ Example2 :
>                 devfreq =3D <&bus_leftbus>;
>                 status =3D "okay";
>         };
> +
> +Example 3:
> +       An interconnect path "bus_display -- bus_leftbus -- bus_dmc" on
> +       Exynos4412 SoC with video mixer as an interconnect consumer devic=
e.
> +
> +       soc {
> +               bus_dmc: bus_dmc {
> +                       compatible =3D "samsung,exynos-bus";
> +                       clocks =3D <&clock CLK_DIV_DMC>;
> +                       clock-names =3D "bus";
> +                       operating-points-v2 =3D <&bus_dmc_opp_table>;
> +                       samsung,data-clock-ratio =3D <4>;
> +                       #interconnect-cells =3D <0>;
> +               };
> +
> +               bus_leftbus: bus_leftbus {
> +                       compatible =3D "samsung,exynos-bus";
> +                       clocks =3D <&clock CLK_DIV_GDL>;
> +                       clock-names =3D "bus";
> +                       operating-points-v2 =3D <&bus_leftbus_opp_table>;
> +                       #interconnect-cells =3D <0>;
> +                       interconnects =3D <&bus_dmc>;
> +               };
> +
> +               bus_display: bus_display {
> +                       compatible =3D "samsung,exynos-bus";
> +                       clocks =3D <&clock CLK_ACLK160>;
> +                       clock-names =3D "bus";
> +                       operating-points-v2 =3D <&bus_display_opp_table>;
> +                       #interconnect-cells =3D <0>;
> +                       interconnects =3D <&bus_leftbus &bus_dmc>;
> +               };
> +
> +               bus_dmc_opp_table: opp_table1 {
> +                       compatible =3D "operating-points-v2";
> +                       /* ... */
> +               }
> +
> +               bus_leftbus_opp_table: opp_table3 {
> +                       compatible =3D "operating-points-v2";
> +                       /* ... */
> +               };
> +
> +               bus_display_opp_table: opp_table4 {
> +                       compatible =3D "operating-points-v2";
> +                       /* .. */
> +               };
> +
> +               &mixer {
> +                       compatible =3D "samsung,exynos4212-mixer";
> +                       interconnects =3D <&bus_display &bus_dmc>;
> +                       /* ... */
> +               };
> +       };
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks for your work.

--=20
Best Regards,
Chanwoo Choi
