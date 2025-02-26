Return-Path: <linux-pm+bounces-22987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A64A45C4D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 11:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60A41756A4
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212A269B13;
	Wed, 26 Feb 2025 10:54:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354624E01A;
	Wed, 26 Feb 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567283; cv=none; b=CZ0amb6ee6FLZBeu2FerVSA4iJ2E+eyDocEwLKPDy6vzNijwFUIMnDSUcnoqV9PE9DnK+CwlP6ZZbltj7Gv6jweF/+JhFzM51bZsIkirf8CJI+NFRPEXy26c/s3VFqKa4sITFao1wdsEGYD/C1aAKmflSJfOz1QQbOEea5kePi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567283; c=relaxed/simple;
	bh=koG82KQ5MAFZbbOnQch9i9ot+SNWC3tiYmyye7wwNLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5/pqYub49s7UUlq9LginRYY35/7AXdHecZH8C0U/LqmlzqtUomo4FJfo/CUYNHk/JqnHxk+jR8rsDchL0sGhfcMK1COibgvb+xWvl0xhgHe+Fyi+jp1zdh/BMQPoNOZ8VzNAH8yAafW1AYZje+Y4Lj6iGRV4+9ULb57SHxFSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6437D1BA8;
	Wed, 26 Feb 2025 02:54:56 -0800 (PST)
Received: from [192.168.102.177] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380203F673;
	Wed, 26 Feb 2025 02:54:38 -0800 (PST)
Message-ID: <bc7f915b-8d9f-4e05-9939-8b7ecc078f85@arm.com>
Date: Wed, 26 Feb 2025 10:54:29 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <d0c013d5d2a9251d5dc468446f2a08ae8a7a8953.camel@linux.ibm.com>
 <f949565ef1f256a1641cea3fa1d01d126bcc32e8.camel@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <f949565ef1f256a1641cea3fa1d01d126bcc32e8.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/26/25 04:49, Aboorva Devarajan wrote:
> On Mon, 2025-02-24 at 11:57 +0530, Aboorva Devarajan wrote:
>> On Thu, 2025-02-06 at 15:21 +0100, Rafael J. Wysocki wrote:
>>
>>
>>
>>
>> So for the entire series:
>>
>> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>
>> I'm also trying a minimal unit fuzz-test with the pre- and post- patched version of the get_typical_interval 
>> function to understand this better, will post the results soon.
>>
>>
> In addition to the previous tests, I also reviewed and tested how get_typical_interval
> predicts the idle duration before and after the patch by mimicking the function in
> userspace for better unit fuzz testing [1].
> 
> With the patch get_typical_interval function now produces more predictable values, whereas
> in the previous implementation it frequently returned UINT_MAX. The behavior with the patch
> seems to be more reasonable compared to before.  
> 
> Here are the test results  
> 
> 1. Low Variance:
> 
> When the history of CPU idle durations (8 intervals) is relatively uniform with low variance,
> the predicted idle duration is unchanged between the patched and unpatched versions:  
> 
> | Test Case | Intervals                                    | Before | After | Difference |
> |-----------|----------------------------------------------|--------|-------|------------|
> | 1         | 100,105,110,115,120,125,130,135              | 117    | 117   | 0          |
> | 2         | 200,205,210,215,220,225,230,235              | 217    | 217   | 0          |
> | 3         | 500,505,510,515,520,525,530,535              | 517    | 517   | 0          |
> | 4         | 1000,1005,1010,1015,1020,1025,1030,1035      | 1017   | 1017  | 0          |
> 
>  2. High Variance
>  
> For cases with high variance, the nonpatched function returned UINT_MAX,
> 
> After the patch, the function now returns reasonable values:  
> 
> | Test Case | Intervals                                  | Before      | After | Difference       |
> |-----------|--------------------------------------------|-------------|-------|------------------|
> | 5         | 99,198,297,396,495,594,693,792             | 4294967295  | 594   | -4294966701      |
> | 6         | 1000,2000,3000,4000,5000,6000,7000,8000    | 4294967295  | 6000  | -4294961295      |
> | 7         | 40,140,240,340,440,540,640,740             | 4294967295  | 540   | -4294966755      |
> | 8         | 90,590,1090,1590,2090,2590,3090,3590       | 4294967295  | 2590  | -4294964705      |
> | 9         | 42,142,242,342,442,542,642,742             | 4294967295  | 542   | -4294966753      |
> | 10        | 70,570,1070,1570,2070,2570,3070,3570       | 4294967295  | 2570  | -4294964725      |
> | 11        | 44,144,244,344,444,544,644,744             | 4294967295  | 544   | -4294966751      |

So these are all "highest observed values after dropping high-end outliers" from what I can tell.

> 
>  3. Low-end Outliers 
> 
> The patch removes variance from low-end values as well,
> Without the patch, the function only filtered high-end outliers, but now it correctly eliminates both
> high and low ends.
> 
> | Test Case | Intervals                                 | Before      | After | Difference  |
> |-----------|-------------------------------------------|-------------|-------|-------------|
> | 12        | 1,200,200,250,250,230,220,260             | 4294967295  | 230   | -4294967065 |
> | 13        | 100000,200,200,250,250,230,220,260        | 230         | 230   | 0           |
> 
> 
>  4. As far as I understand, the function only returns UINT_MAX when all values are 0, negative, or the
> computed average itself is UINT_MAX.  
> 
> | Test Case | Intervals                                   | Before      | After       | Difference |
> |-----------|---------------------------------------------|-------------|-------------|------------|
> | 14        | 4294967295,4294967295,4294967295,4294967295 | 4294967295  | 4294967295  | 0          |
> | 15        | 0,0,0,0,0,0,0,0                             | 4294967295  | 4294967295  | 0          |
> 
> The updated get_typical_interval function avoids unnecessary UINT_MAX returns, handles both low and high end
> outliers, and gives more reliable predictions in high-variance cases. It only returns UINT_MAX when absolutely
> necessary, and this will help in not selecting deeper idle state unless it is needed. So, I'm good with
> the patch. 
> 
> Refer [2] for more test results.
> 
> [1] - https://github.com/AboorvaDevarajan/linux-utils/blob/main/cpuidle/cpuidle-predict-duration/predict_cpuidle_interval.c
> [2] - https://github.com/AboorvaDevarajan/linux-utils/blob/main/cpuidle/cpuidle-predict-duration/out.predict.csv
> 
> 
> Thanks,
> Aboorva

Thank you Aboorva, that's very useful.
Looks all good and as expected to me then.


