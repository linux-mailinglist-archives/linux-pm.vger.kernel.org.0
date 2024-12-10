Return-Path: <linux-pm+bounces-18959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0777D9EBC3A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D026188AF45
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAB223D419;
	Tue, 10 Dec 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MJA/f3mZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540E2397B4;
	Tue, 10 Dec 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867765; cv=none; b=pl48QQwsaytsO/TecJfFUZc3EZ+lkslkUlF+bpFLEk0VWslgZOzfHATxo0deLU4mbrjNqkrWG72QB7BrtN+liy6mfWiqNV3M7YSl2ZqNjMx6PsCRDG8XP8fnDB06/hyZKIr0k8txEs6cQhbYJsgMcQxFv3DZdDXkoAh4ZCMAjxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867765; c=relaxed/simple;
	bh=+YGDTxSdhaw3xsmyw2NeAbWf1IMK70o61+V3BPkda4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Skuq08KKD/acvjyArLbcJlJlIX0UAdA6mRS+vLK6gjSCA3SHu8jZPcSv/tJyPEyrLxY9TREvKNOStJBHmyYu1uM7rF9dknzarHNXkgu+VTtsyIiw2g2FEP/VTXvOCp6hYkjCukFXTGv8lnP6zvOYdCZIEy9yyDJqiAq1ne5cRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MJA/f3mZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867760;
	bh=+YGDTxSdhaw3xsmyw2NeAbWf1IMK70o61+V3BPkda4g=;
	h=From:Subject:Date:To:Cc:From;
	b=MJA/f3mZus7LGmITbekVCbVJcAq66HjeoBRycllq6OXKgNhFkDMetAmGc/ylxxeyB
	 Sqocn5X5O5dmy2t+iRl2Qfd9iL/foLK3L00hFfBRYAa2M5yUZ6uQ0RTJuqQTmCiVGo
	 9fSnB+QXcQ6HB1NtzqiRWOVeJ5QQ1yVLdr1takgo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 00/14] power: supply: introduce and use
 power_supply_for_each_psy() and dev_to_psy()
Date: Tue, 10 Dec 2024 22:55:47 +0100
Message-Id: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOO4WGcC/4WNQQ6CMBBFr0K6dgytoMDKexhCKkztJIY2HSgSw
 t2tXMDle8l/fxOMgZBFk20iYCQmNyZQp0z0Vo8vBBoSC5WrQqq8Au8WDMCz9+8VBozd5DrPK5j
 nxegCpdFXLdLaBzT0OcqPNrElnlxYj6Mof/Z/M0rIwdTlgLWUt7Ks7gsSM/d2tucRJ9Hu+/4FA
 nF92MMAAAA=
X-Change-ID: 20241208-power-supply-dev_to_psy-fb3fa4e1fa6a
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=2215;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+YGDTxSdhaw3xsmyw2NeAbWf1IMK70o61+V3BPkda4g=;
 b=793fnRywIoSyimqnJL1i3d3U3yWCVUS+umSPizyk46isXeCOD3C7UAfLJbrTq5wRhSyjrZ0g8
 XXbJ7zf0/MaDvmFyCYcGt9NvAOLqxrWRtQ+d7ustVNRTi7sQZLM6LTe
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add two new functions with easier to use and safer APIs.
Switch over a bunch of in-tree users.

The first commit is not directly related but fits the general theme of
the series.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Remove slipped in 'struct power_supply_ext'
- Link to v1: https://lore.kernel.org/r/20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net

---
Thomas Weißschuh (14):
      power: supply: mm8013: use accessor for driver data
      power: supply: core: introduce power_supply_for_each_psy()
      power: supply: core: use power_supply_for_each_psy()
      power: supply: ab8500: use power_supply_for_each_psy()
      power: supply: apm_power: use power_supply_for_each_psy()
      power: supply: core: remove power_supply_for_each_device()
      power: supply: core: introduce dev_to_psy()
      power: supply: core: use dev_to_psy()
      power: supply: sysfs: use dev_to_psy()
      power: supply: ab8500: use dev_to_psy()
      power: supply: surface_battery: use dev_to_psy()
      power: supply: bq2415x_charger: use dev_to_psy()
      power: supply: bq24190_charger: use dev_to_psy()
      power: supply: bq24257_charger: use dev_to_psy()

 drivers/power/supply/ab8500_btemp.c       |  5 +--
 drivers/power/supply/ab8500_chargalg.c    |  5 +--
 drivers/power/supply/ab8500_charger.c     |  5 +--
 drivers/power/supply/ab8500_fg.c          | 33 ++++++++--------
 drivers/power/supply/apm_power.c          |  6 +--
 drivers/power/supply/bq2415x_charger.c    | 24 +++++------
 drivers/power/supply/bq24190_charger.c    |  4 +-
 drivers/power/supply/bq24257_charger.c    |  8 ++--
 drivers/power/supply/mm8013.c             |  2 +-
 drivers/power/supply/power_supply_core.c  | 66 ++++++++++++++++++-------------
 drivers/power/supply/power_supply_sysfs.c |  8 ++--
 drivers/power/supply/surface_battery.c    |  4 +-
 include/linux/power_supply.h              |  4 +-
 13 files changed, 92 insertions(+), 82 deletions(-)
---
base-commit: 94ba531bf9cb3c4ef725ffc37b8ed09006533f25
change-id: 20241208-power-supply-dev_to_psy-fb3fa4e1fa6a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


