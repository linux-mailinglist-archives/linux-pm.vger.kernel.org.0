Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CC6728BB4
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 01:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjFHXY6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 19:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFHXY6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 19:24:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE2D30D6;
        Thu,  8 Jun 2023 16:24:30 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 753836606F1D;
        Fri,  9 Jun 2023 00:24:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686266664;
        bh=mCFzt9Y8896kdcxmhKQPvHOnPkcXSRatB/HlXjIKGQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcSfKi7LayIU/v34zNkIEAO6QPFs20sykANJIiRceDpKRd4hBFyrlKfBYal9/3iIr
         5rvtCnsvrR8Ta18JeX7S0pkSdvFl/iJwv+QYkGizxbrD+0dnQQ1vPOTcb7h9uMaZKP
         N0KFG+JJc0i6PRfIffG8SDw+EROmPehrb56fXbhnxQBFJuSZuCL7S/Xkj6n4edo1Yo
         +G0ew41QMVPpyrzOs91GRBeMrMKaMa3kB19Q5dnfFJsZ/1ukC7e2ydRG51aqBPeZcd
         6+VXsmfU4oyTvEQnzvqo5BKme0Nzlcb0o1ZeX7nsg+tfoW/+arro/nm7rJHew23KZp
         ofFBskKzAUpgA==
Received: by mercury (Postfix, from userid 1000)
        id 29AFB1060A24; Fri,  9 Jun 2023 01:24:22 +0200 (CEST)
Date:   Fri, 9 Jun 2023 01:24:22 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: Re: [PATCH v9 0/2] power: supply: introduce support for the Qualcomm
 smb2 charger
Message-ID: <20230608232422.ikckij5m4adwnrap@mercury.elektranox.org>
References: <20230524-pmi8998-charger-v9-0-cd7f6d03c0ab@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cv4aioka2xke3d7y"
Content-Disposition: inline
In-Reply-To: <20230524-pmi8998-charger-v9-0-cd7f6d03c0ab@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cv4aioka2xke3d7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 26, 2023 at 10:44:13PM +0100, Caleb Connolly wrote:
> Add a driver for the Qualcomm PMI8998/PM660 Switch-Mode Battery Charger.
> This is the second generation SMB charger, and replaces the previous
> SMBB hardware found in older PMICs.
>=20
> Changes since v8:
>  * Add charger bindings reference to qcom,spmi-pmic.yaml
> V8: https://lore.kernel.org/all/20230524-pmi8998-charger-v8-0-b87ffcd9864=
d@linaro.org/
>=20
> Changes since v7:
>  * Implement fixes suggested by Sebastian
>  * Fix format warning
> V7: https://lore.kernel.org/linux-arm-msm/20230127230506.3140297-1-caleb.=
connolly@linaro.org/
>=20
> To: Sebastian Reichel <sre@kernel.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Caleb Connolly <caleb.connolly@linaro.org>
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Nathan Chancellor <nathan@kernel.org>
> To: Nick Desaulniers <ndesaulniers@google.com>
> To: Tom Rix <trix@redhat.com>
> ---
> Caleb Connolly (2):
>       dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for =
smb2 driver
>       power: supply: add Qualcomm PMI8998 SMB2 Charger driver
>=20
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    1 +
>  .../power/supply/qcom,pmi8998-charger.yaml         |   82 ++
>  drivers/power/supply/Kconfig                       |    9 +
>  drivers/power/supply/Makefile                      |    1 +
>  drivers/power/supply/qcom_pmi8998_charger.c        | 1059 ++++++++++++++=
++++++
>  5 files changed, 1152 insertions(+)
> ---

Thanks, queued.

-- Sebastian

--cv4aioka2xke3d7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSCYyEACgkQ2O7X88g7
+ppw6w//Zzu/r/8Xz5uRQd7GSe12Dh9LxYrMQSBlUvnx7kDxgozjcNN+g34yd0aQ
sRewvvYQy3jh5ssfNhTWI3uNp0TIeEtk+t1kJE2iTSry5wH7QikVOdydzd6+9CT1
8TEEzUQBywONL3GxSMUeN05Wb72hTKWUeQgoLiSbeogp9G5oBcWKvimG8mEM0jIB
yEazx6NM1SOdCMkA8LH89KoLo2xgXILpL6f2wFpCO3xYeKAa7n4+ifqweyOyvtjH
JMK21eCrP1Zp3LHLYOQNrf+I535Geqh8QpSl4joqm3xfBWE3WqMUFVRhRucyQXPa
k7PNzSwmmuf08w1unEXFImu5zSL1IvYwFRX+9dVPdxle2RmJnPjW3DJpCSyd+Zwk
6NqL6q+4jU7VwrZHwSGEqXS1EDJXcEfIFdEKyZHTIJ8HaUfREmzeVIihUwOsGu00
ifTffm90ySSeaZTIcQ0jZmNDryfF+hRTiNx5FgffjEqds/ppGmhackacJ86iefsu
o6c6fhBbMJPSzc3oHfBrMz8sfQlu6AJw0wDq1PJp8SNpqLoFSOVc3rL6ksJAaXJj
kmjYzOsfXiI+j5qN0aq+fac6uF875psA0DQFpjJSv4Qq01WhQAyxg4aLLKug2vyO
blz63/fj3Qmq9fZA8axOy+JJpylYjkqX3WaQsZSvRGYh2Se/vr0=
=F7Hh
-----END PGP SIGNATURE-----

--cv4aioka2xke3d7y--
