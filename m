Return-Path: <linux-pm+bounces-22599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CF6A3ECC5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 07:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E3D19C3E3A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62C1FCD04;
	Fri, 21 Feb 2025 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VNtxgC0X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22311E5B78;
	Fri, 21 Feb 2025 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740118737; cv=none; b=uSkn+fUxtqTeDxb4+kTjBg3XiaRLbsaS7znPKTNNmpAG060Oz4VN59YSCqYTbZvL1J9dCvN3zPrl1iF1FCprNYz2/gED8YIZgQo1GbCliSVdUf1MAD6LpK5uPcOEBzT9LI1I/jWlmdcJ/HEaSWASqeFDh3okAuk0bAnBFh/hMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740118737; c=relaxed/simple;
	bh=8Tx8j0lvA4+fEQUw3oEHp9MRGre6e3kM75ckUoHtBvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mn5P8KODLvCsmyXUdcxqBqaO9WtgXHUy3iuQPVvTpsEDHqYLqnA+wcBFlM8zxSBS6TwSP8p0XuDfrTSEHJHUPYnYXKEmZT6GkdrMvO0izg2ffgDfuRHq2eqsAf0isZ8WdwicqexFzAVW/xhnO0dp0Ozsf3xJVazYng5VZoP7npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VNtxgC0X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L5xxQM015703;
	Fri, 21 Feb 2025 06:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8I4xAWQpxfpMRrlRqjIPNzPFALUHLmb31EkOijYpW6M=; b=VNtxgC0Xcwat/Hel
	II6pZygsOYs+4dL+Gw5OUM+0wJMQF25vPL7o8cxYnJWke32T6oQUL/Nzvp2HlWFU
	I0s3Pdhlb8UhvDM2YIlsQ7l+vEKC+AK4WghYBxKwtzsicPMCmOgVuGmXlmywhYz8
	lPrwh1qi0USSZ2+ekpYsVdVvdFfP5geo3DNZTEjIDOJajbjWB500rgWJywoBTC80
	jCIykSaJdI8Rq/ABSru4o56m1y7ew0t6p6AFl7Ab3mdUGaqxDNNf0MdAPPGmd6Ot
	0hr8TByMMgvZ2nbSXdFkbeDz5H29Ut1qWFh9meCuJqMOBvWVexKlrisufhd4vg4e
	ifntgA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44xku6r1pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 06:18:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51L6InsI031251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 06:18:49 GMT
Received: from [10.216.53.96] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 22:18:43 -0800
Message-ID: <17561e13-822b-440a-b62d-3d0eac1861d9@quicinc.com>
Date: Fri, 21 Feb 2025 11:48:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 2/7] interconnect: core: Add dynamic id allocation
 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <quic_mdtipton@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Sibi
 Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
 <20250205182743.915-3-quic_rlaggysh@quicinc.com>
 <bwiuhfgv4jw7tlwjqffgrxvskxbpf4forz46nn5g3vihz3z5od@w25y7hdprykf>
 <f40f6b9d-8f31-4ce6-a912-1aa484863d5e@quicinc.com>
 <6j576swreyqcyu7ryxtyojjmo7clfwb7fibw2aeuvif5vzexpq@du2farsldpti>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <6j576swreyqcyu7ryxtyojjmo7clfwb7fibw2aeuvif5vzexpq@du2farsldpti>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pg88hATFIV5t7CKqbUc97r4tMNKK-jOM
X-Proofpoint-GUID: pg88hATFIV5t7CKqbUc97r4tMNKK-jOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210046



On 2/17/2025 6:32 AM, Dmitry Baryshkov wrote:
> On Sun, Feb 16, 2025 at 10:08:51PM +0530, Raviteja Laggyshetty wrote:
>>
>>
>> On 2/10/2025 4:20 PM, Dmitry Baryshkov wrote:
>>> On Wed, Feb 05, 2025 at 06:27:38PM +0000, Raviteja Laggyshetty wrote:
>>>> The current interconnect framework relies on static IDs for node
>>>> creation and registration, which limits topologies with multiple
>>>> instances of the same interconnect provider. To address this, update
>>>> the interconnect framework APIs icc_node_create() and icc_link_create()
>>>> APIs to dynamically allocate IDs for interconnect nodes during creation.
>>>> This change removes the dependency on static IDs, allowing multiple
>>>> instances of the same hardware, such as EPSS L3.
>>>>
>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>>> ---
>>>>  drivers/interconnect/core.c | 13 ++++++++++++-
>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>>> index 9d5404a07e8a..40700246f1b6 100644
>>>> --- a/drivers/interconnect/core.c
>>>> +++ b/drivers/interconnect/core.c
>>>> @@ -20,6 +20,8 @@
>>>>  
>>>>  #include "internal.h"
>>>>  
>>>> +#define ICC_DYN_ID_START 10000
>>>> +
>>>>  #define CREATE_TRACE_POINTS
>>>>  #include "trace.h"
>>>>  
>>>> @@ -826,7 +828,12 @@ static struct icc_node *icc_node_create_nolock(int id)
>>>>  	if (!node)
>>>>  		return ERR_PTR(-ENOMEM);
>>>>  
>>>> -	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
>>>> +	/* negative id indicates dynamic id allocation */
>>>> +	if (id < 0)
>>>
>>> Nit: I think it might be better to add an explicit define for that and
>>> to decline all other negatdive values. Please leave us some room for
>>> future expansion.
>>>
>> Do you mean to replace the value of ALLOC_DYN_ID from -1 to some
>> positive value like 100000 and to use it as initial ID for the nodes
>> requiring the dynamic allocation ? This explicit define can be used as
>> check for dynamic allocation and also as argument to idr_alloc min value
>> argument. Is my interpretation of the comment correct ?
> 
> No, it is not. I asked to add an explicit define for -1 in the ICC
> framework and make icc_node_create_nolock() reject all other negative
> values.

Understood, will make the change as suggested.
> 
>>
>>>> +		id = idr_alloc(&icc_idr, node, ICC_DYN_ID_START, 0, GFP_KERNEL);
>>>> +	else
>>>> +		id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
>>>> +
>>>>  	if (id < 0) {
>>>>  		WARN(1, "%s: couldn't get idr\n", __func__);
>>>>  		kfree(node);
>>>> @@ -962,6 +969,10 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>>>>  	node->avg_bw = node->init_avg;
>>>>  	node->peak_bw = node->init_peak;
>>>>  
>>>> +	if (node->id >= ICC_DYN_ID_START)
>>>> +		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
>>>> +					    node->name, dev_name(provider->dev));
>>>> +
>>>>  	if (node->avg_bw || node->peak_bw) {
>>>>  		if (provider->pre_aggregate)
>>>>  			provider->pre_aggregate(node);
>>>> -- 
>>>> 2.39.2
>>>>
>>>
>>
> 


