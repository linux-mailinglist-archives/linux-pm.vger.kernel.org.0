Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22AA3E30B8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhHFVNd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbhHFVNd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 17:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9CAB61184;
        Fri,  6 Aug 2021 21:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628284397;
        bh=VamfysyfMJ6hiOGFjc2j6AndOlXtXFDk6eG4aqGHU3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VaJBTjKrRs0kBrbzaBFwUlFfRe/wI4/WEMpS7CidiqQte3XEOMi0QMDPNY37Xw9R9
         Oiht/X4EZjIuv66GcVsfll1afAuvpked2z2IQWiE1rQWAYTFPLk6U9dXVtxTgyGLBw
         bFUh0hVqXmZz/uZr0wXsG0M8TwiWYduHK/4oOIkx0dIn1dM38aQuhARc063Ud9OhmY
         oskS3rWZPDfKfv2OeLXgRWoUldaNxb2OVzeIHbAaPJ7qsqQS+TMe4Tftc3F/DtGXqG
         tstUdnUM/s5QDCz2J8PrGZ9xe9F0wJrtvf0NUgkoaNI0cMryh3yE8NO+wQET2BqsvH
         hLd/YvGcq4R8A==
Received: by earth.universe (Postfix, from userid 1000)
        id DE7253C0C99; Fri,  6 Aug 2021 23:13:14 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:13:14 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 05/12] dt-bindings: power: supply: smb347-charger:
 Document USB VBUS regulator
Message-ID: <20210806211314.sfjl5jke27hz3jj7@earth.universe>
References: <20210731173842.19643-1-digetx@gmail.com>
 <20210731173842.19643-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rxizn6tonuqcuyrj"
Content-Disposition: inline
In-Reply-To: <20210731173842.19643-6-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rxizn6tonuqcuyrj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 31, 2021 at 08:38:35PM +0300, Dmitry Osipenko wrote:
> SMB347 can supply power to USB VBUS, which is required by OTG-cable
> devices that want to switch USB port into the host mode. Add USB VBUS
> regulator properties.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../power/supply/summit,smb347-charger.yaml   | 30 +++++++++++++++++++
>  .../dt-bindings/power/summit,smb347-charger.h |  4 +++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347=
-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb34=
7-charger.yaml
> index 983fc215c1e5..20862cdfc116 100644
> --- a/Documentation/devicetree/bindings/power/supply/summit,smb347-charge=
r.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charge=
r.yaml
> @@ -73,6 +73,26 @@ properties:
>        - 1 # SMB3XX_SOFT_TEMP_COMPENSATE_CURRENT Current compensation
>        - 2 # SMB3XX_SOFT_TEMP_COMPENSATE_VOLTAGE Voltage compensation
> =20
> +  summit,inok-polarity:
> +    description: |
> +      Polarity of INOK signal indicating presence of external power supp=
ly.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # SMB3XX_SYSOK_INOK_ACTIVE_LOW
> +      - 1 # SMB3XX_SYSOK_INOK_ACTIVE_HIGH
> +
> +  usb-vbus:
> +    $ref: "../../regulator/regulator.yaml#"
> +    type: object
> +
> +    properties:
> +      summit,needs-inok-toggle:
> +        type: boolean
> +        description: INOK signal is fixed and polarity needs to be toggl=
ed
> +                     in order to enable/disable output mode.
> +
> +    unevaluatedProperties: false
> +
>  allOf:
>    - if:
>        properties:
> @@ -134,6 +154,7 @@ examples:
>              reg =3D <0x7f>;
> =20
>              summit,enable-charge-control =3D <SMB3XX_CHG_ENABLE_PIN_ACTI=
VE_HIGH>;
> +            summit,inok-polarity =3D <SMB3XX_SYSOK_INOK_ACTIVE_LOW>;
>              summit,chip-temperature-threshold-celsius =3D <110>;
>              summit,mains-current-limit-microamp =3D <2000000>;
>              summit,usb-current-limit-microamp =3D <500000>;
> @@ -141,6 +162,15 @@ examples:
>              summit,enable-mains-charging;
> =20
>              monitored-battery =3D <&battery>;
> +
> +            usb-vbus {
> +                regulator-name =3D "usb_vbus";
> +                regulator-min-microvolt =3D <5000000>;
> +                regulator-max-microvolt =3D <5000000>;
> +                regulator-min-microamp =3D <750000>;
> +                regulator-max-microamp =3D <750000>;
> +                summit,needs-inok-toggle;
> +            };
>          };
>      };
> =20
> diff --git a/include/dt-bindings/power/summit,smb347-charger.h b/include/=
dt-bindings/power/summit,smb347-charger.h
> index d918bf321a71..3205699b5e41 100644
> --- a/include/dt-bindings/power/summit,smb347-charger.h
> +++ b/include/dt-bindings/power/summit,smb347-charger.h
> @@ -16,4 +16,8 @@
>  #define SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW	1
>  #define SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH	2
> =20
> +/* Polarity of INOK signal */
> +#define SMB3XX_SYSOK_INOK_ACTIVE_LOW		0
> +#define SMB3XX_SYSOK_INOK_ACTIVE_HIGH		1
> +
>  #endif
> --=20
> 2.32.0
>=20

--rxizn6tonuqcuyrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENpeMACgkQ2O7X88g7
+ppzLQ//eHaRl42dx9MzVCV2u+n1cPFnsVduPyX5XgdRQ+66+FtZWVsdOO6X32en
lyuHqro4b6aV+rtHvlcr4VY+ZRJql6PycGWvrAXgRKHx1Sx/etrdAH93kFQxnllV
6W+LmkMelL/Ng7qtf4Tg302CWGESnDX1u8doIXWoGI7BC+oOC5XjsJf9F3GNLmr0
uPUqf8bVdKbtP0wuxRNiw9NoMS34fCvmB2MzylNlksmnWF6aVVqY/MPXtKkCQO1g
I2X/4/4BlwhkzPYuOuO3iEYdTuo4e6FQ1KZUWIDnGAfs79HqZO967pDvPz6hRwWN
R6oa8pqPDymRPV1Tb0jvhCvRByaoa2Zo6cHSW2aowf7CdorVrnB8/Rfh/s/GLvfx
lU5UvVsFo0TlE2WpPSNtM48qd6VZek0CxWIsaWwZuIbJp9qVvg3tdUFsqDNDEbiA
y8x2ei2wSyi7kpdycd1ilIcHmBczLUkXUKQso9FrYlFmkosmpacx6K0coUrYbFEl
3O3P+hcua2rK3/g58ZcRluL9mJ0qmprET8Gxil85H7BUkvJ/oakPREorSv5LQcic
dQW/9ol+cCKQe+3nLfGIhKnWBYI0LIvxMvR/DEO1dsjhwcg5EU2//22yQXPnjNwM
jLhNT7G/zVRD2dkxJO/o76tGSZ0TVsiYFBMFpU91a0Fvfieacyk=
=UOZ/
-----END PGP SIGNATURE-----

--rxizn6tonuqcuyrj--
