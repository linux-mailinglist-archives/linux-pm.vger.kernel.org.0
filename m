Return-Path: <linux-pm+bounces-22168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1941A375C2
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 17:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120DE3A28A3
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B819ABC3;
	Sun, 16 Feb 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HSFCGGsD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822619A288;
	Sun, 16 Feb 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723346; cv=none; b=Da67Z3DyXB3CWZXk5m83eAzR8vYgbj9qA/nRpCJFCEq3zTDD/F3SSN16DteLUwiezmP0d/A3mYF7Y2QKyy+hutVA90GAUh3S+/nAtMSEInLAOSZ6/XQRc9QU/jb/mIT2/yni7zS8YApiv9uU5nlgZ1fh2+KKEHP70fubVkK+ijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723346; c=relaxed/simple;
	bh=BB1M9pZes0XnX0AWgNfSTRychSVPRlf6abBbzHDQJNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=htdkXJ2Db+f6kO1MIX/yLqhJC3znnAc7AGJERJRlEk9U9fqEXtbG/VAyDei3N9QI8YcTncuQ9g3C/kjaOx9ts5Sc0A7de+ZicEhf2VnI2jzjSkptWfMQYwWFxpka4fK/+7JSmr0DPgsXClG3dL3qll4VrF48+cfOz8YYB8VYIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HSFCGGsD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GEglqK028585;
	Sun, 16 Feb 2025 16:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fefc5d7Yr5GC1JM/WaUcFMRv4iRq/YkXdeYK/2W7m3E=; b=HSFCGGsDVfJ9kKqt
	779YGeriTSswDn3uG7qrLfBRULNFytdzsv1NNVL2rlc/wEPAhyqX41hadtO92T4l
	/IVcLkvupA5pYl/pSpW9MS3jRAxH2RX4s+ZJ9QKzh+voojN8P/opBOYRqZJy0OaI
	44cG13MFp1cXqNJaHipSvpYGHLRCD8cXDTMv6lZ8YKkkvxf2+SOmiWl6sb8BYwPQ
	tpEn/7uNyN/+521GfE/4bwu0VAJ5PlTYPj7LCCika9egStlGEUei9AZc0f3TdK8d
	ijMS9JGgpZENjT9Pv+jDipwvXjVhaYoMBmMicRWOk1WW6zBv7GjmF6wTSJPl3UMB
	GuaJxg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44tm3gta0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 16:28:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51GGSob0026790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 16:28:50 GMT
Received: from [10.216.15.99] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Feb
 2025 08:28:45 -0800
Message-ID: <4482b900-2ec0-44c1-9b68-3b403a1df7d8@quicinc.com>
Date: Sun, 16 Feb 2025 21:58:41 +0530
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
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <fclfywuw3p43pcj42gi2w5kutvnto3rcrdng2zl2pzgpvz7dis@cjx2e6v4skfm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3Pc0CGekBsZEW164Qp0G6t9N5dzBdf6q
X-Proofpoint-GUID: 3Pc0CGekBsZEW164Qp0G6t9N5dzBdf6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-16_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160149



On 2/10/2025 4:27 PM, Dmitry Baryshkov wrote:
> On Wed, Feb 05, 2025 at 06:27:39PM +0000, Raviteja Laggyshetty wrote:
>> EPSS on SA8775P has two instances, necessitating the creation of two
>> device nodes with different compatibles due to the unique ICC node ID
>> and name limitations in the interconnect framework. Add multidevice
>> support for the OSM-L3 provider to dynamically obtain unique node IDs
>> and register with the framework.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/osm-l3.c | 46 +++++++++++++++++-------------
>>  1 file changed, 26 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
>> index 6a656ed44d49..da2d82700b5a 100644
>> --- a/drivers/interconnect/qcom/osm-l3.c
>> +++ b/drivers/interconnect/qcom/osm-l3.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>   */
>>  
>>  #include <linux/args.h>
>> @@ -33,6 +34,7 @@
>>  #define EPSS_REG_PERF_STATE		0x320
>>  
>>  #define OSM_L3_MAX_LINKS		1
>> +#define ALLOC_DYN_ID			-1
> 
> This should be defined by ICC framework.

