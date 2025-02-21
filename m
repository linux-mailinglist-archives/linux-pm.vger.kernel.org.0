Return-Path: <linux-pm+bounces-22621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78898A3F2B2
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 12:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBBF19C1AF1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6FF2080E4;
	Fri, 21 Feb 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nuAW+rjC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB06207A2E;
	Fri, 21 Feb 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136184; cv=none; b=Nu8iFF78OKRxCajG4l1nv1U4HyN+s4EBKcFgmXyf0DQ64mPxuWPrbrDAMhgb+UQNRN5X22LI8TaK8A7DFNz7BG7zJeA1PgN5OOZkbhBTK14WWMSnVmRoZG8XYdMv5od+tJZuSZeBXvIsRcexuY+/aj+kR0YHVzKWtrBzO61Uyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136184; c=relaxed/simple;
	bh=h3iqELhA28DBuUskBm3qO3i9yaA0BWW3ouF2OXutVxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XLxOPmCXW+W8m6p2hrvbpQw5mQFG4m0cKPo8znNU09+CYOrR/5gFmo9K15ZnzJc0Rq2a2hbxlNKSydjA/Cuppz2G1RGyK6sXnpX8Sw+HO8K5FQDF7ote/YaPQNQ/uwJgkxSg8/9S1raUPF8dgG15OyyWTTtxPmul6JWJCkvRsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nuAW+rjC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L5cnNX011722;
	Fri, 21 Feb 2025 11:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hf2PUWm8OQyikV9j6rNMCeXRUVGpnIjAHnXg5g+Qo58=; b=nuAW+rjC1FirxBRM
	YwVO8y7quHAyvYVB0WYjM7ZxYQ5ODVFk18ReU8eEbJdCIoEx+HW0ycb075SxYHnR
	Q1edQEv5l1eDpykBWifbBgx4pqSoSmqO1Tcd5eafYqR5d0yWiyAKR82DoHDaW0OE
	k8TpHLjdCQCEj9xDI8PEzyMgVNoyUp+BsJmgPOmHsdi3vOGvgGXYGrSMmclQRBg/
	jguSLKo3wObyRuDg8P+LbxVvOvZPlGJEeYBZrkDiazPDjA+OVOrRXCXqQ8eYcdh5
	xV/UdO9Xk75Ie7t1JS1HyQKS6dT6sf9SMeYzhyWMXYTvdnA93Us8TuUMcVM5AhdW
	wUZvGQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3spsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 11:09:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51LB9WZN017409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 11:09:32 GMT
Received: from [10.216.53.96] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Feb
 2025 03:09:26 -0800
Message-ID: <1b9f1bec-5fb6-4afe-bbd5-94d19aa4a4fa@quicinc.com>
Date: Fri, 21 Feb 2025 16:39:23 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 3/7] interconnect: qcom: Add multidev EPSS L3 support
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
 <20250205182743.915-4-quic_rlaggysh@quicinc.com>
 <fclfywuw3p43pcj42gi2w5kutvnto3rcrdng2zl2pzgpvz7dis@cjx2e6v4skfm>
 <4482b900-2ec0-44c1-9b68-3b403a1df7d8@quicinc.com>
 <ii33reyezniliytyom2u6k33nqcdrf5c444s76uwb2rs2hodno@q6exlaj6pqug>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <ii33reyezniliytyom2u6k33nqcdrf5c444s76uwb2rs2hodno@q6exlaj6pqug>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pKqeWj13H47ZbAjSWLONBOmtpos-BmUD
X-Proofpoint-GUID: pKqeWj13H47ZbAjSWLONBOmtpos-BmUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502210084



