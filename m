Return-Path: <linux-pm+bounces-34947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A6FB83619
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 09:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507CE16BFAC
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6632ECE8F;
	Thu, 18 Sep 2025 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="iymhw7p9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AC2EBDCF;
	Thu, 18 Sep 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181529; cv=none; b=KQ+Eu7hXWW6b6EBjvaaikIsgvE9mWDhzWxYqNSVoXCBMMf3O6YuRC1hAEtr+R5NfvvOAOMeDjBSKIbFllAQWUuDZhEGKOVyRpVhCRu15nQBMGa0EzHavCbSpvZUFDoyKBSJn3V7jIbd02QnBkdFq0aC5vkcEmClYCEdgrLFeBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181529; c=relaxed/simple;
	bh=NB7xAjO4tMiy7knpfZpr8sLB2fm7/Qi17xHEb9HkCMM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f9U+OO6EGIMiB630NCkECL8dqB3NWRU+PZhknCBloOVAwG4j3zHH4EvCQE00LFjHkkuPsZ/kN5upD/Upx1fnDs2mlEs1YjObSMQVlv6L7496hB6XYHBbRQx5Qrf+nbfFFKn2JM+ADqp0TfJ0/jl8G5Jrf4lRr0lPRO0nTJ7+vFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=iymhw7p9; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=dQBaVu6WYznOiPZIWET5HI2UvRXh/gGIzQMif1x7+GQ=; b=iymhw7p95orw5qBYuiq4K8GZsU
	tW7Lx2nlaDbuT/ya3m+DP4/N64ICyEyUH5L/kw2S2uk+4muuhmRMyZ3KUJTLDZE8zqgQRawHu3A85
	GG369iNoaZC/beAZudNI48B91XY5M50J0Yo2SmC8JsGymlr5Hlb5iZ2W1A18REKXUmSwERsZVR3yC
	LeTPidh68G27sY9LCNpiAhLQUFb51zzrlnC2eGtiSjeNPwyTF2UtMY2uB16aXs3/GdFa194zIXPND
	KjFn4yld90FQ3q9wdMV+OmqC2hkfp6z6gWAZc41PW8xHIvjsaK0ileQMEBYce0HuXuix0ij/YtqXs
	ARuhqsuw==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v5 0/3] power: supply: add charger for BD71828
Date: Thu, 18 Sep 2025 09:45:08 +0200
Message-Id: <20250918-bd71828-charger-v5-0-851164839c28@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIW4y2gC/3XNQY7CMAwF0KugrAmKnbRJWHGPEYsmcSBCtChF1
 SDUu49hM4jCxtL3l5/vYqRaaBTb1V1UmspYhp5Ds16JeOz6A8mSOAtU2CgHrQzJgkMnua0HqtI
 ncFabNvMQfHWplMvvU/zZcz6W8TrU2/PBBI/td2sCqaSFABASNdHq3YnOfZdoU/o8iAc34QuBa
 kkgExpz9K1CSx4/EPqVgCWhmYjRmi4aUjn4D4T5JzzYJWGYyCG6pvOgjH8n5nn+AyyA8U96AQA
 A
X-Change-ID: 20250816-bd71828-charger-9d187346f734
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=NB7xAjO4tMiy7knpfZpr8sLB2fm7/Qi17xHEb9HkCMM=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDBmnd/SXvn13iFHH9c+Ez2Hd2uFyjKKvtA/pi63aInV0m
 /nqhYHcHaUsDGJcDLJiiiy/rBXcPqk8yw2eGmEPM4eVCWQIAxenAEwk/DbDP6ONIQdPPLFWfTON
 9eqTzRUhAjNjk2af1mG4vyDM1Pn63wpGhuMHWl96rqnSD3IMmtC4edW/lGUViTmu/bM+R4S7Sag
 95gQA
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
Changes in v5:
- include cleanup in the power driver
- Link to v4: https://lore.kernel.org/r/20250917-bd71828-charger-v4-0-fbc85a910499@kemnade.info

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
 drivers/power/supply/bd71828-power.c | 1049 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-bd71828.h     |   63 ++
 6 files changed, 1163 insertions(+), 9 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250816-bd71828-charger-9d187346f734

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>


