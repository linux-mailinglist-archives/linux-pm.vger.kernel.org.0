Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91328B8F6
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390470AbgJLN4c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 09:56:32 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:42461 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390558AbgJLN4W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 09:56:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4745978|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0102361-0.00261358-0.98715;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.IiEO.rd_1602510932;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IiEO.rd_1602510932)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 12 Oct 2020 21:55:47 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        rjw@rjwysocki.net, jcrouse@codeaurora.org, eric@anholt.net,
        tiny.windzz@gmail.com, kholk11@gmail.com,
        emil.velikov@collabora.com, gustavoars@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 3/3] drm/msm: Convert to devm_pm_opp_set_supported_hw
Date:   Mon, 12 Oct 2020 21:55:17 +0800
Message-Id: <20201012135517.19468-4-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012135517.19468-1-frank@allwinnertech.com>
References: <20201012135517.19468-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use the devm_pm_opp_set_supported_hw() to avoid memory leaks in some cases.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 91726da82ed6..8d88f119a59f 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1487,7 +1487,7 @@ static void check_speed_bin(struct device *dev)
 		nvmem_cell_put(cell);
 	}
 
-	dev_pm_opp_set_supported_hw(dev, &val, 1);
+	devm_pm_opp_set_supported_hw(dev, &val, 1);
 }
 
 struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
-- 
2.28.0

