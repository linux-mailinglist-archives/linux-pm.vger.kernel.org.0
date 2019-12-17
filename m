Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1649E122448
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 06:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfLQFvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 00:51:52 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31603 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfLQFvM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 00:51:12 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191217055110epoutp03f47b4c3b3d09cf7d7123e718b9ff8ec2~hEqsJNk-I0699506995epoutp03u
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 05:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191217055110epoutp03f47b4c3b3d09cf7d7123e718b9ff8ec2~hEqsJNk-I0699506995epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576561870;
        bh=O72tznyqE+/XDINrHrD7q4VDYOKlq2biAtS4Ew50ktM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEzkA/BzIbfWiNG79pOlmsY/gN2TkPXAgn7BcajOYj0kYGHQmsWxvEDKvJr9ZjPIF
         E/aDqMdoAoUOEDvZ65UngD5vI8rZsihgeyt5h7Wx+KZuknAUAE64QTC2rHTAjo7kdp
         G8VLnUGu6zUMS0/PyEzf2QolSiCAqn59YEKDOHgA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191217055109epcas1p3fcdaeb07dbad56ae5ced7dc78f8683e5~hEqrkFQZW1374813748epcas1p3k;
        Tue, 17 Dec 2019 05:51:09 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47cS1Q1XfXzMqYkt; Tue, 17 Dec
        2019 05:51:06 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.0D.51241.ACC68FD5; Tue, 17 Dec 2019 14:51:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191217055105epcas1p3bacbf54550c52979fe819ab33bb21d30~hEqntGdws1374813748epcas1p3e;
        Tue, 17 Dec 2019 05:51:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191217055105epsmtrp25d086cf2e7287f69d6b2485ddaecd81a~hEqnsO-nq1905819058epsmtrp28;
        Tue, 17 Dec 2019 05:51:05 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-45-5df86ccad7bb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.5D.10238.9CC68FD5; Tue, 17 Dec 2019 14:51:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191217055105epsmtip147e4c06741ba45fb928cc9047cb8ffa3~hEqncM2z53193831938epsmtip1W;
        Tue, 17 Dec 2019 05:51:05 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     a.swigon@samsung.com, m.szyprowski@samsung.com, kgene@kernel.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 1/9] PM / devfreq: Add devfreq_get_devfreq_by_node function
Date:   Tue, 17 Dec 2019 14:57:30 +0900
Message-Id: <20191217055738.28445-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217055738.28445-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxj26+m5oNacVTZf65R6lv6QBOSAxQ8txkTmTtQ4EhYTTbAe4YQi
        vdlTzNzi/TJFEQ1LNF5AnURXFLASqCigpbjJgsDYcGjIqmbDtQaieIvG1LaHRf897/M+7+V7
        vpchtLWUjim2uyWXXbRy1ER1U8ec1JQu6+v8NF8Dif+u2oPw3efDJK4O3CFx5GGYxBWPwgTu
        6WmgcffOJzS+MPSUxN5HAyTubzlJ4bHyAMLPghECH+tpU+EzO3fT+FJgiMY1d/tU+P6OCxTe
        0xqgF2uFi1UXkeD17KeEK+e2CZdHfCrhUKMHCc0DVYQw5p2VS68pMVkksVBy6SV7gaOw2F6U
        zS3PMy8xGzPT+BQ+C8/n9HbRJmVzOStyU5YWW6PP4PSbRGtplMoVZZmbu8jkcpS6Jb3FIbuz
        OclZaHVmOVNl0SaX2otSCxy2BXxaWroxKlxXYvEeO0E5f5vx7a63XeR2VDmtDDEMsPPgSffs
        MjSR0bI+BD9e8yAleIYgVF6nUoKXCPrau+kylBCvqP/nAa0kWhF0RuooJXiOoOfhQFxFscnQ
        /vgvKoYT2a1Q3eGLtyLYQRVc//0eGUtMZZfDaG8kLlKzBvCfv0LEsIZdAGdeVquVcUlQ23Aj
        ziewC2G4KRxvBGyEgq7DRwlFlAM1bS3jeCqEfmkc31UHYyOtlIK/h59vByileB+CxvZeUklk
        QHtNpSpmB8HOgfqWuQo9G66+PYVimGCnwMiLg6TimAb27dUqki+gPzikUvB0+OmH/eOjBCgP
        3SMUVw4heDd6hDyMZh3/MOE0Qh70meSUbUWSzDuNH/+ZF8UPNTnLh27dWeFHLIO4yRpwv8rX
        kuImebPNj4AhuESNTx+lNIXi5u8kl8PsKrVKsh8Zo1YeIXSfFjiiZ293m3ljekZGBp7HZxp5
        npumYV735WvZItEtlUiSU3L9X6diEnTbETOabji7pSLxT0PAGn4jdxBJG2+Y+nX/DQSXrW8q
        ezBpw0xTTuev33iMSyuT1uSvPB0+cKutYuPqTzoz83prLd5I89ddxweFQP1XtNCXu2rLkuKx
        tYvKFwdNNwuaDwQNVO3R7rwv74/k+A2rzQs7daF/606qT4WS/sj73D2c0JQ9OIFTyxaRTyZc
        svgeSl59D74DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO7JnB+xBhtOyVrcn9fKaHH9y3NW
        i/lHzrFa/H/0mtWi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGi08P/jNb
        zDi/j8liYVMLu8XaI3fZLZZev8hkcbtxBZtF694j7A5CHmvmrWH02LSqk81j85J6j43vdjB5
        9G1Zxeix/do8Zo/Pm+QC2KO4bFJSczLLUov07RK4MjbNmM1WcFq6ovn3KdYGxsniXYycHBIC
        JhLrnz5k72Lk4hAS2M0osWrpR2aIhKTEtItHgWwOIFtY4vDhYoiaT4wSFza9YQSpYRPQktj/
        4gYbiC0i0MYoseS7HIjNLPCcSWJflxmILSzgLfH+wn+wGhYBVYlDyzeDzecVsJJY+G0+C8Qu
        eYnVGw6AxTkFrCWeb3vNBGILAdX8nPqMdQIj3wJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV5
        6XrJ+bmbGMFBr6W5g/HykvhDjAIcjEo8vBIl32OFWBPLiitzDzFKcDArifDuUAAK8aYkVlal
        FuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwMibfnSLqd277e5qrY5z
        drUsXVi0V9DGzrklLmNdz1X5S3sVww68/sZeGijKdXCCbn+ytcfqY6lLOdYofZilcppDYDtn
        Tut8vvPn5jG/XmZmcIyVWetKt6D9zFcWW06ZdTbuStHs/bQ+/tj1ydy33h/bdn3uHPUbzaps
        yWfLyhL/uBapzQv481GJpTgj0VCLuag4EQCG3KPNdgIAAA==
