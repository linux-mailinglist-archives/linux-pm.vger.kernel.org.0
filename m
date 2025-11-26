Return-Path: <linux-pm+bounces-38697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA01AC899C8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 12:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2558735575B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934A73254B3;
	Wed, 26 Nov 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="En1Pf8h/"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305162E7BC2;
	Wed, 26 Nov 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158216; cv=none; b=Mgayg0JbTIr55yQIFk7sy2D/wGb1rNywHj6NpXYdNTK0JmTLuVeb06Ohhsg856hKoVixFa6G/wC36zIp/5SdjGECLz/T+LcBIyOI8uYEw1iXwcpf/9qRP3hUmQljcMNKxqSkvAa7aOP5HzjmcvvXMhy6tXZLQGFXFNZi00B3kig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158216; c=relaxed/simple;
	bh=6Bc8ctkWf0MlDErFTWLIrGe04KSla5uK/67iOY4E08w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mbDmE/bjX0L0RFX2EQiZ+SeGyYwulhjcOUXZhTxcntouTtHO8nsGdwPQoBuP2PjupQBhxDXVL0RmMgMEDtqvfhfT84Nq3BYXjpKng8IvCHBlBwbkIPk3wdsOOk1/eAB8lhOi7T/2yAm2cvCW5trEyIR1iA8XRhSNc6YgqT+3uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=En1Pf8h/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type:To; bh=Ufeb2Y1qdBth3LcT17BVdapoAoJh2TGcN1TWOhiBKf0=;
	b=En1Pf8h/dboQ57E/Xg0GvL4gWJTIP0wuL/u6Ci9gG9Qho59PJDIOomubQhmhWf
	PD8kyMXDdmsWkDxkxWDZGSu+Z+coheekooSe9hCRIaGTw0/NVohNAGfw70A+AOlW
	fR4+VgeS7DHPaMbXoB5w+m0Def6yMsr2euRr5wGoLpQG4=
Received: from [192.168.10.1] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBnveN26iZpJOi_FQ--.56535S2;
	Wed, 26 Nov 2025 19:54:32 +0800 (CST)
From: Shuwei Wu <shuweiwoo@163.com>
Subject: [PATCH 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC
 thermal sensor
Date: Thu, 27 Nov 2025 02:44:06 +0800
Message-Id: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZKJ2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyMT3SQT3WxD3ZKM1KLcxBzd1ORESwOzVLOUFPNEJaCegqLUtMwKsHn
 RsbW1AH3F1YdfAAAA
X-Change-ID: 20251124-b4-k1-thermal-eca906e6dd7a
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764182662; l=1444;
 i=shuweiwoo@163.com; s=20251125; h=from:subject:message-id;
 bh=6Bc8ctkWf0MlDErFTWLIrGe04KSla5uK/67iOY4E08w=;
 b=ewyJRJ6JRELmsRZPHaJEV8DBkEtk7N+18zJKoIBSbmPdtwi4m63YqOpjVgAIPRh4VI1SCd20c
 qSkdZ2ZYXZFDhOZNrSanVi6kHXeT8TrSF8d8Cdcb6eq1OFiZ7rMGVXs
X-Developer-Key: i=shuweiwoo@163.com; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-CM-TRANSID:PigvCgBnveN26iZpJOi_FQ--.56535S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw43JF4rJF17GF47Ww1xKrg_yoW8Gr4xpa
	1Uurn8Cw1DGFs3Jw13uF1DCFZ8tr4ftFy3Xrn3Kw15tr45GryfJrW5Kr15W348GrWvga1D
	ArsrCr4rCr1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRBOJwUUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/xtbBzxUSjmkm5A563gAAsH

Introduce support for the on-die thermal sensor unit (TSU)
found on the SpacemiT K1 SoC.

Include the device tree binding documentation in YAML format, the
thermal sensor driver implementation, and the device tree changes to
enable the sensor on K1 SoC.

Test logs:
Hardware: OrangePi-RV2 integrates SpacemiT K1 SoC
Kernel: 6.18.0-rc4 mainline

Verified that all five thermal sensors are registered and reporting
valid temperatures.

$ cat /sys/class/thermal/thermal_zone*/type
soc-thermal
package-thermal
gpu-thermal
cluster0-thermal
cluster1-thermal

$ cat /sys/class/thermal/thermal_zone3/temp
28000

Dynamic threshold and interrupt tests passed via sysfs trip_point
manipulation.

---
Shuwei Wu (3):
      dt-bindings: thermal: Add SpacemiT K1 thermal sensor
      thermal: K1: Add driver for K1 SoC thermal sensor
      riscv: dts: spacemit: Add thermal sensor for K1 SoC

 .../bindings/thermal/spacemit,k1-thermal.yaml      |  76 +++++
 arch/riscv/boot/dts/spacemit/k1.dtsi               | 101 +++++++
 drivers/thermal/Kconfig                            |  14 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/k1_thermal.c                       | 307 +++++++++++++++++++++
 5 files changed, 499 insertions(+)
---
base-commit: f5f2e20b1cbc5f9ea20b372d15967b24921ede19
change-id: 20251124-b4-k1-thermal-eca906e6dd7a

Best regards,
-- 
Shuwei Wu <shuweiwoo@163.com>


