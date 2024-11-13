Return-Path: <linux-pm+bounces-17479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33B9C7091
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 14:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E094BB2E42E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321B8200BB6;
	Wed, 13 Nov 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lLcz8paR"
X-Original-To: linux-pm@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B51EBA04
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502759; cv=none; b=WworPJAF4pgOXAStM20o45FfZBurLv3eYCTZCe5z8JbSt99m+4nl5qH6ba0Pc3uaslGkiAXl6Gkbi3hIZwJw9hAGVjq2iFyef/Eknn2RHV+MnOY+1E3q8YKvnyowEqiNsTdp8DfdI/vGiupm4dUWwB4yLCQqYpYhCoWyHtGcYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502759; c=relaxed/simple;
	bh=u5tGDNtr71dYjkM5XT6nRh18NvdgCTJKoO70dbwxF2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRdWUr6BvHPmYN3bCb3QhGofHZTH0RDWd0c27MxW8DYF27WOMVmXOWcQaEAnbgOs+QmOY0IyFyhlOJweqohWp1ppmbj6DiXevl4hD9evb/u/Nlod2YORplQu9wKzHi/cZQt2GgDxptmg6qtDnEH27mGv5u4NiWzaq2kcTY9O4n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lLcz8paR; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731502757;
	bh=HeW/stKMIpHwA/oQL/utsqZrC65ZV39vRcrfssf+zDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=lLcz8paRxYMbzuSOS9mHNHIGKHPE+ezKlgxibRk7T8LY7Z7bZorMlNFPpjOXWqwS1
	 6Hpz5XvOgozCuWFMgya2789RsMD7blCbnCPxEVVrByuvwmnk+opGPkkqUIWaZ+dP4U
	 an85f9NOMBBC3vfMM1QgnAOXCOBY0nZAqeVy85MrnAjLqlJnvoNVkPvdeEcbjNG0Ms
	 6jeGqARI2ZzFwZpS4ogP6P4plheOuoC0TrtE+gJBmq+gEDZbqZ+pcRD0zqcsxE2gek
	 1yjEY+0iA4TNFZfdz8FbaG4tH0pMNFSf08EfLM3bGDkWYuE46FJzLV9ebSlKYsagSo
	 Yfy5rFae/MLHQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id B98F3D00302;
	Wed, 13 Nov 2024 12:59:11 +0000 (UTC)
Message-ID: <0c9a06af-78e2-477d-99a4-b5626a1f791b@icloud.com>
Date: Wed, 13 Nov 2024 20:59:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] PM: domains: Fix return value of API
 dev_pm_get_subsys_data()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 stable@vger.kernel.org
References: <20241028-fix_dev_pm_get_subsys_data-v1-1-20385f4b1e17@quicinc.com>
 <2024111257-collide-finalist-7a0c@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024111257-collide-finalist-7a0c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KrzcmBmhurldNPMqFZ7RBSEX594Mi4a0
X-Proofpoint-ORIG-GUID: KrzcmBmhurldNPMqFZ7RBSEX594Mi4a0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411130111

On 2024/11/12 19:46, Greg Kroah-Hartman wrote:
> On Mon, Oct 28, 2024 at 08:31:11PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> dev_pm_get_subsys_data() has below 2 issues under condition
>> (@dev->power.subsys_data != NULL):
>>
>> - it will do unnecessary kzalloc() and kfree().
> 
> But that's ok, everything still works, right?
> 

i don't think so, as explained below:

under condition (@dev->power.subsys_data != NULL), the API does
not need to do kzalloc() and should always return 0 (success).

but it actually does *unnecessary* kzalloc() and have below impact
shown:

if (kzalloc() is successfully)
	it will degrade the API's performance
else
        it changed the API's return value to -ENOMEM from 0, that
        will impact caller's logic.

>> - it will return -ENOMEM if the kzalloc() fails, that is wrong
>>   since the kzalloc() is not needed.
> 
> But it's ok to return the proper error if the system is that broken.
> >>
>> Fixed by not doing kzalloc() and returning 0 for the condition.
>>
>> Fixes: ef27bed1870d ("PM: Reference counting of power.subsys_data")
>> Cc: stable@vger.kernel.org
> 
> Why is this relevant for stable kernels?
> 

it has impact related to performance and logic as explained above.

> thanks,
> 
> greg k-h


