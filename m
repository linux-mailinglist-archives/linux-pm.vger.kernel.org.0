Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8A251D10
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 18:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgHYQVG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 12:21:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60460 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHYQVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 12:21:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2409C29244F
Received: by earth.universe (Postfix, from userid 1000)
        id A3C303C0C82; Tue, 25 Aug 2020 18:21:01 +0200 (CEST)
Date:   Tue, 25 Aug 2020 18:21:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     Andy Yan <andy.yan@rock-chips.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [RESEND PATCH v1 1/4] dt-bindings: power: reset: Convert
 reboot-mode to YAML
Message-ID: <20200825162101.27ivwlxbby7q7hy6@earth.universe>
References: <1597776856-12014-1-git-send-email-eberman@codeaurora.org>
 <1597776856-12014-2-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svvw56udockwuh7v"
Content-Disposition: inline
In-Reply-To: <1597776856-12014-2-git-send-email-eberman@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--svvw56udockwuh7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks, queued.

-- Sebastian

On Tue, Aug 18, 2020 at 11:54:13AM -0700, Elliot Berman wrote:
> Convert reboot-mode bindings to YAML.
>=20
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  .../bindings/power/reset/reboot-mode.txt           | 25 ------------
>  .../bindings/power/reset/reboot-mode.yaml          | 47 ++++++++++++++++=
++++++
>  2 files changed, 47 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/reboot-=
mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-=
mode.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.tx=
t b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> deleted file mode 100644
> index de34f27..0000000
> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Generic reboot mode core map driver
> -
> -This driver get reboot mode arguments and call the write
> -interface to store the magic value in special register
> -or ram. Then the bootloader can read it and take different
> -action according to the argument stored.
> -
> -All mode properties are vendor specific, it is a indication to tell
> -the bootloader what to do when the system reboots, and should be named
> -as mode-xxx =3D <magic> (xxx is mode name, magic should be a none-zero v=
alue).
> -
> -For example modes common on Android platform:
> -- mode-normal: Normal reboot mode, system reboot with command "reboot".
> -- mode-recovery: Android Recovery mode, it is a mode to format the devic=
e or update a new image.
> -- mode-bootloader: Android fastboot mode, it's a mode to re-flash partit=
ions on the Android based device.
> -- mode-loader: A bootloader mode, it's a mode used to download image on =
Rockchip platform,
> -	       usually used in development.
> -
> -Example:
> -	reboot-mode {
> -		mode-normal =3D <BOOT_NORMAL>;
> -		mode-recovery =3D <BOOT_RECOVERY>;
> -		mode-bootloader =3D <BOOT_FASTBOOT>;
> -		mode-loader =3D <BOOT_BL_DOWNLOAD>;
> -	}
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.ya=
ml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> new file mode 100644
> index 0000000..a6c9102
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/reboot-mode.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic reboot mode core map
> +
> +maintainers:
> +  - Andy Yan <andy.yan@rock-chips.com>
> +
> +description: |
> +  This driver get reboot mode arguments and call the write
> +  interface to store the magic value in special register
> +  or ram. Then the bootloader can read it and take different
> +  action according to the argument stored.
> +
> +  All mode properties are vendor specific, it is a indication to tell
> +  the bootloader what to do when the system reboots, and should be named
> +  as mode-xxx =3D <magic> (xxx is mode name, magic should be a non-zero =
value).
> +
> +  For example, modes common Android platform are:
> +    - normal: Normal reboot mode, system reboot with command "reboot".
> +    - recovery: Android Recovery mode, it is a mode to format the device=
 or update a new image.
> +    - bootloader: Android fastboot mode, it's a mode to re-flash partiti=
ons on the Android based device.
> +    - loader: A bootloader mode, it's a mode used to download image on R=
ockchip platform,
> +              usually used in development.
> +
> +properties:
> +  mode-normal:
> +      $ref: /schemas/types.yaml#/definitions/uint32
> +      description: |
> +        Default value to set on a reboot if no command was provided.
> +
> +patternProperties:
> +  "^mode-.*$":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +examples:
> +  - |
> +    reboot-mode {
> +      mode-normal =3D <0>;
> +      mode-recovery =3D <1>;
> +      mode-bootloader =3D <2>;
> +      mode-loader =3D <3>;
> +    };
> +...
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>=20

--svvw56udockwuh7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9FOl8ACgkQ2O7X88g7
+ppIVA//Q7sFR8KWW2DLHJO66JM9waRoFhMR0niAYGKNORlj8MIbR5ruDIQ7iX2K
E0Q+7igrfRF2nOxuVOEYD8dIS9PygAeLyiCY8u5gZorISVf2GveENkWSDGZeY//G
nkoEjTFKI17uEmwgw5PO07xuHJvmhUJ3UvaA+gNHIWOrkO2P6zH4s4jEZsqGs1uu
xJk+BFCVBjb7cX6cWZLyF1cgw660n3bNtF9iPjHnNLKpVxIwK+OEB/hCeatEayTh
3jPeZ1zLtI3Umo3dhEo0H+s5Hjt/HIt/bQhuvirTTrDyDQF4n3gxWwIeRKUY3z8N
jTw2esV/61m8ZpIX4cSuwoAroCUlK4jYRRdNDuCfwT07HbLiUs/YdC3KtZGXXrdn
xacoaTXQWP/7FL7URwPEsc4KcRImU3sodyPs+ReXfk8DAQA2DjT95hSqLUaZvh8h
1uilDsSLFJauzWR7hDGuhPyA/3qvm9AU2BrZ0ziskT7XoZ/hq0GB/Dtuuq+5lV8c
dGMNmLIbMyXO+hGnIODXl5fxMiayEJ9mW3wN0P8ynTZ/2N7IKm3tTXeDGwHosd7Y
M+d+JHY4p9T8tF84p9eqQf1CqFVLffZjnEfRTLMY60AJBdDHSp9SdjrdoYNs4/AH
So9SKU3ssbJLe9c2Ea1DjQx773vfq1iFAFaS2WvWPX/Up8TXmyo=
=33YO
-----END PGP SIGNATURE-----

--svvw56udockwuh7v--
