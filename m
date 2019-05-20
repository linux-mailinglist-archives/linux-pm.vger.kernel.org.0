Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6E22FCE
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfETJHw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 05:07:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48070 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfETJHv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 05:07:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8BC7080450; Mon, 20 May 2019 11:07:39 +0200 (CEST)
Date:   Mon, 20 May 2019 11:07:49 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Pavel Machek <pavel@denx.de>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] soc: fsl: add RCPM driver
Message-ID: <20190520090748.GB9748@amd>
References: <20190517033946.30763-1-ran.wang_1@nxp.com>
 <20190517033946.30763-3-ran.wang_1@nxp.com>
 <20190519213844.GH31403@amd>
 <AM5PR0402MB2865EC5E1EF12C6C1D3C5566F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <20190520085647.GA9748@amd>
 <AM5PR0402MB2865F4574B19761848B001F9F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <AM5PR0402MB2865F4574B19761848B001F9F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-05-20 09:03:50, Ran Wang wrote:
> Hi Pavel,
>=20
> On Monday, May 20, 2019 16:57, Pavel Machek wrote:
> >=20
> > Hi!
> >=20
> > > > > +static int rcpm_pm_prepare(struct device *dev) {
> > > > > +	struct device_node *np =3D dev->of_node;
> > > > > +	struct wakeup_source *ws;
> > > > > +	struct rcpm *rcpm;
> > > > > +	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1], tmp;
> > > > > +	int i, ret;
> > > > > +
> > > > > +	rcpm =3D dev_get_drvdata(dev);
> > > > > +	if (!rcpm)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	/* Begin with first registered wakeup source */
> > > > > +	ws =3D wakeup_source_get_next(NULL);
> > > > > +	while (ws) {
> > > >
> > > > while (ws =3D wakeup_source_get_next(NULL)) ?
> > >
> > > Actually, we only pass NULL to wakeup_source_get_next() at very first
> > > call to get 1st wakeup source. Then in the while loop, we will fetch
> > > next source but not 1st, that's different. I am afraid your suggestion
> > > is not quite correct.
> >=20
> > Sorry, I seen your next version before seeing this explanation.
> >=20
> > You are right, but the current code is "interesting". What about
> >=20
> >     ws =3D NULL;
> >     while (ws =3D wakeup_source_get_next(NULL)) ...
> >=20
> > then?
>=20
> Did you mean:
>      ws =3D NULL;
>      while (ws =3D wakeup_source_get_next(ws)) ...
>=20
>    Yes, that will be the same to my original logic, do you recommend to c=
hange
> to this? :)

Yes please. It will be less confusing to the reader.

Thanks (and sorry for cross-talk),
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzibmQACgkQMOfwapXb+vJOsgCgqGW6NAUYHlbtL2j5RhCyhuS2
zxMAn1WDZj1TbQDXI+hk99qNzljFSRtI
=XWgf
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
