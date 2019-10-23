Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9276BE20BE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 18:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404898AbfJWQhD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 12:37:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51218 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403971AbfJWQhD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 12:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m700Ovhtawx1D7xYGjJcWREMnvuFfL4T8auLxTc4g+o=; b=tVW+N1CGFWe7AqjwhhUwObc5T
        4DcO3owdYhBJ4EIo45+VMPO/QapuVR8eKr7Hk4KYvWTFDygVNHMgTfW2vVYJf4451ljrE1z7fnQGU
        v2h/cr+LcMpU9LhKonteQt9Mc7RpjlboPdAiJmpHZKMCFJhUOm0rhoqvgfT6tteSrf55k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNJd3-0000wd-He; Wed, 23 Oct 2019 16:36:57 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0F4AA2743021; Wed, 23 Oct 2019 17:36:57 +0100 (BST)
Date:   Wed, 23 Oct 2019 17:36:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] cpufreq: s3c64xx: Remove pointless NULL check in
 s3c64xx_cpufreq_driver_init
Message-ID: <20191023163656.GH5723@sirena.co.uk>
References: <20191023000906.14374-1-natechancellor@gmail.com>
 <20191023032302.tu5nkvulo2yoctgr@vireshk-i7>
 <20191023104304.GA5723@sirena.co.uk>
 <20191023162628.GA10997@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Content-Disposition: inline
In-Reply-To: <20191023162628.GA10997@ubuntu-m2-xlarge-x86>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 09:26:28AM -0700, Nathan Chancellor wrote:
> On Wed, Oct 23, 2019 at 11:43:04AM +0100, Mark Brown wrote:

> > The driver should also have supported s3c6400 as well.

> Kconfig says otherwise, unless I am missing something.

> config ARM_S3C64XX_CPUFREQ
>         bool "Samsung S3C64XX"
>         depends on CPU_S3C6410
>         default y
>         help
>           This adds the CPUFreq driver for Samsung S3C6410 SoC.
>=20
>           If in doubt, say N.

Note the XX in the config option.

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2wgagACgkQJNaLcl1U
h9B+kgf/Tu4Mcdc2QLhbFdhdn07a8/luddZop3Dn6jL3SW5BZhP4E4UY9ekG3fTz
CKU0uGyVB8qUYZKlNQIgwWmBghGl9HeqKuLUGEdsDcOxVxccnSJYTMk2ZNLz6IK9
lH0wfeiXPIV7wguJCqAkkVZVfxdFZcKoQx00n6rTWjh7Py5qzuJtzwf/DTaDGsjC
F5nqTo4vdQQSNm6WSAEX/I629qmL3Yd/ogB+jUVFYvcqxozLMcuae+CP5Nu8MH8T
w5LrxCUugVJnkaUm6XUkeO29V9d2qmA3f9YU9BmyAm8caPdBABp5cjciu0X4sSCk
03ZCDlb+0oZqbtMSlcjVKXin63aMOA==
=JqnS
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
