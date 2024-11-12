Return-Path: <linux-pm+bounces-17420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2C19C5B30
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE2E281418
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7E2022C2;
	Tue, 12 Nov 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Xu+Rt82N"
X-Original-To: linux-pm@vger.kernel.org
Received: from ms11p00im-qufo17281601.me.com (ms11p00im-qufo17281601.me.com [17.58.38.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB820127D
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423518; cv=none; b=gvZoJHOXEpIcr/ji626OOAoZqXu4iU0IVX3wT90fcK4YaTiED4GLNCO7tYFzTU5dvjqpY2XjLwQVwb9hUEJdokHXUa+fUxZdaHRaWsblw5Rx9ejzg5ccM5hIvT584PbO93psSkFb90tEWCKxzeC1JM71cZSo9H3nXWoy6HQRGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423518; c=relaxed/simple;
	bh=yRmtPN0TFHkU99Flp+fEchW2OsR8PBdDUPKHR2odiLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3kSKcILlj2QU9dV7intxJH2cLn9Y5oy6GPV4+XbiU43QGTsHPyYZzrizJQZzdMaT4MuEux8a+L9VEAkUaKp7M1fQdseeXAOlxKW7O1oK94F0/1y7Ri1pe042yQ8lfB2xjEashwSUhIO97e5yAhKazauIEd4zY+DVwhp0nix2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Xu+Rt82N; arc=none smtp.client-ip=17.58.38.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731423516;
	bh=Eh44U3KL7qWcwQYFzXUwloAPncqESfrGkSg2LByutzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=Xu+Rt82NWGawAyXcrKqEmFdwZC5k+gTO5JOqa3bSrzaWqn1fFShXHLV9r6lg/9Yk2
	 sT8svgev72ExV2fA/yzfehaNCzBJep1PkNN/M11mcVqFhNkx7cVxMhC6rVIV8FX+Q/
	 KFMAyG+5dBouzUKoqcuKluy2wEAzynME2DsUpf0fNPj3ywBtxnpA0cJJrV/clGbUew
	 uBLz5DFK/MdgYFRDmQCtSsridVTsz6g4T64oc7lgPIewyCNVHi2CG39q9UIEyS7w4H
	 kxsGMUGacUM0O7tEwDQJVaZzRWVp3XdjlIcS7FZK00NSJvxCGkOplreNIF82YIvKy/
	 kZBsCu+QqaEuw==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17281601.me.com (Postfix) with ESMTPSA id DD7FFAA00C9;
	Tue, 12 Nov 2024 14:58:32 +0000 (UTC)
Message-ID: <2682bae5-9ae6-4781-8d57-47587084a58f@icloud.com>
Date: Tue, 12 Nov 2024 22:58:29 +0800
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
X-Proofpoint-GUID: 0ab2Ysty0ejJwHjOS-IKdzmmv4mTLVK4
X-Proofpoint-ORIG-GUID: 0ab2Ysty0ejJwHjOS-IKdzmmv4mTLVK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=905 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411120120

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

yes.

> 
>> - it will return -ENOMEM if the kzalloc() fails, that is wrong
>>   since the kzalloc() is not needed.
> 
> But it's ok to return the proper error if the system is that broken.

IMO, the API should return 0 (success) instead of -ENOMEM since it does
not need to do kzalloc().

Different return value should impact caller's logic.

> 
>>
>> Fixed by not doing kzalloc() and returning 0 for the condition.
>>
>> Fixes: ef27bed1870d ("PM: Reference counting of power.subsys_data")
>> Cc: stable@vger.kernel.org
> 
> Why is this relevant for stable kernels?

you can remove both Fix and stable tag directly if you like this change.(^^)

> 
> thanks,
> 
> greg k-h


