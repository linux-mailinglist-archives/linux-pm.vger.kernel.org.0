Return-Path: <linux-pm+bounces-40907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2211D22B7E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 08:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 069C5304BB6A
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE432573D;
	Thu, 15 Jan 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaOmKxh4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3841C63;
	Thu, 15 Jan 2026 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768460905; cv=none; b=u41NdQNAR41xB213sdeBcXjBiuV/AjjIPn8JRLdpArlyfMV9yCrBF9uPmZAunly/I4VMTzQGlk0lS6YN7+7l7pil7Pc+rhtdqA567miD7ZoTo+pGfV1QRJG7dsLxSjV1l4kg+jxsJj4++iIwUsTk6fIgi5Psd/oJO4wKGGSs6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768460905; c=relaxed/simple;
	bh=7ZuDFsWT2gxxq3ujMvtSzPih5aeosnU4qUGhtGU18+o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BH5ucvfPvybaQrIwJCkeGv0CGZWGvHsy2ECUY+5gpWzCQ0slEgv1jwvE9DMFOHlBTfS89nemTnJDp6KLe6Em6f1nW7bRJEtKVfCRLlT/G5C+weUVCxQjxz/g8vbB2ZKOmkepi2poSD6xQSgWvEvogbhIUFXyK5EId3MeIT3uzZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaOmKxh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B037AC116D0;
	Thu, 15 Jan 2026 07:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768460904;
	bh=7ZuDFsWT2gxxq3ujMvtSzPih5aeosnU4qUGhtGU18+o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VaOmKxh4tymfaveut3u1VL1+fxvpwKNADofSqFce1tmityltUDF+IAEg7cs88785q
	 zNf/bQF682yFAU7WV3jWlFBkgTjagT9F91E1UJnk56iAtzFdeEhDZuUX94hoWqJXIy
	 r0yK0y9NDAxJ/zWKFjAtZx4tX/rPhrmKXKXPjZpcf+fv/QkyYqhItc126ZLgakNdmV
	 Vp+J1a5eb0H9zr2TwMnHSEI9i9fsH38uiMUv8UiQY/x2cPXq11+P5pzbOrRTFaO/kO
	 w5IUrjgtTQ/HVxT+0tLqoKLyMDBdzFNy7Aj0VhCQKO83oUBKqwNYWrXamnFx17M58J
	 ErUgRjRltH5YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FEAD3CC8A;
	Thu, 15 Jan 2026 07:08:24 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] Add Apple Silicon SMC power driver
Date: Thu, 15 Jan 2026 18:08:14 +1100
Message-Id: <20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+SaGkC/3WNyw6CMBBFf4V0bU07UF4r/8O4qMMATSwlrakaw
 r9bWJEYl+cm59yFBfKGAmuzhXmKJhg3JchPGcNRTwNx0yVmIKAUUih+L7jVGCzy2b3I807ICrH
 qVa6RJWv21Jv3XrzeEo8mPJ3/7AdRbuv/VpRc8BIaVWABWil1Gaw2jzM6y7ZWhKPf/PqQ/CavZ
 d1LqroSjv66rl8n4xcR7gAAAA==
X-Change-ID: 20260105-b4-macsmc-power-d017cc7f53ac
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768460903; l=2212;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=7ZuDFsWT2gxxq3ujMvtSzPih5aeosnU4qUGhtGU18+o=;
 b=ZqocKdTEOkpTOndAfW3elALKsRlonSok214dv4pvVbnLBEpl//qZUsBW7DJ3g8mvf1YbcDtEF
 6pBqk5v+n0sAmAuvweaEXSglpBwNgYtXbypJpVc8UzHA7hiE0FzDIOr
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

This series adds a power supply driver for the Apple SMC found on
Apple Silicon devices. This allows the kernel to report AC status,
battery charging status, and power metrics, and modify the charging
behaviour.

The first patch adds the driver itself, and the second patch wires it
up to the MFD core.

The driver is based on an original out-of-tree implementation by
Hector Martin. It has been refactored for upstream inclusion, 
including support for newer SMC firmwares, devices without batteries,
dynamic property detection and improved state management.

Tested on: Apple M3 (MacBook Air, J613)

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
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
Michael Reeves (2):
      power: supply: Add macsmc-power driver for Apple Silicon
      mfd: macsmc: Wire up Apple SMC power driver

 MAINTAINERS                         |   1 +
 drivers/mfd/macsmc.c                |   1 +
 drivers/power/supply/Kconfig        |  11 +
 drivers/power/supply/Makefile       |   1 +
 drivers/power/supply/macsmc-power.c | 834 ++++++++++++++++++++++++++++++++++++
 5 files changed, 848 insertions(+)
---
base-commit: b775e489bec70895b7ef6b66927886bbac79598f
change-id: 20260105-b4-macsmc-power-d017cc7f53ac

Best regards,
-- 
Michael Reeves <michael.reeves077@gmail.com>



