Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E0D127A90
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfLTMCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 07:02:03 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36395 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfLTMBr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 07:01:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191220120145euoutp013b5f4dfcb22a68776b8a17df2cb479a0~iEqHXWi1-1030410304euoutp012
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 12:01:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191220120145euoutp013b5f4dfcb22a68776b8a17df2cb479a0~iEqHXWi1-1030410304euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576843305;
        bh=EMoPAC75FBY1rzEvXerOmj/3hLvCyILy+vvdDVXy7a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRCnruzb/wY9YAaY5gD3giVNZ2IaC86gwj8514iGy1XRgMfyzA5i66EzStxwldjmz
         Dmnc508mUSlm09ciGE+o+5Qj5bv+BeIWD52KrLF+Qg8taD48ZXXWYj525anWcmCepn
         Nu4wa72qB3QvgybK72cEdeADTUJpamHtO9qu0wvw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191220120145eucas1p15c70bfb8a1ed29cdc9146915b0ba97ba~iEqHFhwRt1908419084eucas1p1S;
        Fri, 20 Dec 2019 12:01:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A4.3E.60698.928BCFD5; Fri, 20
        Dec 2019 12:01:45 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191220120145eucas1p295af63eed7b23982d8c49fcf875cec8c~iEqGt9ZyO2958229582eucas1p24;
        Fri, 20 Dec 2019 12:01:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191220120145eusmtrp2bddf4a83107f924dccfe910146f1c3a1~iEqGtG9RP2149221492eusmtrp2y;
        Fri, 20 Dec 2019 12:01:45 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-4b-5dfcb82996b3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.87.08375.928BCFD5; Fri, 20
        Dec 2019 12:01:45 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191220120144eusmtip2b8b1a1fa0c24155f199d95970587d722~iEqF9D0FK3105631056eusmtip2a;
        Fri, 20 Dec 2019 12:01:44 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v3 5/7] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
Date:   Fri, 20 Dec 2019 12:56:51 +0100
Message-Id: <20191220115653.6487-6-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220115653.6487-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRzf73nuee7p6vJ0aX1F4pq1whX54ydmtbEdNjNjrEkdPdJ0l91T
        kT84jlTnpWWtK72RVcuMHrFqhNxqybrp9Titoogh7aoJQ0/Pmf77fH+fl+/Lfgyp6qICmGRD
        Gmc06FLUtEL2oHXGvjq04VdcRN73QDxYdh7hOusdCvdPfqBwua2Twj1T4zQufCTQOH8wT4bt
        9rtyXDMwQWHhXR+Fu5tKaOy6ZEPYam8m8G3bgBw7z9TQ2Hr1Ix3NaoXaHFr7pu8hrR20tBHa
        ezdPa+u+NhDay/W1SOsSlu6Uxyo2JnIpyRmcMXxTguKIc8xJH/sdfuLKswnahKpCchHDALsO
        vrzYk4sUjIqtQdD9uYbKRR6zxSSCOsd+iXAhuPzos0wkRIOQbSIkohpB/Wvrf0dFwRYR02wM
        5BcMyUXRQtaG4GrFuEwsSLaEgOyc6rkoXzYeJp8Mzbll7Aq4br9IiFjJYjCPNMqldkFw6+4T
        UsQe7Hpw9HaRksYH2otG5nLIWY35/jVS0k/JofL+Pglvhvz2T+4cX/jUVu/GS+BPYzkhYR5G
        GwcpcThgTQiEKps7aAO86fxBi0ci2VC40xQuPcdAq9Atl27nDY4vPtII3pD/oJCUnpWQnaWS
        oBqairwlI8DZW33ubC30z0wQeWh58bxdiuftUvy/bQUia5E/l87rkzg+0sAd1/A6PZ9uSNIc
        StULaPandfxum2pAzb8OtiCWQWovZfThn3EqSpfBZ+pbEDCkeqHSmT0Tp1Im6jJPcsbUeGN6
        Cse3oMWMTO2vjLzxMU7FJunSuKMcd4wz/mMJxiPAhErSO8YOdCx67OIDB5Lfvgo3h7pYRdlw
        5alz0zvMWVaf0TIvv7U9+54b6Mis2AWeK59GFFxYui3W0zIx0lWoVx0yhQRZxr8FO8KG+V3L
        LIUnhKTSK+UtxgIiRvNyaImfZqv5euaqKH1KUakm+D0zk0AGTpuigtjenr15W6JvbN+tlvFH
        dGvCSCOv+wsmu2svZQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7qaO/7EGiw9xGZxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3WHH3I6vFpsfXWC0u75rDZvG59wij
        xYzz+5gs1h65y25xu3EFm8WMyS/ZHAQ8Nq3qZPO4c20Pm8f97uNMHpuX1HtsfLeDyaNvyypG
        j8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQybr+4zVbwT7+i//BHtgbGZepdjJwcEgImEps6Gpi6GLk4hASWMkp8vXaRCSIhIfFx/Q1W
        CFtY4s+1LjaIok+MEnff3mAGSbAJOEpMmvqAHSQhInCKUWLr8nNsIAlmgRVMEv1zhEFsYYFY
        iZ7l68EmsQioSiw83wO2gVfAQqL5yU52iA3yEqs3HAAbyilgKXHj6iUwWwioZufnPqh6QYmT
        M5+wdDFyAM1Xl1g/TwhilbxE89bZzBMYBWchqZqFUDULSdUCRuZVjCKppcW56bnFhnrFibnF
        pXnpesn5uZsYgfG67djPzTsYL20MPsQowMGoxMP7Mvl3rBBrYllxZe4hRgkOZiUR3tsdP2OF
        eFMSK6tSi/Lji0pzUosPMZoCvTaRWUo0OR+YSvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmk
        J5akZqemFqQWwfQxcXBKNTDOfa7uftNQeXXJrxMce0Wk+Dc7Hv9cf2xFqufltQuj7/zITJdx
        MxML+3xxnvqRvn0buNKvTLu1yOTbz61MKp+uPzZ73JUV13v1r0yP/5n3NhemymXfr+2Nvrfr
        z/XF+acSpnxJKNzYYbFC6CXT+g26/xNO7VD1tP9YU3EmvVDO2zZXNjMn/XCZEktxRqKhFnNR
        cSIAfK1wku0CAAA=
