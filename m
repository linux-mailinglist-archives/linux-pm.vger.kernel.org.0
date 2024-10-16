Return-Path: <linux-pm+bounces-15741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88B9A0392
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD592B2705A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E951D270D;
	Wed, 16 Oct 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ViUJ/ZGW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6A1D1F7B;
	Wed, 16 Oct 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065807; cv=none; b=tvDIvgAQ8N6SavcVz7wHx+JlOjuCW3lqqlUIYujTQ/wI/r+/bWDL8L+RMOE0Ae3WrH4ItZ52DkOLt7fJdArQFzDnF0yICSB41nENJkOnQsyMmrEIwGodfhixxalvUjDgKPb2S0hclMcJ40flB5Y7P9YXFKaQxyzM3OR5qgIKX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065807; c=relaxed/simple;
	bh=1eBE8U39+8j137AwN33pMYfhhzaw9VZgdIiKVZwF988=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XxViUjxt58qOqLrDDTIZWvqeUlCq8iYfPZFAR9S0tHm4sBqGojGetJz7atkPQ/y5CHsY1pafSPmzJteMjCQk3G9Z5xpfbidCYR5dnVzz23yWtWtoseVyMO/F9lj8Pk5E1MWh/WvA1csvJ6ikkPCYF1M8h4XJ9wjBzWPntlPSWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ViUJ/ZGW; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=c9rfrELr3kRzTw8yZu4HzqoH7y14nBKXVdFWDw/SolM=; b=ViUJ/ZGWKl2UB9Qk8ombMz0OHE
	3u0VaMVhgjskeFwTVmisO1nbpWGjVx+p+uCIPMG9zTklCvTZXgC+xCJ7Q313H1vOyILsWICgs7g6h
	1kYjsOfosZA+p9AoRXuaxAAMHlLIeAmdjeU2nsghWMVnueHAZyf6aoaykNRrbwG0sqnw9tDSPSJh8
	LKU9RmjqObc8v0JYXz3BZ8qpuGFenSkMNWdDXClPK/eaJaGT3dgqMG2RrQ64rW9hWCtexvtGNGdWZ
	D8LbKuWhTE6M+5Q7snp6VigiWaywvCAzL/+SgK11v5Oy9G6FgDShe4ai1Y8UvW/0SrdWp+J0pSrnH
	HseQYJUA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: khilman@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	tony@atomide.com,
	linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v5 0/3] power: supply: twl6030/32 charger
Date: Wed, 16 Oct 2024 10:03:11 +0200
Message-Id: <20241016080314.222674-1-andreas@kemnade.info>
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

Changes in v5:
- set fwnode
- drop mfd patch as it is already applied

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

Andreas Kemnade (3):
  dt-bindings: power: supply: Add TI TWL603X charger
  power: supply: initial support for TWL6030/32
  ARM: dts: ti/omap: use standard node name for twl4030 charger

 .../power/supply/ti,twl6030-charger.yaml      |  48 ++
 arch/arm/boot/dts/ti/omap/twl4030.dtsi        |   2 +-
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/twl6030_charger.c        | 581 ++++++++++++++++++
 5 files changed, 641 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
 create mode 100644 drivers/power/supply/twl6030_charger.c

-- 
2.39.2


