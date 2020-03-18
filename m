Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96C2189CA1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 14:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCRNLb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 09:11:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44342 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgCRNLa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 09:11:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 1E0CF294B84
Date:   Wed, 18 Mar 2020 09:11:14 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, airlied@linux.ie, daniel@ffwll.ch,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com,
        patrick.bellasi@matbug.net, orjan.eide@arm.com,
        rdunlap@infradead.org, mka@chromium.org
Subject: Re: [PATCH v5 5/5] drm/panfrost: Register devfreq cooling and
 attempt to add Energy Model
Message-ID: <20200318131114.GA1812@kevin>
References: <20200318114548.19916-1-lukasz.luba@arm.com>
 <20200318114548.19916-6-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20200318114548.19916-6-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

On Wed, Mar 18, 2020 at 11:45:48AM +0000, Lukasz Luba wrote:
> Register devfreq cooling device and attempt to register Energy Model. This
> will add the devfreq device to the Energy Model framework. It will create
> a dedicated and unified data structures used i.e. in thermal framework.
> The last NULL parameter indicates that the power model is simplified and
> created based on DT 'dynamic-power-coefficient', voltage and frequency.
>=20
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index 413987038fbf..8759a73db153 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -105,7 +105,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfd=
ev)
>  	}
>  	pfdev->devfreq.devfreq =3D devfreq;
> =20
> -	cooling =3D of_devfreq_cooling_register(dev->of_node, devfreq);
> +	cooling =3D devfreq_cooling_em_register(devfreq, NULL);
>  	if (IS_ERR(cooling))
>  		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
>  	else
> --=20
> 2.17.1
>=20

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl5yHe0ACgkQ/v5QWgr1
WA3gpxAAhQnRoPbq6S2+0Lb7C5bP7Ta67p3aDFRc/xxNEKsqRl5YcErm72knMqpa
ojkyaIkecKFeI6D1QS9UpFtSDzHdq+HsBJSnSBsR8ND6GOlUv3ZQhl7dQAf37exS
Kq64qQnpJfy/kcF5zStxtD145VJDXoX1By4AdnSg+kOuYi2HAKQ2SbQvYDd5ffk0
9fe6YagwE/iaz2o5z0c2EO6nBjstSo91/AKx99MwW7IfgJmgMZCGE0Q4UTduryr2
tFSBzWTStKCWxI2lDsrRQcF7KN4mZ2dZWgNFo4UU5tp36/kGHqKQ+Vzyaay8WWGU
IHgjKW+vo9TH8QyayRCCljtl/iYUbhrEa9n6APCnmW6sNsxPuO6KbZ3vzMz6WkLJ
/W1M+XIchveNFRZB7ku8DG4nLgISikgjMnPCO/F/y0NOQ8YaU7GeyeGj7yRom6LY
e4Oz34cToBULP5m6B1b/KGu013TwkRqwAoc2qHAlB5TXBXm/zOdyLqPo1/pgul30
H4+YKSUEl95b5w8URYnoKvf3sS0wocG4GvdC2pY8IOYRUNSmfsxiPW33Y7wcavgj
WF9YUFO5mRV1b+2QppuWp2UIwSjC7Uuh2lCTFhK4hod+RptE5h1MoKmQa2jSegr8
3uvfCXtDGQskJ+MDv9aUtGYTX14nPfwXUO3RPidKGgMF8r6W3to=
=pczP
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
