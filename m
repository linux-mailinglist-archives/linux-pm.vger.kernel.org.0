Return-Path: <linux-pm+bounces-35475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64878BA49DE
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EA5380F10
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0825FA2D;
	Fri, 26 Sep 2025 16:27:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34125A2CF;
	Fri, 26 Sep 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904043; cv=none; b=QVdAZlKWD7BY70GCDAK2IOxnoytmg/8IV5DrWYAQVTVRfl54OI8ONK/DcR7bUcSpoH3qUQ0Oofq2Ppwa2w9sXgr7+gLVoPQru0Ld/AGMBJrI9WyUl/1KleJSutyme3qeLnZZ9A/q+miqIxEJWEeiVPwULyI1omQeiq1zG3pg1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904043; c=relaxed/simple;
	bh=try/PAT9gj7u33ZxmLD+vfMHhDbHVLWks0cuFzMy8Es=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LDOzr6x8nFdElpX9ZLqonLghQ4p/+a2/FDuS85EA6gyc7INQ8fV97MkOTzsQNgmUDPWh9OO3h4iVVu5C7iR/kJXyw3khMycfznY+UFqbJeXLI5FZ06YqwFibizpT7u2gsMN00Z4tmA/z3aFaSYOsXcOkGuvf9zSjt8Q57uIbiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 693F61C24F8;
	Fri, 26 Sep 2025 18:27:06 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf8:0:ec51:b786:a581:3dd1])
	by srv01.abscue.de (Postfix) with ESMTPSA id B7FE51C24F1;
	Fri, 26 Sep 2025 18:27:05 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH 0/5] power: reset: sc27xx: Add SC2730 and reboot support
Date: Fri, 26 Sep 2025 18:23:22 +0200
Message-Id: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPq91mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMz3eJkI3NjA92i1KT8/BJd8zRjy0SglKmJeYoSUE9BUWpaZgXYvOj
 Y2loAcVAmmV8AAAA=
X-Change-ID: 20250926-sc2730-reboot-7f39a025547d
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Implement poweroff and reboot support for the SC2730 PMIC in the
existing driver for the SC27xx series. Add missing device tree bindings
and compatibles.

For some reason, a reboot implementation for SC2731 already exists in
the SPI driver used for communicating with the PMIC
(drivers/spi/spi-sprd-adi.c). This obviously does not belong there, but
it appears that SC2731 has no dedicated reboot registers and requires
triggering the PMIC watchdog for a reboot. Since there is no driver for
the PMIC watchdog yet, keep that code unmodified and only implement
reboot for SC2730 here. Once a watchdog driver is implemented, the
duplicate code for setting the reboot mode can be removed from the SPI
driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
Otto Pflüger (5):
      dt-bindings: power: reset: Add SC27xx series PMIC poweroff
      dt-bindings: mfd: sc2731: Reference sprd,sc2731-poweroff
      power: reset: sc27xx: Use devm_register_sys_off_handler
      power: reset: sc27xx: Add support for SC2730 and OF match table
      power: reset: sc27xx: Add reboot support for SC2730

 .../devicetree/bindings/mfd/sprd,sc2731.yaml       |   8 +
 .../bindings/power/reset/sprd,sc2731-poweroff.yaml |  22 +++
 drivers/power/reset/sc27xx-poweroff.c              | 170 +++++++++++++++++++--
 3 files changed, 188 insertions(+), 12 deletions(-)
---
base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
change-id: 20250926-sc2730-reboot-7f39a025547d

Best regards,
-- 
Otto Pflüger <otto.pflueger@abscue.de>


