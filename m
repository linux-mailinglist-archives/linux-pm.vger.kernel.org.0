Return-Path: <linux-pm+bounces-13750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D770096E9ED
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 08:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910E0289608
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B934314831F;
	Fri,  6 Sep 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nFs5R4G1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A2A84A2F;
	Fri,  6 Sep 2024 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603353; cv=none; b=ZASt0Y4Y1tk+KffHi+BPXy8N2USK5H7wovxfqjPxbOhExrbUUH/eGro/NsUlD0WNNVi9bgf9ugNG+rFygO/UwWY7LMrtSRPrNHVjHnlh2QFVg5NzxbpLaeBT4iPJGYF1YltCJ9+AhfdDWaouSKOe+QkQQnSUmst7xVrNna+y5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603353; c=relaxed/simple;
	bh=79bP+9tenPT4X0zt0R10ccVUIVlPRZl8Fv567FS8JjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uiIMmglm5l41KER4qRF11fDSgX/jP/k3w9WRjEz0F6jXaR7MtegO+PGN6sjuJjZh/ycfI8eW7CSpoZ2PKmPLLnJm/Wa1s54pJz0FBOBU6rduc0tgHPr29oXAJhZCj4fsy4Cd3a0zkOzrs6oVBaclGatpXe9rj43pUHS4uLM8ve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nFs5R4G1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQ5JF021772;
	Fri, 6 Sep 2024 06:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dYIfT0L1Gyqdy6+UGfAcsvvhKADQqx8n0cQq/HMS2ys=; b=nFs5R4G1TxawjxbT
	4lndhX6mST0QBgdRZK1///T7cMQHtFxIV4/iKrcOF5RGBEOef/1rBZeIfi1ijEgN
	fNaKblQwzCs5PkrMMeF2XQUTrBiojB0I0rsOReUovo+B71yftdubdilKWgNk4c0m
	Zj4DiggA1QjyzAC7JTBpwkKwnKPX/N/ZHQKbbZ4KQmQUVhMNEAbRZbTlk/SWIdJm
	La7dLDS2Kq47i/HFTs+1VJOTLioyyDZw7VRxJul6MCSSq01VX5tPPVy357ydP1VJ
	vg12m25pc13hyu4u3EDfdB/MoK4LeyqpYZcnKauVEsL1UfvB4QuuodoZ6r7Xz/Dg
	HUhkqQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu195q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 06:15:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4866FiCZ026158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 06:15:44 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 23:15:41 -0700
Message-ID: <c674b8ff-6fdb-419d-86f4-69a940eccc2f@quicinc.com>
Date: Fri, 6 Sep 2024 14:15:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] arm64: defconfig: enable clock controller,
 interconnect and pinctrl for QCS8300
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-17-d0ea9afdc007@quicinc.com>
 <851566fe-4802-41c7-bb35-d6d1e9cf9bdf@kernel.org>
 <d5b13f14-ce66-496c-8182-aad840e0d5cb@quicinc.com>
 <wzjv6xvthoz3z4fimxfc6gzm6ptepkuwlzjm6xy3klmtpr3bvf@k7yxdc7hryju>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <wzjv6xvthoz3z4fimxfc6gzm6ptepkuwlzjm6xy3klmtpr3bvf@k7yxdc7hryju>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WEk1eTDzyk_2E7aKgddkZQNpWt8FuMpZ
X-Proofpoint-ORIG-GUID: WEk1eTDzyk_2E7aKgddkZQNpWt8FuMpZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060045

Hi Dmitry,

On 9/6/2024 11:18 AM, Dmitry Baryshkov wrote:
> On Thu, Sep 05, 2024 at 12:54:35PM GMT, Jingyi Wang wrote:
>>
>>
>> On 9/4/2024 5:39 PM, Krzysztof Kozlowski wrote:
>>> On 04/09/2024 10:33, Jingyi Wang wrote:
>>>> Enable clock controller, interrconnect and pinctrl for QCS8300.
>>>
>>> NXP QCS8300? What is QCS8300? Which products use it? That's a defconfig
>>> for entire kernel, not your Qualcomm one.
>>>
>> Will describe it in more detail.
>>>> It needs to be built-in for UART to provide a console.
>>>>
>>>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>>>> ---
>>>>  arch/arm64/configs/defconfig | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index 81ca46e3ab4b..a9ba6b25a0ed 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>>>> @@ -606,6 +606,7 @@ CONFIG_PINCTRL_MSM8996=y
>>>>  CONFIG_PINCTRL_MSM8998=y
>>>>  CONFIG_PINCTRL_QCM2290=y
>>>>  CONFIG_PINCTRL_QCS404=y
>>>> +CONFIG_PINCTRL_QCS8300=y
>>>>  CONFIG_PINCTRL_QDF2XXX=y
>>>>  CONFIG_PINCTRL_QDU1000=y
>>>>  CONFIG_PINCTRL_SA8775P=y
>>>> @@ -1317,6 +1318,7 @@ CONFIG_MSM_MMCC_8998=m
>>>>  CONFIG_QCM_GCC_2290=y
>>>>  CONFIG_QCM_DISPCC_2290=m
>>>>  CONFIG_QCS_GCC_404=y
>>>> +CONFIG_QCS_GCC_8300=y
>>>>  CONFIG_QDU_GCC_1000=y
>>>>  CONFIG_SC_CAMCC_8280XP=m
>>>>  CONFIG_SC_DISPCC_7280=m
>>>> @@ -1618,6 +1620,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8996=y
>>>>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>>>>  CONFIG_INTERCONNECT_QCOM_QCM2290=y
>>>>  CONFIG_INTERCONNECT_QCOM_QCS404=m
>>>> +CONFIG_INTERCONNECT_QCOM_QCS8300=y
>>>
>>> Why this cannot be a module?
>>>
>>>
>> I think the commit-msg "It needs to be built-in for UART to provide a console." can
>> explain that, could you please help to share your insights on that?
> 
> Unless loading these modules from initramfs doesn't work, please use =m.
> The drivers that are enabled here are going to be enabled for everybody
> using arm64 defconfig, taking up memory on their platforms, etc.
>
We had previous discussion here about why these drivers needs to be built-in to support
debug-uart:
https://lore.kernel.org/linux-arm-msm/c11fd3c2-770a-4d40-8cf3-d8bc81f7c480@kernel.org/
I will mention more details in the commit message of this patch.

Thanks,
Jingyi

 


