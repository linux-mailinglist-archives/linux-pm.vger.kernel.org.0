Return-Path: <linux-pm+bounces-33641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823CBB401D2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 15:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EB31692A4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF882DE704;
	Tue,  2 Sep 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q2c039Ls"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7522D131A;
	Tue,  2 Sep 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817827; cv=none; b=okdZldANyUbx8NutFX23BHElA819rBZSMRydhk94GI5YYKbomkIawtt3rX6eWJUYjoXB1t+/eXM7EoQ61uObq+D02v+gGlBecfsPgz8W1mmsye1+x2rmG1Wxer/jyy4oZKkNLeaNajqhErrRpcel334mKnA43pnnJHj8paRPB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817827; c=relaxed/simple;
	bh=ZhS5C7Da3pBb6sozmTWBjkVYvgvVjapDX3zVsymscIo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=g+tf/0BY5pw76LROqeHI5DhFXSKIZ5faflj6WDWYfF2k8djF5Yt+pL44BrCVthIOyu7r4zSBhe7ReY+Lp6B6LtghunEcq3ZLpLXuEocd4ptLBYKTr6IzIralYaqDxUG53TvLaYnG6AdkL+QJMLitQ9fBKKBGEqhs+J8d9MOOwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q2c039Ls; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B53Io027881;
	Tue, 2 Sep 2025 12:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	86qW85Tc37g5BJVqaChVC8doy+h8rTyKf5jkJxK/O+c=; b=Q2c039LsglTS+4aW
	6Vqv1ScjZGV9nPkzgGnbqbR6TTCuUchIFWSPxkb5+MM3Cdzvac46X5rpz9yDKQ2y
	dchDxK0/NoJuZwKf9r6auIEiF1HAz44jtqDr+L9wn1h/uLMIDkPbFhaiMzsqBb+a
	h6E0ev18ICokplWNEUbYsVD+Twl+6PMqWJkyDLTHKZb+93DH0Dh+5ennH9Mje3BB
	re9WwKZvL6Nz/V4rpIk7trkPI8SF4QSe2qGTAGQdc4HZOr3PRx0WfabOGcCn+vu7
	bxO7wCcWBAeF51zq29+Im7st6ojZ+DtYvl0ktJ6Vqi2paFe81sFG2U/Lh8C2dUDa
	4Q6ZQA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuyva4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 12:56:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 582Cuodr029185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Sep 2025 12:56:50 GMT
Received: from [10.253.38.125] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 2 Sep
 2025 05:56:43 -0700
Message-ID: <335d6661-8719-46d7-89c6-3392fc13f396@quicinc.com>
Date: Tue, 2 Sep 2025 20:56:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Luo Jie <quic_luoj@quicinc.com>
Subject: Re: [PATCH v4 06/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
 <20250828-qcom_ipq5424_nsscc-v4-6-cb913b205bcb@quicinc.com>
 <20250829-ubiquitous-imaginary-mammoth-d52bde@kuoka>
Content-Language: en-US
In-Reply-To: <20250829-ubiquitous-imaginary-mammoth-d52bde@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX58rUtrKpDeG6
 9nJEjs6cttA8dPwot1KSSZsLhRHpn3F/cZSyeZ62+jfg7dQfQpDBS0HzqE18XIcwVCjvB7WDesj
 P/bHiOi7krhVPAGdA56ZxxurD7hG66MXS8P1VsfmZXsX+1L9JonlUsRtHQoSK6sWACYuJmQkXtu
 d00vyLYQ7/GEUvI5LemFZAadZ68AV8l6aplytq89hiOVju+/EOUcso15Z9YymWFAaQKBJ5N0AYQ
 N9cV+dUIVcoltdl81jpMxQ2tq7s7oEjyfnfCmGD5KZ7/IrDVXAfTHONRmMhtlxlWKL1k6lk38rk
 cdvih+mRJ9HnEGz4X+tdSY6gCwj8iTgB9SkYqcg3TeTRAHb/bCFHzwAwlmd7ozwRsLkRIN6FtQ/
 7vSXolz4
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6e994 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8
 a=g-MkapQZPYqtOJljyDYA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SkBytaGhBcwz6UtUuAqgjW778_jLkguH
X-Proofpoint-GUID: SkBytaGhBcwz6UtUuAqgjW778_jLkguH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031



On 8/29/2025 3:37 PM, Krzysztof Kozlowski wrote:
> On Thu, Aug 28, 2025 at 06:32:19PM +0800, Luo Jie wrote:
>> ICC clocks are always provided by the NSS clock controller of IPQ9574,
>> so add interconnect-cells as required DT property.
> 
> Does not make sense. If clocks are always, you require different
> property?

The '#interconnect-cells' property is mandatory in the DTS so that the
client driver such as PPE driver can acquire the ICC clocks from the NSS
CC provider. This is already part of the IPQ9574 DTS which is merged. We
had missed adding it as 'Required' at that time and fixing it now.

I will update the commit message to describe this better in the next
version to avoid confusion.

> 
>>
>> Fixes: 28300ecedce4 ("dt-bindings: clock: Add ipq9574 NSSCC clock and reset definitions")
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> 
> Fixes cannot be in the middle of patchset.
> 
> See submitting patches and your internal guideline explaining it with
> great details.
> 

I understand that fixes should not be placed in the middle of a
patchset. I will reorder the patches to ensure that all fixes are at the
beginning of the series.

>> ---
>>   Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> index 17252b6ea3be..fc604279114f 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> @@ -57,6 +57,7 @@ required:
>>     - compatible
>>     - clocks
>>     - clock-names
>> +  - '#interconnect-cells'
> 
> ABI break without explanation.
> 
> Best regards,
> Krzysztof
> 

This property is already present in the current IPQ9574 SoC DTS file
which is already merged, and hence no ABI break is introduced for
IPQ9574. I will update the commit message in the next version to clarify
this.


