Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08BC1C123C
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgEAMgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728639AbgEAMgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 08:36:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09CDC061A0C;
        Fri,  1 May 2020 05:36:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A01292A2FC1
Received: by earth.universe (Postfix, from userid 1000)
        id 69D353C08C7; Fri,  1 May 2020 14:36:45 +0200 (CEST)
Date:   Fri, 1 May 2020 14:36:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 05/11] power: supply: core: allow to constify property
 lists
Message-ID: <20200501123645.tqs6ta7n3cdtcdv3@earth.universe>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
 <1ebdfa76e2912c579c3c45fe86dbbedac6824167.1585944770.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fv6uh23nozfyr4mm"
Content-Disposition: inline
In-Reply-To: <1ebdfa76e2912c579c3c45fe86dbbedac6824167.1585944770.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fv6uh23nozfyr4mm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 03, 2020 at 10:20:32PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Since tables pointed to by power_supply_desc->properties and
> ->usb_types are not expected to change after registration, mark
> the pointers accordingly
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

>  include/linux/power_supply.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index dcd5a71e6c67..6a34df65d4d1 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -223,9 +223,9 @@ struct power_supply_config {
>  struct power_supply_desc {
>  	const char *name;
>  	enum power_supply_type type;
> -	enum power_supply_usb_type *usb_types;
> +	const enum power_supply_usb_type *usb_types;
>  	size_t num_usb_types;
> -	enum power_supply_property *properties;
> +	const enum power_supply_property *properties;
>  	size_t num_properties;
> =20
>  	/*
> --=20
> 2.20.1
>=20

--fv6uh23nozfyr4mm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sF90ACgkQ2O7X88g7
+ppYTw/7BRO4/SGM635ARYaEVZhIURdUiSfrZVBqooNJssCcWzxcx/98OshrBpfr
GlP92ZLz95npJbdPmpVsLRv9MCW4nV1P7uhs3OPlw9hcdu891F+6pPtR4vD2Qj1B
5uNQcvaRhczh3D6eS3RvSyLihFgZRipm99qg3eNFj7yiD4YNKyojp8DhgiB7bHqJ
w/DRZ48Z/SwrsO94U9WbBipFic03Z0NQEKkJ09uRl/1bDnylFcLXD6hNOJ7Oq2Kd
1ZB/FFGFrWHSG28zBYDtZbKJJgyPhXhNkur8Gmn2wz7nuoY4YYaaOFqqfzZW1xzx
AehuYByeCrsgwtLKpPhJLbsA15tmTUxhBKQFHggLJtRxFLoZn/XLUuA0zZU42mbC
1jY9gfifU8YvIzIdlf0ENWR0ZcvUT7kIExF9D1LRSHfcaFigi7B/fK2SpI51+DxV
YQVGOnS1EudND91BXFE9Nu1SQmItABD3Ofnl9LtQ0AGcgP/5Wg2RLujCM9615hp5
pgSNwV80JJmkGHaMuwt+CQ40RSqngCNnH/+KytC+DS5b3u964RvmqcCRNpEBJ+Z4
JNSZzCiVCO5bokIyQFn9rPD1mMHAKRciO8Dagf7DM+wR0chM7Wx4BDi2JQKIooOl
+MdWBF9M1LTi5n2/ck1wno3/nRL8QbLZNN/SY1FnLauSFT64y5c=
=FQql
-----END PGP SIGNATURE-----

--fv6uh23nozfyr4mm--
