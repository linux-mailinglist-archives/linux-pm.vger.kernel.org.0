Return-Path: <linux-pm+bounces-15206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C29915D6
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068CF1C2145C
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84A14D70B;
	Sat,  5 Oct 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cKoimEs8"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFEF14C5B0;
	Sat,  5 Oct 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122794; cv=none; b=UTrGNJ8BTqxRePgejRvQ3/y/1a7QIQrB4lUm24u8dcJlP3RNaYuyS4YSMfkUB35AhrB2x6G7mrVh4kbT5amIP353uq+PUhKpwXhBotf8wKUTB8vGooVXxWWgdDtAwIL7bIn9yRIqlFuA9EWi5iQF4qY4tbwfkbV/jocC7qRfDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122794; c=relaxed/simple;
	bh=xSJzXcjSDEw5veRB5ks1paRA8EhnR9PwkhHHH7zXiuA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zcsx8tDlJhFigs5Kb+cBLEL9ZolsPNmlXkK2QuVoMMfSnV7ge4iutLfKqae38R9bBkM9sk2G7zetaOpfcAp75eCwbTide6idHBkE9B4cmFlXNdyh6Qab3pa8hdZwNv3YHZ/CMhSBPHyUe6I4tCzjp86T/Zo0BFp5p0iebBWDQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cKoimEs8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122791;
	bh=xSJzXcjSDEw5veRB5ks1paRA8EhnR9PwkhHHH7zXiuA=;
	h=From:Subject:Date:To:Cc:From;
	b=cKoimEs8+9h+uIj1qwaQDK6ojILE7qnHmLnEfatLNLLT8eGzRDCSh43T8cwssZH8F
	 rfakwxOKEJfMq/LkaTrRyOK0x1CwEZMENWx7Ud0IwwoPTMCiL4q2JB0l49yxHVfW9H
	 OlPlkwRani52y3j/6VLxn7NorDKLtcA7xgkdiuUM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] power: supply: core: random cleanups and optimizations
Date: Sat, 05 Oct 2024 12:06:14 +0200
Message-Id: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJYPAWcC/x3M3QpAQBBA4VfRXJtiW8SryAVrMKU17eQveXeby
 +/inAeUApNCkzwQ6GDlzUfkaQJu6f1MyGM0mMzYrDYGZTspoO4i641upd7volg5GiZb1nlVWIi
 tBJr4+r9t974fAxnDdWcAAAA=
X-Change-ID: 20240922-power-supply-cleanups-7cebf4691754
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122791; l=933;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xSJzXcjSDEw5veRB5ks1paRA8EhnR9PwkhHHH7zXiuA=;
 b=hv3gOaOMNHE099HpT1byo++U+P085sQ/RVNJzFyLe9uHs/5yJgCgbQ3XMOZWxoMUHDDse/NRy
 nCsgS1i/bTwA7NNscwccmS8qj2Pxq7JCE1CXYhzE5nYup2ZQhLIfDhs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Some independent cleanups and optimizations.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      power: supply: core: use device mutex wrappers
      power: supply: core: unexport power_supply_property_is_writeable()
      power: supply: core: mark attribute arrays as ro_after_init
      power: supply: hwmon: move interface to private header

 drivers/power/supply/power_supply.h       | 22 +++++++++++++++++++++-
 drivers/power/supply/power_supply_core.c  |  5 ++---
 drivers/power/supply/power_supply_hwmon.c |  3 +++
 drivers/power/supply/power_supply_sysfs.c | 12 ++++++------
 include/linux/power_supply.h              | 15 ---------------
 5 files changed, 32 insertions(+), 25 deletions(-)
---
base-commit: 27cc6fdf720183dce1dbd293483ec5a9cb6b595e
change-id: 20240922-power-supply-cleanups-7cebf4691754

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


