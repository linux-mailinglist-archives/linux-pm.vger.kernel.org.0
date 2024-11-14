Return-Path: <linux-pm+bounces-17549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C49C84F2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C9D283F0C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6231F76A8;
	Thu, 14 Nov 2024 08:40:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B85E573;
	Thu, 14 Nov 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573648; cv=none; b=LKHvJGW1Y2c0kIwBnc84PxRQotc3JLHwSz8dSowlHrgsJdoF+zld7RFdOyDtqoCkZbRGg9ixeHsE/LcS3+cEcE1SZH/m1p19POYFmxYlc2iXpnZTSXk2YpEIuzgdERq4OnGbzJ5GdKqEpivElapYGwJrGaMCnVOCmTwEvUlPf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573648; c=relaxed/simple;
	bh=8Bq6mXfCwSPUt664VOOXNLdd1zHIpAOXfn1bu2to69Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZfr57jVIfp39Zj5iJzk5/BHNlCXna88eaaaT/k1twPy1o2C6BEba5JQtSOVX8EAMS1WtvzFAcdZZHH96slp9fjgvvmlYvgcyagxx9WDPOSJqfhA1c3g8KP8rnU9Goe98NAfhNY7BvG9sN3YNhtkFTDEV8qfoiPmrJYAzzZmnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56735b788efa-20f10;
	Thu, 14 Nov 2024 16:40:41 +0800 (CST)
X-RM-TRANSID:2ee56735b788efa-20f10
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16735b787100-b6a86;
	Thu, 14 Nov 2024 16:40:41 +0800 (CST)
X-RM-TRANSID:2ee16735b787100-b6a86
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH v2] tools/thermal: Fix common realloc mistake
Date: Thu, 14 Nov 2024 16:40:39 +0800
Message-Id: <20241114084039.42149-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

If the 'realloc' fails, the thermal zones pointer is set to NULL. This
makes all thermal zones references which were previously successfully
initialized to be lost.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
v1->v2:
	Modify commit info and use right type.

 tools/thermal/thermometer/thermometer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
index 1a87a0a77f9f..6df6ffdc571a 100644
--- a/tools/thermal/thermometer/thermometer.c
+++ b/tools/thermal/thermometer/thermometer.c
@@ -259,6 +259,7 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
 {
 	int fd;
 	char tz_path[PATH_MAX];
+	struct tz *tz;
 
 	sprintf(tz_path, CLASS_THERMAL"/%s/temp", path);
 
@@ -268,12 +269,13 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
 		return -1;
 	}
 
-	thermometer->tz = realloc(thermometer->tz,
+	tz = realloc(thermometer->tz,
 				  sizeof(*thermometer->tz) * (thermometer->nr_tz + 1));
-	if (!thermometer->tz) {
+	if (!tz) {
 		ERROR("Failed to allocate thermometer->tz\n");
 		return -1;
 	}
+	thermometer->tz = tz;
 
 	thermometer->tz[thermometer->nr_tz].fd_temp = fd;
 	thermometer->tz[thermometer->nr_tz].name = strdup(name);
-- 
2.33.0




