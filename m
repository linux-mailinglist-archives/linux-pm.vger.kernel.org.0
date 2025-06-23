Return-Path: <linux-pm+bounces-29411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A9DAE5654
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 00:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0573A3F68
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 22:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962FA22333B;
	Mon, 23 Jun 2025 22:16:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60B7B676;
	Mon, 23 Jun 2025 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717003; cv=none; b=tKn5ui5DnBVCpCPISBBIv6VSe2tTaZhE1POfPb2d+F5/NYOBBR0rnkGIvwOzh2pZv0JgcHuV27PclQxsbFu4t7xTdLJuNJC+lxu5CniSY34AZOmgEfvqAXN5Ro71P+c8nvSXJvW9/uD5gTGpDCB9pNgTICwcJ60EQEUaxVmJZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717003; c=relaxed/simple;
	bh=HPc7j1Rjffy+/FVRAD+2Y9VXgliY5w7VDMVHee2UYJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/ilAm16++8inwFseqwE5qK+oWD9WMbHgZyTDaFQBDiUCZewVxvaxF7C+YU5XbCff2yl5Eofi77sgxMQreZcH9ZlkfC5ufm0OxP9HhalKzZC74I7oWa+Gl7qz1yfGaaT8U10jn9w7Nit/rC1n5bzRgKzkciV+sUXm1zk1TIJxjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D76D5106F;
	Mon, 23 Jun 2025 15:16:21 -0700 (PDT)
Received: from [192.168.178.25] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 475413F58B;
	Mon, 23 Jun 2025 15:16:38 -0700 (PDT)
Message-ID: <e4854492-86cc-4775-bbc3-5f16b73d008d@arm.com>
Date: Tue, 24 Jun 2025 00:16:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Fix initialization with disabled boost
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, zhenglifeng1@huawei.com
References: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
 <CAJZ5v0heNSqHKZsmzu8N_hNKXeg_BZ0g4p0=dQtkDxBFHN+=4w@mail.gmail.com>
 <1458e4f8-bd76-4d75-acb9-87f7064ea40c@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <1458e4f8-bd76-4d75-acb9-87f7064ea40c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/06/2025 16:57, Christian Loehle wrote:
> On 6/18/25 15:32, Rafael J. Wysocki wrote:
>> On Mon, Jun 16, 2025 at 7:25 PM Christian Loehle
>> <christian.loehle@arm.com> wrote:
>>>
>>> The boost_enabled early return in policy_set_boost() caused
>>> the boost disabled at initialization to not actually set the
>>> initial policy->max, therefore effectively enabling boost while
>>> it should have been enabled.
>>
>> Did you mean "disabled"?
> 
> Yup, the latter 'enabled' should be disabled.
> 
>>
>> It would be good to mention the failure scenario here too.
>>
> 
> Absolutely, let me respin this in a series that provides some context, too.

I got confused as well. Is this for a dt file with some (higher) OPPs
marked with 'turbo-mode' or not?

[...]

