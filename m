Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE20345574
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 03:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCWC0K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 22:26:10 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:47238 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCWC0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 22:26:10 -0400
X-Greylist: delayed 678 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2021 22:26:09 EDT
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 40609980492;
        Tue, 23 Mar 2021 10:14:48 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] thermal: ti-soc-thermal: of_device.h is included twice
Date:   Tue, 23 Mar 2021 10:14:30 +0800
Message-Id: <20210323021430.141218-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTh4fGkJISh1LSB9JVkpNSk1PTU5NQ0NNS09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K006Czo4FD8RLDoJEEgiNDUw
        PTYKCT9VSlVKTUpNT01OTUNDQ0NIVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0tNNwY+
X-HM-Tid: 0a785cdcf7bed992kuws40609980492
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

linux/of_device.h has been included at line 25, so remove 
the duplicate one at line 35.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 8a3646e26ddd..d81af89166d2 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -32,7 +32,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "ti-bandgap.h"
 
-- 
2.25.1

