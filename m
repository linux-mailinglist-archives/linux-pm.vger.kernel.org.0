Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27A2A5E5D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 02:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfICAE6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 20:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfICAE6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 20:04:58 -0400
Received: from earth.universe (dyndsl-091-096-044-124.ewe-ip-backbone.de [91.96.44.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE9F21881;
        Tue,  3 Sep 2019 00:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567469097;
        bh=C2Oo2ekkJf07UhZBjYcgHSOlX2ttr9aZ7KHtFcD/uVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pqgu9s97I5kIBQCgfJOcjjiwIvlIAMdsQ6MttlVE7h5NayMbcKz8kzhxfO14I/W0e
         uNclzdygVNWAo96lxNW6jLxOFs9xu8+YcCuAfZFVSEOMjUQvreWEj2hEOYKjgsk0gn
         1+sO9sTJvJyfBKgHu7ISaJIGc5yH4t6OezqHBoQE=
Received: by earth.universe (Postfix, from userid 1000)
        id E087E3C0CFA; Tue,  3 Sep 2019 02:04:54 +0200 (CEST)
Date:   Tue, 3 Sep 2019 02:04:54 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nandor Han <nandor.han@vaisala.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] power: reset: make reboot-mode user selectable
Message-ID: <20190903000454.lul7fn5nxqcvi5x5@earth.universe>
References: <20190805075812.1056069-1-arnd@arndb.de>
 <20190902203857.zusvlv3yv5arel6y@earth.universe>
 <CAK8P3a3uNPepYweCN9+_cQNQyiSGdidwNGL0+xhti2vm8g9O_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jk6o2ixaejebpkmd"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3uNPepYweCN9+_cQNQyiSGdidwNGL0+xhti2vm8g9O_g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jk6o2ixaejebpkmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 02, 2019 at 11:16:27PM +0200, Arnd Bergmann wrote:
> On Mon, Sep 2, 2019 at 10:39 PM Sebastian Reichel <sre@kernel.org> wrote:
> > This patch does not look good to me. Better patch would be to
> > allow compiling CONFIG_REBOOT_MODE without CONFIG_OF. Obviously
> > the configuration would not be useful for anything except compile
> > testing, but that is also true for this patch.
>=20
> Ok, I'd suggest we leave it with the bugfix you already applied then.
> [caa2b55784, power: reset: nvmem-reboot-mode: add CONFIG_OF dependency]

That's also fine with me.

-- Sebastian

--jk6o2ixaejebpkmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1triEACgkQ2O7X88g7
+prOIw//St+HxBGAjsiXQniqUuYYbeK3Snbkmksh6ma9RNd6of3UOCaeF0jMr0sQ
SjIgMlGJUgmOoa28eSoI+v2hRxugs1Wz5by/YCIAZxXysseA/xB8iDuScnjR2/FV
BC9xhdAUQorvqeSHfBjrYQVSVjBqAg2lxbYFLLIbJFMvFTOf4656fQr6YaORvvC7
lF4W9sedS1nqv5fStCQmFWoiodzKcie6QVvJtDuqueg7g/St1d0dDDiJO8fbgp1/
w1sK3QEhrzGBfTp9GzmO7F98RUXxsCpxv5K+nQBuWx1pbLJIabJ9PP113Zuz2HQY
/m/n4bwXeO47PaQ85/iC1qpn/L6XIReQC1TSA/pYureaazxf0zKwm0zOD5X9qHQJ
0e5BxzWKsg5DgRg573oFoCzQtE1mgTm1Bv3ehmIYkW25I2pFhph+z5EI6tyFPIW1
WxtgZY19dKK3YQQ7MF1ZxMUazuChHWqzGfLyrjhcglD8uQlx39fLu5N+DQceNhJm
z9hv44m2kdcqUctjT91qi1CdZJDJhu3fJHy/QYk/KB9RdP6rhQUCmirmLMn1jjjO
T6IhRTvtjKVtABjVa4ps97rY+hAIOffepm3KtPHa+6qPI7Wf8AY/JTCHE2+Tc1q4
C2IFoOxpAd5HjBC+ZJqjkW+r/2xq+1bY4Z0WhT8BCvTYvJqWeOI=
=UaPm
-----END PGP SIGNATURE-----

--jk6o2ixaejebpkmd--
