Return-Path: <linux-pm+bounces-43162-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IDuJ8/4nWmeSwQAu9opvQ
	(envelope-from <linux-pm+bounces-43162-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:15:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF2618BC17
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22E13305E82A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B13A0E8E;
	Tue, 24 Feb 2026 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="K/7ZhW2G"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB528643A;
	Tue, 24 Feb 2026 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960521; cv=none; b=nc/q2j82mOwBMow2VOK3LOTWoZx79LmN9gTgs/HN/fzRQ+MoOIzwL9yQ5ogwlM8Ai59ecILYD1VieD1JKCWj0FC5hKWD61jfL64bQ/YBRoRb+Ga7KooP1YYwiNpf1Orxtu5lP9UOCCtuS7bctsSgq3rdd7Ohm7GMeokYF0EU+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960521; c=relaxed/simple;
	bh=rAGbxnpKFT+1CkfQA0k7D/O3Tzw6DoraRHLRwf05jYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f4eFRIglZgQLz4tQHM5EvBPKrctSkbSlHdkJKh9fHmQK4JAJZagFXgTplIYWWZQmSBuokaad5BwfzHHkNo90H+0ZyH5AtVazbQ6RV7pKVxe2GQtH6whcnK187HxtbydRCWYaFqo1g7iKoP/O1cuYtYACd1oA9jFawwW+V/506SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=K/7ZhW2G; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 61EB326F67;
	Tue, 24 Feb 2026 20:15:16 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mpe8zN3WOjXT; Tue, 24 Feb 2026 20:15:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960515; bh=rAGbxnpKFT+1CkfQA0k7D/O3Tzw6DoraRHLRwf05jYk=;
	h=From:Subject:Date:To:Cc;
	b=K/7ZhW2GZ0V1fDSnhAM0XpeNYp744uS2Zvxo2xJCepgEvB02bgYUaH+9ypnBd67v3
	 R5YTLdTj9pXUUKQduo/mnwmMlW2SRXLBQ1hRy68F6SH1/TQ18u+VFX5j77QVQtfM0j
	 K2a0t6QAcOiLyUo5XBW/2nyNegpPv4SSNeGy0ZDN3OUdD55jfX09OXyEfs7OM+RdWU
	 pTxd8/rqketyPIEo5JqleCJC5m6m/Pe6eNPiz2UZdrvzBI7jFHxIFAQUg9EXH0LRk0
	 AqHbzJsN4kw8IyKgvzp6Kj+5+Mxqn7XgIE34a0enWsY/zhR5WTGkBgCK8cbymVphWG
	 xrXTMlYvdohaA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v3 00/13] Support for Samsung S2MU005 PMIC and its
 sub-devices
Date: Wed, 25 Feb 2026 00:45:02 +0530
Message-Id: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALn4nWkC/13MsQ6DIBSF4VcxzKXhgqB26ns0HSiC3kExYEkb4
 7sXTRzseE7yfwuJNqCN5FYsJNiEEf2Yh7gUxPR67CzFNm/CGZcAwGnkw5sxSacBDWVGVU6rlzb
 CkJxMwTr87NzjmXePcfbhu+sJtveAyjOUgDLaWAF12QrNTHNvMQbv56sPHdmoxI9cMeDqL+c5r
 2oHupJOlpU+5+u6/gAxAY8b6QAAAA==
X-Change-ID: 20251112-s2mu005-pmic-0c67fa6bac3c
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43162-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,disroot.org:mid,disroot.org:dkim,disroot.org:email]
X-Rspamd-Queue-Id: 1FF2618BC17
X-Rspamd-Action: no action

S2MU005 is an MFD chip manufactured by Samsung Electronics. This is
found in various devices manufactured by Samsung and others, including
all Exynos 7870 devices. It is known to have the following features:

1. Two LED channels with adjustable brightness for use as a torch, or a
   flash strobe.
2. An RGB LED with 8-bit channels. Usually programmed as a notification
   indicator.
3. An MUIC, which works with USB micro-B (and USB-C?). For the micro-B
   variant though, it measures the ID-GND resistance using an internal
   ADC.
4. A charger device, which reports if charger is online, voltage,
   resistance, etc.

