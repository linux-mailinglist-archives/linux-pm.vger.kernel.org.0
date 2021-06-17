Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5673AB3BB
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFQMkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 08:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhFQMkG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Jun 2021 08:40:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 252A7610CA;
        Thu, 17 Jun 2021 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623933478;
        bh=JXZlIvP9Jv7f57Wfb41hYAPLe3/lzlvn9IlwjLKbrf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLUpejLzm6khVyg99lx39uFIe+3YsyCNZ3x1fBTlmBClMnh7AasKRaTFw0zN3Ph+L
         UVEBU6qGkRcIiGFZ3WF//KGW5U9ha0cxD8zbFjM7nNBPBUEvTpLjkMdej2B5d5nGOq
         TvYunvw+D8eyjtjnaNC3Z/KxX5GN4QSscdln2aa2PcDoxJXO49SXw5tSCuNe/y223U
         us4vSqdmNMTLwYsIy9IQYl9mtcFhkpuiq9JrFcJWekM4zvBRc/kt6jPGkHjX4yYqKZ
         0L3LQQFeCGz8qp1SySWogVsfCBcVdtAPfPLUpH35shkgvkaRBVtjpzk0bQsrzQpObF
         g4PoHrqb+poNA==
Date:   Thu, 17 Jun 2021 13:37:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH RESEND v10 00/11] Extend regulator notification support
Message-ID: <20210617123738.GC5067@sirena.org.uk>
References: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: But it does move!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 08:40:07AM +0300, Matti Vaittinen wrote:
> Extend regulator notification support
>=20
> This series extends the regulator notification and error flag support.
> Initial discussion on the topic can be found here:
> https://lore.kernel.org/lkml/6046836e22b8252983f08d5621c35ececb97820d.cam=
el@fi.rohmeurope.com/

Any thoughts on the reboot or thermal patches?  In the absence of any
further feedback by the end of the week I might go ahead and apply
things to the regulator tree if that's OK with people.

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDLQhEACgkQJNaLcl1U
h9CFGAf/URUmhopehFCmMlbpAU+UBOk0Mjr8Ko9s6KYYgB+p4HLxz0dSmuS1+iAo
+oMzCCE6wWOR8uFQ0UvnceyS0ixGE7O2QVds0nz+nk5Kl6rAgOFVx/DpWE238ZGi
r5v5qjX2mo92x8fvYnQGMeH8rJtXhD92r/kN7vdu+E6Dt3+HPTGS4fSxiWwAq1Pg
46t5I2wArFhOaGCZJ/68jQJg9BZ3+wE2ThPUWy4eWTB4wwqXmoiUKaLO6Tbsuna+
G+JbnO2md5U205F15CDlppUAl4e9HpxEYpv8I6MaWhdpsmawHLSiS/us3tqGTZE1
zBNA4Di/Ay7xzS6WIOA0cza2giFBRg==
=D9Xy
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
