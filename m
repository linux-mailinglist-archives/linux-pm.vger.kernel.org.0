Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FC77812B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 21:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjHJTQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjHJTQr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 15:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A452702;
        Thu, 10 Aug 2023 12:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02FB165EF0;
        Thu, 10 Aug 2023 19:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E284C433C8;
        Thu, 10 Aug 2023 19:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691695006;
        bh=ABbCZnqaHOMEf90aqEG/uJbFjwHMDbi8Eiuwkh1cz7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSBhGzffw5L18ttbTOWjs5Obei0i0OCfy+Try87B2jrFtGrHR8rPlJSOrhj+0fJfR
         5hVTwHukXwBPl9wIVDDvlbcJjqsiv26D0/6npFwTzi7bO904VaNzc6oKdWXTvRosVB
         7azKIo7cge//Rd6wSWjLdHPoW3+3HLLV3RDHXEvNx3Zdc0brPavwuDG2CznN/f76d1
         X1B06c/xV6n5iTohjtepYLyfRV3rsPBTQbeVn/CT2JPUgD26DAZ4qnFYoAeZgvCz6M
         MYtMia5SfjzyPiA0YppYjxjja39vEMW++2eetEPL26n3WLmQO02UyTfaTN5GI25G07
         JLxOh76uGgQ/A==
Date:   Thu, 10 Aug 2023 20:16:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] imx6q related DT binding fixes
Message-ID: <20230810-endearing-regime-55ef11e2eb10@spud>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="URlnTqj3lemnJ3lq"
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--URlnTqj3lemnJ3lq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 04:44:45PM +0200, Alexander Stein wrote:
> Hi everyone,
>=20
> while working on i.MX6Q based board (arch/arm/boot/dts/nxp/imx/imx6q-mba6=
a.dts)
> I noticed several warnings on dtbs_check. The first 5 patches should be p=
retty
> much straight forward.
> I'm not 100% sure on the sixth patch, as it might be affected by incorrect
> compatible lists. Please refer to the note in that patch.
> I'm also no sure whether thse patches warrent a Fixes tag, so I only adde=
d that
> for patch 3. All of these patches are independent and can be picked up
> individually.

These all seem fine to me, with the last one being really a question for
those with knowledge of the hardware.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--URlnTqj3lemnJ3lq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNU3lgAKCRB4tDGHoIJi
0iDzAP9btbv433WunzUjWgavbWN4XYM2BmISvgmqPvWHzHBEGQD+O9uZXAvmB0sQ
bp9J69XKdJ8+MnisYcWMrLxgYZ6PSAk=
=bwwc
-----END PGP SIGNATURE-----

--URlnTqj3lemnJ3lq--
