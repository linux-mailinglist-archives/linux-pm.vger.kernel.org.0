Return-Path: <linux-pm+bounces-17640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C495D9CF271
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 18:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E52B61429
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4231E0DF5;
	Fri, 15 Nov 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rk3hDSHL"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AF1D54E1;
	Fri, 15 Nov 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688839; cv=none; b=d0xFr7X/bQZHuMUTi9Fd/p15PEBi6V3DEQO66moBh45tV/pwDdeZogqsYFC1KOjrrYFsXa+iuFHrW2wtwdWl5TJFUYNMe8DkbRWllQ2mKVgbEbdO/Yn/rNWo4ru3iPuLjbFfXYIzVY8Nfmc3ddf8gjdF8dhKMHpyBme5zlMYt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688839; c=relaxed/simple;
	bh=XJgwbJmJy1dij2tvJOcwOOlxmwxz8tQU72/Pm0EegoA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uvyqeW7vmbfqQ3y5InrKEsZDBmDMKurC/qTwevOqAq0lQAMT1Mhq8Bj8QxdrlMAQ9SvSivy9ZXTqtfZ4CGULohVm/YW7UpCafX2Lx3MmZJLG5PDTmch4oC0KPR32BZCC61PPxbzesII+lPQKxGyLeC66XSUUvAOudz7Q2u25iZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rk3hDSHL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731688833;
	bh=XJgwbJmJy1dij2tvJOcwOOlxmwxz8tQU72/Pm0EegoA=;
	h=From:Subject:Date:To:Cc:From;
	b=rk3hDSHLR+Ep6ydphocv3aeZ30Fd16rSlDBYSX1ELszo2drVLuEYA6OxnqkS20sKs
	 1z0MJJM0xNQ00cx9ktjL8zwXMis6e/oVbSZW3PwXlQMZYqJxaJs7J7jGFY0C+xxD+4
	 L47Uz+98nYD27W4PzbDAw3fwz1iiB3xnyyT82kvA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] hwmon: (core) Avoid ifdef CONFIG_THERMAL in C
 source file
Date: Fri, 15 Nov 2024 17:40:20 +0100
Message-Id: <20241115-hwmon-thermal-v2-0-c96f0c0984b2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHR5N2cC/3XMyw6CMBCF4Vchs7aGGS81rnwPw6LSwU4ixXSwa
 AjvbmXv8j/J+WZQTsIK52qGxFlUhliCNhW0wcU7G/GlgWraI+LOhKkfohkDp949DHny7nDCluw
 RyueZuJP36l2b0kF0HNJn5TP+1n9SRoPGItn6xrazji4Ti6q24RW2kUdolmX5AoHun+ivAAAA
X-Change-ID: 20241113-hwmon-thermal-2d2da581c276
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731688832; l=849;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XJgwbJmJy1dij2tvJOcwOOlxmwxz8tQU72/Pm0EegoA=;
 b=jDhwvYH1RRBZYDcKyKhsKmJMFFTEW6KNBzi9NHeRqwg+sXj7dZEKy1K3u1yqSmbEN5cJOXOLx
 VPqxI1c6CcMDWFDjeS0B63gxickl07yDfaeXB86iKJIB6HcB0+tWYjI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Replace some confusing ifdeffery with IS_ENABLED() conditionals.
The ifdefs confused me while looking at the implementation of
HWMON_C_REGISTER_TZ.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Add stub for thermal_zone_device_update()
- Link to v1: https://lore.kernel.org/r/20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net

---
Thomas Weißschuh (2):
      thermal: core: Add stub for thermal_zone_device_update()
      hwmon: (core) Avoid ifdef CONFIG_THERMAL in C source file

 drivers/hwmon/hwmon.c   | 21 ++++++---------------
 include/linux/thermal.h |  4 ++++
 2 files changed, 10 insertions(+), 15 deletions(-)
---
base-commit: cfaaa7d010d1fc58f9717fcc8591201e741d2d49
change-id: 20241113-hwmon-thermal-2d2da581c276

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


