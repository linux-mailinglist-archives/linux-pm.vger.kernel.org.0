Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BCEE213B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfJWQ7a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 12:59:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60776 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfJWQ73 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 12:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XrIyTUIIcwGweoXzbiGvqpSOVSltHgzWrBHeN+yMKhA=; b=luoGGER/eGCXKNWHKBECwxZ9x
        sLCfmNfX4bnSYny15P6DcWr3vzki1ED12Zzs26AainIOjMYSGefPYltHf2uBBfJJzVcOV+gTYjaVQ
        4ybUzVgt6iWL9sNjMtyTB93lLR3o6t9ffzuOhla/Yu9gsa8LwoPh2pfc7v6I/psgmtLN8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNJym-0000zH-4P; Wed, 23 Oct 2019 16:59:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 50EF62743021; Wed, 23 Oct 2019 17:59:23 +0100 (BST)
Date:   Wed, 23 Oct 2019 17:59:23 +0100
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
Message-ID: <20191023165923.GL5723@sirena.co.uk>
References: <20191023000906.14374-1-natechancellor@gmail.com>
 <20191023032302.tu5nkvulo2yoctgr@vireshk-i7>
 <20191023104304.GA5723@sirena.co.uk>
 <20191023162628.GA10997@ubuntu-m2-xlarge-x86>
 <20191023163656.GH5723@sirena.co.uk>
 <20191023165417.GA15082@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AQNmCumFClRcGgHG"
Content-Disposition: inline
In-Reply-To: <20191023165417.GA15082@ubuntu-m2-xlarge-x86>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2019 at 09:54:17AM -0700, Nathan Chancellor wrote:
> On Wed, Oct 23, 2019 at 05:36:56PM +0100, Mark Brown wrote:
> > On Wed, Oct 23, 2019 at 09:26:28AM -0700, Nathan Chancellor wrote:
> > > On Wed, Oct 23, 2019 at 11:43:04AM +0100, Mark Brown wrote:

> > > > The driver should also have supported s3c6400 as well.

> > > Kconfig says otherwise, unless I am missing something.

> > Note the XX in the config option.

> But what about the depends and the help text?

Viresh asked why the driver was written with s3c6410 support optional.
I explained that the reason that it was written this way was to
accomodate s3c6400 support.

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2whuoACgkQJNaLcl1U
h9D5XQf8DtCAVE+KWRLKQff+e0eoyrmuOH64fFlBCM0iJFytXmKaO6yq/o7FQjcx
9CLRRHMdyzXLnTiVGkmkhsVGuAOJPCM+tTjYr/fHoq83Y3cKVSpWnOre95Z52OBa
qkawCaJ6i1XrXY0hznOXDb48gQuKG7kecSLaKxGvskoYpI6csEoqeTU/jUKTSMqr
GGa5Kdcp4LNd77ZbOWg4TRzUVj9BdcU59SFkOSPB+eA9O/Lers0oGENcu59MrxXF
wgJnuQnwnJIv7liRZDk0/z6lSLWqIq32C/nm+AKUrQrD3obXhzvyZnigHpn/hwfV
tEmawktj1/+nJxfhTt1gh0vRlbhiyw==
=wsTD
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--
