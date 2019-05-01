Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C8A10E8A
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 23:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEAV0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 17:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfEAV0N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 May 2019 17:26:13 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B933020656;
        Wed,  1 May 2019 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556745972;
        bh=zlVypDJix2aPc5aPr2Bir4wsza86pu7M8teneGSTxEo=;
        h=Date:From:To:Cc:Subject:From;
        b=e/Z5TRqxwl2YcmO937o4pfMbaEoS/rp175noLuRCjFXAXPKmQwGBpwY0nMwmYERnf
         XDGxkSOeSALwjEjJiJbZMtfkGQEV/vdCaTsSe+yGVFlAIKUukFMALieMLzUcoxYles
         mjSoFxfT2q4mhzcXxQtKIorR/qwMN1De9KxcwS/I=
Received: by earth.universe (Postfix, from userid 1000)
        id 69A383C0D1B; Wed,  1 May 2019 23:26:10 +0200 (CEST)
Date:   Wed, 1 May 2019 23:26:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.1
Message-ID: <20190501212610.5qrl7gyttdyzs2dq@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37hn66nvtdvo22am"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--37hn66nvtdvo22am
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I have two more fixes for the 5.1 cycle. One division by zero fix
in a specific driver and one core workaround for bad userspace
behaviour from systemd regarding uevents. IMHO this can be considered
to be a userspace bug, but the debug messages are useless anyways.

-- Sebastian

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.1-rc

for you to fetch changes up to 349ced9984ff540ce74ca8a0b2e9b03dc434b9dd:

  power: supply: sysfs: prevent endless uevent loop with CONFIG_POWER_SUPPLY_DEBUG (2019-04-26 00:06:56 +0200)

----------------------------------------------------------------
Power Supply Fixes for 5.1 cycle

* cpcap-battery: fix a division by zero
* core: fix systemd issue due to log messages produced by uevent

----------------------------------------------------------------
Andrey Smirnov (1):
      power: supply: sysfs: prevent endless uevent loop with CONFIG_POWER_SUPPLY_DEBUG

Tony Lindgren (1):
      power: supply: cpcap-battery: Fix division by zero

 drivers/power/supply/cpcap-battery.c      | 3 +++
 drivers/power/supply/power_supply_sysfs.c | 6 ------
 2 files changed, 3 insertions(+), 6 deletions(-)

--37hn66nvtdvo22am
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzKDvIACgkQ2O7X88g7
+ppArQ/+PT2tpBOjdBDsXD0AfKO80q8kHVFNFkMe/ZU5KPOktT2kYzGboQA9k3aN
AkxkL15Lb+dEDrTeKWUz9rIXAzxyWmlo9O3jfYO7LS1kz4EVl4I2PuUeJo3ji+cP
2DywEl4UvT78bZEYDHw96A2SHZOOIaqDUQXTJNawLxvwOdpIvsba8EVcxmEB8Elh
LYjlfQudZ6QH47+hGg8QbiAPCC3+RP+jtyfvHER1QdUqSplRzJ8pZfIuPQPyP06E
oo78XkNAybPDEHy1RmqcLNX5tzTOQ6EnYzkOnF9CfC1CIrdSEKSv2rBZA+aLDGkh
PdMgJUG8NU5J5mLrqfN4s118+gQUbWvRWhnCCTzZUPzG2HpF2iCIhNJzPF5RdUbD
PwhmcERAqZ+t8uGY/fXkCuly4EKydUiItR4kl601yD6C6NCDXF7w7YnzsDmlSk/t
b4umcC9BvKFvlMp/iRYN362bqS4OEWDunuQnhkxErTYEYVbm208e7Tu+UziY/ISx
mJ2eDol3ogMekOdZqEq9uUJegdnKx6lxvzG/eDF/32ud+Ib+4PI+faxutNalQbNd
S7uxHAqPyyTejD3GZfPRxGzGYyyttOxE69IQ1n5s+wZmgt70sbYkG/u5mxPMQo6J
gppkBT/RmJwHxOQfkcXlbxPbRwOgG9NNnrD1K397aV/KbiinuW0=
=1AuR
-----END PGP SIGNATURE-----

--37hn66nvtdvo22am--
