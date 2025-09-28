Return-Path: <linux-pm+bounces-35515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D4BBA65EB
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 04:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC501737EA
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365E245028;
	Sun, 28 Sep 2025 02:02:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F233EC;
	Sun, 28 Sep 2025 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759024931; cv=none; b=NlnhrQztiX+DCEV23uBJzgA2KKuXA6F7lA0xvoWxl3mDh1Dc2TpA1EIJPQeBHOoqIK9Gsg7foSargGHzo1GQVGXjyTIRlpOzvbZaqoQ9zVs5BeNBMl48oQH6ki8cslwZSA/DiZYoQvD6McyFqF2LQMvFnsXPhsVl/rp8motMd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759024931; c=relaxed/simple;
	bh=2Ldqunqua+Ct1DWMfYX/V9YnIxX1ZwBCUQtELFEyUpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j4qpjvIDczxapimLq57DmM3xCsePkEpYbLOj2XCBqWcqudErmii6fStjiA6CEJka40Y2CWzCXnU0K01OCb6dE3q26XI4ckeXe2NnUUrQ/kouhmu67bbtSzHBpD80J6x96nZLBCttelWv17kkV0/WQpotY8zcNMyHMmkKMgHSK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cZ6sL6SMMzWvDH;
	Sun, 28 Sep 2025 09:57:42 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cZ6xs0Z8mz1T4Gx;
	Sun, 28 Sep 2025 10:01:37 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id A39AB180464;
	Sun, 28 Sep 2025 10:01:57 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 28 Sep
 2025 10:01:56 +0800
Message-ID: <d694df21-235f-422e-ba08-1eb442b376bd@hisilicon.com>
Date: Sun, 28 Sep 2025 10:01:56 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devreq: move governor.h to a public header location
To: Jon Hunter <jonathanh@nvidia.com>, Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>, Thierry Reding
	<thierry.reding@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>, Robie Basak
	<robibasa@qti.qualcomm.com>
References: <20250903-governor-public-v1-1-111abd89a89a@oss.qualcomm.com>
 <ae509446-4703-43af-a48d-9c72da0b3813@hisilicon.com>
 <25692922-7610-49bc-b33d-c799a13995cb@nvidia.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <25692922-7610-49bc-b33d-c799a13995cb@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 9/26/2025 6:33 PM, Jon Hunter wrote:
> 
> On 26/09/2025 04:16, Jie Zhan wrote:
>>
>> Hi Dmitry,
>>
>> On 9/3/2025 9:43 PM, Dmitry Baryshkov wrote:
>>> Some device drivers (and out-of-tree modules) might want to define
>>> device-specific device governors. Rather than restricting all of them to
>>> be a part of drivers/devfreq/ (which is not possible for out-of-tree
>>> drivers anyway) move governor.h to include/linux/devfreq-governor.h and
>>> update all drivers to use it.
>>
>> For out-of-tree module compilation, can it add drivers/devfreq/ to the
>> include path?
>> I suppose this is unnecessary.
> 
> The kernel header/source package created for most linux distros will not included this header because it is internal and so in that case it is necessary.
> 
> Jon
> 
Got it, thanks.

