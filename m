Return-Path: <linux-pm+bounces-20833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F5A1A201
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B41A188E33F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FFD20DD43;
	Thu, 23 Jan 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k4AePRlw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E46186A;
	Thu, 23 Jan 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628826; cv=none; b=RBCBn5mrxqryPk50J25Sggcaw5yglrd0i7TpUiQ/MZUvrpUa4QUpEpMZjFdu/fdtQPPqpNvdv7YOA/5YpG0K4T0uF1lPXsGVcJw25Zc0fz6p4K4hgv1M8EKg8MOjbI8lKH3U6BpitjVvut/45sOs9hd+Aw3hofUzbscTrGLtUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628826; c=relaxed/simple;
	bh=rNhX+mGVLDlxXBCfcI27SJX1oV/gtvNgZjrIKTR/guE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eQteMgSH3ceBn5X1Ms5uxl3cdiEJxNrG/0JY18dxe9+/XpxYf2f2ssZVKBjSFq1yakJArgIVutg74bIuF1Zta72gvdFTYYwc/tslaYYR612hCiOMfHF9xOGP5r9PBwKfVqc6Fc6layuWpl3fqCWpKKKvujimb8mUpGVr+EBr82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k4AePRlw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N6fm3T015645;
	Thu, 23 Jan 2025 10:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	29Du6oyo5iqjeNExZHXtY/IB4GNJgkj9T6QUvrEyiCM=; b=k4AePRlwVWFVVK9j
	cFrXG/FMETP8vBmPoeySWySZGLEdtxZbJYWgATEm4vFPuFgfrtZTOZXRqafb7CKP
	rDePAdOw5RGmHsKao6XXpWPcD8KDkjHQW4g3k55eAFlCX2cWoT8kgOaypoSlSCHM
	ccudZMcNAPg5/MIbwlBuxkOH6UDPGa1eCoCTYM9EeFXifsDyUr68fXB+H/Tqi5/s
	2rwDUAI62gZo/lxKTR3L/SHjQrvsC9dzmA0wTPXCjfwnvtnKNDKEkwOUdL3W9mND
	Jxz8/6+d49+3gl3VrPwQjI0WKDwBeJptDsKaGOWGrlw+1Iw07v3u8igJNYrQM/5Y
	DfF7yQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bgqrgj2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:40:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50NAeK0o019532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:40:20 GMT
Received: from [10.216.27.253] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 02:40:15 -0800
Message-ID: <5bd43ab2-68a0-47b7-b9c2-5b6d0726cc16@quicinc.com>
Date: Thu, 23 Jan 2025 16:10:10 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/5] interconnect: qcom: Add multidev EPSS L3 support
To: Bjorn Andersson <andersson@kernel.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <mdptipton@quicinc.com>,
        "Vivek
 Aknurwar" <viveka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
 <20250111161429.51-3-quic_rlaggysh@quicinc.com>
 <lm6gvcrnd2pcphex4pugxie7m47qlvrgvsvuf75w4uumwoouew@qcuvxeb3u72s>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <lm6gvcrnd2pcphex4pugxie7m47qlvrgvsvuf75w4uumwoouew@qcuvxeb3u72s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bdaUswPB7Dm6W-_oIuATGuSejKFxE1bB
X-Proofpoint-GUID: bdaUswPB7Dm6W-_oIuATGuSejKFxE1bB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230081



