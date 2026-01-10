Return-Path: <linux-pm+bounces-40605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CDD0DD76
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 21:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73045301F016
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 20:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF223ED5B;
	Sat, 10 Jan 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR7GTQdg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85A1DF25F
	for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768077848; cv=none; b=jZmbU7T7LixL3ykb7M59L4v75sPcr9RH3BKSre8BKP0jTTToW0kz/h7BiEzr9GsElWpIpc4VgzcscA8oYRS93EsPiGehqymv6QGkmsI1ZW/rvZDendk1NyKyFqnYawkC7FFhusHsc4Hc9UhI2cfLxTnWNjO3yu7QtiUj5RaCop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768077848; c=relaxed/simple;
	bh=a4HmEfh9BqR7pTBiKgNox5hkDeetZuvGFpwNpPQK9TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8CzLfMw1IvWqoia0E7aXz46F58RafFx/c1Q/TtlxwXO23IBM1jhkKegG42bgAuT7Rq6ktowpxXLjV1a6uirE2kmpuqFIjcYWX97k7LCLiGnPm1kBkfoAtkvIgJGxpF6YxiC7QCpKfTuV+vdo9jI8BNm7almHTMf9HC71yiYyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR7GTQdg; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94121102a54so3592203241.1
        for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768077846; x=1768682646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2QgzlraiAQ3LvbrUcID54KuJyrj3432Mgk/LsLaWtE=;
        b=mR7GTQdgcxYxA2kkOVrRT6lx0RFLylwydpzO0RW0GXsIj4VjqhHB/ll0dIXjuf7gsX
         UG6N2P225USRW1RZ3TsJNGOcS1fy8nJJ0HBodRYyGxYkMuvRNHtWx5oFq7gyVooo7wSm
         bQqvGn9xVJ9qecFnLKhia8ohhNV7hBVERTIznGwoEjlRhnqMfKgkF40RMLPyfnlnHjye
         DlChedwA/XsIysNj4HMpfv0F8crSo/2ENnak+G3ahPV0SgQJXIs2PO3PlsaOzbUGz4AV
         lxYMHj+eeuPteEcuSl0nTWmcpN2tCyWybkpotXiD+H7kn+wVryV2t7JB4XD6tkm0T0LA
         mO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768077846; x=1768682646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2QgzlraiAQ3LvbrUcID54KuJyrj3432Mgk/LsLaWtE=;
        b=jPPONfcc+iyJvpGJp45JSEM83CKLjaXi1NbPHT0Dwe8V8ZoCuXWDVJYEalEHuCpp74
         q9ghuDBefSJeKmbYzJFZseI3bj1pYuCuGWpdR4TJXqC578u4uN77F5hVNaCm4g3GYeVF
         HyipRRawd8k3GtsYh/owakPICX+XIZXz6sZOKpL0kPz1sQglmloVH4h0F9VYRihlPvS7
         bH2ZL3w/9luwelQFrPwRi6dvoJMOQFLz0jQDqU+N9Lx3CnjHm4wiHgBkCGfMwIF9Nt3G
         IW3Qa+Q7uhRmPBlrcXmVa4NXSzTtBSu8cFOMhje+c2eddpX/Qj5KCbKpknvLj0IngqRH
         ToaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Imnh9ND5zdLdQLcPijMobmjVBqh7UlPa9Wf2VJyDHTjY//12JG61JRsGffpY/jq5vN21wvgqfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywjJv0AD6Iaj11Vg/EshRGth+Hb0atAgvlq6fgdODrz3UXUa6n
	CDhiGLahmt4gVMkEt/LfIUjN5VyI6XT9rYT8XMrW7nIR0rp5/DVE1yneMt+6ww==
X-Gm-Gg: AY/fxX6B3aPdQyljqlA2WQfpDe9r6Bbj4kRDBiuSX2EYSgsz5M0mSfVlEs6HQ61GpjT
	9fJGP0x0sGxfl6yTWKFbmI266JRllqkLfXqToLvySz9l4+78LB4EPLvxGSCyUS4gZb6YsR0j+/6
	i+/iOlqTHpheNPAojbaULTk9HzRGieEc7D0/6VY6hw+iYpX+kbtkTFK6cYQlUa6e6kXUGjerlK1
	rOWOVS01TgOPflPS/jFnpiB0+a99k9Cc0/YoHDmvFWYiQPJV1xb2+9QcRUR3DZsr0/qIdTDRE25
	Y4zz47p1WCKLPna+azLH9xXP8IEKaa4H0CJP1Wbtt1vMKRJw1qEYlEnpcdvDo0Qhl+jWB4xNRuw
	74tAw1nM8CBtq15QXnaF0esL8kFjdjw1JX1fwzyJdxnpyAkS2w463USVNhKOp6Khkw/n5CCdhIX
	oPa0ksx0jBUXBh3P9Rr0gKeMJC534Om9kVr7XOFojbrQZ/8NeZ1KalCLCcSjAF/5Yo7U92FHiMA
	UO1BFwjvGGteohJIjM9vtKiyEtKsoSd
