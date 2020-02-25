Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA216C128
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgBYMnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 07:43:18 -0500
Received: from foss.arm.com ([217.140.110.172]:50270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgBYMnS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Feb 2020 07:43:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6234030E;
        Tue, 25 Feb 2020 04:43:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D96393F6CF;
        Tue, 25 Feb 2020 04:43:16 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:43:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 6/6] regulator: Use driver_deferred_probe_timeout for
 regulator_init_complete_work
Message-ID: <20200225124315.GB4633@sirena.org.uk>
References: <20200225050828.56458-1-john.stultz@linaro.org>
 <20200225050828.56458-7-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20200225050828.56458-7-john.stultz@linaro.org>
X-Cookie: Booths for two or more.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2020 at 05:08:28AM +0000, John Stultz wrote:
> The regulator_init_complete_work logic defers the cleanup for an
> arbitrary 30 seconds of time to allow modules loaded by userland
> to start.

Acked-by: Mark Brown <broonie@kernel.org>

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5VFmIACgkQJNaLcl1U
h9DzrQf/faqtOS9TdPP0gkC5NRJPMYTyyP/T4QP2bdax55Uhogt8rQ1GleRuUfp+
tkUWHP2MRfEzUkNR6wOMIDvmMIYijbn3an/laONAfMO5QRUHByFTF7tM4Vk8OuwL
3EG9MceIYNXRvYx8rlWmyFjZQoq7H9JAcNW+0LBGLJyqgkvWCevXX/LDOzXE2gP8
6wl8rHjqujyagDipgii40dM1287JWJKgBBGNSAqMQGkPCUIaaJkYYhPLWrf6PDy1
YUl2ZnWGod/PsL5FQCCQiFnVlfElWkYOhKw0bMaXUAJruPai5wG3icR4WfKfRrzj
ROwomfEBNpiaLPx9P4r2rRhZuhbmBQ==
=sUYb
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
