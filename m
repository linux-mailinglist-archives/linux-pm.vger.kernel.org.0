Return-Path: <linux-pm+bounces-23723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FEFA58A6C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 03:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC8188CDEC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E646192D8E;
	Mon, 10 Mar 2025 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oOb3M20s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA5190674;
	Mon, 10 Mar 2025 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573475; cv=none; b=VjfKmfzlFnKjMLzg79lT4EG3MtSFLb9XWVYj5ko9HmRaRKq06d6UymuuVFVzIn4ax+xyftmpRJXRTmptXNxTDh3hMF1P7QVzEKUDh9hP7ZWftgIBN48vnCpxJLlEaDJ30w3V4JaHyhvYT7oFt0BD1SqvC8aRwW9TDkDrCtkqwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573475; c=relaxed/simple;
	bh=ahJW1eRggySdKhNYEq4e4OHlBcX9x0Hyt+5+EXAIke8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CG0X5yieGPOmEJyxMDUTKKIX/4lsQPCfTbh2eJlrhZN2WdTj8zm0GcZVl0+pZhBtmq+1ZshwV60pXTfy0BaykKT5lHRyOKpLRSyfwEQmGanPXMcFGz78PN85+bynMDlLHAAlhMqTW+YaF7yFMbI1+oTtVSff/VaMWTMViRQGLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oOb3M20s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529HndiR004071;
	Mon, 10 Mar 2025 02:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifC3tTkxRuQxKuY61odXeH7wVTwit3C7QPfnkAFRCqw=; b=oOb3M20sNfRvlkXS
	BuPD9mgMDNmNT9tyxgviv2+7vshu7f5538s+qnpFEZuUHNzR3gzF8bDkjUdDdXm3
	0PbQ/JBi39QpUj5K+RFmBeZH6eCKploH7e8V3RRHZKXL1XDFy+7dF7gcbWm3Fjx7
	6e1StroYOIJD4TEoNpsfnalzaUBQfZIMF/RX1ux7RHjx3cKmqf74WAaATS9MC+/p
	Yn3+Un5YW/fGA3pKqQIo2bTllHefnmOpl1AThYImhszvHKkYM8Zy3VQs3tjG5wJL
	kY/pNCZHTFEb9DDRZ4e9EIlgJPQcWCd34RPbYpPUK+0SuuY47LNe76YKBiVQZ0vZ
	OFwW+A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt36h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 02:24:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52A2ORYH018693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 02:24:27 GMT
Received: from [10.216.28.75] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Mar 2025
 19:24:20 -0700
Message-ID: <5278cb2e-6111-4e57-86b3-987f6f9eabf6@quicinc.com>
Date: Mon, 10 Mar 2025 07:54:15 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 4/7] interconnect: qcom: icc-rpmh: Add dynamic icc node
 id support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Jeff
 Johnson" <jeff.johnson@oss.qualcomm.com>,
        Mike Tipton <mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-5-quic_rlaggysh@quicinc.com>
 <gxqjfabcqafqjzzwc3seadfuldqfxlfappsotjbhkbirvorcyd@mahdpv6klwn5>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <gxqjfabcqafqjzzwc3seadfuldqfxlfappsotjbhkbirvorcyd@mahdpv6klwn5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -R2GEnEa9YBghtOxKBoD6wD5MTZDPELS
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67ce4d5c cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=L8qSQLY5uW4YFV_B7Q0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -R2GEnEa9YBghtOxKBoD6wD5MTZDPELS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100017



On 2/27/2025 9:46 PM, Dmitry Baryshkov wrote:
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
> 
> I really don't like the idea of reading the ->id back. I think in the
> last cycle I have already asked to add an API to link two nodes instead
> of linking a node and an ID. Is there an issue with such an API?

Yes, the link pointer may or may not be initialized during the link
creation as the link can belong to other provider which is yet to probe.
So, it is not possible to pass two node pointers as arguments for linking.

RPMh driver has multiple providers and during the creation of links,
nodes associated with other providers are created in the icc_link_create
API. When the actual provider to which the link belongs is probed, its
initialization/node creation is skipped by checking the ID. To ensure
proper tracking of node initialization and prevent re-initialization, it
is essential to read back and store the node’s ID in qnode.


> 
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
>> +	int id;
>>  	u16 num_links;
>>  	u16 channels;
>>  	u16 buswidth;
>> -- 
>> 2.43.0
>>
> 


