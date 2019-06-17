Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E9248030
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfFQLEL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 07:04:11 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:58076 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfFQLEK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jun 2019 07:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8XdeYg0GlEJgt8p/N7L3c6uxos5/PKeCfsQ7LLmnUYw=; b=IuvGRaou5HUNJXpE0AAbIF/rF
        u6PHU/hQ0TSVaOmy6/9EGTV43+qYi2ART6kKlk1HQfesa80EJk1W6AW7Y+Qi1Ck2o7HF21+tLD4HO
        6qOEWxIgq4jzaspY2ICoo+CnpDdABhaKgEEkWJ3UgmadL7L/65At2872P2geg9b0cM76w=;
Received: from p578b2b7d.dip0.t-ipconnect.de ([87.139.43.125] helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hcpQl-0000PF-SB; Mon, 17 Jun 2019 13:04:07 +0200
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hcpQi-0003Ls-9m; Mon, 17 Jun 2019 13:04:04 +0200
Date:   Mon, 17 Jun 2019 13:03:57 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Mark Brown <broonie@kernel.org>
Cc:     tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Message-ID: <20190617130357.41204ff7@kemnade.info>
In-Reply-To: <20190617103111.GM5316@sirena.org.uk>
References: <20190615163314.28173-1-andreas@kemnade.info>
        <20190617103111.GM5316@sirena.org.uk>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T/ae9AiTrO+noE5l2ZRMJjS"; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/T/ae9AiTrO+noE5l2ZRMJjS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 17 Jun 2019 11:31:11 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote:
>=20
> > The VDD1/VDD2 regulators on twl4030 are neither defined with
> > voltage lists nor with the continuous flag set, so
> > regulator_is_supported_voltage() returns false and an error
> > before above mentioned commit (which was considered success)
> > The result is that after the above mentioned commit cpufreq
> > does not work properly e.g. dm3730. =20
>=20
> Why is this a good fix and not defining the supported voltages?  These
> look like fairly standard linear range regulators.

I am fixing the definition of the two regulators in the patch.
I am defining them as continuous.=20
Voltage ranges are defined in
arch/arm/boot/dts/twl4030.dtsi
Only the continuous flag is missing.

Is there anything else do you want to be defined?

Regards,
Andreas

--Sig_/T/ae9AiTrO+noE5l2ZRMJjS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl0Hc50ACgkQl4jFM1s/
ye8YpA/8CrtqyQjtHJXh7k+8PQQp3Shw7IYEnKTorCO7pz3jS6Y9LTGR11kH5GVe
tsZpUKXcGjbNGPo9Urnb78t+SWySAABsd9F0zF00m0Ma8qA8KptW1Zggs1+zzm5z
P+ariX43asVqSXLbdNAEEPrFmWSeHTl1+n6vk/D3FPxAisyPKknRwPSZ6nv/6w6V
/IIiUYaJ1X4oBbr3ydhsIVmbmAsE1U6R5nl+nw5/+fRPakD2WVyv5oGCm6sgglvX
5lLnvhZE1S6YJF/eSUwlqbJt0R9KLFCWlvede0a4OAx5tDvIqqyEGzjGjUt+YKBQ
e3Jb8c2/oh29MtQHLvxxBEvWih0yact/T7ZDKUGsgJ9L0epJ56EGgFUTYmwQTDck
Y2z4jt7ciNCcBSDx1SGhRZeUoBEeCrUzsRL6Pqeuxf1s6O9bnP1Xs1mbZOYmMkVl
XPxpNqgbJNV1LLOHBHqac7nrm1lzkKPIbkNEk79A7pbWtWH67PoEUXcr5Y8Jkkjl
HM4Qwzd3KM3DZvHed666wpJ6n8LSUb7f0TqzRJPjFt8AYsgu4uoQcwWycFVDGWDS
P0t/41wyQQOCxzNIMj9HRaKnryqqo7+Frg+KaRuzXkUrAi6uwDFDH/jUbk/jmr0g
AzX7JHDzzEVtdslahvTmKXparIef4Lch42NvaE0naDOyabZLRtg=
=3Fg4
-----END PGP SIGNATURE-----

--Sig_/T/ae9AiTrO+noE5l2ZRMJjS--
