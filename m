Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB526251D24
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHYQXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 12:23:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60526 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHYQXj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 12:23:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A99E72929C6
Received: by earth.universe (Postfix, from userid 1000)
        id B04B43C0C82; Tue, 25 Aug 2020 18:23:35 +0200 (CEST)
Date:   Tue, 25 Aug 2020 18:23:35 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     Andy Yan <andy.yan@rock-chips.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [RESEND PATCH v1 2/4] dt-bindings: power: reset: Add alternate
 reboot mode format
Message-ID: <20200825162335.ctyc3trvraiwihhg@earth.universe>
References: <1597776856-12014-1-git-send-email-eberman@codeaurora.org>
 <1597776856-12014-3-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hylhkgvtyey2ignd"
Content-Disposition: inline
In-Reply-To: <1597776856-12014-3-git-send-email-eberman@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hylhkgvtyey2ignd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 18, 2020 at 11:54:14AM -0700, Elliot Berman wrote:
> Current reboot-mode device tree schema does not support reboot commands
> with spaces in them [1]. Add an optional new node "reboot-mode-names"
> and "reboot-mode-magic" which add an array of strings and u32s,
> respectively which would permit any string in this framework.
>=20
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/md/dm-verity-target.c?h=3Dv5.5#n255
>=20
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---

I'm waiting for an Ack from Rob for this one.

-- Sebastian

>  .../devicetree/bindings/power/reset/reboot-mode.yaml    | 17 +++++++++++=
++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.ya=
ml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> index a6c9102..4ea6b33 100644
> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> @@ -19,6 +19,9 @@ description: |
>    the bootloader what to do when the system reboots, and should be named
>    as mode-xxx =3D <magic> (xxx is mode name, magic should be a non-zero =
value).
> =20
> +  reboot-mode-magic and reboot-mode-names may be used in addition/instea=
d of
> +  mode-xxx style.
> +
>    For example, modes common Android platform are:
>      - normal: Normal reboot mode, system reboot with command "reboot".
>      - recovery: Android Recovery mode, it is a mode to format the device=
 or update a new image.
> @@ -32,6 +35,14 @@ properties:
>        description: |
>          Default value to set on a reboot if no command was provided.
> =20
> +  reboot-mode-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: List of reboot commands, paired with reboot-mode-magic =
by index
> +
> +  reboot-mode-magic:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: List of reboot magic, paired with reboot-mode-names by =
index
> +
>  patternProperties:
>    "^mode-.*$":
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -44,4 +55,10 @@ examples:
>        mode-bootloader =3D <2>;
>        mode-loader =3D <3>;
>      };
> +
> +  - |
> +    reboot-mode {
> +      reboot-mode-names =3D "normal", "bootloader", "dm-verity device co=
rrupted";
> +      reboot-mode-magic =3D <0x0>, <0x1>, <0xf>;
> +    };
>  ...
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>=20

--hylhkgvtyey2ignd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9FOwcACgkQ2O7X88g7
+poO+g//br2c8K72ObA/SO3efTGrTSV5mBor3AwZW2VvoeT0tJN8RBQhqME+5wzS
zZkGOC6fd23loTaGdh85ZWQz/2K2TUUjWd2+PdExAOChjzUa1CeF1y9wSjQJ5cli
VOnUE68D3Mn7DaFWz64IAcJr/YKGf4+SXuJ1LhtYrtEPtugdq6kFkNbM3eDUlL2b
c0HF+dD4mi+r4p24ZceTHsN5Y1lA+D9IH883e0wOW5wwNXB46aNWP6QteNWWsgeS
3y1n8WPRMJ1Ru92OJ/4eIpEyJC5TfZLwnXEveeLLSgDb4MqoDAk1GoCM8JvfLyAa
hTK18eJzphJ2Fn0IjtpqytzKzuq82gq3d9NtqVhxeXn6JvOEY36nz8Op4GRjjtQi
84B7wU6nhGYpGbHIpWRKU3cICYI8HrV+idHLJrZY+NXMjq2q71NHHJfQoZ4K1at1
R/qU66qGnXdKFLaE2NM15RljhdpJUqA/GhsqcAPm5vPjU9yyp120QKr4cnIckhhJ
iwPJA8HuWunLlSmTuem9P1ICpli+gqzsBVAfQeCrOnGxSHfQC5wFQN/vbbeF/tWa
QwTXqro2kM8aDmBtwCag6Coyy7Vt75SeuQL9zcIO7ZBHTTK/OazqSNpxC7FJCW5U
hj2RY9NdlZlPwUx46+GBnP3mNIEJhaTFlpsCdPwV5Q7QxL/fizo=
=cqmB
-----END PGP SIGNATURE-----

--hylhkgvtyey2ignd--
