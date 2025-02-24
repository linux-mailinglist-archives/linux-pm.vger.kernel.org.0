Return-Path: <linux-pm+bounces-22835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE11A429EF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 18:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0297A5DC3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD42661AA;
	Mon, 24 Feb 2025 17:34:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73963265CD3;
	Mon, 24 Feb 2025 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418497; cv=none; b=AcRfU6GYdKIJRhfKnzeJvq8dN59BwtLlD25C1LsyXabUn3tTQw1fG8bZkwZ33c8Qva3eJOIoX3908JzuBGfdgf0zJ0e6nLLC9oJQOIhEksqzPfC+bIhHHx8Ov+vuVRsDZT5Q9fAgDKKmXUQ8hZUzjG3HIxiZNVxBqC3eoEc7Jag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418497; c=relaxed/simple;
	bh=4FN3Kso8IEB/8nRwPwS1e0s0rSpmccUC6yRgfCqU3tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyuKbzwAjyxPzZbPtrdi/HPCkZY1z3fsl+m7RtpClDw237NSX7gwhWG0vipcrhEE2GswkT9dw8fYE1ZfEeWm2AC63qq+0racZ9/w4qrci2Ef39R/PL9dFbXkDJXQkZTE9DsTFKyC8UBsykBJFz/Zjn1G7FdM0hmBvMpfNuSkruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF63152B;
	Mon, 24 Feb 2025 09:35:08 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.65.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 242AB3F5A1;
	Mon, 24 Feb 2025 09:34:49 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: lukasz.luba@arm.com,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 3/4] thermal: int340x: Use kcalloc() instead of kzalloc() with multiplication
Date: Mon, 24 Feb 2025 17:33:05 +0000
Message-ID: <20250224173432.1946070-4-lukasz.luba@arm.com>
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
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 8dca6a6aceca1..2d672c4be3ce5 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -133,8 +133,8 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	if (ACPI_SUCCESS(status))
 		int34x_zone->aux_trip_nr = trip_cnt;
 
-	zone_trips = kzalloc(sizeof(*zone_trips) * (trip_cnt + INT340X_THERMAL_MAX_TRIP_COUNT),
-			     GFP_KERNEL);
+	zone_trips = kcalloc(trip_cnt + INT340X_THERMAL_MAX_TRIP_COUNT,
+			     sizeof(*zone_trips), GFP_KERNEL);
 	if (!zone_trips) {
 		ret = -ENOMEM;
 		goto err_trips_alloc;
-- 
2.48.1


