Return-Path: <linux-pm+bounces-14061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C950976091
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 07:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA17B20CBC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 05:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020718786D;
	Thu, 12 Sep 2024 05:47:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396CA2119;
	Thu, 12 Sep 2024 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120060; cv=none; b=uUVgl6qr2Q0te2kDMDY12nx3veXNDQfSbtWmt/xp/d8uIFasNmTu0LEefCmPvh8NGEFd2nYRGiFjwH+MS0uqca3bMX5suVExjkSom1g7uaXeBcZ5MGCCsdgoD5yz919lmTTBlJsLpbOOKHvSc5kEbRaHAWjmIeTZb+MMCod+Fxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120060; c=relaxed/simple;
	bh=t+fk5V5nUqgzYrN0b7bpXJ8GzuBCxY4mbshzH7YG7Os=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCm8nz0lA1HjoTq2zjlzcwT0hFHmDeyeTtu4YxF+xwe5vlUXZnIDwXg9/XV/zXcEvSvERYeI6wufb50l+nyN6A1tYQ40CRy6C0OagJdoGBlOBgWKwdLZLSNZ1WZuhl+xLGs3Mc3Zy3T1oZmIn0/4Osp1Z7Bl/wzAB/tqX+DkAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766e28072576-2557c;
	Thu, 12 Sep 2024 13:47:31 +0800 (CST)
X-RM-TRANSID:2ee766e28072576-2557c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766e28072070-04678;
	Thu, 12 Sep 2024 13:47:31 +0800 (CST)
X-RM-TRANSID:2ee766e28072070-04678
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools/lib/thermal: Rm thermal.h soft link.
Date: Thu, 12 Sep 2024 12:50:31 +0800
Message-Id: <20240912045031.18426-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Run "make -C tools thermal" can create a soft link
for thermal.h in tools/include/uapi/linux.
Just rm it when make clean.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/lib/thermal/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index 2d0d255fd0e1..8890fd57b110 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -121,7 +121,9 @@ all: fixdep
 
 clean:
 	$(call QUIET_CLEAN, libthermal) $(RM) $(LIBTHERMAL_A) \
-                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBTHERMAL_VERSION) .*.d .*.cmd LIBTHERMAL-CFLAGS $(LIBTHERMAL_PC)
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBTHERMAL_VERSION) \
+                .*.d .*.cmd LIBTHERMAL-CFLAGS $(LIBTHERMAL_PC) \
+                $(srctree)/tools/$(THERMAL_UAPI)
 
 $(LIBTHERMAL_PC):
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
-- 
2.33.0




