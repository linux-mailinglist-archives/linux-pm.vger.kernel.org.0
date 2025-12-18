Return-Path: <linux-pm+bounces-39688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A370BCCDDC8
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 23:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14C22302177B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E92E091E;
	Thu, 18 Dec 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4N4329j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B5149E17;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766098183; cv=none; b=upf+kFYSLiD+Z9StBIYs7ei4Xe4ioSBM1Bcy96O7Ytkp5RmHx1EuiKw0/PPx7/2x2TtNQX0P2bMRvMh+L/R1dHe4Hd77rlWDRfFYwuGguz/rMuqgLFOOHr9eno2aQ5wvO2mqjQABc8anJHpIGK/CeU7/abZ1FwgYYueHtY4EGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766098183; c=relaxed/simple;
	bh=pC82eqfu76ux0epNJS8FANzPY3la5Ggo/hStiOoB+QU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tFgNA6sgtipfEnWHBYUnAvy6XIvFi+nkbL4f0APqw3lCWA0web1J+Kylc4sH7luxXSr3zWclqc2P7ew64FDhj3AJTIxG1+bvQmAwYvX/Hn0z6i3Xhi1mQxmaVQzERCvg3XjcYyL/hSRjU23foU7kMoiB8CwDfdHo6dLchpbxspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4N4329j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DCDAC4CEFB;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766098182;
	bh=pC82eqfu76ux0epNJS8FANzPY3la5Ggo/hStiOoB+QU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=P4N4329jBsieS0MZQ6LxlPi8MMKSXiCmyyfbw9FmN41j0alMPNg5l+ifYgk+q1GHX
	 LnjJ4qx73Xf0ZRsQuF7ic1ardmZvE3UDa9tQY6Cz2y4HWRsZtfXp0jlHnvW/uONxMK
	 le4L2bySs1j+ejnZ/6etp7K/gzO93zCl7IwcbiR5x+0OgLs1K+vVHMDHSv/oRK4sQh
	 irIb//pFreKfo8sSg8jUC0xWABuXFwo9TqZkvrJuA0Y77l3vWPdJw8hkfT1CIzDGjm
	 9DjZPxdYM+AgydzV8Tpd+IeFCcn4jJjAIr6/D0soIBSvffoJOnTm7Mu/+MxF3z2QNs
	 QEQzWBfPBHrzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF7D711C7;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v2 0/5] Introduce MAX77759 charger driver
Date: Thu, 18 Dec 2025 22:49:05 +0000
Message-Id: <20251218-max77759-charger-v2-0-2b259980a686@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOGERGkC/2WNQQ6DIBREr2L+ujTyK2C76j0aF6IfJKlioCE2h
 ruXmu66fDOZNztECo4i3KodAiUXnV8K4KmCYeoXS8yNhQFrFJzXgs39ppQSV1bqYCmwVqCWKEc
 peQ9ltgYybjuUj67w5OLLh/fxkPg3/cnw8i9LnNVMaqRGt0YZ0dyt9/ZJ58HP0OWcP7Rb5wGxA
 AAA
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
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766098181; l=2751;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=pC82eqfu76ux0epNJS8FANzPY3la5Ggo/hStiOoB+QU=;
 b=lbIcP1LKHq4okfWrT5bO3wyYxZA3KbK+ci7CLSJci4yPIY5/UBu485YUDYXZH2kYUaC/ilJUh
 n7d3iDhvCvzB4ythXTWSquSkPeS7zU2RDKTAZblumV4kLTUkXOMmcc+
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
      dt-bindings: mfd: maxim,max77759: add charger child node
      dt-bindings: usb: maxim,max33359: Add supply property for vbus
      mfd: max77759: add register bitmasks and modify irq configs for charger
      power: supply: max77759: add charger driver
      usb: typec: tcpm/tcpci_maxim: deprecate WAR for setting charger mode

 .../devicetree/bindings/mfd/maxim,max77759.yaml    |  33 +
 .../devicetree/bindings/usb/maxim,max33359.yaml    |   4 +
 MAINTAINERS                                        |   7 +
 drivers/mfd/max77759.c                             |  94 ++-
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/max77759_charger.c            | 754 +++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h               |   1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |  54 +-
 include/linux/mfd/max77759.h                       | 202 +++++-
 10 files changed, 1102 insertions(+), 59 deletions(-)
---
base-commit: 39f90c1967215375f7d87b81d14b0f3ed6b40c29
change-id: 20251105-max77759-charger-852b626d661a

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



