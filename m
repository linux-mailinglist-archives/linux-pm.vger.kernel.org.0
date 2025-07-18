Return-Path: <linux-pm+bounces-31052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C19B09EA6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EC85A4E1B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ED729550F;
	Fri, 18 Jul 2025 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gvmy/OZZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2B15278E;
	Fri, 18 Jul 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829578; cv=none; b=My1YtUbd6AWapQP5PmYlY1T2VJ5OHs2yu+Z+FKCsFS1SKOT/p5wloPG62uxqwRfUJltb1nLMGqjjcuuP//HMtBIozkSOap3TdK+lPXBJub8pZ8PytDFSVJ8BnwX4iGGR4ChKpswLzlKduLAGYWbGyHxJ//IhdnxjOrPbc/Z69mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829578; c=relaxed/simple;
	bh=z9BUvmWIt7hCxYtCLxNT6F///XMUiL2OyAVIWUDKtzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QWDm3RnPydUxSlRAI2BMwjGGn6U83qnIOGsJ9p1h09wI9xsg6/wsaPCYjUeYWiapeX3SkiWHpKIjimqbcSfCFyeOZm8K98usHUi07t+wsDgX2L+NHkE6CIFWBQRhYsnKqS3jofv3ogNNflFnaafTEG3rldJgVa3O0Fpq4ToGN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gvmy/OZZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8h2Bk008487;
	Fri, 18 Jul 2025 09:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zteTB79X+fUFIDXx8fj+5FQ3KCq88qFTkVFdV3sKo+g=; b=gvmy/OZZ3WysJgWy
	ZIeKGMdraUZK3CLSKAg4lJmyZT/akQCx8UCrO3VktWYp6qabPJnkOiV31U76rUJA
	TL3MxzFySkAVyhRuVkKpTJBxBYR0F74yJnwzziUuO6NcUqexemEYJjOhikTPYFbZ
	O4u/6K+lr19pSzDcOeUFffpyeg5vSoGjioKnT0qkpKSBhH8JCQIj6jxYb06URDEk
	hI/FTTtDhd1CWCY293nWyClCF5qdeuajIwiUTf7qPgUQDVy+85XEGUfmAOoDh9Ii
	EyqoMwYGe039OY5cWIQuaBkSdzpgFff+3gQiMjzVpDAuiyGVnJpRy7FbPqm0S4LD
	A7//tg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbavc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 09:05:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56I95vF1018192
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 09:05:57 GMT
Received: from [10.253.76.178] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 18 Jul
 2025 02:05:51 -0700
Message-ID: <49d5d360-6a2f-4dd4-bbd7-1a902e556f00@quicinc.com>
Date: Fri, 18 Jul 2025 17:05:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] dt-bindings: clock: qcom: Add NSS clock
 controller for IPQ5424 SoC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring
	<robh@kernel.org>
CC: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-7-f149dc461212@quicinc.com>
 <20250710225539.GA29510-robh@kernel.org>
 <0ef83a1e-38c3-41bb-8fd2-c28565f2a0ba@oss.qualcomm.com>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <0ef83a1e-38c3-41bb-8fd2-c28565f2a0ba@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AZYG4c9OW3-sedX7DX_sxsCBKToCgLEp
X-Proofpoint-ORIG-GUID: AZYG4c9OW3-sedX7DX_sxsCBKToCgLEp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3MSBTYWx0ZWRfX5LbihV0UUb0t
 o21O7oJbdD4zibgNivY2bBbTBmsoB+iplPPmx6rChx/ut7gn7Oak9Xo/Cba0tVImzdtQkjf1JHs
 oBhPicQoATtb1Fewi02B34i2fBfDyxh3jYR9b0phAg+OD5StpMgfsgLmQYmCOShN9QFNsCKMzOn
 26tvTc4F9OyOLprj0x3bKaZAaGpQlEg1fhfuj99i0Q8gwfUgzDY6traYYcPkyKmuIIXwsK17vIe
 TJCR//Ud9056pCQTdr4hFGqOk1FzaAQpT5pfn+wgYcVmWY2xUQ+wpP1ORBNOzNz25K2QkDbzspP
 8DK+tiwNRq5rISN3CmyTieuEroCtcDkvB990oXHNm3lmCjGtGTPDHYuRECylvgScCL67CvfA0CJ
 m+MV1TXB/J3gdyyDPiGbtHPDnjLNTBAeVONL7gP9/lZJabYnuwN1kjL+WO0vQiEzYhGtlMJj
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a0e76 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=zwoUeVU6iwdCpd6WVVcA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180071



On 7/11/2025 8:16 PM, Konrad Dybcio wrote:
> On 7/11/25 12:55 AM, Rob Herring wrote:
>> On Thu, Jul 10, 2025 at 08:28:15PM +0800, Luo Jie wrote:
>>> NSS clock controller provides the clocks and resets to the networking
>>> blocks such as PPE (Packet Process Engine) and UNIPHY (PCS) on IPQ5424
>>> devices.
>>>
>>> Add the compatible "qcom,ipq5424-nsscc" support based on the current
>>> IPQ9574 NSS clock controller DT binding file. ICC clocks are always
>>> provided by the NSS clock controller of IPQ9574 and IPQ5424, so add
>>> interconnect-cells as required DT property.
>>>
>>> Also add master/slave ids for IPQ5424 networking interfaces, which is
>>> used by nss-ipq5424 driver for providing interconnect services using
>>> icc-clk framework.
>>>
>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>> ---
> 
> [...]
> 
>>>     clocks:
>>>       items:
>>> @@ -57,6 +61,7 @@ required:
>>>     - compatible
>>>     - clocks
>>>     - clock-names
>>> +  - '#interconnect-cells'
>>
>> You just made this required for everyone. Again, that's an ABI change.
> 
> In this case it's actually valid, but should be a separate fixup change
> 
> Konrad

Making #interconnect-cells a required property does introduce an ABI
change in the device tree bindings. However, this change is necessary
to ensure proper functionality and integration with the interconnect
framework, which increasingly relies on this property for accurate
configuration and resource management.

Yes, this is a fixup change. Since the current NSS clock controller DTS 
node for IPQ9574 already includes '#interconnect-cells', I will separate 
this modification into a standalone fixup patch.




