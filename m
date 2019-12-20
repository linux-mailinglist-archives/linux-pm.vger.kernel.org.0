Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4288F127245
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfLTASn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:18:43 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:57652 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfLTASH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 19:18:07 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191220001804epoutp03d48b904111ad3317635dac984edfba7f~h7DtndhLz1423414234epoutp03B
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 00:18:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191220001804epoutp03d48b904111ad3317635dac984edfba7f~h7DtndhLz1423414234epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576801084;
        bh=sAv5KFtPYXy7xSog3ojb9vcjFNw1ESh0hk+USCZHJj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ai9RvWqf1teqR6R1DdhTirxAEp5lslIcNqy14LNygF/PEnSQtewasHeTZPpE+8mEB
         39P8QInakEuG4CBoFvBgHvZorEgFmDyVG+URhE+8299bvxAuYQnJQ/VG4bnil6LKfS
         RSjJoxK9hbAeTGfQWVK5jdtPKeJT9LHPKr6oEjUA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191220001803epcas1p4a8876dff2ae81370068c87ca4173a8ac~h7Ds5Q_Ag2970029700epcas1p46;
        Fri, 20 Dec 2019 00:18:03 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47f8Tg5hhszMqYlr; Fri, 20 Dec
        2019 00:17:59 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.0E.48019.7331CFD5; Fri, 20 Dec 2019 09:17:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epcas1p4ce1c2017937a35de84eab720b9732df0~h7DpC0qNa0539105391epcas1p4T;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220001759epsmtrp11c6a7053121e5a05c63c31650e5d1f92~h7DpB7FGz1705617056epsmtrp1P;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-62-5dfc133761e8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.6C.06569.7331CFD5; Fri, 20 Dec 2019 09:17:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epsmtip1fa82730305a941bd00b4c1688e04da03~h7Do1fCuM2006320063epsmtip12;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 02/11] PM / devfreq: Remove
 devfreq_get_devfreq_by_phandle function
Date:   Fri, 20 Dec 2019 09:24:21 +0900
Message-Id: <20191220002430.11995-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002430.11995-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmrq658J9Yg+Ur9Czuz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlAbygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL
        89L1kvNzrQwNDIxMgQoTsjM2fLzOVtCkUPFp4nv2BsZ3Ul2MHBwSAiYSNybndjFycQgJ7GCU
        uHtiKzuE84lR4s3Nd4wQzjdGiT9PLrN2MXKCdVzZPJ8ZIrGXUWLRkfMsEM4XoKoD/5lBqtgE
        tCT2v7jBBmKLCGRIzHwN0s3FwSzwkUmia9tdsISwQIRE98E7YA0sAqoSE5/MArN5Bawktn7s
        ZoZYJy+xesMBMJtTwFpiy7OH7BDx32wST17IQ9guEisf/WSEsIUlXh3fAlUjJfGyvw3KrpZY
        efIIG8gREgIdjBJb9l+A+sdYYv/SyUyg0GAW0JRYv0sfIqwosfP3XLCZzAJ8Eu++9rBCAoxX
        oqNNCKJEWeLyg7tMELakxOL2TjYI20Oi68VJaDj2MUqcP3mdfQKj3CyEDQsYGVcxiqUWFOem
        pxYbFpggR9kmRnA61bLYwbjnnM8hRgEORiUeXoe037FCrIllxZW5hxglOJiVRHhvd/yMFeJN
        SaysSi3Kjy8qzUktPsRoCgzJicxSosn5wFSfVxJvaGpkbGxsYWJoZmpoqCTOy/HjYqyQQHpi
        SWp2ampBahFMHxMHp1QDo+G59qbXN85JXG/7tfKeY2DW45IXnyJtrnnvuR+x7jmHe1NU+fl5
        ua49DI0OlZY5sw21Xj0K2b50wcWztuq3ejf+qj3rr3nvQXpGjv8sCZEXKybf5b1xd2/XosVs
        Pxn3LSuv1z/4YVlUbz9bi1PJ3+2nPuTI/OVPW3IrpSNiG6N4zJfsNT6FnUosxRmJhlrMRcWJ
        AL9tCPy9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK658J9Yg79TZSzuz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FFcNimpOZllqUX6dglcGRs+XmcraFKo+DTxPXsD4zupLkZODgkB
        E4krm+czdzFycQgJ7GaUaN10ixkiISkx7eJRIJsDyBaWOHy4GKLmE6NEx76f7CA1bAJaEvtf
        3GADsUUE8iQ2bfwKNohZ4D+TxPeTDxhBEsICYRLfT89iBbFZBFQlJj6ZBbaAV8BKYuvHbqhl
        8hKrNxwAszkFrCW2PHsItkAIqObl+QusExj5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L
        10vOz93ECA57La0djCdOxB9iFOBgVOLhdUj7HSvEmlhWXJl7iFGCg1lJhPd2x89YId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYwZU0otguvaLX+qJOSI
        3xLgSHz5TlpaZi33L9Uas2eR5T5uZT7paY71z23CdjPJc/VdMGHLm+Cmc5BV7xr7koAMnttT
        6+eza7lxf2Z0O/nFSIhlk9yUyzOWXfo5eUL1xRgpnfbfrqqcdnoeif8P/fql69z/+VbV/4bz
        c3rW70iq0PeQafRPUmIpzkg01GIuKk4EACnv8JV3AgAA
