Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95C72A22E8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 03:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgKBCMA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 21:12:00 -0500
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:7021 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgKBCMA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 21:12:00 -0500
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id CE486482B20;
        Mon,  2 Nov 2020 10:11:57 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drivers/thermal: fix potential memleak in error branch
Date:   Sun,  1 Nov 2020 18:11:48 -0800
Message-Id: <20201102021149.3047-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSBoYSU8YTR9LGUwYVkpNS09JQ0hKSkNLSEpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46Kww*Cz8pHSEPLR0UAjID
        LywwCUlVSlVKTUtPSUNISkpDT0xCVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5MWVdZCAFZQUpNQ0g3Bg++
X-HM-Tid: 0a7586b9b19593bakuwsce486482b20
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Function __thermal_cooling_device_register, when device_register
failed, cdev is not free after error value return, this may
bring in potential memleak.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3d1e0033bf3e..e4bee15dfa1f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1125,6 +1125,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (result) {
 		ida_simple_remove(&thermal_cdev_ida, cdev->id);
 		put_device(&cdev->device);
+		kfree(cdev);
 		return ERR_PTR(result);
 	}
 
-- 
2.29.0

