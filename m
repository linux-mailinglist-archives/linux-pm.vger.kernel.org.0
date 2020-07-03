Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D76214068
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 22:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGCUeu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 16:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCUeu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jul 2020 16:34:50 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA09B208B8;
        Fri,  3 Jul 2020 20:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593808490;
        bh=AH0GTCbSop8eZujnaf/Z85LbZvsVu310x9dmthGY7qo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BFUne6XCpVnoyuqdrs3695kjpBOdZDUJ6qdF/ujE3reI8k51V2jxyLOZHtrVSH6NE
         HCzS8dlXg8SxwgXOHxM889bNowfBijmo7DGGxDxEZgASlaJuI7nQ446I+kOoyfDIWk
         O6rM8YRYO+CSSymMjoDVm5bN03/DwHRpUzfG77Bg=
Received: by mail-lj1-f172.google.com with SMTP id f5so22503272ljj.10;
        Fri, 03 Jul 2020 13:34:49 -0700 (PDT)
X-Gm-Message-State: AOAM533G/p/QIL90dAuvzMwW4ug2D5vFtkPh4nE2ayjeS5dG6qf9u09V
        9z8BndmUCeha6Uc2O72HsLDf1scGy3Czjy6GgY8=
X-Google-Smtp-Source: ABdhPJzJ1IRgn3b/usnN9r+/avS3HfXMB23+RrbrqwAzGjub3iwXzVKFekPat3URzO7ASd63Wf+D4X6k3nsjOOsLpuc=
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr16546043ljk.27.1593808488121;
 Fri, 03 Jul 2020 13:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200703100810.12304-1-cw00.choi@samsung.com> <CGME20200703095657epcas1p187b7f90a4a33da7791a83a78760f3a91@epcas1p1.samsung.com>
 <20200703100810.12304-3-cw00.choi@samsung.com> <6027cf29-ea6f-0a27-3e39-a80c24b80bb8@gmail.com>
In-Reply-To: <6027cf29-ea6f-0a27-3e39-a80c24b80bb8@gmail.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sat, 4 Jul 2020 05:34:11 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1uWaSHW5+URTj3SjvxRRZqF9WtMfofe+8X7BHCrk3R0g@mail.gmail.com>
Message-ID: <CAGTfZH1uWaSHW5+URTj3SjvxRRZqF9WtMfofe+8X7BHCrk3R0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: Add governor flags to clarify the features
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>, lukasz.luba@arm.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        jonathanh@nvidia.com, Abel Vesa <abel.vesa@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On Fri, Jul 3, 2020 at 7:46 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 03.07.2020 13:08, Chanwoo Choi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra3=
0-devfreq.c
> > index e94a27804c20..620ecd250d7c 100644
> > --- a/drivers/devfreq/tegra30-devfreq.c
> > +++ b/drivers/devfreq/tegra30-devfreq.c
> > @@ -765,10 +765,12 @@ static int tegra_governor_event_handler(struct de=
vfreq *devfreq,
> >
> >  static struct devfreq_governor tegra_devfreq_governor =3D {
> >       .name =3D "tegra_actmon",
> > +     .flag =3D DEVFREQ_GOV_FLAG_ATTR_COMMON
> > +             | DEVFREQ_GOV_FLAG_ATTR_POLLING_INTERVAL,
>
> Hello, Chanwoo!
>
> There is a typo here, it should be ".attr =3D ".

Ah. Sorry. After changed the name, I didn't test COMPILE_TEST.

>
> > +     .flag =3D DEVFREQ_GOV_FLAG_FLAG_IMMUTABLE,
> > +             | DEVFREQ_GOV_FLAG_FLAG_IRQ_DRIVEN,
>
> There is a typo here too FLAG_FLAG ^

Thanks.

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
