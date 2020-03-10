Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A2180A7B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 22:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgCJVay (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 17:30:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50788 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgCJVax (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 17:30:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 95993293E8E
Received: by earth.universe (Postfix, from userid 1000)
        id 6BF9A3C0C82; Tue, 10 Mar 2020 22:30:50 +0100 (CET)
Date:   Tue, 10 Mar 2020 22:30:50 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sandeep Patil <sspatil@android.com>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/4] power_supply: Add additional health properties to
 the header
Message-ID: <20200310213050.si7gcr2wbmjgr7jf@earth.universe>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-3-dmurphy@ti.com>
 <20200117010658.iqs2zpwl6bsomkuo@earth.universe>
 <20200306235548.GA187098@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="35joe23zra66xihb"
Content-Disposition: inline
In-Reply-To: <20200306235548.GA187098@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--35joe23zra66xihb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sandeep,

On Fri, Mar 06, 2020 at 03:55:48PM -0800, Sandeep Patil wrote:
> On Fri, Jan 17, 2020 at 02:06:58AM +0100, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Thu, Jan 16, 2020 at 11:50:37AM -0600, Dan Murphy wrote:
> > > Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
> > >=20
> > > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > > ---
> >=20
> > Looks good. But I will not merge it without a user and have comments
> > for the driver.
>=20
> Android has been looking for these properties for a while now [1].
> It was added[2] when we saw that the manufacturers were implementing these
> properties in the driver. I didn't know the properties were absent upstre=
am
> until yesterday. Somebody pointed out in our ongoing effort to make sure
> all core kernel changes that android depends on are present upstream.
>=20
> I think those values are also propagated in application facing APIs in
> Android (but I am not sure yet, let me know if that's something you want
> to find out).
>=20
> I wanted to chime in and present you a 'user' for this if that helps.

With user I meant an upstream kernel driver, which exposes the
values. But thanks for the pointer. This should be mentioned in
the patch description, also the fact that the status values are
directly taken from JEITA spec.

> Cc: kernel-team@android.com
>=20
> - ssp
>=20
> 1. https://android.googlesource.com/platform/system/core/+/refs/heads/mas=
ter/healthd/BatteryMonitor.cpp#162
> 2. https://android-review.googlesource.com/c/platform/system/core/+/414481

-- Sebastian

--35joe23zra66xihb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5oBwcACgkQ2O7X88g7
+pqdpw/+Lcc4W0PsvkYpEfn0QKMOTsIdEV/XS+BPufOCcHNwB+J8VhlmicgdEpf6
2zviAP4z/u6yz72Tb1zgQlJVplBlfmxYoWgWjUUYbscZ0YQNTFDanOyUHjyw9I5b
S6Sx9z1jAbWkQk5tb5novx/eXpwYq/AScfKDAuwIqN+Aid8OXRB6vHi56nVCEuWH
bQkt7CdHQCa6wodzcN5TEShhzXi3nMNHpAXHg1MRzyijzNEnH16G88vVtHfhflxw
4zzSrGWVyyZAzqK8ap1tXEIOhTFvev4hSm69fUDPB5fF1rc43pTY78jzRcFbx+Qe
0TBaJwP9pkaCxMEY4qJdNEIO8UnzL7Wcu76XrWEvcXJg/jFXzNo6p64lA+sfDoMl
UFxh1WsAFLF3rAO0d5vj5pHojIZ0IAmp82ruzJEFPqmlGslSZ8bmbgFz4+bqc3J9
45toClOMeAbp8QZvd8cVI+OriVGpjcOGaUtjbVSul9T2sWnqs7UuHgtyNI6oYRU3
zpEkwk80aZAgb9MSpicykzBH8zTXaSDIKN6nhcWlcceyBGiD2VTZ9DRpxcgyD27y
GMEo4kMf1W++TELOIhwJsB7MzHNc8e1nLcBK9TTy5YNDAqvMs/YWjVfYfy0VpfMh
bm4wW6p52ufDicRSq2AwUl65InaRKRY3XRIVzfVe4bg8PihKD8E=
=OK1D
-----END PGP SIGNATURE-----

--35joe23zra66xihb--
