Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF4845CD5B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245210AbhKXTjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 14:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbhKXTjC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 14:39:02 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC930C061574;
        Wed, 24 Nov 2021 11:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q0t2vlvXal39O8KUBbebiSGPvmsmjja+oK/ATdwZIWs=; b=eYVULo7WCY/ampnVyzdqu4sNfE
        3+lmQOXnfng4jSiy0XvGS8o9kzDzoxc/87aKd5D1h2a5zHuhd+8ADwqu0FTIkT9Cm/u7l7Sa2cS5k
        8AtXiB4TiMfbbYKP1fF84CTpzMqVI4k1fSMkaIIgXksXZ0cvuP25Oc/nWz7OZMUUawRQ=;
Received: from p200300ccff0d65001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:6500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mpy3J-0007MB-IZ; Wed, 24 Nov 2021 20:35:33 +0100
Date:   Wed, 24 Nov 2021 20:35:32 +0100
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
Message-ID: <20211124203532.30577a50@aktux>
In-Reply-To: <00d68181-ad3b-17d2-0150-00029d399f0f@roeck-us.net>
References: <20211110122948.188683-1-alistair@alistair23.me>
        <20211110122948.188683-4-alistair@alistair23.me>
        <20211116000634.767dcdc0@aktux>
        <CAKmqyKPFOqWD7t6tC1Act97CVcY+yazrhwMLLr3j_wOyH50GTA@mail.gmail.com>
        <00d68181-ad3b-17d2-0150-00029d399f0f@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, 23 Nov 2021 07:39:05 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On 11/23/21 4:14 AM, Alistair Francis wrote:
> > On Tue, Nov 16, 2021 at 9:10 AM Andreas Kemnade <andreas@kemnade.info> =
wrote: =20
> >>
> >> Hi,
> >>
> >> this all creates a lot of question marks...
> >> One of my main question is whether sy7636a =3D sy7636 (at least the
> >> driver in the kobo vendor kernels does not have the "A" at the end,
> >> whic does not necessarily mean a difference).
> >>
> >> https://www.silergy.com/products/panel_pmic
> >> lists only a SY7636ARMC, so chances are good that the letters were just
> >> stripped away by the driver developers. Printing on chip package is
> >> cryptic so it is not that helpful. It is just "BWNBDA" =20
> >=20
> > I don't have a definite answer for you. But I think it's sy7636a
> >=20
> > The page you linked to above lists SY7636ARMC as well as SY7627RMC,
> > SY7570RMC. That makes me think that the RMC is a generic suffix and
> > this actual IC is the SY7636A.
> >  =20
>=20
> Almost all chips have an ordering suffix, indicating things like
> temperature range or packaging. The datasheet says:
>=20
yes, they have. The only question is where it starts. So did you find a
public datasheet which you can chere

> Ordering Information
> SY7636 =E2=96=A1(=E2=96=A1=E2=96=A1)=E2=96=A1
>              | Temperature Code (C)
>           | Package Code (RM)
>         | Optional Spec Code (A)
>=20
> The datasheet otherwise refers to the chip as SY7636A.
>=20
so there is no indication of something like this where the A really
makes a difference:

commit 28e64a68a2ef1c48f30e8b6803725199929069fc
Author: Daniel Jeong <gshark.jeong@gmail.com>
Date:   Tue Nov 12 15:08:58 2013 -0800

    backlight: lm3630: apply chip revision
   =20
    The LM3630 chip was revised by TI and chip name was also changed to
    LM3630A.  And register map, default values and initial sequences are
    changed.  The files, lm3630_bl.{c,h} are replaced by lm3630a_bl.{c,h} Y=
ou
    can find more information about LM3630A(datasheet, evm etc) at
    http://www.ti.com/product/lm3630a

That is good to know. Thanks for your investigation.=20

Regards,
Andreas
