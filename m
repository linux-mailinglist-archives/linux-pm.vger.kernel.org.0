Return-Path: <linux-pm+bounces-40603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C04D0DB0B
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 20:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0655D3008CA6
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C82494FF;
	Sat, 10 Jan 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJfd+7S2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC756288C0A
	for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768072358; cv=none; b=tzbSawdzKVqt3FKzlUTQrBVfymqaZ0njQ9WtfEEaqrx90olDcOp/qu4WFZURSnfC7998vAQqcLh+M8OYXwXPZGJZSSEjfUqCHD9TM2sSki820fXuJaeWINWBk+6G0wL5bBVM4qTxpxiTzLUWNaYxOPzM85yVMasNBcNELTUusD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768072358; c=relaxed/simple;
	bh=6hsgPQMDhASeJ+fOgWGYiTzJn6pw7Tq/wZDyJJgthV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2ilE2CLE+2y9ppb3cfsb+iZUnuPIwDk06Fvt9k6WpXXXUEiH8RdMVzOAXMo7ibtzSHSi0ketJYqdYUfjCEORFwbMqzeRSjl9KzmKAJPwEuk3Lc6fKeGYUBpQ/+uGlNNKCp9XS+Q4UQ/nB8M0y1kkR64BUDHqhL2txzPbW2MTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJfd+7S2; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3f0cbfae787so3895840fac.3
        for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 11:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768072356; x=1768677156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdkXa9/L4wvq4IHLS3coifR72fpkOP/zf+UrPdheL+o=;
        b=jJfd+7S2E1heManhm7vSO1UyefIvAV+evJSJBDVnILdbQVQD7oPC8+wew9JcZgJgwx
         K8Ixdag5yfeZ9ejLmZH44wnsXU95UtGENXH8WOnXvHZH2x7/WX16+YbmqUyJiuB9d4CY
         ffmBwdpbP2nvrMaTUPlVvFJLfIg2rlDgWnZSaaqBbMeue9srYv2H/b6s1J4obOD/3NFM
         2OskEw6jshHnURJDqYgN/uTIA6egyL3t4ML99QSQFBH1SSczc4ap4x2sWA6WEhviXPZF
         wb4kQqe2grXCBlnWTV/LbtI7noAMkzqsxfOVEnkNakn0CCtqPFsN4xUCdEMsXO1oPHZ7
         dJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768072356; x=1768677156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdkXa9/L4wvq4IHLS3coifR72fpkOP/zf+UrPdheL+o=;
        b=biO9oBAZm7MBQHSBjw2lXuqLVekUkf8ddaWiQ/6090L7h0EAfFzsLoF0mpSrTtV/Xr
         qgZLzBpFFIrCZkwbU/JeGIzgdL1tL37rkdsavnMrCYts18MA3pr7smsRE5T8IlXhZWxL
         EfZD86E0rnML7Yg1xOrl4ljJ9CTqSNbCvlyO25fAluRL47MEMcIXg+DPcsYzKHr87S36
         Ievw4AaNw3MQMuoK3PwW14ahv1vhfYWyO7oEzo1Np8ZHDty2Ri+dmvTZ4CbfIexLPU9E
         UwlqjsmuMK4Ednl3l2LwFtYTeuL5AY+4475jjltSORsnilaQy+MG7RuFilfljt/waG5M
         PEPw==
X-Forwarded-Encrypted: i=1; AJvYcCVSoxG4j+yNPNalSaaeWCiBZiKTNDxL5eaYfr8iYH2O7m+TMPTb/OYUZxJs1Ovb1DEjR7CmvAmWVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyun7SnmvHYs28Ka+9RnEJGI6XNq47poKjC5WOX6WIlIUWtaZg8
	0CYvkCw1+PwdVb2PWH6N+asGpAX/RCzfx/BG/V2bpC9jKVfU9dESiyYAxyv8KQ==
