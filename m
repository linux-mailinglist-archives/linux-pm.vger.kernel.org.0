Return-Path: <linux-pm+bounces-13505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBEF96AFB7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 06:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0412F1F24F55
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 04:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6562059155;
	Wed,  4 Sep 2024 04:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ntcj8PtI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585292E401;
	Wed,  4 Sep 2024 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725423328; cv=none; b=KNrrNloFglNxWx44PlkHVxyjaQrNlqb7HxWyPz8dax1a8pzdhNVzmQrjdwH7QEVs3I0coLOFqf5EiXPZgOZHTH0CtyeGhEWPDsbktFNCAWrodIpd+5A3hj543qCYTDk3gtqCfohBT+L39SDeTOnJDQ3Qm1y0tiec+0P6kKdCjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725423328; c=relaxed/simple;
	bh=04cXRNVhzxjuM3K45RH8+pyf4XyvBDyMQBZtKwITLPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JpTd2xKdlud6Dmo/1jh9eXJJhEuESl1AikUyh3keczjqcf9La4luCzRdXrlk2P+b7pST3OVMNzRyIh91ES91TUocqEBng3g0U3g6NN++9cfUq6zLTvJ6AXI4jtXkEgvec4LGesgX+yycgaBlXrgczbKuO4Th57VR5ngFcKggnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ntcj8PtI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LwKZV028269;
	Wed, 4 Sep 2024 04:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7OwV9q54UMJ6Ji6Evf3mn018rjPxWeTlzaxGAmoj8x4=; b=ntcj8PtIJErq78mW
	PjFcNJ3pD55ac5x/QQL9X3Lxi4x6Cdn29M9sPh+QIY1YKH3Y1zZBubaMGvS0eP8J
	DnEhm2y7QnWSHv42I7tsiM8OTVbTB1y8isFB+1G11Sz2E/Ok83tLpL6vh22vpUVw
	LU9jDv2qTU6Z5KEb6Z67+r6EjV7BTCsS3GXy3LV1Xx/5ilpkmVMFNb6MH1LqfCwd
	JOgaID4b1qC465TxRTSX/ghUoR/PAwfxYo8hVWBCqr6vYhDC29L2eczSDUEvRfpK
	dH0S+rzWGuvl02H+jcIJ9dWIPDNv4ePhLidAfbZxrfmy2KX/Xu1I6d8kWWXUZcYb
	9JCi1w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxsfwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 04:15:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4844FEtW019077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 04:15:14 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 21:15:08 -0700
Message-ID: <a4b30cf0-3432-475c-9266-51b79780a666@quicinc.com>
Date: Wed, 4 Sep 2024 09:45:05 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm QCS8300 DT
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Danila Tikhonov
	<danila@jiaxyga.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Vladimir
 Lypak" <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        "Sibi
 Sankar" <quic_sibis@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andrew Halaney
	<ahalaney@redhat.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <quic_okukatla@quicinc.com>
References: <20240827151622.305-1-quic_rlaggysh@quicinc.com>
 <20240827151622.305-2-quic_rlaggysh@quicinc.com>
 <2221d0dd-e7ed-4ac8-a3c8-905ad8037fb6@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <2221d0dd-e7ed-4ac8-a3c8-905ad8037fb6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qOEMVR2bohbJmNxDGHLge5sbfItYPJtA
X-Proofpoint-ORIG-GUID: qOEMVR2bohbJmNxDGHLge5sbfItYPJtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_02,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409040029


On 8/27/2024 9:02 PM, Krzysztof Kozlowski wrote:
> On 27/08/2024 17:16, Raviteja Laggyshetty wrote:
>> The Qualcomm QCS8300 SoC has several bus fabrics that could be
>> controlled and tuned dynamically according to the bandwidth demand.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
> A nit, subject: drop second/last, redundant "DT bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
> And you do not add "Qualcomm QCS8300" here. QCS8300 is a SoC. You add
> here specific device, right?
Agreed, QCS8300 should be enough, I will update the commit text, addressing the comments.
>
>>  .../interconnect/qcom,qcs8300-rpmh.yaml       |  50 +++++
>>  .../interconnect/qcom,qcs8300-rpmh.h          | 189 ++++++++++++++++++
>>  2 files changed, 239 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
>>  create mode 100644 include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
>> new file mode 100644
>> index 000000000000..ac75eeb6a6b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,qcs8300-rpmh.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. RPMh Network-On-Chip Interconnect on QCS8300
>> +
>> +maintainers:
>> +  - Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> +
>> +description: |
>> +  RPMh interconnect providers support system bandwidth requirements through
>> +  RPMh hardware accelerators known as Bus Clock Manager (BCM).
>> +
>> +  See also:: include/dt-bindings/interconnect/qcom,qcs8300.h
> Just one ':'
Will address this in next revision of patch.
>
>> +required:
>> +  - compatible
>> +
>> +allOf:
>> +  - $ref: qcom,rpmh-common.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    gem_noc: interconnect-gem-noc {
>> +        compatible = "qcom,qcs8300-gem-noc";
> Hm, no reg?
>
> Where is your DTS? Please follow standard upstream process, which means
> you send DTS separately. Your internal guideline already should cover
> that. If it does not, please look at upstreaming of SM8650, update your
> guideline and then follow SM8650 process. That way we can verify that
> what you send is true.

Thanks for the review !

I will share the link to DTSi change and will update the yaml in the next revision.

> Best regards,
> Krzysztof

Thanks,

Raviteja.