X-Google-Smtp-Source: AGHT+IHJyW9uEXWCJiI83QcTAYmX1GcC5s0mRQdqyVrWqtgcrZ+wGI7/QW2fOBYzChEaW0ufq8KGjQ==
X-Received: by 2002:a17:903:2b05:b0:29f:1738:348e with SMTP id d9443c01a7336-2a3ee433c46mr132033055ad.15.1768070603633;
        Sat, 10 Jan 2026 10:43:23 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c5ce06sm132349985ad.44.2026.01.10.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 10:43:23 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	marscheng@google.com,
	wllee@google.com,
	aarontian@google.com,
	hsuanting@google.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] interconnect: Add kunit tests for core functionality
Date: Sat, 10 Jan 2026 18:43:09 +0000
Message-ID: <20260110184309.906735-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interconnect framework currently lacks in-tree unit tests to verify
the core logic in isolation. This makes it difficult to validate
regression stability when modifying the provider/consumer APIs or
aggregation logic.

Introduce a kunit test suite that verifies the fundamental behavior of
the subsystem. The tests cover:
- Provider API (node creation, linking, topology construction).
- Consumer API (path enabling/disabling, bandwidth requests).
- Standard aggregation logic (accumulating bandwidth across links).
- Bulk operations for setting bandwidth on multiple paths.

The suite simulates a simple SoC topology with multiple masters and a
shared bus to validate traffic aggregation behavior in a controlled
software environment, without requiring specific hardware or Device
Tree support.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Switch to 0-based node IDs to avoid sparse array usage.
- Implement .get_bw callback to ensure zero initial bandwidth.

 drivers/interconnect/Kconfig     |  14 ++
 drivers/interconnect/Makefile    |   2 +
 drivers/interconnect/icc-kunit.c | 324 +++++++++++++++++++++++++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 drivers/interconnect/icc-kunit.c

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index f2e49bd97d31..882dcb0b4a5b 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -22,4 +22,18 @@ config INTERCONNECT_CLK
 	help
 	  Support for wrapping clocks into the interconnect nodes.
 
+config INTERCONNECT_KUNIT_TEST
+	tristate "KUnit tests for Interconnect framework"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit test suite for the generic system interconnect
+	  framework.
+
+	  The tests cover the core functionality of the interconnect subsystem,
+	  including provider/consumer APIs, topology management, and bandwidth
+	  aggregation logic.
+
+	  If unsure, say N.
+
 endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index b0a9a6753b9d..dc4c7b657c9d 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
 obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
 
 obj-$(CONFIG_INTERCONNECT_CLK)		+= icc-clk.o
