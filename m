Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34125399E07
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 11:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFCJtT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 05:49:19 -0400
Received: from m12-14.163.com ([220.181.12.14]:54615 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCJtS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Jun 2021 05:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=l/H8n
        C4YoHj05n2BIqJHaCdtBf6rJsdXXUyPoceBaCI=; b=TbRC8odVXPMcv5YTLjAAt
        N+rDPEE/S3Zu9HVEpnQnEUfZ1QC8ALpPgL3qVnRX1Fwb45m93HwpzDoqFHhY4Iuu
        JCsO5WMb9qka0fZBHHLhdDvTt+g3pxblVuXrEbU1M52UdPiwm2Q5QAMTODP85zXS
        wpJ/cvHUOE6Ni0FP2LriEM=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowAB3C2Awpbhgr_tpMg--.46694S2;
        Thu, 03 Jun 2021 17:47:29 +0800 (CST)
From:   Jian Xin <xinjian34324@163.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jian Xin <xinjian@yulong.com>
Subject: [PATCH] power: supply: ab8500_fg: Fix typo
Date:   Thu,  3 Jun 2021 17:47:18 +0800
Message-Id: <20210603094718.229553-1-xinjian34324@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAB3C2Awpbhgr_tpMg--.46694S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4rKr17CryxKryUtF4fZrb_yoWxtrX_ua
        1rX3W2gry5Kr1a9F1qkFnrXry09a18XFWIva17Kr43tF98ur43JFyUur1DArn5Xr4jkwsI
        9a9FyFWruryxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnfb1UUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: x0lqyxtdqtkjisu6il2tof0z/1tbiLBGmCFspaqIkBwAAsK
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jian Xin <xinjian@yulong.com>

fix misspelled 'interrupts'

Signed-off-by: Jian Xin <xinjian@yulong.com>
---
 drivers/power/supply/ab8500_fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 06ff42c71f24..64c6037cb0bc 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -58,7 +58,7 @@
 	((y1) + ((((y2) - (y1)) * ((x) - (x1))) / ((x2) - (x1))));
 
 /**
- * struct ab8500_fg_interrupts - ab8500 fg interupts
+ * struct ab8500_fg_interrupts - ab8500 fg interrupts
  * @name:	name of the interrupt
  * @isr		function pointer to the isr
  */
-- 
2.25.1

