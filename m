Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63E22F92A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgG0TfY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 15:35:24 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:1127 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgG0TfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 15:35:23 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jul 2020 12:35:23 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 27 Jul 2020 12:35:23 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 1EF081581; Mon, 27 Jul 2020 12:35:23 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Veera Vegivada <vvegivad@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v1 2/2] thermal: qcom-spmi-temp-alarm: Don't suppress negative temp
Date:   Mon, 27 Jul 2020 12:35:19 -0700
Message-Id: <6bb66f529eaab58b3a75eea3386233cbca27f818.1595878198.git.gurus@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <f22bb151d836f924b09cf80ffd6e58eb286be5d6.1595878198.git.gurus@codeaurora.org>
References: <f22bb151d836f924b09cf80ffd6e58eb286be5d6.1595878198.git.gurus@codeaurora.org>
In-Reply-To: <f22bb151d836f924b09cf80ffd6e58eb286be5d6.1595878198.git.gurus@codeaurora.org>
References: <f22bb151d836f924b09cf80ffd6e58eb286be5d6.1595878198.git.gurus@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Veera Vegivada <vvegivad@codeaurora.org>

Currently driver is suppressing the negative temperature
readings from the vadc. Consumers of the thermal zones need
to read the negative temperature too. Don't suppress the
readings.

Signed-off-by: Veera Vegivada <vvegivad@codeaurora.org>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
Apologies for resending - My earlier two submissions were directed to the wrong
reviewer audience and list.

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 05a9601..6d8f090 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2011-2015, 2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/bitops.h>
@@ -212,7 +212,7 @@ static int qpnp_tm_get_temp(void *data, int *temp)
 		chip->temp = mili_celsius;
 	}
 
-	*temp = chip->temp < 0 ? 0 : chip->temp;
+	*temp = chip->temp;
 
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