ok, I will move this to framework.
> 
>>  
>>  #define to_osm_l3_provider(_provider) \
>>  	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>> @@ -55,46 +57,40 @@ struct qcom_osm_l3_icc_provider {
>>   */
>>  struct qcom_osm_l3_node {
>>  	const char *name;
>> -	u16 links[OSM_L3_MAX_LINKS];
>> -	u16 id;
>> +	struct qcom_osm_l3_node *links[OSM_L3_MAX_LINKS];
>> +	int id;
>>  	u16 num_links;
>>  	u16 buswidth;
>>  };
>>  
>>  struct qcom_osm_l3_desc {
>> -	const struct qcom_osm_l3_node * const *nodes;
>> +	struct qcom_osm_l3_node * const *nodes;
>>  	size_t num_nodes;
>>  	unsigned int lut_row_size;
>>  	unsigned int reg_freq_lut;
>>  	unsigned int reg_perf_state;
>>  };
>>  
>> -enum {
>> -	OSM_L3_MASTER_NODE = 10000,
>> -	OSM_L3_SLAVE_NODE,
>> -};
>> -
>> -#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
>> -	static const struct qcom_osm_l3_node _name = {			\
>> +#define DEFINE_QNODE(_name, _buswidth, ...)			\
>> +	static struct qcom_osm_l3_node _name = {			\
>>  		.name = #_name,						\
>> -		.id = _id,						\
>>  		.buswidth = _buswidth,					\
>>  		.num_links = COUNT_ARGS(__VA_ARGS__),			\
>>  		.links = { __VA_ARGS__ },				\
>>  	}
>>  
>> -DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
>> -DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
>> +DEFINE_QNODE(osm_l3_slave, 16);
>> +DEFINE_QNODE(osm_l3_master, 16, &osm_l3_slave);
>>  
>> -static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>> +static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>>  	[MASTER_OSM_L3_APPS] = &osm_l3_master,
>>  	[SLAVE_OSM_L3] = &osm_l3_slave,
>>  };
>>  
>> -DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
>> -DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
>> +DEFINE_QNODE(epss_l3_slave, 32);
>> +DEFINE_QNODE(epss_l3_master, 32, &epss_l3_slave);
>>  
>> -static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>> +static struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>>  	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
>>  	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>>  };
>> @@ -164,7 +160,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  	const struct qcom_osm_l3_desc *desc;
>>  	struct icc_onecell_data *data;
>>  	struct icc_provider *provider;
>> -	const struct qcom_osm_l3_node * const *qnodes;
>> +	struct qcom_osm_l3_node * const *qnodes;
>>  	struct icc_node *node;
>>  	size_t num_nodes;
>>  	struct clk *clk;
>> @@ -242,6 +238,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  
>>  	icc_provider_init(provider);
>>  
>> +	/*Initialize IDs to ALLOC_DYN_ID to indicate dynamic id allocation*/
>> +	for (i = 0; i < num_nodes; i++)
>> +		qnodes[i]->id = ALLOC_DYN_ID;
> 
> This can be initialized statically.

There are two instances of EPSS L3 and the target specific compatible
data is global which requires resetting the IDs for the second instance
probe. If we don't the reset the IDs back to ALLOC_DYN_ID, then ICC
framework assumes that ID has been already allocated and doesn't create
the new ICC nodes for the second instance.

> 
>> +
>>  	for (i = 0; i < num_nodes; i++) {
>>  		size_t j;
>>  
>> @@ -250,14 +250,19 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  			ret = PTR_ERR(node);
>>  			goto err;
>>  		}
>> +		qnodes[i]->id = node->id;
> 
> Should not be necessary.
This is required, each qnode corresponds to a ICC node in framework and
some nodes get created in icc_node_create() API and some in
icc_link_create() API, to have a track of node creation qnode->id is
used, hence initializing qnode->id with id allocated during icc node
creation and avoid creation of duplicate nodes.
> 
>>  
>>  		node->name = qnodes[i]->name;
>>  		/* Cast away const and add it back in qcom_osm_l3_set() */
>>  		node->data = (void *)qnodes[i];
>>  		icc_node_add(node, provider);
>>  
>> -		for (j = 0; j < qnodes[i]->num_links; j++)
>> -			icc_link_create(node, qnodes[i]->links[j]);
>> +		for (j = 0; j < qnodes[i]->num_links; j++) {
>> +			struct qcom_osm_l3_node *link_node = qnodes[i]->links[j];
>> +
>> +			icc_link_create(node, link_node->id);
> 
> Please add icc_link_nodes() (or something like that), taking two struct
> icc_node instances. Then you can use it here, instead of reading back
> the ID. Ideally the 'ID' should become an internal detail which is of no
> concern for the ICC drivers.
>

Instead of reading back the link node id from the framework, I will call
icc_node_create before calling the icc_link_create() API and assign the
allocated id to respective qnode in the following way:

struct qcom_osm_l3_node *qn_link_node = qnodes[i]->links[j];
struct icc_node *link_node = icc_node_create(qnodes[i]->links[j]->id);
qn_link_node->id = link_node->id;
icc_link_create(node, link_node->id);

This looks cleaner than reading back the id.


>> +			link_node->id = (node->links[node->num_links - 1])->id;
>> +		}
>>  
>>  		data->nodes[i] = node;
>>  	}
>> @@ -278,6 +283,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  static const struct of_device_id osm_l3_of_match[] = {
>>  	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
>>  	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
>> +	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
>>  	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
>>  	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
>>  	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
>> -- 
>> 2.39.2
>>
> 


