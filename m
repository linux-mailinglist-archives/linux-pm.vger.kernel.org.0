Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C202322F0
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 18:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2Qwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 12:52:55 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:40377 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgG2Qwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 12:52:55 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Jul 2020 09:52:54 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 29 Jul 2020 09:52:54 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 884661947; Wed, 29 Jul 2020 09:52:54 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Veera Vegivada <vvegivad@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v2 1/2] thermal: qcom-spmi-temp-alarm: Don't suppress negative temp
Date:   Wed, 29 Jul 2020 09:52:51 -0700
Message-Id: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Veera Vegivada <vvegivad@codeaurora.org>

Currently driver is suppressing the negative temperature
readings from the vadc. Consumers of the thermal zones need
to read the negative temperature too. Don't suppress the
readings.

Fixes: c610afaa21d3c6e ("thermal: Add QPNP PMIC temperature alarm driver")
Signed-off-by: Veera Vegivada <vvegivad@codeaurora.org>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index bf7bae4..6dc879f 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2011-2015, 2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/bitops.h>
@@ -191,7 +191,7 @@ static int qpnp_tm_get_temp(void *data, int *temp)
 		chip->temp = mili_celsius;
 	}
 
-	*temp = chip->temp < 0 ? 0 : chip->temp;
+	*temp = chip->temp;
 
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

