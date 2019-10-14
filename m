Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46791D6B40
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 23:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbfJNV07 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 17:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbfJNV0t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 17:26:49 -0400
Received: from earth.universe (eth-west-pareq2-46-193-2-41.wb.wifirst.net [46.193.2.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF58A2067B;
        Mon, 14 Oct 2019 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571088409;
        bh=M9bcdnCeNrkpTQITeGXNjQpGnJuPalAz253L966tFWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdMEydFVZCAn+LklPnDJKHbFGfkUb0FfxiBrEh8vacnbAR5IZIx6zsO59ta3EIsl3
         Ygo+FLmrPmYIh8ZsbcccQK52a/JKEz6FRTA9WnmgkLVi3QD48Bo4CkcIvVDmzUH1J0
         lRj/ZZ4TTovgsY8XrLxOjCkY42+s67O83EphI3Go=
Received: by earth.universe (Postfix, from userid 1000)
        id C4D0F3C0CA4; Mon, 14 Oct 2019 06:24:28 +0200 (CEST)
Date:   Mon, 14 Oct 2019 06:24:28 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 2/2] power: supply: axp20x_usb_power: add
 applied max Vbus support for AXP813
Message-ID: <20191014042428.wslcadbv45k7v242@earth.universe>
References: <20191002112545.58481-1-icenowy@aosc.io>
 <20191002112545.58481-3-icenowy@aosc.io>
 <CAGb2v65MPG=zbKtQk1oXq+TYP=0fPBXEj0fcGA=6mCD2+Smmpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jnwzl62lfmns7tc6"
Content-Disposition: inline
In-Reply-To: <CAGb2v65MPG=zbKtQk1oXq+TYP=0fPBXEj0fcGA=6mCD2+Smmpg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jnwzl62lfmns7tc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 08, 2019 at 12:07:05AM +0800, Chen-Yu Tsai wrote:
> As far as the sysfs documents go, CURRENT_MAX is read-only, and should re=
fer to
> the hard limit the hardware can support, i.e. maximum power ratings.
> INPUT_CURRENT_LIMIT and INPUT_VOLTAGE_LIMIT are for configurable upper an=
d lower
> limits respectively.
>=20
> Sebastian, is my understanding of this correct?

Yes.

-- Sebastian

--jnwzl62lfmns7tc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2j+HwACgkQ2O7X88g7
+prfHA/+Jc00u/1cAYAPN6ewnUrc/bbD55/ftu4HZ0EXef5mU4CtB6P+f/gVJfwT
sRtrW/liEbo+tC238pyJE1VwradxeXErWIxnjv68NkjTyxjqZdN4EEeKW0qIrur+
QisFcrdSxbu17GCyBxOWztgxwksnahRkzrIFOZlbSqP9B8OayMKKdcB+heUoC1pP
qMm4SsYiVvEVwVzS95Z3rwDsQioyHzXhMD6RxCEeZEiKFovuiJ0YbS7WL+pA/ay1
6Pnv7V89C1T5sGG8oBzU+ow3e9Cp/uTMlhVSl20MMvE4vKTp47HP+5xMmZ/Nx5Ja
bc9th2ABWPalmpv03wXM3ERol7FNtFtG5CkMmqbbL3IJc9VklqPw3lqXF1x7RtYP
FEuXDdQeZwiFnwAfzJRge1gsOv6Dt0T0F7qvCtnGLHrcEusQ2hVDpqpbh5ySDUuN
zemYtNep3+6MQ9cSd9285XKtTO6SectY04SL6VeF0uYo/5t2oJC4YW3KgZOAMd4r
fR7YMJQwiKb1xzomvul37o4wSltTsCP+Zw0321d6USHvfLDPxs0zQD2aWogGJ/cs
wUycmIge9neDb2DPxWeKY9QLUClXyt/99PuzHjZ+y7Rv9ADGpbo3pz+PejpSjf0Z
+sz3g/pvL0vpmdwqTige7/TW/zTFZ6DjYcn+bZ1sBWiShVOZarI=
=RG51
-----END PGP SIGNATURE-----

--jnwzl62lfmns7tc6--
