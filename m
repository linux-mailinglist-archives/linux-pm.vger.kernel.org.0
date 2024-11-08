Return-Path: <linux-pm+bounces-17171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412259C1680
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 07:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF1B2830E0
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC241CCB49;
	Fri,  8 Nov 2024 06:39:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243BBEBE;
	Fri,  8 Nov 2024 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047975; cv=none; b=CB40j5S0JD1H2d0MvR00NCTbVhmD1hwH133JBb+XSh3DVm370ZChJ8L7B8Dz0zghS3ydV8dGtn0BWKVUX/flUBU+ODBJN3XpviOGc9cHNog/a1cs6Nu/Ie2RO4/mM8WPfOU7l2fZkuKMrP+xq5YGA68dmi4cUcfgha/M56+JCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047975; c=relaxed/simple;
	bh=Y267l0BUqqgJmxGvfXbT0PmHmIKaH+mSx4D3GnoS1zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rX1L8DPV7AgYI1ZQTW4+JbASfCG7PSZRTslxU530bEGpYB5crcmN2onjupBVxEunwNLRPG1AaLETS+f9b+MvsPiUyuVnkGgokzdn9VPLE9CV5/8H8yvSAH4pL4l+UiveNyxbt15Q9FHQSV/HqJwfLUwO7DWzDS/R+z3r8c5lkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1672db21d641-bff53;
	Fri, 08 Nov 2024 14:39:27 +0800 (CST)
X-RM-TRANSID:2ee1672db21d641-bff53
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5672db21ec48-8c35a;
	Fri, 08 Nov 2024 14:39:26 +0800 (CST)
X-RM-TRANSID:2ee5672db21ec48-8c35a
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools/thermal: Fix common realloc mistake
Date: Fri,  8 Nov 2024 12:47:00 +0800
Message-Id: <20241108044700.37633-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Do not set thermometer->tz NULL when realloc failed.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/thermal/thermometer/thermometer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
index 1a87a0a77f9f..e08291a97fd8 100644
--- a/tools/thermal/thermometer/thermometer.c
+++ b/tools/thermal/thermometer/thermometer.c
@@ -259,6 +259,7 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
 {
 	int fd;
 	char tz_path[PATH_MAX];
+	void *tmp;
 
 	sprintf(tz_path, CLASS_THERMAL"/%s/temp", path);
 
@@ -268,12 +269,13 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
 		return -1;
 	}
 
-	thermometer->tz = realloc(thermometer->tz,
+	tmp = realloc(thermometer->tz,
 				  sizeof(*thermometer->tz) * (thermometer->nr_tz + 1));
-	if (!thermometer->tz) {
+	if (!tmp) {
 		ERROR("Failed to allocate thermometer->tz\n");
 		return -1;
 	}
+	thermometer->tz = tmp;
 
 	thermometer->tz[thermometer->nr_tz].fd_temp = fd;
 	thermometer->tz[thermometer->nr_tz].name = strdup(name);
-- 
2.33.0




