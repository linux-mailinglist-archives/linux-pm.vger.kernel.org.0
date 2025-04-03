Return-Path: <linux-pm+bounces-24751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17276A7A095
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537131892AA3
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC01F2B87;
	Thu,  3 Apr 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mXRY4G7c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E73C0B;
	Thu,  3 Apr 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674489; cv=none; b=rBAYWihukySHQremKtgbeOj7RrtfbaCyi1MH3WjOBVDpS+BCtep71Im9aYfpaBmUBioezSb9IbyTUVPTLiaz3etX5mcyU2UErhFwTkTA6KUzX5Kj82O68qebKl93mxqgLF//OBNCSWeqwrjiOhmpGiTKRCi22BYRi6A86YGnSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674489; c=relaxed/simple;
	bh=o994RbWktyY+p2hEEkPv5mZWIlgw2IFFP2m+eReL0xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AEjeX4+ANT0ZYDKuZxDBJ7VplrZTj9nI2RnhGGD8jmG+o0K6xpcIebDfGvlBZnsGRwLSTPt77YVNNTQfki3KHUYs/tdiwmm3G56BvOHjf6YZeUqtpG/r80RPX7D4oBigzxxHBKb6G8xqHzG+csLw72aVB5Xt4fIcQ70w54PzCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mXRY4G7c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5339s1pA026803;
	Thu, 3 Apr 2025 10:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eoL7WgS6lhnK6j3Rk13IS3v6qWVWzwc/bcajn5AdMfQ=; b=mXRY4G7coIE4M9pj
	Yt2WeulGolGaAsYuRSafvy9Ssb4L99OvTvnkScOTIoNW903wOQT527RQbnDhHAzN
	6e4nEdyWYzacoPZf0BdKmiJFGjaUnaqM0EUaIdtmw6I6mDyGIfvJlRHqwTwpnu1Q
	JsFug+XD2HhM7MFcIhC6I9395l0TLdTrEBOt6kJyLXeKgpk7UwP6RcfD2/b9tcX2
	bqpWtyrDMrDtGacHTcc4+rM+CSYMNmS3i11SPbIoR/iW47IxXFEitf7KcrTaBPP+
	DXsHtObrFn2/L5XIw76T3onuUo2gjwIs2pmCXnZ0MrUsMC957qnLodBBUb7+3pt/
	syI6BQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45sc2ysp2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 10:01:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 533A1JhC012104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Apr 2025 10:01:19 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 3 Apr 2025
 03:01:17 -0700
Message-ID: <1988a6b2-4e25-42b9-8197-5599760c6755@quicinc.com>
Date: Thu, 3 Apr 2025 18:01:07 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: menu: Optimize bucket assignment when
 next_timer_ns equals KTIME_MAX
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250403092852.1072015-1-quic_zhonhan@quicinc.com>
 <0d420c47-f336-41c0-83df-066131338b49@arm.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <0d420c47-f336-41c0-83df-066131338b49@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=AMoviu7M c=1 sm=1 tr=0 ts=67ee5c70 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=7CQSdrXTAAAA:8 a=9GLfLwG9d9fP24aDl1QA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: zIsuUoJOGi4Ss1LYrwiMbmkH8pZN8SKR
X-Proofpoint-ORIG-GUID: zIsuUoJOGi4Ss1LYrwiMbmkH8pZN8SKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_04,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030034

On 4/3/2025 5:34 PM, Christian Loehle wrote:
> On 4/3/25 10:28, Zhongqiu Han wrote:
>> Directly assign the last bucket value instead of calling which_bucket()
>> when next_timer_ns equals KTIME_MAX, the largest possible value that
>> always falls into the last bucket. This avoids unnecessary calculations
>> and enhances performance.
>>
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> 
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> 
>> ---
>>   drivers/cpuidle/governors/menu.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index 39aa0aea61c6..8fc7fbed0052 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -255,7 +255,12 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>   		 */
>>   		data->next_timer_ns = KTIME_MAX;
>>   		delta_tick = TICK_NSEC / 2;
>> -		data->bucket = which_bucket(KTIME_MAX);
>> +		/*
>> +		 * Assign the last bucket value directly instead of calling
>> +		 * which_bucket(), since KTIME_MAX is the largest possible
>> +		 * value that always falls into the last bucket.
>> +		 */
> 
> comment almost seems overkill.
> 
>> +		data->bucket = BUCKETS - 1;
>>   	}
>>   
>>   	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
> 
Thanks Christian for the review~

Actually I just want to add a comment to indicate that which_bucket()
was once called here, in case which_bucket() changes in the future,
and however, we stayed with the original approach, leading to the
inconsistency.

Could you please review the comment below and let me know if it's okay
or if I should not add any log? Thanks a lot~

/* KTIME_MAX falls into the last bucket, skip which_bucket(). */



I will collect review comments before arise patch V2.


-- 
Thx and BRs,
Zhongqiu Han

