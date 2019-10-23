Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE762E1831
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 12:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390935AbfJWKnM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 06:43:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390566AbfJWKnM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 06:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o8+aRiWYArgOfcIQUpcz0HRWYDcLBPfXp8bzXS/M6uk=; b=osCh/jbEew5Dyc2YthYufYOzT
        /wWvYeSc75A8nWZCJhQPtPZQJIPzRLmVMjAZHWDrgPwEE/cD+/tXhLi+RnPHgD+OxlAHWnpdBLkTV
        GlWNDNNzdGUT/gMTgUuVag18SmkkVxCDkpkaaAQASWnWKQnpLoDjBpCmbLBxBwdkDyz48=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNE6b-0000J4-QS; Wed, 23 Oct 2019 10:43:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0557E2743259; Wed, 23 Oct 2019 11:43:04 +0100 (BST)
Date:   Wed, 23 Oct 2019 11:43:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] cpufreq: s3c64xx: Remove pointless NULL check in
 s3c64xx_cpufreq_driver_init
Message-ID: <20191023104304.GA5723@sirena.co.uk>
References: <20191023000906.14374-1-natechancellor@gmail.com>
 <20191023032302.tu5nkvulo2yoctgr@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20191023032302.tu5nkvulo2yoctgr@vireshk-i7>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 08:53:02AM +0530, Viresh Kumar wrote:
> On 22-10-19, 17:09, Nathan Chancellor wrote:
> > When building with Clang + -Wtautological-pointer-compare:
> >=20
> > drivers/cpufreq/s3c64xx-cpufreq.c:152:6: warning: comparison of array
> > 's3c64xx_freq_table' equal to a null pointer is always false
> > [-Wtautological-pointer-compare]
> >         if (s3c64xx_freq_table =3D=3D NULL) {
> >             ^~~~~~~~~~~~~~~~~~    ~~~~
> > 1 warning generated.
> >=20
> > The definition of s3c64xx_freq_table is surrounded by an ifdef
> > directive for CONFIG_CPU_S3C6410, which is always true for this driver
> > because it depends on it in drivers/cpufreq/Kconfig.arm (and if it
> > weren't, there would be a build error because s3c64xx_freq_table would
> > not be a defined symbol).

> +broonie, who wrote this patch to see his views on why he kept it like
> this.

The driver should also have supported s3c6400 as well.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2wLrMACgkQJNaLcl1U
h9B2ZAf/eQxJSi8vjkh2szC5fpPoxL3PqhhtoNyHk9pyamhKksLnfq8Wfc5cXoYf
m805fFfs10op9oNpI//wwBy+WtmSWx7wFDZx+by2GeKvzPfCqjdXBvUziAtQhq/q
pU4RI10nDISz7KV5+MogDYKIqS86tiaCpprrXQI9B524i1u1TCIiaqoW9EC6eho5
104of9kneV1wM3wKRtz1W9HkOlV+Dnm1rDRWldGriYbd+HAJNhxGe+LNiLubnATf
N3ntYDNTJmhuwc4KWuzOTHQE+5RXi2VBkk599ZoLoNSZhd6M5a4UU896+XYBjvEN
NBjAKyjIVg55uIINznEJ2YtoD+u6qg==
=wd9j
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
