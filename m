Return-Path: <linux-pm+bounces-18775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9239E853B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72502816FC
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A5156C71;
	Sun,  8 Dec 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rQPkwjb8"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109E154439;
	Sun,  8 Dec 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662966; cv=none; b=ibtBGrrcY6jnMertBrZQjW0BJSPYShnkKgyMJX0nYHzrp2TkMJmiI1+zWG9ZWx4B9CyhhOeHcPYZbrgT34P2WUTk8N6D82j9/XLnXI8GianjH4qMPe17uXQiNK64MCRSoyBqVhdhi0H+BvbVzoKrQfuYa63ba+OJERhTIP/bJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662966; c=relaxed/simple;
	bh=rdh35BFI5KygGq7wxSw7wcqfjLu8NG5cFAZXr6CdRq0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ArOmmrqaFVPh4hqKcUxyq6IrKkQdzY77bMO2V/dA4dtx0VV1cBxyzlOlNW9axF9ZF4o/EqJp56wZbZ8ne+sjgBXOXio5rBcKNON4mnGiVEB+jxlIL2MNHRHGq5zNFaU4XqW5ntpJambdfpjYJtzSu/RiMIYetGTte2n0tkIXZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rQPkwjb8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662958;
	bh=rdh35BFI5KygGq7wxSw7wcqfjLu8NG5cFAZXr6CdRq0=;
	h=From:Subject:Date:To:Cc:From;
	b=rQPkwjb8/Ttf8YyipUrISj3kZKfBQzRoA/csHHYTCE20ILL0bsHZ9T/gO/vkZF8vH
	 nFGRMoxQe4D4311jM9G3AgRP2Kodo6gXI/ei/2RCaVFGBUJyXo+uab84gFWM8hQzOq
	 K58Qb8NUihT3atddIvf0puwAe6x9qHFk7ukSIVB8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 00/14] power: supply: intruduce and use
 power_supply_for_each_psy() and dev_to_psy()
Date: Sun, 08 Dec 2024 14:02:32 +0100
Message-Id: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOiYVWcC/x3MQQqDMBBA0avIrB1IohTxKqVIqpM6IGbIWFuR3
 N3g8i3+P0EpMSn01QmJdlaOa4GtKxhnv34IeSoGZ1xrnelQ4o8S6ldkOXCifdjiIHpgeDfBt2S
 Df3gotSQK/L/Pz1fOF0YbisRpAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=2038;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rdh35BFI5KygGq7wxSw7wcqfjLu8NG5cFAZXr6CdRq0=;
 b=eFtpEtqbLdCpo+fFPwd3xVD6L27ddGIoGN+MiqXRp3yDm7OrXnWhml0hJKSPx9zwbDQymC9Dh
 MKKx2AxGy0XC+qJl08N5rzJnWlkaeFI8z9akrHlghmZDRZ6HPcNJdsI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add two new functions with easier to use and safer APIs.
Switch over a bunch of in-tree users.

The first commit is not directly related but fits the general theme of
the series.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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
base-commit: 39f3bd9c9a27d526858da153090376decdf7bfea
change-id: 20241208-power-supply-dev_to_psy-fb3fa4e1fa6a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