On 2/17/2025 6:38 AM, Dmitry Baryshkov wrote:
> On Sun, Feb 16, 2025 at 09:58:41PM +0530, Raviteja Laggyshetty wrote:
>>
>>
>> On 2/10/2025 4:27 PM, Dmitry Baryshkov wrote:
>>> On Wed, Feb 05, 2025 at 06:27:39PM +0000, Raviteja Laggyshetty wrote:
>>>> EPSS on SA8775P has two instances, necessitating the creation of two
>>>> device nodes with different compatibles due to the unique ICC node ID
>>>> and name limitations in the interconnect framework. Add multidevice
>>>> support for the OSM-L3 provider to dynamically obtain unique node IDs
>>>> and register with the framework.
>>>>
>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>>> ---
>>>>  drivers/interconnect/qcom/osm-l3.c | 46 +++++++++++++++++-------------
>>>>  1 file changed, 26 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
>>>> index 6a656ed44d49..da2d82700b5a 100644
>>>> --- a/drivers/interconnect/qcom/osm-l3.c
>>>> +++ b/drivers/interconnect/qcom/osm-l3.c
>>>> @@ -1,6 +1,7 @@
>>>>  // SPDX-License-Identifier: GPL-2.0
>>>>  /*
>>>>   * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>>>> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>   */
>>>>  
>>>>  #include <linux/args.h>
>>>> @@ -33,6 +34,7 @@
>>>>  #define EPSS_REG_PERF_STATE		0x320
>>>>  
>>>>  #define OSM_L3_MAX_LINKS		1
>>>> +#define ALLOC_DYN_ID			-1
>>>
>>> This should be defined by ICC framework.
>>
>> ok, I will move this to framework.
>>>
>>>>  
>>>>  #define to_osm_l3_provider(_provider) \
>>>>  	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>>>> @@ -55,46 +57,40 @@ struct qcom_osm_l3_icc_provider {
>>>>   */
>>>>  struct qcom_osm_l3_node {
>>>>  	const char *name;
>>>> -	u16 links[OSM_L3_MAX_LINKS];
>>>> -	u16 id;
>>>> +	struct qcom_osm_l3_node *links[OSM_L3_MAX_LINKS];
>>>> +	int id;
>>>>  	u16 num_links;
>>>>  	u16 buswidth;
>>>>  };
>>>>  
>>>>  struct qcom_osm_l3_desc {
>>>> -	const struct qcom_osm_l3_node * const *nodes;
>>>> +	struct qcom_osm_l3_node * const *nodes;
>>>>  	size_t num_nodes;
>>>>  	unsigned int lut_row_size;
>>>>  	unsigned int reg_freq_lut;
>>>>  	unsigned int reg_perf_state;
>>>>  };
>>>>  
>>>> -enum {
>>>> -	OSM_L3_MASTER_NODE = 10000,
>>>> -	OSM_L3_SLAVE_NODE,
>>>> -};
>>>> -
>>>> -#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
>>>> -	static const struct qcom_osm_l3_node _name = {			\
>>>> +#define DEFINE_QNODE(_name, _buswidth, ...)			\
>>>> +	static struct qcom_osm_l3_node _name = {			\
> 
> No. Global data _must_ remain const.

Ok, will make the global struct const.

> 
>>>>  		.name = #_name,						\
>>>> -		.id = _id,						\
>>>>  		.buswidth = _buswidth,					\
>>>>  		.num_links = COUNT_ARGS(__VA_ARGS__),			\
>>>>  		.links = { __VA_ARGS__ },				\
>>>>  	}
>>>>  
>>>> -DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
>>>> -DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
>>>> +DEFINE_QNODE(osm_l3_slave, 16);
>>>> +DEFINE_QNODE(osm_l3_master, 16, &osm_l3_slave);
>>>>  
>>>> -static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>>>> +static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>>>>  	[MASTER_OSM_L3_APPS] = &osm_l3_master,
>>>>  	[SLAVE_OSM_L3] = &osm_l3_slave,
>>>>  };
>>>>  
>>>> -DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
>>>> -DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
>>>> +DEFINE_QNODE(epss_l3_slave, 32);
>>>> +DEFINE_QNODE(epss_l3_master, 32, &epss_l3_slave);
>>>>  
>>>> -static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>>>> +static struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>>>>  	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
>>>>  	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>>>>  };
>>>> @@ -164,7 +160,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>>>  	const struct qcom_osm_l3_desc *desc;
>>>>  	struct icc_onecell_data *data;
>>>>  	struct icc_provider *provider;
>>>> -	const struct qcom_osm_l3_node * const *qnodes;
>>>> +	struct qcom_osm_l3_node * const *qnodes;
>>>>  	struct icc_node *node;
>>>>  	size_t num_nodes;
>>>>  	struct clk *clk;
>>>> @@ -242,6 +238,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>>>  
>>>>  	icc_provider_init(provider);
>>>>  
>>>> +	/*Initialize IDs to ALLOC_DYN_ID to indicate dynamic id allocation*/
>>>> +	for (i = 0; i < num_nodes; i++)
>>>> +		qnodes[i]->id = ALLOC_DYN_ID;
>>>
>>> This can be initialized statically.
>>
>> There are two instances of EPSS L3 and the target specific compatible
>> data is global which requires resetting the IDs for the second instance
>> probe. If we don't the reset the IDs back to ALLOC_DYN_ID, then ICC
>> framework assumes that ID has been already allocated and doesn't create
>> the new ICC nodes for the second instance.
> 
> Well, don't use global data for shared purposes. Consider both your
> instances probing at the same time. So, please drop the
> qcom_osm_l3_node.id, pass ALLOC_DYN_ID directly to the
> icc_node_create(), store returned nodes in a local array and pass node
> pointers to icc_link_create().
> 

