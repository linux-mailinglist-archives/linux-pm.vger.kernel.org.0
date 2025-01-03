Return-Path: <linux-pm+bounces-19942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA1A00A45
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 15:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0C33A0F82
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC41F9F75;
	Fri,  3 Jan 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KlaLbkR3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715581F9428;
	Fri,  3 Jan 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735913264; cv=none; b=pLKUgwwcN7mzKbhickmvPKIaZeu8So4sIaApmiZNGZ3vEsn+MUM3UiAp68Rp8GyitaZF+/QHc+hT8aBTw0oRsrIgek8qls6IevSEFUW4gyhdXOunbqpJlr++XEnM2v3Q6LAzwYqZ6A+4xn/c8/OnhIdQUPESYkEBctDZjY9r3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735913264; c=relaxed/simple;
	bh=TtSY5XtET3VlePieWkjgXvHJDZQtKE6czFZuQo1BULA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lcl6OwTEsn0d9zuX+NrUmYUoUGSmJqcDMcU1trfFVoKi7VnSbsPznT9mXpzG5rxMCZmI0XcXdnIr3aNrGpgcYZwcxyTKtyninHCrcSVWnWuZ5i5UiqRzsEc6zWn6PWJYFDW+/QtcXUwRnJDLz7IqsJ8aHmTyz1BSv7BFWyg002k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KlaLbkR3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5038Kirw010162;
	Fri, 3 Jan 2025 14:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R6NTduAePc8ZwaKvcu36TnjGrnGXU936fDZ6o+O8DIo=; b=KlaLbkR3d7V4Ef1H
	oRic7Nf8Scdxt1Oji8wLk3rGs7k+ogGq/IQfA3nMjfyD6bqgFIKFf4zQ77N3/hig
	BV/L3LppT6D6v+X9U/YBEU6SThuD3KfGG6Nsu2OOSLvIDVgoDYdC6PXlpIr/H3Md
	hMeuCcc2BH/RrlZpxzQtCaQkQs/pCWQa0QpjrTHL+enOPPHzLgvMemYLvz8T76U9
	L+nIrWvx4at2faBz1L28rSPg3fnDFKfRRqh1/1wZ6ypuAoKoZ+JP0SYmCNketwAA
	kcsOx5JlCL1r4tqiPHRLHelIfWb0Pfc0JL2quWHaKtc+u5f3Y5gYig5zGEEX1gxl
	PXIBOw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43xca50pum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 14:07:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 503E7Zh3021814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Jan 2025 14:07:35 GMT
Received: from [10.216.36.23] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 Jan 2025
 06:07:30 -0800
Message-ID: <193702a3-cdad-42d9-8434-b29c2cca0896@quicinc.com>
Date: Fri, 3 Jan 2025 19:37:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/4] interconnect: qcom: Add multidev EPSS L3 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        "Sibi
 Sankar" <quic_sibis@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
 <20241125174511.45-2-quic_rlaggysh@quicinc.com>
 <2b95cc25-a842-4edd-a5f3-2351038d264e@oss.qualcomm.com>
 <5egskepgsr52ulnbw7jhvazfjayg5ge5vhg6pi7mllyxx2vwqw@a2ojvabzd36o>
 <0881289f-db05-4e33-91a7-ffd415c2f37e@oss.qualcomm.com>
 <b2zicviv7nyl3izj2fzwzm2cp5phlxufaaoyi7e3g3iyxcyw56@iufgz33tsk33>
 <dafa6ce0-47f6-4e6a-882b-278c3b51e768@quicinc.com>
 <bbn3cbrxcagifpcjrzh5k7o5xvf6ajnf5y6zqnghex6sqwdt4t@mb3v6yfgehtv>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <bbn3cbrxcagifpcjrzh5k7o5xvf6ajnf5y6zqnghex6sqwdt4t@mb3v6yfgehtv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oPqdJ8YugvhkcPMEFE0654fOCtnwnZIt
X-Proofpoint-GUID: oPqdJ8YugvhkcPMEFE0654fOCtnwnZIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501030125



