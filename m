Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D917A713407
	for <lists+linux-pm@lfdr.de>; Sat, 27 May 2023 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjE0KfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 May 2023 06:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjE0KfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 May 2023 06:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B2710A;
        Sat, 27 May 2023 03:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901CA61830;
        Sat, 27 May 2023 10:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0677BC433EF;
        Sat, 27 May 2023 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685183702;
        bh=sg2FrDsa4OyGlWP61AQ7Bo4NewAEhbkfSJkPzv0P6QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kyuvmmXC5XO8XPh6CnRozru8D8aARsE0yU9P5OkmbMBnuXw2o3T29Bp36D/GBWkV1
         Z80HO32V5/EUR/JUHQgFmoPf/91NS0UaPaf1l6i0ES2pr2xAT4whW0x+8gSj1Yqnf1
         LycJStW+Fjl74+gnHBsb10Zte0AB4Y1yBX3ke5WT6+6uZZ1tCP+4ZGDeBg/L8qKkzD
         u1N7feJIDA2cWFW1Lr/yL/uKifG5WP7BJsFZpdiiwOUQF9VveAAn0yEWWIVn74tf+q
         TSLnJTaABiif3cBlzeexuI72zXomNOkIQUMBhCpRUVAYpdh9lw8k6eA7NT//9muVRB
         uDmIyHUoWRWkw==
Date:   Sat, 27 May 2023 11:34:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: power: supply: qcom,pmi8998-charger:
 add bindings for smb2 driver
Message-ID: <20230527-retaining-backless-7e1c5298b2b2@spud>
References: <20230524-pmi8998-charger-v9-0-cd7f6d03c0ab@linaro.org>
 <20230524-pmi8998-charger-v9-1-cd7f6d03c0ab@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4dHMmvzTtB+odP/d"
Content-Disposition: inline
In-Reply-To: <20230524-pmi8998-charger-v9-1-cd7f6d03c0ab@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4dHMmvzTtB+odP/d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 10:44:14PM +0100, Caleb Connolly wrote:
> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
> driver.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  1 +
>  .../power/supply/qcom,pmi8998-charger.yaml         | 82 ++++++++++++++++=
++++++
>  2 files changed, 83 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/=
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 36de335a33aa..44590dc112be 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -133,6 +133,7 @@ patternProperties:
>      oneOf:
>        - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
>        - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
> +      - $ref: /schemas/power/supply/qcom,pmi8998-charger.yaml#

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--4dHMmvzTtB+odP/d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHHc0QAKCRB4tDGHoIJi
0giLAQDd90qpqDEoqwaiVOGr+nJqPeUk42Zfbbahtll20cqwfAEA/DkptlMVYcLy
IMEADcbgGO6H3ug9jI1YnTs/d+Od1gw=
=31dr
-----END PGP SIGNATURE-----

--4dHMmvzTtB+odP/d--
