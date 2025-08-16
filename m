Return-Path: <linux-pm+bounces-32468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E5B29032
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 21:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5790016648C
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4619620C00C;
	Sat, 16 Aug 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="nW64Aci7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABC136358;
	Sat, 16 Aug 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755371990; cv=none; b=bk5XHezMMByXjtNBgS12vSQXN/hJ9gydEgVtVYakwPqP2Xib6A/8WkB8RTFP6PpZx4EnX73pcg2ZfpjBoxtu0ZkGi5Bchc6YCZrLdnPMgoOrdYHT4T4qZ/kWjm7rWlshrD7/Ku0Qp2LiAkm7aOHfgL0fgf1dsuOXoEO11Jkde84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755371990; c=relaxed/simple;
	bh=E2qxdukfX2KrJc5V6ZEUoJJ2kJjaOXngDSOP7o1I4E8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LXMrKZy4XFLZfGnRrotP4Lo2DbhXsPqeu7aZWmblFQ9IU0xhvuQXe4jw+15NNHU6xEwwsu0rempgDSxiWbGC8FhGsuWNx35XqGqYpWrQSBaUZhReLGJcCQGTRqukpwpb7H4ljTHp4vkPcSsZjP0Bnr6xLTZGbecWOvpThhksPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=nW64Aci7; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=hKuoHVKU4ykXyozWybFaDggViAEf0QMMXpUHn0EINI4=; b=nW64Aci7x7VutxujyEj5ZV76MV
	DRkf/L7sJlub1gv29I5W0g9Qxt+JlNPVgdB6P4ReE14qkzh1uyC40D6ARiVfFxqpYZx0uKglngKLs
	euoc0EGyigXcwmPKvWvteFF1XJekqQvHbFgo/QFfdQl9YjbsFGtxW7wHUyEWWBo7EdmvkaG3CYOo6
	T02VLxjzig4nSm6U9ziq7IBbfHFnT3cRpGBl6e46YMsF/FGtGbdPokFOUqrC24J5CKL9vbllP1yp2
	WZ1SlrtKePghKgqqiI4jadQPwNN5Eoz/GDtkGruGEvWHpqEPFLLaZYKCCdvQZ8BxM20rwVZUFqFB/
	LnGoVZUw==;
From: "Andreas Kemnade,,," <andreas@kemnade.info>
Subject: [PATCH 0/2] power: supply: add charger for BD71828
Date: Sat, 16 Aug 2025 21:19:13 +0200
Message-Id: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHZoGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Mz3aQUc0MLIwtdoGxRemqRrmWKoYW5sYlZGpBQAuoqKEpNy6wAmxg
 dW1sLAN0QHGBhAAAA
X-Change-ID: 20250816-bd71828-charger-9d187346f734
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=E2qxdukfX2KrJc5V6ZEUoJJ2kJjaOXngDSOP7o1I4E8=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBkLbp4u4mMXZD/wq3YDW5pzm+2kGfe2C9p8nOi4ZN/ba
 cX8s/UaO0pZGMQ4GGTFFFl+WSu4fVJ5lhs8NcIeZg4rE8gQBi5OAZjIfkdGhhfL0msmrFg3L8zL
 Z2N/QeXNJ2+/uguvKPa9IvVPUyFp1imG/96Lk5+tXxji0LJlwtdfRq/sX0v17j3/+uHnj1MPdSX
 XrOYDAA==
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
Andreas Kemnade (1):
      power: supply: Add bd718(15/28/78) charger driver

Matti Vaittinen (1):
      mfd: bd71828, bd71815 prepare for power-supply support

 drivers/mfd/rohm-bd71828.c           |   44 +-
 drivers/power/supply/Kconfig         |   11 +
 drivers/power/supply/Makefile        |    1 +
 drivers/power/supply/bd71828-power.c | 1144 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-bd71828.h     |   65 ++
 include/linux/mfd/rohm-generic.h     |    2 +
 6 files changed, 1258 insertions(+), 9 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250816-bd71828-charger-9d187346f734

Best regards,
-- 
Andreas Kemnade,,, <andreas@kemnade.info>