X-CMS-MailID: 20191220001759epcas1p4ce1c2017937a35de84eab720b9732df0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001759epcas1p4ce1c2017937a35de84eab720b9732df0
References: <20191220002430.11995-1-cw00.choi@samsung.com>
        <CGME20191220001759epcas1p4ce1c2017937a35de84eab720b9732df0@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Previously, devfreq core support 'devfreq' property in order to get
the devfreq device by phandle. But, 'devfreq' property name is not proper
on devicetree binding because this name doesn't mean the any h/w attribute.

The devfreq core hand over the right to decide the property name
for getting the devfreq device on devicetree. Each devfreq driver
will decide the property name on devicetree binding and then get
the devfreq device by using devfreq_get_devfreq_by_node().

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c    | 35 -----------------------------------
 drivers/devfreq/exynos-bus.c | 12 +++++++++++-
 include/linux/devfreq.h      |  8 --------
 3 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index cb8ca81c8973..c3d3c7c802a0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -991,48 +991,13 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
 
 	return ERR_PTR(-ENODEV);
 }
-
-/*
- * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
- * @dev - instance to the given device
- * @index - index into list of devfreq
- *
- * return the instance of devfreq device
- */
-struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
-{
-	struct device_node *node;
-	struct devfreq *devfreq;
-
-	if (!dev)
-		return ERR_PTR(-EINVAL);
-
-	if (!dev->of_node)
-		return ERR_PTR(-EINVAL);
-
-	node = of_parse_phandle(dev->of_node, "devfreq", index);
-	if (!node)
-		return ERR_PTR(-ENODEV);
-
-	devfreq = devfreq_get_devfreq_by_node(node);
-	of_node_put(node);
-
-	return devfreq;
-}
-
 #else
 struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
 {
 	return ERR_PTR(-ENODEV);
 }
-
-struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
-{
-	return ERR_PTR(-ENODEV);
-}
 #endif /* CONFIG_OF */
 EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_node);
-EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
 
 /**
  * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 7f5917d59072..1bc4e3c81115 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -86,6 +86,16 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
 	return ret;
 }
 
+static struct devfreq *exynos_bus_get_parent_devfreq(struct device_node *np)
+{
+	struct device_node *node = of_parse_phandle(np, "devfreq", 0);
+
+	if (!node)
+		return ERR_PTR(-ENODEV);
+
+	return devfreq_get_devfreq_by_node(node);
+}
+
 /*
  * devfreq function for both simple-ondemand and passive governor
  */
@@ -353,7 +363,7 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	profile->exit = exynos_bus_passive_exit;
 
 	/* Get the instance of parent devfreq device */
-	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
+	parent_devfreq = exynos_bus_get_parent_devfreq(dev->of_node);
 	if (IS_ERR(parent_devfreq))
 		return -EPROBE_DEFER;
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 1dccc47acbce..a4351698fb64 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -254,8 +254,6 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
 				struct notifier_block *nb,
 				unsigned int list);
 extern struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
-extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
-						int index);
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
@@ -413,12 +411,6 @@ static inline struct devfreq *devfreq_get_devfreq_by_node(struct device_node *no
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
-							int index)
-{
-	return ERR_PTR(-ENODEV);
-}
-
 static inline int devfreq_update_stats(struct devfreq *df)
 {
 	return -EINVAL;
-- 
2.17.1

