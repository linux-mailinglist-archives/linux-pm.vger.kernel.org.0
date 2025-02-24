Return-Path: <linux-pm+bounces-22841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB86A42D35
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 20:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46BF18881D6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 19:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AAA2063EA;
	Mon, 24 Feb 2025 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lSBGMgSM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6487136327;
	Mon, 24 Feb 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427140; cv=none; b=MMTzTDzkMNkmkpruwhb4L5OZyLFr5KVc4AbfCUbqrVvrF/Vj4lSsXnh+NR2/ZM7IUTsIgERd7CoU1x45vU4Md+qDcLRyMJ77TeVC2IuhKQRIojQBnqhj+4Kx7ZM5zhIVL95OjtRiukw4JnPY6jD2/SKDSr39OvAO4Hdy29p4U8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427140; c=relaxed/simple;
	bh=fWCZLO7EKR4DOPrWOUXgbX4igVnp3NTdUsv32c2M+X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eK4jc0f++aiL4258pJ88mM7W2MnZTfsYIT005Blcww9IN8CR74OeGkjVNQQJGBvyoLRYDO05nwoEyHIlqHPziouu9B22sifE/i5JPjCQFhWqLug+dN1DbPVCf0+OUrQ1PdjnbGnGctTFZi3nHDukkUtPxQVFNgXiuuA3hYPFrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lSBGMgSM; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id meSLt3GDwJyOhmeSPtGswC; Mon, 24 Feb 2025 20:49:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740426579;
	bh=TYkhntDhg6zE2Z9rvZA/FjSywjAnJEg0AG/RXj5Cj1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lSBGMgSMfFY2R+JdkvLMGe2zWfxig9natjAOM4rxrWscn60b5LMO+ZS3u1Xe5Ekev
	 1CvRH93p4Yd9EpqVtYBGU6Jp4WhutYyiDeJbim0UAq+bamEeDLoIfeGXleFZ9i5eWR
	 argVhLUHy4C8W7QR24QpctGtYri85t4yoAid5HMWGJ9It5oKL4eOzDXSE7iSEKKEVo
	 3RU2KCqZBjh1vjdyMbnDyWX3eCo3PM2XQh4RYmdISJilAvW8xQWhRiFrkum9b+anhN
	 FBOTbRiEt09JWr3T4W3ryk9fr0iGMynSOU3aGeYt3SHKzxLdc7+mjbdpHDvMps5eai
	 Vw9liiq/fSqGw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Feb 2025 20:49:39 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: intel: Remove a useless operation in int340x_thermal_zone_add()
Date: Mon, 24 Feb 2025 20:49:28 +0100
Message-ID: <cceb7f8864c43f046cf1c19c3bbcc38a7a57adc5.1740426540.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'zone_trips' has just been allocated with kzalloc(), so .flags is known to
be 0. Remove the useless | when assigning THERMAL_TRIP_FLAG_RW_TEMP.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This was added in commit cca52f696952 ("thermal: intel: Set
THERMAL_TRIP_FLAG_RW_TEMP directly")
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 8dca6a6aceca..b43d848e66b8 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -143,7 +143,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	for (i = 0; i < trip_cnt; i++) {
 		zone_trips[i].type = THERMAL_TRIP_PASSIVE;
 		zone_trips[i].temperature = THERMAL_TEMP_INVALID;
-		zone_trips[i].flags |= THERMAL_TRIP_FLAG_RW_TEMP;
+		zone_trips[i].flags = THERMAL_TRIP_FLAG_RW_TEMP;
 		zone_trips[i].priv = THERMAL_INT_TO_TRIP_PRIV(i);
 	}
 
-- 
2.48.1


