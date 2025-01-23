Return-Path: <linux-pm+bounces-20832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E92A1A1F7
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4210E188DB11
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C61F20DD41;
	Thu, 23 Jan 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aMrFwEix"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB014186A;
	Thu, 23 Jan 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628589; cv=none; b=aEL/VneP6+YuDAneown/IuPVkAbnGS/P3PCBXPou3HKfYsngKlMnUIYo8KjDQsPl6/jgFWrsw3gwPSlZkIK4vAGqEuXfk5xpBMsinV0M/qWMmi3hPlijD4eYv5XD82tHSZnkT5ezraLYMCsaHnZ//b73ugjNPxYG+bgwTUtiahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628589; c=relaxed/simple;
	bh=yeOngZHOJaGaTHkZJfVVp3OdxskJww+jY8vzIs4TCxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j1ypn77FiIcsVjMx4AzTk/Yh6zTv+EoxCB5As5bnyY9poLpAXa70VbaWIYRVl7to5ogGEtYft4ALydGpIsTsXA9XwrSXMY14nCEWmJOa6b2DsIZZ1QGAkfTdYhJwrWBLdSlEBx5fGUY6wKVOcTzBpU5jzVhJcN7v5CIyN8y8QmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aMrFwEix; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NA3HPl016535;
	Thu, 23 Jan 2025 10:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QfmCLbUabp4yVNBHV/Ri1VGNWl5Mrqof2hOoSquHnWA=; b=aMrFwEixE3lRFd3q
	QJjdLLVK2/Rs/NICEFKZGoFnuvzlYJ/LX6FfvAbmG6MgBgKcisrRmMSyaxfR1mti
	37GhK02Je1H93gas94XVw+D/M8OOPsZTs8iB4zQWsB7UoQFfHd2JRCO+hqtAObjl
	PiMkHcZhL/IOzd9rEZVJZ1/n6zt0VenAmFfSs/H3IMSyeM/AFJtLWr93WX1S55Z2
	zjB6BburT1O35EA/p8j1lQrc25oHdasSOLPbYSoO7JqBDWgVv+jwoAUh9LN4BxKQ
	+qTDHeEmc5zQpRvGWKtR3D8UZdMS4a9ZMh+wZ3GjRwV9Z4zZda4P50dnRV1bP/As
	svP4sg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bknxg2ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:36:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50NAaIRg017838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:36:18 GMT
Received: from [10.216.27.253] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 02:36:13 -0800
Message-ID: <91ec5b74-2fda-4aa8-bc87-c8e99f046391@quicinc.com>
Date: Thu, 23 Jan 2025 16:05:59 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/5] interconnect: core: Add dynamic id allocation
 support
To: Bjorn Andersson <andersson@kernel.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <mdtipton@quicinc.com>,
        "Vivek
 Aknurwar" <viveka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
 <20250111161429.51-2-quic_rlaggysh@quicinc.com>
 <pu3s3fjkt2663wce2632s25oys56wkhsc22lcc5ydepfc4pbll@n73ouprb25zj>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <pu3s3fjkt2663wce2632s25oys56wkhsc22lcc5ydepfc4pbll@n73ouprb25zj>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6fu28QVKq1PxSakHRnEES0rZ1fBAh4Kh
X-Proofpoint-GUID: 6fu28QVKq1PxSakHRnEES0rZ1fBAh4Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230081



On 1/12/2025 2:27 AM, Bjorn Andersson wrote:
> On Sat, Jan 11, 2025 at 04:14:25PM +0000, Raviteja Laggyshetty wrote:
>> Current interconnect framework is based on static IDs for creating node
>> and registering with framework. This becomes a limitation for topologies
>> where there are multiple instances of same interconnect provider. Add
>> icc_node_create_alloc_id() API to create icc node with dynamic id, this
>> will help to overcome the dependency on static IDs.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/core.c           | 32 +++++++++++++++++++++++++++
>>  include/linux/interconnect-provider.h |  6 +++++
>>  2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 9d5404a07e8a..0b7093eb51af 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -858,6 +858,38 @@ struct icc_node *icc_node_create(int id)
>>  }
>>  EXPORT_SYMBOL_GPL(icc_node_create);
>>  
>> +/**
>> + * icc_node_create_alloc_id() - create node and dynamically allocate id
>> + * @start_id: min id to be allocated
>> + *
>> + * Return: icc_node pointer on success, or ERR_PTR() on error
>> + */
>> +struct icc_node *icc_node_create_alloc_id(int start_id)
> 
> By having clients pass in start_id, you distribute the decision of what
> a "good number" is across multiple parts of the system (or you have
> clients relying on getting [start_id, start_id + N) back).
> 
> Wouldn't it be better to hide that choice in one place (inside the icc
> framework)?
> 

Yes, inline to Dmitry's suggestion I will be moving the start_id to
framework and all dynamic allocations will start from 10000.

> Regards,
> Bjorn
> 
>> +{
>> +	struct icc_node *node;
>> +	int id;
>> +
>> +	mutex_lock(&icc_lock);
>> +
>> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +	if (!node)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	id = idr_alloc(&icc_idr, node, start_id, 0, GFP_KERNEL);
>> +	if (id < 0) {
>> +		WARN(1, "%s: couldn't get idr\n", __func__);
>> +		kfree(node);
>> +		node = ERR_PTR(id);
>> +		goto out;
>> +	}
>> +	node->id = id;
>> +out:
>> +	mutex_unlock(&icc_lock);
>> +
>> +	return node;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_node_create_alloc_id);
>> +
>>  /**
>>   * icc_node_destroy() - destroy a node
>>   * @id: node id
>> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
>> index f5aef8784692..4fc7a5884374 100644
>> --- a/include/linux/interconnect-provider.h
>> +++ b/include/linux/interconnect-provider.h
>> @@ -117,6 +117,7 @@ struct icc_node {
>>  int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>  		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
>>  struct icc_node *icc_node_create(int id);
>> +struct icc_node *icc_node_create_alloc_id(int start_id);
>>  void icc_node_destroy(int id);
>>  int icc_link_create(struct icc_node *node, const int dst_id);
>>  void icc_node_add(struct icc_node *node, struct icc_provider *provider);
>> @@ -141,6 +142,11 @@ static inline struct icc_node *icc_node_create(int id)
>>  	return ERR_PTR(-ENOTSUPP);
>>  }
>>  
>> +static inline struct icc_node *icc_node_create_alloc_id(int start_id)
>> +{
>> +	return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +
>>  static inline void icc_node_destroy(int id)
>>  {
>>  }
>> -- 
>> 2.39.2
>>


