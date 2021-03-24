Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86934729F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 08:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhCXH3n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 03:29:43 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:43052 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhCXH32 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 03:29:28 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 3D8F798040B;
        Wed, 24 Mar 2021 15:29:25 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: linux: pm: Remove duplicate declaration
Date:   Wed, 24 Mar 2021 15:29:11 +0800
Message-Id: <20210324072912.737621-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUseGBpKGBpKSklLVkpNSk1OTEtCTU5OQk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OEk6Tzo*ED8QSzhCMEwCKg02
        Gj4wCRdVSlVKTUpNTkxLQk1NT0xNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT0xNNwY+
X-HM-Tid: 0a7863235dbdd992kuws3d8f798040b
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

struct device is declared twice.So remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/pm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 482313a8ccfc..c9657408fee1 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -39,7 +39,6 @@ static inline void pm_vt_switch_unregister(struct device *dev)
  * Device power management
  */
 
-struct device;
 
 #ifdef CONFIG_PM
 extern const char power_group_name[];		/* = "power" */
-- 
2.25.1

