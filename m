Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406FF1CBBB4
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 02:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgEIAPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 20:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbgEIAPI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 20:15:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39310C061A0C;
        Fri,  8 May 2020 17:15:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2DDE32A2ECF
Received: by earth.universe (Postfix, from userid 1000)
        id C00913C08C6; Sat,  9 May 2020 02:15:04 +0200 (CEST)
Date:   Sat, 9 May 2020 02:15:04 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     ChenTao <chentao107@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] power/supply/cw2015: Make some symbols static
Message-ID: <20200509001504.7snfnuesoxjagxl2@earth.universe>
References: <20200506114519.238186-1-chentao107@huawei.com>
 <0a9613a6-5557-21cb-af16-bd57d7b2a696@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mhxy3ryrlei3espq"
Content-Disposition: inline
In-Reply-To: <0a9613a6-5557-21cb-af16-bd57d7b2a696@manjaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mhxy3ryrlei3espq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 06, 2020 at 09:49:26PM +0200, Tobias Schramm wrote:
> > Fix the following warning:
> >=20
> > drivers/power/supply/cw2015_battery.c:96:5: warning:
> > 'cw_update_profile' was not declared. Should it be static?
> > drivers/power/supply/cw2015_battery.c:712:1: warning:
> > 'cw_bat_pm_ops' was not declared. Should it be static?
> >=20
>=20
> LGTM.
>=20
> Acked-by: Tobias Schramm <t.schramm@manjaro.org>
> Tested-by: Tobias Schramm <t.schramm@manjaro.org>

Thanks, queued.

-- Sebastian

--mhxy3ryrlei3espq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl619ggACgkQ2O7X88g7
+ppjmw//V9xDnxeiMZnhcflE6PESFzdcAuuEJSllnrM5AkJnMM+ECYzineENjZjT
As23fAr8sWDQTvEZB3+YB1EAe1rzn1/sdRQU3CoSPB4OOqk8kKulXs40WF+Uwj0q
IIU36ozq94FgUBJzeM6p/F1mvm3LLmP8ydctlKdfcR9xMkaw4fy985GXZeQYk10N
JMEx+pJ/h1DudgcYbG2Js3CQtTNcAdVSSo7LanOdIlgucaDbCLXxFXUDpiQytwyE
f5HCFWUzC0P7X1v+2Jyv/Lk26tUhiRxJ+SfFXq19nJKSakNg4So4PqKGenl3BUb0
4ra3VBMh9V2dSNPJLYQMo0xR1m+SWujbodyjtNSxdGIbL8uc4M6YRpmqLn5UoRVb
FCIHy7ZCw6YDoFLh+WCzAoXvXdekcAa8lBBDSyw//pkVgL65QPy/mMiHpva/wpx1
HF1BZmJpLc1rl4ozCiZRhvKgbvon9C3VUh4Jq8S1Kw2XLt5qkCpOCQt2CxsFEsWc
PnfFuiSHQI6Q/PEyvqZov7cSDXJCZJOkWp6huYKw0Dv1Se3pi046jcVCyzboc5sB
UZoiVcLxZbKXSi09NzCbXxfqBYd67tGXjAA69ngvMv8UFsv79g2xsPsSkLTPBYLm
mF2RBqwmzims9BoyhFyjtQEY6+/eksSC6ZTZ66WJP/BkwoK+LkU=
=ObJf
-----END PGP SIGNATURE-----

--mhxy3ryrlei3espq--
