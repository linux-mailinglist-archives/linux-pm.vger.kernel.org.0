Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F68C74E9F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbfGYM52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 08:57:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37839 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387901AbfGYM52 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 08:57:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id c9so34421524lfh.4;
        Thu, 25 Jul 2019 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=xM6KrE+i6GTD27vbYKn5cqDmPVp4Sc2Sjq00mSvmh2U=;
        b=XXpK0Ruyln89lB3FtPJQlFIHzkNrM+OFf+i4hux201WJ2ZQ8HIQVoKrEtlgpvzYKl8
         oMsc2mWrk11bd2G5oHFfJO1z+s0WY7Dl0onn1RinPh3VwNrcKIGFzJOq9Qe6lhWUu3O7
         Q//XStbzPtGgslB+AyFj7C9tNlGfnBI+gRo9FIMgyx0jEwMeLn2x4F8wKA6r5N3IX9ub
         wCJNweqMuL6PuOwrtsjlvREok7Xhb1Sh6VxWtKC+zMYOCm8oUvl5uU6BQ/NfWo+uDRP7
         UjdD/7nLSbX5rRAp8Cy+mf/717jZ4SR7ewR9CiHXWoYJNISCHqvUACA5Bth2MyT6Bu1t
         9G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=xM6KrE+i6GTD27vbYKn5cqDmPVp4Sc2Sjq00mSvmh2U=;
        b=XxTcQPNy++k2IO6C3G3CX+gEGk1N8U/xxazqUq49qorA+iMWQc5rKPiPK1cgESQ+ZM
         kLQFVtwyP68qwJ/f/DEjqUzaPooFc7nVD78L+JqfYCQEK+Kqqdv0moF/vSxU8K5Uy4Kn
         HxHxA1NFrjDUGMnl+XGYR25bHRyOcOIfwmCoNVVmXpqZiW9HN5XADNiVkvy+/ZZ8WVSZ
         4PiM97tJnHNt4EI4p9P+Gk5/MMXAjrSYLJFIcrxTe7Y3vx+IY/TD/cJK1QL4z/HjKKNt
         fTokDp41UpypVFLKWKAbkFDUPLbKibODRdcVgSycfIPVQEFK7INH3kn+bUKFV+CHJtGq
         RvTw==
X-Gm-Message-State: APjAAAX+x8tKlm9QyLFv4pNS9rVbz0UXpF+LdJYvp0oMwREua9lRS9mH
        H+fPMirdox3+JTC1lAT5jwj+gDBLJqwde/YCsmo=
X-Google-Smtp-Source: APXvYqy87nc1SZfVl4oFMMftjXVfgZz3Rbm0BYNTg4fKAWIu9Eqqr7bor/GS6c2HKFxbPTv05+jyugcTeGyUoK+wC+g=
X-Received: by 2002:ac2:42ca:: with SMTP id n10mr23728905lfl.121.1564059445077;
 Thu, 25 Jul 2019 05:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190723122024eucas1p1ff060d072132bfbc8a8a1d10fa1f90f8@eucas1p1.samsung.com>
 <20190723122016.30279-1-a.swigon@partner.samsung.com> <20190723122016.30279-4-a.swigon@partner.samsung.com>
In-Reply-To: <20190723122016.30279-4-a.swigon@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 25 Jul 2019 21:56:48 +0900
Message-ID: <CAGTfZH09n9UOLMwNrCvcdeRCHYFO4TiB-YG2rMVuxA4bxuLCVw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/11] devfreq: exynos-bus: Change goto-based logic to
 if-else logic
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

2019=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 8:08, A=
rtur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> This patch improves code readability by changing the following construct:
>
> >    if (cond)
> >        goto passive;
> >    foo();
> >    goto out;
> >passive:
> >    bar();
> >out:
>
> into this:
>
> >    if (cond)
> >        bar();
> >    else
> >        foo();
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index cf6f6cbd0f55..4bb83b945bf7 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -505,25 +505,19 @@ static int exynos_bus_probe(struct platform_device =
*pdev)
>         node =3D of_parse_phandle(dev->of_node, "devfreq", 0);
>         if (node) {
>                 of_node_put(node);
> -               goto passive;
> +               ret =3D exynos_bus_profile_init_passive(bus, profile);
> +               if (ret < 0)
> +                       goto err;
>         } else {
>                 ret =3D exynos_bus_parent_parse_of(np, bus);
> +               if (ret < 0)
> +                       goto err;
> +
> +               ret =3D exynos_bus_profile_init(bus, profile);
> +               if (ret < 0)
> +                       goto err;
>         }
>
> -       if (ret < 0)
> -               goto err;
> -
> -       ret =3D exynos_bus_profile_init(bus, profile);
> -       if (ret < 0)
> -               goto err;
> -
> -       goto out;
> -passive:
> -       ret =3D exynos_bus_profile_init_passive(bus, profile);
> -       if (ret < 0)
> -               goto err;
> -
> -out:
>         max_state =3D bus->devfreq->profile->max_state;
>         min_freq =3D (bus->devfreq->profile->freq_table[0] / 1000);
>         max_freq =3D (bus->devfreq->profile->freq_table[max_state - 1] / =
1000);
> --
> 2.17.1
>

It seems more simple than before.
Instead, please merge patch1/2/3 to one patch. and drop the patch4.

--=20
Best Regards,
Chanwoo Choi
