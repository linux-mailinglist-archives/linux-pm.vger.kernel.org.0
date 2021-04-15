Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82707360066
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 05:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhDODZs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 23:25:48 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:36072 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDODZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Apr 2021 23:25:44 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id A5F024003CA;
        Thu, 15 Apr 2021 11:25:20 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] power: reset: Remove unneeded semicolon
Date:   Thu, 15 Apr 2021 11:24:56 +0800
Message-Id: <20210415032456.24070-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGRhKSVYeHk1JTUNLSk8eSE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6NRw4Cj8RFhM#HhApKTZK
        VikaCQFVSlVKTUpDT05MSklKSk1OVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0tNNwY+
X-HM-Tid: 0a78d38fd057d991kuwsa5f024003ca
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following coccicheck warning:

./drivers/power/reset/vexpress-poweroff.c:136:2-3: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/power/reset/vexpress-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 1fdbcbd95fc2..447ffdacddf9 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -133,7 +133,7 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	case FUNC_REBOOT:
 		ret = _vexpress_register_restart_handler(&pdev->dev);
 		break;
-	};
+	}
 
 	return ret;
 }
-- 
2.25.1

