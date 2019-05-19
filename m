Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A817F22940
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2019 23:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfESVir (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 May 2019 17:38:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59981 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfESVir (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 May 2019 17:38:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 04D75803A3; Sun, 19 May 2019 23:38:34 +0200 (CEST)
Date:   Sun, 19 May 2019 23:38:44 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 3/3] soc: fsl: add RCPM driver
Message-ID: <20190519213844.GH31403@amd>
References: <20190517033946.30763-1-ran.wang_1@nxp.com>
 <20190517033946.30763-3-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
Content-Disposition: inline
In-Reply-To: <20190517033946.30763-3-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> +
> +struct rcpm {
> +	unsigned int wakeup_cells;
> +	void __iomem *ippdexpcr_base;
> +	bool	little_endian;
> +};

Inconsistent whitespace


> +static int rcpm_pm_prepare(struct device *dev)
> +{
> +	struct device_node *np =3D dev->of_node;
> +	struct wakeup_source *ws;
> +	struct rcpm *rcpm;
> +	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1], tmp;
> +	int i, ret;
> +
> +	rcpm =3D dev_get_drvdata(dev);
> +	if (!rcpm)
> +		return -EINVAL;
> +
> +	/* Begin with first registered wakeup source */
> +	ws =3D wakeup_source_get_next(NULL);
> +	while (ws) {

while (ws =3D wakeup_source_get_next(NULL)) ?


> +static int rcpm_probe(struct platform_device *pdev)
> +{
> +	struct device	*dev =3D &pdev->dev;
> +	struct resource *r;
> +	struct rcpm		*rcpm;
> +	int ret;

Whitespace.

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzhzOQACgkQMOfwapXb+vI6ywCfVCMHtkjXb3a+eeg4lf0cWVnK
ltAAn0s9Rg5VoedxYnGb5y+G2Eo0Kxic
=n8eU
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
