Return-Path: <linux-pm+bounces-17690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A46F9D0967
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 07:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076DAB20FDA
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646291487D5;
	Mon, 18 Nov 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cZK+Gpur"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572F13AD2F;
	Mon, 18 Nov 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910568; cv=none; b=lG4XopcDJodagJw0+jR0US40f5uisLIiP1m1hgrMGL8V155RMa9ImX/K15A4zvcjHCfa3XkUsDhtr3vCpp2bAo89Z027WzZCcL5EZwmpOm+J1qZ2+EXJk9nUPSgSzzzr2f8lD9KLf+VYwENXvf67usNa1zZxYPA9tmhtNOp84XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910568; c=relaxed/simple;
	bh=wwbsn1gz1zmNUJOUm/SsveOx12mGn+wDuAGKbxt50fU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ScRh1JUT9LGqSaUHlIkhfjI7zAerRpolE4HAWL4W1WcExfBSJs46udTDncSoegaNfoVcNKtTy4l+D9XTRo+xopnmI7XNibMXUZMxUkdxrlfWYzdggdfI0VAZG6zQl6WZZ4yZGJnu8NOomte8o+OjLpX/uVzjqJya1f2v2MRNYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cZK+Gpur; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731910561;
	bh=wwbsn1gz1zmNUJOUm/SsveOx12mGn+wDuAGKbxt50fU=;
	h=From:Subject:Date:To:Cc:From;
	b=cZK+Gpurd3QEqA7WuaVvRL+N2nobz3e0VgtZiG4RuWLdg2zDusSmURClcPIKFAUh2
	 U52nyZ0cFNfiPN+jZ+FO0DkNmjqAh6OFERgjcNvGVgUw0YmbYGh4i7T+CVpyhG2KUE
	 14wkpR6sQ6VDpZHsQuKheBTge2YWF+azWP7efM1c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 0/2] hwmon: (core) Avoid ifdef CONFIG_THERMAL in C
 source file
Date: Mon, 18 Nov 2024 07:15:57 +0100
Message-Id: <20241118-hwmon-thermal-v3-0-9c17973e7342@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ3bOmcC/3XMSw6CMBSF4a2Yjr2mvTwKjtyHcVDKxTaRYlosG
 sLeLYyMxuF/kvPNLJC3FNhxNzNP0QY7uBTZfse0Ue5KYNvUDDnmQogMzNQPDkZDvlc3wBZbVVR
 CoyxZ+tw9dfa5eedLamPDOPjXxkexrv+kKECAFCh5Q7KTCk8T2RCCNg9zcDSylYv4SRTfBAIHX
 Zcd17yu8uaXWJblDXldcxzyAAAA
X-Change-ID: 20241113-hwmon-thermal-2d2da581c276
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731910561; l=1080;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wwbsn1gz1zmNUJOUm/SsveOx12mGn+wDuAGKbxt50fU=;
 b=1zdfUsJ1IyIH/OEZafiPGR1dqdanw89Is6p7+iwGMlWwm0mhKecJHS9j7deVt/7Yf99A72Vjj
 GQZMcjzPZSOCPnVoP5TM5pI9OyKbKKNe8uxXFJiDo3sOGpN3UYyNh8p
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Replace some confusing ifdeffery with IS_ENABLED() conditionals.
The ifdefs confused me while looking at the implementation of
HWMON_C_REGISTER_TZ.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Fix warning "omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]"
- Link to v2: https://lore.kernel.org/r/20241115-hwmon-thermal-v2-0-c96f0c0984b2@weissschuh.net

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
base-commit: f66d6acccbc08b4146f4c2cf9445241f70f5517d
change-id: 20241113-hwmon-thermal-2d2da581c276

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


