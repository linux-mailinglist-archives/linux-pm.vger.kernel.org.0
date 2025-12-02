Return-Path: <linux-pm+bounces-39062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A3C9B5BF
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 12:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1613934157E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6028D84F;
	Tue,  2 Dec 2025 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XclRLEbV"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D25201033
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676247; cv=none; b=S1VG4Exvn9R7ZWAReLfFHFfaKw4K00cnMjql4Op0tGaog73/nhGLgWu6mjmfubcqwImNHWrdy2cLcJ4nsVuwk+oSk9fug3fzsmzTgwNIr5wX98cjAzpwky/5qA/K0PSIhMBP/woVO7vzue3kLKytC7eRj7KLNjzrmBd3Bpn+gg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676247; c=relaxed/simple;
	bh=yBi+nP/opDiWlOt8Eq/LFEECBJLf3VrAWsvOWSBTk7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xfrx5IgEcuAfjMTz5WIN7HFRDk+lsyz2lc3PqkwjLkPBDDtFZLWRJLDQp4GQqlUau7quycC23IuNoM+rgvPjvO6RmsiPfJwv9oY95W4gHE5Paxsww5e88G8PcM0J/98Ucx6FTBMdiw3XGpaO5uz7mNOchLErJhBcnWqsJlhV1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XclRLEbV; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764676243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uu0oTM2zB/ypMQp9kI3DuIVgZil2XGchs7rGpG8lU8Y=;
	b=XclRLEbVUeZs1+CKRrHJczUEjULJqLBTOLo+O1R0/lE978awlvuKsVgp25QrM+LPoR52RQ
	Ueq1HW+boWJnbDYgwspYnSoq2Htkk/JVm0bf+uB9wPkWHfiFfdtRIAZHdYxgNxiEcs6nrs
	BllDDDfB6ot39ecUw7uv1mq2kIge+dg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: sprd: Use min instead of clamp in sprd_thm_temp_to_rawdata
Date: Tue,  2 Dec 2025 12:50:33 +0100
Message-ID: <20251202115034.375174-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Clamping 'val' to itself is unnecessary and the expression can be
simplified by using min() instead. Casting SPRD_THM_RAW_DATA_HIGH to u32
is also redundant and can be removed.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/sprd_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index 44fa45f74da7..d683fcb0f8ab 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -201,7 +201,7 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 	 */
 	val = (temp + sen->cal_offset) / sen->cal_slope;
 
-	return clamp(val, val, (u32)(SPRD_THM_RAW_DATA_HIGH - 1));
+	return min(val, SPRD_THM_RAW_DATA_HIGH - 1);
 }
 
 static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


