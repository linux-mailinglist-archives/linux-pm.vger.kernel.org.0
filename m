Return-Path: <linux-pm+bounces-15931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B099A386D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0991F29C5A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58018C024;
	Fri, 18 Oct 2024 08:23:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6E1885BE
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239795; cv=none; b=GsPFDNGl5HPO73Bxth/SLOvSycQ5dIR0AyeUqvOA7z+5mTb0Y3W6mlLKbXy2vv+XHkfEi3BrEOfA9Xri0dMvw6NpU6iq6+gsB6u49dBPP3PIDdWZh308497PCJzFjixZXYj4QHgsRRGHJhjSStNZMq1phoNiqVzoXGhIJgLJMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239795; c=relaxed/simple;
	bh=BJFBIUyPSih6cwDKmv85keY65//l/EaiOx1M1Dw2Ay4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=eA91wXrWRYox8Ihf64fwA+G4PybKhm+ZiEpb+GaM/48C0p95hOFUPUaIN34VhatFmEmlCFDoxjqvPLHAUTbXPyHUzVZDXKeoZ48OQCG1aSfRiI80/0K7UWIlf2IiKVe7KDaTalSkEeNmm6r47/wL8bG7NPq5V+bCO9WwS/LWvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 769DAFEC;
	Fri, 18 Oct 2024 01:23:42 -0700 (PDT)
Received: from [10.57.78.54] (unknown [10.57.78.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02DF93F528;
	Fri, 18 Oct 2024 01:23:11 -0700 (PDT)
Message-ID: <c13e95ff-649d-4a43-a899-8f0088f3fc7f@arm.com>
Date: Fri, 18 Oct 2024 09:24:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powercap/dtpm_devfreq: Fix error check against
 dev_pm_qos_add_request()
To: Yuan Can <yuancan@huawei.com>
References: <20241018021205.46460-1-yuancan@huawei.com>
Content-Language: en-US
Cc: daniel.lezcano@kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241018021205.46460-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yuan,

On 10/18/24 03:12, Yuan Can wrote:
> The caller of the function dev_pm_qos_add_request() checks again a non
> zero value but dev_pm_qos_add_request() can return '1' if the request
> already exists. Therefore, the setup function fails while the QoS
> request actually did not failed.
> 
> Fix that by changing the check against a negative value like all the
> other callers of the function.
> 
> Fixes: e44655617317 ("powercap/drivers/dtpm: Add dtpm devfreq with energy model support")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>   drivers/powercap/dtpm_devfreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
> index f40bce8176df..d1dff6ccab12 100644
> --- a/drivers/powercap/dtpm_devfreq.c
> +++ b/drivers/powercap/dtpm_devfreq.c
> @@ -178,7 +178,7 @@ static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
>   	ret = dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
>   				     DEV_PM_QOS_MAX_FREQUENCY,
>   				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> -	if (ret) {
> +	if (ret < 0) {
>   		pr_err("Failed to add QoS request: %d\n", ret);
>   		goto out_dtpm_unregister;
>   	}

Good catch thanks!
Indeed in the doc of that API there is '1' as return value.
I will check other places of that QoS usage.


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


