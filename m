Return-Path: <linux-pm+bounces-17948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD0E9D59F2
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 08:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E44283733
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38C316F0EB;
	Fri, 22 Nov 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hWjePwgy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EB1465A0;
	Fri, 22 Nov 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260302; cv=none; b=eRxQx1hekihVjS86Bbw569JuTKhSCvAMAsWNWKp1pCjzAgj9ZdhAIdl8Vn57Z7tEM16aq6dqLKc0HGQ5OlVY5gU/CgYSpDklil/fz+qsyv8csORwAIllxbwKm+u+IrzJrp29BDxNTMkVMqyCzCfEAe3KRvAMr+bRx/3PQrnWC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260302; c=relaxed/simple;
	bh=7ESMhw6qWFkb1s9kF5O6ikkxZs/870Smg/4qvKVpSa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h+fgKwQ6CaoE4e6/H5RQ01kQ5H4bWwrBXNAbzQzc/mh8H8mYHpp793jcM40Sz93DUu1bCG7tKxrs6WUMscCbaKZY7+797ypviWkbZ5inM4YDVy56I88AsNa0ArMcTIHTFcSOtBqRrjzXm0uZi72vxjHJz2Jl0/azOmt2cm5yxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hWjePwgy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALJPchJ019239;
	Fri, 22 Nov 2024 07:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mZOchEo22wWGYZOOArnnZSYty6lEalNJAgJuZtAfWZs=; b=hWjePwgyCsJqiwkK
	U0Aj8p4NjcIe00XL8JnXtIQJ0V5vF5aZbCGwpoi0ZZEZeqCGseW9FD+77ZI5awaB
	lfwYOhnvMy4hWHW2y7RKR9XpGLKJnWXMmQ2uX9yBlMTlrkMieaHxybz/bWaJzWEF
	AFKnv7wpmDnOBXHNzJWgfnmiDET8YCh2sERSt6s2Y/UVQvdTdXQKM20WBoGcNvP6
	MgF1LXq2hiEcVF3E+m90vtRHZkGpX9d/vyeVdUfYjXfty+jZr0dooUl+z/yBiuvx
	Uhosas6BrIoVf57dFZOFM4aO/XuLcGX7IcQA+YHPUKCyBneEMoEpzmVOquK6Jboh
	+jKt/Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431c7hpm1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 07:24:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AM7OwR7028349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 07:24:58 GMT
Received: from [10.216.2.20] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 23:24:53 -0800
Message-ID: <d0848961-f5d4-46eb-b1ab-99ae6a0e07e1@quicinc.com>
Date: Fri, 22 Nov 2024 12:54:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/4] interconnect: qcom: osm-l3: Add epss compatibles
 for SA8775P SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-5-quic_rlaggysh@quicinc.com>
 <51653aac-76e0-4da2-aea8-16d62b570155@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <51653aac-76e0-4da2-aea8-16d62b570155@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -HGI-8ePDZ8bgJxOYgPlSZJXtjCujxKl
X-Proofpoint-GUID: -HGI-8ePDZ8bgJxOYgPlSZJXtjCujxKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220060



On 11/21/2024 5:21 PM, Krzysztof Kozlowski wrote:
> On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
>> The EPSS instance in SA8775P uses PERF_STATE register instead of
>> REG_L3_VOTE to scale L3 clocks.
>> Along with SoC specific compatible, add new generic compatible
>> "qcom,epss-l3-perf" for PERF_STATE register based L3 scaling.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/osm-l3.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
>> index a9405b7d251b..285afaa1f61e 100644
>> --- a/drivers/interconnect/qcom/osm-l3.c
>> +++ b/drivers/interconnect/qcom/osm-l3.c
>> @@ -318,6 +318,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  
>>  static const struct of_device_id osm_l3_of_match[] = {
>>  	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
>> +	{ .compatible = "qcom,epss-l3-perf", .data = &epss_l3_perf_state },
> 
> 
> Hm? Why?
> 
>>  	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
>>  	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
>>  	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
>> @@ -325,6 +326,7 @@ static const struct of_device_id osm_l3_of_match[] = {
>>  	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
>>  	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
>>  	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
>> +	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
> 
> 
> So this is compatible with sm8250. Use that one. Don't grow this table
> needlessly.
> 
Will make use of sm8250 compatible in next patch revision.
> 
> Best regards,
> Krzysztof


