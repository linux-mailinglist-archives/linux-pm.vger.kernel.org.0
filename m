Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E932AC9A9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 01:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKJAYJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 19:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJAYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 19:24:09 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FDBC0613CF;
        Mon,  9 Nov 2020 16:24:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CVTBB2zRGz9s1l;
        Tue, 10 Nov 2020 11:24:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1604967844;
        bh=Ti1Sq57D7UTNDxlGQA3Kpf+FaZhQzC6sbUa6johPKzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JBuF+yb2xdeOf2t8gWMG2cePZJBghlvK/WWGXAyhTLjpqWs2sTPCkZL/808B2/TEA
         ftQlr3ktff3k8YsS9qs+4ApFJhzPafa/EB6u/klViBowyAI/TXSR4+RK0L3Vj36sFC
         IfXIH5txbptUGz2Xg+dNPuA6iRPOIH77J5fy+VOStIkezpV52l9jK2oWcYF1KPlfNC
         DdKxcK1TV+LN6ujhA0HaDR9Ql4HZo2IQXDYGTOoD10HVn+YGXRm1lVCXlbFEuQme26
         GC2URNOP9A1FYTWT2GpWJx7aN1K+VQ7qYdgv369GjN9UxohmyENq9mUBLnCbjHvkgs
         WvsvJqkG5//GA==
Date:   Tue, 10 Nov 2020 11:23:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>, linux-next@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next v2] clk: pm_clock: provide stubs for
 pm_clk_runtime_suspend/_resume
Message-ID: <20201110112358.7534075f@canb.auug.org.au>
In-Reply-To: <20201109032115.10610-1-rdunlap@infradead.org>
References: <20201109032115.10610-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kVA7201z7YABmbVZ.11D5.l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/kVA7201z7YABmbVZ.11D5.l
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sun,  8 Nov 2020 19:21:15 -0800 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> Add stubs for pm_clk_runtime_suspend() and pm_clk_runtime_resume()
> to fix build errors when CONFIG_PM and CONFIG_PM_CLK are not enabled.
>=20
> Fixes these build errors:
>=20
> ../drivers/clk/qcom/camcc-sc7180.c: In function =E2=80=98cam_cc_sc7180_pr=
obe=E2=80=99:
> ../drivers/clk/qcom/camcc-sc7180.c:1672:8: error: implicit declaration of=
 function =E2=80=98pm_clk_runtime_resume=E2=80=99; did you mean =E2=80=98pm=
_runtime_resume=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>   ret =3D pm_clk_runtime_resume(&pdev->dev);
>         ^~~~~~~~~~~~~~~~~~~~~
> ../drivers/clk/qcom/camcc-sc7180.c:1681:3: error: implicit declaration of=
 function =E2=80=98pm_clk_runtime_suspend=E2=80=99; did you mean =E2=80=98p=
m_runtime_suspend=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    pm_clk_runtime_suspend(&pdev->dev);
>    ^~~~~~~~~~~~~~~~~~~~~~
>=20
> Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller drive=
r for SC7180")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: linux-next@vger.kernel.org
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> v2: move the function stubs to be inside the #else (for !CONFIG_PM)
>     as suggested by Nathan to fix another build error
>=20
>  include/linux/pm_clock.h |    8 ++++++++
>  1 file changed, 8 insertions(+)

I have added this to the merge of to clk tree in linux-next today
(pending it being added to the clk tree itself).

--=20
Cheers,
Stephen Rothwell

--Sig_/kVA7201z7YABmbVZ.11D5.l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+p3Z4ACgkQAVBC80lX
0GylrggAgWLtxVpvAT6XbNbAXqfr2ATTEcubuM8h7Tueti77AlQlAh99RWqKHHAI
lS05MrkjXe9XPYEI8kPkhph+/LSFhmRezQc6KsH7Y5E8uNZL/4k474A4Z6Cz2uE+
SL+1M1BDRONkfD9l5cuDdqEhwHLZzgZ8vQdfus5+9RnprRMV3PtqW1FTFZUsjXBd
H37vt4K6ZTJvgPB+7XH6+FPFBeVsqnVilx8IYK/2G12yWN7Gb4eZIUGoZbMGXzCf
M63Gm+bpVPcuRWV/PboK/FeVUyJ8mjldjMwCjUxJPGJgVoO6gyJuFCuf2ivMoYrh
wbU5dOw3Ka3fUA3OiTQkI3/pGv7MaA==
=qN6g
-----END PGP SIGNATURE-----

--Sig_/kVA7201z7YABmbVZ.11D5.l--
