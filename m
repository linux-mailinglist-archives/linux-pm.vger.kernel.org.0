Return-Path: <linux-pm+bounces-16441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DBA9AFEC0
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 11:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEE9284758
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94071D26F9;
	Fri, 25 Oct 2024 09:47:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAE712FB1B;
	Fri, 25 Oct 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849621; cv=none; b=uH3lfJDTpZ7nFhjAlHmRLpI58FtdAEkXs9Y2ZHU0oTuQ0zgPRRu/dC7Bd0WGsQ/oFnn3lqdJNRgC/4tuZIk4C+sJTO+wxjrUMBvtou5tvnwIarYQleAmRBk/GwxYupys+9UUmv5DaAHqZh9wwSXeXWH5iLtEd5Z4dIhwzn8JUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849621; c=relaxed/simple;
	bh=y+SBzjIIn19qEmS5GIgWwnWVEOEv+/x85ElFQ3XTVQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pdFjfjnQw3Y4IXqNimrANyb8wcfojXdM0n4zagNSMr3rKmWT7cCU2RC28SYJETu2fcwMmxYqG2I4OzoXaQv1+CHl1odHv6XpNp7xSU00HlkmoT8dwQTO0i1sDey35ZaOpht20Lh7M/f1Fv+C+VY9O0Zj9LsAXMi3Tz8kz+KN9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7671b690da0d-7ca22;
	Fri, 25 Oct 2024 17:46:53 +0800 (CST)
X-RM-TRANSID:2ee7671b690da0d-7ca22
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1671b68ff7b3-33043;
	Fri, 25 Oct 2024 17:46:53 +0800 (CST)
X-RM-TRANSID:2ee1671b68ff7b3-33043
From: Ba Jing <bajing@cmss.chinamobile.com>
To: ssantosh@kernel.org
Cc: sre@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] reset: keystone-reset: remove unused macros
Date: Fri, 25 Oct 2024 17:06:59 +0800
Message-Id: <20241025090659.33458-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After reviewing the code, it was found that these macros are never
referenced in the code. Just remove them.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/power/reset/keystone-reset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index dbc4ff61cd74..cfaa54ced0d0 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -16,7 +16,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 
-#define RSTYPE_RG			0x0
 #define RSCTRL_RG			0x4
 #define RSCFG_RG			0x8
 #define RSISO_RG			0xc
@@ -28,7 +27,6 @@
 #define RSMUX_OMODE_MASK		0xe
 #define RSMUX_OMODE_RESET_ON		0xa
 #define RSMUX_OMODE_RESET_OFF		0x0
-#define RSMUX_LOCK_MASK			0x1
 #define RSMUX_LOCK_SET			0x1
 
 #define RSCFG_RSTYPE_SOFT		0x300f
-- 
2.33.0