Will pass ALLOC_DYN_ID as argument to create node instead of
qcom_osm_l3_node.id and avoid its usage.
Instead of creating the local array to store the pointers, will make use
of icc_onecell_data which stores all the nodes present in the provider.
>>
>>>
>>>> +
>>>>  	for (i = 0; i < num_nodes; i++) {
>>>>  		size_t j;
>>>>  
>>>> @@ -250,14 +250,19 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>>>  			ret = PTR_ERR(node);
>>>>  			goto err;
>>>>  		}
>>>> +		qnodes[i]->id = node->id;
>>>
>>> Should not be necessary.
>> This is required, each qnode corresponds to a ICC node in framework and
>> some nodes get created in icc_node_create() API and some in
>> icc_link_create() API, to have a track of node creation qnode->id is
>> used, hence initializing qnode->id with id allocated during icc node
>> creation and avoid creation of duplicate nodes.
> 
> Basically, no. You cannot do that. Create nodes first, create links
> afterwards.

Sure, Will create nodes first and then create the links.
> 
>>>
>>>>  
>>>>  		node->name = qnodes[i]->name;
>>>>  		/* Cast away const and add it back in qcom_osm_l3_set() */
>>>>  		node->data = (void *)qnodes[i];
>>>>  		icc_node_add(node, provider);
>>>>  
>>>> -		for (j = 0; j < qnodes[i]->num_links; j++)
>>>> -			icc_link_create(node, qnodes[i]->links[j]);
>>>> +		for (j = 0; j < qnodes[i]->num_links; j++) {
>>>> +			struct qcom_osm_l3_node *link_node = qnodes[i]->links[j];
>>>> +
>>>> +			icc_link_create(node, link_node->id);
>>>
>>> Please add icc_link_nodes() (or something like that), taking two struct
>>> icc_node instances. Then you can use it here, instead of reading back
>>> the ID. Ideally the 'ID' should become an internal detail which is of no
>>> concern for the ICC drivers.
>>>
>>
>> Instead of reading back the link node id from the framework, I will call
>> icc_node_create before calling the icc_link_create() API and assign the
>> allocated id to respective qnode in the following way:
>>
>> struct qcom_osm_l3_node *qn_link_node = qnodes[i]->links[j];
>> struct icc_node *link_node = icc_node_create(qnodes[i]->links[j]->id);
>> qn_link_node->id = link_node->id;
>> icc_link_create(node, link_node->id);
>>
>> This looks cleaner than reading back the id.
> 
> As you might have guessed from the the earlier comments, no. Don't write
> _anything_ to a global data.
> 

Will not modify or update the global data.
>>
>>
>>>> +			link_node->id = (node->links[node->num_links - 1])->id;
>>>> +		}
>>>>  
>>>>  		data->nodes[i] = node;
>>>>  	}
>>>> @@ -278,6 +283,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>>>  static const struct of_device_id osm_l3_of_match[] = {
>>>>  	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
>>>>  	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
>>>> +	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
>>>>  	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
>>>>  	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
>>>>  	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
>>>> -- 
>>>> 2.39.2
>>>>
>>>
>>
> 


