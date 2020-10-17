Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0AB291088
	for <lists+linux-pm@lfdr.de>; Sat, 17 Oct 2020 09:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437471AbgJQHbD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Oct 2020 03:31:03 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:60699 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411853AbgJQHbB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2020 03:31:01 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2020 03:31:01 EDT
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 2702C48275B;
        Sat, 17 Oct 2020 10:44:57 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drivers/thermal: remove unnecessary structure members allocated_tzp
Date:   Fri, 16 Oct 2020 19:44:49 -0700
Message-Id: <20201017024449.37377-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHUoeSkkaSE1OQx5MVkpNS0lCS0lNQkxIT0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OQw6Iio*AT8ZGTMiFjI8Dhg9
        FwpPFElVSlVKTUtJQktJTUJMTExPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSUJCSzcG
X-HM-Tid: 0a753472254793bakuws2702c48275b
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Struct power_allocator_params element allocated_tzp is only used
in unbind to kfree the kzalloc space.
Maybe we don’t have to need this member to mark, also, kfree will
handle NULL point, there is no risk.
This change is to make the code run a bit fast.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/thermal/gov_power_allocator.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 5cb518d8f156..e4672a94e6b1 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -51,8 +51,6 @@ static inline s64 div_frac(s64 x, s64 y)
 
 /**
  * struct power_allocator_params - parameters for the power allocator governor
- * @allocated_tzp:	whether we have allocated tzp for this thermal zone and
- *			it needs to be freed on unbind
  * @err_integral:	accumulated error in the PID controller.
  * @prev_err:	error in the previous iteration of the PID controller.
  *		Used to calculate the derivative term.
@@ -65,7 +63,6 @@ static inline s64 div_frac(s64 x, s64 y)
  *					controlling for.
  */
 struct power_allocator_params {
-	bool allocated_tzp;
 	s64 err_integral;
 	s32 prev_err;
 	int trip_switch_on;
@@ -556,8 +553,6 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 			ret = -ENOMEM;
 			goto free_params;
 		}
-
-		params->allocated_tzp = true;
 	}
 
 	if (!tz->tzp->sustainable_power)
@@ -593,10 +588,8 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 
 	dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
 
-	if (params->allocated_tzp) {
-		kfree(tz->tzp);
-		tz->tzp = NULL;
-	}
+	kfree(tz->tzp);
+	tz->tzp = NULL;
 
 	kfree(tz->governor_data);
 	tz->governor_data = NULL;
-- 
2.28.0

