Return-Path: <linux-pm+bounces-16469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51909B087B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 17:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBB81F24411
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9D2158A36;
	Fri, 25 Oct 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XzMahmc/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13221A4D1;
	Fri, 25 Oct 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870694; cv=none; b=J67Q/D9lzUQvU4qwBWMjlfJp4vdDE9E/FXuxgGRYAqHc7PFUOYoN1yhUKcH5h2rhnR1NbkMwrIqmFkibcVWoV0NAdvG6zmOriQmZ9ELPvtueDs1zu8hJf/OnDcAxu7cSfzC4H8Yus+PCLTKR3UUa4KwwjiUt49RgfFI5Jo9SDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870694; c=relaxed/simple;
	bh=nytdE+OMqaf0MoPj32sj8DwLwDlmjXVUXFFT4d6RQbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s4u5z7KY0NKfMlYeerM8Dpz1kmURZNydnj8bPRk9LAF5Hn/Tjh5xajQs8NCEBRnZ17pe2uPzfn6+lQPcaIw8be/tGa3dnyfy0YmtoEUFkjH4adA9wCGAtBdfckoj/+518VgxoK52BsOYHp9zDIP5k0QAl4m96JKWhLBsIvWOtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XzMahmc/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P9tG1A029632;
	Fri, 25 Oct 2024 15:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U84hYf+i/sQVc62LD3GlieQxSAgIZVxC07W6ix6zSQ4=; b=XzMahmc/iYB8jFa6
	qxR3F4TGLh8WDKRzTY2UNNAmm1SIAyh8DK2fUnVrADxLXBTY96TvFphgNqMtDdqr
	Mvah2hbPT8JlXix6Sm549iAN75xE64SGRuYnmCLra1kREs7InmZtY2qJK2CH4YN7
	xcjFIlXwXnCx7WgNCB7O0aZy5cPvBbSJRsvaPCVPZKHmlExbdgCLAjwkF2e4mamE
	cVxAHzInkUR2Dj6zDD+8RdGbGAkkHDYaJB3o6eRXJVJPajfQ5EkEf2uJvLSxyS7g
	/pEoCFMAQOKhnSvSgSCGSAdfDqmMLOj2QYrgWpwWleyeX6kctkg66SLZbmNFcHFx
	e2W8FQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3w9prx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 15:38:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PFc8lL014283
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 15:38:08 GMT
Received: from [10.216.47.209] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 08:38:03 -0700
Message-ID: <6b89de85-58c0-4808-9a33-6ee7dc26611d@quicinc.com>
Date: Fri, 25 Oct 2024 21:08:00 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] interconnect: qcom: Add EPSS L3 support on SA8775P
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_okukatla@quicinc.com>,
        <quic_mdtipton@quicinc.com>
References: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
 <20240904171209.29120-4-quic_rlaggysh@quicinc.com>
 <c3efb01d-2138-4b79-97a1-653b7bd531d0@kernel.org>
 <bfcc65b2-97a4-4353-a2fd-dce927c53428@quicinc.com>
 <49aa8205-6324-412d-b03d-c2b3f738cc98@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <49aa8205-6324-412d-b03d-c2b3f738cc98@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zBqaFD_DP8udcG2lulO2oi1TXApw3z8v
X-Proofpoint-GUID: zBqaFD_DP8udcG2lulO2oi1TXApw3z8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250121



On 9/6/2024 10:00 PM, Krzysztof Kozlowski wrote:
> On 06/09/2024 17:32, Raviteja Laggyshetty wrote:
>>
>> On 9/4/2024 11:52 PM, Krzysztof Kozlowski wrote:
>>> On 04/09/2024 19:12, Raviteja Laggyshetty wrote:
>>>> +
>>>>  static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
>>>>  	.nodes = epss_l3_nodes,
>>>>  	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
>>>> @@ -284,6 +307,10 @@ static const struct of_device_id osm_l3_of_match[] = {
>>>>  	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
>>>>  	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
>>>>  	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
>>>> +	{ .compatible = "qcom,sa8775p-epss-l3-cl0",
>>>> +	  .data = &epss_l3_perf_state },
>>> Don't grow it but express compatibility.
>> ok. Will rename compatible from "qcom,sa8775p-epss-l3-cl0" to "qcom,sa8775p-epss-l3".
> 
> This won't solve the problem. You still grow the table, right?

Falling back to "qcom,epss-l3" won't work because we need to vote into perf state register.
I am introducing a new fallback compatible "qcom,epss-l3-perf" for perf voting, which can be used for upcoming qcs8300.

epss_l3_cl0: interconnect@18590000 {
       compatible = "qcom,sa8775p-epss-l3", "qcom,epss-l3-perf";	   
};

> 
> Best regards,
> Krzysztof
> 


