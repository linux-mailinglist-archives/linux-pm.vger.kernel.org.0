Return-Path: <linux-pm+bounces-17861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356AB9D4DCA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 14:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B810B213C5
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0DA1D0E00;
	Thu, 21 Nov 2024 13:32:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1260E2628D;
	Thu, 21 Nov 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732195940; cv=none; b=Xf1yITCu0vkS1tKGY2QZsm8GVsJqBeSKHIjSqFriLrhtXg5arV6M6l8U+/mIHxVaWFJ97Rq6qOMJJ7AzVFZPCNrLJeBHpvbT5OZwtVgNSuZ0pNohY46G0okWsodo/ncRRrDLq2U49NlsIlGs+PTLQG/7nqIUM0Jcr8XIfO1ufTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732195940; c=relaxed/simple;
	bh=tRv+q15Ih9uBY+jN2IVBw8AHYaMRhYGKYbNAobIYtRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ifxj664h+sLUqppJIllJubC9/ECNomRBy4+9nqvoCFhWctHVSCTXBzDDodDHMGDiNB821sK2FtamQWJOqofTpcvGoKHcmQUzT5tRGIwn+S5lnh9QFXvnMIReh1g18lwhwpw2PleOA+M+JCr3LaEMPhQ4qjzsMq+LKiq9MrI2yXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6673f3657c8b-2e55c;
	Thu, 21 Nov 2024 21:32:14 +0800 (CST)
X-RM-TRANSID:2ee6673f3657c8b-2e55c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.69])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4673f365bbb5-c25b8;
	Thu, 21 Nov 2024 21:32:13 +0800 (CST)
X-RM-TRANSID:2ee4673f365bbb5-c25b8
From: liujing <liujing@cmss.chinamobile.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] cpupower: Fixing memory leaks
Date: Thu, 21 Nov 2024 21:32:12 +0800
Message-Id: <20241121133212.6809-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If execlp fails, page memory is not freed, so fix it.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 9ec973165af1..36d486199630 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -98,7 +98,7 @@ static int print_man_page(const char *subpage)
 	}
 
 	execlp("man", "man", page, NULL);
-
+	free(page);
 	/* should not be reached */
 	return -EINVAL;
 }
-- 
2.27.0




