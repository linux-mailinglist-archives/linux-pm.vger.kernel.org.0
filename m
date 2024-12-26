Return-Path: <linux-pm+bounces-19765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164069FCBC2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FE91621E0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB473176;
	Thu, 26 Dec 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JKVG1B0U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D57647;
	Thu, 26 Dec 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735229621; cv=none; b=ckV1pFDCZ/+ZeJJLen7bdgPdXqO1VDJkHKeJgO+N2dltsVvDm/6CtMGzKXYLJ6cebpOQt0uW0Cq+XFthuuIApXYuvINDXdIkk8KazZG33BDnFVTYMf4fddTryhpk6Wb9UuOKkPyZrj+WnJgfJnrvD49V1AE51tjzf78EmqrMxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735229621; c=relaxed/simple;
	bh=R8gTBKypijmWyZend+EQ7DZwu+TKMr8gYHaZkpEQjTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l7WhqjzOfHqi3g8ckqJoFWc9IbAbBSqkRoG/fCeYx39Y27TjwVM2YnWZy+vTf+T1G5kQId9c3qiEUx8Fzj4uPfuvCoCUN2vpEts7IfLORK+KHmBQdiYfzNyfAwPlluCuy58iS9opSoBHOXs9gUznBQS9wyQli19yLuJalZlH0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JKVG1B0U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQ6ttAo005102;
	Thu, 26 Dec 2024 16:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ivBD8d5gBzuOH2t6w4NLCLVafrwFu+cn5L/5FCyuZ84=; b=JKVG1B0U8c6rZN0y
	rynL9pI56S+U50H+6aDqIcOzPqeV8oikR+uVRruQ+tPK99bEU/xURm+oxGG5WsVC
	veVNU4HpnKjOHOPM/kPg60ORMBQA2QlgGS63j8LsHI9SvsT3fmaReo0EN8HZ0eUK
	a/P2rHFfeSgaINcbWhA1NaTZ7Tj559flB7wWpYwPgpS350AkwuNatkJozQt9nSEp
	rC3uArT9Jq7NIo5aFTC07YWUlqJHogohqLgML2pxzPzuNylGAO2NKpMSSFeVzg48
	4lOlgzLbhNw2wk/xFDxTX7qgXWoK3O4GGceos+ER5amIpeJBhUVJYj1RnXmoOZp4
	dIUn9A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43s2a8uf1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 16:13:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BQGDT2G026513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 16:13:29 GMT
Received: from [10.216.0.11] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Dec
 2024 08:13:23 -0800
Message-ID: <dafa6ce0-47f6-4e6a-882b-278c3b51e768@quicinc.com>
Date: Thu, 26 Dec 2024 21:43:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/4] interconnect: qcom: Add multidev EPSS L3 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <quic_mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
 <20241125174511.45-2-quic_rlaggysh@quicinc.com>
 <2b95cc25-a842-4edd-a5f3-2351038d264e@oss.qualcomm.com>
 <5egskepgsr52ulnbw7jhvazfjayg5ge5vhg6pi7mllyxx2vwqw@a2ojvabzd36o>
 <0881289f-db05-4e33-91a7-ffd415c2f37e@oss.qualcomm.com>
 <b2zicviv7nyl3izj2fzwzm2cp5phlxufaaoyi7e3g3iyxcyw56@iufgz33tsk33>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <b2zicviv7nyl3izj2fzwzm2cp5phlxufaaoyi7e3g3iyxcyw56@iufgz33tsk33>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A9yg5quDy3VUFdUWd3ivV4YfB9OYoBb6
X-Proofpoint-ORIG-GUID: A9yg5quDy3VUFdUWd3ivV4YfB9OYoBb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412260143



On 11/30/2024 9:02 PM, Dmitry Baryshkov wrote:
> On Sat, Nov 30, 2024 at 04:12:49PM +0100, Konrad Dybcio wrote:
>> On 30.11.2024 4:09 PM, Dmitry Baryshkov wrote:
>>> On Sat, Nov 30, 2024 at 01:49:56PM +0100, Konrad Dybcio wrote:
>>>> On 25.11.2024 6:45 PM, Raviteja Laggyshetty wrote:
>>>>> EPSS on SA8775P has two instances which requires creation of two device
>>>>> nodes with different compatible and device data because of unique
>>>>> icc node id and name limitation in interconnect framework.
>>>>> Add multidevice support to osm-l3 code to get unique node id from IDA
>>>>> and node name is made unique by appending node address.
>>>>>
>>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> +	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>>  	qp->base = devm_platform_ioremap_resource(pdev, 0);
>>>>>  	if (IS_ERR(qp->base))
>>>>>  		return PTR_ERR(qp->base);
>>>>> @@ -242,8 +262,13 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>>>>  
>>>>>  	icc_provider_init(provider);
>>>>>  
>>>>> +	/* Allocate unique id for qnodes */
>>>>> +	for (i = 0; i < num_nodes; i++)
>>>>> +		qnodes[i]->id = ida_alloc_min(&osm_l3_id, OSM_L3_NODE_ID_START, GFP_KERNEL);
>>>>
>>>> As I've said in my previous emails, this is a framework-level problem.
>>>>
>>>> Up until now we've simply silently ignored the possibility of an
>>>> interconnect provider having more than one instance, as conveniently
>>>> most previous SoCs had a bunch of distinct bus masters.
>>>>
>>>> Currently, debugfs-client.c relies on the node names being unique.
>>>> Keeping them as such is also useful for having a sane sysfs/debugfs
>>>> interface. But it's not always feasible, and a hierarchical approach
>>>> (like in pmdomain) may be a better fit.
>>>>
>>>> Then, node->id is used for creating links, and we unfortunately cannot
>>>> assume that both src and dst are within the same provider.
>>>> I'm not a fan of these IDs being hardcoded, but there are some drivers
>>>> that rely on that, which itself is also a bit unfortunate..
>>>>
>>>>
>>>> If Mike (who introduced debugfs-client and is probably the main user)
>>>> doesn't object to a small ABI break (which is "fine" with a debugfs
>>>> driver that requires editing the source code to be compiled), we could
>>>> add a property within icc_provider like `bool dynamic_ids` and have an
>>>> ICC-global IDA that would take care of any conflicts.
>>>
>>> Frankly speaking, I think this just delays the inevitable. We have been
>>> there with GPIOs and with some other suppliers. In my opinion the ICC
>>> subsystem needs to be refactored in order to support linking based on
>>> the supplier (fwnode?) + offset_id, but that's a huuuge rework.
>>
>> I thought about this too, but ended up not including it in the email..
>>
>> I think this will be more difficult with ICC, as tons of circular
>> dependencies are inevitable by design and we'd essentially have to
>> either provide placeholder nodes (like it's the case today) or probe
>> only parts of a device, recursively, to make sure all links can be
>> created
> 
> Or just allow probing, but then fail path creation. It will be a
> redesign, but I think it is inevitable in the end.
> 

There are no two instances of l3 or NoC on any SoC except qcs9100 and
qcs8300. I dont expect any new SoC as well.
As second instance is needed only on qcs9100 and qcs8300, I am keeping
the patch (patchset v6) as is and limit the dynamic id addition to l3
provider only.

>>
>> Konrad
>>
>>>> Provider drivers whose consumers don't already rely on programmatical
>>>> use of hardcoded IDs *and* don't have cross-provider links could then
>>>> enable that flag and have the node IDs and names set like you did in
>>>> this patch. This also sounds very useful for icc-clk.
>>>
> 


