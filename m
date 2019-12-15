Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0066D11F88D
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2019 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfLOPmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 10:42:21 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37228 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfLOPmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 10:42:21 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so2725811ioc.4;
        Sun, 15 Dec 2019 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Sj9K/Fg/Lp6+H1dkSUhFxjPXudhpqL7Gotq9vKzF4I=;
        b=aNI7zL5BW90R+OYPkdGKAQQHwnE+TTd3rXHfLCytAOHAVtTaoyLJQ+BAI3gs+I0wiC
         EI0qLinJcWxwssodkMC4IbXDKTCUKCVgRKvE5+V9xI1KDc+Wy73hOIxHvpJQH3PVOC0q
         b9VfJ9DReaRmr0cy3VJcMYl7DART9zbvLziDREuOypti1CqLHjkfGCDVBijwA0s5yhl7
         8z/R7UlTf4eASf1crwDP+3OBqr/cq3qoZTEl204qRTn66rgFSzmBIEBMD/2DEpkSPlk1
         cxSJkjxrsRo7XsbJoAPY5d9/M7ogOEjXcMuZQrIXL+xaQ4DvxXxdcXe8xULCrlA078bU
         i9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Sj9K/Fg/Lp6+H1dkSUhFxjPXudhpqL7Gotq9vKzF4I=;
        b=WrYnmfzkA9/WYZTxtAaJXbnWfCzmyWCjlUuH5zV1ub2FgkTcOyGTpboM2Tgb85M4ar
         4/+xqD9/3ign/LcAUjKmbXlzU5N7A9PPxdPT8KvaW1VDiqX6WimPtGl3zfnKdcDRkJPi
         Ay+ym72uSbXqHPELPnkIH8h9TxqTXZEmaVjlia/0guSqML3dQSHNMN9OWHMIP97whwv6
         O0iz5DUulwVdA54tYzsY4ti/9tCCcee/OrTU50vknVl/igr62t352BlVcePr3Pcw5bnt
         CUXazcB1H0MoRR9jASCS03AZInzzayBKLGT0rvIBXpg5Q+niu0aKho/MLizhX6vgaHDT
         fe2Q==
X-Gm-Message-State: APjAAAU3GABadS/AoQNypoYOJwr/V28JPws6ILYRzjeocXvPOUdHfU+u
        nU+A0lbaA0WOc2YKdr+NNb/7mUTs4YTDza18S30=
X-Google-Smtp-Source: APXvYqws70XxM0JoLHNpgvw5pBBvXrE4HabAxu+lsW18wz8a5sI525dN+rR4EXNq0736nWqzgu37UyiDgIYx3jFXEM4=
X-Received: by 2002:a02:c611:: with SMTP id i17mr8752837jan.28.1576424540734;
 Sun, 15 Dec 2019 07:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20191214181130.25808-1-tiny.windzz@gmail.com> <CAGTfZH2CS6o-zaHXReKJXzxsU_jfYKg2WL7uGpzyaFNhgTSVbg@mail.gmail.com>
In-Reply-To: <CAGTfZH2CS6o-zaHXReKJXzxsU_jfYKg2WL7uGpzyaFNhgTSVbg@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 15 Dec 2019 23:42:09 +0800
Message-ID: <CAEExFWs7YejweJLDxcx9bECgVRFAVx6xL2T+_76Z239Pa-XyNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / devfreq: rockchip-dfi: add missing of_node_put()
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 15, 2019 at 11:31 PM Chanwoo Choi <chanwoo@kernel.org> wrote:
>
> 2019=EB=85=84 12=EC=9B=94 15=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 3:12=
, Yangtao Li <tiny.windzz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > of_node_put needs to be called when the device node which is got
> > from of_parse_phandle has finished using.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/devfreq/event/rockchip-dfi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/eve=
nt/rockchip-dfi.c
> > index 5d1042188727..45b190e443d8 100644
> > --- a/drivers/devfreq/event/rockchip-dfi.c
> > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > @@ -200,6 +200,7 @@ static int rockchip_dfi_probe(struct platform_devic=
e *pdev)
> >         node =3D of_parse_phandle(np, "rockchip,pmu", 0);
> >         if (node) {
> >                 data->regmap_pmu =3D syscon_node_to_regmap(node);
> > +               of_node_put(node);
> >                 if (IS_ERR(data->regmap_pmu))
> >                         return PTR_ERR(data->regmap_pmu);
> >         }
> > --
> > 2.17.1
> >
>
> Applied it. Better to use the capital letter for first char of sentence.

Thx!

Yangtao

>
> --
> Best Regards,
> Chanwoo Choi
