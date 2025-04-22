Return-Path: <linux-pm+bounces-25935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91443A97356
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 19:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4563AAEE7
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B50A29617B;
	Tue, 22 Apr 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jEZ+8Lj6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5313C3F6;
	Tue, 22 Apr 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341664; cv=none; b=Gi9YErjWwCiZdpBB3hx1aVkoFOaPqZSm58iWoCmR3eyCUTIR0BexSnldPEZrRd4bIvRjegpT45I+52yLCvl85XW8+9WZrY98cZWkGD7n3xoApXHn04aSM1b3HKXcbLdcZpql8c7rR+oYFn9aroq0uhJUaY3WuXsbex8CWogjgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341664; c=relaxed/simple;
	bh=wP2HHciPUmMSwT9dbn/j099qBVn4wnF7b816IwB20Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BJa2rfRSOeTvw70pcImoN0Jma6wnzSvus3edf/VhIz6hwQ3oKNmaiqYbYSzY7po4uJCvseQIf+sT14wMU73XRmJbaiAnpCtqnWQpOhZzjftSHip4gvE/jgPudW8rNGTzs0lidLFxi0P4WUFU69588MRU+Kg+FehGLm8cTvV+HhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jEZ+8Lj6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MCF4iH023288;
	Tue, 22 Apr 2025 17:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UxGbEsZ+4E8+fRBWB7/h7y9QN0FggykMGW/XC4EIPhY=; b=jEZ+8Lj6vmtgSKBa
	Po/Q3MCmIHLU3cO0SVOzLwGhchb6B8orJtwXzVS23NMPr0Zunhg176zP9UE6qFTD
	7Sd237PCseUfKIVirCvkavT8XGojrIMnOuaMu5z6Q6S72QTUni2nRfFkv5RrPL60
	PQhrlsQbKqmKPtKGOflfWpZ3UupAMwB0OmW0eMyrklo4TIWnahiuPGQyryN7WxCX
	BGvG+8IgoOj51iDDEpDytsddjnJwGAon1wn3ZMLK4f6s1/V7b9sRiSFfJrGQvyrm
	S2Tw1AxUBkGYm7OaAkQrBukNzplGcXO3U6TStRRLOMlijGblrdfSkn0rlbS6+8Bu
	2AScZA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4642svgg8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 17:07:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53MH7ZDY028289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 17:07:35 GMT
Received: from [10.216.54.177] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Apr
 2025 10:07:29 -0700
Message-ID: <e6e1ee6d-a12f-4e18-b2d7-65d1ccca5308@quicinc.com>
Date: Tue, 22 Apr 2025 22:37:25 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] opp: add new helper API dev_pm_opp_set_level()
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
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
 <20250418151235.27787-2-quic_ptalari@quicinc.com>
 <20250421074004.yttb42qq4p5xzi3o@vireshk-i7>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20250421074004.yttb42qq4p5xzi3o@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YyWBJ9dLmEkULWUMr6Ar_Yy3ZGwS2WyF
X-Proofpoint-ORIG-GUID: YyWBJ9dLmEkULWUMr6Ar_Yy3ZGwS2WyF
X-Authority-Analysis: v=2.4 cv=QLJoRhLL c=1 sm=1 tr=0 ts=6807ccd8 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=aDFI50vaQ4pevssQf7UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_08,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220129

Thank viresh for review.

On 4/21/2025 1:10 PM, Viresh Kumar wrote:
> On 18-04-25, 20:42, Praveen Talari wrote:
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 73e9a3b2f29b..a9bca9502f71 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -3151,3 +3151,25 @@ void dev_pm_opp_remove_table(struct device *dev)
>>   	dev_pm_opp_put_opp_table(opp_table);
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
>> +
>> +/*
>> + * dev_pm_opp_set_level() - Configure device for a level
>> + * @dev: device for which we do this operation
>> + * @level: level to set to
>> + *
>> + * Return: 0 on success, a negative error number otherwise.
>> + */
>> +int dev_pm_opp_set_level(struct device *dev, unsigned int level)
> I would rather move this to pm_opp.h as an inline helper.

most of helper APIs in core.c and even i don't see any helper API in 
pm_opp.c.

please let me know if you still need to add in pm_opp.h.

>
>> +{
>> +	struct dev_pm_opp *opp = dev_pm_opp_find_level_exact(dev, level);
>> +	int ret;
>> +
>> +	if (IS_ERR(opp))
>> +		return -EINVAL;
> Why not reuse the same error value ?

as reference of APIs in core.c, i have used  -EINVAl instead of IS_ERR(opp).

Let me know your thoughts on return value.

>
>> +
>> +	ret = dev_pm_opp_set_opp(dev, opp);
>> +	dev_pm_opp_put(opp);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_level);
> Make the changes and send it separately (or with the series, your
> choice), I will apply it to the OPP tree. Thanks.
>