X-CMS-MailID: 20191217055105epcas1p3bacbf54550c52979fe819ab33bb21d30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191217055105epcas1p3bacbf54550c52979fe819ab33bb21d30
References: <20191217055738.28445-1-cw00.choi@samsung.com>
        <CGME20191217055105epcas1p3bacbf54550c52979fe819ab33bb21d30@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

Split off part of devfreq_get_devfreq_by_phandle into a separate
function. This allows callers to fetch devfreq instances by enumerating
devicetree instead of explicit phandles.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
[cw00.choi: Export devfreq_get_devfreq_by_node function and
 add function to devfreq.h when CONFIG_PM_DEVFREQ is enabled.]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++++++++++----------
 include/linux/devfreq.h   |  6 +++++
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 89260b17598f..cb8ca81c8973 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -966,6 +966,32 @@ struct devfreq *devm_devfreq_add_device(struct device *dev,
 EXPORT_SYMBOL(devm_devfreq_add_device);
 
 #ifdef CONFIG_OF
+/*
+ * devfreq_get_devfreq_by_node - Get the devfreq device from devicetree
+ * @node - pointer to device_node
+ *
+ * return the instance of devfreq device
+ */
+struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
+{
+	struct devfreq *devfreq;
+
+	if (!node)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		if (devfreq->dev.parent
+			&& devfreq->dev.parent->of_node == node) {
+			mutex_unlock(&devfreq_list_lock);
+			return devfreq;
+		}
+	}
+	mutex_unlock(&devfreq_list_lock);
+
+	return ERR_PTR(-ENODEV);
+}
+
 /*
  * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
  * @dev - instance to the given device
@@ -988,26 +1014,24 @@ struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
-	mutex_lock(&devfreq_list_lock);
-	list_for_each_entry(devfreq, &devfreq_list, node) {
-		if (devfreq->dev.parent
-			&& devfreq->dev.parent->of_node == node) {
-			mutex_unlock(&devfreq_list_lock);
-			of_node_put(node);
-			return devfreq;
-		}
-	}
-	mutex_unlock(&devfreq_list_lock);
+	devfreq = devfreq_get_devfreq_by_node(node);
 	of_node_put(node);
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return devfreq;
 }
+
 #else
+struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
 {
 	return ERR_PTR(-ENODEV);
 }
 #endif /* CONFIG_OF */
+EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);
 EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
 
 /**
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index c6f82d4bec9f..e3633ae43349 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -253,6 +253,7 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
 				struct devfreq *devfreq,
 				struct notifier_block *nb,
 				unsigned int list);
+extern struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
 extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 						int index);
 
@@ -407,6 +408,11 @@ static inline void devm_devfreq_unregister_notifier(struct device *dev,
 {
 }
 
+struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 							int index)
 {
-- 
2.17.1

