Return-Path: <linux-pm+bounces-42625-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGuvMnjoj2lqUQEAu9opvQ
	(envelope-from <linux-pm+bounces-42625-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 04:14:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692A13AD90
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 04:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F616302EEAB
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 03:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617AE28FA9A;
	Sat, 14 Feb 2026 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htf5QPpR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBD5CDF1;
	Sat, 14 Feb 2026 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771038831; cv=none; b=Y+AIqdxwryh7YoDIHzXM/JVKKcZrVMhxHusNXHw4IMieaim1p2YZToEQeJTiLl8goDpmRgv1B+xcjl2Mr3p3HYTqZXCPpxbYeAbQCBFeQuRRc6iqgSYtT4d4IEBMEVqS9U5An/0FasTQfqjF8iSf6m7i9UVGoB8q8eUipCa1qaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771038831; c=relaxed/simple;
	bh=AveWrvXusFxamxdRx0C3nhvuASpHXQtiNHJ9W6SVTD0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=USdDDmYrzueVVym651RFl47vsBwf0R0kkmLq3EArRAxZYfIoEIq2uDeqAjw7nqul8yEVj4FfN/93R1UygrP1gC4hb02CCMz0wW5UCqfFgeTZTFFbB8UZxBTGfUF+YgBYJklZe5Mmwen9ucUhQhfeqTWkJEnG7EquYHi+mHw7EMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htf5QPpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE412C116C6;
	Sat, 14 Feb 2026 03:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771038830;
	bh=AveWrvXusFxamxdRx0C3nhvuASpHXQtiNHJ9W6SVTD0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=htf5QPpROUREoUzab+2Ap5vldjgcVTmZAzlsCvRDPOb0HZVPE1d5fq6+YGwi6ZV56
	 ZmSZ4rF/boBnyP2L0XdVHXRsLgiR14urgfgntZ9GcruWFc94ku3cUWRzXQoPOgDjqb
	 hxUnI+EbCPwWmT2C5jgu7QepBudvscP8mIIPmWhJgn3Xl4JzEJ5hNstbEBUybgU0Ae
	 hS9OXPful/WXcsbbQnT1y2nIcXeR1iZ3EojR1/ZUD9cKvuTk5JTHrb+sxmE6ZBqzrJ
	 7NW7d1KWZyqkxa+FO635Fs4kCFqIRn6zip+Blo7dnwhrBjHXhrpicgXefp+twQ2XFR
	 u2OpC8NFhMQuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912A2EF99D5;
	Sat, 14 Feb 2026 03:13:50 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v6 0/6] Introduce MAX77759 charger driver
Date: Sat, 14 Feb 2026 03:12:36 +0000
Message-Id: <20260214-max77759-charger-v6-0-28c09bda74b4@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACToj2kC/23QwW7DIAwG4FepOI8JDDaw095j2gESJ0VaS0Wmq
 FOVdx+pNnVTcvyN/NnmJiaumSfxcriJynOecjm3QE8H0R3jeWSZ+5YFKECtFcpTvDrnMMj2XEe
 u0iMkAuqJdBSt7VJ5yNc7+fbe8jFPn6V+3SfMeq3+YGC22KylkpSAbfKDG9C+jqWMH/zclZNYt
 RkeAmi/I0ATIAGG4FUkTxvB/BHA7QimCWiZyA7YxQAbwf4KpNoSO4JdrwgWjO18z73eCPgQQO3
 9AzYhoTIBjaOIwz9hWZZvRNwDGLkBAAA=
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
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771038829; l=5661;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=AveWrvXusFxamxdRx0C3nhvuASpHXQtiNHJ9W6SVTD0=;
 b=c10MZSi5/tRPt3QQmxGUNygXPSvwX6fMeJjn0bye+BqKRxMW4brk9JP8Q2zStXD/7JS1HUKHP
 Xaq6h0phelVCzdJmfF8dIaIkMnOHrNd4C++uP8YyxiRuBPMso6gvYCs
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42625-lists,linux-pm=lfdr.de,amitsd.google.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[amitsd@google.com]
X-Rspamd-Queue-Id: 7692A13AD90
X-Rspamd-Action: no action

MAX77759 PMIC is used in Pixel 6 and 6 Pro (Oriole/Raven) boards.
One of the functions of the MAX77759 PMIC is a battery charger. This
patchset introduces a driver for this function. One of the unique
features of this charger driver is that it works with a USB input where
the Type-C controller is TCPCI based.

Changes to the board files will follow soon once this patchset is reviewed.

For reference to the MAX77759 MFD based patchset (present in upstream):
https://lore.kernel.org/all/20250509-max77759-mfd-v10-0-962ac15ee3ef@linaro.org/

Dependency list for patches (directionality indicates depends on):
[6] -> [5] -> [4] & [3]

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
Changes in v6:
-  Linear Range usage (André Draszik):
  - Dedicate individual arrays for inlim, chgcc & chg_cv_prm to simplify
    code.
  - Use numerical values instead of macros for linear_range array init.
  - Remove macros defining current and voltage limits due to above.
  - Didn't use Reviewed-by tag for Patch 3 due to the above.
  - Add new linear_ranges api to leverage it for obtaining selector
    values.
  - Improve voltage and current getters and setters functions by leveraging
    existing and new linear_ranges API.
- IRQ related changes (André Draszik)
  - Dedicated names for individual irqs.
  - Refactor irq handlers.
  - Ratelimit prints
- Retry mechanism (André Draszik):
  - Initialize error retry counter to 0 when psy work is scheduled on a
    new notifier event.
  - Protect the counter using a lock.
  - Add appropriate prints.
- Link to v5: https://lore.kernel.org/r/20260203-max77759-charger-v5-0-b50395376a5f@google.com

Changes in v5:
- Use linear_range library instead of reinventing it. (André Draszik)
  - This requires a selector_max value so modified mfd/max77759.h to
    include it for CHGCC and CHG_ILIM.
  - Removed "reviewed-by" for Patch 3 (mfd) due to above
- Use asnyc probe type. (André Draszik)
- Retry mechanism for psy_work. (André Draszik)
- Minor nits (André Draszik):
  - Use named initializers for instantiating structs.
  - Use static qualifier for `psy_name` variable.
  - Refactor if-else ladder to remove else handling if return in prior
    "if" loop.
  - Remove redundant `unlikely`.
- Link to v4: https://lore.kernel.org/r/20260121-max77759-charger-v4-0-694234c8ded1@google.com

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
Amit Sunil Dhamne (6):
      dt-bindings: mfd: maxim,max77759: reference power-supply schema and add regulator property
      dt-bindings: usb: maxim,max33359: Add supply property for vbus
      mfd: max77759: add register bitmasks and modify irq configs for charger
      lib/linear_ranges: Add linear_range_get_selector_high_array
      power: supply: max77759: add charger driver
      usb: typec: tcpm/tcpci_maxim: deprecate WAR for setting charger mode

 .../devicetree/bindings/mfd/maxim,max77759.yaml    |  16 +-
 .../devicetree/bindings/usb/maxim,max33359.yaml    |   4 +
 MAINTAINERS                                        |   6 +
 drivers/mfd/max77759.c                             |  91 ++-
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/max77759_charger.c            | 768 +++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h               |   1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |  54 +-
 include/linux/linear_range.h                       |   3 +
 include/linux/mfd/max77759.h                       | 176 ++++-
 lib/linear_ranges.c                                |  36 +
 12 files changed, 1108 insertions(+), 59 deletions(-)
---
base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
change-id: 20251105-max77759-charger-852b626d661a

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



