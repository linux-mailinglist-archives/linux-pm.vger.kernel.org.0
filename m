Return-Path: <linux-pm+bounces-35733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53886BBE526
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 16:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348241887288
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ED12D541E;
	Mon,  6 Oct 2025 14:26:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ADC2D47E8;
	Mon,  6 Oct 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760763; cv=none; b=ueFusQiXizqWNSarRAIQVCHA/8cGHGaRUNBMM3aXzGcWh9sSzDT9w3ArMljy6V1Hjm1/qHDtxrcIZv9dm26Y4WR1okc7LZ0OBVaqu3Io1vy8CMN+QBvD3QoId7sOMwKBOUwG5unJIetsPh8vdLaMHsD1xhpNeNqu4T/Ltm3jZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760763; c=relaxed/simple;
	bh=Kj1knDkCBA9GFiICeHfLtWlrSwpX8lQAXVNbt6JeTf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf4/GuHX1vWsE9CUYlO2jd0TkRm5Q3QNE3nBCbjUxBwo6UdHpPpJ3gnPEe3IqIZcRcyKaxYGoUnuRPXbp2aDsudUuCUX01GrjXaRpQt/xn7P/8Amv87keWQORCK9j7hjKYTFcsuWGZvi7QVKzjLKI1C8amPHe7iNR/vrY3k+APA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F531515;
	Mon,  6 Oct 2025 07:25:53 -0700 (PDT)
Received: from [10.57.81.187] (unknown [10.57.81.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96A723F738;
	Mon,  6 Oct 2025 07:25:59 -0700 (PDT)
Message-ID: <268414ae-43b2-49e0-9ee5-9c51468a6bb0@arm.com>
Date: Mon, 6 Oct 2025 15:26:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 02/10] PM: EM: Expose the ID of a performance
 domain via debugfs
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-3-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-3-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/25 04:19, Changwoo Min wrote:
> For ease of debugging, let's expose the assigned ID of a performance
> domain through debugfs (e.g., /sys/kernel/debug/energy_model/cpu0/id).
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   kernel/power/energy_model.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 3fe562b6230e..8998a7f4910a 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -126,6 +126,16 @@ static int em_debug_flags_show(struct seq_file *s, void *unused)
>   }
>   DEFINE_SHOW_ATTRIBUTE(em_debug_flags);
>   
> +static int em_debug_id_show(struct seq_file *s, void *unused)
> +{
> +	struct em_perf_domain *pd = s->private;
> +
> +	seq_printf(s, "%d\n", pd->id);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(em_debug_id);
> +
>   static void em_debug_create_pd(struct device *dev)
>   {
>   	struct em_dbg_info *em_dbg;
> @@ -142,6 +152,8 @@ static void em_debug_create_pd(struct device *dev)
>   	debugfs_create_file("flags", 0444, d, dev->em_pd,
>   			    &em_debug_flags_fops);
>   
> +	debugfs_create_file("id", 0444, d, dev->em_pd, &em_debug_id_fops);
> +
>   	em_dbg = devm_kcalloc(dev, dev->em_pd->nr_perf_states,
>   			      sizeof(*em_dbg), GFP_KERNEL);
>   	if (!em_dbg)

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

