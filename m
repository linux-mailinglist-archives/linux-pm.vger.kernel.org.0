Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B131728A71
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 23:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFHVxS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFHVxR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 17:53:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06521FE9;
        Thu,  8 Jun 2023 14:53:16 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A413E6606F20;
        Thu,  8 Jun 2023 22:53:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686261194;
        bh=0turIOKv3Fz3xiHNL4HdnpSFWFoTeQvCzI/w5GgFqM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h69W7farTNDyLucXIIgezy6iqneK4NlWAwzzJib0otp5n8pEWwAbwqo+DHUIdgWcZ
         RlE1EJeKTc/6UB+bW8nCG3igTqlrhjZxKD420IqUZblZK1hRRCSoI5jtwNpRWn7auY
         lFTpXH94bZPivpiQALLfGorKEFrGIQuAAUt4bSnieQSpCs4aTsC6PrWGpaHDj2dVHX
         ofaP0Bpc2u+ujR5rIH5yFup5bXahRU/M7DNrnsCQLaQzTwzZQL5BaQNwNV62yvhBFz
         AtDMNDW9z6As50oK5sul7pJThl3mdCQIFbd6oxMOtsL8u/61yK5DEM3Cjyo1Q/bni4
         kojRjJusJ2LjQ==
Received: by mercury (Postfix, from userid 1000)
        id 419C41060A24; Thu,  8 Jun 2023 23:53:12 +0200 (CEST)
Date:   Thu, 8 Jun 2023 23:53:12 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: power: reset: qcom-pon: define
 pm8941-pon
Message-ID: <20230608215312.ilq5aygpvzuw45z2@mercury.elektranox.org>
References: <20230531014248.3824043-1-dmitry.baryshkov@linaro.org>
 <20230531014248.3824043-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a5ibemveujedc67j"
Content-Disposition: inline
In-Reply-To: <20230531014248.3824043-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--a5ibemveujedc67j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 31, 2023 at 04:42:45AM +0300, Dmitry Baryshkov wrote:
> On PM8941 pon doesn't store the reset reason. However we still need the
> wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
> device.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Does not apply, please rebase.

-- Sebastian

>  .../devicetree/bindings/power/reset/qcom,pon.yaml    | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml =
b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index d96170eecbd2..eb3c88e501ef 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -19,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,pm8916-pon
> +      - qcom,pm8941-pon
>        - qcom,pms405-pon
>        - qcom,pm8998-pon
>        - qcom,pmk8350-pon
> @@ -56,13 +57,22 @@ required:
>  unevaluatedProperties: false
> =20
>  allOf:
> -  - $ref: reboot-mode.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: qcom,pm8941-pon
> +    then:
> +      $ref: reboot-mode.yaml#
> +
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
>                - qcom,pm8916-pon
> +              - qcom,pm8941-pon
>                - qcom,pms405-pon
>                - qcom,pm8998-pon
>      then:
> --=20
> 2.39.2
>=20

--a5ibemveujedc67j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSCTcMACgkQ2O7X88g7
+po27A/9HhEyoeuF36BaSeCu+aIYi+sNeTS9GUfQRDUUp5OhEu51nxu/r2DbqSMh
yzfbPtefjtfexpDzPjcHjiLkHrrwX/127SB46TyKIm4/B5kjFRFlUdgQ6r+WG6ta
jyo2YcBet0IewhIfmXkhCn0a2io2XR3ckoMsEQcDrkkXjDY0pn/aEZPTWDoXq6c7
peS8DHZXsm51ffopCy1N0VTEcNLSNIafE5enZm4hfIJvY0uLqxLHlXUFo18Qcy7I
JzglUJIbfjqb3PuyTgI6u9EnFOIRouWnGArm9NCXvGnk70wnOsVAXMNf5qARievv
zVgbG7VnT6PudkaPIyy6CFYfRANvg8mWXpLD5s8J0XjV9gjM1TbcqAaXOF6EHo8I
SbdWisqtT5Ne1keoSdqkKzdka5/EfYN8D5RIRmDKkIydxTC0grZKXnPkNh0Ormpa
zHZlOwMegmRnRawiEZTZB61dLwPrnxWLcspgpxrxSdVZJtQYEaOLojg0REHa4OzH
TgP1Lo1spgJ5+3/86GAdRXGJau/Ms8KG43AA70jZ4rM8yQAt4rObuQQEJNHeTAPC
EjMOaCqgWKs8PeuCTztXSzvElKkK60qHRBpi8vUGocrN1hUN8mvRsIV0lXXJNnuG
7wo2q6GzFavDnLNGbYQgz3IIoBGt731G2eJmGfsSK2IPu1sl7Hw=
=illl
-----END PGP SIGNATURE-----

--a5ibemveujedc67j--
