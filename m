Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA9260F5B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgIHKMw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 06:12:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:28624 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgIHKMo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 06:12:44 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200908101240epoutp02756193cae73e796c8e6de9600882a094~yx08UhFPC3270032700epoutp02g
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 10:12:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200908101240epoutp02756193cae73e796c8e6de9600882a094~yx08UhFPC3270032700epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599559960;
        bh=ZHYNOECr6/hyoQNi3rgR3D9rFSRmKng51Z3eUSqSMIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXg/DUZY7LxGgS5od6oYaR8dIkwUEtU+g6EtRg8/4x/5mYhIjxPSKnTZNl0lUkFVu
         6pZa5uBWKWNQRoYMf7XeVYlEbRbfKWMumFLMxTQmPq+4mIhlMdQ/X9fhJ+Mg2e2TMd
         8QZi33GkMXextJuuB+ocX4tcYmIIgwl9f++6fLQU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200908101239epcas1p1d075182cf83a1893c740b8616589effc~yx08CCPsn2557725577epcas1p1q;
        Tue,  8 Sep 2020 10:12:39 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Bm1DJ0QJ6zMqYkd; Tue,  8 Sep
        2020 10:12:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.1F.19033.F09575F5; Tue,  8 Sep 2020 19:12:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200908101230epcas1p25f1ae5d3230f802a8326bfaa7e49c159~yx0ztoYIo0740007400epcas1p2y;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200908101230epsmtrp2a300a48ee770632bff671a9434324728~yx0zskhGD2570325703epsmtrp2a;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-6e-5f57590f3e9e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.48.08303.E09575F5; Tue,  8 Sep 2020 19:12:30 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200908101230epsmtip20867b17f627241e809c6a25e87d89e91~yx0zg9lAb1414914149epsmtip2P;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, lukasz.luba@arm.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v3 1/3] PM / devfreq: Add devfreq_get_devfreq_by_node
 function
