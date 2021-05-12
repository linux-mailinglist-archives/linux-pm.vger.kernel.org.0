Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D509837B7D6
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhELI0K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 04:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhELI0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 04:26:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFDDC061574;
        Wed, 12 May 2021 01:25:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A88C11F42650
Received: by earth.universe (Postfix, from userid 1000)
        id 711603C0C95; Wed, 12 May 2021 10:24:58 +0200 (CEST)
Date:   Wed, 12 May 2021 10:24:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     satya priya <skakit@codeaurora.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH V4 5/5] dt-bindings: power: reset: qcom-pon: Convert qcom
 PON binding to yaml
Message-ID: <20210512082458.o37su5rcpfc3sp23@earth.universe>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
 <1620800053-26405-6-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qfwnk4lxta2snkiz"
Content-Disposition: inline
In-Reply-To: <1620800053-26405-6-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qfwnk4lxta2snkiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 12, 2021 at 11:44:13AM +0530, satya priya wrote:
> Convert qcom PON binding from .txt to .yaml format.
>=20
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes in V2:
>  - As per Rob's comments, converted the main PON binding and added in V2.
>    Dropped example here to have one full example in qcom,pm8941-pwrkey.ya=
ml
>=20
> Changes in V3:
>  - As per Sebastian's comments, added allOf to refer reboot-mode.yaml and
>    used unevaluatedProperties =3D false. Added maxItems for reg.
>=20
> Changes in V4:
>  - Added the example back. Removed it in qcom,pm8941-pwrkey.yaml
>=20
>  .../devicetree/bindings/power/reset/qcom,pon.txt   | 49 -------------
>  .../devicetree/bindings/power/reset/qcom,pon.yaml  | 80 ++++++++++++++++=
++++++
>  2 files changed, 80 insertions(+), 49 deletions(-)
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
> index 0000000..353f155
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -0,0 +1,80 @@
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
> +allOf:
> +  - $ref: reboot-mode.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8916-pon
> +      - qcom,pms405-pon
> +      - qcom,pm8998-pon
> +
> +  reg:
> +    maxItems: 1
> +
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
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/interrupt-controller/irq.h>
> +   #include <dt-bindings/input/linux-event-codes.h>
> +   #include <dt-bindings/spmi/spmi.h>
> +   spmi_bus: spmi@c440000 {
> +     reg =3D <0x0c440000 0x1100>;
> +     #address-cells =3D <2>;
> +     #size-cells =3D <0>;
> +     pmk8350: pmic@0 {
> +       reg =3D <0x0 SPMI_USID>;
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       pmk8350_pon: pon_hlos@1300 {
> +         reg =3D <0x1300>;
> +         compatible =3D "qcom,pm8998-pon";
> +
> +         pwrkey {
> +            compatible =3D "qcom,pm8941-pwrkey";
> +            interrupts =3D < 0x0 0x8 0 IRQ_TYPE_EDGE_BOTH >;
> +            debounce =3D <15625>;
> +            bias-pull-up;
> +            linux,code =3D <KEY_POWER>;
> +         };
> +
> +         resin {
> +            compatible =3D "qcom,pm8941-resin";
> +            interrupts =3D <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +            debounce =3D <15625>;
> +            bias-pull-up;
> +            linux,code =3D <KEY_VOLUMEDOWN>;
> +         };
> +       };
> +     };
> +   };
> +...
> --=20
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member=
=20
> of Code Aurora Forum, hosted by The Linux Foundation
>=20

--qfwnk4lxta2snkiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCbkNIACgkQ2O7X88g7
+poMCRAAibu5F3FbmYapA73Qr0G3L1N0Aq6s48p+pkZMUKoUCNdT3Zs++0o1tPUq
7Pyn3Wpt/Fd8/wNt+T8CFE7T2dZOpQGf6DspjXbKLvqEWZ6+K23S82/A2v4Jy8D9
HovDfz657lG+j/zroqm1sHdLJhN22vqZsw/xw1fe/7qey9tyWiclZj/nC0fS7aZS
JZMG9DzxNkgObExZMfOaeZ0Hf+00SiHkcKYEVAZU0lH7Tqo4E4S0p59vFET2Q7nD
fD2rpqDEEvJVSVjRcr+BWUGONq8XZF6K5qyfkueRhX3IzPFOOxrShgCfgvQrhCpu
2E+QNWMsnRdgI85AkhNYUi6qWZL8CmDi2jn2WEKlL7nBPwZa7gD8Rx5s/M/v4E5g
EyYXbmAt54/b55+3Kn2Rk7ZEG1uU/VOe0ELcH+0H1wT2zTVDyyiWaHqQwAndVS2E
CiSLRcJMl8OeGan1iCOl2Xq8pbxWKkuw6A+zJA1TEraQqYJE6rhespzASgwH3xFZ
Qdyo9C6NVqxRC8sya0gnYCDR9B7p7Le1OKrOnmciOTe2+8HAyQt7dEBxmEm8fNMZ
eqNjo5jSpkeBJBKdXqF+ri5kBAgWoFChh7w8ae0TgHKxWckWdPGoeal1tBvkNSJQ
RjtnIPhojWie5FutYmKq7BbDP24idzNYEjIWHDMD1rPcMEUmCEw=
=Cb4p
-----END PGP SIGNATURE-----

--qfwnk4lxta2snkiz--
