Return-Path: <linux-pm+bounces-26550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0106AA6BC5
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 09:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285F73AFA28
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 07:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E182676E6;
	Fri,  2 May 2025 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RbORFC7n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1319C253324;
	Fri,  2 May 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171472; cv=none; b=l1EVdFpdAo9ma7N2EemxvemRSn8lIiqXBDzXNGLZ0mwLJ+rsnhg0QheG+wOyZA+jWECbnOmsGRgvWimToKU13QvXrkcHPyU5pfQg/UZ631jyIcaT9UQmPL9Y5VW7/D01Xyk4TuLzFCKuNbZdc4Ah6IaJ6x3ky4tFKpAGrKNcuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171472; c=relaxed/simple;
	bh=agbvgyrGl+TBT7C8n1D5AKZSi7AVfqShVIdXyQcDkH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=llk6B1gKukcguYMtt6XlTR7CeT3IKCywgCjFRJYguq6tQjxiIB4tE0d8Jm2Q+1LLVty4Nt6ZKgx3K7X8Bp7DQeN2MrvQeNgdnO9lWYNNNtGkWNpyag0CNtg9fI34xY8ccmhoFteW7B32cpNdbc6AdyuX+0KDxckP23qXznUuGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RbORFC7n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421NHse015251;
	Fri, 2 May 2025 07:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zu+Hb+CVAoyO+KdtfrNp2BOt+4pQRVp0db4DBgtZrDw=; b=RbORFC7n9ev7V8Ds
	e3NkpkSqtpboc/9zNQLxn2UnyGg+dXeLe8zBaqbT9pN6Mt1KQN86JnkT/wfb5e6K
	9YV7v9CcFC+JyZ//o3HZuXxC/xetVW4C3gELV+Cv+xhJJqih58iDwF/V8CtgMGzr
	vCzLwJmRZAsqcNCnc5UDFFzNZXh2t2ZxE2mSqLD+YINUNLaPNi/bxDHjxLmwoRh+
	SFnirsRqWbiJbde3K7pbhj+Ev/F3oGNFg+wbzIGRDNVcYN1wFmbqTf5t98cy9nhI
	s+y2W3L8qtal39rELrFoQ+SAWD05atXWr2ekQCZhqgp86p+cVmzzJOSVb40RQpGH
	a8MaDg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6uayfmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 07:37:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5427bhPv001222
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 07:37:43 GMT
Received: from [10.216.18.87] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 May 2025
 00:37:36 -0700
Message-ID: <e72aeda8-035d-4144-a9ce-ae276bca87bf@quicinc.com>
Date: Fri, 2 May 2025 13:07:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] opp: add new helper API dev_pm_opp_set_level()
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <psodagud@quicinc.com>,
        <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-2-quic_ptalari@quicinc.com>
 <20250502053758.utawzhq6famwenc2@vireshk-i7>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20250502053758.utawzhq6famwenc2@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8LF-cETM9CLSq0X51y9q-pef9javSjYK
X-Authority-Analysis: v=2.4 cv=KtlN2XWN c=1 sm=1 tr=0 ts=68147649 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=pLippShZzUuVUgE2s9MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8LF-cETM9CLSq0X51y9q-pef9javSjYK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA1OCBTYWx0ZWRfX2J7kak+qqEEN QoVKYFamX0DMmsWDVCNTcPGHFbFxUr2uC/RTJv8R5MDfTl9UoaVDE38mdYm47bVY5WBNv4LHpt7 RuiIFAIt7zZnBMfc+ZqDEi6XhMuWXD3r7KhOh0b1C+xv1d7YFmOGOnbhRbFCnSHPZhkroaPJdk7
 e8YexEs5iG+4Kl8blHloQjKK5560KSJbQvA9FSvJSdE8xfB2IcUoxjltISqJYFBYx1/MB8ANicT jT9Hd27cqETDnriK4kL1h0vJnLzL4idYUmwTRYB/PK5caDl2pNVYfX3mDp/zWmwxHqsXoGeH14n GHSlFNeGbSj22p9eQ2X1jPUjd4FJ95l4iIqK5ZUQ4xZDN1jPI4/s5t2UuLcmUUoHrMR0tvHoLK4
 op5YZWmY3lV25yUe6uXKnFCrZkczlmgeDKq75iZBx/4nRpZFT9iQlf6z5VHKxLoZI8VrL3JQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020058

Hi Viresh

Thank you for review.

On 5/2/2025 11:07 AM, Viresh Kumar wrote:
> On 02-05-25, 08:40, Praveen Talari wrote:
>> To configure a device to a specific performance level, consumer drivers
>> currently need to determine the OPP based on the exact level and then
>> set it, resulting in code duplication across drivers.
>>
>> The new helper API, dev_pm_opp_set_level(), addresses this issue by
>> providing a streamlined method for consumer drivers to find and set the
>> OPP based on the desired performance level, thereby eliminating
>> redundancy.
>>
>> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
>>
>> v2 -> v3
>> - moved function defination to pm_opp.h from core.c with inline
>> - updated return value with IS_ERR(opp)
>>
>> v1 -> v2
>> - reorder sequence of tags in commit text
> As Trilok mentioned, this is not the right place for this.
>
>> ---
>>   include/linux/pm_opp.h | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
>> index e7b5c602c92f..31ed8a7b554e 100644
>> --- a/include/linux/pm_opp.h
>> +++ b/include/linux/pm_opp.h
>> @@ -197,6 +197,28 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>>   void dev_pm_opp_remove_table(struct device *dev);
>>   void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
>>   int dev_pm_opp_sync_regulators(struct device *dev);
>> +
>> +/*
>> + * dev_pm_opp_set_level() - Configure device for a level
>> + * @dev: device for which we do this operation
>> + * @level: level to set to
>> + *
>> + * Return: 0 on success, a non-zero value if there is an error otherwise.
>> + */
> No need of these for simple wrappers.
>
>> +static inline int dev_pm_opp_set_level(struct device *dev, unsigned int level)
>> +{
>> +	struct dev_pm_opp *opp = dev_pm_opp_find_level_exact(dev, level);
>> +	int ret;
>> +
>> +	if (IS_ERR(opp))
>> +		return IS_ERR(opp);
> IS_ERR is wrong here, should be PTR_ERR.
>
>> +
>> +	ret = dev_pm_opp_set_opp(dev, opp);
>> +	dev_pm_opp_put(opp);
>> +
>> +	return ret;
>> +}
>> +
>>   #else
>>   static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
>>   {
>> @@ -461,6 +483,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
>>   	return -EOPNOTSUPP;
>>   }
>>   
>> +static inline int dev_pm_opp_set_level(struct device *dev, unsigned int level)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
> No need of these too for such wrappers. And then this isn't rebased
How come? i have synced  linux-next today itself and pushed from it, 
even i didn't face any issue.
Let me know how/where rebased i.e linux-next or linux?
> over latest changes in the OPP core.
>
> I modified it and applied the below version to my tree now.
>

