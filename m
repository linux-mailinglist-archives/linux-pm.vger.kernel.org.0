Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6781601
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 11:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfHEJ40 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 05:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfHEJ40 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Aug 2019 05:56:26 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5469C217D9;
        Mon,  5 Aug 2019 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564998985;
        bh=c/eJMd7h8iMY7g3oBcO09Ax6tNi/85j/LkvMdm+2LJ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kCUfwhYAxdatWJQsoVRP5kF25HVcRa1aMqKUgUJMss9brgbECYUQmepSWt2tGm/RQ
         umRuOgvoPUKkt+A7Papljrijh6QQVCW0gkYfOsbJ6bM3ez1Rp3W8VOVzCufeKWykP2
         SI9yu/NkrsRLYzfI5dB6G+qzLhW/6hIfeGIf620k=
Received: by mail-lj1-f171.google.com with SMTP id h10so7308819ljg.0;
        Mon, 05 Aug 2019 02:56:25 -0700 (PDT)
X-Gm-Message-State: APjAAAXzFIpCWS5XBf77VnlywWzZUbrTNQNiwyN3HVuC4+prFDF7C8xX
        DaepV4NDFhOVqOD6QA0HpqV/hsw07nnrY/d3cd0=
X-Google-Smtp-Source: APXvYqxzVKAd5TMLzlif6yoBQ/7YS/sKvvkA9uKhcxY/lMn1ISB5YMDZXNJeRxIeHY+6zPufLi4WkrEALvt2npvWd0M=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr21170060ljg.80.1564998983563;
 Mon, 05 Aug 2019 02:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122022eucas1p1266d90873d564894bd852c20140f8474@eucas1p1.samsung.com>
 <20190723122016.30279-2-a.swigon@partner.samsung.com> <20190724190741.GD14346@kozik-lap>
 <bda10bcc66aae96355e74c4739229d72bcc95b0d.camel@partner.samsung.com>
In-Reply-To: <bda10bcc66aae96355e74c4739229d72bcc95b0d.camel@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 5 Aug 2019 11:56:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdAhyAE96LmzV7TB1YTyNcN7Eh65Xb9caanXA-52Gskvg@mail.gmail.com>
Message-ID: <CAJKOXPdAhyAE96LmzV7TB1YTyNcN7Eh65Xb9caanXA-52Gskvg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] devfreq: exynos-bus: Extract exynos_bus_profile_init()
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        Inki Dae <inki.dae@samsung.com>,
        Seung Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 31 Jul 2019 at 15:00, Artur =C5=9Awigo=C5=84 <a.swigon@partner.sams=
ung.com> wrote:
>
> Hi,
>
> On Wed, 2019-07-24 at 21:07 +0200, Krzysztof Kozlowski wrote:
> > On Tue, Jul 23, 2019 at 02:20:06PM +0200, Artur =C5=9Awigo=C5=84 wrote:
> > > This patch adds a new static function, exynos_bus_profile_init(), ext=
racted
> > > from exynos_bus_probe().
> > >
> > > Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> > > ---
> > >  drivers/devfreq/exynos-bus.c | 106 ++++++++++++++++++++-------------=
--
> > >  1 file changed, 60 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bu=
s.c
> > > index d9f377912c10..d8f1efaf2d49 100644
> > > --- a/drivers/devfreq/exynos-bus.c
> > > +++ b/drivers/devfreq/exynos-bus.c
> > > @@ -372,12 +372,69 @@ static int exynos_bus_parse_of(struct device_no=
de *np,
> > >     return ret;
> > >  }
> > >
> > > +static int exynos_bus_profile_init(struct exynos_bus *bus,
> > > +                              struct devfreq_dev_profile *profile)
> > > +{
> > > +   struct device *dev =3D bus->dev;
> > > +   struct devfreq_simple_ondemand_data *ondemand_data;
> > > +   int ret;
> > > +
> > > +   /* Initialize the struct profile and governor data for parent dev=
ice */
> > > +   profile->polling_ms =3D 50;
> > > +   profile->target =3D exynos_bus_target;
> > > +   profile->get_dev_status =3D exynos_bus_get_dev_status;
> > > +   profile->exit =3D exynos_bus_exit;
> > > +
> > > +   ondemand_data =3D devm_kzalloc(dev, sizeof(*ondemand_data), GFP_K=
ERNEL);
> > > +   if (!ondemand_data) {
> > > +           ret =3D -ENOMEM;
> > > +           goto err;
> >
> > Just return proper error code. Less lines, obvious code since you do no=
t
> > have any cleanup in error path.
>
> I was advised to avoid modifying code being moved (in one patch). I do ma=
ke
> changes in these places in patch 04/11, i.e. change the original label 'e=
rr' to
> 'out'. What's your opinion on making the proposed changes to patches 01 a=
nd 02
> (s/goto err/return ret/) in patch 04 instead?

Yes, you're right. I also prefer not to touch moved code.

Best regards,
Krzysztof
