Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D84161D42
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 23:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgBQWWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 17:22:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37583 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgBQWWn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Feb 2020 17:22:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Lz4s3TWQz9sPJ;
        Tue, 18 Feb 2020 09:22:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1581978159;
        bh=T/Ho1UZEyFt8rs4SdRhU3v+8yxewmcXVrq7So23AQHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fB16ZjEjWQ1+Dxc9OAbPk1bDSsmg4otnhc3HTmHHRUZxQHUqv5wcWqNqrxOTW+r1J
         oZlKigjMDFIO/I4jB/cGtIYxaqCPFdkr9TZeALZFb0sAljMlUU63CmHp+e1vbZIFwA
         u+L8sHcmVeoBFKhmD5BKx7+YPh9dLhdnPOAuMZJNqvTVmYZz8yB44kQUBOEnjUNHFl
         8OwTcN2z4rNA74p27snEmuoIiyUCDSBxm01OyfUdfYBKYvKUttrenaWdpsuNCjWh1+
         27rmHRv6oHPkLT/lmu2Z8Eb++7cOZcqH0Rargn+kVEKD+RPyQHIxPiEAFtm5GJgnW5
         ylz9hfujI2HIQ==
Date:   Tue, 18 Feb 2020 09:22:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH] soc: amlogic: fix compile failure with
 MESON_SECURE_PM_DOMAINS & !MESON_SM
Message-ID: <20200218092229.0448d266@canb.auug.org.au>
In-Reply-To: <20200218080743.07e58c6e@canb.auug.org.au>
References: <1581955933-69832-1-git-send-email-jianxin.pan@amlogic.com>
        <20200218080743.07e58c6e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.qVlDOXsSXuL3sxUO2UwZ_+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/.qVlDOXsSXuL3sxUO2UwZ_+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 18 Feb 2020 08:07:43 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 18 Feb 2020 00:12:13 +0800 Jianxin Pan <jianxin.pan@amlogic.com> =
wrote:
> >
> > When MESON_SECURE_PM_DOMAINS & !MESON_SM, there will be compile failure:
> > .../meson-secure-pwrc.o: In function `meson_secure_pwrc_on':
> > .../meson-secure-pwrc.c:76: undefined reference to `meson_sm_call'
> >=20
> > Fix this by adding depends on MESON_SM for MESON_SECURE_PM_DOMAINS.
> >=20
> > Fixes: b3dde5013e13 ("soc: amlogic: Add support for Secure power domain=
s controller")
> >=20
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: patchwork-bot+linux-amlogic<patchwork-bot+linux-amlogic@ke=
rnel.org>
> > Reported-by: Stephen Rothwell<sfr@canb.auug.org.au>
> > Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> > ---
> >  drivers/soc/amlogic/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-) =20
>=20
> I will apply that patch to linux-next today.

This fixes the build for me.

Tested-by: Stephen Rothwell<sfr@canb.auug.org.au>

Also, please keep the commit message tags together at the end of the
commit message i.e. remove the blank line after the Fixes: tag above.
(see "git interpret-trailers ")
--=20
Cheers,
Stephen Rothwell

--Sig_/.qVlDOXsSXuL3sxUO2UwZ_+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5LEiUACgkQAVBC80lX
0GxiFQf/YRVKJcX4m5O/6kWTlxZ2/vzcKlyfDLSY2sadgEbNcCoGpqHg3C8MuVN5
SHJd3URexLrLU3zLpCtgxCgDTjoQRNjqUIZVQYnWFBI0bOiWu+rc9Z+SCuJ62UVq
Ct6I89voQEMg9Wdz37uordsgbGJIRq+VFiA2lOSLJhMxQIJ9/5Wf5AO0i2g/RDxz
j/xX2bbl2nb3fFBBWQ59Hs1/GHaXCv73apLt0WTxxw8I5slbF0sRYqWDo0BABABX
PIar9gHeIOrBLJWJJTqJV3E7/JepXwBpfZK7fuZKcroirNefQrkQdhRW26C7gKFN
9uuM1INSTOTPFxa5jaYaw0r3vAnkYg==
=IwNd
-----END PGP SIGNATURE-----

--Sig_/.qVlDOXsSXuL3sxUO2UwZ_+--
