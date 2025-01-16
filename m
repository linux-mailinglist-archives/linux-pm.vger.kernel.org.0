Return-Path: <linux-pm+bounces-20522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71FDA13116
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 03:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754BD1889509
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 02:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3150285;
	Thu, 16 Jan 2025 02:08:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B11E480;
	Thu, 16 Jan 2025 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736993306; cv=none; b=N9218L8RKvFFj+mdle743COydkPU3sLwb2pGIhymBD6eCjGniY246lF5NhQE+OEL/+SBXynQ3SeY/elXlYsn0cU65gculHfIllGC7ZhVQgQEWl6HfZQIXfVtaqlqguZq8IrIiEgt4yF/SkRPD43dfqOZ5w22kC3mRdhWyYRLb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736993306; c=relaxed/simple;
	bh=ISZ/r+9sXHU4PlqiSCDo21HNThB3R2YXCh4o+Ce98DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O+QGz32yB8tkwBTo+4AUuKO8KEFrwqwepo2xxBnjk8tgzxOPTQmJp32pipN92ajAXaern5KqtzlUWKqVM1SkwHMpLSuXhKHAz4z1l0s9bmMa2UxwX5E71lWSxrXjVU8VXX42vJsokifn+MgjH52m1sfhXcPvbcIHi2a+Ucjc4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YYR7P2LGpzrSV4;
	Thu, 16 Jan 2025 10:06:41 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 6556318032E;
	Thu, 16 Jan 2025 10:08:21 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Jan
 2025 10:08:20 +0800
Message-ID: <9423f959-6d93-4908-ac2a-a9e23c69f2db@huawei.com>
Date: Thu, 16 Jan 2025 10:08:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpufreq: Introduce a more generic way to boost when
 cpu is going online
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250115100123.241110-1-zhenglifeng1@huawei.com>
 <CAJZ5v0gPMGg2ZvjOmvmfj9W6L9wKT2+ToFgDpi-1pcg_zc+Z2g@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0gPMGg2ZvjOmvmfj9W6L9wKT2+ToFgDpi-1pcg_zc+Z2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/15 20:53, Rafael J. Wysocki wrote:

> On Wed, Jan 15, 2025 at 11:01 AM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Since commit f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on
>> SoCs using cpufreq_boost_set_sw()") and commit 102fa9c4b439 ("cpufreq:
>> Allow drivers to advertise boost enabled"), per-policy boost flag has
>> already been set to mirror the cpufreq_driver boost during
>> initialization. However, the current implementation doesn't work for all
>> cpufreq drivers and may fail in certain situation. A more generic
>> implementation is needed.
> 
> Can you please be more specific here?
> 
> What happens, why it happens and why do you think the way to go is to
> reimplement this?

I've explained this in commit log of patch 2. But if you think it is better
to palce here too, I'll do that in v2.

