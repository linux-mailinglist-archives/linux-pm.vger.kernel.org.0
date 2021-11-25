Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC5B45D57D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhKYHfT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 02:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhKYHdT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 02:33:19 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86271C06175B;
        Wed, 24 Nov 2021 23:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AoNS7IlrvP3Cw/y+6cNuB0NOoKwsJQac1U9nQY9aARk=; b=GOd7EmQhZ+dxfQMASMAE7rAhQf
        m3TRHCjskVh6GiYaotc7iOhCoWLSQMKUXt8/toE3JABI0YuPccAyj9lIxF6LZPzlDPGNgrHkjWsKE
        Hn14gNNSLAqvpiK6weqNaxhC//5EUbns3bDVMF4p2kDdSQdEoLL8Jsi4zSuk7AwBEjfc=;
Received: from p200300ccff15b4001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff15:b400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mq9C0-0003Aj-6K; Thu, 25 Nov 2021 08:29:16 +0100
Date:   Thu, 25 Nov 2021 08:29:15 +0100
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
Message-ID: <20211125082915.534b99fc@aktux>
In-Reply-To: <39b586c1-aba7-4d82-2c96-9f4ca9db4f11@roeck-us.net>
References: <20211110122948.188683-1-alistair@alistair23.me>
        <20211110122948.188683-4-alistair@alistair23.me>
        <20211116000634.767dcdc0@aktux>
        <CAKmqyKPFOqWD7t6tC1Act97CVcY+yazrhwMLLr3j_wOyH50GTA@mail.gmail.com>
        <00d68181-ad3b-17d2-0150-00029d399f0f@roeck-us.net>
        <20211124203532.30577a50@aktux>
        <a2fd5089-14a5-e36e-63ce-d73be3cd99a2@roeck-us.net>
        <20211124235041.2840a770@aktux>
        <39b586c1-aba7-4d82-2c96-9f4ca9db4f11@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, 24 Nov 2021 14:56:46 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

[...]
> >>>> Ordering Information
> >>>> SY7636 =E2=96=A1(=E2=96=A1=E2=96=A1)=E2=96=A1
> >>>>                | Temperature Code (C)
> >>>>             | Package Code (RM)
> >>>>           | Optional Spec Code (A)
> >>>>
> >>>> The datasheet otherwise refers to the chip as SY7636A.
> >>>>    =20
> >>> so there is no indication of something like this where the A really
> >>> makes a difference:
> >>>     =20
> >>
> >> I may be missing it, but I see nothing in the datasheet that would ind=
icate
> >> that or if the "A" has any relevance other than "Optional Spec Code",
> >> and I do not see an explanation for that term either. =20
> >=20
> > well things seems to match with things I got from analysing the kobo
> > sources. So at least the thing in the Kobo Libra H2O seems to be that
> > one described in the datasheet, so we can have one sy7636a driver for
> > it.
> >=20
> > BTW: If I search for a sy7636 on aliexpress I get some SO-8 lithium
> > charger ICs.
> >  =20
>=20
> The datasheet says "PMIC for Electronic Paper Display".
>=20
Correct. And we have the silergy vendor prefix in the dt compatible, so
if some other company decides to call its chip sy7636, we can
distinguish.

Regards,
Andreas
