Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB3445D65
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 02:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhKEBma (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 21:42:30 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:40272 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230345AbhKEBma (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 21:42:30 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 21:42:29 EDT
Received: from localhost.localdomain (unknown [124.16.141.244])
        by APP-01 (Coremail) with SMTP id qwCowACnPyD3iYRhJ0+SBg--.22237S2;
        Fri, 05 Nov 2021 09:33:44 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        thara.gopinath@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/qcom/spmi-adc-tm5: Remove unnecessary print function dev_err()
Date:   Fri,  5 Nov 2021 01:33:40 +0000
Message-Id: <20211105013340.38300-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnPyD3iYRhJ0+SBg--.22237S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWrWF45tw4DKr1xGryrtFb_yoW3ZwbEkr
        18Xr4xJ3yFyrn0vw1rtr4akr9FyF4vvF4SgrsavF9Iy345Ja4DWFykAFykArWxZr40kryU
        CFy3Wry3Gw1fZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
        c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2rcTDU
        UUU
X-Originating-IP: [124.16.141.244]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwcPA1z4kkBX0wABsz
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 824671cf494a..8492dd3bfed6 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -612,10 +612,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
 	adc_tm->base = reg;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "get_irq failed: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = adc_tm5_get_dt_data(adc_tm, node);
 	if (ret) {
-- 
2.25.1

