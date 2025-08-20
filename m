Return-Path: <linux-pm+bounces-32740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55001B2E662
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 22:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8FB1889485
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32828B4FE;
	Wed, 20 Aug 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="9/7t5+Yo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D429A31D;
	Wed, 20 Aug 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721313; cv=none; b=iHW6eJg2aeazewvDhkzs8FSML32TBBcW3ZBAty1ibIYeuJApd8+41nIFhU7SGu2TmEb4bnkMa6g8dC1cHQiDApEnLw5WFewuq0ipHaKkyHoWMOdo8JtXTmoH+L9YBPLLhS3CMoJeVvzgfSeMLG/01cfUXmnFFCjD/deya14OFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721313; c=relaxed/simple;
	bh=GSFI+b+FV3iDqribDoqHYVrSoO11VJOzdi2bEqsEfY0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EKhoAlB29hgTCU9u2L1AwX+pUPT23+CiIcsjnjPGhyHcnygifU3K45Y+a27762GE3Fw6ABlWb4AJMO3dO8DdsI5W9yvbb3ftWsBBE4pA2wHIawhgfREQFr6cOAL0m5Kv2El8wIm8/Ph1tMIpRWLC4fJHN//2GGgiTcSNx2evGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=9/7t5+Yo; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=M1+pHLHYC/oRTveLLY0USCJvLuOoRkkpIXVFvNN30Ho=; b=9/7t5+YolhSArDM2uDmTXRKGtJ
	iDQdUOV/BWJbOCVxGMi140gaw2bwfwviIh+X7a/oBo39PkJJnyYBu85pC0T7qMJzSThQvXjA31XvT
	fVAAem9GtaQ0szl3ZaSd1FfznzM9j+Iw9pYIuNru26cCDKwbz7rRMKvmg93ORie/yiGbinii+6GmS
	FcYvdCybodEz5cj7ITi8lNoXQnTKOOZL8ANVoEs4YyFewzuBro4AIUnbw4q4V7a+BD/NEw3gwv+En
	jr/H/tKqap0TaPVxbWZrliuQ9CBkhC1T0EbkyHuOlonsSFlcaNO3D6Eu6NXZD/yEFRdAnzDukjAQe
	Q0ovswNA==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/2] power: supply: add charger for BD71828
Date: Wed, 20 Aug 2025 22:21:39 +0200
Message-Id: <20250820-bd71828-charger-v2-0-32fc96027e92@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMupmgC/3WNwQ7CIBBEf6XZsxiW2oKe/A/TQylLuzFSA4ZoG
 v5d7N3LJG8mM7NBosiU4NJsEClz4jVUUIcGpmUMMwl2lUFJ1UmDvbBOo1FG1DTOFMXZodHtqfd
 VoLaekTy/98XbUHnh9FrjZz/I+HP/b2UUUmi0iNZRN+n2eqdHGB0dOfgVhlLKF9SOxaexAAAA
X-Change-ID: 20250816-bd71828-charger-9d187346f734
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=GSFI+b+FV3iDqribDoqHYVrSoO11VJOzdi2bEqsEfY0=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBnL9GKknhoo3lY6fUzxUyz3RMY1qVZhd2UM2bUPs9sd5
 Mv6+Smyo5SFQYyDQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgIksdmdk6JvsuCrrZprQh57e
 FcYry3auSIpNW1opqbqsJGrDTLaOlwz/NMtmXWyJ+cnVKsuv9f19xjf1lp7E/SJKPWmer8xXl65
 mAQA=
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
Andreas Kemnade (1):
      power: supply: Add bd718(15/28/78) charger driver

Matti Vaittinen (1):
      mfd: bd71828, bd71815 prepare for power-supply support

 drivers/mfd/rohm-bd71828.c           |   44 +-
 drivers/power/supply/Kconfig         |    9 +
 drivers/power/supply/Makefile        |    1 +
 drivers/power/supply/bd71828-power.c | 1135 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-bd71828.h     |   65 ++
 5 files changed, 1245 insertions(+), 9 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250816-bd71828-charger-9d187346f734

Best regards,
-- 
Andreas Kemnade <andreas@kemnade.info>


