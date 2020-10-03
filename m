Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3082826EA
	for <lists+linux-pm@lfdr.de>; Sat,  3 Oct 2020 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgJCVuc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Oct 2020 17:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgJCVuc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Oct 2020 17:50:32 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D39B206C3;
        Sat,  3 Oct 2020 21:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601761831;
        bh=fW/MShrvVaeOh1J4dzKJiFbCTCe6vgKzdHkQwIvKw2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfjKT85tbuHd2Hl+EPSekpf88rrzirRQQhZD3p/ij9MSuWuLVD5kQnxL46665rsg7
         jbHnmrwPa/cG7lUUni4m7evSKESzeV5dHfGB7LJFogvpeBsWmZSwYnEPLei1Vmf1mk
         UcERQUrl0QMTsTNfz/4Rbh1pVlo4j4Kwa/Xt2HkM=
Received: by earth.universe (Postfix, from userid 1000)
        id 572133C0C87; Sat,  3 Oct 2020 23:50:29 +0200 (CEST)
Date:   Sat, 3 Oct 2020 23:50:29 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] test_power: add missing newlines when printing
 parameters by sysfs
Message-ID: <20201003215029.jsugcgpgrmcmydr3@earth.universe>
References: <1599199798-27804-1-git-send-email-wangxiongfeng2@huawei.com>
 <20201003212336.5et7erdf6fihqscu@earth.universe>
 <472008b94f4b20915425db4714fdb505cb0cbe5a.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ly4wgne62jo6bhtn"
Content-Disposition: inline
In-Reply-To: <472008b94f4b20915425db4714fdb505cb0cbe5a.camel@perches.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ly4wgne62jo6bhtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 03, 2020 at 02:43:09PM -0700, Joe Perches wrote:
> On Sat, 2020-10-03 at 23:23 +0200, Sebastian Reichel wrote:
> > On Fri, Sep 04, 2020 at 02:09:58PM +0800, Xiongfeng Wang wrote:
> > > When I cat some module parameters by sysfs, it displays as follows.
> > > It's better to add a newline for easy reading.
> []
> > > root@syzkaller:~# cd /sys/module/test_power/parameters/
> > > root@syzkaller:/sys/module/test_power/parameters# cat ac_online
> > > onroot@syzkaller:/sys/module/test_power/parameters# cat battery_prese=
nt
> > > trueroot@syzkaller:/sys/module/test_power/parameters# cat battery_hea=
lth
> > > goodroot@syzkaller:/sys/module/test_power/parameters# cat battery_sta=
tus
> > > dischargingroot@syzkaller:/sys/module/test_power/parameters# cat batt=
ery_technology
> > > LIONroot@syzkaller:/sys/module/test_power/parameters# cat usb_online
> > > onroot@syzkaller:/sys/module/test_power/parameters#
> > >=20
> > > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > > ---
> >=20
> > Thanks, queued.
> []
> > > diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply=
/test_power.c
> []
> > > @@ -353,6 +353,7 @@ static int param_set_ac_online(const char *key, c=
onst struct kernel_param *kp)
> > >  static int param_get_ac_online(char *buffer, const struct kernel_par=
am *kp)
> > >  {
> > >  	strcpy(buffer, map_get_key(map_ac_online, ac_online, "unknown"));
> > > +	strcat(buffer, "\n");
> > >  	return strlen(buffer);
> > >  }
>=20
> All of these would be better as sprintf(buffer, "%s\n", <whatever>)
> so the output is scanned just once instead of scanned three times.

Agreed. Anybody willing to send a patch? :)

-- Sebastian

--ly4wgne62jo6bhtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl948iIACgkQ2O7X88g7
+pqfHg/+LTGXjiz4dukxRGm15eNueBi4JiM/H06xmc2bd5Lk9IH2dB6cLjrcpk5f
F123gNDhFIUPEnXzya64mqCUy2OmkUFijs6cXMOYgX7LPtIRBMjmiM7NRkOStpIg
mn+XFesG8AhfOeZ0EX1pefbVRwjxrp2yJcOeKTtDSu4JNmdM3xT+IRSmi/fELJys
ALoYqwtqr7jUKQAGCtnL9tv4sV4CqkqeayvKqnmB0amU6uXhQz0yawNsylhVAVW1
1q3fy6c6qNEUls0Ykbac0RbbC6nWud1XoxuJLxjek5JQt9Od2sLyBYV6L/Ahnge/
C6p2EWwMn81mUH5Xp50YhUxpGDwiAlREQgt18L9sbRr4qv7SUbuyiJHeNcjk1jps
1fdjJiOIbNOcewnxeZZhaPeSDP6v5ORsM9bznOCBeIApHXor1LOgfvm381iR4x5g
UqrlLtk9k4t/9UpEXfpTR2budlqlzVRRr0HNglC+vVnXxGVTykPEXAhVas08B3/p
0gyNpd43/NSEzfmtJ54VEVRRFTxyxCfABq94vBOuCSVpgRwA4D+yYv/NL37qlnSk
OTSP6iWKCiNEVHzA1HSZySt76NmvlLUiSJkrVvGTPlVQIk1+rw3MhpYHsoYJxDls
sAZWEbVMN3epd/zrw/mw+Gd4YuD2W6sbCtqw3s4H7zTKJLqOjm8=
=8CAB
-----END PGP SIGNATURE-----

--ly4wgne62jo6bhtn--
