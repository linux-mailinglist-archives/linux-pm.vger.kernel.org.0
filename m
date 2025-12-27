Return-Path: <linux-pm+bounces-39956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBDCDF263
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 01:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E7BD3006F76
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD343A1E9A;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjQQ0qIU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311B625;
	Sat, 27 Dec 2025 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766793899; cv=none; b=kyoOGBAfWmtOgWY1Xq413LCc/yn0QKuSNi5QJaPl+PonpQA6PoMpWVIOHwmj9vygIXvabwXLgMRvo87q6KcNnrS68+HIDjZAMCdLBe6ISUFufvWzOzrwflpC0fROO8jNLDhHNWDWQRInua18XTyiXPaMojUM2tsD8xR5AnXk50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766793899; c=relaxed/simple;
	bh=l+eK+53HFS6Nf1N+WzqWh69/CWIpr9CIKF2aOQzhUPE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UTbJsj0LgPe67/MqCQm9l5ci7miw/o8UAoJKxV8E5+/p4X8zi8xcgiXbJLMyFJ76JtsJyulSHnUtdp/sHoqZGGX0qrRzMFMNGwa0yJVAMLgXcrEnHSht9x5knBObPU0ZUjYZNn3SVHgBA6et1bJtvq6tsbjVMH8yE1JmZfBdHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjQQ0qIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1A4AC4CEF7;
	Sat, 27 Dec 2025 00:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766793898;
	bh=l+eK+53HFS6Nf1N+WzqWh69/CWIpr9CIKF2aOQzhUPE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qjQQ0qIUhWW8aOCRi5zJ/5DhGTXTBop1xqdqUVTkTSgfmmPK2JTAGt447hxrJIEev
	 bw759ytgrtFQeMAGiOP92vvIFUsQ5I3yh0ppgpxXexT0YtQodXauWZ/I02qC1nh2bI
	 dKdXNxOL31FhMToP1Z/rlP7ESrf/xVDfOo/5xj46tfnDc9kl1LpuiLxPqtDUgObwwu
	 wdlxBIrYNkKnAKg4Blscs7yY3CvxXqpUlNHQv6/AhVGz+NhqZEnjLoU59t0cjyEOus
	 EwoF5K2p5Li0g7o/tijVjY0SckGsMJNzJ9PLli/VzWrPJjv6dUzxLaA8zWtrBbQTjR
	 OtE/S7BHwHScw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9CE8FDAF;
	Sat, 27 Dec 2025 00:04:58 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v3 0/5] Introduce MAX77759 charger driver
Date: Sat, 27 Dec 2025 00:04:20 +0000
Message-Id: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIQiT2kC/23NSw6CMBCA4auQrq1pB/rAlfcwLgoMpYlQ05oGQ
 7i7hZgYo8t/JvPNQiIGh5GcioUETC46P+UoDwVpBzNZpK7LTYCB4JwJOppZKSVqmtfBYqBaQCN
 BdlJyQ/LZPWDv5p28XHMPLj58eO4fEt+mbwzKXyxxyqhsAKtG96oX1dl6b294bP1INi3BRwCu/
 wiQBWhA1LVmRmr5Jazr+gJoktcj8wAAAA==
X-Change-ID: 20251105-max77759-charger-852b626d661a
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766793897; l=3010;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=l+eK+53HFS6Nf1N+WzqWh69/CWIpr9CIKF2aOQzhUPE=;
 b=v8dBC0vdvLgYRAJ47ZiiomwUGFw58iVgkYJp8pVD8h8B/j98E/xV5G2OAoJkxhHyABv8ppu86
 +eTiiO+nyNoBUrO0p1xSNVV8iuFkwjHAduzkWjeHkoNWM4+jH9ereWg
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

MAX77759 PMIC is used in Pixel 6 and 6 Pro (Oriole/Raven) boards.
One of the functions of the MAX77759 PMIC is a battery charger. This
patchset introduces a driver for this function. One of the unique
features of this charger driver is that it works with a USB input where
the Type-C controller is TCPCI based.

Changes to the board files will follow soon once this patchset is reviewed.

For reference to the MAX77759 MFD based patchset (present in upstream):
https://lore.kernel.org/all/20250509-max77759-mfd-v10-0-962ac15ee3ef@linaro.org/

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
Changes in v3:
- Had incorrectly folded the charger sub-device with the pmic parent.
  Corrected it. (Krzysztof Kozlowski)
- Link to v2: https://lore.kernel.org/r/20251218-max77759-charger-v2-0-2b259980a686@google.com

Changes in v2:
- Fold charger binding in maxim,max77759-charger.yaml to its parent
  node. (Krzysztof Kozlowski)
- Renamed regulator supplier & consumer. (Krzysztof Kozlowski & Heikki
  Krogerus)
- Removed explicit setting of irq trigger types in max77759 driver.
  (André Draszik & Krzysztof Kozlowski)
- Complete bit definitions for IRQ registers. (André Draszik)
- Consolidate all bit definitions for charger IP in mfd/max77759.h.
  (André Draszik)
- Modify the handling of charger IRQs such that regmap IRQ chip handles
  masking, de-mux and acking of interrupts. (André Draszik)
- Remove unused macro definitions relating to Charger modes in tcpci
  maxim driver (André Draszik)
- Add dependency on Regulator class in Kconfig definition for max77759
  chg. (Kernel Test Robot)
- Link to v1: https://lore.kernel.org/r/20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com

---
Amit Sunil Dhamne (5):
      dt-bindings: mfd: maxim,max77759: reference power-supply schema and add regulator property
      dt-bindings: usb: maxim,max33359: Add supply property for vbus
      mfd: max77759: add register bitmasks and modify irq configs for charger
      power: supply: max77759: add charger driver
      usb: typec: tcpm/tcpci_maxim: deprecate WAR for setting charger mode

 .../devicetree/bindings/mfd/maxim,max77759.yaml    |  16 +-
 .../devicetree/bindings/usb/maxim,max33359.yaml    |   4 +
 MAINTAINERS                                        |   6 +
 drivers/mfd/max77759.c                             |  91 ++-
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/max77759_charger.c            | 764 +++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h               |   1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |  54 +-
 include/linux/mfd/max77759.h                       | 202 +++++-
 10 files changed, 1091 insertions(+), 59 deletions(-)
---
base-commit: dd9b004b7ff3289fb7bae35130c0a5c0537266af
change-id: 20251105-max77759-charger-852b626d661a

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



