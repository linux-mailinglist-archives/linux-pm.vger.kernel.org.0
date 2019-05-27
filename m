Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C882B913
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 18:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfE0Q3c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 12:29:32 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.163]:14263 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbfE0Q3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 12:29:32 -0400
X-Greylist: delayed 1263 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 12:29:32 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D3F86138DD
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2019 11:08:27 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VIAlhCyJt4FKpVIAlhYZg4; Mon, 27 May 2019 11:08:27 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=33436 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hVIAk-001oQ4-O2; Mon, 27 May 2019 11:08:26 -0500
Date:   Mon, 27 May 2019 11:08:25 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] thermal: tsens: Remove unnecessary comparison of unsigned
 integer with < 0
Message-ID: <20190527160825.GA24219@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hVIAk-001oQ4-O2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:33436
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need to compare hw_id with < 0 because such comparison
of an unsigned value is always false.

Fix this by removing such comparison.

Addresses-Coverity-ID: 1445440 ("Unsigned compared against 0")
Fixes: 3e6a8fb33084 ("drivers: thermal: tsens: Add new operation to check if a sensor is enabled")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/thermal/qcom/tsens-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 928e8e81ba69..94878ad35464 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -69,7 +69,7 @@ bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
 	u32 val;
 	int ret;
 
-	if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
+	if (hw_id > priv->num_sensors - 1)
 		return -EINVAL;
 	ret = regmap_field_read(priv->rf[SENSOR_EN], &val);
 	if (ret)
-- 
2.21.0

