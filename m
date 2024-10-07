Return-Path: <linux-pm+bounces-15270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A0E99305A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C171F24ADD
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33731D8E10;
	Mon,  7 Oct 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="pic6vJBU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946CEEC9;
	Mon,  7 Oct 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313286; cv=none; b=V1KxlwMpMUFapHP6IQIBR+wsn+PlITVXur4RHXWDjogfbslJPaOEkjlGMkTg0GUJdWvGnNYwYrIUuZvcxH1i75qK3CaCA5qL+3LaW+WnRKSJgCF/WtT33E9xegB42/kKELdZw3eFXOdYXswgtIl3n3fSJrrzTDjJgwlboVOECrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313286; c=relaxed/simple;
	bh=BKa7F3T+x64sPoI4NsSuGQmgQuhlv3xTq8e4wiyPwPM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pIp03UrWFNfRZG4lYaeF6w0GkKYWiGgH+361AXSc2+6xBH9lxwvOCDXxoYxo2EIeQN0BrYob+7VuWvkvp7GZow1cvZiEh5r06k6CRRVK2GqXh7AmfXUYE1YfGI85Gk+guS/egNqE17zReKu4E5qbalnyQnkyyWcD0tMycj9UjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=pic6vJBU; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QUlITJwzuI3QvM9dA75zgeo5pDN25LRgOLNySo/t9Ck=; b=pic6vJBUaSszZDso15VgkLtriZ
	HvpF33lp+H3QAYZ3JUF0PWts6cG2YKQoDrsqJD5tpKvlsgsykhDocTJ0Dj/JVAsNjenu8CXIdKrk6
	brab3iZHbxwW2QR8LcRGzpMSXZpx8o4BIFrblznVyyZrTiOeFLaRHAjkkdEx50wAHbO/c9J8BqsLE
	KjhBsWb0dtwy3gmDnKeN6WYLKNyYKcQNzhbxS+7KgeblAZhwdtw6xmAzbm6Ap00GMOBvH95zLG+AU
	BEWZ5lPKeHG4vue2GC6oeVJ8ek4WvgcxPW72oQRIghPJrCdWmfKUVDGAED8U03Hi3TSjruh9kxJfn
	N4kbi9nA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	tony@atomide.com,
	Rob Herring <robh@kernel.org>,
	linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	khilman@baylibre.com,
	linux-omap@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 0/4] power: supply: twl6030/32 charger
Date: Mon,  7 Oct 2024 17:01:16 +0200
Message-Id: <20241007150120.1416698-1-andreas@kemnade.info>
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

Changes in v4:
- require compatible in charger node

Changes in v3:
- define charger in toplevel
- s/bci/charger for twl4030

Changes in v2:
- s/bci/charger in mfd schema
- additionalProperties for charger node
- extended example in mfd schema
- no quotes for compatibles in charger schema
- no example in charger schema
- interrupt description in charger schema
- replace device_is_compatible by driver data
- clang compile fix
- removed alias
- style fixes

Andreas Kemnade (4):
  dt-bindings: power: supply: Add TI TWL603X charger
  dt-bindings: mfd: twl: add charger node also for TWL603x
  power: supply: initial support for TWL6030/32
  ARM: dts: ti/omap: use standard node name for twl4030 charger

 .../devicetree/bindings/mfd/ti,twl.yaml       |  32 +-
 .../power/supply/ti,twl6030-charger.yaml      |  48 ++
 arch/arm/boot/dts/ti/omap/twl4030.dtsi        |   2 +-
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/twl6030_charger.c        | 580 ++++++++++++++++++
 6 files changed, 670 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
 create mode 100644 drivers/power/supply/twl6030_charger.c

-- 
2.39.2


