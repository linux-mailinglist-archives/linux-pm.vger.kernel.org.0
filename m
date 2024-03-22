Return-Path: <linux-pm+bounces-5219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690DD886886
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 09:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970F71C21EBE
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822C18EC0;
	Fri, 22 Mar 2024 08:50:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA3F224D8;
	Fri, 22 Mar 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097426; cv=none; b=HWLtSs5n0/N/5vpw/nS7XV9zAeRnVMk9c1H/cnKK7DROrVAkKz5VuvTgiuVC2ZLzxBsEC/mgH/g3WXWJkVLGnuCFpQAibsmh85X0BJnrIIKpn6gB9gKT6s5nWA74gbSvg085mbqVSJr4Zj56+kkhJMPc72RL/6KHj9R8p6V+eBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097426; c=relaxed/simple;
	bh=8ba/XlgbFs7Ype4sixeB3Mh2Ts60t6pN/+s3RLXasJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKgj3ec9DrNAMJSjeJNPPrD+RdyGHf6d+llpA05JpjdZ333fyqgSsnyFe6lyDQbnAuKedekGGnACpPu3AwIcmbsJNDCEcLYd3nbcGRPcdiGna2Ti8oY2/IoNyjNaYYdHnsAZDl3JWMrqFiuMpTIrch5GmNcqMnQgeKtJaq47xjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFA0E1007;
	Fri, 22 Mar 2024 01:50:50 -0700 (PDT)
Received: from [10.57.71.57] (unknown [10.57.71.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5E183F64C;
	Fri, 22 Mar 2024 01:50:14 -0700 (PDT)
Message-ID: <c7b2cb6f-3e14-45c3-9e22-11c0a9422bce@arm.com>
Date: Fri, 22 Mar 2024 08:50:06 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Fix perf state when
 calculate dfc res_util
Content-Language: en-US
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: tao.huang@rock-chips.com, heiko@sntech.de, rafael@kernel.org,
 daniel.lezcano@linaro.org, finley.xiao@rock-chips.com,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, rui.zhang@intel.com
References: <20240321102100.2401340-1-ye.zhang@rock-chips.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240321102100.2401340-1-ye.zhang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/21/24 10:21, Ye Zhang wrote:
> The issue occurs when the devfreq cooling device uses the EM power model
> and the get_real_power() callback is provided by the driver.
> 
> The EM power table is sorted ascending，can't index the table by cooling
> device state，so convert cooling state to performance state by
> dfc->max_state - dfc->capped_state.
> 
> Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model and use EM")
> Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> ---
> v1 -> v2:
>    - Update the commit message.
> 
>   drivers/thermal/devfreq_cooling.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 50dec24e967a..8fd7cf1932cd 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -214,7 +214,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>   
>   		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
>   		if (!res) {
> -			state = dfc->capped_state;
> +			state = dfc->max_state - dfc->capped_state;
>   
>   			/* Convert EM power into milli-Watts first */
>   			rcu_read_lock();

Thanks, LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

