Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B045D07F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 23:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347694AbhKXWyM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 17:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244991AbhKXWyI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 17:54:08 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD3C061574;
        Wed, 24 Nov 2021 14:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C1JErvcbhxfEVHxYdQe+2WCbatKoUOR1fMCyHqNo4+w=; b=EG7eyj40mtJ2kFbE0yuI6uRYDu
        ugQILDQcOkPpdcKj2AafOOR739vNFkQaM4rz1gMNWAGeDbwKU339r/MB/LDYtZ3ExvX7i7S5s61Bx
        neZhhVRzuvgZH3F2jcmcdiLNBkANBHVHAKHdqQ1T5q+vAfU259j4h++GRd+Pm9OGNAuc=;
Received: from p200300ccff0d65001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:6500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mq16A-0008N5-1o; Wed, 24 Nov 2021 23:50:42 +0100
Date:   Wed, 24 Nov 2021 23:50:41 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alistair Francis <alistair23@gmail.com>,
        Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, lgirdwood@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v15 3/8] mfd: simple-mfd-i2c: Enable support for the
 silergy,sy7636a
Message-ID: <20211124235041.2840a770@aktux>
In-Reply-To: <a2fd5089-14a5-e36e-63ce-d73be3cd99a2@roeck-us.net>
References: <20211110122948.188683-1-alistair@alistair23.me>
        <20211110122948.188683-4-alistair@alistair23.me>
        <20211116000634.767dcdc0@aktux>
        <CAKmqyKPFOqWD7t6tC1Act97CVcY+yazrhwMLLr3j_wOyH50GTA@mail.gmail.com>
        <00d68181-ad3b-17d2-0150-00029d399f0f@roeck-us.net>
        <20211124203532.30577a50@aktux>
        <a2fd5089-14a5-e36e-63ce-d73be3cd99a2@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Nov 2021 12:09:44 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On 11/24/21 11:35 AM, Andreas Kemnade wrote:
> > Hi,
> >=20
> > On Tue, 23 Nov 2021 07:39:05 -0800
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >  =20
> >> On 11/23/21 4:14 AM, Alistair Francis wrote: =20
> >>> On Tue, Nov 16, 2021 at 9:10 AM Andreas Kemnade <andreas@kemnade.info=
> wrote: =20
> >>>>
> >>>> Hi,
> >>>>
> >>>> this all creates a lot of question marks...
> >>>> One of my main question is whether sy7636a =3D sy7636 (at least the
> >>>> driver in the kobo vendor kernels does not have the "A" at the end,
> >>>> whic does not necessarily mean a difference).
> >>>>
> >>>> https://www.silergy.com/products/panel_pmic
> >>>> lists only a SY7636ARMC, so chances are good that the letters were j=
ust
> >>>> stripped away by the driver developers. Printing on chip package is
> >>>> cryptic so it is not that helpful. It is just "BWNBDA" =20
> >>>
> >>> I don't have a definite answer for you. But I think it's sy7636a
> >>>
> >>> The page you linked to above lists SY7636ARMC as well as SY7627RMC,
> >>> SY7570RMC. That makes me think that the RMC is a generic suffix and
> >>> this actual IC is the SY7636A.
> >>>     =20
> >>
> >> Almost all chips have an ordering suffix, indicating things like
> >> temperature range or packaging. The datasheet says:
> >> =20
> > yes, they have. The only question is where it starts. So did you find a
> > public datasheet which you can chere
> >  =20
>=20
> I registered an account on the Silergy web site, and I was subsequently
> able to download the datasheet. The document has a "confidential"
> watermark, so I can not share it. You should be able to register an
> account and download it yourself, though.
>=20
ok, did so.=20

> >> Ordering Information
> >> SY7636 =E2=96=A1(=E2=96=A1=E2=96=A1)=E2=96=A1
> >>               | Temperature Code (C)
> >>            | Package Code (RM)
> >>          | Optional Spec Code (A)
> >>
> >> The datasheet otherwise refers to the chip as SY7636A.
> >> =20
> > so there is no indication of something like this where the A really
> > makes a difference:
> >  =20
>=20
> I may be missing it, but I see nothing in the datasheet that would indica=
te
> that or if the "A" has any relevance other than "Optional Spec Code",
> and I do not see an explanation for that term either.

well things seems to match with things I got from analysing the kobo
sources. So at least the thing in the Kobo Libra H2O seems to be that
one described in the datasheet, so we can have one sy7636a driver for
it.

BTW: If I search for a sy7636 on aliexpress I get some SO-8 lithium
charger ICs.

Regards,
Andreas

