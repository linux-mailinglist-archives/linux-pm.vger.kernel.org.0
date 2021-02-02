Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07E630BA9A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 10:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBBJK5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 04:10:57 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:49832 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhBBJFx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 04:05:53 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B645B1C0B76; Tue,  2 Feb 2021 10:04:52 +0100 (CET)
Date:   Tue, 2 Feb 2021 10:04:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Abel Wu <abel.w@icloud.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hewenliang4@huawei.com,
        wuyun.wu@huawei.com
Subject: Re: [PATCH] PM: hibernate: add sanity check on power_kobj
Message-ID: <20210202090451.GA27619@amd>
References: <20210201075041.1201-1-abel.w@icloud.com>
 <20210201105243.GA23135@duo.ucw.cz>
 <F87648CF-E5D6-41C7-9F4E-87A4BA2A4786@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <F87648CF-E5D6-41C7-9F4E-87A4BA2A4786@icloud.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2021-02-02 09:59:11, Abel Wu wrote:
>=20
>=20
> > On Feb 1, 2021, at 6:52 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >=20
> > On Mon 2021-02-01 02:50:41, Abel Wu wrote:
> >> The @power_kobj is initialized in pm_init() which is the same
> >> initcall level as pm_disk_init(). Although this dependency is
> >> guaranteed based on the current initcall serial execution model,
> >> it would still be better do a cost-less sanity check to avoid
> >> oops once the dependency is broken.
> >=20
> > I don't believe this is good idea. If the dependency is ever broken,
> > this will make failure more subtle and harder to debug.
>=20
> Thanks for reviewing. I think the cmdline parameter initcall_debug will
> help in this case.
> Actually we are trying to make initcalls being called asynchronously to
> reduce boot time which is crucial to our cloud-native business. And we
> resolve this kind of dependencies by retrying failed initcalls.

And this patch is okay if that gets mainlined, but not before.

Best regards,
							Pavel
						=09
--=20
http://www.livejournal.com/~pavelmachek

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAZFbMACgkQMOfwapXb+vKMsACfemy1Qj83ceejJNSRQ4aSJqaC
aO0An2VkofaLO9/WlKkHvZWeT5mGsj//
=nUX3
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
