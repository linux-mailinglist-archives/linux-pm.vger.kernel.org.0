Return-Path: <linux-pm+bounces-34680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632EB57FB3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 16:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C43B14B6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042FB321F3F;
	Mon, 15 Sep 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwp4P16Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A915D1;
	Mon, 15 Sep 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948130; cv=none; b=nnQ5Iv0TFAUygKSfm+ySn0l914ySsMQnDxIucp2tQmOZCUU+b9BxEwK22HBJIfgFL5fixukg2c4Pz6NAheRwCvj6oR7xnn2a8SrWj0OuOcEth/dQCvqQWuM7jUa69B8sJ+RR6zWFBKqcssD0RDUkJLQKH5HEZzGSLKHE1PXQs4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948130; c=relaxed/simple;
	bh=E0BcBn1WFxoT1N0OP2dESPWb0hRlTdmo5WhVvjd4xdM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BpNpLcPiobCW1Sr1yWPAtj9oWsRoIzxNqDhaf+ymcZsE+gg0xpz6Y0IP9gv0KHA8vvGII060ePx7GEn/dsYc/zfoTUaLd96UILW4rKhhNgzgjc2EkOJAdlhIEbe20O5mi6j5BjCqaX2oFZ0SyXHkD8EO4GuCKMIt9+YOQoH681A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwp4P16Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721F3C4CEF1;
	Mon, 15 Sep 2025 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948130;
	bh=E0BcBn1WFxoT1N0OP2dESPWb0hRlTdmo5WhVvjd4xdM=;
	h=Date:From:To:Cc:Subject:From;
	b=lwp4P16Y6o8aYpd2Xwnhr76tg3+fnGKShKeuFAsMyFbhT9BxEpzk0OMv0rKqp1nsS
	 YNjhKPaiWlB9ulXe/055q4XLOZTpN07gQLPuuD857Q9vPFg8qTK3UZHnXy36ox1xHO
	 VfHaEF/9CVrI9ABf39/4H7MatWdUR8vbHMMcINyWuH22f7/bNy9gRkqKHlOXrfUav5
	 1e7jjowlZoLIDgS/cxtxUn21vlsGcuRPv20ih5Hr3mOdHbTXRSXwuVJfGRDQv6pyC7
	 9VpkX7hKtC6T7TejXKuuwmo5U7IFJiOFgL+KxZ0IV29W7EgwQjajNAVoxx2EG3CB9J
	 VgCKBKKYPO6gw==
Received: by venus (Postfix, from userid 1000)
	id 0D805180BBC; Mon, 15 Sep 2025 16:55:28 +0200 (CEST)
Date: Mon, 15 Sep 2025 16:55:28 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.17-rc
Message-ID: <otvgknffk3ba7hzploodbvs5cbj2axb25wz2nelewlbmye4iag@ooi26edepadg>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="snfa4d7e4kfcef4h"
Content-Disposition: inline


--snfa4d7e4kfcef4h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] power-supply changes for 6.17-rc
MIME-Version: 1.0

Hi Linus,

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.17-rc

for you to fetch changes up to 1e451977e1703b6db072719b37cd1b8e250b9cc9:

  power: supply: bq27xxx: restrict no-battery detection to bq27000 (2025-09-06 02:11:38 +0200)

----------------------------------------------------------------
Power Supply Fixes for 6.17 cycle

 * bq27xxx: avoid spamming the log for missing bq27000 battery

----------------------------------------------------------------
H. Nikolaus Schaller (2):
      power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
      power: supply: bq27xxx: restrict no-battery detection to bq27000

 drivers/power/supply/bq27xxx_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--snfa4d7e4kfcef4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjIKN8ACgkQ2O7X88g7
+ppkmg//Z+b+SAwPoM8GAODaavpyeIPJNF2WTxe6/CpP9nnQZefKWWOVx73+/PyX
Lu+xgxyMLO65LRndhaPU7bTj+0eGdxFNXNy3qsn7YS9axDvQAWC4w5ZNjhAujhqG
qXqV+e9zFE77howrZkmebbhDBGUbERtdfXNXm/fNk2wo5InyfCc0sYbqC8CFozt0
g9wEkzigFCsV6W789cU/8kRBJlXWCOcAF9+9FZbGI8/SMuqvYMEfX5i8m93RrWZg
kZoz5v0Aqk2beDF/VrEMbfMrwkBpYtGPOTx6IIFmopT4/HKSPLLGuoYcUZUiEZfI
2n+biSf57382tM/kDzKz7u0w/O7ssmD6cv04pBJN8CftW6WCCNjWVOGt5YTq4sKd
oO/zzI/Syp1lxyn+YBb3kYcXpdK9FbUJcAVTnSIcquzSSoW3khA/tASPYODyOczo
xsJsc29Epu2NaHZ1k0aLssNbQaycJccLyq9aJnVl4Pf/YnRqiGPeTCJxNeND6hmQ
64mv1VBv+3XVbKXd7waCpYcfxuf8hurWy1G/XQelTS7V9ee3cOA2Mu6cXbXyVbeQ
6KIJN7vmLXdEiSvSLiTNNGrynTPLJumbRgcrzxtjPrusrRqu2BRmqb0CM6+RrRTc
5gkjK09wJSFCjR34LJIobmx5UF+sMmYznLufpQhcz8rjDamQfug=
=r1Sa
-----END PGP SIGNATURE-----

--snfa4d7e4kfcef4h--

