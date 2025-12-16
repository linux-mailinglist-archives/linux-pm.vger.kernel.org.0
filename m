Return-Path: <linux-pm+bounces-39610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1413CCC08F4
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 03:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A78CE301EFA6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 02:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE762BE7C3;
	Tue, 16 Dec 2025 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ps1CQMlY"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DCC2C0F93;
	Tue, 16 Dec 2025 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765850603; cv=none; b=abZ4ztB0CUFnGL8PEQmq0sHrLEsUkcGoU+UrEjhQKSfq3yVDFPKRBbkipTJ3MdmQ96qmii8arvm+URuVgUCjb9i7J7tVyANm7+hPQBYGYGXtLni6/CSEiRCjt40R04kjnt6/M3uJlkloCVkJvdIGL/qAmctT55BnKzTlp0zMUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765850603; c=relaxed/simple;
	bh=4JEux+wemjhe5lRBTJMYmOo5JbXHIEj6+c2dZiB74RM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZMXumIcsD7ltmt2ibQ+BwNzwS+Ku4UovlJYIhNkejPSnTsukgy5U3KnGO78m3+mLiZBsf+AaSl+j5e+XbLNFZpsnc7EFyJf/6jEg0ki2oRI3AqRaoVMjVkRUT1N4/vkHd+69BOhJK6dSWpqLujQubJqumSSGqKJbkjlm/ZkkCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ps1CQMlY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type:To; bh=O5iu4yIsSO9ZWZlJQVFULBolHuSozJ/OSd+ZcqTsLBc=;
	b=ps1CQMlYZwgVk3oj5+edqK156CDZtUI9pGrvMF1uF6vjIJxpC87bATBL/2fRun
	MDB0q98WA0avy5aGORlr/0zzb3gBkhgtldssJTABKPCbWnAEWJ29oct7NN/0HlcC
	WYTG86EJXD29xaB9mWdQF9VJOsUxlCesFVIH5/rm1Imx8=
Received: from [192.168.10.1] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXUu97vUBpOmJ5Ag--.29S2;
	Tue, 16 Dec 2025 10:01:34 +0800 (CST)
From: Shuwei Wu <shuweiwoo@163.com>
Subject: [PATCH v2 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC
 thermal sensor
Date: Tue, 16 Dec 2025 10:00:34 +0800
Message-Id: <20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEK9QGkC/x3MQQqEMAxA0atI1hOYRAriVQYXnZja4IxKK0UQ7
 25x+Rb/n5A1mWbomxOSFsu2LhX0akCiXyZFG6uB3+yIyeHmd4mFcSbco6a//6EL4du1XRASgRp
 uSYMdz/QDhWG4rhtSmDr3aAAAAA==
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765850492; l=1390;
 i=shuweiwoo@163.com; s=20251125; h=from:subject:message-id;
 bh=4JEux+wemjhe5lRBTJMYmOo5JbXHIEj6+c2dZiB74RM=;
 b=IBMt8PFGdohtMqhWB2UmoRRcAUFBvDkXtpCpUypHi17BMGo7NcoyJ6EagYHfgnr1dwBZrT80M
 2DUUw/J5whNA+TmA6JdliHQpyalK89xB+W/Gj/STy5B/OfzU8fA73x2
X-Developer-Key: i=shuweiwoo@163.com; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-CM-TRANSID:_____wDXUu97vUBpOmJ5Ag--.29S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw43JF4rJr4rKw13GFyDWrg_yoW8JF47pF
	s8ur95Cr1DGF4xJw4fur1UuFZxtF4rtFy2gr1Igw1YqF15CFy3Jr98try5Xa48Xry3JFyj
	vrsrGr45CF1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi8sq_UUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/xtbC5B-4h2lAvX+0VQAA3O

Introduce support for the on-die thermal sensor found
on the SpacemiT K1 SoC.

Include the device tree binding documentation in YAML format, the
thermal sensor driver implementation, and the device tree changes to
enable the sensor on K1 SoC.

---
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
 drivers/thermal/spacemit/k1_tsensor.c              | 283 +++++++++++++++++++++
 7 files changed, 485 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251215-patchv2-k1-thermal-5ffb838fc1cc

Best regards,
-- 
Shuwei Wu <shuweiwoo@163.com>