X-Gm-Gg: AY/fxX4++QdeFT/zvkNzUEFOp4JqUT7Bjs8Yut2TxXiPecxRyl+E8nFfnXRcP27Gr6n
	JgJJsdRQrfsy3QICnJke1kMDyRdViEX+m1wo9wIZgoBgCiN1eezvEZvUSTSSx0QcmNYxvYcIE4A
	0F6FwHm/YWSQSOcYzyRnJAEp1c9EBOXCkdhgZCeYjXkhrhDmGgXzn8F75HMYvU4yMZ1HdWATGv+
	IWVi5jW4HM688OfYuNsqfn3/C3vtm+7twH5QERRi+sqvVOyRorOPsoUYRTXMKL5u9MsW4pJzpxw
	MfkDQsPXCLbczv1+cQJFpZUXXht6J989IOZQXO6ampjc/XWUEUzMqyq8S6ioQXMipx8k20cR7D9
	QR7p++1MrwIlQTJUoXmdl+3qeTUZL8iOW9I89QBIllGd2eRz62IPka6/70+Pg3e5Ey+h/Pujsrl
	ojLrNWg0d2oSh+HkYYaG6kEk8vRitKvqLsYaNwyMx46jzJdU5VbV5jHpsVWOIrfPWcxsIn
X-Google-Smtp-Source: AGHT+IHvh3vBxNr6ei7GlykxFLjWFURTvhvRl6IQsovogNCI455jmZsQDHLqMmWUa4ZR3buYcpiN7Q==
X-Received: by 2002:a17:903:2341:b0:2a1:10f6:3c1 with SMTP id d9443c01a7336-2a3ee46f97cmr116800655ad.26.1768066346072;
        Sat, 10 Jan 2026 09:32:26 -0800 (PST)
