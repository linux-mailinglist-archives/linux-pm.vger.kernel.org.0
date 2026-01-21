Return-Path: <linux-pm+bounces-41202-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCmcJCklcGlRVwAAu9opvQ
	(envelope-from <linux-pm+bounces-41202-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:00:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B44EC94
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 02:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E9AA8AAC15
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8E72DF143;
	Wed, 21 Jan 2026 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4eRzsAb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E11DFD96;
	Wed, 21 Jan 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957214; cv=none; b=jf57ElDMUYQ2oAbKMXzKia9VLGwZAk/b17CXE0A7hmTAkmQCz21lxc1FnAvcUiuI6eZqttDCLsQUpZDsts1p+WSH0nRInws6jI9xWCvzRVMtMFR3GKxFeoGc+499jCiK18OyhyIDc1lDCO/+3wtPxQ6E5UCMZWWqBuj7nXUf/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957214; c=relaxed/simple;
	bh=SFo9t6l3/bhf9aZgOhzuecaeoOY+SMMUkhye3rCxRng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QIvfxBiD1JX2lKQjr00gTx8HgABgYZ45w8SVpHt71bTYbCw3d21gkjDPYRx/QVbZIDdHCN/oJVgJQkbPjFveWRbzjMGS1WBefPvA9WlRFUdvNzZLgksH3JVlwb50323gcuu2pwvsNNQtL+NHgHOp8kEZiqSewbfNmP4qDsVxkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4eRzsAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D997C16AAE;
	Wed, 21 Jan 2026 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957214;
	bh=SFo9t6l3/bhf9aZgOhzuecaeoOY+SMMUkhye3rCxRng=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=S4eRzsAbzwvs2ntfsdUs7fjUzEWQkhWjk1Qy3l3lhk53nh1gUoOFyzNQvA1ODK+FJ
	 QF/RFmUn1CwLEuoE2RTboul244TNTUKkV0IoLyWsRCqdrblBKYqj+WwlazaN0L8ET4
	 pMc8pgOyTE0a9Pm6xefiaZnZZ6sDLGj8IbXNbrERp55JN4j/HRIuGnkj8vj7cW+o65
	 M5cmG3mR3K4tOKXYI1pnSna9PZnLSB7ZysVtyLR1mrNo7Gm70Uudu8K07fFFXWdjjR
	 ajmO3iR5VAb+mTdLVmN4jLOfUlRVgSRQ6IvM9GLdkVSwvZy1XcNjQfAzKb55BpxyLT
	 GfgVZlbodDgzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B3BD262AF;
	Wed, 21 Jan 2026 01:00:14 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v4 0/5] Introduce MAX77759 charger driver
Date: Wed, 21 Jan 2026 00:59:34 +0000
Message-Id: <20260121-max77759-charger-v4-0-694234c8ded1@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPYkcGkC/23NwQ6CMAyA4VcxOzvDytYNT76H8TCgwBJhZhiCI
 by7g5iogePfpl8n1lNw1LPzYWKBBtc738WQxwMrGtvVxF0Zm0ECSohE8daOWmuV8bgONQVuFOQ
 IWCIKy+LZI1DlxpW83mI3rn/68Fo/DGKZfjBIt9ggeMIxB5K5qXSl5KX2vr7TqfAtW7QBvgIIs
 yNAFCAHlWUmsWhwI6Q/AugdIY2CkoQoK1XYDP6EeZ7fnDUeDTUBAAA=
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768957213; l=3693;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=SFo9t6l3/bhf9aZgOhzuecaeoOY+SMMUkhye3rCxRng=;
 b=g5zA+uB4d1Wa/5ShS5DQUoY2BLnVMD4oc3yrZDuqc8GmN5IkqD3Qy22CuDGsNfBTSRi5mXIzJ
 tKPFsrYfD+sDOlg+u2VTYxFR8sMRxpc90iDxyqIEcPjqMqU/CdECDiI
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41202-lists,linux-pm=lfdr.de,amitsd.google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[amitsd@google.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 003B44EC94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v4:
- Removed a stray tabspace in mfd/max77759.h. (André Draszik)
- Fixed the following issues in Patch 4/5 (André Draszik):
  - Re-order Kconfig entry
  - Refactored to not use global variable
  - Use of clamp() to clamp values instead of duplicating logic
  - Return IRQ_NONE for unhandled irqs or error conditions
  - Remove debug messages in irq handler
  - Refactor code to use dev_err_probe in *_init_irqhandler()
  - Remove unneeded irq_flags
  - Check return values of regmap ops
  - Other nits like newlines, not using greedy init, using print stmnts
- Link to v3: https://lore.kernel.org/r/20251227-max77759-charger-v3-0-54e664f5ca92@google.com

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
 drivers/power/supply/max77759_charger.c            | 737 +++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h               |   1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |  54 +-
 include/linux/mfd/max77759.h                       | 202 +++++-
 10 files changed, 1064 insertions(+), 59 deletions(-)
---
base-commit: b71e635feefc852405b14620a7fc58c4c80c0f73
change-id: 20251105-max77759-charger-852b626d661a

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



