Return-Path: <linux-pm+bounces-13746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 021D696E94D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761FC1F25105
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 05:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0E283CDA;
	Fri,  6 Sep 2024 05:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BSH0sl9k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F5819;
	Fri,  6 Sep 2024 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725600816; cv=none; b=H/+97hoZhTKMdoGmK2EgCx1sr2PcSshEch8cOgvxOT0JTYvd3JK+MVBqYGNcIjGvl3H0Ohi89wlChi+VtJFOZmJd0TXRHz/lTdqRI6QUQICdA6gMoPMcfaBiJz/fg9opu8g7Fn157De3j4NuAOrgBk0sWuQOSwfAp+twiHnUj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725600816; c=relaxed/simple;
	bh=+wqXwlOJLYUva84G6ipGlzWPUA2uIFHCxaVbBOcdlNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GDFLnqW96mX/IZpHgI+b+qITujP7ZoytnMit+nXlvtwDoXCB7k30Ax5cUKYDfguUgRrEOdX5KDmbEW9AL7ApHT43oUM9OuLhO8AKVG0smML2/r6srUOa/MK8nxQr0GD3AoWHqNl6044NoouD+m7s2FjsX/ne0kf3pRPm7Sc3QMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BSH0sl9k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQ34K009992;
	Fri, 6 Sep 2024 05:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AQ6010Ge4eWitT4DPpgKOhbf3PTApvBDUYpOt802MW8=; b=BSH0sl9kHEZqCmKz
	oDAMBaSqta4qWZziQcJoxBi9Iqq+27mdbEYVfX1Alx3A6gVJ8nr2u8HJvzgh4ySk
	1e8cdq0p0oE6zZHMepWL0Sq4CBInw6DdX1eYU1FqbWwvXxMPGu/XKnwCruZjozwI
	5ySL0ChpVlGp81fEB2VeDfFRlAiK16JYCdlx0L2n52c84vPzfk17mbdF2w0EXYGj
	YRGvbvoVZcul1YIpJmsEjI7LYYS4Orox0QguMAIePmGQM/LCk8Ci+jYg6VuZNYyE
	dVBHxBmIHv9SxHCoMJ2UitPejI3zuYRZRw+CMsX0AK24pzhI+f6ZJ6XAUdVd3Y/v
	s7Wh2Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwrs65d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 05:33:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4865XQ70028293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 05:33:26 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 22:33:23 -0700
Message-ID: <1e814bd1-0ae6-494a-8453-4de23639c5a7@quicinc.com>
Date: Fri, 6 Sep 2024 13:33:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] remoteproc: qcom: pas: Add QCS8300 remoteproc
 support
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Xin Liu
	<quic_liuxin@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-2-d0ea9afdc007@quicinc.com>
 <ecd95f82-ea98-4279-ad01-dc73d361180a@kernel.org>
 <a0f3176d-9b2a-4fb9-9a7b-f8e778e3b427@quicinc.com>
 <6652a08e-7143-4214-a864-9f27c10d7571@kernel.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <6652a08e-7143-4214-a864-9f27c10d7571@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E8-igjlDLuh_9zjMNe7ZmOg1oOgpCeP9
X-Proofpoint-GUID: E8-igjlDLuh_9zjMNe7ZmOg1oOgpCeP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060039



On 9/5/2024 2:24 PM, Krzysztof Kozlowski wrote:
> On 05/09/2024 06:30, Jingyi Wang wrote:
>>>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>>>> index ef82835e98a4..f92ccd4921b7 100644
>>>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>>>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>>>> @@ -1416,6 +1416,9 @@ static const struct of_device_id adsp_of_match[] = {
>>>>  	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
>>>>  	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
>>>>  	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
>>>> +	{ .compatible = "qcom,qcs8300-adsp-pas", .data = &sa8775p_adsp_resource},
>>>> +	{ .compatible = "qcom,qcs8300-cdsp-pas", .data = &sa8775p_cdsp0_resource},
>>>> +	{ .compatible = "qcom,qcs8300-gpdsp-pas", .data = &sa8775p_gpdsp0_resource},
>>>
>>> What's the point of this? You have entire commit msg to explain such
>>> weird duplication. Otherwise sorry, don't duplicate unnecessarily.
>>> Devices are compatible, aren't they?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>> I will drop this, could you please help us to understand what is the correct way to
>> deal such situation, do we need to update the yaml and add qcs8300 bindings or just
>> reference to sa8775p bindings in the device tree?
> 
> Above diff hunk suggests that devices are compatible, so should be made
> compatible in the bindings (use fallback). There are plenty examples of
> this for all Qualcomm devices.
> 
> Best regards,
> Krzysztof
> 

The usage of binding seems inconsistent across different Qualcomm drivers. Could you please
confirm that when you mentioned "use fallback", do you mean binding like this?

      - items:
          - enum:
              - qcom,sm8550-sndcard
              - qcom,sm8650-sndcard
          - const: qcom,sm8450-sndcard

https://www.kernel.org/doc/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml

Thanks,
Jingyi



