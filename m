Return-Path: <linux-pm+bounces-20761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD5A17AAA
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11FD1881BCC
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71AE1E32C5;
	Tue, 21 Jan 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUz1L+LA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636D1DF98A;
	Tue, 21 Jan 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453412; cv=none; b=PE3+cnrHk0nG6BZkUGKU2U+E+5ax+XJugW24hBacsemRBrGHC2fCkJLVFLLE+5UcSguqiVYm+aLS/siyvOpv2b/2VXfvQ3ZKI+0/AIlrRJG22z4a9dwG5dTFg6jka9j5ZM1Nvb6VaJO10knulLETuqiO8m8YNgagYW9OL6WzPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453412; c=relaxed/simple;
	bh=VFdMeQyLiwbCJVSAb/gaw/U6kH1rz5Fyafx/lk564JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4NLXeyDP8heACKjTbmckH2fuhz23Hc/SGTMuDw/1vvIOikafhNeidAZkpENobvjn3zQhdMBLAD4ZN9Meop4v/yZEHFTRs3jKdMuCgtQuDgIbxQqpossXZeY1ZjXOL4SIq97rumUlsuQJNCurUT/uFaaOc99taXjlP0ORtCQILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUz1L+LA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5452DC4CEDF;
	Tue, 21 Jan 2025 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737453412;
	bh=VFdMeQyLiwbCJVSAb/gaw/U6kH1rz5Fyafx/lk564JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUz1L+LAd2OkWGtzafKYQmfHp9h/uEZefN6dLcYGcI5NgQF+bMkgQ+sqlG7WJFyHH
	 GDBIh+AB5eZ9Yr9+U2/fKQ+UN1WJ3WTHEEnv01mh0kt6u6Su8D8UTxjpmJcbB3eTQu
	 SgQ4alLUkB5BlgY+hMnDqx0HTx4eNziQkG5OjYt6bjGkJkXjxpEIcN36dkY125KhE8
	 eNAch6MWVYLUcIuI/eHvb3ypArgFQ2VU7CQSeDJruORrYuSfqsjOgCQVAJRfD1Exyf
	 9tKiI9gkSl6M5wrI/CyyyRqU1FH86SXaiYi6AXq8NWfRgz6Ow9L3eQ9QWqAHUcOZzD
	 b42DL2uIFNSZQ==
Date: Tue, 21 Jan 2025 10:56:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org, 
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [RFC v3 04/18] firmware: thead: Add AON firmware protocol driver
Message-ID: <20250121-small-ruby-seahorse-7475d0@krzk-bin>
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
 <CGME20250120172124eucas1p233b3f6da39e7064db62b02a66bc1ac29@eucas1p2.samsung.com>
 <20250120172111.3492708-5-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120172111.3492708-5-m.wilczynski@samsung.com>

On Mon, Jan 20, 2025 at 06:20:57PM +0100, Michal Wilczynski wrote:
> +#include <linux/firmware/thead/thead,th1520-aon.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/firmware/thead,th1520-aon.h>

How/where do you use this header?

> +
> +#define MAX_RX_TIMEOUT (msecs_to_jiffies(3000))
> +#define MAX_TX_TIMEOUT 500
> +
> +struct th1520_aon_chan {
> +	struct platform_device *pd;
> +	struct mbox_chan *ch;
> +	struct th1520_aon_rpc_ack_common ack_msg;
> +	struct mbox_client cl;
> +	struct completion done;
> +
> +	/* make sure only one RPC is perfomed at a time */
> +	struct mutex transaction_lock;
> +};
> +

...

> +static int th1520_aon_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct th1520_aon_chan *aon_chan;
> +	struct mbox_client *cl;
> +	int ret;
> +	struct platform_device_info pdevinfo = {
> +		.name = "th1520-pd",
> +		.id = PLATFORM_DEVID_AUTO,
> +		.parent = dev,
> +	};
> +
> +	aon_chan = devm_kzalloc(dev, sizeof(*aon_chan), GFP_KERNEL);
> +	if (!aon_chan)
> +		return -ENOMEM;
> +
> +	cl = &aon_chan->cl;
> +	cl->dev = dev;
> +	cl->tx_block = true;
> +	cl->tx_tout = MAX_TX_TIMEOUT;
> +	cl->rx_callback = th1520_aon_rx_callback;
> +
> +	aon_chan->ch = mbox_request_channel_byname(cl, "aon");
> +	if (IS_ERR(aon_chan->ch)) {
> +		ret = PTR_ERR(aon_chan->ch);

Drop, pointless. The entire point of using dev_err_probe is to make it
simple.

> +		return dev_err_probe(dev, ret, "Failed to request aon mbox chan\n");
> +	}
> +
> +	mutex_init(&aon_chan->transaction_lock);
> +	init_completion(&aon_chan->done);
> +
> +	platform_set_drvdata(pdev, aon_chan);
> +
> +	aon_chan->pd = platform_device_register_full(&pdevinfo);
> +	ret = PTR_ERR_OR_ZERO(aon_chan->pd);
> +	if (ret) {
> +		dev_err(dev, "Failed to register child device 'th1520-pd': %d\n", ret);
> +		goto free_mbox_chan;
> +	}
> +
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		goto unregister_pd;
> +
> +	return 0;
> +
> +unregister_pd:
> +	platform_device_unregister(aon_chan->pd);
> +free_mbox_chan:
> +	mbox_free_channel(aon_chan->ch);
> +
> +	return ret;
> +}
> +
> +static void th1520_aon_remove(struct platform_device *pdev)
> +{
> +	struct th1520_aon_chan *aon_chan = platform_get_drvdata(pdev);
> +
> +	platform_device_unregister(aon_chan->pd);
> +	mbox_free_channel(aon_chan->ch);
> +}
> +
> +static const struct of_device_id th1520_aon_match[] = {
> +	{ .compatible = "thead,th1520-aon" },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, th1520_aon_match);
> +
> +static struct platform_driver th1520_aon_driver = {
> +	.driver = {
> +		.name = "th1520-aon",
> +		.of_match_table = th1520_aon_match,
> +	},
> +	.probe = th1520_aon_probe,
> +	.remove = th1520_aon_remove,
> +};
> +module_platform_driver(th1520_aon_driver);
> +
> +MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
> +MODULE_DESCRIPTION("T-HEAD TH1520 Always-On firmware driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/firmware/thead/thead,th1520-aon.h b/include/linux/firmware/thead/thead,th1520-aon.h
> new file mode 100644
> index 000000000000..3daa17c01d17
> --- /dev/null
> +++ b/include/linux/firmware/thead/thead,th1520-aon.h
> @@ -0,0 +1,186 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2021 Alibaba Group Holding Limited.
> + */
> +
> +#ifndef _THEAD_AON_H
> +#define _THEAD_AON_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#define AON_RPC_MSG_MAGIC (0xef)
> +#define TH1520_AON_RPC_VERSION 2
> +#define TH1520_AON_RPC_MSG_NUM 7
> +
> +extern struct th1520_aon_chan *aon_chan;

Drop all externs.


Best regards,
Krzysztof


