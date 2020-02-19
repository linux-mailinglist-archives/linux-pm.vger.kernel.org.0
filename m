Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB95C163855
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 01:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgBSAPi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 19:15:38 -0500
Received: from foss.arm.com ([217.140.110.172]:37410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgBSAPi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 19:15:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D41F41FB;
        Tue, 18 Feb 2020 16:15:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5775E3F68F;
        Tue, 18 Feb 2020 16:15:37 -0800 (PST)
Date:   Wed, 19 Feb 2020 00:15:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in
 __driver_deferred_probe_check_state to allow EPROBE_DEFER to be returned for
 longer
Message-ID: <20200219001535.GQ4232@sirena.org.uk>
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9+VnUxDxRuy97YQ+"
Content-Disposition: inline
In-Reply-To: <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--9+VnUxDxRuy97YQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 04:51:39PM -0600, Rob Herring wrote:
> On Tue, Feb 18, 2020 at 4:07 PM John Stultz <john.stultz@linaro.org> wrote:

> > Specifically, on db845c, this change (when combined with booting
> > using deferred_probe_timeout=30) allows us to set SDM_GPUCC_845,
> > QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and get a working
> > system, where as without it the display will fail to load.

> I would change the default for deferred_probe_timeout to 30 and then
> regulator code can rely on that. Curious, why 30 sec is fine now when
> you originally had 2 min? I'd just pick what you think is best. I
> doubt Mark had any extensive experiments to come up with 30sec.

Sort of - I've spent a bunch of time looking at the sorts of devices
where this is applicable for regulators and 30s is wildly excessive for
the use case.  I didn't specifically measure anything at the time I did
the change though, even longer should work just as well.

That feature in the regulator framework is targetted quite narrowly at
things we really don't want to glitch out during boot if we can avoid it
like the display, people tend to make efforts to ensure that they come
up quickly during boot anyway so we're not expecting to worry about the
full boot time for bigger systems.  The expectation is that most devices
will cope fine with having the power turned off for a period and if the
user can't see it happening then it doesn't *really* matter.

--9+VnUxDxRuy97YQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MficACgkQJNaLcl1U
h9ADvAf/dCuCTqkr7k83orjGQpiBBxwwP5TzaUQLzl6Er3k6ZrnIKgFxlzmtqGex
NJAACaOkDMq11a8aFmlVsDydWlwtXOrukfdBPbdXJTTlnM5+LWXr7vAhe7lUcFVe
CI5lPe1UDp9jqRKB+RuaPIdzZ1kn4La1Npd6SWcxLiEDSAOEy+afBUnqTwk1gemG
2A43mqQ6c5bl4boQ+cwuFzyNHH5IUd9vIZiTCK6doCw3oVidm6JPMH6ol4vlJEaN
p6XVYnVEPtU0iqhgpcMLCC0jIUbZg6Xx4gGsi1U1EaUcMZMFqBeiDZuUJ3pFaqws
2OiahHbeeqJ9k56s9c40M0xQAHgqKw==
=npzu
-----END PGP SIGNATURE-----

--9+VnUxDxRuy97YQ+--
