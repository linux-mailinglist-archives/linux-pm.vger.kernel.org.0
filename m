Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B5618AB17
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 04:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCSDUP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 23:20:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41651 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSDUP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Mar 2020 23:20:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48jXGK5lGkz9sPF;
        Thu, 19 Mar 2020 14:20:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584588011;
        bh=Ai9OhofFDo+Kuv8/Q1oIJL9PA57GRqNhOuVclO2kkAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s+c8gZbnoR5P6CdeA8jyGK9OfV1C3G7SUDQ7Nas7JVbCu+DqEBYmrEDotfFuTR5H/
         J4ND90uHfyIyRgUygj2rR9q/zPgXuk7hg9JY/wPf2s7QQWtQpOvu7t9CohWybgd/T7
         AIEX+YN3astnwwL4hmok5SGbKEHdx/BQ6I5KbNxst7Uai3hVNM9vaeVBvtx3DLNBm7
         iTisZ82te70xQFnole+4mgCg48iJXRU/CcEVODRUDx8+6UQvW90kAZ0uDhyEURIra8
         06cWKyldIT1cccLPRjZT1zk5tPGasgfNYYO00YWNutYavRkU1CY5Yu5aFrFvdcX786
         d+tMcdQAZcGTw==
Date:   Thu, 19 Mar 2020 14:20:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: linux-next: Tree for Mar 18 (drivers/base/power/sysfs.c)
Message-ID: <20200319142002.7382ed70@canb.auug.org.au>
In-Reply-To: <1c7d78ba-55ae-6f8c-9a4f-13aca32f59de@infradead.org>
References: <20200318220920.48df2e76@canb.auug.org.au>
        <1c7d78ba-55ae-6f8c-9a4f-13aca32f59de@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OzymEXv09uqzpaSswDv9a8x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/OzymEXv09uqzpaSswDv9a8x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Wed, 18 Mar 2020 09:14:29 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on i386:
>=20
> ../drivers/base/power/sysfs.c: In function =E2=80=98dpm_sysfs_change_owne=
r=E2=80=99:
> ../drivers/base/power/sysfs.c:708:44: error: passing argument 2 of =E2=80=
=98sysfs_group_change_owner=E2=80=99 from incompatible pointer type [-Werro=
r=3Dincompatible-pointer-types]
>   rc =3D sysfs_group_change_owner(&dev->kobj, &pm_attr_group, kuid, kgid);
>                                             ^
> In file included from ../include/linux/kobject.h:20:0,
>                  from ../include/linux/device.h:17,
>                  from ../drivers/base/power/sysfs.c:3:
> ../include/linux/sysfs.h:576:19: note: expected =E2=80=98const struct att=
ribute_group **=E2=80=99 but argument is of type =E2=80=98const struct attr=
ibute_group *=E2=80=99
>  static inline int sysfs_group_change_owner(struct kobject *kobj,
>                    ^~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/base/power/sysfs.c:714:16: error: passing argument 2 of =E2=80=
=98sysfs_group_change_owner=E2=80=99 from incompatible pointer type [-Werro=
r=3Dincompatible-pointer-types]
>     &dev->kobj, &pm_runtime_attr_group, kuid, kgid);
>                 ^
> In file included from ../include/linux/kobject.h:20:0,
>                  from ../include/linux/device.h:17,
>                  from ../drivers/base/power/sysfs.c:3:
> ../include/linux/sysfs.h:576:19: note: expected =E2=80=98const struct att=
ribute_group **=E2=80=99 but argument is of type =E2=80=98const struct attr=
ibute_group *=E2=80=99
>  static inline int sysfs_group_change_owner(struct kobject *kobj,
>                    ^~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/base/power/sysfs.c:720:45: error: passing argument 2 of =E2=80=
=98sysfs_group_change_owner=E2=80=99 from incompatible pointer type [-Werro=
r=3Dincompatible-pointer-types]
>    rc =3D sysfs_group_change_owner(&dev->kobj, &pm_wakeup_attr_group,
>                                              ^
> In file included from ../include/linux/kobject.h:20:0,
>                  from ../include/linux/device.h:17,
>                  from ../drivers/base/power/sysfs.c:3:
> ../include/linux/sysfs.h:576:19: note: expected =E2=80=98const struct att=
ribute_group **=E2=80=99 but argument is of type =E2=80=98const struct attr=
ibute_group *=E2=80=99
>  static inline int sysfs_group_change_owner(struct kobject *kobj,
>                    ^~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/base/power/sysfs.c:732:16: error: passing argument 2 of =E2=80=
=98sysfs_group_change_owner=E2=80=99 from incompatible pointer type [-Werro=
r=3Dincompatible-pointer-types]
>     &dev->kobj, &pm_qos_latency_tolerance_attr_group, kuid,
>                 ^
> In file included from ../include/linux/kobject.h:20:0,
>                  from ../include/linux/device.h:17,
>                  from ../drivers/base/power/sysfs.c:3:
> ../include/linux/sysfs.h:576:19: note: expected =E2=80=98const struct att=
ribute_group **=E2=80=99 but argument is of type =E2=80=98const struct attr=
ibute_group *=E2=80=99
>  static inline int sysfs_group_change_owner(struct kobject *kobj,
>                    ^~~~~~~~~~~~~~~~~~~~~~~~

Caused by commitCONFIG_SYSFS

  303a42769c4c ("sysfs: add sysfs_group{s}_change_owner()")

from the net-next tree.

The CONFIG_SYSFS declaration of sysfs_group_change_owner() is different
from the !CONFIG_SYSFS version.

--=20
Cheers,
Stephen Rothwell

--Sig_/OzymEXv09uqzpaSswDv9a8x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5y5OIACgkQAVBC80lX
0GxRxwf/bZRlfZbDsOLE5GMYUz6Wd9HdJhOP8f3ZeuKS/Q3m+rYVHI6bc83jwgA2
8oqocs60tkJ1XwIrDQ7ue77QnTJZGYxL/8kiPavtszwZYB+SrmVhH5bHKmkKssks
aSmz4NpNNo00yhU9TE7pXs4VdXN0ejc59lkDgD0gGS6YBUHAjgQJBkODUak1mjV1
VboVQb/HPIp1LCx2+r0vriZOUqxtxBTcxMZeIeFIWzQNsx4wSh6SX+hoITNcbwIz
855QOgv6ebOYNlSTFxHNrGPziHz/W9xDltsicKy3PcEBizn7uHkJgBNN/Yd8QZWt
KOa02FeHTmuBvecjJ7rzpnF0afaxNQ==
=Xfd+
-----END PGP SIGNATURE-----

--Sig_/OzymEXv09uqzpaSswDv9a8x--