This patch series implements a lot of these features. Naturally, this
series touches upon a lot of subsystems. The 'parent' is the MFD driver,
so the subsystems have some form of dependency to the MFD driver, so
they are not separable.

Here are the subsystems corresponding to the patch numbers:
dt-bindings - 01, 02, 03, 04, 05
mfd         - 05, 06, 07, 08
led         - 01, 02, 09, 10, 11
extcon      - 03, 12
power       - 04, 13

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v3:
- Remove "extcon" text from dt-bindings documentation (Rob Herring)
- Add connector for MUIC node
- Fix dt binding errors reported by robh's bot
- Fix kernel test robot const errors 
- Remove FIELD_PREP() values in register header file (André Draszik)
- Add max_register, volatile_reg, cache_type (André Draszik)
- Redo [v2 07/12] to NOT store the PMIC revision (André Draszik)
- Add a commit to fix DMA coherent mask in I2C PMICs
- Implement various flow changes in flash LED driver (André Draszik)
- Use device_for_each_child_node_scoped() (André Draszik)
- Fix CFI panic in devm_add_action_or_reset()
- Link to v2: https://lore.kernel.org/r/20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org

Changes in v2:
- Drop [v1 06/13], instead use regmap_irq_chip::get_irq_regs() 
- Remove references to driver in devicetree commits (Conor Dooley)
- Propagate errors of sec_pmic_store_rev() (André Draszik)
- Fix documentation language errors (Randy Dunlap)
- Link to v1: https://lore.kernel.org/r/20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org

---
Kaustabh Chakraborty (13):
      dt-bindings: leds: document Samsung S2M series PMIC flash LED device
      dt-bindings: leds: document Samsung S2M series PMIC RGB LED device
      dt-bindings: extcon: document Samsung S2M series PMIC extcon device
      dt-bindings: power: supply: document Samsung S2M series PMIC charger device
      dt-bindings: mfd: s2mps11: add documentation for S2MU005 PMIC
      mfd: sec: add support for S2MU005 PMIC
      mfd: sec: set DMA coherent mask
      mfd: sec: resolve PMIC revision in S2MU005
      leds: flash: add support for Samsung S2M series PMIC flash LED device
      leds: rgb: add support for Samsung S2M series PMIC RGB LED device
      Documentation: leds: document pattern behavior of Samsung S2M series PMIC RGB LEDs
      extcon: add support for Samsung S2M series PMIC extcon devices
      power: supply: add support for Samsung S2M series PMIC charger device

 .../bindings/extcon/samsung,s2mu005-muic.yaml      |  39 ++
 .../bindings/leds/samsung,s2mu005-flash.yaml       |  52 +++
 .../bindings/leds/samsung,s2mu005-rgb.yaml         |  34 ++
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   | 109 ++++-
 .../power/supply/samsung,s2mu005-charger.yaml      |  35 ++
 Documentation/leds/index.rst                       |   1 +
 Documentation/leds/leds-s2m-rgb.rst                |  60 +++
 drivers/extcon/Kconfig                             |  10 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-s2m.c                        | 354 ++++++++++++++++
 drivers/leds/flash/Kconfig                         |  12 +
 drivers/leds/flash/Makefile                        |   1 +
 drivers/leds/flash/leds-s2m-flash.c                | 429 +++++++++++++++++++
 drivers/leds/rgb/Kconfig                           |  11 +
 drivers/leds/rgb/Makefile                          |   1 +
 drivers/leds/rgb/leds-s2m-rgb.c                    | 458 +++++++++++++++++++++
 drivers/mfd/sec-common.c                           |  34 +-
 drivers/mfd/sec-i2c.c                              |  32 ++
 drivers/mfd/sec-irq.c                              |  74 ++++
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/s2m-charger.c                 | 213 ++++++++++
 include/linux/mfd/samsung/core.h                   |   1 +
 include/linux/mfd/samsung/irq.h                    |  66 +++
 include/linux/mfd/samsung/s2mu005.h                | 327 +++++++++++++++
 25 files changed, 2360 insertions(+), 6 deletions(-)
---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20251112-s2mu005-pmic-0c67fa6bac3c

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


