Return-Path: <linux-pm+bounces-16468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ACD9B0873
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E031F242A6
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C415ADAB;
	Fri, 25 Oct 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kCQBI6v3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82921A4DC;
	Fri, 25 Oct 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870625; cv=none; b=SWJ4ONW7bqoCg3qyeiopG/3aRpj87XBM8yuIgobLKD1P7lnhoHk4YkwkvNQB/OAyEj4DXanI/fMDvH7H0Qj1oiCgWOMus281lTxlO3PxUnEHZGtCwfdTd6qTjZhrCpaynsJuYFLcJ3PpDSgpIRj/eT7468sM25WAc37vsXhEZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870625; c=relaxed/simple;
	bh=U7a/FhaEaBlq9Y+GGNScoitt5QffxKkyGd7hLp9aPdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IkOjji1RTyXsNd28aLXKrxOniSxTx76ucxPq6NiNZP/eq99VyQtZKGzPmCLsofdJd8Zi8zkGvjMERS8L35+oCvkcsPsMFldrO91uVO0s7aMjUU8fae81FoZcBLtOqOxlMmyUw78S/jRuhruSuY05w/TvuSiBxpPZW/aB5VqOVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kCQBI6v3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PB5rAP015472;
	Fri, 25 Oct 2024 15:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	myh7xxzrJi7sDbWl9S5raZY4azAtv3tbnoi2CofFHyw=; b=kCQBI6v3bHbU+FKV
	pnt7uOqm/HG1KfLlPcXxur/S7fvAAndsxHbbWXNY/tpS1nf+XndgofFH6bjjebhJ
	k6VUSa5z+OoTFXs7IBEAtSbE3c/6dZlPXMGwXgOW3ymiQrxeOSLRkrkRw1aeTGfo
	sAXf7umI22wMIDkety2g91afBk1QaBBc6/u+Yh/K3o4SbpfiscchIOHy5qAM6rs4
	Ebvi4FtDtBRkBl41wjU/e3oPShZdcmRRMIJYt2HcQk5ocb45erepaUK3vrSql6ty
	lDIWkZl6LpNeISJnFGeqU5tFSSoJe2zB8MMuVY3d9eQJL80WZAl9OgEx2CCF19jc
	oMJNGA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ga5jrx5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 15:36:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PFawll013357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 15:36:58 GMT
Received: from [10.216.47.209] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 08:36:53 -0700
Message-ID: <672ceb3d-1b19-461f-b17c-eaa50d936aa5@quicinc.com>
Date: Fri, 25 Oct 2024 21:06:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add EPSS L3 compatible for
 SA8775P
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
 <20240904171209.29120-2-quic_rlaggysh@quicinc.com>
 <86fad872-ccfe-4aa2-906c-c938946af8b7@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <86fad872-ccfe-4aa2-906c-c938946af8b7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AFNZojUn8lZUg60FfJuXSEKDSOdEm966
X-Proofpoint-GUID: AFNZojUn8lZUg60FfJuXSEKDSOdEm966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250121



On 9/4/2024 11:53 PM, Krzysztof Kozlowski wrote:
> On 04/09/2024 19:12, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>> SA8775P SoCs.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> index 21dae0b92819..de2c59ddc94a 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> @@ -33,6 +33,8 @@ properties:
>>                - qcom,sm6375-cpucp-l3
>>                - qcom,sm8250-epss-l3
>>                - qcom,sm8350-epss-l3
>> +              - qcom,sa8775p-epss-l3-cl0
>> +              - qcom,sa8775p-epss-l3-cl1
> 
> Your device driver change suggests that cl0 is compatible with other
> variants.
> 
> And what about generic fallback here? Can it be used and device will be
> operating correctly?
> 

Falling back to "qcom,epss-l3" won't work because we need to vote into perf state register.
I am introducing a new fallback compatible "qcom,epss-l3-perf" for perf voting, which can be used for upcoming qcs8300.

epss_l3_cl0: interconnect@18590000 {
       compatible = "qcom,sa8775p-epss-l3", "qcom,epss-l3-perf";	   
};

> Best regards,
> Krzysztof
> 