On 12/29/2024 6:53 AM, Dmitry Baryshkov wrote:
> On Thu, Dec 26, 2024 at 09:43:20PM +0530, Raviteja Laggyshetty wrote:
>>
>>
>> On 11/30/2024 9:02 PM, Dmitry Baryshkov wrote:
>>> On Sat, Nov 30, 2024 at 04:12:49PM +0100, Konrad Dybcio wrote:
>>>> On 30.11.2024 4:09 PM, Dmitry Baryshkov wrote:
>>>>> On Sat, Nov 30, 2024 at 01:49:56PM +0100, Konrad Dybcio wrote:
>>>>>> On 25.11.2024 6:45 PM, Raviteja Laggyshetty wrote:
>>>>>>> EPSS on SA8775P has two instances which requires creation of two device
>>>>>>> nodes with different compatible and device data because of unique
>>>>>>> icc node id and name limitation in interconnect framework.
>>>>>>> Add multidevice support to osm-l3 code to get unique node id from IDA
>>>>>>> and node name is made unique by appending node address.
>>>>>>>
>>>>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>>>>>> ---
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> +	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>> +
>>>>>>>  	qp->base = devm_platform_ioremap_resource(pdev, 0);
>>>>>>>  	if (IS_ERR(qp->base))
>>>>>>>  		return PTR_ERR(qp->base);
>>>>>>> @@ -242,8 +262,13 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>>>>>>  
>>>>>>>  	icc_provider_init(provider);
>>>>>>>  
>>>>>>> +	/* Allocate unique id for qnodes */
>>>>>>> +	for (i = 0; i < num_nodes; i++)
>>>>>>> +		qnodes[i]->id = ida_alloc_min(&osm_l3_id, OSM_L3_NODE_ID_START, GFP_KERNEL);
>>>>>>
>>>>>> As I've said in my previous emails, this is a framework-level problem.
>>>>>>
>>>>>> Up until now we've simply silently ignored the possibility of an
>>>>>> interconnect provider having more than one instance, as conveniently
>>>>>> most previous SoCs had a bunch of distinct bus masters.
>>>>>>
>>>>>> Currently, debugfs-client.c relies on the node names being unique.
>>>>>> Keeping them as such is also useful for having a sane sysfs/debugfs
>>>>>> interface. But it's not always feasible, and a hierarchical approach
>>>>>> (like in pmdomain) may be a better fit.
>>>>>>
>>>>>> Then, node->id is used for creating links, and we unfortunately cannot
>>>>>> assume that both src and dst are within the same provider.
>>>>>> I'm not a fan of these IDs being hardcoded, but there are some drivers
>>>>>> that rely on that, which itself is also a bit unfortunate..
>>>>>>
>>>>>>
>>>>>> If Mike (who introduced debugfs-client and is probably the main user)
>>>>>> doesn't object to a small ABI break (which is "fine" with a debugfs
>>>>>> driver that requires editing the source code to be compiled), we could
>>>>>> add a property within icc_provider like `bool dynamic_ids` and have an
>>>>>> ICC-global IDA that would take care of any conflicts.
>>>>>
>>>>> Frankly speaking, I think this just delays the inevitable. We have been
>>>>> there with GPIOs and with some other suppliers. In my opinion the ICC
>>>>> subsystem needs to be refactored in order to support linking based on
>>>>> the supplier (fwnode?) + offset_id, but that's a huuuge rework.
>>>>
>>>> I thought about this too, but ended up not including it in the email..
>>>>
>>>> I think this will be more difficult with ICC, as tons of circular
>>>> dependencies are inevitable by design and we'd essentially have to
>>>> either provide placeholder nodes (like it's the case today) or probe
>>>> only parts of a device, recursively, to make sure all links can be
>>>> created
>>>
>>> Or just allow probing, but then fail path creation. It will be a
>>> redesign, but I think it is inevitable in the end.
>>>
>>
>> There are no two instances of l3 or NoC on any SoC except qcs9100 and
>> qcs8300. I dont expect any new SoC as well.
>> As second instance is needed only on qcs9100 and qcs8300, I am keeping
>> the patch (patchset v6) as is and limit the dynamic id addition to l3
>> provider only.
> 
> As you could have noticed, it was suggested to change ICC subsystem API
> to allow the dynamic IDs. This isssue is not limited to just EPSS L3
> driver. So we were discussing if you or your colleagues could sign up
> for updating the interconnect subsystem to use node+arguments approach
> instead of using a global static ID list.
> 
This problem is limited to EPSS L3 only, NoCs are not having
multi instances and don't expect this problem to arise in new
chipsets. we have multi instances of L3 only on qcs9100 and
qcs8300. we can limit the dynamic ID creation for L3 provider.
If we update the interconnect framework also, we will have to
limit it to provider only.

Thanks,
Raviteja
>>
>>>>
>>>> Konrad
>>>>
>>>>>> Provider drivers whose consumers don't already rely on programmatical
>>>>>> use of hardcoded IDs *and* don't have cross-provider links could then
>>>>>> enable that flag and have the node IDs and names set like you did in
>>>>>> this patch. This also sounds very useful for icc-clk.
>>>>>
>>>
>>
> 


