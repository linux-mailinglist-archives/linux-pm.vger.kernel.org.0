Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AA8128B60
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 21:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLUUJd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Dec 2019 15:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfLUUJd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Dec 2019 15:09:33 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D15F20700;
        Sat, 21 Dec 2019 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576958972;
        bh=JJfFCLhlkopmo4wVR32TZkulzHo1NE33kZtKC+jRwX8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qIoWyU9Fr2+SEGmnrTBoC8KenLJzObYZSJcO0wijT6vlmTRBYEiO5dzZQRjl+VHd5
         VRpM6L82ePrlJkeAMd4p4LCyf3cD/yK+x0aK4lJBStBzSZmb8AIdOCgykLIAMNGoqD
         fEsyPDsdBqn//ywd0oa6eArN22WlwhgAMi0cv+xU=
Received: by mail-lj1-f179.google.com with SMTP id u71so13593500lje.11;
        Sat, 21 Dec 2019 12:09:32 -0800 (PST)
X-Gm-Message-State: APjAAAXefr3D2KV5cOU0OHcFyNQQrWED5x0F0S+nfR+oNHOMOp72eosH
        Qmsv1lNfUpB8ETzCnDqhlrKUgE1SsysrhH1zXFo=
X-Google-Smtp-Source: APXvYqz+9TaYpA9qazzKenl6SyuSjXpHqSa8zOU8/cwyY5DW/ALCHnPENo9DzSPsoKOg/6lqqFIb2RMTFQtQMDJRhJ0=
X-Received: by 2002:a2e:a361:: with SMTP id i1mr13043160ljn.29.1576958970281;
 Sat, 21 Dec 2019 12:09:30 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191220120146eucas1p25dada01c315215d18bb8a15e3173b52c@eucas1p2.samsung.com>
 <20191220115653.6487-1-a.swigon@samsung.com> <20191220115653.6487-7-a.swigon@samsung.com>
In-Reply-To: <20191220115653.6487-7-a.swigon@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sun, 22 Dec 2019 05:08:53 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0QC5ZgVcSvXAy5tkyprZxfnwtWRa5NkRVfNP6HLMimew@mail.gmail.com>
Message-ID: <CAGTfZH0QC5ZgVcSvXAy5tkyprZxfnwtWRa5NkRVfNP6HLMimew@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/7] arm: dts: exynos: Add interconnects to
 Exynos4412 mixer
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
> This patch adds an 'interconnects' property to Exynos4412 DTS in order to
> declare the interconnect path used by the mixer. Please note that the
> 'interconnect-names' property is not needed when there is only one path i=
n
> 'interconnects', in which case calling of_icc_get() with a NULL name simp=
ly
> returns the right path.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos=
4412.dtsi
> index 48868947373e..13a679a9a107 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -771,6 +771,7 @@
>         clock-names =3D "mixer", "hdmi", "sclk_hdmi", "vp";
>         clocks =3D <&clock CLK_MIXER>, <&clock CLK_HDMI>,
>                  <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
> +       interconnects =3D <&bus_display &bus_dmc>;
>  };
>
>  &pmu {
> --
> 2.17.1
>

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

--=20
Best Regards,
Chanwoo Choi
