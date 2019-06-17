Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE9488D9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFQQ1s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:27:48 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:58722 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfFQQ1s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jun 2019 12:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V1J5KcSxrmH6kMxoNhKSoFAdQCQGIWo+tRQvbszLDJM=; b=KAmzeS4j/v69f/vQoCyWhWlPgL
        mGRwjrgL+MK7xaGU9oj98xKnUYud42p/Yy2Y3GnpQfOtwckJZD+F2LP5uD5BYNXSlG8lW3IQ9KcWa
        BQty8OMnl+zEnFxexcXLU5ilJQPZRj6h2JpaUakEhNf8S9Ruo5gj03cgzelBhpMSD5EY=;
Received: from p5dcc3c96.dip0.t-ipconnect.de ([93.204.60.150] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hcuTw-0003bY-3i; Mon, 17 Jun 2019 18:27:44 +0200
Date:   Mon, 17 Jun 2019 18:27:43 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Mark Brown <broonie@kernel.org>
Cc:     tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Message-ID: <20190617182743.7f40f2ee@aktux>
In-Reply-To: <20190617114048.GN5316@sirena.org.uk>
References: <20190615163314.28173-1-andreas@kemnade.info>
        <20190617103111.GM5316@sirena.org.uk>
        <20190617130357.41204ff7@kemnade.info>
        <20190617114048.GN5316@sirena.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 Jun 2019 12:40:48 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jun 17, 2019 at 01:03:57PM +0200, Andreas Kemnade wrote:
> > Mark Brown <broonie@kernel.org> wrote: =20
> > > On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote: =20
>=20
> > > Why is this a good fix and not defining the supported voltages?  These
> > > look like fairly standard linear range regulators. =20
>=20
> > I am fixing the definition of the two regulators in the patch.
> > I am defining them as continuous.=20
> > Voltage ranges are defined in
> > arch/arm/boot/dts/twl4030.dtsi
> > Only the continuous flag is missing. =20
>=20
> > Is there anything else do you want to be defined? =20
>=20
> These regulators are not continuous regulators as far as I can see, they
> are normal linear range regulators and so should have their voltages
> enumerable like any other linear range regulator.

Citing tps65950 trm page 55:

The device contains three switch-mode power supplies (SMPS):
=E2=80=A2 VDD1: 1.2-A, buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, in s=
teps of 12.5 mV)
=E2=80=A2 VDD2: 600-mA buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, in s=
teps of 12.5 mV, and 1.5 V as a
   single programmable value)

you are right, they are not really continuous. So should I add these
68 steps they have as a voltage list?

I think they are nearly continuous, so we should IMHO rather take that
not that strict. I guess there are no really continuous regulators, all
have steps as voltage is specified in a limited resolution. So what is
the exact meaning of that flag here?

I think it is common sense to specify these regulators as continuous.
Max and min values are already in arch/arm/boot/dts/twl4030.dtsi.

Regards,
Andreas
