Return-Path: <linux-pm+bounces-8304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6EB8D256B
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 22:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF751C234ED
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 20:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945B17839E;
	Tue, 28 May 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="m0yBI/G9"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4217838A;
	Tue, 28 May 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926718; cv=none; b=i87adYjdZ++0iCAFsTr0mNHwJulQYiFjrll8vtHmtwbtL9m000Q8ErfjcAur9XS98l4WiGiTnbMGTpojNtqIjs+SZCYutMXZjBp6Vadm6XTFUmU8e93QM4CVt6thabfCO949NheEu9QtzBFxBpUScRO4hXyUjFSszSgeYqC6OWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926718; c=relaxed/simple;
	bh=iiKhQmFNByPcXspe2bsUME4YrkiJ8ckmRbNWS2vPbdk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bxO2fLk8HggoeZ2a/4/oiur5Tgqab5pjIXkT8jK/QneBS4NWcCCl2vuoKhPr0au528jdRWfYl9W/v8GfM1uPh/MdVGIHZjTb0Q22GdLdZkcc1pjDIgbRgvw94/FEFxvlmIXwbwlQA8EYWDTTUb+bXW/tQnwiEGoVyy2CgSNDBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=m0yBI/G9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716926707;
	bh=iiKhQmFNByPcXspe2bsUME4YrkiJ8ckmRbNWS2vPbdk=;
	h=From:Subject:Date:To:Cc:From;
	b=m0yBI/G9ILhDGIJkxe7P9EpwJ20bJPNKxEvHfJg1Efujskaxc+Se7rywCsZxcmUSF
	 z91W2HK1FUICl9XkN0CBIPbe/blJH+bm/rLRrlztzUrS0nj6r0FhwPM5YMA1rra5oH
	 sQekHa8N3cXk8QZTVVxz++umRFGJ8TG6UH7z7MGs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] ChromeOS Embedded Controller charge control driver
Date: Tue, 28 May 2024 22:04:09 +0200
Message-Id: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALk4VmYC/3WNwQ6CMBBEf4Xs2ZoWBYon/8MQA2Wxm5iW7CJqC
 P9uJV49vpnMmwUEmVDglC3AOJNQDAnyXQbOt+GGivrEkOv8qAtdKsdRruhUajm1LoaJ412Vtih
 NhRZ7W0Eaj4wDvTbxpUnsSabI7+1nNt/0pzT1P+VslFZdOxx00buq7uz5iSQizj/8PuAEzbquH
 1mzYn3BAAAA
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716926706; l=1698;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iiKhQmFNByPcXspe2bsUME4YrkiJ8ckmRbNWS2vPbdk=;
 b=a838ZxPgon4i1+SbW6pRgcmX7Q4jxi4EREHrFP59RVRrYS3/X8/W6oq1lFgF0JRqFmaFpFHHF
 O9s2L3hAktuDk4hHDHjiZg9pNRasJDuP7jZKhL1hBgrN+AAVwOWD6rk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add a power supply driver that supports charge thresholds and behaviour
configuration.

This is a complete rework of
"platform/chrome: cros_ec_framework_laptop: new driver" [0], which used
Framework specific EC commands.

The driver propsed in this series only uses upstream CrOS functionality.

Tested on a Framework 13 AMD, Firmware 3.05.

[0] https://lore.kernel.org/lkml/20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Accept "0" as charge_start_threshold
- Don't include linux/kernel.h
- Only bind to the first found battery
- Import EC_CMD_CHARGE_CONTROL v3 headers
- Add support for v1 and v3 commands
- Sort mfd cell entry alphabetically
- Link to v1: https://lore.kernel.org/r/20240519-cros_ec-charge-control-v1-0-baf305dc79b8@weissschuh.net

---
Thomas Weißschuh (3):
      platform/chrome: Update binary interface for EC-based charge control
      power: supply: add ChromeOS EC based charge control driver
      mfd: cros_ec: Register charge control subdevice

 MAINTAINERS                                    |   6 +
 drivers/mfd/cros_ec_dev.c                      |   1 +
 drivers/power/supply/Kconfig                   |  12 +
 drivers/power/supply/Makefile                  |   1 +
 drivers/power/supply/cros_charge-control.c     | 353 +++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  49 +++-
 6 files changed, 420 insertions(+), 2 deletions(-)
---
base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
change-id: 20240506-cros_ec-charge-control-685617e8ed87

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


