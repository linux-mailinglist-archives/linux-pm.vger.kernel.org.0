Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64228174A92
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2020 01:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgCAAs2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Feb 2020 19:48:28 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgCAAs2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 29 Feb 2020 19:48:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48VPlW5nYLz9sPk;
        Sun,  1 Mar 2020 11:48:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1583023705;
        bh=4nRI6rwZRJmJBCSa2D7NMwK+7ECxFcV3Jplu7f2M8vI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bQndGde94p9FyOTmTOsKt5AnSDdUQoxCwxy7l9+8ZpBXs+oyYGsT/USUpwwCYFUeB
         OAs2OK8w6ainF6Hb1E0AJ3CtUFbC/Gb0BjAl8V8sCSxedVthQ/5mF0cXHyhWH3URuy
         548JnLhcYrDjKtEwM62cZV7xhRlwqKtlLRSnogfOpYniYaEqqhZXM/iY1dM+4u/X/N
         6kc5DIlzx4Xg9x6Gdes2FktrED8OwRU/yMDa6+PP8t50g89z4T4PxnCkpVeVv3S4db
         oEtYHaxZc1SvKAmmMUypMuz3UqBveSsmjCegll5CS64Xsw+gfj6rEWt1n7xZ+786FC
         OU6eoFzkoU47Q==
Date:   Sun, 1 Mar 2020 11:47:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "Jian Hu" <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH] soc: amlogic: fix compile failure with
 MESON_SECURE_PM_DOMAINS & !MESON_SM
Message-ID: <20200301114750.7d270124@canb.auug.org.au>
In-Reply-To: <7hzhd19vuj.fsf@baylibre.com>
References: <1581955933-69832-1-git-send-email-jianxin.pan@amlogic.com>
        <20200218080743.07e58c6e@canb.auug.org.au>
        <20200218092229.0448d266@canb.auug.org.au>
        <20200224101654.530f1837@canb.auug.org.au>
        <7hzhd19vuj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Kf1.E4dLddnNTqvZx6GlV0A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/Kf1.E4dLddnNTqvZx6GlV0A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Sat, 29 Feb 2020 17:55:32 +0100 Kevin Hilman <khilman@baylibre.com> wrot=
e:
>
> I've fixed up the trailer whitespace an queued this up now, so should
> show up in linux next shortly.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/Kf1.E4dLddnNTqvZx6GlV0A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5bBjYACgkQAVBC80lX
0Gw+KAgAhjy4Z4V15rVXk29DVizB7BmoTp0AHlbwyBOXdg1fqDDAgpSapQv/aaTF
t/kpWrI8HPqJIV33mTw9Y4ihIwM3w3hurf1Z3fal9lem4IITW6hlcuXG8jm1I0Zh
rMlvimE+P9nv7UYTDqgQx0+v7nw3Y0kxJTkkoRbtPMOBeX/mq3oEMqHmvyTRzjjf
+uqsMBh50kotDakasWPX47i7cULdhXg3BUd/lPYg7n1wJ179GLOl0F83CLmbeCtK
D5PxpxIZmQEvgFModR81zi8NPz46WCa1WeSQ0edqS2AYBe8p6FWYyEeBCmU2b2ER
xjSTCdXBgNDI8gD67V0Tx7Qs1++sjA==
=V59f
-----END PGP SIGNATURE-----

--Sig_/Kf1.E4dLddnNTqvZx6GlV0A--
