Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80A774F2C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfGYNWw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 09:22:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41894 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGYNWw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 09:22:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so47966558ljg.8;
        Thu, 25 Jul 2019 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=KgKbQn+sVtaYeJftRwYKqZockp8kTGU+oulqwixLW+w=;
        b=Kf3Z1S3rHqrjO1JoxJdWnKuBq8hN1KQIwgSpoPR00GOKJL3nGmYGed+tcTpj8qr2GB
         +v7HJMt9fxA+2jZBPUgP9hhAnYFR72DdyTp8/ATGS/ewqTcf0ASA7K9KfaJKhMZA4vZd
         6vDFnnJDlMGVnajKl23G3fJSHXPaANDNf+UlcHmUe46sXRl5tpCzGSSsx6xF1L2sCMkw
         pTKPI0gZ9GkMqW2QIEOv6uyth18zlsjxH3vH+AC/3Vi56ujnMtPqEd1M/9tFpNqVStkl
         prodH09bb738Mr8sstAKfx6tK16+abbu1SV26muDqEUtaUc1ZzAraUZr13LdSnrKtafX
         hyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=KgKbQn+sVtaYeJftRwYKqZockp8kTGU+oulqwixLW+w=;
        b=mBDAuogFJpRAq0OwaXa7oY5TQO9W7RgJyRL4hj9vGXoukf0aoPpfz33RQZvXOU77Qx
         QXBABq4sJH8NBCUfZHOpxUtAfvIOUSuItYpq+g0JuC6gRqHB9glLk4ayHhPfjiKNxh5+
         ckQbf63mAWHWq6QDe8I6/AT77i188XEae0JUcAROSEm1ECPUIti++4JB95R5Jx3Dg/Ux
         FSvQkmse7CQUEJN9OQGjlzG2qF33hvsabBTMUyzWidUkCDSpkpPi4tS1McWj1z+SUA1b
         O5UW55bzuUacFJ1zz/b7Esl6KsPWz5+l0k0DnEcp9rS9uLbHrHIyzGLfA4Bh4+RmGi4M
         /MKg==
X-Gm-Message-State: APjAAAVyhsrLMXBlFdXKoNFsd1Q6awHZYUSxuVJ4EPCSh9Lls5L36U1w
        zosszob/x+XlLKOL4DCIsQONCsKUbt1Rpea4zwR/v/bg
X-Google-Smtp-Source: APXvYqyTTtkZSLGybeBnj2BYoFqYLkzK/AMLxamssTlKXEad8A8gaXQC1+CN5OL/YGc0pcrVbBBEQ1iENKDqhDFdKKU=
X-Received: by 2002:a2e:9198:: with SMTP id f24mr46939627ljg.221.1564060446021;
 Thu, 25 Jul 2019 06:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98@eucas1p2.samsung.com>
 <20190723122016.30279-1-a.swigon@partner.samsung.com> <20190723122016.30279-9-a.swigon@partner.samsung.com>
In-Reply-To: <20190723122016.30279-9-a.swigon@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 25 Jul 2019 22:13:29 +0900
Message-ID: <CAGTfZH1_Qk+vNa_AJW_8OA8MJbnZa3yCTLLRs2w23bNTm72gyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 8:07, A=
rtur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> This patch adds two fields tp the Exynos4412 DTS:
>   - parent: to declare connections between nodes that are not in a
>     parent-child relation in devfreq;
>   - #interconnect-cells: required by the interconnect framework.
>
> Please note that #interconnect-cells is always zero and node IDs are not
> hardcoded anywhere.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
>  arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/b=
oot/dts/exynos4412-odroid-common.dtsi
> index ea55f377d17c..bdd61ae86103 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -106,6 +106,7 @@
>  &bus_leftbus {
>         devfreq-events =3D <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>         vdd-supply =3D <&buck3_reg>;
> +       parent =3D <&bus_dmc>;

It is wrong. 'bus_leftbus' has not any h/w dependency of 'bus_dmc'
and 'bus_leftbus' is not child of 'bus_dmc'.

Even it there are some PMQoS requirement between them,
it it not proper to tie both 'bus_leftbus' and 'bus_dmc'.

>         status =3D "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos=
4412.dtsi
> index d20db2dfe8e2..a70a671acacd 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -390,6 +390,7 @@
>                         clocks =3D <&clock CLK_DIV_DMC>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_dmc_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -398,6 +399,7 @@
>                         clocks =3D <&clock CLK_DIV_ACP>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_acp_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -406,6 +408,7 @@
>                         clocks =3D <&clock CLK_DIV_C2C>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_dmc_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -459,6 +462,7 @@
>                         clocks =3D <&clock CLK_DIV_GDL>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_leftbus_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -467,6 +471,7 @@
>                         clocks =3D <&clock CLK_DIV_GDR>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_leftbus_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -475,6 +480,7 @@
>                         clocks =3D <&clock CLK_ACLK160>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_display_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -483,6 +489,7 @@
>                         clocks =3D <&clock CLK_ACLK133>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_fsys_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -491,6 +498,7 @@
>                         clocks =3D <&clock CLK_ACLK100>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_peri_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> @@ -499,6 +507,7 @@
>                         clocks =3D <&clock CLK_SCLK_MFC>;
>                         clock-names =3D "bus";
>                         operating-points-v2 =3D <&bus_leftbus_opp_table>;
> +                       #interconnect-cells =3D <0>;
>                         status =3D "disabled";
>                 };
>
> --
> 2.17.1
>


--=20
Best Regards,
Chanwoo Choi
