Return-Path: <linux-pm+bounces-23722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED70AA58A2C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 02:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280B716A025
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 01:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD4416D9C2;
	Mon, 10 Mar 2025 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MkvJBEHt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825B33991;
	Mon, 10 Mar 2025 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571929; cv=none; b=OPo2rLVDvh7n6VW/Yv+KD7Ry1eSxGiYdTCq7E8gCmTbhzUxqnu9VA3zv0TRF/o3bVZZeOGBzIuhWAOtdPOS4uY+hbag/r11eo3/7Uhx7fWX6po9HenhfSM8vc+ZgML8vMxfZGm3iRzdaaSMFkkeAlU5C57HMJmG7jxq62/zx/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571929; c=relaxed/simple;
	bh=6P/sYsBlPXI28YDPL6e6GYfTaKI9Syduhlo2Whk9kB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a07WP4u98tI1Y//QmqtVJJIE7s8cQAjUnV2QmLaCuDjEAlMRlwRkJIXxzuhYEjT15xEXVITrdJOaIHoV/gUvktkDJB3uIbUWJoRsABGUwoPS8YSir230Ad+zIfR+zvKrChKqZ/orXnvqvyBFsPPHWI8FTn9smvc5e8X8eKAISXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MkvJBEHt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529MiPoD030297;
	Mon, 10 Mar 2025 01:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7JC319lKqZ7+vrTPClXjMYMJqgypPY72vRxSw96Gvac=; b=MkvJBEHtlosz/Fgz
	s73A1C4PIwDWz+v7MECqXuMe5OEtMnCKC1eNtmJun2lUt08LatyE/7KzKqSwt13r
	dB0wsFUvj1V+ZhBIfJLLgV2rMT2ShJJhy+zjYYIUqQv6p41+WruIaueFWFaJSj8f
	tASVv8hgdvavheNmO5zzYdDpkxQwrTErZ0Qq8nXCHcJ0BWTFOYUqNfkDO7kFA81P
	N30m+QFmYlml91+N1TKd2uBf4a0ReU8mzA6Yk1Pe7eF4YVEPZ1hvtaQuamrQHbAc
	GPumqVwQsA0nZbaPznhL3Zniacpyvxkt1jdgxKUmZrhMQmwT9DuwodhSbsFFJwQw
	6ifUnA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt34w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 01:58:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52A1wgTY006829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 01:58:42 GMT
Received: from [10.216.28.75] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Mar 2025
 18:58:36 -0700
Message-ID: <f1dd5c1f-3bfb-427b-8e17-030776df38a1@quicinc.com>
Date: Mon, 10 Mar 2025 07:28:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 4/7] interconnect: qcom: icc-rpmh: Add dynamic icc node
 id support
To: Mike Tipton <quic_mdtipton@quicinc.com>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Jeff
 Johnson" <jeff.johnson@oss.qualcomm.com>,
        Jagadeesh Kona
	<quic_jkona@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-5-quic_rlaggysh@quicinc.com>
 <20250307035357.GA7435@hu-mdtipton-lv.qualcomm.com>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <20250307035357.GA7435@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RJrcnw5ojGXVqg8O4O9pz_BuYZHRkJWH
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67ce4753 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=sHi-3QDVYUbo2YnzGAgA:9 a=QEXdDO2ut3YA:10
 a=mn1kVZPsorgl7L_8cYVa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RJrcnw5ojGXVqg8O4O9pz_BuYZHRkJWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100014



On 3/7/2025 9:23 AM, Mike Tipton wrote:
> On Thu, Feb 27, 2025 at 03:52:10PM +0000, Raviteja Laggyshetty wrote:
>> To facilitate dynamic node ID support, the driver now uses
>> node pointers for links instead of static node IDs.
>> Additionally, the default node ID is set to -1 to prompt
>> the ICC framework for dynamic node ID allocation.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/icc-rpmh.c | 16 ++++++++++++++--
>>  drivers/interconnect/qcom/icc-rpmh.h |  3 ++-
>>  2 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
>> index f2d63745be54..2e654917f535 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.c
>> +++ b/drivers/interconnect/qcom/icc-rpmh.c
>> @@ -285,13 +285,25 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>>  			ret = PTR_ERR(node);
>>  			goto err_remove_nodes;
>>  		}
>> +		qn->id = node->id;
>>  
>>  		node->name = qn->name;
>>  		node->data = qn;
>>  		icc_node_add(node, provider);
>>  
>> -		for (j = 0; j < qn->num_links; j++)
>> -			icc_link_create(node, qn->links[j]);
>> +		for (j = 0; j < qn->num_links; j++) {
>> +			struct qcom_icc_node *qn_link_node = qn->link_nodes[j];
>> +			struct icc_node *link_node;
>> +
>> +			if (qn_link_node) {
>> +				link_node = icc_node_create(qn_link_node->id);
>> +				qn_link_node->id = link_node->id;
>> +				icc_link_create(node, qn_link_node->id);
>> +			} else {
>> +				/* backward compatibility for target using static IDs */
>> +				icc_link_create(node, qn->links[j]);
>> +			}
>> +		}
>>  
>>  		data->nodes[i] = node;
>>  	}
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
>> index 82344c734091..cf4aa69c707c 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.h
>> +++ b/drivers/interconnect/qcom/icc-rpmh.h
>> @@ -95,7 +95,8 @@ struct qcom_icc_qosbox {
>>  struct qcom_icc_node {
>>  	const char *name;
>>  	u16 links[MAX_LINKS];
>> -	u16 id;
>> +	struct qcom_icc_node *link_nodes[MAX_LINKS];
> 
> This is very inefficient. MAX_LINKS = 128, which means we're adding an
> additional 1KB *per-node*. The vast majority of nodes don't come
> anywhere close to this number of links, so this is almost entirely
> unused and wasted space.
> 
> As an example: sa8775p has 193 nodes, so we're adding 193K to the driver
> from this alone. The current driver size is 84K, and the size after this
> change is 283K.
> 
> Instead of embedding this array with a hardcoded size, we could point to
> an array that's sized for the number of links required by the node:
> 
>     - struct qcom_icc_node *link_nodes[MAX_LINKS];
>     + struct qcom_icc_node **link_nodes;
> 
> Then when initializing the arrays, we could:
> 
>     - .link_nodes = { &qns_a1noc_snoc },
>     + .link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
> 
> And for handling compatiblity with older drivers, we'd check for
> link_nodes != NULL instead of checking the array indices.
> 
> Doing it this way would reduce the new sa8775p size from 283K to 88K.
> 
> A similar argument could be made for qcom_icc_node::links, since that's
> also hardcoded to MAX_LINKS. But it's not quite as bad since it's an
> array of u16 rather than an array of pointers. Still, if we implemented
> similar changes for qcom_icc_node::links, then we'd save almost 256B
> per-node, which for sa8775p would reduce the size by roughly another
> 50K. If we're ultimately planning on switching all the old drivers over
> to link_nodes, then we could just wait and get rid of links entirely.
> Regardless, optimizing links doesn't have to happen in this series, but
> I don't want to further bloat the size from the addition of link_nodes.
> 

Ok Mike, I would make use of struct qcom_icc_node **link_nodes instead
of *link_nodes[MAX_LINKS] in the next patch series, we can clean up the
links[MAX_LINKS] as part of another patch series. This suggestion does
help in reducing size of the driver.

>> +	int id;
>>  	u16 num_links;
>>  	u16 channels;
>>  	u16 buswidth;
>> -- 
>> 2.43.0
>>
>>


