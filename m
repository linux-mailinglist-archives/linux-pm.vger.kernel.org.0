Return-Path: <linux-pm+bounces-16702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A197F9B5C0D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 07:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC161C20F68
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970911D5CF9;
	Wed, 30 Oct 2024 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XzPhvnul"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E61865E0;
	Wed, 30 Oct 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271253; cv=none; b=TNpiGJ+WkLu12DSRGYZul1jVhuherfVxRq/Lr4z0BtdC9DkY9NBIUr3G3rndwqAjZ5ycW8qpzvTSDgsWIWkCzrPc/XlnBBJPx3U3VTzA2maezZ+BNC/AAz5zg65Z5dZRBP1hjPCHQYXRCGNRYCzZd5QAXkKiccnpxCgZNJBskgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271253; c=relaxed/simple;
	bh=vl6mPTl8AyI0KWC0zPhPBaFqm0CNVVoTslplmpYy+Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ch88RmlCoOjdpTRL4yINWPzfpwBBbSAeekt7LYCBRCYgWuVbR9xbAnW0xmaWdOr0o04gm7fAiHca+cYt2vvZjRuW42ZSrUQo7NGdmOnlGmem4u5wyO/NAYcDFamCVLC062gWpzeqP2C2yx1XeJgM+0yq+0oa3QLaT4Iz6PWvI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XzPhvnul; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U53IQZ027434;
	Wed, 30 Oct 2024 06:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Bed41nFljZxsryZu4KWbgURJ48E0zcqMvdyiCc3zhg=; b=XzPhvnulsW2BYLz0
	vxzDR62v7uc8iqQut7/p9CeNpKoDEssv7MXNXFWqnmkzagKb6BkSCvS/AtcOmAyz
	CkuZYXhGjw3hfsr0c7KryF0BoVVk9xYPkeQXpvQMymQI/TrxHi5pOnjPCEcqSeYr
	y+WOu1QzHfGGPg9LkVzrQHt0xFhlisnMFdDWwlwbYtl/YukkVVYo+cqyqI2NR+pz
	mYZkGQe7n9ELT0bgZGzKhiKe47ydkV549E9DVLM9sP121Sy8zX68z7bTVd1DUhLA
	E5eGp4IohWWYKfcLS9UsNJNkScT1EUAOxNrY7hUqma26caHEgnNFFHFRfJSbB6n0
	IQISmQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k1p3295x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 06:54:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U6s5oA028371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 06:54:05 GMT
Received: from [10.216.56.67] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 23:54:00 -0700
Message-ID: <2ac4604c-a765-48b1-84b2-8979f18c29a7@quicinc.com>
Date: Wed, 30 Oct 2024 12:23:57 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
 <20241026123058.28258-2-quic_rlaggysh@quicinc.com>
 <7k2vnjop6xyshquqlbe22gm7o5empeluvsohfmq5ulnaas3keb@yzomhzi4w7vf>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <7k2vnjop6xyshquqlbe22gm7o5empeluvsohfmq5ulnaas3keb@yzomhzi4w7vf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9av_cSIHK9y2bkx_taKcP9ulY1WI181_
X-Proofpoint-ORIG-GUID: 9av_cSIHK9y2bkx_taKcP9ulY1WI181_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300052



On 10/26/2024 8:15 PM, Dmitry Baryshkov wrote:
> On Sat, Oct 26, 2024 at 12:30:56PM +0000, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>> SA8775P SoCs.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> index 21dae0b92819..042ca44c32ec 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> @@ -34,6 +34,10 @@ properties:
>>                - qcom,sm8250-epss-l3
>>                - qcom,sm8350-epss-l3
>>            - const: qcom,epss-l3
>> +      - items:
>> +          - enum:
>> +              - qcom,sa8775p-epss-l3
>> +          - const: qcom,epss-l3-perf
> 
> Why is it -perf? What's so different about it?

The EPSS instance in SA8775P uses PERF_STATE register instead of REG_L3_VOTE to scale L3 clocks.
So adding new generic compatible "qcom,epss-l3-perf" for PERF_STATE register based l3 scaling.


> 
>>  
>>    reg:
>>      maxItems: 1
>> -- 
>> 2.39.2
>>
> 


