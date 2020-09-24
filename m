Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B953276915
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 08:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgIXGiH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 02:38:07 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:28788 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgIXGiH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 02:38:07 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 3C6354E1837;
        Thu, 24 Sep 2020 14:38:04 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] power: fix spelling typo
Date:   Thu, 24 Sep 2020 14:37:56 +0800
Message-Id: <1600929478-26554-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTEMZHU1MHhlJHkNLVkpNS0tCSUJPQ09PQ0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NT46Ihw5GT8sHgMPKigiOD0O
        FRBPCh5VSlVKTUtLQklCT0NPQk9LVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTUxINwY+
X-HM-Tid: 0a74bed54e569376kuws3c6354e1837
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Modify the comment typo: "compliment" -> "complement".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/power/supply/ab8500_fg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 7eec415..592a73d
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -653,7 +653,7 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res)
 
 	/*
 	 * negative value for Discharging
-	 * convert 2's compliment into decimal
+	 * convert 2's complement into decimal
 	 */
 	if (high & 0x10)
 		val = (low | (high << 8) | 0xFFFFE000);
@@ -781,7 +781,7 @@ static void ab8500_fg_acc_cur_work(struct work_struct *work)
 	if (ret < 0)
 		goto exit;
 
-	/* Check for sign bit in case of negative value, 2's compliment */
+	/* Check for sign bit in case of negative value, 2's complement */
 	if (high & 0x10)
 		val = (low | (med << 8) | (high << 16) | 0xFFE00000);
 	else
-- 
2.7.4

