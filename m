Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD27DD3AC
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 18:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjJaRB0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjJaRBO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 13:01:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C87D90
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 09:58:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C5FC433C7;
        Tue, 31 Oct 2023 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698771504;
        bh=EXc7FfdhWkgC8EXJESwgVLIiX4BW4W7aviY/soY+zWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUjz+M83TAJK5a62H2SN2uk4JxXlZQ3BaeWfgLG5GNO7sZGmFTLEo4M+nUUg9iCd5
         NadizlmTzfR4oQYqpZ6s0+4UdQ7kw0MkX6Xidgq7qgxKJBbPacuAVI8ytdCFq7N6yb
         Ge6m3gLJEq2Poy/zPILHVloMWRzp/8C/6GMEjx+MiQrYQqbwZYJ6KV9cvOIRSIjQzU
         u2t82g3K52zeoCDcXEfEItaV3EDSVEso7XOVfm9blV3e5Z6upZox2zZkyKGo4OAnb5
         XynAYeF4m8FimQbBzwPcGgrqUqS/aZyPg3jcgUqhO5gXG75KV1dpWB4a8Gp6QORBUU
         7ltuJt6Ux2WXA==
Date:   Tue, 31 Oct 2023 16:58:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Yinbo Zhu <zhuyinbo@loongson.cn>,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: thermal: loongson,ls2k-thermal: Fix
 binding check issues
Message-ID: <20231031-negative-giveaway-6191a2da0cd5@spud>
References: <cover.1698743706.git.zhoubinbin@loongson.cn>
 <944559ea3bf7ba0a1540f831ccd7d33591622b22.1698743706.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MmKz63fqu/mZqg9d"
Content-Disposition: inline
In-Reply-To: <944559ea3bf7ba0a1540f831ccd7d33591622b22.1698743706.git.zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--MmKz63fqu/mZqg9d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 07:05:49PM +0800, Binbin Zhou wrote:
> Add the missing 'thermal-sensor-cells' property which is required for
> every thermal sensor as it's used when using phandles.
> And add the thermal-sensor.yaml reference.
>=20
> Fixes: 72684d99a854 ("thermal: dt-bindings: add loongson-2 thermal")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/thermal/loongson,ls2k-thermal.yaml        | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.=
yaml
> index 7538469997f9..b634f57cd011 100644
> --- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> @@ -10,6 +10,9 @@ maintainers:
>    - zhanghongchen <zhanghongchen@loongson.cn>
>    - Yinbo Zhu <zhuyinbo@loongson.cn>
> =20
> +allOf:
> +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> +
>  properties:
>    compatible:
>      oneOf:
> @@ -26,12 +29,16 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  '#thermal-sensor-cells':
> +    const: 1
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
> +  - '#thermal-sensor-cells'

Why does it need to be a required property now though?
Adding new required properties is technically an ABI break.

Cheers,
Conor.

> =20
> -additionalProperties: false
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> @@ -41,4 +48,5 @@ examples:
>          reg =3D <0x1fe01500 0x30>;
>          interrupt-parent =3D <&liointc0>;
>          interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +        #thermal-sensor-cells =3D <1>;
>      };
> --=20
> 2.39.3
>=20

--MmKz63fqu/mZqg9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUEyKAAKCRB4tDGHoIJi
0k0cAQDPw6O0fZMpvQeC7hVo6AKxjMU7IA9SCENIscLXKwsmigD/T+WLG3cAvHjw
9M/MySMq/6DajsHg0C6nsGeWj3na/QU=
=MXOh
-----END PGP SIGNATURE-----

--MmKz63fqu/mZqg9d--
