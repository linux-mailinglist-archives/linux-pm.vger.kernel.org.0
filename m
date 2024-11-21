Return-Path: <linux-pm+bounces-17887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49259D523F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D151F2291C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4131BC9ED;
	Thu, 21 Nov 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JTWU+j3p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE331A0726;
	Thu, 21 Nov 2024 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212201; cv=none; b=Xz0QTqIM41VTqrXFQH+eqlfktdb8npu8NBIseQo5WrUCBymjktB2DJ11i9/STHGSNoEQeF6BMcACYWwt+6oPMAldbdfUswGjo2yrgvjV7lB1aaxewlwrKwKbh6KNW2tOgZVgVvXAdxM0/9lz/IR/R8YWzqiyQ3mi91n2OHxRUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212201; c=relaxed/simple;
	bh=qdl3gcm8LTYFq14sBh2ATyVCxMyGQMP61nP8fX88IH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z1edo1YvCTZ0Zh90BIzeJBwCm77CLoV+dMYXohEJGsY2noQl+D9OktcdAA6NAJ6Ng/t5YCTqV6iAqaqgW+w/q49eD+XJ8o+F7/BH1c/xrb0grciELe6Cde2D37gkAzhO0AdZYASf+9ZKrbHSo1qe13SNstXbM/iQ0JzsHVajvos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JTWU+j3p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL9Dxs6007912;
	Thu, 21 Nov 2024 18:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mQCLjvbQA0l76BDkjJNaGTmYOIeoZTLNFsbEZ66eoFs=; b=JTWU+j3px7+y9A9f
	uCNMEXg5s8SYMbno6ELldQ79XAoCyzHHNApN0PFpFgEJmMSy5v5lH4CIN/02GmYb
	miNVqfbcGuuplr+QFscOJllC5n6U5pLpOhEvt7EJJLAUTdv3zRuc4QCZLXeCwq/X
	REkpGQ+5q9QfMsE1Sn1moqADy9dEFmfNHEx9vimMcCSOkwnlmOlFYWiK9FLLnnsg
	5SkIH1ueMvf5lWckRF1aFRSRI5M63JUZhjIG/r5b+uO59lRTCnb1xqPVVYDlEj07
	mTyoU0GMe3OY1doWiO8WTg38QmY+jax+vJDd5RBvEkkM8zamYo1nmZ6Li6RMIinX
	pV0Ikg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4318uvne3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:03:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALI3D7L013603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 18:03:13 GMT
Received: from [10.216.2.20] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 10:03:08 -0800
Message-ID: <b2a05dfb-a820-4450-a156-8d6b4bd59be3@quicinc.com>
Date: Thu, 21 Nov 2024 23:33:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/4] interconnect: qcom: Add EPSS L3 support on SA8775P
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-4-quic_rlaggysh@quicinc.com>
 <bc926d6d-e3d1-4fbf-9b6a-bbd3816a766d@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <bc926d6d-e3d1-4fbf-9b6a-bbd3816a766d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L2QJQhmrIgNv2SkNb8xDAEuum8cZyLMQ
X-Proofpoint-GUID: L2QJQhmrIgNv2SkNb8xDAEuum8cZyLMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210137



On 11/21/2024 5:28 PM, Krzysztof Kozlowski wrote:
> On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider on
>> SA8775P SoCs with multiple device support.
>>
> 
> 
> ...
> 
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
> 
> 
> I think dropping const makes the code worse, not better. Commit msg does
> not explain all these changes and I could not figure out the intention
> (except modifying but that's just obvious).

EPSS L3 on SA8775P has two instances and this requires creation of two device nodes in devicetree.
As Interconnect framework requires a unique node id, each device node needs to have different compatible and data.
To overcome the need of having two different compatibles and data, driver code has been modified to acquire unique node id from IDA 
and the node name is made dynamic (nodename@address).
Updating node id and node name is not possible with const.
> 
> 
> 
>>  	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
>>  	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
>>  };
>> @@ -123,6 +125,19 @@ static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
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
>> @@ -164,10 +179,11 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
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
>> @@ -188,6 +204,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
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
>> @@ -242,8 +262,13 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  
>>  	icc_provider_init(provider);
>>  
>> +	/* Allocate unique id for qnodes */
>> +	for (i = 0; i < num_nodes; i++)
>> +		qnodes[i]->id = ida_alloc_min(&osm_l3_id, OSM_L3_NODE_ID_START, GFP_KERNEL);
>> +
>>  	for (i = 0; i < num_nodes; i++) {
>> -		size_t j;
>> +		char *node_name;
>> +		size_t j, len;
>>  
>>  		node = icc_node_create(qnodes[i]->id);
>>  		if (IS_ERR(node)) {
>> @@ -251,13 +276,29 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>>  			goto err;
>>  		}
>>  
>> -		node->name = qnodes[i]->name;
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
> 
> Why the node name becomes dynamic?
> 
> Best regards,
> Krzysztof


