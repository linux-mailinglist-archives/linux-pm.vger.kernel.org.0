Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68856DDE9C
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2019 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfJTNYC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 09:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfJTNYC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 09:24:02 -0400
Received: from earth.universe (tmo-104-243.customers.d1-online.com [80.187.104.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6989218BA;
        Sun, 20 Oct 2019 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571577841;
        bh=JUeyhbY4XLPzl8wkAxz5gj6htNnsDXVN8k8a2GTjy1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5296DppeCP7gcRjsD5Ko3IbgyouQOgb9XoB8emX153V/EMvyLDkFDoGUYxh7LwB8
         xTqZ2yCcAfeo4GfEPMurOZ80hpOZmt7vt7trMvqd0gKqtcBE79LmUEWuvzjzpFh1fw
         T1Tfo8h9cnf4okIUkT8g8bsIzDeENCn6jxLgH49A=
Received: by earth.universe (Postfix, from userid 1000)
        id ADA5B3C09B1; Sun, 20 Oct 2019 15:23:52 +0200 (CEST)
Date:   Sun, 20 Oct 2019 15:23:52 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFT 1/3] power: supply: ab8500: Cleanup probe in reverse order
Message-ID: <20191020132352.seo2seahsq2k32mb@earth.universe>
References: <20191004150738.6542-1-krzk@kernel.org>
 <CACRpkdYSnnOJomJi=Db2nkrrdNQmBnNKny1c7ZpDj6KdmKD9Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bpnqgwqyh5qys2js"
Content-Disposition: inline
In-Reply-To: <CACRpkdYSnnOJomJi=Db2nkrrdNQmBnNKny1c7ZpDj6KdmKD9Mg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bpnqgwqyh5qys2js
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 16, 2019 at 10:33:12AM +0200, Linus Walleij wrote:
> On Fri, Oct 4, 2019 at 5:07 PM Krzysztof Kozlowski <krzk@kernel.org> wrot=
e:
>=20
> > It is logical to cleanup in probe's error path in reverse order to
> > previous actions.  It also makes easier to add additional goto labels
> > within this error path.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> For all 3 patches:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> The battery charging code is currently disabled on ux500 simply
> because no platforms with batteries were available for testing
> or supported by any device trees.
>=20
> This is getting fix: PostmarketOS is brewing patches for enabling
> all Ux500-based Samsung phones, all with batteries. So we will
> soon be able to test and turn this on.
>=20
> The patches are fine to merge, however notice that we are
> refactoring all drivers using ADC through the IIO tree:
> https://lore.kernel.org/linux-iio/20191011071805.5554-4-linus.walleij@lin=
aro.org/
> https://lore.kernel.org/linux-iio/20191011071805.5554-2-linus.walleij@lin=
aro.org/
> https://lore.kernel.org/linux-iio/20191011071805.5554-3-linus.walleij@lin=
aro.org/
>=20
> It would be nice if we could avoid colissions.

Thanks, I merged your immutable branch for the ADC work
and this patchset.

-- Sebastian

--bpnqgwqyh5qys2js
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sX+UACgkQ2O7X88g7
+poy/w/8DMZnLieBPLWUCwhIO5fbuByhIgR2X4Aa8sgjZMXRD5ZyreiZNY5HopAV
5NhV18pa8YcqWLaZO5uar+snOyI959yctBrTSU0ddwt+WAflTxR/sS3d49pNwZDY
OPz6j85seXjYVqlwSjv+FlN3oBBOoAt2dC0F688OZKyoRQ2+rGoVMasNcG3hIeLm
XtJ1Snmb05Jbky8j2YD9WJ/6txAMdoy1xYRpLQxM2J6W6ekZ+DBfFkQc2MPYnuBm
hNKQHvm3wiZ/wXr33UumZc/qJ0ZJx6qzASF9zeiyThn7lGbXMRCyTY1Gow+ECo39
ZxboDpTt7bGbhcDDjl1mAFeDhC7ceZh1iimq6s5n4dgz8Kg3/uPGacMn+ilZnh8a
Ab021CnrZzpwDw2+hgfkJfc7GwgkmwfJ5WwvW37iu/0FITDAvIDZMbsAlRLv6c/d
amB+4VwuA8GXziINCde7f362Gvd0XDJzqSt7ZD3NMR4YNNeYaGd1NZYxd/ox3k6X
KFrF6Wyl8oQlSkGjBAgSCkh9zqjUv6AN8XtLFzd0G+YnyVqC7WzjPxco+ZA95Aft
kASFujCAFOBtyU4q1mwIcHhbcZUPHSD9WJ7uzrbH7lx8lrwbs87XV2iIPRCJN66s
CoCbsUz4ryxNbUcd9xQaAXp9e4wPVb/6rfhBNr+iYVVCjd4agAk=
=rfQl
-----END PGP SIGNATURE-----

--bpnqgwqyh5qys2js--
