Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6362178B4C1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjH1PuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjH1Ptl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 11:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A38DC5;
        Mon, 28 Aug 2023 08:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A56649C0;
        Mon, 28 Aug 2023 15:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D026FC433C8;
        Mon, 28 Aug 2023 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693237778;
        bh=EgwduPs67qveoZgcdAkipZLwkc8aT5xezge3BHjTvRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlHuE3se73qPb2ExjwJVhFAaLuJPJhhHepDASnBShkjs/So6Ed7mjchD/xdu4grrM
         SCae18W1kHPOR4kOXzBdBPA1gII459kX5CiDcpahkhnUIl/uIsd57ILzWHlbo0K8cz
         7iD3NYL3Nsj5/6b71I5YK49LQOvyMlau7denTSxBz7lglvvZ3J3xz2Fh3ehC+8KSz/
         2Wlk04sB1/XtxwL20d6Sgr2ZN3dvF6etkDtxrzSzd/2TvWkAeS7heG++MMDSQWjeTk
         6PfemCtrxGuGQMOJxUySc+Wi/hQsvhK6XBiA9qW+wIHHhvYrqvigh1ISAUj8ocjQlp
         TqMbiXidClShg==
Date:   Mon, 28 Aug 2023 16:49:33 +0100
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
Subject: Re: [PATCH 2/5] dt-bindings: soc: loongson,ls2k-pmc: Add missing
 compatible for Loongson-2K2000
Message-ID: <20230828-shrewdly-payee-c5eb091a0417@spud>
References: <cover.1693218539.git.zhoubinbin@loongson.cn>
 <54ee114c08f35ab8b5dc584fd76135ac9076f5a7.1693218539.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EHhPijYPZzBKwGBx"
Content-Disposition: inline
In-Reply-To: <54ee114c08f35ab8b5dc584fd76135ac9076f5a7.1693218539.git.zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--EHhPijYPZzBKwGBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 08:38:32PM +0800, Binbin Zhou wrote:
> Document the Power Management Unit system controller compatible for
> Loongson-2K2000.
>=20
> This is a missing compatible, now we add it.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml      | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k=
-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pm=
c.yaml
> index da2dcfeebf12..7473c5659929 100644
> --- a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.ya=
ml
> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.ya=
ml
> @@ -15,6 +15,7 @@ properties:
>        - enum:
>            - loongson,ls2k0500-pmc
>            - loongson,ls2k1000-pmc
> +          - loongson,ls2k2000-pmc

Same thing here as the driver patch, the pmc on this newly added SoC
appears to use the same codepaths as the existing ones. Does it share a
programming model & should there be a fallback compatible here?

>        - const: syscon
> =20
>    reg:
> --=20
> 2.39.3
>=20

--EHhPijYPZzBKwGBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOzCDQAKCRB4tDGHoIJi
0mJnAQC5PFTL8cQQxmV3Bs310RTUDpQiffTEZlPNe1A93VY/EAD5AXMuAU9VmRtZ
K/Mv7mHKDQ7h+pNz0M2jzI1i9iLyvA4=
=LQ8S
-----END PGP SIGNATURE-----

--EHhPijYPZzBKwGBx--
