Return-Path: <linux-pm+bounces-30114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B14ACAF8EF5
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441ABB60541
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EFC2EBBAE;
	Fri,  4 Jul 2025 09:07:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F62882A0;
	Fri,  4 Jul 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620056; cv=none; b=uLw0CJv9q3BNUB3SkbxGYMJzrfMUjuRZprub0eKgYF70dNyZJ/G9kJ2f+PjhdTMaBYyirK0MNmsJKfcVO4stqsF/VTQbi37HS/NSTqe17e/igN0dRqEKFYD3LjMJDojPAAqhj94OiYJtD5MxHQsvdhyHGxR6lvB87XjXMPcgam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620056; c=relaxed/simple;
	bh=m7DQxmEPQ6+xgS7Gb1bEgXe3teeybPe4freXbXoSI48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MYzuypFpKqa7cvTAmo9AINKoBsvaRv1n+aIoAKB3aeDbbAqSs0kfHgJYaUHctYZcagy2vswmrrIqYawsLfWdTNTguKbobCdhJHTr9MlIS03P2om4v6rGH+MUwIgLTpzNuR014DDOEAozJQYmZVOtCyLNfvRAO3EtwUymcjmNi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bYSQs5jdmz2BcpV;
	Fri,  4 Jul 2025 17:05:41 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D25218001B;
	Fri,  4 Jul 2025 17:07:31 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 17:07:30 +0800
Message-ID: <c2201037-4f16-4afc-a418-42e4514f27a4@huawei.com>
Date: Fri, 4 Jul 2025 17:07:30 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] cpufreq: Contain scaling_cur_freq.attr in
 cpufreq_attrs
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
 <20250623133402.3120230-4-zhenglifeng1@huawei.com>
 <CAJZ5v0jvdttYihgNcTF=VVnd2K5QsC+W9XJJanqy4F_PXw+u2g@mail.gmail.com>
 <CAJZ5v0jKY2og0bSwq97fwu7W690E-GeYxGkeju3kq4DVgOFCaw@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0jKY2og0bSwq97fwu7W690E-GeYxGkeju3kq4DVgOFCaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/7/3 22:59, Rafael J. Wysocki wrote:

> On Mon, Jun 23, 2025 at 5:30 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Jun 23, 2025 at 3:34 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>>
>>> After commit c034b02e213d ("cpufreq: expose scaling_cur_freq sysfs file for
>>> set_policy() drivers"), the file scaling_cur_freq is exposed to all
>>> drivers. No need to create this file separately. It's better to be
>>> contained in cpufreq_attrs.
>>
>> Fair enough.
> 
> And so applied as 6.17 material along with the [4/7].
> 
> The other patches in the series need more work IMV.
> 
> Thanks!

Thanks! Then in the next version these two patches won't be sent again.