On 1/12/2025 2:38 AM, Bjorn Andersson wrote:
> On Sat, Jan 11, 2025 at 04:14:26PM +0000, Raviteja Laggyshetty wrote:
>> EPSS on SA8775P has two instances which requires creation of two device
>> nodes with different compatible and device data because of unique
>> icc node id and name limitation in interconnect framework.
>> Add multidevice support to osm-l3 code to get unique node id from icc
>> framework.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/osm-l3.c | 91 ++++++++++++++++++++++--------
>>  1 file changed, 67 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
>> index 6a656ed44d49..8e98d1c9a840 100644
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
>> @@ -11,6 +12,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/of_address.h>
>>  #include <linux/platform_device.h>
>>  
>>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>> @@ -34,6 +36,9 @@
>>  
>>  #define OSM_L3_MAX_LINKS		1
>>  
>> +#define OSM_L3_NODE_ID_START		10000
>> +#define OSM_NODE_NAME_SUFFIX_SIZE	10
>> +
>>  #define to_osm_l3_provider(_provider) \
>>  	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>>  
>> @@ -55,46 +60,40 @@ struct qcom_osm_l3_icc_provider {
>>   */
>>  struct qcom_osm_l3_node {
>>  	const char *name;
>> -	u16 links[OSM_L3_MAX_LINKS];
>> +	const char *links[OSM_L3_MAX_LINKS];
>>  	u16 id;
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
>> +#define DEFINE_QNODE(_name, _buswidth, ...)				\
>> +	static struct qcom_osm_l3_node _name = {			\
>>  		.name = #_name,						\
>> -		.id = _id,						\
>>  		.buswidth = _buswidth,					\
>>  		.num_links = COUNT_ARGS(__VA_ARGS__),			\
>> -		.links = { __VA_ARGS__ },				\
>> +		__VA_OPT__(.links = { #__VA_ARGS__ })			\
>>  	}
>>  
>> -DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
>> -DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
>> +DEFINE_QNODE(osm_l3_master, 16, osm_l3_slave);
>> +DEFINE_QNODE(osm_l3_slave, 16);
>>  
>> -static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>> +static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>>  	[MASTER_OSM_L3_APPS] = &osm_l3_master,
>>  	[SLAVE_OSM_L3] = &osm_l3_slave,
>>  };
>>  
>> -DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
>> -DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
>> +DEFINE_QNODE(epss_l3_master, 32, epss_l3_slave);
>> +DEFINE_QNODE(epss_l3_slave, 32);
>>  
>> -static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>> +static struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>>  	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
>>  	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>>  };
>> @@ -123,6 +122,19 @@ static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
>>  	.reg_perf_state = EPSS_REG_L3_VOTE,
>>  };
>>  
>> +static u16 get_node_id_by_name(const char *node_name,
>> +			       const struct qcom_osm_l3_desc *desc)
>> +{
>> +	struct qcom_osm_l3_node *const *nodes = desc->nodes;
>> +	int i;
>> +
>> +	for (i = 0; i < desc->num_nodes; i++) {
>> +		if (!strcmp(nodes[i]->name, node_name))
>> +			return nodes[i]->id;
>> +	}
>> +	return 0;
>> +}
>> +
>>  static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
>>  {
>>  	struct qcom_osm_l3_icc_provider *qp;
>> @@ -164,10 +176,11 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  	const struct qcom_osm_l3_desc *desc;
>>  	struct icc_onecell_data *data;
>>  	struct icc_provider *provider;
>> -	const struct qcom_osm_l3_node * const *qnodes;
>> +	struct qcom_osm_l3_node * const *qnodes;
>>  	struct icc_node *node;
>>  	size_t num_nodes;
>>  	struct clk *clk;
>> +	u64 addr;
>>  	int ret;
>>  
>>  	clk = clk_get(&pdev->dev, "xo");
>> @@ -188,6 +201,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  	if (!qp)
>>  		return -ENOMEM;
>>  
>> +	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>>  	qp->base = devm_platform_ioremap_resource(pdev, 0);
>>  	if (IS_ERR(qp->base))
>>  		return PTR_ERR(qp->base);
>> @@ -242,26 +259,51 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  
>>  	icc_provider_init(provider);
>>  
>> +	/* create icc nodes */
>>  	for (i = 0; i < num_nodes; i++) {
>> -		size_t j;
>> +		char *node_name;
>> +		size_t len;
>>  
>> -		node = icc_node_create(qnodes[i]->id);
>> +		node = icc_node_create_alloc_id(OSM_L3_NODE_ID_START);
>>  		if (IS_ERR(node)) {
>>  			ret = PTR_ERR(node);
>>  			goto err;
>>  		}
>> +		qnodes[i]->id = node->id;
>> +
>> +		/* len = strlen(node->name) + @ + 8 (base-address) + NULL */
>> +		len = strlen(qnodes[i]->name) + OSM_NODE_NAME_SUFFIX_SIZE;
>> +		node_name = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
>> +		if (!node_name) {
>> +			ret = -ENOMEM;
>> +			goto err;
>> +		}
>> +
>> +		snprintf(node_name, len, "%s@%08llx", qnodes[i]->name, addr);
>> +		node->name = node_name;
> 
> I don't think it's reasonable to duplicate this logic and the decision
> of naming convention in each provider driver. Please provide a generic
> solution in the framework.
> 
I will be moving the logic to framework.
> 
> PS. Not that I want you to use it here, but for the next time be aware
> of devm_kasprintf().
> 
Will make use of devm_kasprintf in the next patch revision.
>>  
>> -		node->name = qnodes[i]->name;
>>  		/* Cast away const and add it back in qcom_osm_l3_set() */
>>  		node->data = (void *)qnodes[i];
>>  		icc_node_add(node, provider);
>>  
>> -		for (j = 0; j < qnodes[i]->num_links; j++)
>> -			icc_link_create(node, qnodes[i]->links[j]);
>> -
>>  		data->nodes[i] = node;
>>  	}
>>  
>> +	/* create links in topolgy */
>> +	for (i = 0; i < num_nodes; i++) {
>> +		size_t j;
>> +
>> +		node = data->nodes[i];
>> +		for (j = 0; j < qnodes[i]->num_links; j++) {
>> +			u16 link_node_id = get_node_id_by_name(qnodes[i]->links[j], desc);
> 
> Isn't that O(i^2*j) string comparisons? I don't find that acceptable.

Agreed, I will be linking the nodes using pointers instead of strings,
this will avoid additional loops and lookups while creating the links.

> 
>> +
>> +			if (link_node_id)
>> +				icc_link_create(node, link_node_id);
>> +			else
>> +				goto err;
>> +		}
>> +	}
>> +
>>  	ret = icc_provider_register(provider);
>>  	if (ret)
>>  		goto err;
>> @@ -284,6 +326,7 @@ static const struct of_device_id osm_l3_of_match[] = {
>>  	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
>>  	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
>>  	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
>> +	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
> 
> With the exception of sc8180x, this list is sorted alphabetically.
> Please insert your entry where it makes sense.
> 
Sure, I will fix it in next patch series.

> Regards,
> Bjorn
> 
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(of, osm_l3_of_match);
>> -- 
>> 2.39.2
>>


