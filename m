Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E1478B47C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 17:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjH1Pcn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjH1Pcl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 11:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFB5E1;
        Mon, 28 Aug 2023 08:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC4E61766;
        Mon, 28 Aug 2023 15:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B323C433C7;
        Mon, 28 Aug 2023 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693236757;
        bh=n+HOb8/DOkSkv6qbcqDYdruBbEwzTG5YIOFlBwbk2rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1nytWDTy/tIxxTtNvp6x2e2piwAMq9p6H57MDylhErQ5MluShijnloy1DesDgr/4
         VvZsTSHHTM4WWABXLfPaFwU2caIbHz0M6jn2xk8BPyP3Yxb624ZJAmK613iUPxq90n
         WabmTBFGXXtt4D0MZfjID9Zcl5hfVaGYKBBnQtkHPtuPrND2F4MTpTKhMvJpaeZgXl
         /DioONzHPRt4+4rX0noAOynksv6yKAZvre9LpNlAwkda45A/nUqGZUeqE2OXNjOdLa
         k6v4p+6bYNUK6EUfHro1oLURb4bFxAbyz3bQ5n5jU63I6R8Q97IDyF1vv52ncuMlzP
         hvIySzj0CbPNA==
Date:   Mon, 28 Aug 2023 16:32:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev
Subject: Re: [PATCH 3/5] soc: loongson: loongson_pm2: Add missing compatible
 for Loongson-2K2000
Message-ID: <20230828-compactor-contour-3a9f4991360f@spud>
References: <cover.1693218539.git.zhoubinbin@loongson.cn>
 <8468bdbea87003dc05bd10d15b51e6d27f306a20.1693218539.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xl72ewxv2X0f7Y4j"
Content-Disposition: inline
In-Reply-To: <8468bdbea87003dc05bd10d15b51e6d27f306a20.1693218539.git.zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Xl72ewxv2X0f7Y4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 08:38:33PM +0800, Binbin Zhou wrote:
> Add compatible for Loongson-2K2000, which also has the Loongson2
> Power Management Unit system controller.
>=20
> This is a missing compatible, now we add it.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/soc/loongson/loongson2_pm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/soc/loongson/loongson2_pm.c b/drivers/soc/loongson/l=
oongson2_pm.c
> index 796add6e8b63..6d2b3708e947 100644
> --- a/drivers/soc/loongson/loongson2_pm.c
> +++ b/drivers/soc/loongson/loongson2_pm.c
> @@ -198,6 +198,7 @@ static int loongson2_pm_probe(struct platform_device =
*pdev)
>  static const struct of_device_id loongson2_pm_match[] =3D {
>  	{ .compatible =3D "loongson,ls2k0500-pmc", },
>  	{ .compatible =3D "loongson,ls2k1000-pmc", },
> +	{ .compatible =3D "loongson,ls2k2000-pmc", },

You've not added any new codepaths for this soc, so it is compatible
with the existing ones. Why are you not using fallback compatibles for
this?

--Xl72ewxv2X0f7Y4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOy+EAAKCRB4tDGHoIJi
0okVAP9sQoTuARR2r50RcVlYllk1XS4Ssa5osAlD8MZfPRKxgwEAvYIASGDN36Zc
I4RRQt92IJbOaRFomxERuovjUkxxvA4=
=P4w5
-----END PGP SIGNATURE-----

--Xl72ewxv2X0f7Y4j--
