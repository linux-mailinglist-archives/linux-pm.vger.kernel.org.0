Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2239A1CB5B7
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEHRU2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 13:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgEHRU2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 13:20:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00160218AC;
        Fri,  8 May 2020 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588958427;
        bh=avvo2D7+fnzhDfjNEeCtFHIBbh21vAReCLZQrBEIXUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HsXhb2aBCFZ/aC/VKxnedL0ym7q4w56+RvbYMXOY9XJ1EYBvs4YZkJZnijkLq3c7L
         yIaIp2ADpbwsQYYfKGkkbGpkdFscXaD8KPBnWAm2ZPZsj9r6viZA5cnVtBsYrZDimM
         9kfUHNsJCjy6QSUBzZwhHzPHcvTd8IbYiG+wce5g=
Date:   Fri, 8 May 2020 18:20:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lgirdwood@gmail.com, sre@kernel.org,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/11] Support ROHM BD99954 charger IC
Message-ID: <20200508172024.GN4820@sirena.org.uk>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6o78gXsyQHm68LY/"
Content-Disposition: inline
In-Reply-To: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6o78gXsyQHm68LY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 06:38:17PM +0300, Matti Vaittinen wrote:
> Please note that this series should be applied to two trees. Patches
> 1-4 (or 1-5 as suggested by Sebastian) should go to regulator tree.
> Perhaps Mark can provide an immutable branch to Sebastian? Rest of the
> patches can then go to power-supply tree.

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/linear-ranges-lib

for you to fetch changes up to 60ab7f4153b6af461c90d572c31104086b44639f:

  regulator: use linear_ranges helper (2020-05-08 18:18:13 +0100)

----------------------------------------------------------------
lib: Add linear ranges helper library and start using it

Series extracts a "linear ranges" helper out of the regulator
framework. Linear ranges helper is intended to help converting
real-world values to register values when conversion is linear. I
suspect this is useful also for power subsystem and possibly for clk.

----------------------------------------------------------------
Matti Vaittinen (4):
      lib: add linear ranges helpers
      lib/test_linear_ranges: add a test for the 'linear_ranges'
      power: supply: bd70528: rename linear_range to avoid collision
      regulator: use linear_ranges helper

 drivers/power/supply/bd70528-charger.c  |  10 +-
 drivers/regulator/88pg86x.c             |   4 +-
 drivers/regulator/88pm800-regulator.c   |   4 +-
 drivers/regulator/Kconfig               |   1 +
 drivers/regulator/act8865-regulator.c   |   4 +-
 drivers/regulator/act8945a-regulator.c  |   2 +-
 drivers/regulator/arizona-ldo1.c        |   2 +-
 drivers/regulator/arizona-micsupp.c     |   4 +-
 drivers/regulator/as3711-regulator.c    |   6 +-
 drivers/regulator/as3722-regulator.c    |   4 +-
 drivers/regulator/axp20x-regulator.c    |  16 +--
 drivers/regulator/bcm590xx-regulator.c  |   8 +-
 drivers/regulator/bd70528-regulator.c   |   8 +-
 drivers/regulator/bd71828-regulator.c   |  10 +-
 drivers/regulator/bd718x7-regulator.c   |  26 ++--
 drivers/regulator/da903x.c              |   2 +-
 drivers/regulator/helpers.c             | 130 ++++++++---------
 drivers/regulator/hi6421-regulator.c    |   4 +-
 drivers/regulator/lochnagar-regulator.c |   4 +-
 drivers/regulator/lp873x-regulator.c    |   4 +-
 drivers/regulator/lp87565-regulator.c   |   2 +-
 drivers/regulator/lp8788-buck.c         |   2 +-
 drivers/regulator/max77650-regulator.c  |   2 +-
 drivers/regulator/mcp16502.c            |   4 +-
 drivers/regulator/mp8859.c              |   2 +-
 drivers/regulator/mt6323-regulator.c    |   6 +-
 drivers/regulator/mt6358-regulator.c    |   8 +-
 drivers/regulator/mt6380-regulator.c    |   6 +-
 drivers/regulator/mt6397-regulator.c    |   6 +-
 drivers/regulator/palmas-regulator.c    |   4 +-
 drivers/regulator/qcom-rpmh-regulator.c |   2 +-
 drivers/regulator/qcom_rpm-regulator.c  |  14 +-
 drivers/regulator/qcom_smd-regulator.c  |  78 +++++------
 drivers/regulator/rk808-regulator.c     |  10 +-
 drivers/regulator/s2mps11.c             |  14 +-
 drivers/regulator/sky81452-regulator.c  |   2 +-
 drivers/regulator/stpmic1_regulator.c   |  18 +--
 drivers/regulator/tps65086-regulator.c  |  10 +-
 drivers/regulator/tps65217-regulator.c  |   4 +-
 drivers/regulator/tps65218-regulator.c  |   6 +-
 drivers/regulator/tps65912-regulator.c  |   4 +-
 drivers/regulator/twl-regulator.c       |   4 +-
 drivers/regulator/twl6030-regulator.c   |   2 +-
 drivers/regulator/wm831x-dcdc.c         |   2 +-
 drivers/regulator/wm831x-ldo.c          |   4 +-
 drivers/regulator/wm8350-regulator.c    |   2 +-
 drivers/regulator/wm8400-regulator.c    |   2 +-
 include/linux/linear_range.h            |  48 +++++++
 include/linux/regulator/driver.h        |  27 +---
 lib/Kconfig                             |   3 +
 lib/Kconfig.debug                       |  12 ++
 lib/Makefile                            |   2 +
 lib/linear_ranges.c                     | 241 ++++++++++++++++++++++++++++++++
 lib/test_linear_ranges.c                | 228 ++++++++++++++++++++++++++++++
 54 files changed, 768 insertions(+), 266 deletions(-)
 create mode 100644 include/linux/linear_range.h
 create mode 100644 lib/linear_ranges.c
 create mode 100644 lib/test_linear_ranges.c

--6o78gXsyQHm68LY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61lNgACgkQJNaLcl1U
h9Cg+Af9GYU8vLIXNEIgi10KBZaimF8/PfT9BHGYO+SiKhL8KxTsHBMKEANxDois
M9cjt5K/HneS+UK/Ki1MPCq2+LPop+5sQq0zrh6iCyzM5C1bNpLA9Pdb5WNyEB2P
ctfJcXwNQEdhmYgBM0mw7+Vr9TVoUqc63mpU/0LDZr3vOKXYkoR3I6zrFjgZ3QTY
Xuo0Pl1gpPbmPOQsXpzHcxGbvX6Pse29wL9WfVJ3nJuzdXkPsuUIeXoHuqTQ5v/y
/S0pHliaENCTheW1wDg4JPdCp/G0Ca19xxZXJs6pn9yUUWRIDeibnT4k60N+fnhT
yPg0RIckqQr5pWcnbaxtOwO2xwFfjg==
=ETMU
-----END PGP SIGNATURE-----

--6o78gXsyQHm68LY/--
