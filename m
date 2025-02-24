Return-Path: <linux-pm+bounces-22834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C73A42A01
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 18:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604141896E0B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AAF266188;
	Mon, 24 Feb 2025 17:34:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A2264A88;
	Mon, 24 Feb 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418496; cv=none; b=g8yK/OYXuudx/x/1AZ3fs1+LgUjeppTMt4nVqtI5idvCtlzGRLsNgdoAIv39SzbRZMk0ebqgR/69HcCR2Le/IiES/QrMdRw+MUpIl3H023P1r/dAwvwWt4jK5PwrofPbb9zhN/KT1Wk8ukUsAZxHZY9MLIAxqQRtkEcGuxJ5H1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418496; c=relaxed/simple;
	bh=b5ZVC40DDyXz6JHdlPQVXaMyUJ8Y1KOTGrt2hfJI5z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBMnquIN9TGHclC4kcnZzwFaFjeWTFMPjHWEb8CIJc0SEPc3M52S4eE1/pH0gI0E9hasiEE46HvUlAzDEM5ZbU4A1B5+LjWkJM80zOn0x0hls9yJyV53Azr+eTk6ECA4ninWU5sA/fbyWcLX/+E05g4TzLmHDR7PFMLvJD54GP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E56F1756;
	Mon, 24 Feb 2025 09:35:10 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.65.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 471893F5A1;
	Mon, 24 Feb 2025 09:34:52 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: lukasz.luba@arm.com,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 4/4] thermal: hisi: Use kcalloc() instead of kzalloc() with multiplication
Date: Mon, 24 Feb 2025 17:33:06 +0000
Message-ID: <20250224173432.1946070-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224173432.1946070-1-lukasz.luba@arm.com>
References: <20250224173432.1946070-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the latest recommendations, kcalloc() should be used instead
of kzalloc() with multiplication (which might overflow).
Switch to this new scheme and use more safe kcalloc().

No functional impact changes.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/hisi_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 7e918bd3f1002..4307161533a78 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -412,8 +412,8 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 
 	data->nr_sensors = 1;
 
-	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
-				    data->nr_sensors, GFP_KERNEL);
+	data->sensor = devm_kcalloc(dev, data->nr_sensors,
+				    sizeof(*data->sensor), GFP_KERNEL);
 	if (!data->sensor)
 		return -ENOMEM;
 
-- 
2.48.1


