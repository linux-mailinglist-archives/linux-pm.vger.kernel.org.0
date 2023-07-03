Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2F7460D2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 18:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjGCQiS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCQiR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 12:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DD2E4C;
        Mon,  3 Jul 2023 09:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB41660FD1;
        Mon,  3 Jul 2023 16:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B23CC433C8;
        Mon,  3 Jul 2023 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688402296;
        bh=LZYtAPoqRLO4t1Oy4wzK5nYWXqfIPAkSuqkQg/HcCes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSCHnPU9jvzc9Pzzl+EJG4mkwUCQkexotZcaccEOhLutHDGqNbFoa9ZueHKB69BlU
         hgEe4/7z2JpFmZsyhWIGlhlCbhWa0dIQE5UVrFxPiGU4UBK+HzMt1b8/Lxg/sF1F0v
         IezQMZZUVxnCwg68QqyqRf21Q7hJ0sIzgHYaECYNZMP581VV+6O0JaU+apypULPpEO
         z9kcQptgnsDPUuopQOvP3snzoX5+VwoJLWXTIU4Mn2yn/opLPJenavoHrowylH/QeK
         hpXFiyGgy0exeyREBu1FGB1vIGB1ccBH1vvku+vS9ubilMPBubozQ5K+xqTurY25vy
         9l/iPlNFGml/g==
Date:   Mon, 3 Jul 2023 17:38:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [RFC PATCH 1/8] dt-bindings: nvmem: qfprom: add compatible for
 MSM8960
Message-ID: <20230703-tray-striving-eef10843a377@spud>
References: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
 <20230702175045.122041-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/s4fxM7mP/6a6+lZ"
Content-Disposition: inline
In-Reply-To: <20230702175045.122041-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--/s4fxM7mP/6a6+lZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2023 at 08:50:38PM +0300, Dmitry Baryshkov wrote:
> Add the QFPROM compatible for MSM8960.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--/s4fxM7mP/6a6+lZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKL5cQAKCRB4tDGHoIJi
0lEnAP0YlmIJOSwYf/7PVEYhTfZbpuJoaFQKbbdJwP00ZnT/hAEApl93pCtB9q7f
YZGnUEsWiGvtOQlTEzwX3jISg0+hsw4=
=Uc20
-----END PGP SIGNATURE-----

--/s4fxM7mP/6a6+lZ--
