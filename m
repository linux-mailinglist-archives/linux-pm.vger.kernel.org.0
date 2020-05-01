Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C21C1265
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgEAMrh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 08:47:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60110 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgEAMrh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 08:47:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3F44C2A2F7E
Received: by earth.universe (Postfix, from userid 1000)
        id 7F9853C08C7; Fri,  1 May 2020 14:47:32 +0200 (CEST)
Date:   Fri, 1 May 2020 14:47:32 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 07/11] power: supply: core: tabularize HWMON
 temperature labels
Message-ID: <20200501124732.vxnybog3k7smj7ms@earth.universe>
References: <29b5043db9a51ef7a0cb6e3a8c69c91e36045cd6.1585944770.git.mirq-linux@rere.qmqm.pl>
 <202004050928.d6QhVcsQ%lkp@intel.com>
 <CAKwvOdm5BhMdAmXR0gCLntkbvF7ajaNoWoHVCCio1CqbGzS6aQ@mail.gmail.com>
 <20200420092209.GA25831@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lfptqy4oqfimsjpk"
Content-Disposition: inline
In-Reply-To: <20200420092209.GA25831@qmqm.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lfptqy4oqfimsjpk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 20, 2020 at 11:22:09AM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Tue, Apr 07, 2020 at 11:13:50AM -0700, Nick Desaulniers wrote:
> > On Sat, Apr 4, 2020 at 6:53 PM kbuild test robot <lkp@intel.com> wrote:
> > >
> > > Hi "Micha=C5=82,
> > >
> > > I love your patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on power-supply/for-next]
> > > [also build test WARNING on hwmon/hwmon-next linus/master v5.6 next-2=
0200404]
> > > [if your patch is applied to the wrong git tree, please drop us a not=
e to help
> > > improve the system. BTW, we also suggest to use '--base' option to sp=
ecify the
> > > base tree in git format-patch, please see https://stackoverflow.com/a=
/37406982]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Micha-Miros-aw/exten=
sions-and-fixes/20200405-044024
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-pow=
er-supply.git for-next
> > > config: x86_64-randconfig-b002-20200405 (attached as .config)
> > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project =
62f3a9650a9f289a07a5f480764fb655178c2334)
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master=
/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         COMPILER=3Dclang make.cross ARCH=3Dx86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> drivers/power/supply/power_supply_hwmon.o: warning: objtool: power=
_supply_hwmon_read_string() falls through to next function power_supply_hwm=
on_write()
> >=20
> > I'm guessing this is from the unreachable:
> > https://github.com/0day-ci/linux/commit/b8b2d14ca46ca54257f55c9af58ea25=
695b9ee36
> > I'll need to play with this some more as I couldn't reproduce with a
> > simplified test case, but looks like a compiler bug.  Filed
> > https://github.com/ClangBuiltLinux/linux/issues/978 for me to track.
>=20
> Hi,
>=20
> For gcc this is bug 51513 [1]. This does not affect correctness of the
> code, so I wonder if we should/need be trying to work around it.
>=20
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D51513

Yes, we need to work around it for now. If I understand the situation
correctly, a simple workaround would be:

default:
    /*
     * unreachable, but not explicitly marked because this triggers
     * a compiler bug in gcc and llvm:
     *
     *  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D51513
     *  https://github.com/ClangBuiltLinux/linux/issues/978
     */
    break;

-- Sebastian

--lfptqy4oqfimsjpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sGmQACgkQ2O7X88g7
+po+4A//S4DmGtEEQ79XvYCy8U8UbFFvtBOBFd15P+U9nqljpvvZ2boRi7If1ovJ
Hfh9H52NhsLxTj8NeEQoCQN2d8JBe5Wyw4ISSHICDo/oRLyUQ7jTwUaO7KRkOSDt
Bg3Y3ZryvK2/c+r2fhlQuVYbg3ADAO7oufYMXHPjbe8A2D2dU3s7Q87dPRI0f5Nn
N3eSWuX5SRTiyMBzoOGK98fRj6Sr/hWDznu9XMHfaopYOBulDnQKUGa2EIg4ntS+
0aYZ0ZvSyV9iplTtvSIR0ML8bl1YqU+iiicHeZCw6lfQW4AX9Fbe2Hw0Hfi/ihs/
AuU9CpxhlDuBsyC7dqFwxvm81WjhWz3pfwql5s+jai1ia2CBIrvJJve+A6O4ISPD
ysn6V5gFWVwHBGUNWVOJLg1uAqV3TcujrTFBgWlruIFlcEwQeeJQSN01MCmuKKRV
9dfmrpDm3BK6TVhckd1ezxM/SjdytWQ21AS3B0b2BQVZRmFYbUBK4L1s2M2meAjU
L64HIEiRYh+t5kCXrnrqaiLt7tVRtolF1Q+wTGVOxjGFwEKAzU4g5ppi0zxfizHY
9iKRLgdAN3agOPaKBHxDbusacLu/Vk4qc2b6Zso46W3Xp1N2B7fTI2JMK5o283uK
Tcitnf5waNk6YFW+/SNkZwNlL7UDM8Jhisc6li06p9pDtXR/1HQ=
=fdYN
-----END PGP SIGNATURE-----

--lfptqy4oqfimsjpk--
