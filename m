Return-Path: <linux-pm+bounces-22593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B4A3EA4F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 02:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D6C16A7A7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA1714900B;
	Fri, 21 Feb 2025 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3LRNrCz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A56F30C;
	Fri, 21 Feb 2025 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102380; cv=none; b=JLsn4AqPxHAZ4G4MJNhCPRclN0B9oQfE2A53++IbXXzvpposuMyXY/iJDMAsH09AK29otMbmLK8xSGoi35P7bvSXQPMOjNu+YrTEiZJE6sS4hWNVnwanw4hgLjMN9PxrNLCvpf/J/UA9znP8CNMQ4OSlWOSICcr9G/9ymPrbCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102380; c=relaxed/simple;
	bh=SmSIZIJXWpW68Dr5SLrzf4Ysyfb0cb3CnwHI/xRaIXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cU6M8WzfTIhPIFdxwVWdZagQpvoIpwnj5SVtR/n4oAW22pjTNYIJXryu+Dit5EfKGS+3W5yeS+fA3abt8EHoniKYc9UxgiXqIltLQOJIpHla4ZS83rwTTNsJqHZOI0Or0zxiEJyC/fKglSYOgCS1muQrb7nBVLdLuStQqe9mWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3LRNrCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B90CC4CED1;
	Fri, 21 Feb 2025 01:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740102379;
	bh=SmSIZIJXWpW68Dr5SLrzf4Ysyfb0cb3CnwHI/xRaIXM=;
	h=Date:From:To:Cc:Subject:From;
	b=A3LRNrCzau8cWUJ+R6zSdOFi+Zzk5dMAQazeBvZy8vaIGz+KIrxjW/ADPDCu3Ga3E
	 3y/L+2Mf+3a4F0bBjhL6B+RZs3JN1DmHfgeOLB9OWenm+pq8yvJh6z0AgU+J4FYIrw
	 Z3O45WfjYHF8jT37Naai5sPMu0pDzaJ7KGWN8JWFyiP4D++9fzNLoAIjNcyXZY9Hr4
	 ImcWjpY0SZD7lxvJMlI3xybP5lmL8mAiLWCswZxj1/xhexhHcMjBZ8XcT8x+jwCV06
	 FheQz87mpMvamoxHNN0DslqQQxS7nLGsZ9NjLCWM1RSD42wXF2D9HHchQT4nkwRILk
	 Jsu3Xgiilt62Q==
Received: by venus (Postfix, from userid 1000)
	id 30B9C1835EA; Fri, 21 Feb 2025 02:46:17 +0100 (CET)
Date: Fri, 21 Feb 2025 02:46:17 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply fixes for 6.14
Message-ID: <73672ehjkrjavtqe3uw3vlpriqclihn3y2k2snrf3qc3ovah7y@jvt2c3vrlnro>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvyl2d5z3wzlh7bs"
Content-Disposition: inline


--cvyl2d5z3wzlh7bs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] power-supply fixes for 6.14
MIME-Version: 1.0

Hi Linus,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.14-rc

for you to fetch changes up to 98380110bd48fbfd6a798ee11fffff893d36062c:

  power: supply: axp20x_battery: Fix fault handling for AXP717 (2025-02-03 12:41:18 +0100)

----------------------------------------------------------------
Power Supply Fixes for 6.14 cycle

* core: Fix extension related lockdep warning for LED triggers
* axp20x-battery: Fix fault handling for AXP717
* da9150-fg: fix potential overflow

----------------------------------------------------------------
Andrey Vatoropin (1):
      power: supply: da9150-fg: fix potential overflow

Chris Morgan (1):
      power: supply: axp20x_battery: Fix fault handling for AXP717

Hans de Goede (1):
      power: supply: core: Fix extension related lockdep warning

 drivers/power/supply/axp20x_battery.c    | 31 +++++++++++++++----------------
 drivers/power/supply/da9150-fg.c         |  4 ++--
 drivers/power/supply/power_supply_core.c |  8 ++++----
 3 files changed, 21 insertions(+), 22 deletions(-)

--cvyl2d5z3wzlh7bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme32ugACgkQ2O7X88g7
+ppicRAAqS1JGUQRZSSmGwtIiGhkw18G01B/qZUFDkhHCm1I1tYcoRiImg81526g
OjoMubmzp7mzvfuKggziwp4chwloAvxg3Ntnt1cpbvvkyuwh6ziuqCMfIPl9a20H
BGa1basQl1NpAbCoiVPeJAzTXYUYeHSa6TmaurtVmLZEtpMfm/Qa5C3xh4Eq2UZx
L+un0xlxyhF92Wh8lvzBMDP7iCGpFiQw3fXTFbKE7i8LBgg+0Nm9eok6j2FH8XXV
7qxvUpYcByJkPmvpD0+QNF0usm7z/j8ZXsYVl8nDBA252lLnHOe6Be9mbM6B0uny
cwBGIMsDzeCDBJd7YPHHZiTFZ8xP0+zdKE47MlvvEaeXeOSkE0WFIgktV/1JXqow
IkBPytZ9gEdAOkXJpTL9M/DB3pPThbdIdmWdeW7XgMqvMqS3NP8k7Zk+Q1wtsjax
LyzRHzHYRN5hTamwTQT/7blKiy+mwjK8KImdJjjaZkJhQ9/iQ1fAIY8igD+b35Kk
9QNJlTY6VEzw7AsGGHUiWJpO/eaBjy18pnATBTqgpF1muH1tKfRyhn6UnH3eMqJx
CC+fimMF3SuXUnLyzac1jRn7AaWMoURGMjclyuWG5OpDwTui/s1u5d2QNas4mX07
1Md+AyFlnQ309y1oUSBRCXTtGkqyFGS+ufcrFpGDj6xk/idByOA=
=cDFy
-----END PGP SIGNATURE-----

--cvyl2d5z3wzlh7bs--

