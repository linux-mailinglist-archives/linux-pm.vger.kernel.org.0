Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44ED19F1EA
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 10:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDFI6r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 04:58:47 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54118 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgDFI6q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 04:58:46 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4417F1C4519; Mon,  6 Apr 2020 10:58:44 +0200 (CEST)
Date:   Mon, 6 Apr 2020 10:58:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH][v2] PM / sleep: Add pm_debug_messages boot command
 control
Message-ID: <20200406085843.GE31120@duo.ucw.cz>
References: <20200329144640.20536-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <20200329144640.20536-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-03-29 22:46:40, Chen Yu wrote:
> Debug messages from the system suspend/hibernation infrastructure
> is disabled by default, and can only be enabled after the system
> has boot up via /sys/power/pm_debug_messages. This makes the hibernation
> resume hard to track as it involves system boot up across hibernation.
> There's no chance for software_resume() to track the resume process,
> eg.
>=20
> Turning on the pm_debug_messages during boot up by appending
> 'pm_debug_message'.
>=20
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: According to Randy's suggestion, add the command line
>     option to Documentation/admin-guide/kernel-parameters.txt
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  kernel/power/main.c                             | 7 +++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index c07815d230bc..105ec73743d7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3698,6 +3698,9 @@
>  			Override pmtimer IOPort with a hex value.
>  			e.g. pmtmr=3D0x508
> =20
> +	pm_debug_message	[SUSPEND,KNL]
> +			Enable suspend/resume debug messages during boot up.
> +
>  	pnp.debug=3D1	[PNP]
>  			Enable PNP debug messages (depends on the
>  			CONFIG_PNP_DEBUG_MESSAGES option).  Change at

See?

So this should be pm.debug=3D1 for consistency?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXorvQwAKCRAw5/Bqldv6
8ohfAJ0e7TkJIo8BhyMZ9/yLwGJSPzhM5gCfesbJk8F2XpXKz8Cwoa+84PO8aXY=
=n2/g
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
