Return-Path: <linux-pm+bounces-13652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBCD96CE37
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 06:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092BF1C227FB
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0D155327;
	Thu,  5 Sep 2024 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W54ol1Gq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6A14F123;
	Thu,  5 Sep 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725512091; cv=none; b=uA4YZDYyAG4f8w9nlKCW9Yra41wx7nhVLOHZCP8CgxEA7WBznMEu5YVc/PkXR1bpJZ5PwImGIsw9EAMc6d+9n/edAGyt1zJ2BqhsvkynF5kNzKH/8jT67CAjpQyP/WLr1rkLDtNo8tz8gKNp5nFBMqh9ARxIcKVS4QruMQ7D5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725512091; c=relaxed/simple;
	bh=kU5E59jGvjmjqB7O0+fd63UnTKvAJirSC8kitBme0s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jbzh6WHs7EyUrh0uxpIjSasIX+r/Y35eo+AuuXlj4hv2YvhGSi++yYQnV9DRv4fQgbjyq7lNA4eAjIzUVXYe/Xqh2UTxZP7S9nLj0s6x4HcblDhqL1trZy653gYjEwPRA+8DZ54EJBpmY3gdDob99wZjVi2wqI+xw18SlAAdF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W54ol1Gq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4850WBwv020611;
	Thu, 5 Sep 2024 04:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qdHqXKAAx3KsSB56NbJqlgox7CzoGPYaKAQtdfXZk9A=; b=W54ol1GqPaufLazk
	VpxeviqA+FJvAgOhmGQGL99458+DVe7Fme0y3PXTB+37WHFMhJs+tVuN3fmNp1pz
	ABGrIlAQynk7WKb+fHrkgQZ4gx5bP/1XT4PHkMj8pT0Zx4sf7+0aKtlCGYIl++Gz
	bkSAMC7inMHfXQl0VIRIth2HxQBjs5idalAJ9HQ53yUVfsTxSxyzjxmND81ofg9T
	GywdIXJ3i9aHxVFHLHTR14ueZEaiGmX982LQxOZ3ATpwBJ0gI/QtVmYUcGz/Rv9b
	qqo2mxQlNEEXOpIhQCNx8MwA0DtvC7rWaYGXPzNVGqYwj5ln5eIVSd92RKD31WoI
	3rdiqg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxvsmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 04:54:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4854sgXF025037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 04:54:42 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 21:54:38 -0700
Message-ID: <d5b13f14-ce66-496c-8182-aad840e0d5cb@quicinc.com>
Date: Thu, 5 Sep 2024 12:54:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] arm64: defconfig: enable clock controller,
 interconnect and pinctrl for QCS8300
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-17-d0ea9afdc007@quicinc.com>
 <851566fe-4802-41c7-bb35-d6d1e9cf9bdf@kernel.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <851566fe-4802-41c7-bb35-d6d1e9cf9bdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q647ivrs9ZRbZX7a4zPRg0m0tAgTa4Nh
X-Proofpoint-ORIG-GUID: q647ivrs9ZRbZX7a4zPRg0m0tAgTa4Nh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409050033



On 9/4/2024 5:39 PM, Krzysztof Kozlowski wrote:
> On 04/09/2024 10:33, Jingyi Wang wrote:
>> Enable clock controller, interrconnect and pinctrl for QCS8300.
> 
> NXP QCS8300? What is QCS8300? Which products use it? That's a defconfig
> for entire kernel, not your Qualcomm one.
> 
Will describe it in more detail.
>> It needs to be built-in for UART to provide a console.
>>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  arch/arm64/configs/defconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 81ca46e3ab4b..a9ba6b25a0ed 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -606,6 +606,7 @@ CONFIG_PINCTRL_MSM8996=y
>>  CONFIG_PINCTRL_MSM8998=y
>>  CONFIG_PINCTRL_QCM2290=y
>>  CONFIG_PINCTRL_QCS404=y
>> +CONFIG_PINCTRL_QCS8300=y
>>  CONFIG_PINCTRL_QDF2XXX=y
>>  CONFIG_PINCTRL_QDU1000=y
>>  CONFIG_PINCTRL_SA8775P=y
>> @@ -1317,6 +1318,7 @@ CONFIG_MSM_MMCC_8998=m
>>  CONFIG_QCM_GCC_2290=y
>>  CONFIG_QCM_DISPCC_2290=m
>>  CONFIG_QCS_GCC_404=y
>> +CONFIG_QCS_GCC_8300=y
>>  CONFIG_QDU_GCC_1000=y
>>  CONFIG_SC_CAMCC_8280XP=m
>>  CONFIG_SC_DISPCC_7280=m
>> @@ -1618,6 +1620,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8996=y
>>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>>  CONFIG_INTERCONNECT_QCOM_QCM2290=y
>>  CONFIG_INTERCONNECT_QCOM_QCS404=m
>> +CONFIG_INTERCONNECT_QCOM_QCS8300=y
> 
> Why this cannot be a module?
> 
> 
I think the commit-msg "It needs to be built-in for UART to provide a console." can
explain that, could you please help to share your insights on that?
> 
> Best regards,
> Krzysztof
> 
Thanks,
Jingyi


