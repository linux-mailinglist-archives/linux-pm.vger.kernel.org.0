Return-Path: <linux-pm+bounces-31606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0064DB15FCE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1566E3BE58A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F38290080;
	Wed, 30 Jul 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p2RHjbhO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459917C220;
	Wed, 30 Jul 2025 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876266; cv=none; b=tKngVXn9aS0HSPwvOr448obkI3sO21l6FMV05H6auP7UrV8e3xAT+4Qel1zu6med9s6kvsWW9f8Ixj9bgVj5kxUHEFUQKeT7Ah9xZx1ctzSHcqDjNOYPUt/lTDteb7X4cQje/bXqyAx3efeAVXC00Jw0n4lPME92jgoJQM9j1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876266; c=relaxed/simple;
	bh=hFE+VvnixvHmJqYgEeGzZol5r0MCCC0Bbs1srC4F+x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F5Fi12MYu1QuUNBrU/j1VzJlOjgFzkqkHgMbQcX+blt6KCDuSr494YG7K3cWYRpEGYrI93pHGhS33ux2zV3aMTG1AXprhXXGMdBV/volXKo7sx8FEYVIDUq+NUI6DYp94PJk6MsmZV9YUBgIKyxb0RBRn65V0KCGXvNPMPU7DTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p2RHjbhO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6VMes027649;
	Wed, 30 Jul 2025 11:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EH8hjEKtJUf93juSjee6r978//JmiAHbBCQhbGgK9/s=; b=p2RHjbhO3mK2Oovt
	uS8NdEYfNE0+jSoOf1tvtzEuw+e5OqSUvesvWyieVFUk1Fblqs0louDvYl9cwMZ4
	U4Iv43HidgZ0ipZS491VMKQv8iSr2gzMsGfyP/X1C2+UqB1WzQZ+zCjEsNWlkzjm
	KxE/eUKZ6rj8Y6U94Ayx1aynDhH8S4HhsKhYheofCEeee6xl/XncxjLaTT05hkhA
	HAz/HKX2DjQSPRvfIF0fpMy/r/I+dmluaS+vk6aKEQGdhw43SkS2eNG9CAOucXPR
	7RIaCwfZz0/aWi9lka1Zv++tH7IBuuAhPB8C+ZBg+bK1jfXxoquwBTyryvcriDyt
	CXaFxg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep0y5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:50:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56UBol3t014809
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:50:47 GMT
Received: from [10.235.9.75] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 30 Jul
 2025 04:50:41 -0700
Message-ID: <4c018fd1-f20e-4c16-a914-31ac7bbff800@quicinc.com>
Date: Wed, 30 Jul 2025 19:50:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] dt-bindings: clock: ipq9574: Rename NSS CC
 source clocks to drop rate
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
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
 <20250710-qcom_ipq5424_nsscc-v3-5-f149dc461212@quicinc.com>
 <20250710225412.GA25762-robh@kernel.org>
 <93082ccd-40d2-4a6b-a526-c118c1730a45@oss.qualcomm.com>
 <2f37c7e7-b07b-47c7-904b-5756c4cf5887@quicinc.com>
 <a383041e-7b70-4ffd-ae15-2412b2f83770@oss.qualcomm.com>
 <830f3989-d1ac-4b7c-8888-397452fe0abe@quicinc.com>
 <c67d7d8c-ae39-420f-b48b-d7454deb1fc9@oss.qualcomm.com>
 <5029ba6e-fa5f-41a5-a1df-bb9117973bd8@kernel.org>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <5029ba6e-fa5f-41a5-a1df-bb9117973bd8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QGBbe37uMkGLF3HcKDknxzxOPEReDKYf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4MyBTYWx0ZWRfX/hphI2ZU7hkm
 Y52J+ivvsJXDZM80dpoVP6QhxCc/eC9C9YnxLB8tQal/jE7NmUm9u48ZHP0HnL0b2YDC78WboSN
 9fGz76IdKHN+tkgEsvULzu7C54qpmCbjONSwJ1ICq0/CXJjzXUK4nmK+Gk0ElLCfI2ZOUWqC4KS
 Lheq4uXkeXMEUgs7mrRX/OUwJWrU23z6P7xVCZ0Kqpfewop7z6zIc9ChaIIe8AjC+FBfeqT01FJ
 ERsYU4w3maLxP1s2yJGziRFmR9Y/3nUKP3KRok9367rDs+HW9dClHu2uJ+QZtQwTsQqJpVJnEi8
 n6Hxz6BVZ9TkvMFl86w4l/m+Ob+MOZl7IGliXZFHKAGnXxbDXm5wUnGAedZnkDDuXOpVBrm3+R9
 s6gGeK6cCQZnZSsz00DEak+UuA+LBq9E8/ktY3F40vmO1RGMw8irYr4ffoICH3s9rnJFaXeO
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=688a0718 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=yXWi-EdJr4fTud6n2SMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QGBbe37uMkGLF3HcKDknxzxOPEReDKYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300083



On 7/29/2025 9:57 PM, Krzysztof Kozlowski wrote:
> On 29/07/2025 15:53, Konrad Dybcio wrote:
>>>
>>> We had adopted this proposal in version 2 previously, but as noted in
>>> the discussion linked below, Krzysztof had suggested to avoid using the
>>> clock rate in the clock names when defining the constraints for them.
>>> However I do agree that we should keep the interface for IPQ9574
>>> unchanged and instead use a generic clock name to support the newer
>>> SoCs.
>>>
>>> https://lore.kernel.org/all/20250701-optimistic-esoteric-swallow-d93fc6@krzk-bin/
>>>
>>> Request Krzysztof to provide his comments as well, on whether we can
>>> follow your suggested approach to avoid breaking ABI for IPQ9574.
>>
>> Krzysztof, should the bindings be improved-through-breaking, or should
> 
> 
> Unfortunately not, you should not change them for such reason.
> 
>> there simply be a new YAML with un-suffixed entries, where new platforms
>> would be added down the line?
> 
> 
> Either new binding file or here with allOf:if:then differences per
> variant. Depends on readability.
> 

OK. Thank you for the clarification.

> 
> Best regards,
> Krzysztof


