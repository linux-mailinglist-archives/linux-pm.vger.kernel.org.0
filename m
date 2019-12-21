Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72A5128A8D
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 18:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLURVD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Dec 2019 12:21:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfLURVD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Dec 2019 12:21:03 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9080521D7D;
        Sat, 21 Dec 2019 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576948862;
        bh=ygQ+LLKc6onkKQohUjB4VeER1S5nL8ISyedIw3igvFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x96NU+fxBzmg38mKk0TGitI2DkyJtAaQKY/5VTvgo818kI3m0Av9s6mvDML47ta94
         P1eHg6Bp/jv5P0xoqarNn0EvL7tEDDphKBnvcv1WmbmRKyCHkjtqHCfJCQwI+86fG9
         w1y42YhGVRdJIfTYdIwHvOCJNRQyDKTs2czaTwV0=
Received: by mail-lj1-f169.google.com with SMTP id a13so13238963ljm.10;
        Sat, 21 Dec 2019 09:21:02 -0800 (PST)
X-Gm-Message-State: APjAAAXmnrWyTbJZoTZm1CArPqxhG91zVQlrxv5/ufx0j2uGkmkYZCYz
        2uX8pAVJoTFlvnXkfXTppSEf+lpm6npC++VPFus=
X-Google-Smtp-Source: APXvYqzxQbblDkSAhXsYJzBSq3hDVzSm7VnGs1SPM1HBdZJYbyVd5kmZbEvVMHb9JsKwPhMwlDsc1nNYruHS7j121S0=
X-Received: by 2002:a2e:8551:: with SMTP id u17mr8218439ljj.165.1576948860712;
 Sat, 21 Dec 2019 09:21:00 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191220120142eucas1p1f43c7a862d9c0faa72e14b21d7d697e9@eucas1p1.samsung.com>
 <20191220115653.6487-1-a.swigon@samsung.com> <20191220115653.6487-3-a.swigon@samsung.com>
In-Reply-To: <20191220115653.6487-3-a.swigon@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sun, 22 Dec 2019 02:20:24 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2mh4xcUUa+z=thdnrFsEgZ7NR5nmL4sK2ybARndhn01A@mail.gmail.com>
Message-ID: <CAGTfZH2mh4xcUUa+z=thdnrFsEgZ7NR5nmL4sK2ybARndhn01A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/7] interconnect: Relax requirement in of_icc_get_from_provider()
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

On Fri, Dec 20, 2019 at 9:03 PM Artur =C5=9Awigo=C5=84 <a.swigon@samsung.co=
m> wrote:
>
> This patch relaxes the condition in of_icc_get_from_provider() so that it
> is no longer required to set #interconnect-cells =3D <1> in the DT. In ca=
se
> of the devfreq driver for exynos-bus, #interconnect-cells is always zero.

It doesn't contain why don't need to require it. If you add more detailed
description, it is better to understand.

>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/interconnect/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index e6035c199369..74c68898a350 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -335,7 +335,7 @@ struct icc_node *of_icc_get_from_provider(struct of_p=
handle_args *spec)
>         struct icc_node *node =3D ERR_PTR(-EPROBE_DEFER);
>         struct icc_provider *provider;
>
> -       if (!spec || spec->args_count !=3D 1)
> +       if (!spec)
>                 return ERR_PTR(-EINVAL);
>
>         mutex_lock(&icc_lock);
> --
> 2.17.1
>


--=20
Best Regards,
Chanwoo Choi
