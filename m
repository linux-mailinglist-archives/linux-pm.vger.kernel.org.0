Return-Path: <linux-pm+bounces-20576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A64A14004
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D276164C2F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE822F38C;
	Thu, 16 Jan 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cEb4vf6I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482522FDEC;
	Thu, 16 Jan 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046530; cv=none; b=QLinUK4U/Ku3XxcfFhDyCTVPKWIHyZIhAuilsHhmuA4tcqttYWJ4bvbz4UTzTAB7u7a67aKRVYcQaPdftbWx9q50kLZeb7dTTBjiOvEXcWpeWtj5qfwCHzgIS0l6xd18vxUeisFoN0FOI/i3csP3ZoXrlZv30nn3zQHVq7+l6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046530; c=relaxed/simple;
	bh=qnXblKTf1c+FwyZuNpI6LKg7Uab0zIRehZTBm52aihg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=J6czYv3JmAb7+4X0WB7hdQB2ZrZrNjBklosRGn8/EeFd9nf/DgkiV5gqqgKV5tBEfBHpv0WFz9oPw6Id6AV7VTh6Ulrfw0TvMXLU9WxTWC45K018pu1YcQtjp5HYgyKRiGcT3ZrOs5neeQTmW3HF65QivZA1dnVzh32bECN4XZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cEb4vf6I; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GG66VI011091;
	Thu, 16 Jan 2025 10:55:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=q9PO5DyW8Sg+5Kz4f4cpBbijFk1+rVvFr4t2wwlOGVw=; b=
	cEb4vf6IdZ9XgChY4L+SLiyuVJr/H2ODfzzRT5Jnn6d+dZ3x0bxTKq3tn4FeG+8U
	YEXgbxtx3aBUoJ0guodC5eV3nzLJR8gHGzITVk+m6U4VPPCFZgWSORyAudBruBmN
	aOBEEOMrk6sMP9o2/V3ExZyf0Sn9HWXNvU/T8du7jVg6vdpLI0rohy3aFS7Ue6fi
	V6FqsyQArcMR9nuWOQv4urA3g+sD6CMIBV/XCChiDXTmAWAO8wAdu2hmjp6F7XDK
	QN87Ez6saoV84wzjqJaboRYwB5zBn1hUN3fsdcOLopb6KY+Pb2T5nhaIAdATBsPx
	e0ahpiaNpODgF5Ud17IKXQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 443nxmed58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 10:55:06 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 16 Jan
 2025 16:55:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 16 Jan 2025 16:55:05 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 07119822562;
	Thu, 16 Jan 2025 16:55:05 +0000 (UTC)
Message-ID: <9f0c1792-a569-41c0-9e90-e52717185359@opensource.cirrus.com>
Date: Thu, 16 Jan 2025 16:55:05 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/1] PM: Revert "Add EXPORT macros for exporting PM
 functions"
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@ucw.cz>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5URJxs1U1wGE8AkV2SXp5up5-R5X4sqX
X-Authority-Analysis: v=2.4 cv=Q6Eo452a c=1 sm=1 tr=0 ts=678939ea cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=QyXUC8HyAAAA:8 a=dZKopcQFyAn5TvwnyDAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EKj1Qd2cE-dHkT0nzreX:22
X-Proofpoint-ORIG-GUID: 5URJxs1U1wGE8AkV2SXp5up5-R5X4sqX
X-Proofpoint-Spam-Reason: safe

On 16/01/2025 4:09 pm, Rafael J. Wysocki wrote:
> On Thu, Jan 16, 2025 at 4:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> The introduced macros are not doing what they intend for, namely
>> they won't eliminate the code when CONFIG_PM=n.
> 
> I don't think they have ever been expected to eliminate the code then.
> They just don't export the symbols in that case.
> 
>> Also there were no users of them for all this time.
>

I had code changes to use them but they got lost at the bottom of a long
backlog of other commits and have never been upstreamed. Removing these
macros is fine with me.

(apologies if you get this msg twice, there was a problem with email)

> This actually is a good argument for dropping stuff.
> 
>> Drop them for good and to avoid possible misleading.
>>
>> This reverts commit 41a337b40e983db4f0e1602308109f2b93687a06.
>>
>> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> v2: elaborated commit message (Greg), Cc'ed to the original author
>>   include/linux/pm.h | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index 08c37b83fea8..5dae93817141 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -384,12 +384,8 @@ const struct dev_pm_ops name = { \
>>
>>   #ifdef CONFIG_PM
>>   #define _EXPORT_DEV_PM_OPS(name, license, ns)          _EXPORT_PM_OPS(name, license, ns)
>> -#define EXPORT_PM_FN_GPL(name)                         EXPORT_SYMBOL_GPL(name)
>> -#define EXPORT_PM_FN_NS_GPL(name, ns)                  EXPORT_SYMBOL_NS_GPL(name, "ns")
>>   #else
>>   #define _EXPORT_DEV_PM_OPS(name, license, ns)          _DISCARD_PM_OPS(name, license, ns)
>> -#define EXPORT_PM_FN_GPL(name)
>> -#define EXPORT_PM_FN_NS_GPL(name, ns)
>>   #endif
>>
>>   #ifdef CONFIG_PM_SLEEP
>> --


