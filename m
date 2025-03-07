Return-Path: <linux-pm+bounces-23603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140DBA55F00
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD3D3B1947
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1905187872;
	Fri,  7 Mar 2025 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VGbqUCeT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B256B81;
	Fri,  7 Mar 2025 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319646; cv=none; b=MXS7KpmM4hxBNMhKaMxl9VSWx6LAn621MkLwmgEvskU8gRPAI+mo1StXWkah2SI2F7fAa+YOpFV6hzXMfznPIJjb8JgfV7ZaV34xxKFt0tAMNivxAopLf6ifCf6LB0U/ALZ1I3nIny0TA58bdrj6/9Zm3OHaMCGR/41kZjf5K0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319646; c=relaxed/simple;
	bh=jU6h0zm8DtYW4fawJfkNv1nL8z9bH50zN6BIvm+O+Eg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlAWnM0S20yACZi3qEfYwgOMo6BFRt3c5wrZ6zmz9IFg7Fxm49PS1oXoVM2Ou19gUcoencxL+RKD+jDXb64e070FjVibWr7m2zN8+worQmd+LJeafiiKpKn68uqK+BwfdqJAX5PwAzAHioTqbmO3l/7aQEcOSg5ugN3FMc6w6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VGbqUCeT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5272YDAD031539;
	Fri, 7 Mar 2025 03:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8PTq9eG+BT4Hz28wAGMLFEUm
	W2P+JqYxKWRoyQ32r90=; b=VGbqUCeTwVU5aidABZzir//oRGgOuGoL5m+riG1e
	Lw/UKo8XxQqUNo3nfiXu2YDzYaGbVNXRoTgWWSjeS3vM4U8yiT3735C9NgSouSc4
	S2C7LUFJ6Q7/0WJosTV/54IHlfaoT8u7beWJ1bQCGbix8uN6CmdrxPHE/x8sOd6a
	D85QmmW7z1ycdJn6OgMPUgFgSv/CrCce0W6cGOLDuneziN7g4TFnxS6czdC0ymZ1
	cg12wHh4VH/3cYA8eofQQ94G6aaGzeL1WJVb7+xspTFS3oHy3fm9crB3TmnH5Lqp
	5sCDRBU9AuK2gaAEZbywRw7XaLDF/vDABIYwBAbiit0SWA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4574cebn5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 03:54:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5273rx04019701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 03:53:59 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Mar 2025 19:53:58 -0800
Date: Thu, 6 Mar 2025 19:53:57 -0800
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
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
Subject: Re: [PATCH V9 4/7] interconnect: qcom: icc-rpmh: Add dynamic icc
 node id support
Message-ID: <20250307035357.GA7435@hu-mdtipton-lv.qualcomm.com>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-5-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250227155213.404-5-quic_rlaggysh@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fxJzpiDc5i1jLunUUOZToGbmJ_rl3TMh
X-Proofpoint-GUID: fxJzpiDc5i1jLunUUOZToGbmJ_rl3TMh
X-Authority-Analysis: v=2.4 cv=bNLsIO+Z c=1 sm=1 tr=0 ts=67ca6dd8 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=3H110R4YSZwA:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=zP48Rn2UD53C5hFnKzAA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070023

On Thu, Feb 27, 2025 at 03:52:10PM +0000, Raviteja Laggyshetty wrote:
> To facilitate dynamic node ID support, the driver now uses
> node pointers for links instead of static node IDs.
> Additionally, the default node ID is set to -1 to prompt
> the ICC framework for dynamic node ID allocation.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 16 ++++++++++++++--
>  drivers/interconnect/qcom/icc-rpmh.h |  3 ++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index f2d63745be54..2e654917f535 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -285,13 +285,25 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  			ret = PTR_ERR(node);
>  			goto err_remove_nodes;
>  		}
> +		qn->id = node->id;
>  
>  		node->name = qn->name;
>  		node->data = qn;
>  		icc_node_add(node, provider);
>  
> -		for (j = 0; j < qn->num_links; j++)
> -			icc_link_create(node, qn->links[j]);
> +		for (j = 0; j < qn->num_links; j++) {
> +			struct qcom_icc_node *qn_link_node = qn->link_nodes[j];
> +			struct icc_node *link_node;
> +
> +			if (qn_link_node) {
> +				link_node = icc_node_create(qn_link_node->id);
> +				qn_link_node->id = link_node->id;
> +				icc_link_create(node, qn_link_node->id);
> +			} else {
> +				/* backward compatibility for target using static IDs */
> +				icc_link_create(node, qn->links[j]);
> +			}
> +		}
>  
>  		data->nodes[i] = node;
>  	}
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index 82344c734091..cf4aa69c707c 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -95,7 +95,8 @@ struct qcom_icc_qosbox {
>  struct qcom_icc_node {
>  	const char *name;
>  	u16 links[MAX_LINKS];
> -	u16 id;
> +	struct qcom_icc_node *link_nodes[MAX_LINKS];

This is very inefficient. MAX_LINKS = 128, which means we're adding an
additional 1KB *per-node*. The vast majority of nodes don't come
anywhere close to this number of links, so this is almost entirely
unused and wasted space.

As an example: sa8775p has 193 nodes, so we're adding 193K to the driver
from this alone. The current driver size is 84K, and the size after this
change is 283K.

Instead of embedding this array with a hardcoded size, we could point to
an array that's sized for the number of links required by the node:

    - struct qcom_icc_node *link_nodes[MAX_LINKS];
    + struct qcom_icc_node **link_nodes;

Then when initializing the arrays, we could:

    - .link_nodes = { &qns_a1noc_snoc },
    + .link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },

And for handling compatiblity with older drivers, we'd check for
link_nodes != NULL instead of checking the array indices.

Doing it this way would reduce the new sa8775p size from 283K to 88K.

A similar argument could be made for qcom_icc_node::links, since that's
also hardcoded to MAX_LINKS. But it's not quite as bad since it's an
array of u16 rather than an array of pointers. Still, if we implemented
similar changes for qcom_icc_node::links, then we'd save almost 256B
per-node, which for sa8775p would reduce the size by roughly another
50K. If we're ultimately planning on switching all the old drivers over
to link_nodes, then we could just wait and get rid of links entirely.
Regardless, optimizing links doesn't have to happen in this series, but
I don't want to further bloat the size from the addition of link_nodes.

> +	int id;
>  	u16 num_links;
>  	u16 channels;
>  	u16 buswidth;
> -- 
> 2.43.0
> 
> 

