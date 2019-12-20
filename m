Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE8127218
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfLTASF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:18:05 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63804 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLTASF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 19:18:05 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191220001803epoutp02ebad8566183fe31e6d58f45a48f7c074~h7Dss2yaP0688706887epoutp02x
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 00:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191220001803epoutp02ebad8566183fe31e6d58f45a48f7c074~h7Dss2yaP0688706887epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576801083;
        bh=xSkjfrpCKtZLu3yXna9MHxvv/MLQoXPvCufUjXVdDao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aS3dL6dtP842ovIcgPRHQEy21dcAXpToG3IwaGnRDmktv3WFMLdWvYCrSbMnmrCHQ
         hyfwjbNL69ysIL7+AwMFmwLLbilhjBnR3ccJKa0kNkMqyZD/e77GxgQfJBrgmOj8Fj
         N2Y4wpONhun1FpK9kMAH5N17ekLphFpyUuNkWGtk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191220001802epcas1p41ec9253a90fa075931ada26a5625468c~h7DsMY6OL0539105391epcas1p4a;
        Fri, 20 Dec 2019 00:18:02 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47f8Th3ZNfzMqYkp; Fri, 20 Dec
        2019 00:18:00 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.E5.57028.8331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191220001800epcas1p3accefc4384d9503481311f25f5794cb8~h7DpoID1u1379413794epcas1p3J;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191220001800epsmtrp2b28a72fc38cf21fe5fd87af2ff76222f~h7DpnRz820512905129epsmtrp2Y;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-16-5dfc13381ed3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.7C.06569.8331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epsmtip10394decb60eec4a2af165514065cfb39~h7Dpborb-2227322273epsmtip1n;
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
Subject: [PATCH v2 07/11] PM / devfreq: exynos-bus: Replace the deprecated
 'devfreq' and 'devfreq-events' property
Date:   Fri, 20 Dec 2019 09:24:26 +0900
Message-Id: <20191220002430.11995-8-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002430.11995-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmvq6F8J9Yg1dNshb357UyWlz/8pzV
        Yv6Rc6wW/x+9ZrXof/ya2eL8+Q3sFmeb3rBbrLj7kdVi0+NrrBaXd81hs/jce4TR4tOD/8wW
        M87vY7JY2NTCbrH2yF12i6XXLzJZ3G5cwWbRuvcIu4OQx5p5axg9Nq3qZPPYvKTeY+O7HUwe
        fVtWMXpsvzaP2ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygN5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYFesWJucWl
        eel6yfm5VoYGBkamQIUJ2RmbGhaxFLRIVNzYOJ2pgXGvcBcjJ4eEgInE7ec/2LsYuTiEBHYw
        Snz5c4sJwvnEKLH7VAczhPONUaL57082mJb7W1dBtexllHi5cwUjSEJI4AujxIkHjiA2m4CW
        xP4XN8AaRAQyJGa+vswK0sAs8JFJomvbXbCEsECJxL/TnSwgNouAqsSa22/ABvEKWElcPPmR
        FWKbvMTqDQeYQWxOAWuJLc8egm2WEGhml3i/7TNQMweQ4yJx7KcDRL2wxKvjW9ghbCmJz+/2
        Ql1dLbHy5BE2iN4ORokt+y9ALTCW2L90MhPIHGYBTYn1u/QhwooSO3/PBbuHWYBP4t3XHlaI
        VbwSHW1CECXKEpcf3GWCsCUlFrd3Qq3ykDh3qQ8aQH2MEk/3drFNYJSbhbBhASPjKkax1ILi
        3PTUYsMCQ+Qo28QITqdapjsYp5zzOcQowMGoxMPrkPY7Vog1say4MvcQowQHs5II7+2On7FC
        vCmJlVWpRfnxRaU5qcWHGE2BITmRWUo0OR+Y6vNK4g1NjYyNjS1MDM1MDQ2VxHk5flyMFRJI
        TyxJzU5NLUgtgulj4uCUamAsqTmr1R4dqLl1ulVh5MdSj1z2O1P8lplx1+qfK46qNn8VIXk7
        sFbeSP+DcZh0adqfVw8yuZ6yufq4ltXsFOhY+ESW23TVrMvPfXy1+G2iTxu37r/wYeun3qVT
        2q9rL9inK1j8v/Hd+SZbprrpXs0vNVSfH9JiNVy15nHVp5XmjF4GK29mqSmxFGckGmoxFxUn
        AgD31qlbvQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnK6F8J9Yg/OH2Czuz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FFcNimpOZllqUX6dglcGZsaFrEUtEhU3Ng4namBca9wFyMnh4SA
        icT9ravYQWwhgd2MEnsOpkPEJSWmXTzK3MXIAWQLSxw+XNzFyAVU8olRYtWn04wgNWwCWhL7
        X9xgA7FFBPIkNm38ygxSxCzwn0ni+8kHYEXCAkUSk78fZAKxWQRUJdbcfgMW5xWwkrh48iMr
        xDJ5idUbDjCD2JwC1hJbnj2EOshK4uX5C6wTGPkWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0u
        zUvXS87P3cQIDnotrR2MJ07EH2IU4GBU4uF1SPsdK8SaWFZcmXuIUYKDWUmE93bHz1gh3pTE
        yqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjE1XPefeu8N0Ryb0
        u/Wj3R3NR4+oiOoJyIS1+71f+fXsjizDgKl9B8zWqKR37uNJZz9lMuWlzzGN2GTzpvZ5UxN0
        9nptMPk2+5PnmwsNpSv3X10V1tyyK/sYq2/Llvt2rrcO/3wRovUxflJn0aULXzPfmeZtSzG7
        dpT1l+ns93vsVM33TBK5aazEUpyRaKjFXFScCADBJIQvdgIAAA==
