Return-Path: <linux-pm+bounces-16713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8C19B5F4E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 10:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD89B21A33
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D841E230F;
	Wed, 30 Oct 2024 09:54:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882C1E2016;
	Wed, 30 Oct 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282072; cv=none; b=Xfr1okE5uC9wVxpfrUeaeOkbAxTX8fVZFoxIo3KqqZayKnwEeiJGSgKL0jKThHDlx3Dacn2wz0J+D8eiLP/0tzBC09xQDdgv7iPZAt/RCikH5AtrKtR8MBAMPfaiXQ831jTtnEgsBERFdtxM9EPTFfN38o8GlpuKoy8TGb49+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282072; c=relaxed/simple;
	bh=Flqqcm/cz8s1x0wdzu31nHt4ZmJzcO34SY4lU9SNcT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fX5OZ/A0q4UHXtGDRo7HLCY1RrATX+q8376LPUcULzRgQXcS7H3RUm2FgZaSAaluYppeHgGJcfyhe+UWR1nBDGG3Gurg9+IlDM5kVpSmK51IiVPDyMTB2wLTlK/K0yr8Lmd8rEyliwch+NvQ3Y9gIoyXefPqAVzKCDyxF5sbg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6DD113E;
	Wed, 30 Oct 2024 02:54:57 -0700 (PDT)
Received: from [10.57.58.72] (unknown [10.57.58.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2FBD3F73B;
	Wed, 30 Oct 2024 02:54:24 -0700 (PDT)
Message-ID: <ab36709d-a181-4621-a8e5-0ef38b80186b@arm.com>
Date: Wed, 30 Oct 2024 09:55:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/1] cpufreq: scmi: Register for limit change
 notifications
To: Cristian Marussi <cristian.marussi@arm.com>,
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
 morten.rasmussen@arm.com, dietmar.eggemann@arm.com, pierre.gondois@arm.com,
 vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
References: <20240603192654.2167620-1-quic_sibis@quicinc.com>
 <20240603192654.2167620-2-quic_sibis@quicinc.com> <ZyH9HvKmYjlJC8_x@pluto>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ZyH9HvKmYjlJC8_x@pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/24 09:32, Cristian Marussi wrote:
> On Tue, Jun 04, 2024 at 12:56:54AM +0530, Sibi Sankar wrote:
>> Register for limit change notifications if supported and use the throttled
>> frequency from the notification to apply HW pressure.
>>
> 
> This sort of got lost in mbox...apologies.
> 
> As discussed offlist, the issue with cpufreq and multiple SCMI instances
> remains BUT it will be solved later on with a different approach, so
> as of now this LGTM.
> 
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thank you Cristian for re-visiting this.

That code also LGTM and fits into my other construction built on top
of it [1] [2]. I had a talk with Rafael below that [1] about this
subject patch.

Feel free to add:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

[1] 
https://lore.kernel.org/lkml/20241029094452.495439-1-lukasz.luba@arm.com/
[2] 
https://lore.kernel.org/lkml/20240403162315.1458337-1-lukasz.luba@arm.com/

