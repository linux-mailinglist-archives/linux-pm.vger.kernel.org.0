Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022A3232645
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 22:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgG2UiD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 16:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgG2UiD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 16:38:03 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8E320663;
        Wed, 29 Jul 2020 20:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596055083;
        bh=mFE7aSgbrVVZW37IpR/Ic67KsR9j4jJumMltAx31yMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uP48k4sG2RNF0uyZxwSSbzkDUlOHb+QBuDlEMbhpIiyCrXFvdinr5tOQnky/zlku2
         j7J6YNTlOnEu0TAdjHXKRw0VG2vU30hGYr3F+veJDWZUZLCeCcaaja1iwbi7coEdNg
         OcSIfX8rdcn7OOtnUQmuzVPidCI/Sic2UtFyNtS4=
Received: by earth.universe (Postfix, from userid 1000)
        id 6FF7F3C0B87; Wed, 29 Jul 2020 22:38:01 +0200 (CEST)
Date:   Wed, 29 Jul 2020 22:38:01 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     afd@ti.com, pali@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v6 3/4] dt-bindings: power: Add BQ28z610 compatible
Message-ID: <20200729203801.cgsuvfequq63e44c@earth.universe>
References: <20200729183145.6066-1-dmurphy@ti.com>
 <20200729183145.6066-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbo5plgyb3p4occj"
Content-Disposition: inline
In-Reply-To: <20200729183145.6066-3-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hbo5plgyb3p4occj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 01:31:44PM -0500, Dan Murphy wrote:
> Add the Texas Instruments bq28z610 battery monitor to the bq27xxx
> binding.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Thanks, queued.

-- Sebastian

>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml =
b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> index 0aa33590ac24..82f682705f44 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> @@ -50,6 +50,7 @@ properties:
>        - ti,bq27441
>        - ti,bq27621
>        - ti,bq27z561
> +      - ti,bq28z610
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.28.0
>=20

--hbo5plgyb3p4occj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8h3ikACgkQ2O7X88g7
+prTaw/6AoZQ8a00/W8P0rmYtxNA37ReXSw0l6I5TZ8YzkcijWn1vlvXNpEa0N5T
PRhF7KRXCUWeikivTpVvpYClVKXG/pMmwHviqmGUUrgEzG4DEv/MBHdpwPO6YeeS
3sVB4Eou8FhpozV3pzDmugb9fFDuQAgdtFjK7cbubRefCjCEHTDvvBWS1pzYPDyf
gIzVKZaccsRNZ7YN8TU+Oe5ylGM31N0FF4O89Y1PRSLQUvHsGYOTcKPdsNg81Mgk
6QP72Hb8dzTdK/c3v/F5Xyvj7kf1Ty1G9c8G6vpZcWxMVsx69EPqKfstxttl104J
RSCIac43HpZeOVj2dDk34sw+l2spJbaoJkRzQnNg66RLoG1NWM62dsnl4kb1bCNd
wiGrsbHv8AmteYROXWdcpYPpdibX9fWvdLoJKsYwziRffg5KFf89RWQ+4N9wMCmd
Q+iHQ+UNJAJx0WhylkcNcMiyYR0zGQM/YP4l1X3U2+ocd2vs+Gh78eAw7G2/sYgo
4r1cVifnS7gSxTJbbYmzAsCzWYwPe6yhWhnlz7pkj243rgV1JazViib2iNyO7HRR
4ohjTnK75+LWjDI02dOWDYr0oJ7Hua62GNJ/R+Rd1dnYeN2gP9zgrvecK2cr38Sh
1nWAXDZyXKMznSQC5uyM4Xsk0xcaqUgOyBWdAjI7NVI+DCeNdoA=
=a55h
-----END PGP SIGNATURE-----

--hbo5plgyb3p4occj--
