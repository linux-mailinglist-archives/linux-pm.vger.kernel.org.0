Return-Path: <linux-pm+bounces-40578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F2D0C81D
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 00:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72DAD300D439
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C6337B87;
	Fri,  9 Jan 2026 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDO/tcqd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB02330B00;
	Fri,  9 Jan 2026 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768000150; cv=none; b=WPgYn2V65RS7qjO/yxuqgKGqH5ySJPBUvJm2Z5XhgnTj9cXdOSW/Z5CCnFpE83nbW2146fHDJyEaLeuT9W/vpmPEK7CHws9YEyLA3V3xT+LIUnGPLxOs2kd7pA0ZNNvXbSmuwjWbSv6dVL8zx7ayM9vlqEL6K4QgWR3djDmQEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768000150; c=relaxed/simple;
	bh=joLEiJVFYHE4rOJ1s08l87AadqTWMGifTl6PZ/cU+Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEQtsqc4pfLUAwjBodYqLmR2Om3yL+sJL4WoTGdRCaSFiNN+peIo1HDYortPRTcACVZJkxQNtqOHNiKD75S30Wy/Schl0nxyfkYjuyGnioUmC3Z8RRoU2S5eWMieK0rN9hp35cDm5XLM/rrJRtVKL5JgBH2pBGrn8SJhFfbO3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDO/tcqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED7FC4CEF1;
	Fri,  9 Jan 2026 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768000150;
	bh=joLEiJVFYHE4rOJ1s08l87AadqTWMGifTl6PZ/cU+Rw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lDO/tcqdvKnzTEpFsE7Wonp2IVZ/6u/uqMXBFQ0Lha/46uPftFxTT3jJAHYIa8B0B
	 /6mAZDgoBRAUvAFffJf+sCepyeOFXab3QYQGP67Tqyocc0XD4kI9qpzrblUSCA0X0V
	 FNHaUrF/95fYYlNmwETem5wHQO0IK9imR0caMvLaxBQjDzzVNDu4tOrZpj1uxQqyFH
	 8XaTD/ntaOxmOHoJPQNkFNy0jK4raf/Uxh+8tDbqYR2HucyCA3G2PFKI7pzTvA5jpq
	 BLFQcH5jyxvwxQny7gKGdWmuPLakL1Oqpc7mDz8Qsi3JX3GnlUNST2sB8kKhmiejLn
	 XEKAFHtpR+WIw==
Message-ID: <ab1375ae-ee33-4eb4-a54a-f52a67289155@kernel.org>
Date: Sat, 10 Jan 2026 01:09:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: Add kunit tests for core functionality
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jserv@ccns.ncku.edu.tw, marscheng@google.com, wllee@google.com,
 aarontian@google.com, hsuanting@google.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251210180058.2115010-1-visitorckw@gmail.com>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <20251210180058.2115010-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/25 8:00 PM, Kuan-Wei Chiu wrote:
