Return-Path: <linux-pm+bounces-26630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A03CAA88A1
	for <lists+linux-pm@lfdr.de>; Sun,  4 May 2025 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A26189A7F8
	for <lists+linux-pm@lfdr.de>; Sun,  4 May 2025 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932C21D00D;
	Sun,  4 May 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQMbq8Wa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5421CC5A;
	Sun,  4 May 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380024; cv=none; b=FXEmYL5SbEG6DrO+qeVKaXtQnKBcz4Ea37pccDlhlXd2TmUwJUqDUcY+I2ER8o4PRHn8kZe2vYGVDwK9tBBdz5Nc3X0ay7ukYZkDJnSWTPSVJ6p9ZAhBCZzzof8wk9i71zS6IooEUjtzLeJC951Ms+4H6/Tkxc0NjcBwrOMupRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380024; c=relaxed/simple;
	bh=giT+sq5DATQNvD7PW1F1+M8kPXf80IBcWPokvEGeD4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vz+EyD9pwJ2gCDXwcwrfDyvqLE7Ofqdybt0Jf4vgmVdarMxuxE8J8v+Me6OH+M+9F0Bwoe/GjnsiOinTT+OrtqBj6+spHZ/BqWlLbPqCalVm4rCuu6AxjD/9vt4CYZ8cvm9vwEDZOkU9ijxS/DmjGYJmcn5jqkVr6Z9CdbDLWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQMbq8Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029E5C4CEE7;
	Sun,  4 May 2025 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746380024;
	bh=giT+sq5DATQNvD7PW1F1+M8kPXf80IBcWPokvEGeD4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BQMbq8Was3Sh/yrO1ZIB151kWubLfn3ZfwX6JRSYYEF0j+TzVqanC2YeI3tMy4nhl
	 jo5U2kp1Fcx3RoI+++HkkEFdlJh79ODm25uwnsTJfTlYtg47utrnJGeVr4dO+IK6LH
	 kxmoV4r2Gu1qRqYDU0xgoBmF8fEjnInZMrjWioyEUKvBxNXshmlyfp3XV+jYYZ3w5z
	 GzqAmSvMWeViypCjR9vVvgIhJJMJXmveAU19FtY+RpmuXzZZPDfqDTQgpQ4bBUqKE7
	 /yTv8Vr2MYg/TWjXL2iPX9xy20QzDX1sVwnRxfjpMRxmfUQkNJmoHyGsWo+ozQ72A6
	 K3KwQufOuLZsg==
Message-ID: <82c62623-97b4-4d57-8e18-97750b402aa1@kernel.org>
Date: Sun, 4 May 2025 19:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] drivers: clk: tegra: add DFLL support for Tegra 4
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250321095556.91425-1-clamor95@gmail.com>
 <20250321095556.91425-3-clamor95@gmail.com>
 <aef4574b-8167-4af3-a29c-8c962b396496@kernel.org>
 <CAPVz0n2580WLJmqeH-mJGrTQUpADt32qw7pJzuqRuwrpojc5vA@mail.gmail.com>
 <bd60283a-500a-4ed4-bb8b-c019d33f94cf@kernel.org>
 <CAPVz0n0Ty3QAg_9rSvV7c7EBGDigHtTAOAfkRFBcTR9fziEvQQ@mail.gmail.com>
 <aa8bdf4f-feb9-4355-b629-a5d7c6a43d25@kernel.org>
 <CAPVz0n1y4oF9MJkOJ+XTyDDe2u6mOXHsnAaJfLSM6tpcWTW7BQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAPVz0n1y4oF9MJkOJ+XTyDDe2u6mOXHsnAaJfLSM6tpcWTW7BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/05/2025 19:30, Svyatoslav Ryhel wrote:
> нд, 4 трав. 2025 р. о 20:11 Krzysztof Kozlowski <krzk@kernel.org> пише:
>>
>> On 04/05/2025 18:25, Svyatoslav Ryhel wrote:
>>> нд, 4 трав. 2025 р. о 19:23 Krzysztof Kozlowski <krzk@kernel.org> пише:
>>>>
>>>> On 03/05/2025 10:54, Svyatoslav Ryhel wrote:
>>>>>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>>>>>>> +/*
>>>>>>> + * This header provides Tegra114-specific constants for binding
>>>>>>> + * nvidia,tegra114-car.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#ifndef _DT_BINDINGS_RESET_TEGRA114_CAR_H
>>>>>>> +#define _DT_BINDINGS_RESET_TEGRA114_CAR_H
>>>>>>> +
>>>>>>> +#define TEGRA114_RESET(x)            (5 * 32 + (x))
>>>>>>
>>>>>>
>>>>>> Does not look like a binding, but some sort of register. Binding IDs
>>>>>> start from 0 (or 1) and are incremented by 1.
>>>>>>
>>>>>
>>>>> Hello there!
>>>>> This file add same logic for Tegra114 as Tegra124 currently
>>>>> implements, check here
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/dt-bindings/reset/tegra124-car.h?h=v6.14.5
>>>>>
>>>>> I did not re-use Tegra124 value, though it is same, to avoid confusion
>>>>> in main Tegra114 device tree.
>>>>
>>>> What confusion? Why would anyone be interested in comparing numbers thus
>>>> getting confused by different number? These are abstract IDs.
>>>>
>>>
>>> By using TEGRA124_RESET in Tegra114 device tree
>>
>> Why would you use define from other SoC... and how is it related to my
>> comment in the first place?
>>
> 
> You did not even bother to check link that I have provided, did you?

I did. I clicked it, looked the same as here. Does not help.

> 
> You cut the actual device tree compatible definition,
> TEGRA114_RESET(x) is a macro used further to define device tree
> compatibles.

There are no further users...

> 
> Like this:
> 
> #define TEGRA114_RST_DFLL_DVCO         TEGRA114_RESET(0)

and still my comment stands. Bindings start from 0 or 1.


Best regards,
Krzysztof

