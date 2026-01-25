Return-Path: <linux-pm+bounces-41417-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBrEDyQVdmkfLgEAu9opvQ
	(envelope-from <linux-pm+bounces-41417-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 14:05:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3F80932
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 14:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E1930087BE
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7966231AAAF;
	Sun, 25 Jan 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Ngo5pY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537681D88B4;
	Sun, 25 Jan 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769346335; cv=none; b=DC92N5zNuKNpt/33ecdjhSer1e/F7nRhydoyHCVEcsCn6BxKddwRVUQxt08USIwEx1MtenYFnxOOtNji5TilTwbmx3MXhe1jdvMWgXnvQCDev3UMyzrkzU728lyq3g5ai6iqlmQmChFgaG2mXPnuZotvDO2wn12IvHtMEJXZYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769346335; c=relaxed/simple;
	bh=3nVJfHoPeIK1kwbJp85jAtXyh/3kl/mn5dtmy7TOuao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JmzTeAxyz06J9EeE+S0gPlLYrWZ9zgvuzDicoBwbUyfxIkhIPaj2n7TZXBGPLTrj/E9/YA6P9oXFiiLtiE+WmBcv2d3FYISeYYb5cTZ5/dZUBmthIYMtdSAqHWQBJQgHzTLOkcviA4G03D69F3jCwr98HDfMopulhCZ6niGRYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Ngo5pY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9D50C4CEF1;
	Sun, 25 Jan 2026 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769346334;
	bh=3nVJfHoPeIK1kwbJp85jAtXyh/3kl/mn5dtmy7TOuao=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l5Ngo5pYqzrq0r4RytKaCaq38TZovoV1p/C2/tuzvHGsorbTOJ87tgWUS+L5V2/18
	 OJFDRp6hmHAJhnrucJqKPnEgFosKUwOPLcMWIVSE8kS8vSqkgM2PclZ90XCMF72Vyu
	 0kMDYcNE76EfSG5HtzZPoCfFM3jzj1RAShpdX7KQATmyA5rTXUJeKSQhcl4R6XGtXs
	 QYTft2nMKrnBp4OKPaqFim438ZIE2tQUrsUh6bybBpxRKcZhnNuAlnRUDwG/lOG+H3
	 6SnMtuBlYNpaf53aYa4Grwf+awtMyoPXFhctJAmGD/+bnRK3aQEI3KrA0cMOfYcgpc
	 fff7xUQxFtPEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FB0E63CA2;
	Sun, 25 Jan 2026 13:05:34 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH v4 0/2] (no cover subject)
Date: Mon, 26 Jan 2026 00:05:19 +1100
Message-Id: <20260126-b4-macsmc-power-v4-0-aa2a682ca650@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABAVdmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNT3SQT3dzE5OLcZN2C/PLUIt2kJGMDYwvLVAPTNEMloK6CotS0zAq
 widGxtbUAXSi/4mEAAAA=
X-Change-ID: 20260125-b4-macsmc-power-bb30389e05f1
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>, Joey Gouly <joey.gouly@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769346333; l=3237;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=3nVJfHoPeIK1kwbJp85jAtXyh/3kl/mn5dtmy7TOuao=;
 b=f9YdilHx6WpwE5bb46PjUgNU7L08sOqM5p/8Q9JPHM5B9FvkIYtQmOg20dkPEpoBQEwM58ZLu
 dqpUzgNEQk5B6TfMg3i/+YeSnSVeYF8d3cXQQgLZoiuhNNf0cUgDHnI
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41417-lists,linux-pm=lfdr.de,michael.reeves077.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_REPLYTO(0.00)[michael.reeves077@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,marcan.st,arm.com];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66D3F80932
X-Rspamd-Action: no action

This series adds a power supply driver for the Apple SMC found on
Apple Silicon devices. This allows the kernel to report AC status,
battery charging status, and power metrics, and modify the charging
behaviour.

The first patch adds the driver itself, and the second patch wires it
up to the MFD core.

The driver is based on an original out-of-tree implementation by
Hector Martin. It has been refactored by myself for upstream inclusion, 
including support for newer SMC firmwares, devices without batteries,
dynamic property detection and improved state management, among other
things.

This series is based ontop of the current linux-next at time of writing,
the exact commit hash is listed below.

Tested on: Apple M3 (MacBook Air, J613)

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
Changes in v4:
- Restore Hector Martin as primary author for the series.
- Restore downstream Co-developed-by and Signed-off-by tags.
- Add Reviewed-by: Sven Peter <sven@kernel.org>.
- Simplify MFD patch authorship and remove redundant tags.
- Fix probe return value being overwritten by devm_work_autocancel.
- Return -ENODEV in probe if neither battery nor AC adapter are found.
- Add bounds check for nprops against MACSMC_MAX_BATT_PROPS.
- Refactor macsmc_battery_set_charge_behaviour to remove unnecessary resets.
- Improve critical_work shutdown flags and remove return.
- Add comments explaining SMC key firmware history and flag meanings.
- Clarify event ID descriptions and restore BSFC flag comments.
- Remove redundant dev_dbg logs for missing battery or AC.
- Link to v3: https://lore.kernel.org/r/20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com

Changes in v3:
- Rebase on top of latest linux-next
- Drop charge control threshold properties.
- Switch to devm_work_autocancel() for critical work.
- Add platform ID table and remove MODULE_ALIAS.
- Simplify property array management in struct macsmc_power.
- Improve probe error handling and device pointer usage.
- Minor style and indentation fixes.
- Link to v2: https://lore.kernel.org/r/20260109-b4-macsmc-power-v2-0-93818f1e7d62@gmail.com

Changes in v2:
- Added Reviewed-by: Neal Gompa <neal@gompa.dev> to all patches.
- Fixed Makefile alignment by using tabs for the macsmc-power entry.
- Upgraded physical battery exhaustion log level to EMERG.
- Downgraded software-triggered orderly poweroff log level to CRIT.
- Added check for CHIS key to skip AC registration on desktop models.
- Link to v1: https://lore.kernel.org/r/20260105-b4-macsmc-power-v1-0-62954c42a555@gmail.com

---
Hector Martin (2):
      power: supply: Add macsmc-power driver for Apple Silicon
      mfd: macsmc: Wire up Apple SMC power driver

 MAINTAINERS                         |   1 +
 drivers/mfd/macsmc.c                |   1 +
 drivers/power/supply/Kconfig        |  11 +
 drivers/power/supply/Makefile       |   1 +
 drivers/power/supply/macsmc-power.c | 851 ++++++++++++++++++++++++++++++++++++
 5 files changed, 865 insertions(+)
---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260125-b4-macsmc-power-bb30389e05f1

Best regards,
-- 
Michael Reeves <michael.reeves077@gmail.com>