+
+obj-$(CONFIG_INTERCONNECT_KUNIT_TEST) += icc-kunit.o
diff --git a/drivers/interconnect/icc-kunit.c b/drivers/interconnect/icc-kunit.c
new file mode 100644
index 000000000000..bad2b583737b
--- /dev/null
+++ b/drivers/interconnect/icc-kunit.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the Interconnect framework.
+ *
+ * Copyright (c) 2025 Kuan-Wei Chiu <visitorckw@gmail.com>
+ *
+ * This suite verifies the behavior of the interconnect core, including
+ * topology construction, bandwidth aggregation, and path lifecycle.
+ */
+
+#include <kunit/platform_device.h>
+#include <kunit/test.h>
+#include <linux/interconnect-provider.h>
+#include <linux/interconnect.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+enum {
+	NODE_CPU,
+	NODE_GPU,
+	NODE_BUS,
+	NODE_DDR,
+	NODE_MAX
+};
+
+struct test_node_data {
+	int id;
+	const char *name;
+	int num_links;
+	int links[2];
+};
+
+/*
+ * Static Topology:
+ * CPU -\
+ * -> BUS -> DDR
+ * GPU -/
+ */
+static const struct test_node_data test_topology[] = {
+	{ NODE_CPU, "cpu", 1, { NODE_BUS } },
+	{ NODE_GPU, "gpu", 1, { NODE_BUS } },
+	{ NODE_BUS, "bus", 1, { NODE_DDR } },
+	{ NODE_DDR, "ddr", 0, { } },
+};
+
+struct icc_test_priv {
+	struct icc_provider provider;
+	struct platform_device *pdev;
+	struct icc_node *nodes[NODE_MAX];
+};
+
+static struct icc_node *get_node(struct icc_test_priv *priv, int id)
+{
+	int idx = id - NODE_CPU;
+
+	if (idx < 0 || idx >= ARRAY_SIZE(test_topology))
+		return NULL;
+	return priv->nodes[idx];
+}
+
+static int icc_test_set(struct icc_node *src, struct icc_node *dst)
+{
+	return 0;
+}
+
+static int icc_test_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	return icc_std_aggregate(node, tag, avg_bw, peak_bw, agg_avg, agg_peak);
+}
+
+static struct icc_node *icc_test_xlate(const struct of_phandle_args *spec, void *data)
+{
+	return NULL;
+}
+
+static int icc_test_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static int icc_test_init(struct kunit *test)
+{
+	struct icc_test_priv *priv;
+	struct icc_node *node;
+	int i, j, ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	test->priv = priv;
+
+	priv->pdev = kunit_platform_device_alloc(test, "icc-test-dev", -1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->pdev);
+	KUNIT_ASSERT_EQ(test, kunit_platform_device_add(test, priv->pdev), 0);
+
+	priv->provider.set = icc_test_set;
+	priv->provider.aggregate = icc_test_aggregate;
+	priv->provider.xlate = icc_test_xlate;
+	priv->provider.get_bw = icc_test_get_bw;
+	priv->provider.dev = &priv->pdev->dev;
+	priv->provider.data = priv;
+	INIT_LIST_HEAD(&priv->provider.nodes);
+
+	ret = icc_provider_register(&priv->provider);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	for (i = 0; i < ARRAY_SIZE(test_topology); i++) {
+		const struct test_node_data *data = &test_topology[i];
+
+		node = icc_node_create(data->id);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+		node->name = data->name;
+		icc_node_add(node, &priv->provider);
+		priv->nodes[i] = node;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(test_topology); i++) {
+		const struct test_node_data *data = &test_topology[i];
+		struct icc_node *src = get_node(priv, data->id);
+
+		for (j = 0; j < data->num_links; j++) {
+			ret = icc_link_create(src, data->links[j]);
+			KUNIT_ASSERT_EQ_MSG(test, ret, 0, "Failed to link %s->%d",
+					    src->name, data->links[j]);
+		}
+	}
+
+	icc_sync_state(&priv->pdev->dev);
+
+	return 0;
+}
+
+static void icc_test_exit(struct kunit *test)
+{
+	struct icc_test_priv *priv = test->priv;
+
+	icc_nodes_remove(&priv->provider);
+	icc_provider_deregister(&priv->provider);
+}
+
+/*
+ * Helper to construct a mock path.
+ *
+ * Because we are bypassing icc_get(), we must manually link the requests
+ * to the nodes' req_list so that icc_std_aggregate() can discover them.
+ */
+static struct icc_path *icc_test_create_path(struct kunit *test,
+					     struct icc_node **nodes, int num)
+{
+	struct icc_path *path;
+	int i;
+
+	path = kunit_kzalloc(test, struct_size(path, reqs, num), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, path);
+
+	path->num_nodes = num;
+	for (i = 0; i < num; i++) {
+		path->reqs[i].node = nodes[i];
+		hlist_add_head(&path->reqs[i].req_node, &nodes[i]->req_list);
+	}
+	path->name = "mock-path";
+
+	return path;
+}
+
+static void icc_test_destroy_path(struct kunit *test, struct icc_path *path)
+{
+	int i;
+
+	for (i = 0; i < path->num_nodes; i++)
+		hlist_del(&path->reqs[i].req_node);
+
+	kunit_kfree(test, path);
+}
+
+static void icc_test_topology_integrity(struct kunit *test)
+{
+	struct icc_test_priv *priv = test->priv;
+	struct icc_node *cpu = get_node(priv, NODE_CPU);
+	struct icc_node *bus = get_node(priv, NODE_BUS);
+
+	KUNIT_EXPECT_EQ(test, cpu->num_links, 1);
+	KUNIT_EXPECT_PTR_EQ(test, cpu->links[0], bus);
+	KUNIT_EXPECT_PTR_EQ(test, cpu->provider, &priv->provider);
+}
+
+static void icc_test_set_bw(struct kunit *test)
+{
+	struct icc_test_priv *priv = test->priv;
+	struct icc_path *path;
+	struct icc_node *path_nodes[3];
+	int ret;
+
+	/* Path: CPU -> BUS -> DDR */
+	path_nodes[0] = get_node(priv, NODE_CPU);
+	path_nodes[1] = get_node(priv, NODE_BUS);
+	path_nodes[2] = get_node(priv, NODE_DDR);
+
+	path = icc_test_create_path(test, path_nodes, 3);
+
+	ret = icc_enable(path);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = icc_set_bw(path, 1000, 2000);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, path_nodes[0]->avg_bw, 1000);
+	KUNIT_EXPECT_EQ(test, path_nodes[0]->peak_bw, 2000);
+	KUNIT_EXPECT_EQ(test, path_nodes[1]->avg_bw, 1000);
+	KUNIT_EXPECT_EQ(test, path_nodes[1]->peak_bw, 2000);
+
+	icc_set_tag(path, 0xABC);
+	KUNIT_EXPECT_EQ(test, path->reqs[0].tag, 0xABC);
+
+	icc_disable(path);
+	KUNIT_EXPECT_EQ(test, path_nodes[0]->avg_bw, 0);
+
+	icc_test_destroy_path(test, path);
+}
+
+static void icc_test_aggregation(struct kunit *test)
+{
+	struct icc_test_priv *priv = test->priv;
+	struct icc_path *path_cpu, *path_gpu;
+	struct icc_node *nodes_cpu[3], *nodes_gpu[2];
+	struct icc_node *bus = get_node(priv, NODE_BUS);
+	int ret;
+
+	nodes_cpu[0] = get_node(priv, NODE_CPU);
+	nodes_cpu[1] = bus;
+	nodes_cpu[2] = get_node(priv, NODE_DDR);
+	path_cpu = icc_test_create_path(test, nodes_cpu, 3);
+
+	nodes_gpu[0] = get_node(priv, NODE_GPU);
+	nodes_gpu[1] = bus;
+	path_gpu = icc_test_create_path(test, nodes_gpu, 2);
+
+	icc_enable(path_cpu);
+	icc_enable(path_gpu);
+
+	ret = icc_set_bw(path_cpu, 1000, 1000);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, bus->avg_bw, 1000);
+
+	ret = icc_set_bw(path_gpu, 2000, 2000);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* Bus aggregates: CPU(1000) + GPU(2000) */
+	KUNIT_EXPECT_EQ(test, bus->avg_bw, 3000);
+	/* Peak aggregates: max(CPU, GPU) */
+	KUNIT_EXPECT_EQ(test, bus->peak_bw, 2000);
+
+	icc_test_destroy_path(test, path_cpu);
+	icc_test_destroy_path(test, path_gpu);
+}
+
+static void icc_test_bulk_ops(struct kunit *test)
+{
+	struct icc_test_priv *priv = test->priv;
+	struct icc_node *nodes_cpu[3], *nodes_gpu[2];
+	struct icc_bulk_data bulk[2];
+	int ret;
+
+	nodes_cpu[0] = get_node(priv, NODE_CPU);
+	nodes_cpu[1] = get_node(priv, NODE_BUS);
+	nodes_cpu[2] = get_node(priv, NODE_DDR);
+
+	nodes_gpu[0] = get_node(priv, NODE_GPU);
+	nodes_gpu[1] = get_node(priv, NODE_BUS);
+
+	bulk[0].path = icc_test_create_path(test, nodes_cpu, 3);
+	bulk[0].avg_bw = 500;
+	bulk[0].peak_bw = 500;
+
+	bulk[1].path = icc_test_create_path(test, nodes_gpu, 2);
+	bulk[1].avg_bw = 600;
+	bulk[1].peak_bw = 600;
+
+	ret = icc_bulk_set_bw(2, bulk);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	/* Paths disabled, bandwidth should be 0 */
+	KUNIT_EXPECT_EQ(test, get_node(priv, NODE_BUS)->avg_bw, 0);
+
+	ret = icc_bulk_enable(2, bulk);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	/* Paths enabled, aggregation applies */
+	KUNIT_EXPECT_EQ(test, get_node(priv, NODE_BUS)->avg_bw, 1100);
+
+	icc_bulk_disable(2, bulk);
+	KUNIT_EXPECT_EQ(test, get_node(priv, NODE_BUS)->avg_bw, 0);
+
+	icc_test_destroy_path(test, bulk[0].path);
+	icc_test_destroy_path(test, bulk[1].path);
+}
+
+static struct kunit_case icc_test_cases[] = {
+	KUNIT_CASE(icc_test_topology_integrity),
+	KUNIT_CASE(icc_test_set_bw),
+	KUNIT_CASE(icc_test_aggregation),
+	KUNIT_CASE(icc_test_bulk_ops),
+	{}
+};
+
+static struct kunit_suite icc_test_suite = {
+	.name = "interconnect",
+	.init = icc_test_init,
+	.exit = icc_test_exit,
+	.test_cases = icc_test_cases,
+};
+
+kunit_test_suite(icc_test_suite);
+
+MODULE_AUTHOR("Kuan-Wei Chiu <visitorckw@gmail.com>");
+MODULE_DESCRIPTION("KUnit tests for the Interconnect framework");
+MODULE_LICENSE("GPL");
-- 
2.52.0.457.g6b5491de43-goog


