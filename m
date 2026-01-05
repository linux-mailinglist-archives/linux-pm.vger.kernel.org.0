Return-Path: <linux-pm+bounces-40189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A717CCF3A99
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 14:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96B96300644E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9326343D6F;
	Mon,  5 Jan 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eloDyBS1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DA3431FD;
	Mon,  5 Jan 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617807; cv=none; b=T9FVS7FG62CvvJpJlnqtnOTa6WpTSOZqwt3A+Okx/OY2MiBttvtDhJGNJDzywNmr/WnbANHDTZ/m98JnFMFXsQJPkjxPxQuPm5FC2A7vJMa+8eOlYiOl8e7WPILqYVmjLfM82sX6z0BcDCWsV09tiUmUAc+s9jkeCplf+Keqi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617807; c=relaxed/simple;
	bh=0/FNTDcgirnA9vyGn4Nykw0//mGf5LocBXFpq2GMF5Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GIiEFt3vFWdvIlxqFy+yUPyfwcmORK2VPcXKHYNlC/n0JlU8FtM0DtXt/MHKBtsrZipCrZKcw2p7cKfO3yT3lgsAiRR6U4lT43J6IiR8xgY3tR88L6pR5UTu3/usulNbP5SzY/PQiXzjCC1FzBXflpoCrni+HdpoFNMr8ynnpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eloDyBS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A0C1C19424;
	Mon,  5 Jan 2026 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767617807;
	bh=0/FNTDcgirnA9vyGn4Nykw0//mGf5LocBXFpq2GMF5Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eloDyBS1gwcGjMZvlCWgZ546QCJR1rcU1ZQ3lMUxIqmYlpITBNncl9n7nKv7jMTaV
	 ntWJStZ7ttNrc6x9XKpC/0vWXWN75sA/mRt8cS1deBUt+oy1E48gbieiS2LTS1Pvam
	 /CUiJ3b+DeB76/P/7xs0f+OfunCfp95n1iRd9sKNasaHWiWzJTJkvn9ec+VeQBC2dm
	 Z0nnfmOTNNnk+3FRZKskGmd+4bDRraOvLb5t3NIv0qGC1uC6J1Lj+9iL4XxBCl4BHb
	 QgRwYWtuGBYqIrNTox+uIXwXWBZmBZuPD72xgh08qF6IrS+169tUDQDXpBbQzPM8b7
	 yAXvjBsJbk/cA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C2C79F8C;
	Mon,  5 Jan 2026 12:56:47 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH 0/2] Add Apple Silicon SMC power driver
Date: Mon, 05 Jan 2026 23:56:35 +1100
Message-Id: <20260105-b4-macsmc-power-v1-0-62954c42a555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAO1W2kC/x3MTQqAIBBA4avErBtQ+4OuEi1snGoWlShUIN49a
 fkt3ksQOQhHGKsEgW+Jcp0Fuq6AdntujOKKwSjTK606XFo8LMWD0F8PB3RKD0TD2jWWoFQ+8Cr
 vf5zmnD+qQi/uYQAAAA==
X-Change-ID: 20260105-b4-macsmc-power-d017cc7f53ac
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767617806; l=1301;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=0/FNTDcgirnA9vyGn4Nykw0//mGf5LocBXFpq2GMF5Q=;
 b=pXgNPMu6iKqaJdxxdZ+XZiUEBGctL1+0EGQ1Mf6C7pdzK0+VGMoho8NKfA9cbjoe6FHCZEAZp
 0HXLd6hn9DQAC/1GvyrUcNGyoHIxOwWglVsTCos2RKyS34VGyIPRBWm
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
Michael Reeves (2):
      power: supply: Add macsmc-power driver for Apple Silicon
      mfd: macsmc: Wire up Apple SMC power driver

 MAINTAINERS                         |   1 +
 drivers/mfd/macsmc.c                |   1 +
 drivers/power/supply/Kconfig        |  11 +
 drivers/power/supply/Makefile       |   1 +
 drivers/power/supply/macsmc-power.c | 872 ++++++++++++++++++++++++++++++++++++
 5 files changed, 886 insertions(+)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20260105-b4-macsmc-power-d017cc7f53ac

Best regards,
-- 
Michael Reeves <michael.reeves077@gmail.com>



