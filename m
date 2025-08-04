Return-Path: <linux-pm+bounces-31875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8549FB1A0CB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065FA16A598
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6502417D1;
	Mon,  4 Aug 2025 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IflWdWk7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77FE22097;
	Mon,  4 Aug 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308726; cv=none; b=NR3B3+jWk79UWEgeetdTiXykXBowR4XVmnOi3trI8W8Uye5535PiZ3r4ZHUhmTt61/AfrUzZRHiYFXWo92vKuL/6JcQJ7wL8SongpC9NW2lCUO7Zi51TqDlKMXn/ekivj+159+Danq8Sl1ewaI93Ca+vA2edvklzIaoUaW1OII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308726; c=relaxed/simple;
	bh=yEm+bH9728VNoGP0jXtlopVfvkRICGLpckfA5yJFVI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mwC1uRQx8tIxcO8JS/2LBWqqiGcIlJwiRPQHV2+25+y9h3APAbdhCVkbH2N/OPKCMAVa5WKatvJNx+2JHqnYA1QN6amBx2ZRwEkN4WjPWBAgH0uTgoz1ymhMTSxEnTMezirj63DbDSgYhUvdWYVhf/y/UlLuBBtfqAmUY9sUcLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IflWdWk7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5745apxY023987;
	Mon, 4 Aug 2025 11:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wbcNApL+vnGS0SsubMFQWrTdUK892sGvXkVi1Vdn6qw=; b=IflWdWk7UWaE9o34
	816szCZLe3EfESChAEkxard060rV4COSmtBAJdeWs6SnKSg7/X3UhH2V3aT90vV2
	PsiTT7yF3cKBmoeaAQDbmd9sa6QKBsZt7fDAv5wmaMJU1hej5m7XCY4pWGr3YIoW
	GZpqfhhR1yi+xTR5VqhChD5P/4F26xxUKpRXUzt5wa+q6woxBb8ZI6HtYVbaaBdx
	4veyoEaEUAhxk9vxu3R+j1nLgC3851tew6BZPeXWSCgFJO9JKFpfuHBBo0KwcG2c
	et6KVv+njLnELKKRLkvM+QjU++tXodIUKC5bUZZCznQ4gxADaGzM52Xf/ZWu8sCe
	yOHzDA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rn433-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 11:58:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 574BwToT030408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 11:58:29 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 4 Aug
 2025 04:58:26 -0700
Message-ID: <c1eb8133-8b26-4b53-b0a8-2df9c190d5d9@quicinc.com>
Date: Mon, 4 Aug 2025 19:58:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] Documentation: PM: QoS: Fix return type and return
 value description
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <pavel@kernel.org>, <tony.luck@intel.com>,
        <reinette.chatre@intel.com>, <Dave.Martin@arm.com>,
        <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhongqiu Han
	<quic_zhonhan@quicinc.com>
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <20250721124104.806120-5-quic_zhonhan@quicinc.com>
 <04333423-56d8-4c4f-a5fe-143b179cdd43@arm.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <04333423-56d8-4c4f-a5fe-143b179cdd43@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U7jDeN8b1MFIBJDUvgcNAs_W2Vg91yxG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2NSBTYWx0ZWRfXzI0tiBvXxXMu
 skxZN0MTxx2Ivn0P5MDk24EIBMAdgvJrB50Onx1uXiefIB7Cp4GwPJUk7qU3th4ws6bFCmwr4GZ
 4bkChRXAqvf6HtvDx/eOVGsZVKWatzK3c1Nn4EaUdTZfzf5mBft/XF0qid0vh2a51L1MMHY0kXd
 TYxI3IaZj8Ew7MyCq1R0o27OPXLc1aeBqegRJGbFAEpYGWehD7zjyp6L/vpyqNSMMlpaV0bKHga
 uy9eHxGdAqMvyBNuII4QzyNrwfNN95qU48OtIWErcIKoYsBKUL9CmgUrcOk3emL4YkW6R9XOkOk
 +rgFHJhhUp1AiAZn+rlPjYd5BQSgbeMFbrVk4eVA4QJtLktpzaUViSI90WzQjZqSXA2fY3z7cOK
 OOT75AkX6gZghBo5jaYdMKbbEEo/+4Ql5DrlZHbuAata7x2ZmD/fpj+rMnrHjbJ8rsoKFRtU
X-Proofpoint-GUID: U7jDeN8b1MFIBJDUvgcNAs_W2Vg91yxG
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6890a066 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=7CQSdrXTAAAA:8 a=QbBbMRH77cCVxdqEmXYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040065

On 8/1/2025 7:27 PM, Christian Loehle wrote:
> On 7/21/25 13:41, Zhongqiu Han wrote:
>> The documentation for cpu_latency_qos_request_active() incorrectly stated
>> the return type as 'int' instead of 'bool', and the return value
>> description was incomplete. This patch corrects the return type and
>> clarifies the return value semantics.
>>
>> Fixes: b8e6e27c626e ("Documentation: PM: QoS: Update to reflect previous code changes")
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>>   Documentation/power/pm_qos_interface.rst | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
>> index 1ede4cafc2e3..c6b8b9cda166 100644
>> --- a/Documentation/power/pm_qos_interface.rst
>> +++ b/Documentation/power/pm_qos_interface.rst
>> @@ -55,9 +55,9 @@ void cpu_latency_qos_remove_request(handle):
>>   int cpu_latency_qos_limit():
>>     Returns the aggregated value for the CPU latency QoS.
>>   
>> -int cpu_latency_qos_request_active(handle):
>> -  Returns if the request is still active, i.e. it has not been removed from the
>> -  CPU latency QoS list.
>> +bool cpu_latency_qos_request_active(handle):
>> +  Returns true if the request is still active, i.e. it has not been removed from
>> +  the CPU latency QoS list.
>>   
>>   
>>   From user space:
> 
> I guess this should be swapped in the series with patch 3? (First fix old, then add
> new?)
> Anyway it applies in and of itself.
> 
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> 
Thanks Christian for the review~

Seems swapping the patches might help prevent misunderstanding and make 
the sequence clearer, if needed, I can swap them.

-- 
Thx and BRs,
Zhongqiu Han

