Return-Path: <linux-pm+bounces-29329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7B3AE42BF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28823189D970
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0437255E2F;
	Mon, 23 Jun 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CZZWC2DM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7CD248895;
	Mon, 23 Jun 2025 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684794; cv=none; b=W5FOtt3fp6TdQ72ZylGUGJVUQOVjSOGC2kdZqnmEDSzwuvFyS1U//EFaD9im7JXdDkds2av7YLLJkWVR1i9iGPmjtE0mIcA5fTwzqtIwjrhop7dfDJSA/bsytBR8yEqJcz9nyuoYgCe1QSp28R3BfkTpXo4fiDXaOcm/UxediaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684794; c=relaxed/simple;
	bh=WFr1mvAqWknTLQCXHSHPXHDsjQ1dBOGlTBZcHkDnwYQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=sQqWLH68qsWCSMmzkU8Ts0ZEwGZwsy2nL5FeYDlWgh7T+8HlLfNAyfWVzqMio1v1RYhgb/DUuRtvK1Sw9AyA+IKb1MsIcgpY8WHBXxu94SlZ52OzOgb3tApifM+S2WjOalc3Ovsx9GJOnx2JPEWB1Z4L1w7kEyh4B2W4hpqgsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CZZWC2DM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBliSL031297;
	Mon, 23 Jun 2025 13:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FgLrm/JXRlgdhk4Y0Tj9EAffwhDfvyBigTfDl8obe1Q=; b=CZZWC2DMQvTZJnaa
	q/PSoNtQ1V08REd0Rjxqzi/QnNHYSYsjTXca2u1jGXxR/lz4hfOOyO8ozA/0hTPP
	N1JiuYCl82n52c980w07eoA6bgO1bxuGCMeNB36NXncQj+ABR4aS9ZuAI5SVaabN
	WogsxmJrXP3CKPvfkoWq7tPA/C/3iNXEsehSN+T5V4WJS//TWJ5RLBzjSRxc9gH8
	NRz83AFL//+x10niX6FiuGrXYVfQRrId9eMcHyrlw8VkFrlndPt4FjTOhximDqH8
	EjOvOc5ViEJEHi7LOBm33bJl0PzobzMgxFbaXZzTZAwlLhH2KOccLLLa6HonX0R8
	P3H+uQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ey7k1hjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 13:19:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55NDJd5X008821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 13:19:39 GMT
Received: from [10.253.38.60] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Jun
 2025 06:19:32 -0700
Message-ID: <cf9dd904-c24a-4ea3-9689-087efab99d95@quicinc.com>
Date: Mon, 23 Jun 2025 21:19:29 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Luo Jie <quic_luoj@quicinc.com>
Subject: Re: [PATCH 5/8] dt-bindings: clock: qcom: Add NSS clock controller
 for IPQ5424 SoC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Anusha Rao
	<quic_anusha@quicinc.com>,
        "Richard Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>
References: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
 <20250617-qcom_ipq5424_nsscc-v1-5-4dc2d6b3cdfc@quicinc.com>
 <b628b85b-75c4-4c85-b340-d26b1eb6d83e@kernel.org>
 <512e3355-a110-4e7c-ab43-04f714950971@quicinc.com>
 <78f0e4b5-19f6-45a0-b4dc-a1b519645567@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <78f0e4b5-19f6-45a0-b4dc-a1b519645567@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=YoEPR5YX c=1 sm=1 tr=0 ts=6859546c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=FoU6f1ENpVpzdq5mMe4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: M54owwdi18GAqCN7_LHpIe6F1rX28ZbZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3OSBTYWx0ZWRfX+C7VxCurTRif
 w0TRlVSeVJZEJ+Qek9ML8hifYpHSXHhAqXMUbW3JQV2VxyL9lImiR1nJArs6y6HTm7xDCf5pmWN
 OQWOpPPebeRXVL0OwCPwQwPVFGvDAE+w9H1DCycp/WH6BC59hE8TQLnmLFqUuY3WIlIM6oZtVZ7
 6W1sXIae6l+jfLhKjKafStOVsYA3/EQWgKXqI1SuQd5QCs1N5HnhyGPWwDiwkTPrcnP4MyI/ITC
 NZqBoMmlTM5Wb48krsf/s0t9nIuZFP3lEUmDQSQmMRlu6H9bHkw/EovD4VoJfQalspkCiwR3Otv
 LFN23jXAsoDLeRaMZdPdhx3c7g/yUzE6i/NgG3Z+DLUDyl2L5Qgf8TaybKo05tV6TmD3JE2GFpm
 Mz4PKarvYjKxpI4DbfQnIgIslwARgTRKmyTKSQdmdE1aoBtCQZ2rZp2lSrPSo8BYvOhMLTfm
X-Proofpoint-GUID: M54owwdi18GAqCN7_LHpIe6F1rX28ZbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230079



On 6/21/2025 6:09 PM, Konrad Dybcio wrote:
>>>>      compatible:
>>>> -    const: qcom,ipq9574-nsscc
>>>> +    enum:
>>>> +      - qcom,ipq5424-nsscc
>>>> +      - qcom,ipq9574-nsscc
>>>>        clocks:
>>>>        items:
>>>>          - description: Board XO source
>>>> -      - description: CMN_PLL NSS 1200MHz (Bias PLL cc) clock source
>>>> -      - description: CMN_PLL PPE 353MHz (Bias PLL ubi nc) clock source
>>>> +      - description: CMN_PLL NSS 1200 MHz or 300 MHZ (Bias PLL cc) clock source
>>>> +      - description: CMN_PLL PPE 353 MHz  or 375 MHZ (Bias PLL ubi nc) clock source
>>> This change means devices are different. Just ocme with your own schema.
>> The NSS clock controller hardware block on the IPQ5424 SoC is identical
>> in design to that of the IPQ9574 SoC. The main difference is in the
>> clock rates for its two parent clocks sourced from the CMN PLL block.
>>
>> Given this, would it be acceptable to update the clock name and its
>> description to use a more generic clock name, such as "nss" and "ppe"
>> instead of the current "nss_1200" and "ppe_353"?
> Because you used those clock_names in the existing ipq9574, you can't
> change them now. You could introduce a separate set of clock_names
> for the new ipq5424 though, but I think it could be useful to drop the
> rate suffix for new additions
> 
> Konrad

OK, Understand, I will add the new separate clock names "nss" and "ppe"
for supporting IPQ5424 SoC and further SoCs with similar design.
Thanks for confirmation.