X-CMS-MailID: 20191220120145eucas1p295af63eed7b23982d8c49fcf875cec8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120145eucas1p295af63eed7b23982d8c49fcf875cec8c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120145eucas1p295af63eed7b23982d8c49fcf875cec8c
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120145eucas1p295af63eed7b23982d8c49fcf875cec8c@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds interconnect functionality to the exynos-bus devfreq
driver.

The SoC topology is a graph (or, more specifically, a tree) and its
edges are specified using the 'exynos,interconnect-parent-node' in the
DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
propagated to ensure that the parent is probed before its children.

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

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 144 +++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 9fdb188915e8..694a9581dcdb 100644
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
 
+#define kbps_to_khz(x) ((x) / 8)
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
@@ -205,6 +216,39 @@ static void exynos_bus_passive_exit(struct device *dev)
 	clk_disable_unprepare(bus->clk);
 }
 
+static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
+	s32 src_freq = kbps_to_khz(src->avg_bw);
+	s32 dst_freq = kbps_to_khz(dst->avg_bw);
+	int ret;
+
+	ret = dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
+	if (ret < 0) {
+		dev_err(src_bus->dev, "failed to update PM QoS request");
+		return ret;
+	}
+
+	ret = dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
+	if (ret < 0) {
+		dev_err(dst_bus->dev, "failed to update PM QoS request");
+		return ret;
+	}
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
@@ -419,6 +463,96 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	return 0;
 }
 
+static struct icc_node *exynos_bus_icc_get_parent(struct exynos_bus *bus)
+{
+	struct device_node *np = bus->dev->of_node;
+	struct of_phandle_args args;
+	int num, ret;
+
+	num = of_count_phandle_with_args(np, "exynos,interconnect-parent-node",
+					"#interconnect-cells");
+	if (num != 1)
+		return NULL; /* parent nodes are optional */
+
+	ret = of_parse_phandle_with_args(np, "exynos,interconnect-parent-node",
+					"#interconnect-cells", 0, &args);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	of_node_put(args.np);
+
+	return of_icc_get_from_provider(&args);
+}
+
+static int exynos_bus_icc_init(struct exynos_bus *bus)
+{
+	static DEFINE_IDA(ida);
+
+	struct device *dev = bus->dev;
+	struct icc_provider *provider = &bus->provider;
+	struct icc_node *node, *parent_node;
+	int id, ret;
+
+	/* Initialize the interconnect provider */
+	provider->set = exynos_bus_icc_set;
+	provider->aggregate = icc_std_aggregate;
+	provider->xlate = exynos_bus_icc_xlate;
+	provider->dev = dev;
+	provider->inter_set = true;
+	provider->data = bus;
+
+	ret = icc_provider_add(provider);
+	if (ret < 0)
+		return ret;
+
+	ret = id = ida_alloc(&ida, GFP_KERNEL);
+	if (ret < 0)
+		goto err_id;
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
+	parent_node = exynos_bus_icc_get_parent(bus);
+	if (IS_ERR(parent_node)) {
+		ret = PTR_ERR(parent_node);
+		goto err_parent;
+	}
+
+	if (parent_node) {
+		ret = icc_link_create(node, parent_node->id);
+		if (ret < 0)
+			goto err_parent;
+	}
+
+	ret = dev_pm_qos_add_request(bus->devfreq->dev.parent, &bus->qos_req,
+					DEV_PM_QOS_MIN_FREQUENCY, 0);
+	if (ret < 0)
+		goto err_request;
+
+	return 0;
+
+err_request:
+	if (parent_node)
+		icc_link_destroy(node, parent_node);
+err_parent:
+	icc_node_del(node);
+	icc_node_destroy(id);
+err_node:
+	ida_free(&ida, id);
+err_id:
+	icc_provider_del(provider);
+
+	return ret;
+}
+
 static int exynos_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -468,6 +602,16 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err;
 
+	/*
+	 * Initialize interconnect provider. A return value of -ENOTSUPP means
+	 * that CONFIG_INTERCONNECT is disabled.
+	 */
+	ret = exynos_bus_icc_init(bus);
+	if (ret < 0 && ret != -ENOTSUPP) {
+		dev_err(dev, "failed to initialize the interconnect provider");
+		goto err;
+	}
+
 	max_state = bus->devfreq->profile->max_state;
 	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
 	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
-- 
2.17.1

