Return-Path: <linux-pm+bounces-20934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE0A1B265
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26173A4508
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628D11DAC8A;
	Fri, 24 Jan 2025 09:11:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443781DB133;
	Fri, 24 Jan 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709905; cv=none; b=J3gVZOrXgg4dAJfs/9LIPWlyozLQk6Qj1Whno3iCRJkvQNlBCdRfv8VOkhsprBAvTgyrRUCVDDYPwD5Aslj4av9MsEYYEbY5Vs+WDZTeEEkFJtGX1lWF8u6uPAK7sFj847NEZqDlTBBU+Fzhsx0VLol2S4Lyu7dmd3RMgM94/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709905; c=relaxed/simple;
	bh=wKbf4R2cSSmtid0vkDP/Z8d9UyDWYH9Vm5ezVHYz8ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JqID8L4JEgAPL6FS/CVRpgOmluHfz4SV17DT6DChnvAuJZCy1MTU3NtXWW0VlowuisEdlxBxRStY1YzFH0YuY5D8tLbqn0PDmzDBXvSVEFlZNO1Jl13dxxQykSDh5ORT4GDZZPBR98UkpzK4igoKu849/MIsKUqlDFTRm5KdfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YfXBX3tSsz20pSy;
	Fri, 24 Jan 2025 17:12:04 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id C23F9180216;
	Fri, 24 Jan 2025 17:11:38 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Jan
 2025 17:11:38 +0800
Message-ID: <e9f4d2ac-6561-406b-b370-500ab52ff110@huawei.com>
Date: Fri, 24 Jan 2025 17:11:37 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] cpufreq: ACPI: Remove set_boost in
 acpi_cpufreq_cpu_init()
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <fanghao11@huawei.com>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-5-zhenglifeng1@huawei.com>
 <20250121061418.2eiifftsv6q7jxlm@vireshk-i7>
 <20250124085959.r3cf7qfd7fxz2iiw@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250124085959.r3cf7qfd7fxz2iiw@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/24 16:59, Viresh Kumar wrote:

> On 21-01-25, 11:44, Viresh Kumar wrote:
>> There are more cleanups in drivers that can be done though. I will try
>> that once this series is merged.
> 
> https://lore.kernel.org/751338633b070ee570c3c7da053bd6b9497ee50e.1737707712.git.viresh.kumar@linaro.org
> 

Nice!


