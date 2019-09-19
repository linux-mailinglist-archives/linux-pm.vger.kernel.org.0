Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDBCB7C3A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfISOYM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:24:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53489 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390593AbfISOXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142331euoutp02e7198568608afeb7ac53bf8ac631cdec~F3PoSH-B01740117401euoutp02d
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190919142331euoutp02e7198568608afeb7ac53bf8ac631cdec~F3PoSH-B01740117401euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903011;
        bh=D6O2vi1XFTzvAfXi4lZNJ+jX68pC4swcd5xtePoIdpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UK/iL0muiGT+GRxdvdSeBGK/rRNfLRMhby1to/QFm3AiipSoWizmRDmOAf9k5HDW9
         UAjJ8n7DgqAO+FprFTuCN6QaKXiEVlrnOzMD50bAl/xdWi/Ow8H0uRv8GZ9/pwfiD6
         LSYmprmm75cRuhen9t0HD0BpuHz1iH9K4JBkYxg4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190919142330eucas1p1dce149e7c648e6ce551fa74f9cb03431~F3PnZ6T9K1889418894eucas1p1S;
        Thu, 19 Sep 2019 14:23:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5C.1B.04309.26F838D5; Thu, 19
        Sep 2019 15:23:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e~F3Pml-I3T3084730847eucas1p2z;
        Thu, 19 Sep 2019 14:23:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142329eusmtrp10fc1c968997d1254489c18d3c5a2e802~F3PmXol0x0562505625eusmtrp1L;
        Thu, 19 Sep 2019 14:23:29 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-61-5d838f62dfa0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.1F.04166.16F838D5; Thu, 19
        Sep 2019 15:23:29 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142328eusmtip1da3ae3dff76a6d3af6177c4e689bea6f~F3Plh4up63272632726eusmtip1m;
        Thu, 19 Sep 2019 14:23:28 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
Date:   Thu, 19 Sep 2019 16:22:34 +0200
Message-Id: <20190919142236.4071-10-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O+fs7CjNzqbVm0Xlwh9JTYuCT4pICDo/utFPQ2rmQSU3Zcdl
        V5qX7GKlboTXUlPTlHIuFRtqOkciiWLWKjUmZGlZWm1RQlTbzqz+Pd9zeZ/3hY8hFU5JGJOi
        zeB1WnWqkg6i2h8vDG1KKMiJj3ZZI7DtcZsUO29dQLilpFmCX7inJbjSPiTBz77N07i4y0Jj
        o7OQwsPDZilueP1Fgi1vHBI8aq2gseuaHeGS4W4C37O/luLxrAYal5je07vknKXxMs1NODpp
        zpnfT3APas9zLXMdBNc710lw11sbEeeyrDnIxAXtSORTU07wuqidR4OSn5qmiPSarSdv5zYT
        BvQu8goKZIDdCu9HDdIrKIhRsA0I6htnKPHhRjDT9NWvuBDkjU9LFyPT1yr9rnoElfX30d/I
        QP53n4tmY8F4Y9IXD2XtCExV874IydYScL18mPS6Qlg1DNb+8GGKjYDcgs+EF8vYGKi2mWmx
        by00mXt8nkAP7+72dns9chgonfJh0uPJaSsnRf8FBozGdBHvhlGTmRBxCHzob/XfsBqemK5S
        Ihbg7UOnxLscsAYEljt2/6Dt0Nc/4hEYT8EGaLZGiXQsDGaPUV4a2GB4+UkurhAMxvZiUqRl
        cClPIUIlWEuDxSBAdpPDP5uD1pwKqhCFl/13S9l/t5T9q61CZCNawesFTRIvbNHymSpBrRH0
        2iTVsTSNBXm+3ZNf/e4OZP2ZYEMsg5RLZOsyc+IVEvUJ4ZTGhoAhlaGyim3Z8QpZovrUaV6X
        dkSnT+UFG1rFUMoVsjMBk4cVbJI6gz/O8+m8blElmMAwA9qT61DVXbRoY6L7ZtwLqubZep2F
        eS4vnTijH3JVVe+19m6eNZ0Pt2bcdaxsmNVkE4bPh1r2ZZ1Lq6mz69fnTvQYlquCl+pf5Y01
        7T+5NGZmID4gYsF4wxXwSRX2O/nm2eeqor6P8/kBGZquZUkbR+LMVw90h7yMrnSF7i2aeCQf
        UVJCsnpzJKkT1H8AkIukJXIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7qJ/c2xBocbNSwOHdvKbnF/Xiuj
        xcYZ61ktrn95zmox/8g5VosrX9+zWUzfu4nNYtL9CSwW589vYLdYcfcjq8Wmx9dYLS7vmsNm
        8bn3CKPFjPP7mCzWHrnLbnG7cQWbxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe2x8t4PJ
        4+C7PUwefVtWMXp83iQXwBGlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl3Fp8hOmgsUmFYta1jM1MD7T6mLk5JAQMJF43jufpYuRi0NIYCmjxI62
        K+wQCQmJj+tvsELYwhJ/rnWxQRR9YpR4/GgqC0iCTcBRYtLUB+wgCRGBU4wSW5efA6tiFtjA
        JLH86UuwdmGBeIm3v3+CjWURUJVo6f/ABGLzClhKLDy0gQ1ihbzE6g0HmEFsTqD4l33zwTYI
        CVhIzH08lxGiXlDi5MwnQHEOoAXqEuvnCYGEmYFam7fOZp7AKDgLSdUshKpZSKoWMDKvYhRJ
        LS3OTc8tNtQrTswtLs1L10vOz93ECIzibcd+bt7BeGlj8CFGAQ5GJR5ehfLmWCHWxLLiytxD
        jBIczEoivHNMm2KFeFMSK6tSi/Lji0pzUosPMZoCvTaRWUo0OR+YYPJK4g1NDc0tLA3Njc2N
        zSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTAGsU/t97jS78Z25YSqY8CKJiOrbrZ7byac
        mjV/xb6KF2fifrl6Hb/ry7T2+sz3618uMf1y9xLjaxlrCVYxvfY5TwWvfVLbZZW3/WduouNf
        w7jFC01CjjQtCGzeL7Yh8o3cGg5XRksxjlgfpdXvOBPfNT16PNNjry/j4XtsRcuubYiZXx/O
        1TFHiaU4I9FQi7moOBEAjZlCuPgCAAA=
