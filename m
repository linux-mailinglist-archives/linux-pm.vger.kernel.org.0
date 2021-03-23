Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275CD34555F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 03:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCWCLi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 22:11:38 -0400
Received: from m12-14.163.com ([220.181.12.14]:59161 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhCWCLK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 22:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=+TehKEGSbGfHzsbgX1
        OF+kBoQt/ziQhZ4S4gO4B/Vw8=; b=g2K6104wYQV7IPIgSL6KOy+aLGX0zz06VJ
        vpnP3304IQWW88HH30rGREw22rpfX8FZoVJS2YeW7b5xEx36BQu5+YnyF23PJntq
        sBCRcsuX33y1HGi9eJ6ltrgdQBDohy5h5X1Jiyrx17jfopDe36+eHuOVO+N6ZiKw
        QxYvC2wVA=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowADX3RXxTVlgQZIEqw--.27747S2;
        Tue, 23 Mar 2021 10:09:59 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     amitk@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        huyue2@yulong.com, Jian Dong <dongjian@yulong.com>
Subject: [PATCH]  thermal: qcom: add missing put_device() call in init_common()
Date:   Tue, 23 Mar 2021 10:09:47 +0800
Message-Id: <1616465387-2973-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: DsCowADX3RXxTVlgQZIEqw--.27747S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XryUXr1xuF4fKF15Wr4UArb_yoWDCrXEkr
        4kA397Xr4rCr1DtFyDtry3t34qyrs7uryfu3WxK343J3sI9FW0gr4DJr15JrWkZr1DCa4I
        g3WfAw1I9wn7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8i0ePUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/xtbB0hde3VUMa8lMKAAAsZ
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jian Dong <dongjian@yulong.com>

 Fixes coccicheck ERROR:

 drivers/thermal/qcom/tsens.c:759:4-10: ERROR: missing put_device;
 call of_find_device_by_node on line 715, but without a corresponding
 object release within this function.

Signed-off-by: Jian Dong <dongjian@yulong.com>
---
 drivers/thermal/qcom/tsens.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a6..3c4c051 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -755,8 +755,10 @@ int __init init_common(struct tsens_priv *priv)
 		for (i = VER_MAJOR; i <= VER_STEP; i++) {
 			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
 							      priv->fields[i]);
-			if (IS_ERR(priv->rf[i]))
-				return PTR_ERR(priv->rf[i]);
+			if (IS_ERR(priv->rf[i])) {
+				ret = PTR_ERR(priv->rf[i]);
+				goto err_put_device;
+			}
 		}
 		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
 		if (ret)
-- 
1.9.1


