Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BE81BEBF0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 00:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD2WLv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 18:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgD2WLv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Apr 2020 18:11:51 -0400
Received: from earth.universe (dyndsl-095-033-155-009.ewe-ip-backbone.de [95.33.155.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B5532076B;
        Wed, 29 Apr 2020 22:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588198310;
        bh=NhJAGA4WB4ekULoqW87ilxLf8lLw8KWDvkBTnjmjiDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBOfG5srM35SBMfI2Op8Z/+cCm8Z7RP0MbLIbzO9SX4YMVoKDug0qFEDIakDqv20A
         FBXLfzuTVUr3ou8QabGEC4vGojna1iGQTr1JmjPjvSn9O2pA76RuUT8fOBGj5gElka
         r490vEmIJ3Aw8ayvxWRtAiFxNaMQxCWYSUSSxT3U=
Received: by earth.universe (Postfix, from userid 1000)
        id B37603C08C6; Thu, 30 Apr 2020 00:11:48 +0200 (CEST)
Date:   Thu, 30 Apr 2020 00:11:48 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 00/17] Modularizing Versatile Express
Message-ID: <20200429221148.q7lozhkha6j3t4nt@earth.universe>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nthuz3olvzwitejh"
Content-Disposition: inline
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nthuz3olvzwitejh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Apr 29, 2020 at 03:58:09PM -0500, Rob Herring wrote:
> [...]
>
> v2:
> The major change is a boot fix for 32-bit VExpress platforms with patch 3.
> I also dropped 'power/reset: vexpress: Support building as a module' as it
> was incomplete and not needed for this series.

Ok, please also drop me from Cc for v3 :)

Thanks,

-- Sebastian

--nthuz3olvzwitejh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6p+6QACgkQ2O7X88g7
+ppsow//fD+6baBTm98AWivrmVVWoWCogsnA14PAN71E53Bra7o+E47MHNsq9eSD
KeukkLWEMwt24Bl18kGAZVADe2kHsibb6s4i497ZvY57L/FIy2kI0e2lXeJh2nRA
saNyrSWvV1u2EXb4pxMARzS/fDhPGq+eVbyoDwLiM+Ldy3HkAePU7y0vbZthnBKN
Xh/oZdjFHRZvKzvvqUQ0n9KmIhTbSGA4XO67s8RaufSM8/36/BI8P/9DhHEIbUsE
MILYSECWvSnHXXMXpFMk4KBDoFwFyhxhhRqVIlhn3cz+PycqtPfiNnOKIG5vhxhW
ez4caJtiElsjDP9IpoQw1MEEDYJpFGER90tNo/AQv/SNAc9I0febivmcWjuXDrQB
LuLDfL19RY0lOelVr7JJB1pcwylGwTcUTWZsPLXCk61ReRxMFZMlASEQJsL9qjcT
h2Gq8U4NLlXtibCYTwQFYmq7c3H9Bfyc1fcl7ER146pP37UGHMYfMeikdw/9vAgB
l901C/5smpeoUq6HQDxvpz3yxfPgzg4EzKwlLkwiFG1P5HlHUVhQRrM9xaBKoN3M
cYJLY6JNELq7SwrSiuaiROH57tO5ogtunFS7aZYYNx2odz2xZewjH1uxQnByJQ1G
u6QuAxsh/dAUTfUviK8Q48d9q/CYnzy5wl0koZxWl5optFu/BKo=
=fGB5
-----END PGP SIGNATURE-----

--nthuz3olvzwitejh--