X-CMS-MailID: 20191220001800epcas1p3accefc4384d9503481311f25f5794cb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001800epcas1p3accefc4384d9503481311f25f5794cb8
References: <20191220002430.11995-1-cw00.choi@samsung.com>
        <CGME20191220001800epcas1p3accefc4384d9503481311f25f5794cb8@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace the deprecated 'devfreq' and 'devfreq-events' property
with new following properties.
- 'devfreq' is changed to 'exynos,parent-bus' property
- 'devfreq-events' is changed to 'exynos,ppmu-device' property
But, to guarantee the backward-compatibility, keep the support
both 'devfreq' and 'devfreq-events' property.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 52 +++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index c4931ef53f15..9fdb188915e8 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -88,22 +88,35 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
 
 static struct devfreq *exynos_bus_get_parent_devfreq(struct device_node *np)
 {
-	struct device_node *node = of_parse_phandle(np, "devfreq", 0);
-
-	if (!node)
-		return ERR_PTR(-ENODEV);
-
+	struct device_node *node = of_parse_phandle(np, "exynos,parent-bus", 0);
+
+	if (!node) {
+		/*
+		 * Check the deprecated 'devfreq' property
+		 * to support backward-compatibility.
+		 */
+		node = of_parse_phandle(np, "devfreq", 0);
+		if (!node)
+			return ERR_PTR(-ENODEV);
+	}
 	return devfreq_get_devfreq_by_node(node);
 }
 
 static struct devfreq_event_dev *exynos_bus_get_edev(struct device_node *np,
 							int index)
 {
-	struct device_node *node = of_parse_phandle(np, "devfreq-events",
-							index);
-
-	if (!node)
-		return ERR_PTR(-ENODEV);
+	struct device_node *node = of_parse_phandle(np,
+					"exynos,ppmu-device", index);
+
+	if (!node) {
+		/*
+		 * Check the deprecated 'devfreq-events' property
+		 * to support backward-compatibility.
+		 */
+		node = of_parse_phandle(np, "devfreq-events", index);
+		if (!node)
+			return ERR_PTR(-ENODEV);
+	}
 	return devfreq_event_get_edev_by_node(node);
 }
 
@@ -214,11 +227,20 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	 * buses. This raw data will be used in devfreq ondemand governor.
 	 */
 	count = of_property_count_elems_of_size(dev->of_node,
-					"devfreq-events", sizeof(u32));
+					"exynos,ppmu-device", sizeof(u32));
 	if (count < 0) {
-		dev_err(dev, "failed to get the count of devfreq-event dev\n");
-		ret = count;
-		goto err_regulator;
+		/*
+		 * Check the deprecated 'devfreq-events' property
+		 * to support backward-compatibility.
+		 */
+		count = of_property_count_elems_of_size(dev->of_node,
+					"devfreq-events", sizeof(u32));
+		if (count < 0) {
+			dev_err(dev,
+				"failed to get the count of devfreq-event dev\n");
+			ret = count;
+			goto err_regulator;
+		}
 	}
 	bus->edev_count = count;
 
@@ -423,7 +445,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	if (!profile)
 		return -ENOMEM;
 
-	node = of_parse_phandle(dev->of_node, "devfreq", 0);
+	node = of_parse_phandle(dev->of_node, "exynos,parent-bus", 0);
 	if (node) {
 		of_node_put(node);
 		passive = true;
-- 
2.17.1

