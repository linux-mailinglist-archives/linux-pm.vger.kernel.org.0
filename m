Return-Path: <linux-pm+bounces-26552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB17AA6C1F
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 10:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6491C4A03DF
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 08:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE0266EFF;
	Fri,  2 May 2025 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l9Sh3eQN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79A1B87C9;
	Fri,  2 May 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746172932; cv=none; b=DYs0nV73oc+Q/GpUDFmfO61DtrR3nra/ZylDQ1+0T2Kkr5yhaPQJPRJFX8yYFEL0njL5NBQomwDcFZelfxs+/8VIs5i7qQpTfgQoVDi2ZpL3TwYF50OVMKrnAZGujZ30/kpuu6r2fMEAT+LGFLTbgStQs3lEOfMBTfDuZRek/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746172932; c=relaxed/simple;
	bh=vCWvamB+zFqbzDOsH+zCGRRCQAtnH9b4dE/DMVPQm+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P+RJoSAkOYa61tMpzwt63O6/sV80VGks1F6zTKVmDoz97IzKQribiBYhywQyJc5xI1L7jau0FdKfgtAD2rNAwVPDogJzsVDfgMv3+RqVBr/nHf6mdGvZBeS+uyxXEl+mMTJwN6ElWxzALFpAG4aXNV+TTjwHxmFHaA6OshJs1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l9Sh3eQN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421Mxtt001951;
	Fri, 2 May 2025 08:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l0WuTAuqkbWgRLgrURTJzgvRm/uvGTGu6o6gety2PYE=; b=l9Sh3eQNH+szTU16
	N7dJw+2xo5JRwpTVgNV7iCxmdLMyhBfMja10AS1nV+dhUzhac7iDTcC6lQl7CDZk
	zddViNZVGDUhU2BAxg0bGYmeIYTOYEOvzzpjte4I18tyg/TlEnLAWXhel9xsjb5w
	S6Z+X+5zc88xh08i2+s03GjLv8zH6KL1zvIb2jUgisPa5azeRYbqNd6YWXnWbAci
	iZEa2Zb2fEJoLNbWOtMi+m18jbrc9zaI5VM+7dcZhLbe8EZvUdAuB9VvQsO4bC9C
	4xu15TIMAsZtTcVzEG0nsZxneXwF8hbC0fIxjYDi50BoNJwHHp0DP5o93ecT2OAI
	LYu0HQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u77muf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 08:02:04 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5428232d014302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 08:02:03 GMT
Received: from [10.216.18.87] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 May 2025
 01:01:55 -0700
Message-ID: <8ba02745-378b-4264-883a-b99764701d0b@quicinc.com>
Date: Fri, 2 May 2025 13:31:52 +0530
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2MSBTYWx0ZWRfX9m26AhuV2W+P X++8su1BdTOLe1ZQBLo/uyk+qvdNaY3jBwRvtgQ8Hw/C5MtfEXsY5smoI1Bpfb30Nft9FKQfGTD ayC/7O08pEi50gydCWZrTk7efGHNvSHkp2m0z92WfYrRtjKcmHj8J9oue/RYZIDmMuT6nIP+EW0
 lMSPe5Ihs17l6tHC0HpDEQvDYPbQissWiIkSBB9tMtdE1E5rPaqBuNqvQEFwzgYcKxliOaJpR45 MRXMbN2G30CuCpQkFGvnlmN+V0tZeFBkM0rfgWoTfVaVLaNFaJtK1B5NjiR9bKmqHHn+rDxErEG /JUlL6rXDedL4qRwmprFQiAlR7D8PRRg0CeERmr3WkgphXRL+OMiYlmzyl/hUuDicbSDiIbBq0a
 XftxH8eC+5mzryKDkjDg877IQzY/57IvV0DNbD5X3zCW8vmwv1qvW/zxy6jAw0kTet6gbd5t
X-Proofpoint-GUID: 8pq0VHEWe_BDiX3p7WX7e54Myn9feELg
X-Authority-Analysis: v=2.4 cv=W404VQWk c=1 sm=1 tr=0 ts=68147bfc cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=pLippShZzUuVUgE2s9MA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8pq0VHEWe_BDiX3p7WX7e54Myn9feELg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020061

HI Viresh

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
> over latest changes in the OPP core.
>
> I modified it and applied the below version to my tree now.

Shall i keep commit as you suggested with your SIB.

Thanks,

Praveen

>

