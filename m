Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C25128EFF
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 18:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfLVRJV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 12:09:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfLVRJV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 22 Dec 2019 12:09:21 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46063206B7;
        Sun, 22 Dec 2019 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577034559;
        bh=geqtjwNhYhPjKOQTr6T9PrwqzqjPWdQ7WW0r3/weydI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=07BQMQ6Hi57dx/JRXrxf2u1oNEjJQB034YRiconHLdRB0lLKc4Hwfe97RW05Uv/tq
         AKKDhe6nGpWcF/9npYiw5Fq7zftXQnLc13UPWdC0kF0ifrclA2+d+VZlDC8Ya5r7E8
         tfwfwll4JDkG/JDZSwUMYCfglmEytTVVBzC+tQJE=
Received: by mail-lf1-f52.google.com with SMTP id 15so10942870lfr.2;
        Sun, 22 Dec 2019 09:09:19 -0800 (PST)
X-Gm-Message-State: APjAAAWdkqqIfYX1GDzTIc5509s+wbpIH7AjL2VBEL49BBdSNBNLGv7+
        va06MXGAiwGHQMgbCtUlsZzis6+27yCosBJMzwk=
X-Google-Smtp-Source: APXvYqwBbqcf1Pd8XBumubRFDeYehrjcMzLoDXNvGe/zro6dSDNnXlMk5m00bIDMFtqyXV44zbdUED/i0ZPagGGw2/Y=
X-Received: by 2002:ac2:5444:: with SMTP id d4mr15264932lfn.49.1577034557468;
 Sun, 22 Dec 2019 09:09:17 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191220120143eucas1p1c9b01ae8c2e4ecd70423ef9d8001536f@eucas1p1.samsung.com>
 <20191220115653.6487-1-a.swigon@samsung.com> <20191220115653.6487-4-a.swigon@samsung.com>
In-Reply-To: <20191220115653.6487-4-a.swigon@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Mon, 23 Dec 2019 02:08:41 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0zfvPYtTv6v+5nq99Gd2PVtg+O20dwf2nbV2j1U0nxCQ@mail.gmail.com>
Message-ID: <CAGTfZH0zfvPYtTv6v+5nq99Gd2PVtg+O20dwf2nbV2j1U0nxCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/7] interconnect: Allow inter-provider pairs to be configured
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
> In the exynos-bus devfreq driver every bus is probed separately and is

IMHO, the patch description should specify the more general cause
why have to be changed. Actually, almost people might not know
the 'exynos-bus'. So, firstly, you have to specify the general cause
why this patch is necessary without 'exynos-bus' word and then
add the real use-case with 'exynos-bus' example.

> assigned a separate interconnect provider. However, the interconnect
> framework does not call the '->set' callback for pairs of nodes which
> belong to different providers.
>
> This patch adds support for a new boolean 'inter_set' field in struct
> icc_provider. Setting it to 'true' enables calling '->set' for
> inter-provider node pairs. All existing users of the interconnect
> framework allocate this structure with kzalloc, and are therefore
> unaffected.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> ---
>  drivers/interconnect/core.c           | 11 +++++------
>  include/linux/interconnect-provider.h |  2 ++
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 74c68898a350..a28bd0f8a497 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -259,23 +259,22 @@ static int aggregate_requests(struct icc_node *node=
)
>  static int apply_constraints(struct icc_path *path)
>  {
>         struct icc_node *next, *prev =3D NULL;
> +       struct icc_provider *p;
>         int ret =3D -EINVAL;
>         int i;
>
>         for (i =3D 0; i < path->num_nodes; i++) {
>                 next =3D path->reqs[i].node;
> +               p =3D next->provider;
>
> -               /*
> -                * Both endpoints should be valid master-slave pairs of t=
he
> -                * same interconnect provider that will be configured.
> -                */
> -               if (!prev || next->provider !=3D prev->provider) {
> +               /* both endpoints should be valid master-slave pairs */
> +               if (!prev || (p !=3D prev->provider && !p->inter_set)) {
>                         prev =3D next;
>                         continue;
>                 }
>
>                 /* set the constraints */
> -               ret =3D next->provider->set(prev, next);
> +               ret =3D p->set(prev, next);
>                 if (ret)
>                         goto out;
>
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interc=
onnect-provider.h
> index cc965b8fab53..b6ae0ee686c5 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -41,6 +41,7 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle=
_args *spec,
>   * @xlate: provider-specific callback for mapping nodes from phandle arg=
uments
>   * @dev: the device this interconnect provider belongs to
>   * @users: count of active users
> + * @inter_set: whether inter-provider pairs will be configured with @set
>   * @data: pointer to private data
>   */
>  struct icc_provider {
> @@ -53,6 +54,7 @@ struct icc_provider {
>         struct icc_node* (*xlate)(struct of_phandle_args *spec, void *dat=
a);
>         struct device           *dev;
>         int                     users;
> +       bool                    inter_set;
>         void                    *data;
>  };
>
> --
> 2.17.1
>


--=20
Best Regards,
Chanwoo Choi
