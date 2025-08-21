Return-Path: <linux-pm+bounces-32832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E3EB30203
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 20:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348797A7AC6
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60134F46C;
	Thu, 21 Aug 2025 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="qQWoMkSH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0B34DCFB;
	Thu, 21 Aug 2025 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800652; cv=none; b=Bf16Mu2CYdLwNBUQBjr5PypqVnRabmNX4FYwMfP18GhIS2bpXfKGCA5wtbT6KpxdUr2sMpzDNYGbHhFF3y7LZxT4ZC3llxoIdqGRy4s2npRsUTzXXqLY80PiT56Nn2Zac29MYQJWSQOVsyg5Ab+C7DSxhpY3NtPLJ4aVPmoEzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800652; c=relaxed/simple;
	bh=CluilFXim51uC9dpk32ZYt2i2sJtqps2NUq6ZJiEyEw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A8w0kXJv2aLxgTLI+xWAbaeybo3mYLE+ZZT7kimZUoghp4sE+3LOTfC2SEGXqGuxBfvgf5yZMzLvJY50GJfLMFwHUQGnNqViwwGujzdiJgRbpE6baPiNxBeI96MvD3P6npXioNV3CYk6YxBnyzQJP/MNTAgUxSklGDf3EMBuRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=qQWoMkSH; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=rMFoG+5Rskqk1f1Gs6Z/NvhqC82WqoYSX248NZpvzG8=; b=qQWoMkSHGfF1J+/ZQKC1+VDcaZ
	hrmFmd7fVAZwu2Hdv4fFMcxj73l50YvhyHkhmJTk3zLih+uPxSpV6u6i/smv1pifAMkV8LtO7BaQS
	MSHQZa/rCgrRQungnowet+7qRpBXb+nW2ZxNl1KnQrZ5ZyAV53glDiHxVsu0RjaS7fvsNTNEubz91
	W4yQiio8livg6mo+8u4gmKmwystpb+8K08OFKQ9/TTppFLU4MqJopEqhJ4s/sIclktPdy6hvkuLxr
	vDmOBR/lybfABPo5oPujc3rabTgLm5l5ivNCyqLbj880SazZX+Gx60MRZN8nx2wUWhAc5XeA5nBeD
	IdLPxiNA==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/3] power: supply: add charger for BD71828
Date: Thu, 21 Aug 2025 20:23:33 +0200
Message-Id: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZkp2gC/3XNwQrCMAwG4FcZPVtpUrd2nnwP8bCt6VbEVlopy
 ti72+0kipfAn598mVmi6CixYzWzSNklF3wJclexYer8SNyZkhkKrIWGhvdGgUbNSxtHirw1oJU
 8NLYMVq7ukax7buL5UvLk0iPE1/Ygw7r9b2XggivoAXpD9aDk6Uo33xnaO28DW7mMHwSKXwILI
 dEObSNQUYtfxLIsb9VzYmX0AAAA
X-Change-ID: 20250816-bd71828-charger-9d187346f734
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.15-dev-87983
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=CluilFXim51uC9dpk32ZYt2i2sJtqps2NUq6ZJiEyEw=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBnLU8ymddcopRWskfezuFd291bCh8PR04PPR3GKHy7i+
 db3yaG8o5SFQYyDQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgIkUijH8M5CY/O9B73O+CfuW
 H5hhYHpLQKz68dFdS16ccGxdpfwzrpyRYfHhHod5K+flXJ/OP+0D2/blb5L6nT/LSgTE5ZYs059
 8nxMA
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
 drivers/power/supply/bd71828-power.c | 1060 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-bd71828.h     |   63 ++
 6 files changed, 1174 insertions(+), 9 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250816-bd71828-charger-9d187346f734

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>


