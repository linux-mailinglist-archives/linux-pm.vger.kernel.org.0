Return-Path: <linux-pm+bounces-14652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FE79855A8
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1131C23169
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBE715957E;
	Wed, 25 Sep 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NiZjgL4r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9440132124;
	Wed, 25 Sep 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253638; cv=none; b=Nlx6JUJIoEFnLln88pZZgDAKkBThBgFBpbsqgViXandBTsc2Wai3FEYocMxHUFIWDZ/upfy5GeZZMkm/o82MdVA/HzSNxxonybg9ePvGXUZ9HcUAF1tsCxHfBb4xJbK8rJGW5FGykSrsRxgr2P50Wm9sS2ixPq0t1gwfR/Yo06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253638; c=relaxed/simple;
	bh=G3rkyJMud+WT9NrQgRrDr5uH79egWN8AUKmAFpNfr2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mlBwzds2SHI1gpWJts3xxhCv8Hc3mkTxfq0kVHBjzbwH/BIbml2vYbKRxjeb9A3zCKUJSRStVqx5LFMLji0SNYFvzIaONhHyIGRDrgvb4NCgUrJ/YVD1a4bRVd0k2jz2MHQVGu8JtdGYqgdMXTjZj7Vv5cNmb1eoHDb8QrK/ZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NiZjgL4r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P8CCGv003198;
	Wed, 25 Sep 2024 08:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	byKamiQAHNnlbq0CpogC8pF/k5ZwWEhkxkolRelxSvg=; b=NiZjgL4r8MKCcwte
	5H3eFAR3nqSC8aGQbcRAys2mlWKhfhQQNL4qe2KdLFPYHrSubav92hEPI/tnLa/p
	ysLKPR9pGujpAW2SZyQgYMX4QgZ6OAJeY3kE2d8mfNk6eZeBXwZvP3bWvwalgVCG
	bIZZA4APTXRjLIWxIkDmkv5h8E0lCUJbZ2y2XMasAfAWlXHSnqOOyiNXt0OevWaP
	FOgwYqJ/LamocboV4/QanWqsXbZEKztQdTjqvCGFpRg3DiGZovLcQd0MMMCm4PVu
	2sJic/+BmqE0gjUq3q8WfmpcavCoeXh77MGBXK/mfZqRVGXrPYuE6NbwKVo67dKT
	sMh0sg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6ujyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 08:40:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P8ePO0027288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 08:40:25 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Sep
 2024 01:40:23 -0700
Message-ID: <56b3ca36-e7b8-480f-99b8-c624acba8d65@quicinc.com>
Date: Wed, 25 Sep 2024 16:40:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document QCS8300
 bwmon compatibles
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <quic_tengfan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240925-qcs8300_bwmon_binding-v1-1-a7bfd94b2854@quicinc.com>
 <7ld327om75xpz53fb7itxp2i7gjqvhavywzuhmf52myynawwvo@rmb7yimjxxmy>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <7ld327om75xpz53fb7itxp2i7gjqvhavywzuhmf52myynawwvo@rmb7yimjxxmy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: amRyg2Afm2cv0iX8sGCVKnzRyLNofn1g
X-Proofpoint-ORIG-GUID: amRyg2Afm2cv0iX8sGCVKnzRyLNofn1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250062



On 9/25/2024 4:10 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 25, 2024 at 03:45:06PM GMT, Jingyi Wang wrote:
>> Document QCS8300 BWMONs, which has two BWMONv4 instances for the CPU->LLCC
>> path and one BWMONv5 instance for LLCC->DDR path.
>>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> index 189f5900ee50..251410aabf38 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> @@ -26,6 +26,7 @@ properties:
>>        - items:
>>            - enum:
>>                - qcom,qcm2290-cpu-bwmon
>> +              - qcom,qcs8300-cpu-bwmon
> 
> In most other cases qcs8300 is being declared with the compat fallback
> to sa8775p compat string. Is there any reason why bwmon is different?
> 
All the *cpu-bwmon are fallback to "qcom,sdm845-bwmon", so we add "qcom,qcs8300-cpu-bwmon"
compatible and fallback to that.
>>                - qcom,sa8775p-cpu-bwmon
>>                - qcom,sc7180-cpu-bwmon
>>                - qcom,sc7280-cpu-bwmon
>> @@ -40,6 +41,7 @@ properties:
>>            - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
>>        - items:
>>            - enum:
>> +              - qcom,qcs8300-llcc-bwmon
>>                - qcom,sa8775p-llcc-bwmon
>>                - qcom,sc7180-llcc-bwmon
>>                - qcom,sc8280xp-llcc-bwmon
>>
>> ---
>> base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
>> change-id: 20240925-qcs8300_bwmon_binding-641d8e4bf376
>>
>> Best regards,
>> -- 
>> Jingyi Wang <quic_jingyw@quicinc.com>
>>
> 
Thanks,
Jingyi