Received: from google.com (61-230-24-179.dynamic-ip.hinet.net. [61.230.24.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c491e7sm134544265ad.38.2026.01.10.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 09:32:25 -0800 (PST)
Date: Sun, 11 Jan 2026 01:32:22 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: jserv@ccns.ncku.edu.tw, marscheng@google.com, wllee@google.com,
	aarontian@google.com, hsuanting@google.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] interconnect: Add kunit tests for core functionality
Message-ID: <aWKNJprcgJkMv5qk@google.com>
References: <20251210180058.2115010-1-visitorckw@gmail.com>
 <ab1375ae-ee33-4eb4-a54a-f52a67289155@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1375ae-ee33-4eb4-a54a-f52a67289155@kernel.org>

Hi Georgi,

Thanks for the review!

On Sat, Jan 10, 2026 at 01:09:03AM +0200, Georgi Djakov wrote:
> On 12/10/25 8:00 PM, Kuan-Wei Chiu wrote:
> > The interconnect framework currently lacks in-tree unit tests to verify
> > the core logic in isolation. This makes it difficult to validate
> > regression stability when modifying the provider/consumer APIs or
> > aggregation logic.
> > 
> > Introduce a kunit test suite that verifies the fundamental behavior of
> > the subsystem. The tests cover:
> > - Provider API (node creation, linking, topology construction).
> > - Consumer API (path enabling/disabling, bandwidth requests).
> > - Standard aggregation logic (accumulating bandwidth across links).
> > - Bulk operations for setting bandwidth on multiple paths.
> > 
> > The suite simulates a simple SoC topology with multiple masters and a
> > shared bus to validate traffic aggregation behavior in a controlled
> > software environment, without requiring specific hardware or Device
> > Tree support.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Build and kunit tests passed
> > 
> >   drivers/interconnect/Kconfig     |  14 ++
> >   drivers/interconnect/Makefile    |   2 +
> >   drivers/interconnect/icc-kunit.c | 315 +++++++++++++++++++++++++++++++
> >   3 files changed, 331 insertions(+)
> >   create mode 100644 drivers/interconnect/icc-kunit.c
> > 
> > diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> > index f2e49bd97d31..882dcb0b4a5b 100644
> > --- a/drivers/interconnect/Kconfig
> > +++ b/drivers/interconnect/Kconfig
> > @@ -22,4 +22,18 @@ config INTERCONNECT_CLK
> >   	help
> >   	  Support for wrapping clocks into the interconnect nodes.
> > +config INTERCONNECT_KUNIT_TEST
> > +	tristate "KUnit tests for Interconnect framework"
> > +	depends on KUNIT
> > +	default KUNIT_ALL_TESTS
> > +	help
> > +	  This builds the KUnit test suite for the generic system interconnect
> > +	  framework.
> > +
> > +	  The tests cover the core functionality of the interconnect subsystem,
> > +	  including provider/consumer APIs, topology management, and bandwidth
> > +	  aggregation logic.
> > +
> > +	  If unsure, say N.
> > +
> >   endif
> > diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> > index b0a9a6753b9d..dc4c7b657c9d 100644
> > --- a/drivers/interconnect/Makefile
> > +++ b/drivers/interconnect/Makefile
> > @@ -10,3 +10,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> >   obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
> >   obj-$(CONFIG_INTERCONNECT_CLK)		+= icc-clk.o
> > +
> > +obj-$(CONFIG_INTERCONNECT_KUNIT_TEST) += icc-kunit.o
> > diff --git a/drivers/interconnect/icc-kunit.c b/drivers/interconnect/icc-kunit.c
> > new file mode 100644
> > index 000000000000..2178487f9527
> > --- /dev/null
> > +++ b/drivers/interconnect/icc-kunit.c
> > @@ -0,0 +1,315 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit tests for the Interconnect framework.
> > + *
> > + * Copyright (c) 2025 Kuan-Wei Chiu <visitorckw@gmail.com>
> > + *
> > + * This suite verifies the behavior of the interconnect core, including
> > + * topology construction, bandwidth aggregation, and path lifecycle.
> > + */
> > +
> > +#include <kunit/platform_device.h>
> > +#include <kunit/test.h>
> > +#include <linux/interconnect-provider.h>
> > +#include <linux/interconnect.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/overflow.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include "internal.h"
> > +
> > +enum {
> > +	NODE_CPU = 100,
> > +	NODE_GPU,
> > +	NODE_BUS,
> > +	NODE_DDR,
> > +	NODE_MAX
> > +};
> > +
> > +struct test_node_data {
> > +	int id;
> > +	const char *name;
> > +	int num_links;
> > +	int links[2];
> > +};
> > +
> > +/*
> > + * Static Topology:
> > + * CPU -\
> > + * -> BUS -> DDR
> > + * GPU -/
> > + */
> > +static const struct test_node_data test_topology[] = {
> > +	{ NODE_CPU, "cpu", 1, { NODE_BUS } },
> > +	{ NODE_GPU, "gpu", 1, { NODE_BUS } },
> > +	{ NODE_BUS, "bus", 1, { NODE_DDR } },
> > +	{ NODE_DDR, "ddr", 0, { } },
> > +};
> > +
> > +struct icc_test_priv {
> > +	struct icc_provider provider;
> > +	struct platform_device *pdev;
> > +	struct icc_node *nodes[NODE_MAX];
> 
> So nodes[] is a 104-element array? Is this intentional?

That was indeed an oversight.
In v2, I will simplify the test by making the node id 0 based.

> 
> [..]
> > +static void icc_test_set_bw(struct kunit *test)
> > +{
> > +	struct icc_test_priv *priv = test->priv;
> > +	struct icc_path *path;
> > +	struct icc_node *path_nodes[3];
> > +	int ret;
> > +
> > +	/* Path: CPU -> BUS -> DDR */
> > +	path_nodes[0] = get_node(priv, NODE_CPU);
> > +	path_nodes[1] = get_node(priv, NODE_BUS);
> > +	path_nodes[2] = get_node(priv, NODE_DDR);
> > +
> > +	path = icc_test_create_path(test, path_nodes, 3);
> > +
> > +	ret = icc_enable(path);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +	ret = icc_set_bw(path, 1000, 2000);
> > +	KUNIT_EXPECT_EQ(test, ret, 0);
> > +
> > +	KUNIT_EXPECT_EQ(test, path_nodes[0]->avg_bw, 1000);
> > +	KUNIT_EXPECT_EQ(test, path_nodes[0]->peak_bw, 2000);
> > +	KUNIT_EXPECT_EQ(test, path_nodes[1]->avg_bw, 1000);
> > +	KUNIT_EXPECT_EQ(test, path_nodes[1]->peak_bw, 2000);
> > +
> > +	icc_set_tag(path, 0xABC);
> > +	KUNIT_EXPECT_EQ(test, path->reqs[0].tag, 0xABC);
> > +
> > +	icc_disable(path);
> > +	KUNIT_EXPECT_EQ(test, path_nodes[0]->avg_bw, 0);
> > +
> > +	icc_test_destroy_path(test, path);
> > +}
> > +
> 
> I also tried to run it and noticed that one of the tests is failing on my board...
> 
> KTAP version 1
> 1..1
>     KTAP version 1
>     # Subtest: interconnect
>     1..4
>     ok 1 icc_test_topology_integrity
>     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:207
>     Expected path_nodes[0]->avg_bw == 1000, but
>         path_nodes[0]->avg_bw == 2147483647 (0x7fffffff)
>     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:208
>     Expected path_nodes[0]->peak_bw == 2000, but
>         path_nodes[0]->peak_bw == 2147483647 (0x7fffffff)
>     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:209
>     Expected path_nodes[1]->avg_bw == 1000, but
>         path_nodes[1]->avg_bw == 2147483647 (0x7fffffff)
>     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:210
>     Expected path_nodes[1]->peak_bw == 2000, but
>         path_nodes[1]->peak_bw == 2147483647 (0x7fffffff)
>     # icc_test_set_bw: EXPECTATION FAILED at drivers/interconnect/icc-kunit.c:216
>     Expected path_nodes[0]->avg_bw == 0, but
>         path_nodes[0]->avg_bw == 2147483647 (0x7fffffff)
>     not ok 2 icc_test_set_bw
>     ok 3 icc_test_aggregation
>     ok 4 icc_test_bulk_ops
>     # module: icc_kunit
> # interconnect: pass:3 fail:1 skip:0 total:4
> # Totals: pass:3 fail:1 skip:0 total:4
> not ok 1 interconnect
> 
> ...and the following diff seem to fix it:
> 
> diff --git a/drivers/interconnect/icc-kunit.c b/drivers/interconnect/icc-kunit.c
> index 2178487f9527..060f640818a5 100644
> --- a/drivers/interconnect/icc-kunit.c
> +++ b/drivers/interconnect/icc-kunit.c
> @@ -79,6 +79,14 @@ static struct icc_node *icc_test_xlate(const struct of_phandle_args *spec, void
>  	return NULL;
>  }
> 
> +static int icc_test_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg = 0;
> +	*peak = 0;
> +
> +	return 0;
> +}
> +
>  static int icc_test_init(struct kunit *test)
>  {
>  	struct icc_test_priv *priv;
> @@ -95,6 +103,7 @@ static int icc_test_init(struct kunit *test)
> 
>  	priv->provider.set = icc_test_set;
>  	priv->provider.aggregate = icc_test_aggregate;
> +	priv->provider.get_bw = icc_test_get_bw;
>  	priv->provider.xlate = icc_test_xlate;
>  	priv->provider.dev = &priv->pdev->dev;
>  	priv->provider.data = priv;
> 
> 
> Could you please update and re-send?

Thanks for pointing this out.
I will include this callback in v2.

Will send the v2 patch shortly.

Regards,
Kuan-Wei


