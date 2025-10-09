Return-Path: <linux-pm+bounces-35834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D67BC76A2
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 07:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A98B1894848
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 05:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C932472BB;
	Thu,  9 Oct 2025 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M6XcSuB4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB332116E0;
	Thu,  9 Oct 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759986972; cv=none; b=keVA0jsqxNBDbAGhL+nNYLlnglZbYbNFP0R2ZfZnlSO0a7+2uSBRICRVwe9XxA5X69ScmqlsG2ZqkjCVoNXJLSozAud0dmS7RCotAwq30VKnlXmTyGAyZLFtGq9EIu+9L96HGNNHYzX+p92WlTIvHOM6nhAC3PuqGVQuzdpPZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759986972; c=relaxed/simple;
	bh=IW1bUCw/YgAwnfeHDGwce+n9UMmNwCNmu7rFOyRq5U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EpF36Fp6OZHhBek/S6hkd0F/McOaTTNyGUTsFQT4EcZ6rMaKBf3toXOhiR+tFiu9WsEJPpIO/NVI1z3lXTf24mVtAS4GPD/uZ7sTcFsOwYD1lZmrCfpfKPTvUb8xB0EqAo3zd8fhiax9KkKXkAbugrdHhGBy5RILmOZss/hfaAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M6XcSuB4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5P1M029339;
	Thu, 9 Oct 2025 05:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dG8y3PtCn6EjaswxEEcXK/l2TGKTeVCthwnXaHq+jC4=; b=M6XcSuB45Nw5nM81
	1hMYWrfeijmDMd3L9eESuu6HC2Eie/MH9Py5dr2lyQDnS3iNzw9u4/SctFXqjTTM
	pH+RMGGdfZaWWh1XuVtadQBIcFjXmYJLSkNN8sbIXPtfUstRbc2b9ghNrz0a7FJR
	Dla+GXkL6vhzEP1ab0+JAFPo9Hubn2R5kzGnev/a5GWMekd6+5mEWpqjEdMZOHBT
	L6JQMJVS8FuSK5yhvXzaWM5NyBS6kjKt0Q5nWm2bG8TsxZ+cJ6nVPC9KDh9kLwlg
	vhCEuSJxudpn6ArICDr+0ND1HJ+UItjeROTZz8xHkd5jqSxFFjkuyYEAiYId0DWN
	ubL54Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4shh70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 05:15:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5995Fq8V004079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 05:15:52 GMT
Received: from [10.235.9.75] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 8 Oct
 2025 22:15:46 -0700
Message-ID: <66ff1502-6e77-474e-ae99-fb0aa7f7f618@quicinc.com>
Date: Thu, 9 Oct 2025 13:15:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/10] dt-bindings: clock: Add "interconnect-cells"
 property in IPQ9574 example
To: Rob Herring <robh@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu
	<quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>
References: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
 <20250925-qcom_ipq5424_nsscc-v6-2-7fad69b14358@quicinc.com>
 <20251002011536.GA2828951-robh@kernel.org>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <20251002011536.GA2828951-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jiox-IIK5I-5TWOjqU0GNN8oZZM__i2e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX05BRtH/0xDJv
 QQzT7WoNswJw7NYuDPM6kjiZT3SgJooJYw/vh8mHAF4WCt8MwA2unV78BmdWaxISnn7jN1xtq/R
 3Syql7FaEZfXClpi14UBA2/F3YfyxVzHEMtYSNqBxurAxVkpGc0gh5QQZX9v958LaTzBGPT/vwh
 7jIujLfJVqOOnpAGDYY+lEXwQYfQYr3Zic/kDLRzxXDGhfjfdFIl2pa9ayaM5gYnKqj61/eL0UA
 gl4ROmMKwQe4hf6ogBJASMKCgc+HVyQbwDZkDBXt5ROhdNaK4Jt71Ru7B3lW8a8vM8YTpQfB0Xr
 uAVD83SauAkCXug8JOAssG8/qwapY83+ktLuKiQy/7rRVrutemLPueXVD45FQTDd0uRJ0C0/S20
 Tk5mXqAhQ3o+N6FHHROlpJX8C3PfjQ==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e74509 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=Q-zjNaZJJLQrxVh-NlMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: Jiox-IIK5I-5TWOjqU0GNN8oZZM__i2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/2/2025 9:15 AM, Rob Herring wrote:
> On Thu, Sep 25, 2025 at 10:05:36PM +0800, Luo Jie wrote:
>> The Networking Subsystem (NSS) clock controller acts as both a clock
>> provider and an interconnect provider. The #interconnect-cells property
>> is needed in the Device Tree Source (DTS) to ensure that client drivers
>> such as the PPE driver can correctly acquire ICC clocks from the NSS ICC
>> provider.
>>
>> Add the #interconnect-cells property to the IPQ9574 Device Tree binding
>> example to complete it.
> 
> The subject is wrong as it #interconnect-cells, not interconnect-cells.

OK. I will update the subject to use #interconnect-cells as recommended.
Appreciate your review.

> 
>>
>> Fixes: 28300ecedce4 ("dt-bindings: clock: Add ipq9574 NSSCC clock and reset definitions")
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>


