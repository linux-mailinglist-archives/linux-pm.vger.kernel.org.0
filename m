Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2371805
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfGWMUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:20:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57755 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389737AbfGWMUc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122030euoutp02af493fad379bd8e245d4988afb246ef7~0CJpzCE7W3179531795euoutp02Y
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190723122030euoutp02af493fad379bd8e245d4988afb246ef7~0CJpzCE7W3179531795euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884430;
        bh=EtXo80b/BOT2bVBAt0gRdcaUhCVQMvr2P5JS+yzpsFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r37o2mn0DkTPjwV1X0YN4FWaEExESyZ/rWuSS0vKyKZ2qh1DIG3JVTwfg4ye+5IxV
         kzPLpQWZqh0cA7fIuVTfZiJBl2EehcBx2YnzFDeO1QdAP8KWeoKDAkpqlG9nYRqPPH
         PeWaUfSHwt2n++sCe1ocPEM+zFUcfsfqxVPrrOKo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723122029eucas1p1d78d048e09d79033ca28037784d3275e~0CJpL8H0n0311003110eucas1p1Z;
        Tue, 23 Jul 2019 12:20:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 96.5B.04298.D8BF63D5; Tue, 23
        Jul 2019 13:20:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b~0CJoWSNdP2751627516eucas1p2d;
        Tue, 23 Jul 2019 12:20:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122028eusmtrp1913f3fc00eda32f785805f9f4a05df09~0CJoLsl3s2543625436eusmtrp1I;
        Tue, 23 Jul 2019 12:20:28 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-89-5d36fb8dd145
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 40.E8.04140.C8BF63D5; Tue, 23
        Jul 2019 13:20:28 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122027eusmtip2139fe56f44e2ea08e589506ebef6382c~0CJniKV8X1668716687eusmtip2A;
        Tue, 23 Jul 2019 12:20:27 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
Date:   Tue, 23 Jul 2019 14:20:14 +0200
Message-Id: <20190723122016.30279-10-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7q9v81iDdac57I4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        exSXTUpqTmZZapG+XQJXxutdGgW/zSuW9/1jbGDcr9vFyMkhIWAicbD1BFMXIxeHkMAKRonv
        e5ZBOV8YJdZ3P2CGcD4zSvy7/4UNpmXLmimsEInljBLdTz+zwrXsfzWLBaSKTcBTomfiDrCE
        iMARRonJC96zgDjMAquAnO/bGLsYOTiEBeIkOva7gTSwCKhKTLwyjR0kzCvgJHFpijXENnmJ
        1RsOMIPYnEDhrqPtYFfwCghKnJz5BGwXM1BN89bZYKdKCHxkl/j16gA7RLOLxKmlV5ghbGGJ
        V8e3QMVlJE5P7mGBsIslnu68zwrR3MAosWnZEagGa4nDxy+yghzELKApsX6XPkTYUeJt31Fm
        kLCEAJ/EjbeCEDfwSUzaNh0qzCvR0SYEYWpJLPgdDdEoIdG0+hrUbA+JlkfP2ScwKs5C8sws
        JM/MQli7gJF5FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmAqO/3v+KcdjF8vJR1iFOBg
        VOLh3bDHNFaINbGsuDL3EKMEB7OSCG9gg1msEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfR
        QgLpiSWp2ampBalFMFkmDk6pBsamPhXLDRr7fThFjFs/5Z3+++/WhqcvvSvmn2Crk2JlU3ph
        fLbmlXj2o6V6qw/2KMd/nqNqdEfW0HCzQTd/0tJptl7qihbXV38Rddr6KDp/VlZ01/RdPYte
        JJ6b9PEaF3Oo7n2vN8dnR5pobeG2PC574u/6c1ffOJ08XcbV8jp2R02g7buExzOUWIozEg21
        mIuKEwHM5WhMYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7o9v81iDX4e4Lc4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexutd
        GgW/zSuW9/1jbGDcr9vFyMkhIWAisWXNFFYQW0hgKaPExGmqEHEJiY/rb7BC2MISf651sXUx
        cgHVfGKUaF1xiwkkwSbgKdEzcQcrSEJE4BSjxNbl58CqmAU2MUrcPT6RHaRKWCBGYvenDYwg
        NouAqsTEK9OA4hwcvAJOEpemWENskJdYveEAM4jNCRTuOtrOBnGRo8S27a/BWnkFBCVOznzC
        AtLKLKAusX6eEEiYGai1eets5gmMgrOQVM1CqJqFpGoBI/MqRpHU0uLc9NxiI73ixNzi0rx0
        veT83E2MwAjdduznlh2MXe+CDzEKcDAq8fBu2GMaK8SaWFZcmXuIUYKDWUmEN7DBLFaINyWx
        siq1KD++qDQntfgQoynQZxOZpUST84HJI68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6Yklq
        dmpqQWoRTB8TB6dUA2Nkpd6ah1MSuNqyfVXEZm9w/nftQNPj6TPdy1geXZ99pLliWuU9/v/7
        ft5buj4pev0bs2XP1Es8GkqyzavOSC6dy/RrVeUTBRE+108W9g8/f1mfMT3DYEPJ23cKgkur
        G57t6Wo5X3HjmZV7uIOH3KZNi7Z9PbJfWTZ0R5CNhOlvs9N3579cWrdMiaU4I9FQi7moOBEA
        hcHFd+YCAAA=
