Return-Path: <linux-pm+bounces-4536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD986C2AD
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 08:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F851F25789
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 07:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B49346556;
	Thu, 29 Feb 2024 07:42:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899371F951;
	Thu, 29 Feb 2024 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192546; cv=none; b=bMoQ3Uqlv4pVyZ6kFjVJOp/ci40feguy0lmaD+Pa5SyHw0jpMrMT+Tb400AT1gghujf1qE6N564wSNe4sb3dJP8j82Mfq2uJdXWnoYruW+E8XSACFEf1W8Em3D67FNbfnsR4DnNVAkI7fjLKxB7tKHMPkpDNI39Mpu3xz8SyVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192546; c=relaxed/simple;
	bh=Q/11Q49KEKt/Spi4akngBYieCr5yha8+eBtEahXuFrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0r9mYdXi+BTz+IoFHI5EPjR/lo4ofxa8ljv306U+I6StIT3LfLbYKAczyworJgOb5UfDoUzBQU0JtG60ZHajcA3oQVeXlxXzrPShkG2OkWDLwyWNaj1Z8yGQ2M0YiScngMzLwgTSrr0WteLUMh1DScTOj9KqpMsz5/XcbmJUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76EFA1FB;
	Wed, 28 Feb 2024 23:43:02 -0800 (PST)
Received: from [10.57.12.184] (unknown [10.57.12.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41FBD3F6C4;
	Wed, 28 Feb 2024 23:42:21 -0800 (PST)
Message-ID: <2496f490-fbfb-403c-a86c-73960afb4e76@arm.com>
Date: Thu, 29 Feb 2024 07:42:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
 gustavoars@kernel.org, morbo@google.com, justinstitt@google.com,
 stanislaw.gruszka@linux.intel.com, linux-pm@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 patches@lists.linux.dev, Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
 <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
 <f81af0ae-7458-47d3-90ae-71d5217ee7dd@linaro.org>
 <202402270816.0EA3349A76@keescook>
 <bbc65508-eb0e-4d63-921b-85d242cc556f@linaro.org>
 <202402270852.E46A5268@keescook>
 <3ed4ad69-1229-4834-95b7-9397364ea401@arm.com>
 <20240228165651.GA2158263@dev-arch.thelio-3990X>
 <202402280944.CE26D81@keescook>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <202402280944.CE26D81@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/24 17:48, Kees Cook wrote:
> On Wed, Feb 28, 2024 at 09:56:51AM -0700, Nathan Chancellor wrote:
>> On Wed, Feb 28, 2024 at 08:41:07AM +0000, Lukasz Luba wrote:
>>> Hi Nathan and Kees,
>>>
>>> On 2/27/24 17:00, Kees Cook wrote:
>>>> On Tue, Feb 27, 2024 at 05:47:44PM +0100, Daniel Lezcano wrote:
>>>>> Ok my misunderstanding was I thought sizeof() was calling _bdos under the
>>>>> hood, so when calling sizeof(flex_array), it was returning the computed size
>>>>> inferring from the __counted_by field.
>>>>
>>>> Yeah, sizeof() has a very limited scope. __builtin_object_size() has
>>>> more flexibility (via the 2nd argument, "type"), but it was still
>>>> compile-time only. __builtin_dynamic_object_size() was added to bring
>>>> runtime evaluations into the mix (initially to support the alloc_size
>>>> attribute, and now includes the counted_by attribute too).
>>>>
>>>
>>> Thanks for your earlier emails explaining these stuff.
>>> Do you have maybe some presentation about those features
>>> for the kernel (ideally w/ a video from some conference)?
>>
>> I think Kees's 2022 and 2023 talks at LPC are a good place to start:
>>
>> https://youtu.be/tQwv79i02ks?si=Nj9hpvmQwPB4K3Y4&t=452
>> https://youtu.be/OEFFqhP5sts?si=u6RnOP641S8FkouD&t=614
>>
>> https://outflux.net/slides/2022/lpc/features.pdf
>> https://outflux.net/slides/2023/lpc/features.pdf
> 
> I've also got a write-up on the entire topic of array bounds, which ends
> with some discussion of "the future" (which is now) involving the use of
> the "counted_by" attribute:
> https://people.kernel.org/kees/bounded-flexible-arrays-in-c#coming-soon-annotate-bounds-of-flexible-arrays
> 

Thank you guys!

