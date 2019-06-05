Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A67D3596E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 11:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfFEJNH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 05:13:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59900 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfFEJNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 05:13:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190605091305euoutp02c72f7a363311816a0c555dd1cd8a3e4f~lQoUZOnKd2351623516euoutp02_
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 09:13:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190605091305euoutp02c72f7a363311816a0c555dd1cd8a3e4f~lQoUZOnKd2351623516euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559725985;
        bh=v+RMmIzTcaJyPjA8Zdr0mIih2MUkFcF/sSg/cYP3NCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hbvo1ziuN4o3W9s4U1T6oZKupw9Be57BgjXmF73s5ymGOTVIQY7NRddI94YOFmflv
         JIjNH6wuO3GuK1ccOtUdtB6Q3A4euHPuQw7B2eDaVlfm54279JUfeLD7jg/jc6t6vg
         xA/YtO1+6vGFtiGiFKB6R9OT3OSuvWZFoQgtWyzc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190605091304eucas1p2886c0192cd2da56c16761efb46368a9b~lQoTZg-X02278222782eucas1p2f;
        Wed,  5 Jun 2019 09:13:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A7.3A.04377.F9787FC5; Wed,  5
        Jun 2019 10:13:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a~lQoSpzvtZ2947229472eucas1p2r;
        Wed,  5 Jun 2019 09:13:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605091303eusmtrp2c4812a8b2e229a4ed64dffdd9a439760~lQoSaCwXU2473824738eusmtrp2U;
        Wed,  5 Jun 2019 09:13:03 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-36-5cf7879feea2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 46.30.04146.F9787FC5; Wed,  5
        Jun 2019 10:13:03 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605091302eusmtip13d45ee484c0e87c76c638e908e998294~lQoRs_1gj3220032200eusmtip1N;
        Wed,  5 Jun 2019 09:13:02 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v4 3/5] drivers: devfreq: events: extend events by type of
 counted data
Date:   Wed,  5 Jun 2019 11:12:34 +0200
Message-Id: <20190605091236.24263-4-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605091236.24263-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeUhTcRzvt7e397aaPGfHDxsKK0WNppXFj4wOiFoQUQRFNbCVj3W4VXse
        ZdfKaiXpxFCneUWWY86jqWU2w+bSonIdsExdydZBbh3kWBRl+XiL/vv8Pid8+ZGYpBWPJvdq
        s2idVpUpE4j4N/t+uObXGb4rU0Jr0A1TC45eBj/gqNY5gCOjz48hl6uVQE9OBwg0pJcim8+N
        oxddVQI0XugEyOS6y0NNTg+Brr18xkPDp8wCdLbbSaDegAFHoQdesDJSYa2xAsXtSg+hsFku
        CBRt9ScV9z7beYqidgtQjNtiNhLbRcsy6My9ObQueflO0Z5XfaW8g7/nHG62enE9aJMWACEJ
        qVT4+HmToACISAllBvCP9yHBChIqCKCjZgknjANoN3QQ/xLuwSGCExoAPGcu5nOPyUT3qGey
        iyQFlBx2Wg6xgenUVQBDvdtZD0Zd58G7+d94rBBFbYMVZ77iLOZTcTDf+1PAYjG1AnZXFIfX
        YmFjaw/GdgqplbDNtIKjBwg41hnH0pBaDc0jRzk6Co71t4eTUvjndi2PwwzUF14BHD4Gfcbq
        sCcN9vY/w9kajEqELV3JHL0K1hm9fK49Ag5+imRpbBKW3CzHOFoMz5+TcO4E2H7xaXhoJmyw
        loXLFfB9dSvG3eYSgJc/joJiEFv5f6wOAAuYRWczGjXNLNTSuXJGpWGytWr57gMaG5j8R48m
        +oOdoOvXLgegSCCbJjalh5QSXJXDHNE4ACQx2XSxajiolIgzVEfyaN2BdF12Js04wGySL5sl
        PjpldIeEUquy6P00fZDW/VN5pDBaDyyrakBlni3PcSE3oUN537VhhJ8a8G91MUXuNyXx8q8F
        ygjPUjonib8pbt5ad35oIjf61qDkxPrr8o51X2YII5N7mucGHkVV3Ykvf532NsNeFfBHlL6o
        NhxPrPd93jKU0pi22CjVxFRM3ffKr66/tWjeO+EPe49vc9C1oHairGGhjM/sUS1IwnSM6i/0
        VbMdQwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7rz27/HGJzdzmuxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GTePTWUq+KtcsW7NI9YGxs0yXYycHBICJhLXbtxi72Lk4hASWMooMev9claIhJjE
        pH3b2SFsYYk/17rYQGwhgU+MEhdnOnYxcnCwCehJ7FhVCNIrIrCcUeLYqrfMIA6zwDYmiT1X
        djOCNAgLhEvMbJzEAmKzCKhKND/6BTaIV8BeYu/MCVAL5CVWbzjADDKUU8BBYvMMe4hd9hLH
        z25lnsDIt4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgnGw79nPzDsZLG4MPMQpwMCrx
        8M6I/xYjxJpYVlyZe4hRgoNZSYQ38faXGCHelMTKqtSi/Pii0pzU4kOMpkA3TWSWEk3OB8Zw
        Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxqZF+z/4Tpa+eN+m
        3mdqYLR+D2u/xbTFf+aqipZuTmb79G9pn+LdibJPnKQ3xgcHB7yacmzvZW9Oy8vfntyZNO/4
        k6ZtZYfnFNd1OJzp/fJMYZWx2cwpa29qer5tSV/Ut/3Lpo/cVqtEWvc8X7Al6/H2Ldt3PVw5
        0eN3WfHFf95/XJ7s2+MU8PC1EktxRqKhFnNRcSIAB4QDJakCAAA=
