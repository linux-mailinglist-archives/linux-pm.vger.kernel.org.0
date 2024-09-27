Return-Path: <linux-pm+bounces-14875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFF988400
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D081F227BA
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5B918BBB6;
	Fri, 27 Sep 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EFdPci6j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE115A87A;
	Fri, 27 Sep 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439382; cv=none; b=qheMi799pyCgb+YDbXEYBoDD5W2ec0VR0j1FJTkfWLTGFq6Ti4OkQ0mfqEzylpEzUH0IRaIp4rKqELGS9xt97xF8FujJjiIxenUJQLbrGiZbheacG+CWYTl+YywOngnoZrve7NVNB0CoRF5pFRK5ii3H9uj5pdAhQqsjWj0FCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439382; c=relaxed/simple;
	bh=pv6CmIIw14k8Hkt/mqI0k9GCbM84nlA/MMsvYdxJR+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nXT/GcvBy+SE0VW1XxHEBUTIK7ufXGu6i0WcJfue4FI28LsUstuSM8BeqeqayTInVwm/Q/dY+cURVNd3LSqwEECGDAe4zJvYP1+AgS7o369n9esKidE0tzBTx8EDn43Sb1QblqO4jNezC0KGvKc+uvGWOHdkglrVxo2PHEBucAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EFdPci6j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6Mm1F002811;
	Fri, 27 Sep 2024 12:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AFkHHNoDffm+ilQ9K3LVxcYIBvq03xaAxPmXvLpvmZM=; b=EFdPci6jgroHclah
	/qNPismZIh6ua9iCxvpm/hgpcwG3KwWzHIvJAFtijdPpM/QOAG8arnEWGCeLNijc
	AZJ4/jRau40joDRA32pxDxXqofm665FfDENgV6aW7jvHFWFHqwUHBjz54cxtgNP3
	Rrv0UJEyzgvvvAQXT/KTj0wnjWhOIWJeFj3C3PiloQ0JQW4BlEg2bvkOUj8TjBwA
	ocCSKMsvOc9/Mxe70DF7IOIHoS9Zon6Q3UX/y7zKrHA5Oz/nlzgGVKX65NGH4U06
	c5RkxoNc7bA6aBd7EBj99IVPS8xJRHQpwsLkdcEiodIBn3i04DOqxQmeyN8T+LGu
	qYHpLw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqaktga3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:16:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RCGGVM029251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 12:16:16 GMT
Received: from [10.231.207.28] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 27 Sep
 2024 05:16:10 -0700
Message-ID: <a0c4ba44-8cd3-419e-89cc-0c9cbfcbfda5@quicinc.com>
Date: Fri, 27 Sep 2024 20:16:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document qcs615 RPMh
 power domains
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <quic_tingweiz@quicinc.com>
References: <20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com>
 <20240920-add_qcs615_powerdomains_driver_support-v1-1-8846efaf9454@quicinc.com>
 <30458916-90f4-4126-b5b4-a52f580c4fa7@kernel.org>
Content-Language: en-US
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
In-Reply-To: <30458916-90f4-4126-b5b4-a52f580c4fa7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XLSUE2A6n8HC4FMvV4Zl-lSXKdTl7E0w
X-Proofpoint-GUID: XLSUE2A6n8HC4FMvV4Zl-lSXKdTl7E0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270088



On 9/20/2024 9:15 PM, Krzysztof Kozlowski wrote:
> On 20/09/2024 06:08, Tingguo Cheng wrote:
>> Add compatible string for the RPMh power domains on qcs615 platform.
>>
>> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
> 
> You sent within 30 minutes two independent patchsets touching the same
> part of code, so you knew it will lead to conflicts. I don't get how you
> imagine this to be applied. I suggest combining patchsets in such case.
I created a new patchset by combining the two patchsets into one to 
resolve the conflicts.

20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com
|
|<--Patchset 1:Current patchset.
|<--Patchset 
2:https://lore.kernel.org/r/20240920-add_qcs8300_powerdomains_driver_support-v1-0-96a2a08841da@quicinc.com

> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
> 

-- 
Thank you & BRs
Tingguo


