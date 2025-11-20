Return-Path: <linux-pm+bounces-38246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB1C71AF7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 02:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B684F34EC92
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 01:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2A9189906;
	Thu, 20 Nov 2025 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="z9mnOXyQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9986347;
	Thu, 20 Nov 2025 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763602255; cv=none; b=bAH9V1clq2fyfanQt3tSu1n9wzVYYdQRUmN4QYBFiv0mH96+NsUL7IOg5RM4pxpoy8bQqggZzh8oP8Bf3PatXPiYzP9TPMY01ow0eAYz0eMMSP/AaW3xYKmGnzF8l8cCb8HK6EjIRNRiD1ewT7cchk1VYqpGaKKMqNN/NhHTD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763602255; c=relaxed/simple;
	bh=Q4qqaOW6Hkr922jvRKsZgVKMSvxgD8Uoyif2SywpI2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RjhZFr0YIsEHDAIIQwHCrNHElBD9UJ+wPus8qWSKRqKDocccp1OhSyIsPSRS6W6HSlC3Eo0Mn2OlySOFeHWFQFFwTSyku7ayUIwhH1/ZvU6onykmwomDbyorh6CusLB9WVSXjOyyyEi31DH5c0xCn3FDM8RQoIwhV/qsTJEGSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=z9mnOXyQ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PxEGPBlTCro2RBYlEyGfwGQEMQtOpb20H7ao9A1I/6A=;
	b=z9mnOXyQ0RjIn+K6LDdPyt+V8drbTMSu4TeGlF5MFua3jcWdJvWkAwV4i4EFWGQKEIl44Je6b
	j5NNpxpOnrrhs1cDus1bthfEhELDCZB1RigKJZGMbiGtLkPaiBX7GkOZzF6rtT5uuVLkdAJTKR8
	ERVJG/IeJrJQ5nqrhO5iH/8=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dBgjt2tP4z1prLT;
	Thu, 20 Nov 2025 09:29:06 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 53255140159;
	Thu, 20 Nov 2025 09:30:51 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 20 Nov
 2025 09:30:50 +0800
Message-ID: <5be41a73-9afc-4c70-b77d-f89630aa83a3@huawei.com>
Date: Thu, 20 Nov 2025 09:30:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM / devfreq: hisi: Fix potential UAF in OPP handling
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20250915062135.748653-1-zhangpengjie2@huawei.com>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20250915062135.748653-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr200004.china.huawei.com (7.202.195.241)


Hi All,

This is a friendly follow-up on this patch.

Given that everyone is often busy with various tasks, I wanted to make
sure it doesn't fall through the cracks.

Thank you for your time and review.

Best regards,
Pengjie Zhang

On 9/15/2025 2:21 PM, Pengjie Zhang wrote:
> Ensure all required data is acquired before calling dev_pm_opp_put(opp)
> to maintain correct resource acquisition and release order.
>
> Fixes: 7da2fdaaa1e6 ("PM / devfreq: Add HiSilicon uncore frequency scaling driver")
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>   drivers/devfreq/hisi_uncore_freq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
> index 96d1815059e3..c1ed70fa0a40 100644
> --- a/drivers/devfreq/hisi_uncore_freq.c
> +++ b/drivers/devfreq/hisi_uncore_freq.c
> @@ -265,10 +265,11 @@ static int hisi_uncore_target(struct device *dev, unsigned long *freq,
>   		dev_err(dev, "Failed to get opp for freq %lu hz\n", *freq);
>   		return PTR_ERR(opp);
>   	}
> -	dev_pm_opp_put(opp);
>   
>   	data = (u32)(dev_pm_opp_get_freq(opp) / HZ_PER_MHZ);
>   
> +	dev_pm_opp_put(opp);
> +
>   	return hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_FREQ, &data);
>   }
>   

