Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142A41814C2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 10:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgCKJ1V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 05:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:55604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgCKJ1V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 05:27:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 92B71AEFF;
        Wed, 11 Mar 2020 09:27:19 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] thermal: int340x_thermal: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 10:27:18 +0100
Message-Id: <20200311092718.24052-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index efae0c02d898..529df7174239 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -65,7 +65,7 @@ static ssize_t available_uuids_show(struct device *dev,
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
 		if (priv->uuid_bitmap & (1 << i))
 			if (PAGE_SIZE - length > 0)
-				length += snprintf(&buf[length],
+				length += scnprintf(&buf[length],
 						   PAGE_SIZE - length,
 						   "%s\n",
 						   int3400_thermal_uuids[i]);
-- 
2.16.4

