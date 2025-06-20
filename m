Return-Path: <linux-pm+bounces-29162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D4EAE1BCD
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 15:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C50B177503
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610F28C84B;
	Fri, 20 Jun 2025 13:10:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFAC236442
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425029; cv=none; b=FTAPNSBoh1ZfxPMuXFiRYGNIDcJebidbaZBQvfVXkQnZoesuddKlKv+COpYzKofkjxQS5KtxjlpwJTOyYz6bdJf6Ekbp42iSOKI/b0yfXKiLx5CpVZwich6quKgtIAFStA3G8It7mk+D84RZXP3pHpEK7rU4J4ED2uOs3DcMZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425029; c=relaxed/simple;
	bh=jE9Tjnkryi0urDdqacx0JAJfwZMllit1Msubfg7zZp4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll70QyBwDXNDNTolYyklSDETUlBGSZYqFEx/6uq6pTTX0nuGmzG+E0FJnJOHqEbit65oyE0Le2KHuPZMef+DHfJFYFewZ+uYTJoRsZ6PexRdzxCx42/WQn1HPDftekQeJYwkGCatnrUV1CKvA9KBZ94iE8vOhxWBVf2jGx3Hb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNyQB0GHCz6L6NZ;
	Fri, 20 Jun 2025 21:05:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D72914027A;
	Fri, 20 Jun 2025 21:10:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 15:10:23 +0200
Date: Fri, 20 Jun 2025 14:10:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
CC: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<alireza.sanaee@huawei.com>, <zhenglifeng1@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <liwei728@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [PATCH v5 2/2] PM / devfreq: Add HiSilicon uncore frequency
 scaling driver
Message-ID: <20250620141021.0000694c@huawei.com>
In-Reply-To: <20250619151456.3328624-3-zhanjie9@hisilicon.com>
References: <20250619151456.3328624-1-zhanjie9@hisilicon.com>
	<20250619151456.3328624-3-zhanjie9@hisilicon.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Jun 2025 23:14:56 +0800
Jie Zhan <zhanjie9@hisilicon.com> wrote:

> Add the HiSilicon uncore frequency scaling driver for Kunpeng SoCs based on
> the devfreq framework.  The uncore domain contains shared computing
> resources, including system interconnects and L3 cache.  The uncore
> frequency significantly impacts the system-wide performance as well as
> power consumption.  This driver adds support for runtime management of
> uncore frequency from kernel and userspace.  The main function includes
> setting and getting frequencies, changing frequency scaling policies, and
> querying the list of CPUs whose performance is significantly related to
> this uncore frequency domain, etc.  The driver communicates with a platform
> controller through an ACPI PCC mailbox to take the actual actions of
> frequency scaling.
> 
> Co-developed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>

Hi zhanjie,

A few more things inline that I missed in earlier review.

The devm_mutex one is a definite thing to fix as having it
where it is will make it far to easy to add bugs.

The other stuff is a nice to have.

So with at least the devm_mutex() call moved

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
> new file mode 100644
> index 000000000000..e19678692c16
> --- /dev/null
> +++ b/drivers/devfreq/hisi_uncore_freq.c
> @@ -0,0 +1,664 @@

> +static int hisi_uncore_request_pcc_chan(struct hisi_uncore_freq *uncore)
> +{
> +	struct device *dev = uncore->dev;
> +	struct pcc_mbox_chan *pcc_chan;
> +	int rc;
> +
> +	uncore->cl = (struct mbox_client) {
> +		.dev = dev,
> +		.tx_block = false,
> +		.knows_txdone = true,
> +	};
> +
> +	pcc_chan = pcc_mbox_request_channel(&uncore->cl, uncore->chan_id);

I'm not particularly keen on the repeats of pcc_mbox_free_channel() in each of
the error paths.  Either use a goto and clean it up at the end or
DEFINE_FREE(pcc_mbox_chan, struct pcc_mbox_chan *, if (_T) pcc_mbox_free_channel(_T));

then here
	struct pcc_mbox_chan __free(pcc_mbox_chan) *pcc_chan =
		pcc_mbox_request_channel(&uncore->cl, uncore->chan_id);

remembering to do 
	uncor->chan = no_free_ptr(pcc_chan);
where you currently set it below.

The DEFINE_FREE() might prove useful in other drivers.  kunpeng_hccs
for instance could be simplified with this.  Various other candidates
though not sure how keen on cleanup.h magic those areas of the kernel are.


> +	if (IS_ERR(pcc_chan))
> +		return dev_err_probe(dev, PTR_ERR(pcc_chan),
> +			"Failed to request PCC channel %u\n", uncore->chan_id);
> +
> +	if (!pcc_chan->shmem_base_addr) {
> +		pcc_mbox_free_channel(pcc_chan);
> +		return dev_err_probe(dev, -EINVAL,
> +			"Invalid PCC shared memory address\n");
> +	}
> +
> +	if (pcc_chan->shmem_size < sizeof(struct hisi_uncore_pcc_shmem)) {
> +		pcc_mbox_free_channel(pcc_chan);
> +		return dev_err_probe(dev, -EINVAL,
> +			"Invalid PCC shared memory size (%lluB)\n",
> +			pcc_chan->shmem_size);
> +	}
> +
> +	rc = devm_mutex_init(dev, &uncore->pcc_lock);

This is oddly placed.  Drop this out of this function and do it at least one layer
up.

Having it here leaves the risk of future error cases being added after this
where the devm cleanup will happen out of order as a result.

> +	if (rc) {
> +		pcc_mbox_free_channel(pcc_chan);
> +		return rc;
> +	}
> +
> +	uncore->pchan = pcc_chan;
> +
> +	return 0;
> +}

