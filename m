Return-Path: <linux-pm+bounces-2375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD08328A4
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1021F22E42
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 11:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0B33D393;
	Fri, 19 Jan 2024 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="bKIwIUGV"
X-Original-To: linux-pm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DB3C470
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662954; cv=none; b=GNYyBIb2fOur8J8jOT1CnHUbwFq3en3MpBwKZJG1fGdy4nqkxRw41tkQVtyju2m7CkJRbMaOFg9WyMZjPOPtLsbsrNN8BoawkXhIXoIEhqCEmjRt14apEvFgre/rTf2OTPd937upfawN5HvajD+K25kxQgroa10YlCr16v3u2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662954; c=relaxed/simple;
	bh=DO+mFZ7HF6rMuHe6kj7D6RUUm/n7CFHefjKby+CVNOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r13g0w59nkwZMcDOFl7noiP905fcyekgnzC6guNTrl8j4ZgtqzHMO6rrbdaWqoTOk1+wHA+3E7QZlydoctTxkseqwXPEI+19eOsjyznuXe8tJZf7Zas2VZ5XNQPXi8Z4javfjnYiZi6ltHTC/KQX1dmZNlMbMwZsM3wozZGvFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=bKIwIUGV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BCFF787A82;
	Fri, 19 Jan 2024 12:15:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705662950;
	bh=SUsZc5co9UnGPw9CafszzMNh7dbWHLX8Es5IDCF8Q+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bKIwIUGV1ESVXKbIOMqL5nNhQ7s47t+FdDi6xZp/yJerbxZwm8L2P/J3Jl9HWu9LJ
	 FH/r4ZocLwtrwzZVrVhfFv55x+KO4F0Bf9IHTy7sQojaLOYHLDnRLkpwAL7Lhuz09U
	 ECLF9Cf95+DtBS0WfatGLDJatfPdjN4cXXvYDmjrX6oOTCiLvPgEIQSTDN1WQdoqD1
	 csc93BhBGnQ+Fucr7mcZgkhj0EkuyJrG39WweP+KGoupfGPgNwZe9L54wZfzqM3oiz
	 SlvM9S47TodIvmRxk+y28e3gTA057A83Dz5NnNKIGmhNUJosB7KlAcD9ISeiPcYolk
	 iMjZN/orw2aCg==
Message-ID: <73886bd9-e2ab-40ef-a1a0-a82222d97201@denx.de>
Date: Fri, 19 Jan 2024 11:58:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pmdomain: imx8m-blk-ctrl: imx8mp-blk-ctrl: Error out
 if domains are missing in DT
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Jindong Yue <jindong.yue@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
References: <20240119014807.268694-1-marex@denx.de>
 <asamq53uiegrgwo5c25sjn7n47bsv6xa3ybkueuhb2d42m66ze@t6ujdompm2gs>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <asamq53uiegrgwo5c25sjn7n47bsv6xa3ybkueuhb2d42m66ze@t6ujdompm2gs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/19/24 08:42, Uwe Kleine-König wrote:
> On Fri, Jan 19, 2024 at 02:47:41AM +0100, Marek Vasut wrote:
>> This driver assumes that domain->power_dev is non-NULL in its suspend/resume
>> path. The assumption is valid, since all the devices that are being looked up
>> here should be described in DT. In case they are not described in DT, beause
>> the DT is faulty, suspend/resume attempt would trigger NULL pointer dereference.
>> To avoid this failure, check whether the power_dev assignment is not NULL right
>> away in probe callback and fail early if it is.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Jindong Yue <jindong.yue@nxp.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Marco Felsch <m.felsch@pengutronix.de>
>> Cc: NXP Linux Team <linux-imx@nxp.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-pm@vger.kernel.org
>> ---
>> V2: Add extra check for domain being NULL (thanks Peng)
>> ---
>>   drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 9 ++++++---
>>   drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 9 ++++++---
>>   2 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> index 1341a707f61bc..ca942d7929c2b 100644
>> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> @@ -258,11 +258,14 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>>   
>>   		domain->power_dev =
>>   			dev_pm_domain_attach_by_name(dev, data->gpc_name);
>> -		if (IS_ERR(domain->power_dev)) {
>> -			dev_err_probe(dev, PTR_ERR(domain->power_dev),
>> +		if (IS_ERR_OR_NULL(domain->power_dev)) {
>> +			if (!domain->power_dev)
>> +				ret = -ENODEV;
>> +			else
>> +				ret = PTR_ERR(domain->power_dev);
>> +			dev_err_probe(dev, ret,
>>   				      "failed to attach power domain \"%s\"\n",
>>   				      data->gpc_name);
>> -			ret = PTR_ERR(domain->power_dev);
>>   			goto cleanup_pds;
>>   		}
>>   
>> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
>> index e3203eb6a0229..e488cf79b8007 100644
>> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
>> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
>> @@ -687,11 +687,14 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
>>   
>>   		domain->power_dev =
>>   			dev_pm_domain_attach_by_name(dev, data->gpc_name);
>> -		if (IS_ERR(domain->power_dev)) {
>> -			dev_err_probe(dev, PTR_ERR(domain->power_dev),
>> +		if (IS_ERR_OR_NULL(domain->power_dev)) {
>> +			if (!domain->power_dev)
>> +				ret = -ENODEV;
>> +			else
>> +				ret = PTR_ERR(domain->power_dev);
>> +			dev_err_probe(dev, ret,
>>   				      "failed to attach power domain %s\n",
>>   				      data->gpc_name);
>> -			ret = PTR_ERR(domain->power_dev);
> 
> This could be made a bit more compact using:
> 
> 	domain->power_dev =
> 		dev_pm_domain_attach_by_name(dev, data->gpc_name) ||
> 		ERR_PTR(-ENODEV);
> 	if (IS_ERR(domain->power_dev)) {
> 		ret = PTR_ERR(domain->power_dev);
> 		...
> 
> I'm unsure though if this is human friendly enough?!

I think it is only more cryptic and doesn't improve readability.

> Having said that I wonder about dev_pm_domain_attach_by_name(). IMHO if
> NULL is an error case it and other errors are signaled by error
> pointers, there is something to fix there.

I don't think dev_pm_domain_attach_by_name() returning NULL is an error 
-- the domain may be missing from DT and that is legitimate use case I 
think.

But not here, where all the domains should be described in DT because 
the driver makes assumptions about their presence in the suspend/resume 
part, and because the DT should fully describe the domains of this 
hardware anyway, so we better catch such DT issues.