X-CMS-MailID: 20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a
References: <20190605091236.24263-1-l.luba@partner.samsung.com>
        <CGME20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds posibility to choose what type of data should be counted
by the PPMU counter. Now the type comes from DT where the event has been
defined. When there is no 'event-data-type' the default value is used,
which is 'read+write data in bytes'.
It is needed when you want to know not only read+write data bytes but
i.e. only write data in byte, or number of read requests, etc.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 60 ++++++++++++++++++++---------
 include/linux/devfreq-event.h       |  6 +++
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 17f3c86a6f00..12f637320e9e 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -161,9 +161,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		return ret;
 
-	/* Set the event of Read/Write data count  */
+	/* Set the event of proper data type monitoring */
 	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
-				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
+			   edev->desc->data_type);
 	if (ret < 0)
 		return ret;
 
@@ -375,23 +375,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		return ret;
 
-	/* Set the event of Read/Write data count  */
-	switch (id) {
-	case PPMU_PMNCNT0:
-	case PPMU_PMNCNT1:
-	case PPMU_PMNCNT2:
-		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
-				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
-		if (ret < 0)
-			return ret;
-		break;
-	case PPMU_PMNCNT3:
-		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
-				PPMU_V2_EVT3_RW_DATA_CNT);
-		if (ret < 0)
-			return ret;
-		break;
-	}
+	/* Set the event of proper data type monitoring */
+	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
+			   edev->desc->data_type);
+	if (ret < 0)
+		return ret;
 
 	/* Reset cycle counter/performance counter and enable PPMU */
 	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
@@ -507,6 +495,7 @@ static int of_get_devfreq_events(struct device_node *np,
 	struct device_node *events_np, *node;
 	int i, j, count;
 	const struct of_device_id *of_id;
+	int ret;
 
 	events_np = of_get_child_by_name(np, "events");
 	if (!events_np) {
@@ -556,6 +545,39 @@ static int of_get_devfreq_events(struct device_node *np,
 		desc[j].driver_data = info;
 
 		of_property_read_string(node, "event-name", &desc[j].name);
+		ret = of_property_read_u32(node, "event-data-type",
+					   &desc[j].data_type);
+		if (ret) {
+			/* Set the event of proper data type counting.
+			 * Check if the data type has been defined in DT,
+			 * use default if not.
+			 */
+			if (info->ppmu_type == EXYNOS_TYPE_PPMU_V2) {
+				struct devfreq_event_dev edev;
+				int id;
+				/* Not all registers take the same value for
+				 * read+write data count.
+				 */
+				edev.desc = &desc[j];
+				id = exynos_ppmu_find_ppmu_id(&edev);
+
+				switch (id) {
+				case PPMU_PMNCNT0:
+				case PPMU_PMNCNT1:
+				case PPMU_PMNCNT2:
+					desc[j].data_type = PPMU_V2_RO_DATA_CNT
+						| PPMU_V2_WO_DATA_CNT;
+					break;
+				case PPMU_PMNCNT3:
+					desc[j].data_type =
+						PPMU_V2_EVT3_RW_DATA_CNT;
+					break;
+				}
+			} else {
+				desc[j].data_type = PPMU_RO_DATA_CNT |
+					PPMU_WO_DATA_CNT;
+			}
+		}
 
 		j++;
 	}
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 4db00b02ca3f..cc160b1274c0 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -81,14 +81,20 @@ struct devfreq_event_ops {
  * struct devfreq_event_desc - the descriptor of devfreq-event device
  *
  * @name	: the name of devfreq-event device.
+ * @data_type	: the data type which is going to be counted in the register.
  * @driver_data	: the private data for devfreq-event driver.
  * @ops		: the operation to control devfreq-event device.
  *
  * Each devfreq-event device is described with a this structure.
  * This structure contains the various data for devfreq-event device.
+ * The data_type describes what is going to be counted in the register.
+ * It might choose to count e.g. read requests, write data in bytes, etc.
+ * The full supported list of types is present in specyfic header in:
+ * include/dt-bindings/pmu/.
  */
 struct devfreq_event_desc {
 	const char *name;
+	u32 data_type;
 	void *driver_data;
 
 	const struct devfreq_event_ops *ops;
-- 
2.17.1

