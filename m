Return-Path: <linux-pm+bounces-7974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC08C93BE
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 09:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE88E1F21468
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E45182BB;
	Sun, 19 May 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Lz6vhAyR"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850F1798C;
	Sun, 19 May 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716105051; cv=none; b=cK6Upe99mwFGfkgPsSSpJuJVZYRdH5dnOxxpdZlDRWUZ7QccL3dZPwOXivRatLIBCnJPKZYgOSEFvdFCEnguvv6ulWLX7s0nTqhIKOG0fiupvAYWkYpydqtZWOWoGSzN21le/HSOrRb79vSOQUgfgKNJwdJh3tNj0RYIBD/AWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716105051; c=relaxed/simple;
	bh=XEvMTmyejA92HfvXwRaxygi2nQZ9IXfpiRQKTfYa1uM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KkiqvbAjZS6JiV8eJ18GrGdEXJ8ucAcnz5k9qRwGAJlVtWC3ODGi72/00NsTuSGU15hwvPgkdaUsH5P8FDNqlGeaTU+tLGNkaxGvNqlGsNdR+1ssfcZA2VM2jMQo4WSBAUfAv6aB/AudyOtCrKinz5aB/zeox+2n3S4tIAdNXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Lz6vhAyR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716105046;
	bh=XEvMTmyejA92HfvXwRaxygi2nQZ9IXfpiRQKTfYa1uM=;
	h=From:Subject:Date:To:Cc:From;
	b=Lz6vhAyRZm7CuzS8wdtwgjMUo8XB/5KHpbUcsaSq+94dlgB4TDQqwOIKCObCim666
	 cTqI4w5dS+kz8j/TyqQxZ3IMS5V3wePBgH7Fomub/ypcuDJlTSzyrAmHHp1eUFKHWJ
	 8K2kTnOH4wDC1d413AEuGkhUQvYCy/CygfSC9jwc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] ChromeOS Embedded Controller charge control driver
Date: Sun, 19 May 2024 09:50:18 +0200
Message-Id: <20240519-cros_ec-charge-control-v1-0-baf305dc79b8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADqvSWYC/x2MWwqAMAzAriL9drCJe+BVRERm1YJs0okI4t0tf
 oaQPFCQCQt01QOMFxXKScDUFcRtSisqmoWh0U2rrXYqci4jRiWWxcacTs67csE64zHgHDxIfDA
 udP/jfnjfD0qbOMRoAAAA
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716105045; l=1339;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XEvMTmyejA92HfvXwRaxygi2nQZ9IXfpiRQKTfYa1uM=;
 b=bzQAuhT2HoodDD+paM1bjPmpJqZ4jNyPrci8hFaTGj9Heh/GjTuliLL9JarHQMzpFm2NMAJj9
 EvS9NyxYVEKDABUcyKwKCh1rVS1gsdb52BLgON2Kvm8nHu0Ta2eLx2u
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
Thomas Weißschuh (3):
      platform/chrome: Update binary interface for EC-based charge control
      power: supply: add ChromeOS EC based charge control driver
      mfd: cros_ec: Register charge control subdevice

 MAINTAINERS                                    |   6 +
 drivers/mfd/cros_ec_dev.c                      |   1 +
 drivers/power/supply/Kconfig                   |  12 ++
 drivers/power/supply/Makefile                  |   1 +
 drivers/power/supply/cros_charge-control.c     | 279 +++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  44 +++-
 6 files changed, 341 insertions(+), 2 deletions(-)
---
base-commit: 0450d2083be6bdcd18c9535ac50c55266499b2df
change-id: 20240506-cros_ec-charge-control-685617e8ed87

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


