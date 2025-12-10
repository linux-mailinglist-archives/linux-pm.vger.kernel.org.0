Return-Path: <linux-pm+bounces-39419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4CBCB3B59
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 19:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E1B3088A02
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB063246FD;
	Wed, 10 Dec 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApwgGde5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BA275AE3
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389680; cv=none; b=Lh78OaR3vqqyAB+XXUQf0bWFzum0HP+n89Jb+lGNK4sR612UjRNY36aOakNvvj8TtWpY7UML9jj79ISbNl6vG7YffWSskL75PYQ44Ts2faz7dRFtKnSUjbGtMveYpc2khPKlDWL9IHSk8X3KDyihOGHKV3J/TDrtbn0AO0pmqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389680; c=relaxed/simple;
	bh=0CRpciQkOV9hX55q69tWXDzJdDSlmqGFwfhnOcfQyFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lInfvb4juf+Rk1IMCkvscJakS0/UoD6LkqG+7s0nyR4TYReKS1LsCdCHEFaA7MEiXVD2uNin+FQWHLUV3FDX7l3ZD9rmc+bbck9MFMaF9Tskwg2WwY7BiiI2fRgIrxdSuoLSxyAdXB5buc/0Eg7zDWkxihupfk6GAm8AsQ/8tXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApwgGde5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ade456b6abso39907b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 10:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765389678; x=1765994478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OYRHQWa3xiEJx4SHKHAZrrHc9alAZAUbl4tlBhztlY=;
        b=ApwgGde5ga24gCyRBCRtuK3va2FF1ShLw5/1qUZf7U4F/rgyCj3lmGTMNqyNn5yMiw
         f8f0Npmh9U7jSmAmcPyZ5HSObDQ9H5gIzQz1aOmoQCdKWXbb8xJd2k+b7+um+19raHEF
         LUn50RLKXOTWq9tNs/2+geU4lYJop4rgXsQ0sHA/2gN23ZEy91Ox1aN/77Nnpict1E1r
         nshZ0SP30iZace3kxoo0sRwDtxdxlThs/Minx4YToO8lieq81OqAgDe+xOfMFWEKH/nm
         wnV09pFKN/h1gGGiCI0+HZwyaythO+rmwVcR5TKmfcoSYOMv0AIKOgWkRDmWS+EzJPpY
         XAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765389678; x=1765994478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OYRHQWa3xiEJx4SHKHAZrrHc9alAZAUbl4tlBhztlY=;
        b=gWG3RCa/zaRDQHPS88gCi/nnHfhiFtkuej14/kev4TGXICoFn/U1V5tkKPTKV/LgRA
         pVzOANlPQcUIXcKyqGmVxMIptPhkvDo1lP9+2UBnRRnDbtMDu4RhC1F4S46xkFUt12I0
         XGkq/zWUXki92jc6XQb0DFlsvRJ9oWA927KptHw6qAJ+Led8fdC+m1gC4POtxkxWn79w
         P84V0troS/uo4QjYDfyo3HbOK9J1kStheDbhyEHqvJEE2agGDiJc/3QuA2R4GLmhAurN
         riVWLiG8e/E7EwDD81ebDRLqGSv6qzo7qoAVDt7omneKytF8rGS076YlZDSX4AayYNEn
         WZbw==
X-Forwarded-Encrypted: i=1; AJvYcCXXeTnbdORgp5lwMCp2HJgAzvSmm6m8UycZjjNIjcvu1X4QZpVhFJxP0hLnQCtmpK26+7/3avnViQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IxGUIL1AiCXG14WWkMOd/AqtvsJ5dc9YhUpJO4F4VnTrSYFo
	skvBjPSNAnr+ef8+gixG4m+3GpbqN0iQoo7H0iRcOtnl5FyAoBmwbjVl
X-Gm-Gg: AY/fxX7HVbZPLpYzyt5037TMF0va67naVXdZ6B+X1D5MG6xEUtoXu1aJ9ja3rSTHYxz
	lsIw0VRWYUKySbWEatL26AmvDdNIcaPmEMJTCkUoPkdKYkFzHMHFGLaf91Xun5g7ewj8bD5Jkr6
	QMrN7/IgrCE5nhEmFGCXmkgoDD6k9D6XaVuVJiHbjNxmNh2PZRdx2MAjIrBsw7hvWBGH96F7yzx
	iTgiCk1k98QJxPeEvDrDfSlXHGhrf2IQHCqX7HpDdzS06xh10UuswylWiqejwL2XtUnaeQXwhDJ
	Gy/0ew14n6RXtiFUIH8Xkj6bddSz9CQwlxgNckaXFrls5FMzLRNzNT9oJ1Vkn9pp3RdlQhRTB3u
	BTkcuLskC+XPNM/oBWMwyuPkqP4DfbPB5Cvg7OK1JHoCnJBwXKZPVftHGJYOyHVbc7emqaVo/f+
	DbFxwsYn5u777RiW6T0JeBoEOlBcMwfmsdcnV25I3utWDLanE1oSX/DPfByz2ghUUavsv9bRrQ4
	0S6KUr6iHQVpOGqLixi5pPB
X-Google-Smtp-Source: AGHT+IFaGfQ/nIyAlOjpZun6rhBG69hgbULLUO2of3xW8vx4vmAcuobEfmn/Tz8RxqBpffLbTkS0Xw==
X-Received: by 2002:a05:6a00:4f85:b0:7e8:4471:8cd with SMTP id d2e1a72fcca58-7f22ee57122mr2528975b3a.46.1765389676997;
        Wed, 10 Dec 2025 10:01:16 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (14.250.194.35.bc.googleusercontent.com. [35.194.250.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c585cde0sm159391b3a.69.2025.12.10.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 10:01:16 -0800 (PST)
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
Subject: [PATCH] interconnect: Add kunit tests for core functionality
Date: Wed, 10 Dec 2025 18:00:58 +0000
Message-ID: <20251210180058.2115010-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
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
Build and kunit tests passed

 drivers/interconnect/Kconfig     |  14 ++
 drivers/interconnect/Makefile    |   2 +
 drivers/interconnect/icc-kunit.c | 315 +++++++++++++++++++++++++++++++
 3 files changed, 331 insertions(+)
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
index 000000000000..2178487f9527
--- /dev/null
+++ b/drivers/interconnect/icc-kunit.c
@@ -0,0 +1,315 @@
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
+	NODE_CPU = 100,
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
2.52.0.223.gf5cc29aaa4-goog


