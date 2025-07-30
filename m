Return-Path: <linux-pm+bounces-31597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE82B15E39
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 12:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F611761C5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348F226FA60;
	Wed, 30 Jul 2025 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bflpJaa4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50827E0E4;
	Wed, 30 Jul 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871573; cv=none; b=YHOoygoC1ih370lWo7W25HVzWCAFUVBmFfrX9Ajvo+S1GuXQlhp9Fgx7Kh7dozcXUdNIhAJjmPcLEnoQOG0bdyCY0wDnFC4Bp07pSzctwD+dOVEctUhfK6HTeMLcoW3TxMU2JVt2wOY7Ipjl94ULOJ0F1aGxxeUVXFUod5Fxfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871573; c=relaxed/simple;
	bh=WsXnp8r/2zMoLIEftKtTfeHwLISoTLNiYbjkcq7R4ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eht4PND1ZtlVV7T1CHlbw5sWpzQgxyiRpbaya8UhXfdPhIIybBj0VR/fXFXFPcDss/qGknHkEXKPbzIRpM/vHaZBzsidl9sL23oWHa97j/aX7vPovAlZcWEfzGn+qXApfko9soNYe+Wz8pJ7VWnA9ynBGd+AHXN2HXB3oo9oNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bflpJaa4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5x8CL018829;
	Wed, 30 Jul 2025 10:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J8kzced2LqilmJR7AKpy5OJ5Hlxs74wJYSZaFOJSBX8=; b=bflpJaa4fBS4mN2V
	EKs5isPY+YEwRdv8w4SG3On2OCAfR9Q1ST4CWPQoo3cScEBF2n2odONnnbPeCBv9
	Flfp8xU6mcM9C1Q9YhrvdXTw3FW6oH0Cb1qaVlxsr90zhhQnN2PxqcZ/vm1czJv4
	HmFhnyfpN95yQes2qOE86k4EDBN7YTfSCaN4zza9xSX8pOVWg5JX8wxQFpq+qjLu
	JKy6n8MpCWB7QZoI09c44ePb3n0nwjBC7OHTiUNt6u5K1mGL2RUm8SDRGIZSN3G6
	s67tysKZxNknIjdekg2GEurnxIwAeyCGAZgGQudTUqjhRDfprYSELRJFyIgWftym
	ltB2oQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q863ja2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 10:32:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56UAWlT7028460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 10:32:47 GMT
Received: from [10.151.37.100] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 30 Jul
 2025 03:32:41 -0700
Message-ID: <051a4ad2-bc25-4e69-9b26-5888c469eda8@quicinc.com>
Date: Wed, 30 Jul 2025 16:02:38 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>,
        <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_mdalam@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20250730081316.547796-1-quic_varada@quicinc.com>
 <20250730081316.547796-2-quic_varada@quicinc.com>
 <1705cfd6-95fe-4668-ae3b-f8fc7321d32a@kernel.org>
 <2c165ddd-f6b6-45b6-a319-8944fab324f2@quicinc.com>
 <02084269-f591-420f-8f60-7ac0aca9097a@kernel.org>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <02084269-f591-420f-8f60-7ac0aca9097a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA3MiBTYWx0ZWRfX7ypCNs8cuebz
 cvXNNV5FhgPlEjcW8tPKA+Gxu7QAha0BqEhSajsJ9T35uZguQutLDqjH3CjXaZImrn6B6hXloZM
 vHK1MXB2dLc9y1O4h+SFOx+Lg6TZOyvjK6bZdaGSDiJ/5MmjRkHJRZDlS099wnjZMCMh4KLyX3X
 wcQdPs3lb41jztXoEAJDH+X+8JPY+K+1nC4ojzRGwnfoib7NOoqXF8zVnVKc0y1GFYVXFKx6tLK
 vmTvKo8Fzm9csWbtipTIS6aoKdgWPQrKMbPywscT0g2jLbG+MbR1K3WL/QtAbfKXbV5Jn1qkdkq
 g7TtlvqxgfnSUlmCxl4h7e4/F5RydZCR6wWo4QBrzscorbGdekeXjiAPGUsoJ/rdnxpuvMPXK8g
 fb/dkwnv3OY2mAWvwRiPjioMEqaJ6gv/I55EpDaT/7H/xdrilFC69EgncS/mEk+taKvdirAv
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6889f4cf cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8
 a=COk6AnOGAAAA:8 a=iDVmcDSDRtdF4r9CFTYA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Ps5V9MMwIT2tmYjGimBXfbkcOrP8c8gQ
X-Proofpoint-GUID: Ps5V9MMwIT2tmYjGimBXfbkcOrP8c8gQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=847 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300072



On 7/30/2025 3:06 PM, Krzysztof Kozlowski wrote:
> On 30/07/2025 11:22, Sricharan Ramabadhran wrote:
>>
>>
>> On 7/30/2025 2:32 PM, Krzysztof Kozlowski wrote:
>>> On 30/07/2025 10:13, Varadarajan Narayanan wrote:
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/qcom,ipq5424-apss-clk.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm APSS IPQ5424 Clock Controller
>>>> +
>>>> +maintainers:
>>>> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> +  - Md Sadre Alam <quic_mdalam@quicinc.com>
>>>
>>> My v2 comments seems still valid. Your explanation suggests they moved
>>> on, so it is confusing to see them here.
>>>
>>> Sricharan and Md Sadre, can you provide Acks for this?
>>>
>> Ack. Please feel free to remove my name.
> 
> 
> I meant Ack that you still maintain this hardware and bindingd.

I still work on his hardware, but wont be involved in maintaining this
binding.

Regards,
  Sricharan

