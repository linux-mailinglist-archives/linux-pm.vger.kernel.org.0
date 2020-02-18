Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78A31637D9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 00:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgBRX5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 18:57:33 -0500
Received: from foss.arm.com ([217.140.110.172]:36778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgBRX5d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Feb 2020 18:57:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EBE51FB;
        Tue, 18 Feb 2020 15:57:33 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 859C93F68F;
        Tue, 18 Feb 2020 15:57:32 -0800 (PST)
Date:   Tue, 18 Feb 2020 23:57:30 +0000
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
Message-ID: <20200218235730.GP4232@sirena.org.uk>
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
 <CALAqxLUTNq-Dg5Nd4PozCUx3K0hnVEJYmNnkpnGWGhph8vNr8w@mail.gmail.com>
 <CAL_JsqJuG7ABaZSg=7mr0jHRruoAiWf6vJRD_Ev3DH6BrtpUtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0LFOk513GRb+T2w"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJuG7ABaZSg=7mr0jHRruoAiWf6vJRD_Ev3DH6BrtpUtg@mail.gmail.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--i0LFOk513GRb+T2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 05:53:01PM -0600, Rob Herring wrote:
> On Tue, Feb 18, 2020 at 5:21 PM John Stultz <john.stultz@linaro.org> wrote:

> > As long as 30 seconds is working well, I'm ok with it for now (and it
> > can be overrided via boot arg). Though from past experience with
> > enterprise distros running on servers with tons of disks (which might
> > take many minutes to initialize), I'd suspect its likely some
> > environments may need much longer.

> Those systems aren't going to have a pinctrl or clock driver sitting
> in an encrypted RAID partition either. :)

There speaks the voice of hope and optimism.

--i0LFOk513GRb+T2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MeeoACgkQJNaLcl1U
h9ArgQf/a8zDxowTF/h42OdpwaPpplBdGHYaRlpfh/gOLVkb7MvbofnrLavh44vW
RI9cevWEH07GYzA8vkQR1hlmZcV2Bshn1REsvRJag/rCU+6YTNv27DDWsOC+Ez4R
6V6AHVBoi2ZVshCa3jNmkRyBh6fIZ3dPpQGxEo1fMB25DcMS3QgLtdbHCN9toWWo
xi69jl5gOmFlbnGqlqHdxg/PH2aRJEgi35efezOAa9ZnD+PH4tooYFIx4hb091HC
YIRekUKis0SUZwUcSm4JPvSFsAJV5x4TTvseRSIsbT9QL+Fwx1HTpuI6kgTNEayp
xAw9TzdQod8XbRqXxn113v/10rUdsQ==
=Mfch
-----END PGP SIGNATURE-----

--i0LFOk513GRb+T2w--
