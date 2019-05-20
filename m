Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B8322F80
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfETI4u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 04:56:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47730 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETI4u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 04:56:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 197348021D; Mon, 20 May 2019 10:56:38 +0200 (CEST)
Date:   Mon, 20 May 2019 10:56:47 +0200
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
Message-ID: <20190520085647.GA9748@amd>
References: <20190517033946.30763-1-ran.wang_1@nxp.com>
 <20190517033946.30763-3-ran.wang_1@nxp.com>
 <20190519213844.GH31403@amd>
 <AM5PR0402MB2865EC5E1EF12C6C1D3C5566F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <AM5PR0402MB2865EC5E1EF12C6C1D3C5566F1060@AM5PR0402MB2865.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +static int rcpm_pm_prepare(struct device *dev) {
> > > +	struct device_node *np =3D dev->of_node;
> > > +	struct wakeup_source *ws;
> > > +	struct rcpm *rcpm;
> > > +	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1], tmp;
> > > +	int i, ret;
> > > +
> > > +	rcpm =3D dev_get_drvdata(dev);
> > > +	if (!rcpm)
> > > +		return -EINVAL;
> > > +
> > > +	/* Begin with first registered wakeup source */
> > > +	ws =3D wakeup_source_get_next(NULL);
> > > +	while (ws) {
> >=20
> > while (ws =3D wakeup_source_get_next(NULL)) ?
>=20
> Actually, we only pass NULL to wakeup_source_get_next() at very first
> call to get 1st wakeup source. Then in the while loop, we will fetch
> next source but not 1st, that's different. I am afraid your suggestion
> is not quite correct.

Sorry, I seen your next version before seeing this explanation.

You are right, but the current code is "interesting". What about

    ws =3D NULL;
    while (ws =3D wakeup_source_get_next(NULL)) ...

then?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzia88ACgkQMOfwapXb+vLCHQCdEiZVnts+sVGDltC60TnL3F9y
ltIAn0M2k/oHNFq1zm74JskvAw6PG/L7
=/fdT
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
