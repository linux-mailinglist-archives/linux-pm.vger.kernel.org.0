Return-Path: <linux-pm+bounces-40449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5BD03095
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 14:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B118B302AAF7
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB34E20F2;
	Thu,  8 Jan 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckJ1DLSg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F74A340E;
	Thu,  8 Jan 2026 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878331; cv=none; b=d0j3vbbNsZ5Y2MklfhSM+uBLpDRHZvJq3JEQ/MgmBlM+krubWQeOkg7H8H2xkVFyXp11ssCjh/iSZbeyYGbDj2q15zMgIBjNVRS+VAoPI96xWPA17Mj8liB0ryggF2ZCfbFxIActsT8kZiODpisosYMkotnjXX3wqCNUyruAqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878331; c=relaxed/simple;
	bh=ULItbI1yU0oVHXTe0/S32I9HO15qLNcu+lgP97nBouQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cC9534Secc/0ucSOzNVvTIEIL5LYc1SVBjEe5mOPNxOoBZuEV12dCatnjsd2Stcz1bvnVWAPSIx9jRbnwkSUZEM1OUJLvOSBoVmzYD7NA7aVaFJcOzV2RhWkg3pkxv/Y2kXRgnWgH3wycUtJfJD/4xDIev6pIXo6OYkz1SgMa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckJ1DLSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2AF6C19421;
	Thu,  8 Jan 2026 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767878330;
	bh=ULItbI1yU0oVHXTe0/S32I9HO15qLNcu+lgP97nBouQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ckJ1DLSgXXYnDVSkHtrYWID9qghyP6AEsu1Yb5McBu5NvFvkpy2fmcxf0N7TaYEXV
	 5jR+ztCoTT7jqa19TwTCE4tsco1ryEx9OWU4NC7ESMvqH3nTsD7unNaSZxon+3TkCl
	 kRzSVos4lcNnHBzSt2ViMJ5pWMbd1be48WMdEzORlOEf29wYIfwQUE5lj3fZh2NAO4
	 5OO9qGWq6Mf43uvUNdAIcmIZIpcNNnBiV/dp3TK8jCoYVKUrZMldgTVWoMGlFomzbW
	 mymkxHKnCeNobHCGvJNc/ZZjYD/+9LjSjibYYT2rMnd9vpr6q+fYMIe8opKdDv3qTu
	 /8oxjaIk5AlBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90369D185E7;
	Thu,  8 Jan 2026 13:18:50 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] Add Apple Silicon SMC power driver
Date: Fri, 09 Jan 2026 00:18:47 +1100
Message-Id: <20260109-b4-macsmc-power-v2-0-93818f1e7d62@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALeuX2kC/3WNQQ7CIBBFr9LM2jGA0EZX3sN0gVPaTiKlAYOah
 ruL3bt8L/nvb5BcZJfg0mwQXebEYamgDg3QbJfJIQ+VQQnVCikM3jV6S8kTruHlIg5CdkTdaE6
 WoK7W6EZ+78VbX3nm9Azxsx9k+bP/W1miwFadjSatrDHmOnnLjyMFD30p5QtP5UOgrgAAAA==
X-Change-ID: 20260105-b4-macsmc-power-d017cc7f53ac
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767878329; l=1754;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=ULItbI1yU0oVHXTe0/S32I9HO15qLNcu+lgP97nBouQ=;
 b=nPEwliGopv3tiHSTW55ltR9k7IAzFxUGeMQtuM3HZAEmI8bCau/pgyINeKM2ZSPnUnxCl0ajA
 Y5M3G9B279gDQJ1ndb8X8qMopbNEJrDuivf9tPlqQ3VcpAtCYAC0Jvd
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
 drivers/power/supply/macsmc-power.c | 883 ++++++++++++++++++++++++++++++++++++
 5 files changed, 897 insertions(+)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20260105-b4-macsmc-power-d017cc7f53ac

Best regards,
-- 
Michael Reeves <michael.reeves077@gmail.com>



