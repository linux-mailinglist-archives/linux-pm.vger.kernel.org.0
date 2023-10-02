Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C045E7B52FA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbjJBM1U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 08:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbjJBM1U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 08:27:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814ADD3
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 05:27:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4925FC433C7;
        Mon,  2 Oct 2023 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696249635;
        bh=WWtL4qHNj8OoJw1J87nI1FTIUIMx6ruo7rd7bGMVs3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYGz7qKFQO/zmNRlvD+dNAyb0fF6LIZq3JXKx1MnN91k9AaXJZhZvQxP5Qq0aGbNq
         O+uiz735uHzIs3LTAuvj8zD/DriwbaYmR/grgcWX34doZZK5aVsQiIUh7uTj3LcvRY
         2JQKW2lhNxwHK8mi8Cx+YaGq2lvKXDJHm6wm7RMF2cEsTgvy+EJsQB09shVmAJyUdI
         SPDx/h2cnOvBjsRAypSrECNrAdIzKI10KV/X/bZ29/mCh8eFaGm2eXnuXWtGcWbf9v
         tzqqzFeNFaeybXv2VmUA6DZfZS9OJ+ScbkozCSSTgu5YuZfO07N+3kKkTuurT9mxpa
         s4UIvDK8Sfuog==
Date:   Mon, 2 Oct 2023 13:27:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
Message-ID: <20231002-unheard-copy-f9dceb6498a9@spud>
References: <20230928222130.580487-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l1Vrk9abMCA3Qchf"
Content-Disposition: inline
In-Reply-To: <20230928222130.580487-1-festevam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--l1Vrk9abMCA3Qchf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 07:21:30PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> The number of fsl,tmu-range entries vary among the several NXP SoCs.
>=20
> - lx2160a has two fsl,tmu-range entries  (fsl,qoriq-tmu compatible)
> - imx8mq has four fsl,tmu-range entries. (fsl,imx8mq-tmu compatible)
> - imx93 has seven fsl,tmu-range entries. (fsl,qoriq-tmu compatible)
>=20
> Change minItems and maxItems accordingly.
>=20
> This fixes the following schema warning:
>=20
> imx93-11x11-evk.dtb: tmu@44482000: fsl,tmu-range: 'oneOf' conditional fai=
led, one must be fixed:
>         [2147483866, 2147483881, 2147483906, 2147483946, 2147484006, 2147=
484071, 2147484086] is too long
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

tbh, this seems like a situation where per compatible constraints should
be added, since each of the devices listed above has different
requirements.

Thanks,
Conor.

> ---
> Changes since v1:
> - Adjust min/maxItems to cover all NXP SoCs.
>=20
>  Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml=
 b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> index ee4780f186f9..60b9d79e7543 100644
> --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> @@ -36,7 +36,8 @@ properties:
>      description: |
>        The values to be programmed into TTRnCR, as specified by the SoC
>        reference manual. The first cell is TTR0CR, the second is TTR1CR, =
etc.
> -    minItems: 4
> +    minItems: 2
> +    maxItems: 7
> =20
>    fsl,tmu-calibration:
>      $ref: /schemas/types.yaml#/definitions/uint32-matrix
> --=20
> 2.34.1
>=20

--l1Vrk9abMCA3Qchf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRq3HgAKCRB4tDGHoIJi
0k/cAP4rcAH5Hzz6AYlYVmFVEHq/fR+RgT3RB1W0v0JqWe8cZwEAjFBhNhOdX5Dm
/ywxaC7SmV7uvyK+UW3xuSeorzRQgQI=
=RcZX
-----END PGP SIGNATURE-----

--l1Vrk9abMCA3Qchf--
