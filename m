Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679A5E7BD7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 22:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbfJ1V40 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 17:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbfJ1V40 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Oct 2019 17:56:26 -0400
Received: from earth.universe (tmo-096-224.customers.d1-online.com [80.187.96.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B46121479;
        Mon, 28 Oct 2019 21:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572299785;
        bh=8z6cLakerOz4WB/lec4BSVSyFlt8nfGEwkqPr1hMtkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVearnut9RaAziRb0P2YELOLgsjrczgHMXYyaqfgG2xOu/NR9DtEtGIjy3jKwL6G3
         A+JfyyXKZVOMfCNj9G3krwujddqTbl7+H9P2Wnor+PEW2PBmER9xZFybzigrM5SsyS
         6GReker5+FrR86XgsovxdbhCRIhUL4ZO0TOeA4dg=
Received: by earth.universe (Postfix, from userid 1000)
        id D7E863C09B2; Mon, 28 Oct 2019 22:56:15 +0100 (CET)
Date:   Mon, 28 Oct 2019 22:56:15 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: cpcap-charger: Make
 cpcap_charger_voltage_to_regval static
Message-ID: <20191028215615.3efezzsc5gji722q@earth.universe>
References: <1571672407-58950-1-git-send-email-zhongjiang@huawei.com>
 <5DB71465.6050203@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nnsnvouks6a7nqnj"
Content-Disposition: inline
In-Reply-To: <5DB71465.6050203@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nnsnvouks6a7nqnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

https://lkml.org/lkml/2019/10/21/1018

That's e3da2ce04e12 to be specific.

-- Sebastian

On Tue, Oct 29, 2019 at 12:16:37AM +0800, zhong jiang wrote:
> ping.
>=20
> On 2019/10/21 23:40, zhong jiang wrote:
> > The GCC complains the following case when compiling kernel.
> >
> > drivers/power/supply/cpcap-charger.c:563:5: warning: symbol 'cpcap_char=
ger_voltage_to_regval' was not declared. Should it be static?
> >
> > Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> > ---
> >  drivers/power/supply/cpcap-charger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/suppl=
y/cpcap-charger.c
> > index 40d96b8..c0d452e 100644
> > --- a/drivers/power/supply/cpcap-charger.c
> > +++ b/drivers/power/supply/cpcap-charger.c
> > @@ -560,7 +560,7 @@ static void cpcap_charger_update_state(struct cpcap=
_charger_ddata *ddata,
> >  	dev_dbg(ddata->dev, "state: %s\n", status);
> >  }
> > =20
> > -int cpcap_charger_voltage_to_regval(int voltage)
> > +static int cpcap_charger_voltage_to_regval(int voltage)
> >  {
> >  	int offset;
> > =20
>=20
>=20

--nnsnvouks6a7nqnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl23Y/wACgkQ2O7X88g7
+prsiA/8CFPmGfF8s7d5QI8hJ1R1KnjkOc5kHSIx954UNaHfA/gdjA3jy4oqjDDM
t6nIZUWphJerbqGPfOZIwOQdOhAmjTV5LAtRLkg+IVxEvF2jQXYMaM9Ip5Nke35a
pULPnkSeWARvMFZZYKnxG6OPe6AL8eqRaHBXRWC/Gd0XL5ndqW5SWgDeNOubmJtj
lRmJcVh8s5IB3FafOTlTGA5GQosqrxIa5fWrXL3d/bC0gE9WXa5BKw0XAgv9OSr2
dDJBpMemDCtQmXcmEN7LFg5OD4PUChdL2L60FOPpJnlpcktqNMUdUJ3S9dGuG9RZ
QmYnv2zyC9PRWf0pH0K6ovLsqQrIx0SQm9+PK6jSTyJH/KFuaeHCsdO17wq/BetW
VBZ00Bh+1hXovCQ3lwb6cIqh22hddY0KJiABOfd2kG6cw7tphLyYK8s4YQYYOBrh
GmHU2iLak+inpvB9IX/EtbCwWgahRnI2Hxp9LS15nxt4pyg1Pj+A1264IzPE6EMl
t43BGPt3MSjDIXlUDaR+MV3ibyCzwiq6j3tfihvNWcEiDQgdGSBANAvAXduo8po7
MtgkWlgBvnGSrfcdP60aKblFEqUXQUFCCzTx59j1h6Z6WUckHfZYN55BOsh9LkwW
VNAuWqJDP9iaCNz49ove8YjDuuCq6T5JH+jCPusa6Pg1obbvbYw=
=NLra
-----END PGP SIGNATURE-----

--nnsnvouks6a7nqnj--
