Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACDF282E12
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 00:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgJDWQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Oct 2020 18:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbgJDWQs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Oct 2020 18:16:48 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5EA3205CB;
        Sun,  4 Oct 2020 22:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601849808;
        bh=NBtE/81jZQ0RhL5a24FlrAYkRmb7yL18m82kiAglvQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DfcNmrv3NW+V1zb3qDiCB+qk0ZoPRl6J8tjThoIABJK2c7DDyB8jNRzXo33CjJ7WD
         nmq4zqGLQev/dLV54ieD6Xr93uMBCtx2eHvwJBLotBz+0Y/bSGMhQYN4MpCTUwoPCk
         Ym0Dq8Yq0xvpYVpOg1PN1Wglv0M65+Aa+J+bEiSk=
Received: by earth.universe (Postfix, from userid 1000)
        id DE5003C0C87; Mon,  5 Oct 2020 00:16:45 +0200 (CEST)
Date:   Mon, 5 Oct 2020 00:16:45 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] test_power: add missing newlines when printing
 parameters by sysfs
Message-ID: <20201004221645.nyaf7jhur4jixo6n@earth.universe>
References: <1599199798-27804-1-git-send-email-wangxiongfeng2@huawei.com>
 <20201003212336.5et7erdf6fihqscu@earth.universe>
 <472008b94f4b20915425db4714fdb505cb0cbe5a.camel@perches.com>
 <20201003215029.jsugcgpgrmcmydr3@earth.universe>
 <9822843f764520e1076a92fd9120294aa393a085.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vr4whwmim25ljj7f"
Content-Disposition: inline
In-Reply-To: <9822843f764520e1076a92fd9120294aa393a085.camel@perches.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vr4whwmim25ljj7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 03, 2020 at 02:55:41PM -0700, Joe Perches wrote:
> On Sat, 2020-10-03 at 23:50 +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Sat, Oct 03, 2020 at 02:43:09PM -0700, Joe Perches wrote:
> > > On Sat, 2020-10-03 at 23:23 +0200, Sebastian Reichel wrote:
> > > > On Fri, Sep 04, 2020 at 02:09:58PM +0800, Xiongfeng Wang wrote:
> > > > > When I cat some module parameters by sysfs, it displays as follow=
s.
> > > > > It's better to add a newline for easy reading.
> > > []
> > > > > root@syzkaller:~# cd /sys/module/test_power/parameters/
> > > > > root@syzkaller:/sys/module/test_power/parameters# cat ac_online
> > > > > onroot@syzkaller:/sys/module/test_power/parameters# cat battery_p=
resent
> > > > > trueroot@syzkaller:/sys/module/test_power/parameters# cat battery=
_health
> > > > > goodroot@syzkaller:/sys/module/test_power/parameters# cat battery=
_status
> > > > > dischargingroot@syzkaller:/sys/module/test_power/parameters# cat =
battery_technology
> > > > > LIONroot@syzkaller:/sys/module/test_power/parameters# cat usb_onl=
ine
> > > > > onroot@syzkaller:/sys/module/test_power/parameters#
> > > > >=20
> > > > > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > > > > ---
> > > >=20
> > > > Thanks, queued.
> > > []
> > > > > diff --git a/drivers/power/supply/test_power.c b/drivers/power/su=
pply/test_power.c
> > > []
> > > > > @@ -353,6 +353,7 @@ static int param_set_ac_online(const char *ke=
y, const struct kernel_param *kp)
> > > > >  static int param_get_ac_online(char *buffer, const struct kernel=
_param *kp)
> > > > >  {
> > > > >  	strcpy(buffer, map_get_key(map_ac_online, ac_online, "unknown")=
);
> > > > > +	strcat(buffer, "\n");
> > > > >  	return strlen(buffer);
> > > > >  }
> > >=20
> > > All of these would be better as sprintf(buffer, "%s\n", <whatever>)
> > > so the output is scanned just once instead of scanned three times.
> >=20
> > Agreed. Anybody willing to send a patch? :)
>=20
> Well, you _are_ the maintainer. Why not you?

I prefer to have patches reviewed and when I sent out patches for
my own subsystem I often do not get any reviews at all. From my
experience people often like to increase their patch count anyways
(e.g. because their employer wanting to see high patch count), so
asking others to write the patch is an easy workaround for me. I
then only do the leftovers.

-- Sebastian

--vr4whwmim25ljj7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl96SccACgkQ2O7X88g7
+prN/hAAhvjucLG5mdmznzb+0h8DEKNMLC1kj95NZTvydXpmKbgWVbZbEe8vlKaG
cd783d+/CZxnrOWUQ0G+vuAHDzfySno/rkJX3hIcCQUM4lTPG7gMwnjEEtGPB8FO
oFWuMTDnKklpjgELckUg8hkZdA28HUr/QxMSBYI5sR+yJwqjGGV2ISE8LWJ+iTO+
5gCgdeSLG1+jIqFE2CMFXNo5Hy263Zj5+pz+JoNgj06NzRlH72t52VNZzMvOA+Ku
t+rHG+us35JlCbeYjJjeUOaSv3UwBS5/0LmfvXhcU+MDPMZQgFh5GDp1yfSSNF7M
VSu9gGHNrxm1zzsjQXYy/5l4oeuJuMHhT8rIX5bOIcrOGtilSPMn3jAba+lMEDy3
r/7B5sC0PWOx6k/NjJlVo4Qo/JKj1i6I9QIBqR0oxuJZW6KZcRccMFaf+ujvzz8B
+vUxiM89fEM763dOc+aj5BpbcaT4FrFtiLYg11uV6VShmQKpcuwiUj+bbXhcckC0
7p5UfeMLADdkzH/7Q7fextnZ2yoF6THNYQ1Ci3Vn/SSVTpAuKIFuQoqSGoXrnTiX
vBi5+01TjXf8yNXjSjS8GcLZeaZcW6nnckZ2+YT2CNZzHq3xC70+0GIP7bBSRSso
oEgDs8AsJTMxiAqtooDl2EwHLhh+dF33RDbOT+PZ5eyzCh4uZzo=
=yD3h
-----END PGP SIGNATURE-----

--vr4whwmim25ljj7f--
