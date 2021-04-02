Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A561352A0A
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 13:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhDBLCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 07:02:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55956 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbhDBLCy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 07:02:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 93C081F46851
Received: by earth.universe (Postfix, from userid 1000)
        id 40A033C0C96; Fri,  2 Apr 2021 13:02:48 +0200 (CEST)
Date:   Fri, 2 Apr 2021 13:02:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Murphy <dmurphy@ti.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 28/32] dt-bindings: power: update battery.yaml reference
Message-ID: <20210402110248.qhzeckgcqrksfwp7@earth.universe>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
 <38d6c11d44570822931395dfe18ccaf7d72ac84e.1617279356.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgd2dysqbs7d4ujj"
Content-Disposition: inline
In-Reply-To: <38d6c11d44570822931395dfe18ccaf7d72ac84e.1617279356.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dgd2dysqbs7d4ujj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 01, 2021 at 02:17:48PM +0200, Mauro Carvalho Chehab wrote:
> Changesets: 70c23e62d20c ("dt-bindings: power: supply: Fix remaining batt=
ery.txt links")
> and: 471dec8023d1 ("dt-bindings: power: Convert battery.txt to battery.ya=
ml")
> renamed: Documentation/devicetree/bindings/power/supply/battery.txt
> to: Documentation/devicetree/bindings/power/supply/battery.yaml.
>=20
> Update its cross-reference accordingly.
>=20
> Fixes: 70c23e62d20c ("dt-bindings: power: supply: Fix remaining battery.t=
xt links")
> Fixes: 471dec8023d1 ("dt-bindings: power: Convert battery.txt to battery.=
yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Thanks, queued.

-- Sebastian

>  Documentation/power/power_supply_class.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/power/power_supply_class.rst b/Documentation/p=
ower/power_supply_class.rst
> index 7b8c42f8b1de..c04fabee0a58 100644
> --- a/Documentation/power/power_supply_class.rst
> +++ b/Documentation/power/power_supply_class.rst
> @@ -233,7 +233,7 @@ Devicetree battery characteristics
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Drivers should call power_supply_get_battery_info() to obtain battery
>  characteristics from a devicetree battery node, defined in
> -Documentation/devicetree/bindings/power/supply/battery.txt. This is
> +Documentation/devicetree/bindings/power/supply/battery.yaml. This is
>  implemented in drivers/power/supply/bq27xxx_battery.c.
> =20
>  Properties in struct power_supply_battery_info and their counterparts in=
 the
> --=20
> 2.30.2
>=20

--dgd2dysqbs7d4ujj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBm+dgACgkQ2O7X88g7
+prIzw/+Mlb3ocO+CKzWoQvp0RF5mpf/7fdhZhxaJWstSMq5tSx+XAgyVTGUPBe4
y1dnqi12rr5cVl4xQpmir0mS+FAbNhDdHpIJIVFjy0O4+GaPJ3vWniuWBbzfHMqW
4L2tif53Nys9qTntt1zGpSEEE9Sg0TqyJutFqDbeNtJ+tXbCV6hcoV5S+CvKU4vt
rle5Hodk+OYPuxarZSMbo2rFj4pbe3LDReO2pZIXmsFkU4GuihJAbvApjQt3Wnu2
t/Lgm8yU0/YHUfMHx2/90L/7wuoItu1T395UFq9XRoftN0Xblp/p0RgMz/gvlh1M
ld7pa8k7Lb3WKXruGbRcdeanqdfydzr6t0t/jSP6b5V/LCwEtuSVXBHsaeKD9YhV
tSRMYaDVznPn3pRPA7k44GMv9czX0Yuew/TkPSY7FA6mlUYrHa6jPjQCfi4dlY2N
6lEGMP+dbz7YcSF/4UIB9OuoZ9wy22Zows8Km3jLBFgrA8d5EBiaeLZyjUHll+7r
5KsV4sh5gMpl4AF6b1XV06LTN01muGdBLaMclGOKBHJL1OGPUIfRplUrbEgcLGJR
HXFQ4C4U2j+8L73ACKZaZADML6N03siLFZFKFgab04+dSGokV9i78C/2qZw7W8Ve
ApeWwWaFMjCF1BkOlQEgOTWz2YKgQoWAXFzsOr6uLkl4BeZbSKo=
=Wdzy
-----END PGP SIGNATURE-----

--dgd2dysqbs7d4ujj--
