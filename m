Return-Path: <linux-pm+bounces-19871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36049FF0C2
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 17:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815567A1421
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102C199234;
	Tue, 31 Dec 2024 16:51:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCD013CFA6;
	Tue, 31 Dec 2024 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735663879; cv=none; b=R6Uk3MBRyq3yQYiGhCLj7fJLO3Fy+tPKPGY+Ax2NHXVlEudhSo3e8B4L4Qa2a8ALc4jkxZOLxgseLioDzoX/gOai/59HLqxZabdgk55tFfXetv0PCDE0A4bbvqgYML3L4flxszOqI/dkK7It3A0/CbJ76/ZPsJqDtMKZqOtff08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735663879; c=relaxed/simple;
	bh=gQILtRV6Cv06NRYCVuOvVD++zVJo+wWhuhD9jGcUXhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FJTWgrT+a21DxMBtHZc6KA2xqvm070JggBOD90JEGS3Zf9vgYKJuKGVjfCW/c3/e7HM6JbgCLo5Gr6GYFnmThwgb/X2Xh3KOQ2yV9njZrL98Ki4fY16Bak8qX1Yf5+zwWjP3TMX88m3/ooDcmDKPnRYYcdKndEQ3k7hRYxeKfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93FB11476;
	Tue, 31 Dec 2024 08:51:39 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4233F6A8;
	Tue, 31 Dec 2024 08:51:09 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-sunxi@lists.linux.dev,
	Chris Morgan <macroalpha82@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "mfd: axp20x: Allow multiple regulators"
Date: Tue, 31 Dec 2024 16:51:03 +0000
Message-Id: <20241231165103.800752-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Chris and Vasily reported, the attempt to support multiple AXP PMICs
in one system [1] breaks some of the battery and charging functionality
on devices with AXP PMICs. The reason is that the drivers now fail to get
the correct IIO channel for the ADC component, as the current code seems
to rely on the zero-based enumeration of the regulator devices.
A fix is possible, but not trivial, as it requires some rework in the AXP
MFD driver, which cannot be fully reviewed or tested in time for the
6.13 release.

So revert this patch for now, to avoid regressions on battery powered
devices. This patch was really only necessary for devices with two
PMICs, support for which is not mainline yet anyway, so we don't lose
any functionality.

This reverts commit e37ec32188701efa01455b9be42a392adab06ce4.

[1] https://lore.kernel.org/linux-sunxi/20241007001408.27249-4-andre.przywara@arm.com/

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 251465a656d09..5b8e88341a305 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -1445,7 +1445,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		}
 	}
 
-	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x->cells,
+	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
 			      axp20x->nr_cells, NULL, 0, NULL);
 
 	if (ret) {
-- 
2.25.1


