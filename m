Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7519F250
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDFJSQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 05:18:16 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55960 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDFJSQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 05:18:16 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 752A51C452C; Mon,  6 Apr 2020 11:18:14 +0200 (CEST)
Date:   Mon, 6 Apr 2020 11:18:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH][v3] PM / sleep: Add pm_debug_messages boot command
 control
Message-ID: <20200406091813.GG31120@duo.ucw.cz>
References: <20200402075652.13289-1-yu.c.chen@intel.com>
 <CAJZ5v0j2W5MYJnb4hiDn0OgR1xJZwm4TxVm9o-iw+epXPTp82g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j2W5MYJnb4hiDn0OgR1xJZwm4TxVm9o-iw+epXPTp82g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index ed73df5f1369..3fb9cbee8d28 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3720,6 +3720,9 @@
> >                         Override pmtimer IOPort with a hex value.
> >                         e.g. pmtmr=3D0x508
> >
> > +       pm_debug_messages       [SUSPEND,KNL]
> > +                       Enable suspend/resume debug messages during boo=
t up.
> > +
> >         pnp.debug=3D1     [PNP]
> >                         Enable PNP debug messages (depends on the
> >                         CONFIG_PNP_DEBUG_MESSAGES option).  Change at r=
un-time

> Applied (as 5.7-rc material) with modified subject and changelog,
  thanks!

Please don't.

We have pnp.debug, i8042.debug, acpi.debug_*, lsm.debug... It makes
sense to do pm.debug... we want to have some consistency.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXorz1QAKCRAw5/Bqldv6
8tirAKCUkyHPVgDiMckfb40fMCX03KTXZQCgiI3vObBYdWvXEnTyBLT4zT9uoOs=
=9YRC
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
