Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1335C2322DF
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 18:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgG2Qqi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 12:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG2Qqh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 12:46:37 -0400
Received: from earth.universe (dyndsl-095-033-172-175.ewe-ip-backbone.de [95.33.172.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C1D20809;
        Wed, 29 Jul 2020 16:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596041197;
        bh=MNvYf6Zn28rLdP7ViMy29aZYD0eAurNF8FmA6PG23JU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lis10wwiitfP0LyrSXjMssjlm6eWl7WazeT8122FO4ao/JhL0ZMoiwM99GAMwOaoS
         14i5g80JxD+Z/QzF3SZvVFLQ0gAuZjy5TFNMbU2IWECN2Brdb2+VsKM4LVqfmfYy4F
         7PRwKpxRMNQYTJvbzRT95aKo+cp44lZIPeLuY2XE=
Received: by earth.universe (Postfix, from userid 1000)
        id 7F44F3C0B87; Wed, 29 Jul 2020 18:46:35 +0200 (CEST)
Date:   Wed, 29 Jul 2020 18:46:35 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     pali@kernel.org, robh@kernel.org, afd@ti.com, dmurphy@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sspatil@android.com
Subject: Re: [PATCH v18 2/4] dt-bindings: power: Convert battery.txt to
 battery.yaml
Message-ID: <20200729164635.cnjbadpq22tigwlc@earth.universe>
References: <20200728200814.26501-1-r-rivera-matos@ti.com>
 <20200728200814.26501-3-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pocjiyfjiv2tcf6l"
Content-Disposition: inline
In-Reply-To: <20200728200814.26501-3-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pocjiyfjiv2tcf6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ricardo and Dan,

On Tue, Jul 28, 2020 at 03:08:12PM -0500, Ricardo Rivera-Matos wrote:
> From: Dan Murphy <dmurphy@ti.com>
>=20
> Convert the battery.txt file to yaml and fix up the examples.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

I merged this doing some modifcations while applying, so that this
is not postponed and risking conflicts due to added properties:


> [...]
> +patternProperties:
> +  '^ocv-capacity-table-[0-100]$':
> [...]

[0-100] is a valid regex, but counterintuitively only allows 0 and
1. For example it does not apply for ocv-capacity-table-2.

I used [0-9]+ instead, which is being used by pinctrl.

> +examples:
> +  - |
> +    power {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      battery: battery {
> +        compatible =3D "simple-battery";
> +        over-voltage-threshold-microvolt =3D <4500000>;
> +        re-charge-voltage-microvolt =3D <250000>;
> +        voltage-min-design-microvolt =3D <3200000>;
> +        voltage-max-design-microvolt =3D <4200000>;
> +        energy-full-design-microwatt-hours =3D <5290000>;
> +        charge-full-design-microamp-hours =3D <1430000>;
> +        precharge-current-microamp =3D <256000>;
> +        precharge-upper-limit-microvolt =3D <2500000>;
> +        charge-term-current-microamp =3D <128000>;
> +        constant-charge-current-max-microamp =3D <900000>;
> +        constant-charge-voltage-max-microvolt =3D <4200000>;
> +        factory-internal-resistance-micro-ohms =3D <250000>;
> +        ocv-capacity-celsius =3D <(-10) 10>;

You state, that there is a table for -10 degrees and one for 10
degrees...

> +        ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 9=
0>;

=2E.. and then you provide only the table for -10 degrees. I fixed
this by simply using the previous example (tables for -10, 0 and 10
degrees) and 3 tables and added a comment above the tables.

-- Sebastian

--pocjiyfjiv2tcf6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8hp9kACgkQ2O7X88g7
+prgIA//fWkFK0IS/82O/WY4vEVu36fFAWgJ1uOcVLkDRPVz9DO7Q4TIyVY7FOzW
B7+DuzvHS6/7HFcb89spYKCDPlVtx5dLgjd+wIsrGi2YpeiIIUus3+cKLmiHsi3t
+dHfFYq2Hgg7JFvRhmSi7a9f2tKtOYCeOlCfJ56MOxWVggHnl7v3ytOEiQEyeFN3
/tE/HdIlXtRleLWXPWIBsR7QRW3TJEk7BRIgyfenwvrJXu27/w8AZoXeiisJaJBW
VN4ApBkln1RYHzsiwoobo5j9Z2S/pWfl5AaRabOqdwtxbaZ6Tg96+vkb9J4hFNj6
vXd6DKVOTBhHnQLqbM9pVGpasQoC2d/2v2e5jIRxpjp+5EqYOqTCEeH7SVDznAo+
t5Kv7lvfozuakPOQHmaigyI27Eg1UJ8iLKBRycnwvnwdzm7tJqtOLq1Wj/50LacY
/jjCZ3AG75wHzorusn2kKeBWEGRpFqG7iE7AW2z/sN5NREmyuvSVqXJ908VSMoVJ
VpwRXpfsitMLQhmaKYQXyyeheopOfo69O1CDGk/KwHOtpl3eDatA45Nzn7XhDnsx
n3HIRRl09R1ZE2p4RBU2p+fHN01CluJK+o0FL9JPfjAMB2lAT64OuPBww7TISl4H
vQqDBKlRzOsYU57yvNCHfArwDx/fVp4VlTbTHU0lm7CjNreWw+8=
=d5pW
-----END PGP SIGNATURE-----

--pocjiyfjiv2tcf6l--