X-CMS-MailID: 20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

This patch adds interconnect functionality to the exynos-bus devfreq
driver.

The SoC topology is a graph (or, more specifically, a tree) and most of
its edges are taken from the devfreq parent-child hierarchy (cf.
Documentation/devicetree/bindings/devfreq/exynos-bus.txt). Due to
unspecified relative probing order, -EPROBE_DEFER may be propagated to
guarantee that a child is probed before its parent.

Each bus is now an interconnect provider and an interconnect node as well
(cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
itself as a node. Node IDs are not hardcoded but rather assigned at
runtime, in probing order (subject to the above-mentioned exception
regarding relative order). This approach allows for using this driver with
various Exynos SoCs.

Frequencies requested via the interconnect API for a given node are
propagated to devfreq using dev_pm_qos_update_request(). Please note that
it is not an error when CONFIG_INTERCONNECT is 'n', in which case all
interconnect API functions are no-op.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 153 +++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 8d44810cac69..e0232202720d 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -14,14 +14,19 @@
 #include <linux/devfreq-event.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/idr.h>
+#include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
 #define DEFAULT_SATURATION_RATIO	40
 
+#define icc_units_to_khz(x) ((x) / 8)
+
 struct exynos_bus {
 	struct device *dev;
 
@@ -35,6 +40,12 @@ struct exynos_bus {
 	struct opp_table *opp_table;
 	struct clk *clk;
 	unsigned int ratio;
+
+	/* One provider per bus, one node per provider */
+	struct icc_provider provider;
+	struct icc_node *node;
+
+	struct dev_pm_qos_request qos_req;
 };
 
 /*
@@ -59,6 +70,13 @@ exynos_bus_ops_edev(enable_edev);
 exynos_bus_ops_edev(disable_edev);
 exynos_bus_ops_edev(set_event);
 
+static int exynos_bus_next_id(void)
+{
+	static DEFINE_IDA(exynos_bus_icc_ida);
+
+	return ida_alloc(&exynos_bus_icc_ida, GFP_KERNEL);
+}
+
 static int exynos_bus_get_event(struct exynos_bus *bus,
 				struct devfreq_event_data *edata)
 {
@@ -171,6 +189,38 @@ static void exynos_bus_passive_exit(struct device *dev)
 	clk_disable_unprepare(bus->clk);
 }
 
+static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
+	s32 src_freq = icc_units_to_khz(src->avg_bw);
+	s32 dst_freq = icc_units_to_khz(dst->avg_bw);
+
+	dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
+	dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
+
+	return 0;
+}
+
+static int exynos_bus_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static struct icc_node *exynos_bus_icc_xlate(struct of_phandle_args *spec,
+					     void *data)
+{
+	struct exynos_bus *bus = data;
+
+	if (spec->np != bus->dev->of_node)
+		return ERR_PTR(-EINVAL);
+
+	return bus->node;
+}
+
 static int exynos_bus_parent_parse_of(struct device_node *np,
 					struct exynos_bus *bus)
 {
@@ -366,6 +416,101 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	return 0;
 }
 
+static int exynos_bus_icc_connect(struct exynos_bus *bus)
+{
+	struct device_node *np = bus->dev->of_node;
+	struct devfreq *parent_devfreq;
+	struct icc_node *parent_node = NULL;
+	struct of_phandle_args args;
+	int ret = 0;
+
+	parent_devfreq = devfreq_get_devfreq_by_phandle(bus->dev, 0);
+	if (!IS_ERR(parent_devfreq)) {
+		struct exynos_bus *parent_bus;
+
+		parent_bus = dev_get_drvdata(parent_devfreq->dev.parent);
+		parent_node = parent_bus->node;
+	} else {
+		/* Look for parent in DT */
+		int num = of_count_phandle_with_args(np, "parent",
+						     "#interconnect-cells");
+		if (num != 1)
+			goto out; /* 'parent' is optional */
+
+		ret = of_parse_phandle_with_args(np, "parent",
+						 "#interconnect-cells",
+						 0, &args);
+		if (ret < 0)
+			goto out;
+
+		of_node_put(args.np);
+
+		parent_node = of_icc_get_from_provider(&args);
+		if (IS_ERR(parent_node)) {
+			/* May be -EPROBE_DEFER */
+			ret = PTR_ERR(parent_node);
+			goto out;
+		}
+	}
+
+	ret = icc_link_create(bus->node, parent_node->id);
+
+out:
+	return ret;
+}
+
+static int exynos_bus_icc_init(struct exynos_bus *bus)
+{
+	struct device *dev = bus->dev;
+	struct icc_provider *provider = &bus->provider;
+	struct icc_node *node;
+	int id, ret;
+
+	/* Initialize the interconnect provider */
+	provider->set = exynos_bus_icc_set;
+	provider->aggregate = exynos_bus_icc_aggregate;
+	provider->xlate = exynos_bus_icc_xlate;
+	provider->dev = dev;
+	provider->data = bus;
+
+	ret = icc_provider_add(provider);
+	if (ret < 0)
+		goto out;
+
+	ret = id = exynos_bus_next_id();
+	if (ret < 0)
+		goto err_node;
+
+	node = icc_node_create(id);
+	if (IS_ERR(node)) {
+		ret = PTR_ERR(node);
+		goto err_node;
+	}
+
+	bus->node = node;
+	node->name = dev->of_node->name;
+	node->data = bus;
+	icc_node_add(node, provider);
+
+	ret = exynos_bus_icc_connect(bus);
+	if (ret < 0)
+		goto err_connect;
+
+	ret = dev_pm_qos_add_request(bus->devfreq->dev.parent, &bus->qos_req,
+				     DEV_PM_QOS_MIN_FREQUENCY, 0);
+
+out:
+	return ret;
+
+err_connect:
+	icc_node_del(node);
+	icc_node_destroy(id);
+err_node:
+	icc_provider_del(provider);
+
+	return ret;
+}
+
 static int exynos_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -415,6 +560,14 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err;
 
+	/*
+	 * Initialize interconnect provider. A return value of -ENOTSUPP means
+	 * that CONFIG_INTERCONNECT is disabled.
+	 */
+	ret = exynos_bus_icc_init(bus);
+	if (ret < 0 && ret != -ENOTSUPP)
+		goto err;
+
 	max_state = bus->devfreq->profile->max_state;
 	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
 	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
-- 
2.17.1

