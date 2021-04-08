Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59626358403
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 15:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhDHNAR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 09:00:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46980 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHNAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 09:00:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BC0EA1F45CE5
Received: by earth.universe (Postfix, from userid 1000)
        id 36FAC3C0C96; Thu,  8 Apr 2021 15:00:01 +0200 (CEST)
Date:   Thu, 8 Apr 2021 15:00:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     satya priya <skakit@codeaurora.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 3/4] dt-bindings: power: reset: qcom-pon: Convert qcom
 PON binding to yaml
Message-ID: <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwh33wz7f4hiy5eg"
Content-Disposition: inline
In-Reply-To: <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pwh33wz7f4hiy5eg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 08, 2021 at 05:01:08PM +0530, satya priya wrote:
> Convert qcom PON binding from .txt to .yaml format.
>=20
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---

Thanks for doing this.

> Changes in V2:
>  - As per Rob's comments, converted the main PON binding and added in V2.
>=20
>  .../devicetree/bindings/power/reset/qcom,pon.txt   | 49 ----------------=
------
>  .../devicetree/bindings/power/reset/qcom,pon.yaml  | 41 ++++++++++++++++=
++
>  2 files changed, 41 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/qcom,po=
n.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,po=
n.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b=
/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> deleted file mode 100644
> index 0c0dc3a..0000000
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Qualcomm PON Device
> -
> -The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
> -and resin along with the Android reboot-mode.
> -
> -This DT node has pwrkey and resin as sub nodes.
> -
> -Required Properties:
> --compatible: Must be one of:
> -	"qcom,pm8916-pon"
> -	"qcom,pms405-pon"
> -	"qcom,pm8998-pon"
> -
> --reg: Specifies the physical address of the pon register
> -
> -Optional subnode:
> --pwrkey: Specifies the subnode pwrkey and should follow the
> - qcom,pm8941-pwrkey.txt description.
> --resin: Specifies the subnode resin and should follow the
> - qcom,pm8xxx-pwrkey.txt description.
> -
> -The rest of the properties should follow the generic reboot-mode descrip=
tion
> -found in reboot-mode.txt
> -
> -Example:
> -
> -	pon@800 {
> -		compatible =3D "qcom,pm8916-pon";
> -
> -		reg =3D <0x800>;
> -		mode-bootloader =3D <0x2>;
> -		mode-recovery =3D <0x1>;
> -
> -		pwrkey {
> -			compatible =3D "qcom,pm8941-pwrkey";
> -			interrupts =3D <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> -			debounce =3D <15625>;
> -			bias-pull-up;
> -			linux,code =3D <KEY_POWER>;
> -		};
> -
> -		resin {
> -			compatible =3D "qcom,pm8941-resin";
> -			interrupts =3D <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -			debounce =3D <15625>;
> -			bias-pull-up;
> -			linux,code =3D <KEY_VOLUMEDOWN>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml =
b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> new file mode 100644
> index 0000000..40eea5f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/qcom,pon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PON Device
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description: |
> +  The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
> +  and resin along with the Android reboot-mode.
> +
> +  This DT node has pwrkey and resin as sub nodes.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8916-pon
> +      - qcom,pms405-pon
> +      - qcom,pm8998-pon
> +
> +  reg:
> +    description: Specifies the physical address of the pon register

That description is obvious and pointless. Instead add

maxItems: 1

> +  pwrkey:
> +    type: object
> +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
> +
> +  resin:
> +    type: object
> +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true

Instead of allowing arbitrary properties, only valid modes
should be allowed. So drop additionalProperties and do this
instead:

allOf:
  - $ref: reboot-mode.yaml#

unevaluatedProperties: false

> +...

Please do not drop the example :)

-- Sebastian

--pwh33wz7f4hiy5eg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBu/kgACgkQ2O7X88g7
+ppAeRAAkhWuK8jM17WlU33LPMDBqGwlit1V4YED46pLirpINtFqnT/4ci0BeDV/
U+8uENhHjrM+TE8dC3LJOWXK33xEaczB93IuQfdpV7CLiSGSwT8QJ8s18vOZkoqF
wgdDLw12PdSS4RcJZfD4Pn0fgR2hmCGQgs6IorpYEOhJZEx16kTqPkrZnaDkKPkg
YA/maaol7zbfofYHDhvdqqLuC3qhk2+mgmLftFz5mGQuLD5pzPWLYmRhqe8FsbIT
2QE5S4fc30KiQVufnncRJOuU4XBMScwY1ayHT0N+s4Muo8mDXK5dx613kxckuW6/
R7JnXHiaO8rilZ1BBVcKb0gPcZgAGunJmh3elWrPc/K2idInkDnwhWmfHftgc5zx
vtaFDntNSFXyTEBp09CjQShxi1p6OsYXIyrMfN6FpcnGZqJvR0s2EmJeR9ac9ZSs
Vxn6+OhLRsyEBFSaIefNtAinIHyKTv44AEoWMHopWO0di9J/wHnJCDelGdgUOE3S
lgWb5yZMynmOxWrc7tLZOJDcT/yxfBQ9ATo+FOwYzoN0GQJYnfzVNvou4bTzRgWm
uOHVQ6HkFHIsVvqLe2xeOl3fyxfOVpo6j/ADUxxpL69m9wdoN1B4b+zs3x5nXSQz
BztPpOLY0doi6ILnP6KU6aVC1y4aSU5iYBujcBhiVvQJ9iJDLUw=
=YShM
-----END PGP SIGNATURE-----

--pwh33wz7f4hiy5eg--
