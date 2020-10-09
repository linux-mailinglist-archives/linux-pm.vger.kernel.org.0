Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8997D289054
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 19:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbgJIRzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 13:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731500AbgJIRzI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 13:55:08 -0400
Received: from earth.universe (dyndsl-095-033-159-239.ewe-ip-backbone.de [95.33.159.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCFB02076E;
        Fri,  9 Oct 2020 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602266108;
        bh=x+240dzo4kr4FtQ+8Fvkjcz5mmSbCv1YBLqvzbruF2I=;
        h=Date:From:To:Cc:Subject:From;
        b=PmbSKTFwmpdfBLOlUf+c4xUiMpbdvxhHL/Rs4E4LJj4H5ke765OI7XA2ij/GM4+yp
         Rq2nxg8X9g805z/qV3JRtvu6wBgK49eFnvEKbTf6y2suYvTOT88fqUpk5SUeiVLsSI
         hYi8PfYUbAmVf74x/5Zw3OqM4V0T9sCTC7nZ0Yv8=
Received: by earth.universe (Postfix, from userid 1000)
        id A7DD43C0C87; Fri,  9 Oct 2020 19:55:05 +0200 (CEST)
Date:   Fri, 9 Oct 2020 19:55:05 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.9-rc
Message-ID: <20201009175505.2wbc5tzsr4q2bx3t@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zytlecii5o6ut2vj"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zytlecii5o6ut2vj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.9-rc

for you to fetch changes up to e3f2396b7570751a7ddba996812fb608134fd63c:

  power: supply: sbs-battery: chromebook workaround for PEC (2020-10-09 01:09:37 +0200)

----------------------------------------------------------------
Power Supply Fixes for 5.9 cycle

Just a single change to revert enablement of packet error checking
for battery data on Chromebooks, since some of their embedded
controllers do not handle it correctly.

----------------------------------------------------------------
Sebastian Reichel (1):
      power: supply: sbs-battery: chromebook workaround for PEC

 drivers/power/supply/sbs-battery.c | 6 ++++++
 1 file changed, 6 insertions(+)

--zytlecii5o6ut2vj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl+Ao/QACgkQ2O7X88g7
+poFqg//WbH87fAGszMIyZ91i12j5lDDTfSz34tRBX2eyHh1euRAaB3W2DNbq1KA
0+x0YIdxmbC9SpY8PaLdiZCXORLxp35+Q2pV3uq9x/F/YHsJdpld89QIFrlr6upA
ghKRU9CRp6W6q3dpbXf1zILYL/FbZ2JJBgcAvzkgiS7QM5SlbMDXOUIwPc4eyl5D
Fn6pHEmhqYc0HbljO611tLAXaeHnDij4xwrTQunZmlvz0+3/dlgK5CKDoeEw7DuI
Y9t+xJsGcLNwg+qXVJ6rtFa0Lv0qOWmpjIaQU9MH/PnDGiBjzSVDPK6pZHrZkq4+
yAhkdKAjXAuQi6gKInihhW65RojxO24YUIXlJKDynsbm4IQmu1cSdXux59zTIa3B
lcsnjpfyQICsjMUCGK0J6z84F5fvIV5qLJa6zsKAik+doaDTR8zIdlg0urh67LCM
nsj4SPUnipQtficREZVHxSZn1UH5o5/b1vGc7NBwARhbt7DaW8+ZxHPy68e/EFUk
OeRjO2IakwekViS9vnqg1QA8GK+NlAtVoV7vflHGvMshlOTOjf8/nOxOZ71sglGG
lHfzJKByA/a4SjGIdujZIq3dLuvNDKO5JaYWLeJANE5QjaWBiEcWunq0V+4rd2rh
FF+11jMUrOC1wlddo7O0F4HV/JGmPJgyIrfjNgSUQmyGUUOElsQ=
=FKx6
-----END PGP SIGNATURE-----

--zytlecii5o6ut2vj--
