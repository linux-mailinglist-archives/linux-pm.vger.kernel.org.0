Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7E2303F
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfETJZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 05:25:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48494 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbfETJZC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 05:25:02 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C27EA80450; Mon, 20 May 2019 11:24:49 +0200 (CEST)
Date:   Mon, 20 May 2019 11:24:59 +0200
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
Message-ID: <20190520092459.GC9748@amd>
References: <20190517033946.30763-1-ran.wang_1@nxp.com>
 <20190517033946.30763-3-ran.wang_1@nxp.com>
 <20190519213844.GH31403@amd>
 <AM5PR0402MB2865EC5E1EF12C6C1D3C5566F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <20190520085647.GA9748@amd>
 <AM5PR0402MB2865F4574B19761848B001F9F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <20190520090748.GB9748@amd>
 <AM5PR0402MB2865E28B2E2296CB878ACEA2F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <AM5PR0402MB2865E28B2E2296CB878ACEA2F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > You are right, but the current code is "interesting". What about
> > > >
> > > >     ws =3D NULL;
> > > >     while (ws =3D wakeup_source_get_next(NULL)) ...
> > > >
> > > > then?
> > >
> > > Did you mean:
> > >      ws =3D NULL;
> > >      while (ws =3D wakeup_source_get_next(ws)) ...
> > >
> > >    Yes, that will be the same to my original logic, do you recommend
> > > to change to this? :)
> >=20
> > Yes please. It will be less confusing to the reader.
>=20
> OK, if no other comment, I will work out v4, fix this and extra ','
> =20
> > Thanks (and sorry for cross-talk),
>=20
> That's OK, thanks for your time.

You can add

Acked-by: Pavel Machek <pavel@ucw.cz>

to that version.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzicmsACgkQMOfwapXb+vI/kACfXfr5zSF0QsKLaIDUnn6ldYdL
9rUAn1IvhOf/+HglBb9Ro5uZKDJsTOI+
=fAL6
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
