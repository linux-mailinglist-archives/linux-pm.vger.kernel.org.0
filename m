Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD02B64B6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 14:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgKQNsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 08:48:38 -0500
Received: from foss.arm.com ([217.140.110.172]:57912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387658AbgKQNsh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 08:48:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 180BF101E;
        Tue, 17 Nov 2020 05:48:37 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.25.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 220C13F718;
        Tue, 17 Nov 2020 05:48:34 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, rjw@rjwysocki.net, lukasz.luba@arm.com
Subject: [PATCH v2] powercap: Adjust printing the constraint name with new line
Date:   Tue, 17 Nov 2020 13:47:59 +0000
Message-Id: <20201117134759.26797-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The constrain name has limit of size 30, which sometimes might be hit.
When this happens the new line might get lost. Prevent this and set the
max limit for name string length equal 29. This would result is proper
string clamping (when needed) and storing '\n' at index 29 and '\0' at 30,
so similarly as desired originally.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi Rafael,

It is based on top of you current pm/linux-next branch.

Change log:
v2:
- switched to sprintf() with "%.*s\n" pattern
v1 [1]

Regards,
Lukasz

[1] https://lore.kernel.org/linux-pm/20201109172452.6923-1-lukasz.luba@arm.com/


 drivers/powercap/powercap_sys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 3f0b8e2ef3d4..f0654a932b37 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -170,9 +170,8 @@ static ssize_t show_constraint_name(struct device *dev,
 	if (pconst && pconst->ops && pconst->ops->get_name) {
 		name = pconst->ops->get_name(power_zone, id);
 		if (name) {
-			snprintf(buf, POWERCAP_CONSTRAINT_NAME_LEN,
-								"%s\n", name);
-			buf[POWERCAP_CONSTRAINT_NAME_LEN] = '\0';
+			sprintf(buf, "%.*s\n", POWERCAP_CONSTRAINT_NAME_LEN - 1,
+				name);
 			len = strlen(buf);
 		}
 	}
-- 
2.17.1

