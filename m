Return-Path: <linux-pm+bounces-41815-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO8nFgB9fWmGSQIAu9opvQ
	(envelope-from <linux-pm+bounces-41815-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 04:54:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4408C098A
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 04:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 802C43017F86
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 03:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59629A9E9;
	Sat, 31 Jan 2026 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tawcTe5C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985E7FBA2;
	Sat, 31 Jan 2026 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769831342; cv=none; b=RHktpVgkDKfsicUdJ5Fx5TeNoHM0tDC0nW3z6hrqVKPA4V87uAg6sEaFfi3S3eTAGcdAfjBg81oM/8gZpDFge7krQHzlkmChrMYM6fsH/jXp4XdqIZJY94wYzYYqKTbbMI51BJ3J09VBF1diNJLJqWm8o9rFO09gI0qlkmg7aM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769831342; c=relaxed/simple;
	bh=ZnVtjaB+DXtgm+WtfVOKX4mVzGawj6NsVWf0IaeHm+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PSgLZQGyDzUv549EyAfAmeI9EcHKSYq1Rb94y58zsi7hcJ4as6atLQ4uOvFMdtCkZ88Wgs1V1X3LRRDNefo6TZNFCEm+mOcatOHDJrZ7xncyXnUwMflSdWdjQAfyVewmJE4Y59DAY2uzEt45Zlk4Q0p0mbYq89QHg7mahDp5cQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tawcTe5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1B4AC4CEF1;
	Sat, 31 Jan 2026 03:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769831341;
	bh=ZnVtjaB+DXtgm+WtfVOKX4mVzGawj6NsVWf0IaeHm+Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tawcTe5CkmmWKMMG/5NHyMli2y7uKRmSSwt8LSwaT5KE4DcZfD4TAYlbcgvdqZrFX
	 eL02l9mUKM0CvJmEmkFRiOLLgDkjZsP8VMqcgKFuWNmx9L0Vprd10uigHJ42rWR0OR
	 8NuvIOkYqwQt/odg7Hm6fZB0gFALllIKrhQHtNjcil1PtJUBqqGxy2W2sIFriMH681
	 UtoL98hJDV0aIvxXw0qK8x7FE8ZdzCVWBI9FlTYScFpzuGKr+5PdrHq/gNuJUoicsa
	 y3+I+IczdDTz6whgWHlgcRhFBVqU/Ab7s+0oqn7U3JFrwSkuYicgZ42/fyzQXwF+LC
	 mpY4NHqJDJuOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8C4E6BF22;
	Sat, 31 Jan 2026 03:49:01 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH v7 0/2] Add Apple Silicon SMC power driver
Date: Sat, 31 Jan 2026 14:48:55 +1100
Message-Id: <20260131-b4-macsmc-power-v7-0-0e3a2da69948@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKh7fWkC/4XN0QqCMBTG8VeRXbc4zu04u+o9oottTh2kky2sE
 N+9KQRRF15+B37/M5Nog7ORnLKZBDu56PyQRnnIiOnU0Frq6rQJA4aQM0E1p70ysTd09A8bqNY
 FFLKyIJqcJDUG27jnVrxc0+5cvPvw2h5MfL1+WvjXmjgFqhRTKJlRKODc9srdjsb3ZG1NYseL5
 AtgHBmWhc7lr8cdj8lXEvOaQwlNxb79sixvIMRzZC4BAAA=
X-Change-ID: 20260125-b4-macsmc-power-bb30389e05f1
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>, Joey Gouly <joey.gouly@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769831340; l=3765;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=ZnVtjaB+DXtgm+WtfVOKX4mVzGawj6NsVWf0IaeHm+Y=;
 b=y3e/Gh23VNbZ5wtCBNwx9OB/ZNdpir9z25o8Qdz5G2V+AcDIYCVWC9+a2WQLe+YmwZvtcjsUh
 Q2OFRUTcDyVAf9aZ0evT/iqz2DbxPg7oY0oSu9XzouHEfCOlv5cQAgT
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [10.84 / 15.00];
	URIBL_BLACK(7.50)[gompa.dev:email];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41815-lists,linux-pm=lfdr.de,michael.reeves077.gmail.com];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,marcan.st,arm.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_REPLYTO(0.00)[michael.reeves077@gmail.com];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.717];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gompa.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4408C098A
X-Rspamd-Action: add header
X-Spam: Yes

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
Changes in v7:
- Replace emergency_sync() with hw_protection_trigger() to enable use as a module
- Link to v6: https://lore.kernel.org/r/20260126-b4-macsmc-power-v6-0-9861d4070f92@gmail.com

Changes in v6:
- Add FS header include for emergency_sync()
- Link to v5: https://lore.kernel.org/r/20260126-b4-macsmc-power-v5-0-302462673b18@gmail.com

Changes in v5:
- Readd cover subject that mistakenly got dropped, apologies.
- Link to v4: https://lore.kernel.org/r/20260126-b4-macsmc-power-v4-0-aa2a682ca650@gmail.com

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
 drivers/power/supply/macsmc-power.c | 855 ++++++++++++++++++++++++++++++++++++
 5 files changed, 869 insertions(+)
---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260125-b4-macsmc-power-bb30389e05f1

Best regards,
-- 
Michael Reeves <michael.reeves077@gmail.com>



