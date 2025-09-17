Return-Path: <linux-pm+bounces-34908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D5B8138E
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9529646731D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3E42FD7A4;
	Wed, 17 Sep 2025 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="i3izcnhu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBB2905;
	Wed, 17 Sep 2025 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131318; cv=none; b=aSpkVqbPVkZ96NZ2O9Bz+0ysz2Y5/fJwm9tHEjL1kFrXq9e1f4lXFD++xos6pKG2MIzF7qMRdCiDqe/TcXvTpCvKiiPb8WlJAS6s23bF5hHbagd/tbtL6Cwjz+ztUswv+7FWDn/IXjYwlGDHlC2tsoyFemIdZW7u7+zuJ+Mxz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131318; c=relaxed/simple;
	bh=GSUGXsM0hPD/9no8B1czLo60/9zR/+HtlWAnFKNnBZ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VtH2d16vTRKGPNpTnIYJU3BMTXm5WLroWTrinyCXKyqq9TaDiTHOs43X7tK2XJ1xhn+T6DyoGA4Qb/D4/L1qfJe2oYyVqTvDVQVarqZ1rxpFLtEMSL5t8RUL1Wd7xt03mzNx7cNziemMwazNj3PuuVU2pFbLqgMK2uQVSb9yXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=i3izcnhu; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=mPL5Z9jiDprrdY3LcG18iSElWnw3yrMIHCNC/RNzhY4=; b=i3izcnhuuM6TANkSqGR/ZKNhrm
	b15FXGIRJm9jJxjnrUAxvyQ9eO0N9xYs/TQQ2qyDPGRTk8ASM2tzf3zdRnrHqfWoq7BAiwaPDVNeu
	acaPnVAnMAYoX5KkzQQqnVziJ5J+jwy37NGP1OakJiu92LSDxzSG9tl8QKSk7Wqo8CXmp9VFf1XjU
	vA8xTFsGHapN8KMDjccrAxBuRv4JdyxJCJiSu4FMIgEUz2IEP/oDHyP3MN7L+9UGpdmJGNDk378gC
	jxdCZ6QJg8qc63g8AAHQgJnwq6FxDYz4IgOJUtR36ePWZF3dq6JDH9u7wLBeTmE8nMOtfRLg9gxYt
	k/1GcSzg==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 0/3] power: supply: add charger for BD71828
Date: Wed, 17 Sep 2025 19:48:01 +0200
Message-Id: <20250917-bd71828-charger-v4-0-fbc85a910499@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFH0ymgC/3XNwQ6CMAwG4FchOzuzdoOBJ9/DeGBbB4sRzDBEQ
 3h3Byciemny90+/TmygGGhgp2xikcYwhL5LQR0yZtu6a4gHlzJDgbkooeDGaSix5KmNDUVeOSi
 1VIVPg6WrRyQfXqt4uabchuHZx/f6YIRl+98agQuuwQAYR7nV8nyje1c7OobO92zhRtwQKPYEJ
 kKit1UhUFOFPwi5JWBPyERYq1VtFQlvqi9inucPmtbKNTcBAAA=
X-Change-ID: 20250816-bd71828-charger-9d187346f734
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=GSUGXsM0hPD/9no8B1czLo60/9zR/+HtlWAnFKNnBZ8=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDBmnvqS/XGETOCvIVjn1jW7RbB7GrlbbKLYvGYbreaSvR
 Guq3JvVUcrCIMbFICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwER+WDEyXP9yZOlHhhVO0U9z
 GjyCQrsjOP6WMyzeU3aOX0r/5ufvExgZ1k7996zybauFss9Mn7U1rsuMjPiDbB1Yrf5sf3r/dbA
 SEwA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add basic charger which does just read out simple registers without
doing any sophisticated things. 

This is a stripped down version of
https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/

That version includes all the bells-and-whistles you might imagine
around coloumb counter handling and capacity measurement which includes
changes no the power supply core.
Rather do a step by step approach to keep that reviewable.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v4:
- applied mfd part kept for better overview
- clean up messy file header
- remove some superfluous ret = 0
- move a define to the top
- Link to v3: https://lore.kernel.org/r/20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info

Changes in v3:
- remove unused defines
- some minor style nits
- add MAINTAINER entry
- Link to v2: https://lore.kernel.org/r/20250820-bd71828-charger-v2-0-32fc96027e92@kemnade.info

Changes in v2:
- fix some be16 handling reported by bots
- fix some style issues
- do not sneak in additional chip ids
- remove useless debug output 
- remove wrong/useless alias
- remove fuel gauge remains
- fix error checks in temperature reading
- sync properties in switch/case with list
- Link to v1: https://lore.kernel.org/r/20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info

---
Andreas Kemnade (2):
      power: supply: Add bd718(15/28/78) charger driver
      MAINTAINERS: Add entry for BD71828 charger

Matti Vaittinen (1):
      mfd: bd71828, bd71815 prepare for power-supply support

 MAINTAINERS                          |    6 +
 drivers/mfd/rohm-bd71828.c           |   44 +-
 drivers/power/supply/Kconfig         |    9 +
 drivers/power/supply/Makefile        |    1 +
 drivers/power/supply/bd71828-power.c | 1051 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-bd71828.h     |   63 ++
 6 files changed, 1165 insertions(+), 9 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250816-bd71828-charger-9d187346f734

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>