X-CMS-MailID: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds interconnect functionality to the exynos-bus devfreq
driver.

The SoC topology is a graph (or, more specifically, a tree) and most of its
edges are taken from the devfreq parent-child hierarchy (cf.
Documentation/devicetree/bindings/devfreq/exynos-bus.txt). The previous
patch adds missing edges to the DT (under the name 'parent'). Due to
unspecified relative probing order, -EPROBE_DEFER may be propagated to
guarantee that a child is probed before its parent.

Each bus is now an interconnect provider and an interconnect node as well
(cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
itself as a node. Node IDs are not hardcoded but rather assigned at
runtime, in probing order (subject to the above-mentioned exception
regarding relative order). This approach allows for using this driver with
various Exynos SoCs.

The devfreq target() callback provided by exynos-bus now selects either the
frequency calculated by the devfreq governor or the frequency requested via
the interconnect API for the given node, whichever is higher.

Please note that it is not an error when CONFIG_INTERCONNECT is 'n', in
which case all interconnect API functions are no-op.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 145 +++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 412511ca7703..12fb7c84ae50 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -14,6 +14,7 @@
 #include <linux/devfreq-event.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -23,6 +24,8 @@
 #define DEFAULT_SATURATION_RATIO	40
 #define DEFAULT_VOLTAGE_TOLERANCE	2
 
+#define icc_units_to_hz(x) ((x) * 1000UL / 8)
+
 struct exynos_bus {
 	struct device *dev;
 
@@ -31,12 +34,17 @@ struct exynos_bus {
 	unsigned int edev_count;
 	struct mutex lock;
 
+	unsigned long min_freq;
 	unsigned long curr_freq;
 
 	struct regulator *regulator;
 	struct clk *clk;
 	unsigned int voltage_tolerance;
 	unsigned int ratio;
+
+	/* One provider per bus, one node per provider */
+	struct icc_provider provider;
+	struct icc_node *node;
 };
 
 /*
@@ -61,6 +69,13 @@ exynos_bus_ops_edev(enable_edev);
 exynos_bus_ops_edev(disable_edev);
 exynos_bus_ops_edev(set_event);
 
+static int exynos_bus_next_id(void)
+{
+	static int exynos_bus_node_id;
+
+	return exynos_bus_node_id++;
+}
+
 static int exynos_bus_get_event(struct exynos_bus *bus,
 				struct devfreq_event_data *edata)
 {
@@ -98,6 +113,8 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 	unsigned long old_freq, new_freq, new_volt, tol;
 	int ret = 0;
 
+	*freq = max(*freq, bus->min_freq);
+
 	/* Get new opp-bus instance according to new bus clock */
 	new_opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(new_opp)) {
@@ -208,6 +225,8 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
 	unsigned long old_freq, new_freq;
 	int ret = 0;
 
+	*freq = max(*freq, bus->min_freq);
+
 	/* Get new opp-bus instance according to new bus clock */
 	new_opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(new_opp)) {
@@ -251,6 +270,35 @@ static void exynos_bus_passive_exit(struct device *dev)
 	clk_disable_unprepare(bus->clk);
 }
 
+static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
+
+	src_bus->min_freq = icc_units_to_hz(src->peak_bw);
+	dst_bus->min_freq = icc_units_to_hz(dst->peak_bw);
+
+	return 0;
+}
+
+static int exynos_bus_icc_aggregate(struct icc_node *node, u32 avg_bw,
+				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_peak = *agg_avg = peak_bw;
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
@@ -469,6 +517,95 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	return ret;
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
+			goto out;
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
+	id = exynos_bus_next_id();
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
@@ -517,6 +654,14 @@ static int exynos_bus_probe(struct platform_device *pdev)
 			goto err;
 	}
 
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

