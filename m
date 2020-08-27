Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD37253D18
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 07:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgH0FLE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 01:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgH0FLD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 01:11:03 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC8CC061240;
        Wed, 26 Aug 2020 22:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FtBbdyMfeeBQSJz0ZhSXfAlqnNGhPBDN8gv9qmafBlo=; b=ncsiABwTDcPMYRpZQckinWUIn
        O7LSRHxQSLYCyO9iuP16qlLKPIeGWSMZeEl/bnRgjRA5NF0DnuI+cjiHGli8HHyv/ZZMZESRS7ojy
        BID0JCcXJZh2fKbKWz8vGSGnq6LRhpriWSxc3EAer13xTphughtNmBlWjelv6HSnxBl/k=;
Received: from ip-109-41-66-178.web.vodafone.de ([109.41.66.178] helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kBABd-0004Yq-Oj; Thu, 27 Aug 2020 07:10:59 +0200
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1kBABa-0001DP-Ty; Thu, 27 Aug 2020 07:10:54 +0200
Date:   Thu, 27 Aug 2020 07:10:19 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/2] power: supply: Add support for RN5T618/RC5T619
 charger and fuel gauge
Message-ID: <20200827071019.7022301c@kemnade.info>
In-Reply-To: <20200826215950.bkzk76lwax7l6arz@earth.universe>
References: <20200815165610.10647-1-andreas@kemnade.info>
        <20200815165610.10647-2-andreas@kemnade.info>
        <20200826174817.vhus3j4i4t7u7jc4@earth.universe>
        <20200826202834.42b1673f@aktux>
        <20200826215950.bkzk76lwax7l6arz@earth.universe>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kyTL0mKiSKwRlAhHZgPo7Ph"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/kyTL0mKiSKwRlAhHZgPo7Ph
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 26 Aug 2020 23:59:50 +0200
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Hi,
>=20
> On Wed, Aug 26, 2020 at 08:28:34PM +0200, Andreas Kemnade wrote:
> > On Wed, 26 Aug 2020 19:48:17 +0200
> > Sebastian Reichel <sebastian.reichel@collabora.com> wrote: =20
> > > On Sat, Aug 15, 2020 at 06:56:09PM +0200, Andreas Kemnade wrote: =20
> > > > [...]
> > > > +static int rn5t618_battery_current_now(struct rn5t618_power_info *=
info,
> > > > +				       union power_supply_propval *val)
> > > > +{
> > > > +	u16 res;
> > > > +	int ret;
> > > > +
> > > > +	ret =3D rn5t618_battery_read_doublereg(info, RN5T618_CC_AVEREG1, =
&res);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	val->intval =3D res;
> > > > +	/* 2's complement */
> > > > +	if (val->intval & (1 << 13))
> > > > +		val->intval =3D val->intval - (1 << 14); =20
>=20
> Btw. I think sign_extend32() can be used here?
>=20
> > > > +	/* negate current to be positive when discharging */
> > > > +	val->intval *=3D -1000;   =20
> > >=20
> > > mh, the sign is not documented (which should be fixed). At least
> > > sbs-battery does it the other way around (negative current when
> > > discharging, positive otherwise). Some drivers do not support
> > > signed current and always report positive values (e.g. ACPI driver).
> > >=20
> > > What did you use as reference for swapping the sign?
> > >  =20
> > Well, I have searched for documentation, found nothing and used the
> > bq27xxx driver as reference  which I am used to from the GTA04/GTA02,
> > so things behave equal. That are the devices where a was most
> > intensively looking at those values.
> > I thought that there would be some unwritten rule about that. =20
>=20
> The mess is mostly due to lacking reviewing from my side
> (and possibly my predecessors). I just went through a dozen of
> drivers and it looks like most either do not support signed current
> (and use negative values as error code :() or use negative current
> for discharge. I could not find any other driver using negative
> numbers for charging. I think it's best to negative =3D discharge as
> official correct value and will send an update patch for the
> documentation later.
>=20
ok, I will remove that sign-change and keep/update the comment
so that you know that the driver does it the official way
and send a v2 with the other things you mentioned.

Regards,
Andreas

--Sig_/kyTL0mKiSKwRlAhHZgPo7Ph
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl9HQDsACgkQl4jFM1s/
ye8x/w//ddKmAMtDh/yN1Lq+lECRNbWAZpc4SP4ObqqZZ+O+a/a1J7Op5FLYfLHN
YeLYLUymiotJLKlY6WtJDsUHSzlAUGA2qXSmN+tqzlIgENjr0JWY3rlCwRQ+SZaP
CJ1Iyygx68x+DDFHpsmWDyeDkMYRLxzYLX+Ps+iw0MNIjqGStqkngZ8SoOj1Yqwl
3LZ3FNV/MzMDdHJVk7WeYkRX9y/j6eCc4noiXeM0BJbC6Xv9UcLLz4d6RfYhBZLn
vqETJt0v/IBXTy2rap38Hd+Sa0l7gmg9MPKzn30LbxYbzkCXSMlcbDV/lvtQvddN
+UBjKBnwNcvdH0NJOpALZ8DcXlG+YPEg3n61eL2VLLDkSN/vmtij0Fy+L0paIF31
Diee1W/uuAj7CAU9nP9jjgx3nC281gEvBq2UpqZzbB9ElALE2pEMzq70CO5AloZQ
ObVC076t0jpulMl97sIqDdgiJoqDckMjVOEXtc97osuFQYECBLoV+ievO1vd++Cl
R08ht6tHai+BKrlbHhaWw45ztrJJu3sOGUOHYWyWduywHYT8E5zzJBRRYxGUpMi4
YksqSX2JKcCP0U/mchQZs0V8FV8i/kTOJREHL6jYTDjGjAi1OfYOYwWoD03L63pP
5q9/Z63sXbmkX3uQtbHuGvRI2+ChpY6zAOzn0XHJMHK3XpwdimM=
=5h+f
-----END PGP SIGNATURE-----

--Sig_/kyTL0mKiSKwRlAhHZgPo7Ph--
