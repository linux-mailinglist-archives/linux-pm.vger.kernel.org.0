Return-Path: <linux-pm+bounces-4501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC3D86AA36
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 09:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52CA28325B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671642C85D;
	Wed, 28 Feb 2024 08:40:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09019250E0;
	Wed, 28 Feb 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109654; cv=none; b=eDvEth33BE7GFYNfqmslP8eJu+LI8wq8jZ5hrefzmsHyFcLWYodfAerOf2pFr2YF3ME2O9LSjXDlLdip7PAqsMhdFEN7IQcpGIDdLd9E3e0PK4o1Zf9ewKyLlr8lwzMFlXn8AL8u2CRZyG6/YmH+hG73sC7lH8c6tY7K0yGbI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109654; c=relaxed/simple;
	bh=WwgjU44tVUA8AEoqcZgtgfLaS9tkTahfdO6/GuC5sNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8w8H36Ve9T2Y3RXC5ktBjk9QZG8nZxP+L7/3EeZCKhPh9Crt7lLmIhrrjVxlsiOa91DIsIH7YF0gmHvHPpOWFFOCgSuhyjrgzle/7iRbOr+MBC4jpCYP8esSVHsUvrBEJdF+6w3ZlVQOPXN2XUXXQIsK4UhXsKLhYdx4WzWZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AA2EC15;
	Wed, 28 Feb 2024 00:41:31 -0800 (PST)
Received: from [10.57.11.244] (unknown [10.57.11.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130723F6C4;
	Wed, 28 Feb 2024 00:40:49 -0800 (PST)
Message-ID: <3ed4ad69-1229-4834-95b7-9397364ea401@arm.com>
Date: Wed, 28 Feb 2024 08:41:07 +0000
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
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <202402270852.E46A5268@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nathan and Kees,

On 2/27/24 17:00, Kees Cook wrote:
> On Tue, Feb 27, 2024 at 05:47:44PM +0100, Daniel Lezcano wrote:
>> Ok my misunderstanding was I thought sizeof() was calling _bdos under the
>> hood, so when calling sizeof(flex_array), it was returning the computed size
>> inferring from the __counted_by field.
> 
> Yeah, sizeof() has a very limited scope. __builtin_object_size() has
> more flexibility (via the 2nd argument, "type"), but it was still
> compile-time only. __builtin_dynamic_object_size() was added to bring
> runtime evaluations into the mix (initially to support the alloc_size
> attribute, and now includes the counted_by attribute too).
> 

Thanks for your earlier emails explaining these stuff.
Do you have maybe some presentation about those features
for the kernel (ideally w/ a video from some conference)?

Regards,
Lukasz

