Return-Path: <linux-pm+bounces-41063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B830CD39C84
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 03:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86CEA300EA1C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 02:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A52620E5;
	Mon, 19 Jan 2026 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G37TqJUJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76361E9B1A;
	Mon, 19 Jan 2026 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790566; cv=none; b=oH1cfv10CHNYlypwCHDeQJu2Amh6rOLY9R8cAnqnWzCLhicwyO+f2H1TpsXx716izNlpJNlq7/VZYtZ2ezxYEze0+MkfHcRIKd6hNUOzWvpX+8m6mrCyWrPT6brkqOI2srAjpZel6ZtKKBeFUMzoc0LHONxk25geMicIzQLaJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790566; c=relaxed/simple;
	bh=yA3VdZI4Un06fzV00HqWi7i7xrowQbaZzQEdIjfwCUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RPSo/Ye27DwpBvFBbXehEEeff/gP8b4wJqX1YmK9KgNc/7+8IkDKAkYalzhn8u8fZ1EpfFbdiCjKAdtdVPiehwjiKATskM5ix4mhWXRxqY7jGVkur9xxGOioAC2Tf4+W03ZcEkNBWEXpDZ1jsaCTTVlb1FvfMev1N+Q3GiwtNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G37TqJUJ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type:To; bh=Cdyy8B+C4W0KUxe3m2muENX4c9ZqpB9du/esOVVOZa0=;
	b=G37TqJUJ4VZXnuCYtNSjKAPquN24rVA3w8FarxVBq8AgB+yc2/l9nsh7jyz2rY
	BWErJCLRUcKb55n+5caWe5wjg9oDJ6UFdlOGegusj8iKdso474z7zOXPkUh7T1NK
	WKLT2jdoI+sHQmDfleh6m4e8KIC3d3XvV1EI1anaA4nJw=
Received: from [113.54.162.98] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXQfnSmW1pNwHHLg--.6S2;
	Mon, 19 Jan 2026 10:41:26 +0800 (CST)
From: Shuwei Wu <shuweiwoo@163.com>
Subject: [PATCH v3 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC
 thermal sensor
Date: Mon, 19 Jan 2026 10:41:20 +0800
Message-Id: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANCZbWkC/22Nyw6CMBBFf4XM2jFMCwRc+R+GBQxT2yiPtKTRE
 P7dSuLO5TnJPXeDIN5JgEu2gZfogpunBPqUAdtuugu6ITGoXJWkqMSlW9lGhQ/C1YofuyeWxvS
 1rg0TM6Th4sW41xG9tYmtC+vs38dHpK/95ap/uUiY41D0mow03OTFlSp95nmEdt/3DzogIMOyA
 AAA
X-Change-ID: 20251215-patchv2-k1-thermal-5ffb838fc1cc
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Shuwei Wu <shuweiwoo@163.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768790485; l=1596;
 i=shuweiwoo@163.com; s=20251125; h=from:subject:message-id;
 bh=yA3VdZI4Un06fzV00HqWi7i7xrowQbaZzQEdIjfwCUM=;
 b=xOxL7SjIRv+RJxc9mAAosj7bqGbYodCxlmFPffaassJA8vOCV5iTdhEMlZYLlwo0Dt3nMmt1O
 uoDv8QHxCltAjYY6hbw2G8HLt7CbkjtrGADTemsER0EQgwFWG4hcr35
X-Developer-Key: i=shuweiwoo@163.com; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-CM-TRANSID:PygvCgAXQfnSmW1pNwHHLg--.6S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw43JF4rJr47JF1ktFyrZwb_yoW8XrWrpF
	s8urn5C34DGr4xJw4fur17CFZ0qF4rtFy2gF1Igw1Yv3WUCFy3XryDtF15Xa48Xry3JFWq
	vrsrGr4rCF1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi8sq_UUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/xtbC5BdR32ltmdeEuQAA3K

Introduce support for the on-die thermal sensor found
on the SpacemiT K1 SoC.

Include the device tree binding documentation in YAML format, the
thermal sensor driver implementation, and the device tree changes to
enable the sensor on K1 SoC.

---
Changes in v3:
- Fix indentation and variable types
- Simplify clock management and redundant assignments
- Link to v2: https://lore.kernel.org/r/20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com

Changes in v2:
- Move driver to drivers/thermal/spacemit/ and update Kconfig/Makefile
- Address reviewer feedback on style and structure
- Improve variable naming and comments
- Link to v1: https://lore.kernel.org/r/20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com

---
Shuwei Wu (3):
      dt-bindings: thermal: Add SpacemiT K1 thermal sensor
      thermal: spacemit: k1: Add thermal sensor support
      riscv: dts: spacemit: Add thermal sensor for K1 SoC

 .../bindings/thermal/spacemit,k1-tsensor.yaml      |  76 ++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi               | 101 ++++++++
 drivers/thermal/Kconfig                            |   2 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/spacemit/Kconfig                   |  19 ++
 drivers/thermal/spacemit/Makefile                  |   3 +
 drivers/thermal/spacemit/k1_tsensor.c              | 281 +++++++++++++++++++++
 7 files changed, 483 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251215-patchv2-k1-thermal-5ffb838fc1cc

Best regards,
-- 
Shuwei Wu <shuweiwoo@163.com>


