Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE1128B5B
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 21:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLUUBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Dec 2019 15:01:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfLUUBL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Dec 2019 15:01:11 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF5AD206EC;
        Sat, 21 Dec 2019 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576958470;
        bh=cAoG20mOdDaPDzKbP1yFgpmFG1wND9D7fIKzylMTt+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VfKHDs+UrA0zxIEDZ3/P6uaXOxZ2X+ypWsPWjAajHI0ahhdVjqi2hFHOCL6iNKHf2
         LdKldq/aPkuaE8bGlZqUqSuILfyq7f9TpU/64QWz3CN/81vc2/fVuoRmmBfhxluYq1
         nnHdDzE8BnOWyyR8v8kz/+O9liL1lZ12dD2p+los=
Received: by mail-lj1-f175.google.com with SMTP id u1so13569950ljk.7;
        Sat, 21 Dec 2019 12:01:09 -0800 (PST)
X-Gm-Message-State: APjAAAVVU0Br19cFVDh52FqNGHKlpjNVNfxzpbOBcVslqSgCDcYhObeV
        b1oCzC220zpdNFzJMppvGlo8BWe2km8E/jhIJlY=
X-Google-Smtp-Source: APXvYqyoSWFit4YcQSqBr6vLJk2CTqXrA+sNgLRokSVcuTZ0gSZDSqHSBwKiDJtfNlZKwKctroRd0nQzOWJkw4mUiBo=
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr12176163ljk.30.1576958468047;
 Sat, 21 Dec 2019 12:01:08 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
 <20191220115653.6487-1-a.swigon@samsung.com> <20191220115653.6487-5-a.swigon@samsung.com>
In-Reply-To: <20191220115653.6487-5-a.swigon@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sun, 22 Dec 2019 05:00:31 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0PBoBe5NUObMdK9ru_=+dV6N8nJk3JzM+FF3y9_y8n1w@mail.gmail.com>
Message-ID: <CAGTfZH0PBoBe5NUObMdK9ru_=+dV6N8nJk3JzM+FF3y9_y8n1w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings
 for Exynos4412
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Dec 20, 2019 at 9:02 PM Artur =C5=9Awigo=C5=84 <a.swigon@samsung.co=
m> wrote:
>
> This patch adds the following properties to the Exynos4412 DT:
>   - exynos,interconnect-parent-node: to declare connections between
>     nodes in order to guarantee PM QoS requirements between nodes;
>   - #interconnect-cells: required by the interconnect framework.
>
> Note that #interconnect-cells is always zero and node IDs are not
> hardcoded anywhere.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/b=
oot/dts/exynos4412-odroid-common.dtsi
> index 4ce3d77a6704..d9d70eacfcaf 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -90,6 +90,7 @@
>  &bus_dmc {
>         exynos,ppmu-device =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>         vdd-supply =3D <&buck1_reg>;
> +       #interconnect-cells =3D <0>;
>         status =3D "okay";
>  };
>
> @@ -106,6 +107,8 @@
>  &bus_leftbus {
>         exynos,ppmu-device =3D <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>         vdd-supply =3D <&buck3_reg>;
> +       exynos,interconnect-parent-node =3D <&bus_dmc>;
> +       #interconnect-cells =3D <0>;
>         status =3D "okay";
>  };
>
> @@ -116,6 +119,8 @@
>
>  &bus_display {
>         exynos,parent-bus =3D <&bus_leftbus>;
> +       exynos,interconnect-parent-node =3D <&bus_leftbus>;
> +       #interconnect-cells =3D <0>;
>         status =3D "okay";
>  };
>
> --
> 2.17.1
>

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

I has not yet tested on target. I'll test it on next week
and then reply the test result.

--=20
Best Regards,
Chanwoo Choi