> The interconnect framework currently lacks in-tree unit tests to verify
> the core logic in isolation. This makes it difficult to validate
> regression stability when modifying the provider/consumer APIs or
> aggregation logic.
> 
> Introduce a kunit test suite that verifies the fundamental behavior of
> the subsystem. The tests cover:
> - Provider API (node creation, linking, topology construction).
> - Consumer API (path enabling/disabling, bandwidth requests).
> - Standard aggregation logic (accumulating bandwidth across links).
> - Bulk operations for setting bandwidth on multiple paths.
> 
> The suite simulates a simple SoC topology with multiple masters and a
> shared bus to validate traffic aggregation behavior in a controlled
> software environment, without requiring specific hardware or Device
> Tree support.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Build and kunit tests passed
> 
>   drivers/interconnect/Kconfig     |  14 ++
>   drivers/interconnect/Makefile    |   2 +
>   drivers/interconnect/icc-kunit.c | 315 +++++++++++++++++++++++++++++++
>   3 files changed, 331 insertions(+)
>   create mode 100644 drivers/interconnect/icc-kunit.c
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index f2e49bd97d31..882dcb0b4a5b 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -22,4 +22,18 @@ config INTERCONNECT_CLK
>   	help
>   	  Support for wrapping clocks into the interconnect nodes.
>   
> +config INTERCONNECT_KUNIT_TEST
> +	tristate "KUnit tests for Interconnect framework"
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the KUnit test suite for the generic system interconnect
> +	  framework.
> +
> +	  The tests cover the core functionality of the interconnect subsystem,
> +	  including provider/consumer APIs, topology management, and bandwidth
> +	  aggregation logic.
> +
> +	  If unsure, say N.
> +
>   endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index b0a9a6753b9d..dc4c7b657c9d 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -10,3 +10,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
>   obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
>   
>   obj-$(CONFIG_INTERCONNECT_CLK)		+= icc-clk.o
> +
> +obj-$(CONFIG_INTERCONNECT_KUNIT_TEST) += icc-kunit.o
> diff --git a/drivers/interconnect/icc-kunit.c b/drivers/interconnect/icc-kunit.c
> new file mode 100644
> index 000000000000..2178487f9527
> --- /dev/null
> +++ b/drivers/interconnect/icc-kunit.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for the Interconnect framework.
> + *
> + * Copyright (c) 2025 Kuan-Wei Chiu <visitorckw@gmail.com>
> + *
> + * This suite verifies the behavior of the interconnect core, including
> + * topology construction, bandwidth aggregation, and path lifecycle.
> + */
> +
> +#include <kunit/platform_device.h>
> +#include <kunit/test.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/interconnect.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "internal.h"
> +
> +enum {
> +	NODE_CPU = 100,
> +	NODE_GPU,
> +	NODE_BUS,
> +	NODE_DDR,
> +	NODE_MAX
> +};
> +
> +struct test_node_data {
> +	int id;
> +	const char *name;
> +	int num_links;
> +	int links[2];
> +};
> +
> +/*
> + * Static Topology:
> + * CPU -\
> + * -> BUS -> DDR
> + * GPU -/
> + */
> +static const struct test_node_data test_topology[] = {
> +	{ NODE_CPU, "cpu", 1, { NODE_BUS } },
> +	{ NODE_GPU, "gpu", 1, { NODE_BUS } },
> +	{ NODE_BUS, "bus", 1, { NODE_DDR } },
> +	{ NODE_DDR, "ddr", 0, { } },
> +};
> +
> +struct icc_test_priv {
> +	struct icc_provider provider;
> +	struct platform_device *pdev;
> +	struct icc_node *nodes[NODE_MAX];

So nodes[] is a 104-element array? Is this intentional?

[..]
> +static void icc_test_set_bw(struct kunit *test)
> +{
> +	struct icc_test_priv *priv = test->priv;
> +	struct icc_path *path;
> +	struct icc_node *path_nodes[3];
> +	int ret;
> +
> +	/* Path: CPU -> BUS -> DDR */
> +	path_nodes[0] = get_node(priv, NODE_CPU);
> +	path_nodes[1] = get_node(priv, NODE_BUS);
> +	path_nodes[2] = get_node(priv, NODE_DDR);
> +
> +	path = icc_test_create_path(test, path_nodes, 3);
> +
> +	ret = icc_enable(path);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = icc_set_bw(path, 1000, 2000);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_EQ(test, path_nodes[0]->avg_bw, 1000);
> +	KUNIT_EXPECT_EQ(test, path_nodes[0]->peak_bw, 2000);
> +	KUNIT_EXPECT_EQ(test, path_nodes[1]->avg_bw, 1000);
> +	KUNIT_EXPECT_EQ(test, path_nodes[1]->peak_bw, 2000);
> +
> +	icc_set_tag(path, 0xABC);
> +	KUNIT_EXPECT_EQ(test, path->reqs[0].tag, 0xABC);
> +
> +	icc_disable(path);
> +	KUNIT_EXPECT_EQ(test, path_nodes[0]->avg_bw, 0);
> +
> +	icc_test_destroy_path(test, path);
> +}
> +

I also tried to run it and noticed that one of the tests is failing on my board...

KTAP version 1
1..1
     KTAP version 1
     # Subtest: interconnect
     1..4
     ok 1 icc_test_topology_integrity
     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:207
     Expected path_nodes[0]->avg_bw == 1000, but
         path_nodes[0]->avg_bw == 2147483647 (0x7fffffff)
     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:208
     Expected path_nodes[0]->peak_bw == 2000, but
         path_nodes[0]->peak_bw == 2147483647 (0x7fffffff)
     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:209
     Expected path_nodes[1]->avg_bw == 1000, but
         path_nodes[1]->avg_bw == 2147483647 (0x7fffffff)
     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:210
     Expected path_nodes[1]->peak_bw == 2000, but
         path_nodes[1]->peak_bw == 2147483647 (0x7fffffff)
     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:216
     Expected path_nodes[0]->avg_bw == 0, but
         path_nodes[0]->avg_bw == 2147483647 (0x7fffffff)
     not ok 2 icc_test_set_bw
     ok 3 icc_test_aggregation
     ok 4 icc_test_bulk_ops
     # module: icc_kunit
# interconnect: pass:3 fail:1 skip:0 total:4
# Totals: pass:3 fail:1 skip:0 total:4
not ok 1 interconnect

...and the following diff seem to fix it:

diff --git a/drivers/interconnect/icc-kunit.c b/drivers/interconnect/icc-kunit.c
index 2178487f9527..060f640818a5 100644
--- a/drivers/interconnect/icc-kunit.c
+++ b/drivers/interconnect/icc-kunit.c
@@ -79,6 +79,14 @@ static struct icc_node *icc_test_xlate(const struct of_phandle_args *spec, void
  	return NULL;
  }

+static int icc_test_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
  static int icc_test_init(struct kunit *test)
  {
  	struct icc_test_priv *priv;
@@ -95,6 +103,7 @@ static int icc_test_init(struct kunit *test)

  	priv->provider.set = icc_test_set;
  	priv->provider.aggregate = icc_test_aggregate;
+	priv->provider.get_bw = icc_test_get_bw;
  	priv->provider.xlate = icc_test_xlate;
  	priv->provider.dev = &priv->pdev->dev;
  	priv->provider.data = priv;


Could you please update and re-send?

Thanks,
Georgi

