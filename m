Return-Path: <linux-pm+bounces-20104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB95A06264
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 17:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05887163D77
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC881FF5E3;
	Wed,  8 Jan 2025 16:44:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1FE1FF1CF;
	Wed,  8 Jan 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354648; cv=none; b=BSBG3eBYfHTD6xwCSiz5ZOwyqqUuuHINXnxrWqAWXxtp3Q6rAar/xy/pBHqkSAC0rNcYWgnMVqXwnAmWlqjSrRp3DEpk3o0pDqOXoSm0GxxC8feaeX0O3bX4Flv1k9EuvCoq2izGbZGmvL/HUnCF1Jc3ezrIbN5uLxrh1N+BUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354648; c=relaxed/simple;
	bh=xHy/5lzq2/xkdX7uQZHL90Ap3bZIuqwrobQifirHEiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCpUwAsqEOznohm+wABKfOyP866dqTQoWp+/wXaIxhZmeJQC9ArhsWQKNYXFcc3aoMjJYUK9ssri2UR+vjcaf+KG5VWa21DWD3LWDgeZWAatN0LLlZeOjYZ7adEunuAu3qbp6tBZwvg8dU25F9j28jToJwwaEwDto9i5Xu+N+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73AAF13D5;
	Wed,  8 Jan 2025 08:44:34 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61DB63F66E;
	Wed,  8 Jan 2025 08:44:04 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-sunxi@lists.linux.dev,
	Chris Morgan <macroalpha82@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "mfd: axp20x: Allow multiple regulators"
Date: Wed,  8 Jan 2025 16:43:59 +0000
Message-Id: <20250108164359.2609078-1-andre.przywara@arm.com>
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

Reported-by: Chris Morgan <macroalpha82@gmail.com>
Closes: https://lore.kernel.org/linux-sunxi/675489c1.050a0220.8d73f.6e90@mx.google.com/
Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
Closes: https://lore.kernel.org/linux-sunxi/CA+E=qVf8_9gn0y=mcdKXvj2PFoHT2eF+JN=CmtTNdRGaSnpgKg@mail.gmail.com/
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

just replacing the old -1 with the respective macro name, as Lee asked
for. Also adding tags to acknowledge the reporters.
Lee, feel free to change the subject line if you think the "Revert" in
there is not justified anymore.

Cheers,
Andre

Changes v1 .. v2:
- use proper name for the formely used -1 value
- add Reported-by: tags

 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 251465a656d09..bce85a58944ac 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -1445,7 +1445,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		}
 	}
 
-	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x->cells,
+	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_NONE, axp20x->cells,
 			      axp20x->nr_cells, NULL, 0, NULL);
 
 	if (ret) {
-- 
2.25.1


