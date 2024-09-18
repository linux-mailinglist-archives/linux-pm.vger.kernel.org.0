Return-Path: <linux-pm+bounces-14393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6DD97B97D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72861F26AB0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 08:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45D175D54;
	Wed, 18 Sep 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="EdJ80ahG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947D17109B;
	Wed, 18 Sep 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648905; cv=none; b=ZrdA9vJ0Hy/9VFi9jDF5bQcHyZHkNIt00Qq82wJXgezecXf7P91uA4zjolbesrOG+7VLFC9rGxCCnvklZjNtntX3SWnbpfHc0auOSRyjCY6maoV/1xje7BCzXwzujUdpYUmMBHuOoKAB8KvevnEoNheYck5kZ/VIdNfx46wyLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648905; c=relaxed/simple;
	bh=mn9mI2S8mSXs15GtSFvObBCc+jT1sPtxxW/LFo4PTK8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OYB2g5hYbtcXieL9YBZuTD0yRXYMq4xq+JoEf2Qu+cfMtP9ECB98fDJ5zumbkorPU84Fr+INZODUvwF8bqL++1rxuD6qIPGzLfNgGv3pE+NQyfp2RdfRPMMjcXvShGaOjj8moNb8We258j1GFxsKUE1QsgrVblBxsH5CVcQlnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=EdJ80ahG; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=RClJr09uffgbAvKnsR2grPgxRk7TIWAd2Kn+++S3YLc=; b=EdJ80ahGGnVU8byvsPD00QqmsQ
	nH0XZM8KnLGWkBpnWuFHvRkpiPubo8Eb56tqHNc2p9hrefOmSV8iTQvdixD5Fi74Zh2dwnnkaYBLk
	gIrQiV/sGFOTDHPMvV/ddbhz4tL0QN2zAc4EdBLbQgkvYv3YJftWhJnFDnSqheCJNDvTfwWBRYXhl
	aIhhWpKrzPNeC6Wn4rNt8KzDl2uMOxE8zgyrb166ogqyiMGB78bYjg7AWfFVbNVwWmQ4GP1HlxxSG
	dya0yWseB//7wifWKDo38d4/xcNWWuQYFcQ+HDZXNoOxSYzWhQED54UoaoBsTz1e+6XwsnPgAeXB9
	QGBo6GuQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: tony@atomide.com,
	Sebastian Reichel <sre@kernel.org>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/3] power: supply: twl6030/32 charger
Date: Wed, 18 Sep 2024 10:41:29 +0200
Message-Id: <20240918084132.928295-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic support for the charger in the TWL6030/32. Supported is the USB
path. AC path is not handled yet, also there is no entry yet
in /sys/class/power_supply with type battery yet.

Without this series, devices will happily drain battery when running
on mainline.

Andreas Kemnade (3):
  dt-bindings: power: supply: Add TI TWL603X charger
  dt-bindings: mfd: twl: add charger node also for TWL603x
  power: supply: initial support for TWL6030/32

 .../devicetree/bindings/mfd/ti,twl.yaml       |  18 +
 .../power/supply/ti,twl6030-charger.yaml      |  62 ++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/twl6030_charger.c        | 566 ++++++++++++++++++
 5 files changed, 657 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
 create mode 100644 drivers/power/supply/twl6030_charger.c

-- 
2.39.2


