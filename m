Return-Path: <linux-pm+bounces-15182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF399914BC
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 08:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947941C21A4B
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 06:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC5D60DCF;
	Sat,  5 Oct 2024 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="9XWwScD8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41AE3F9D5;
	Sat,  5 Oct 2024 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728108318; cv=none; b=B4PdfJJ/G8+Jc/eMIAutQB8LujrNkKflL4z6iwE2L2/l2hI+sUy1sgz3Hw20EsFKYX9sugAb6Wo8eGnRaRgBBCnqkdxmmd/Zaa91OIiunJ9o6Y1pTesLMoyPfGhMHFtuIrDp/r4NMO0HGhMTc6NXZ59+tr6be/T+3w5+nDpwkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728108318; c=relaxed/simple;
	bh=U0485fxW6LEVGII+rpQROcHZFV3myBUP+VWYTWxPL/E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LI2MEI4a3NEiLTYzvQlWZ/nFSRcrYQFKk2dhISFXP4pY6SaNO8XKu9wkmV7D5lBC2lCmiZj//se4BEPTZ1Hi1uJPDWJOKYwG1BGW99TB9NfTus8Mfz5S1M4VUzh/p5oL852oJnquCCT37zbGvKoZHAQywAXTJdsfUb2b+C0HTtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=9XWwScD8; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Z3guRNwJopPlkQDmMZn6yU9cOKBqNwYsRwH+H1VXDzU=; b=9XWwScD8dFjQLHxmfFn93uuyVQ
	BlGGQfr17WfaTX4lLKqORlX4uZuTqR8Qa/r3mNmLdI3knjhOe7fNNyviS0SIgOjav5CqQyBakO3RY
	XcrVTRDDaNpEYiSbSenfbL0ABOxUmWcHfPIhvtZJRGpcS6NL4PESSDAQlWhBFG85fRLhPJgyGZTMK
	spZqQyMGww3+IE9Kg/VQk6e2s1GztajusHkhCZiy0tyEXbUS2jbDoKju/cfoH3w+MfR4pjBWmc+5T
	3GDTFp3qViAhNIR3ffdY2115cQbJsUS3ESV0YLWEwnPpniZKGiepfq3MK4Qk8muL0MXHQWod6Xdfy
	Fg8AZ/nw==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	tony@atomide.com,
	linux-kernel@vger.kernel.org,
	khilman@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/4] power: supply: twl6030/32 charger
Date: Sat,  5 Oct 2024 08:05:07 +0200
Message-Id: <20241005060511.1334049-1-andreas@kemnade.info>
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

 .../devicetree/bindings/mfd/ti,twl.yaml       |  30 +-
 .../power/supply/ti,twl6030-charger.yaml      |  48 ++
 arch/arm/boot/dts/ti/omap/twl4030.dtsi        |   2 +-
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/twl6030_charger.c        | 580 ++++++++++++++++++
 6 files changed, 668 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
 create mode 100644 drivers/power/supply/twl6030_charger.c

-- 
2.39.2


