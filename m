Return-Path: <linux-pm+bounces-28983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F0ADF08D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 16:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744F91884782
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E72EF2A9;
	Wed, 18 Jun 2025 14:57:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9412EF2A2;
	Wed, 18 Jun 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258642; cv=none; b=NyXSaX/++2uQvs6gsAy8x/bfGPugVD5S38y5BgIRrjOA3OO6Gf8USWdrmaSgjqIEvHzBJl1znI36WdfYIiiM3Jg2QXPCAE/7B8+4kkOgmFAron2U0Gjw5tapBsKD45/N8ootdxg1exnldFSwAYTsahsOFW6vfIEXwCE0wOl81xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258642; c=relaxed/simple;
	bh=MyH+iNLN68kJuVQh2e9J8E7zeuT3U91XuHIwrgcbNus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIrl35FCBFBjL8COml2tu68mOc4ngcazF8A6Wi6pytkUBNbAebevJgjtTuEwwR2ZWqofaP4FzBYNENoLH72jlVRvKjGGH2FSAcwnKQnDucKdxU+Yoah6URpxVg9J+EgXFGTbaF3V4os0b+9785lyCkQWFsnntpP/6OSdIDCOD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4781B1D31;
	Wed, 18 Jun 2025 07:56:57 -0700 (PDT)
Received: from [10.1.35.75] (e127648.arm.com [10.1.35.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D58473F58B;
	Wed, 18 Jun 2025 07:57:16 -0700 (PDT)
Message-ID: <1458e4f8-bd76-4d75-acb9-87f7064ea40c@arm.com>
Date: Wed, 18 Jun 2025 15:57:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Fix initialization with disabled boost
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, zhenglifeng1@huawei.com
References: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
 <CAJZ5v0heNSqHKZsmzu8N_hNKXeg_BZ0g4p0=dQtkDxBFHN+=4w@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0heNSqHKZsmzu8N_hNKXeg_BZ0g4p0=dQtkDxBFHN+=4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/25 15:32, Rafael J. Wysocki wrote:
> On Mon, Jun 16, 2025 at 7:25 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> The boost_enabled early return in policy_set_boost() caused
>> the boost disabled at initialization to not actually set the
>> initial policy->max, therefore effectively enabling boost while
>> it should have been enabled.
> 
> Did you mean "disabled"?

Yup, the latter 'enabled' should be disabled.

> 
> It would be good to mention the failure scenario here too.
> 

Absolutely, let me respin this in a series that provides some context, too.

>> Fixes: 27241c8b63bd ("cpufreq: Introduce policy_set_boost()")
>> Reported-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index d7426e1d8bdd..e85139bd0436 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1630,7 +1630,7 @@ static int cpufreq_online(unsigned int cpu)
>>          */
>>         if (cpufreq_driver->set_boost && policy->boost_supported &&
>>             (new_policy || !cpufreq_boost_enabled())) {
>> -               ret = policy_set_boost(policy, cpufreq_boost_enabled());
>> +               ret = cpufreq_driver->set_boost(policy, cpufreq_boost_enabled());
>>                 if (ret) {
>>                         /* If the set_boost fails, the online operation is not affected */
>>                         pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
>> --
>> 2.34.1