Date:   Tue,  8 Sep 2020 19:24:45 +0900
Message-Id: <20200908102447.15097-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908102447.15097-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmvi5/ZHi8wZkGK4vrX56zWpw/v4Hd
        4mzTG3aLFXc/slpsenyN1eLyrjlsFp97jzBazDi/j8liYVMLu8XtxhVsDlwea+atYfTYtKqT
        zWPzknqPje92MHn0bVnF6PF5k1wAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGl
        hbmSQl5ibqqtkotPgK5bZg7QZUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssC
        veLE3OLSvHS95PxcK0MDAyNToMKE7Izrb7+zFCyQqZjybBN7A+Mr8S5GTg4JAROJ16fWM3Yx
        cnEICexglHhyuQPK+cQocenLVhYI5zOjxN6NH9lhWtZO+M4MkdjFKNFy4C4rhPMFyFnaxQJS
        xSagJbH/xQ02EFtEoEzi9perYB3MApsYJZZu/wbUwcEhLBAg0f9eDaSGRUBVYt2JuywgYV4B
        K4kJn6QhlslLrN5wgBnE5hSwlti+aiEbyBgJgZfsEt8+zmKDKHKR+PpuGZQtLPHq+BaoS6Uk
        Pr/bCxWvllh58ghUcwejxJb9F1ghEsYS+5dOZgJZzCygKbF+lz5EWFFi5++5jCA2swCfxLuv
        PWAnSwjwSnS0CUGUKEtcfnCXCcKWlFjc3gm1ykOi7e4TsOlCAn2MEm93c0xglJuFsGABI+Mq
        RrHUguLc9NRiwwIj5BjbxAhOeVpmOxgnvf2gd4iRiYPxEKMEB7OSCG/XodB4Id6UxMqq1KL8
        +KLSnNTiQ4ymwLCbyCwlmpwPTLp5JfGGpkbGxsYWJoZmpoaGSuK8D28pxAsJpCeWpGanphak
        FsH0MXFwSjUwFVeICx1u4DOpZdBkZdXjTo3eeJ4p1XHeBZ2Vrq/XNVlwc/Ac9t7a8b7w8Qc7
        YZvA7y8FFTPucx+JbXPq0Lj7Z/NUpYp56Q9/WnTd/HKxuJ1v/Y0DmReu7U397tviVfqm6eBO
        Q+V1sWu8ZYwkz3A+MXDwNrfkmDVfI2/Lj3saYZ0vWxdpzL3LEHYpWiM+8Fftsz73QJmW6Yce
        6WVH/l7ze3pleuPd2k6xwA0c3Ed1Nz6tf2Kict5QpcBwwcdjFZsN+WM0c5ILuNV0vwX4nGjs
        0bhvEeJwQ2yKwaRLXVPtF869FlJT8HfOWzbmw6eWXejqbww+E1drs6Hz4q19MzZtDbxu7cLw
        L03E+aLnpeNKLMUZiYZazEXFiQASJfiuAgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvC5fZHi8wYb1hhbXvzxntTh/fgO7
        xdmmN+wWK+5+ZLXY9Pgaq8XlXXPYLD73HmG0mHF+H5PFwqYWdovbjSvYHLg81sxbw+ixaVUn
        m8fmJfUeG9/tYPLo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujOtvv7MULJCpmPJsE3sD4yvx
        LkZODgkBE4m1E74zdzFycQgJ7GCU2Dn1KiNEQlJi2sWjQAkOIFtY4vDhYoiaT4wSy5b3sIDU
        sAloSex/cYMNxBYRqJFYNncPG0gRs8A2Rom+1Q+YQJqFBfwk3k+XA6lhEVCVWHfiLgtImFfA
        SmLCJ2mIVfISqzccYAaxOQWsJbavWgg2Ugio5NqSHYwTGPkWMDKsYpRMLSjOTc8tNiwwykst
        1ytOzC0uzUvXS87P3cQIDkwtrR2Me1Z90DvEyMTBeIhRgoNZSYS361BovBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHer7MWxgkJpCeWpGanphakFsFkmTg4pRqYHNykv76bP9eK2/PDqlkid+Jz
        CrMmu5Ulyk802M7Ps+arZqMGn4FDheh6uaCKNf3LlS/YG7Q0zXEwceQpP2scM+mfirDK6yW7
        4+d1GWndu9ARqHphRknhaaY1d1NXuT1j+r3z0HKB6ZZaUjxP1hhd+u51XHfhieMcbAW1LvaF
        Vksmah7c/I/t1NmFrVM1ztbZaV10/Dnz+MOtu6qvX+FdZn9+Rt/zRzG/v+/8VfbV+uSuiYfb
        y5Z0bJGZeVQ0fNGGn6nuOzlUJn6dtdXi08x7/bsXZ1xMlv+mapofW23IteyrsdvJrRMbn6iw
        /P7ocrf75OWAvh8Zj033cmvnygdqOe4uLeXvPXZF0oVzTvu2P0osxRmJhlrMRcWJAJn719G7
        AgAA
X-CMS-MailID: 20200908101230epcas1p25f1ae5d3230f802a8326bfaa7e49c159
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908101230epcas1p25f1ae5d3230f802a8326bfaa7e49c159
References: <20200908102447.15097-1-cw00.choi@samsung.com>
        <CGME20200908101230epcas1p25f1ae5d3230f802a8326bfaa7e49c159@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

Split off part of devfreq_get_devfreq_by_phandle into a separate
function. This allows callers to fetch devfreq instances by enumerating
devicetree instead of explicit phandles.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
[cw00.choi: Export devfreq_get_devfreq_by_node function and
 add function to devfreq.h when CONFIG_PM_DEVFREQ is enabled.]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++++++++++----------
 include/linux/devfreq.h   |  6 +++++
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 561d91b2d3bf..b9b27fb3291e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -983,6 +983,32 @@ struct devfreq *devm_devfreq_add_device(struct device *dev,
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
@@ -1005,26 +1031,24 @@ struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
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
index 12782fbb4c25..eb971b8e5051 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -261,6 +261,7 @@ void devm_devfreq_unregister_notifier(struct device *dev,
 				struct devfreq *devfreq,
 				struct notifier_block *nb,
 				unsigned int list);
+struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
 struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index);
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
@@ -414,6 +415,11 @@ static inline void devm_devfreq_unregister_notifier(struct device *dev,
 {
 }
 
+static inline struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 					int index)
 {
-- 
2.17.1

