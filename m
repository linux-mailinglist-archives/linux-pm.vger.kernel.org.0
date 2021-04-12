Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C457535C2AE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbhDLJrO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 05:47:14 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:21872 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbhDLJhP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 05:37:15 -0400
Received: from wanjb-KLV-WX9.. (unknown [123.131.141.119])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 5E397400290;
        Mon, 12 Apr 2021 17:36:46 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] thermal: tmon: Remove unneeded variable
Date:   Mon, 12 Apr 2021 17:35:22 +0800
Message-Id: <20210412093522.29647-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0NLH1ZMQx9KHkJJGExLHUpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTY6Dio*Hj8QMB8rSEoOOCgj
        Vg0aFA1VSlVKTUpDSUlLSUtMSkpMVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlK
        SUhVSkhKVUpPSlVKSkJZV1kIAVlBSk1NSTcG
X-HM-Tid: 0a78c570ca2bd991kuws5e397400290
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix coccicheck warning:

tools/thermal/tmon/pid.c:57:5-8:
Unneeded variable: ret. Return 0 on line 68

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/thermal/tmon/pid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/thermal/tmon/pid.c b/tools/thermal/tmon/pid.c
index c54edb4f630c..cbacd3b438b2 100644
--- a/tools/thermal/tmon/pid.c
+++ b/tools/thermal/tmon/pid.c
@@ -54,8 +54,6 @@ static double xk_1, xk_2; /* input temperature x[k-#] */
  */
 int init_thermal_controller(void)
 {
-	int ret = 0;
-
 	/* init pid params */
 	p_param.ts = ticktime;
 	/* TODO: get it from TUI tuning tab */
@@ -65,7 +63,7 @@ int init_thermal_controller(void)
 
 	p_param.t_target = target_temp_user;
 
-	return ret;
+	return 0;
 }
 
 void controller_reset(void)
-- 
2.30.2

