Return-Path: <linux-pm+bounces-7615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C42178BF49E
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 04:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386521F24B3A
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673D10A2C;
	Wed,  8 May 2024 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oTOPnCtw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256362563;
	Wed,  8 May 2024 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135846; cv=none; b=umxksKHZJjmPXyPBMj8XDcuJR3AQ+I/BHltJ2NsbrjLrz7HBhmHRNMExhmZ8R4h6XyILU9hzCd+4DXY8NKC6//z3jmRt8dOfd7l0W9Go2VQBhL7wRkycYhKMVL10S5UmJJNr7/HA7ptvKopXutPSDOxZ+2eWkSXEVTKKF+DAoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135846; c=relaxed/simple;
	bh=L+7O8cBMHbYGbdx2i1sHwLmX/iYsNK3kndk4UoqXo0U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3/W7YEZFZ55EuoBb5iPk+3kwKrQqFCILerL/+owr/4bqo2DJppJ+9S6Hs7u2tjTpPmdap+CX94O2cnoBFQOKGyQy0xZwCVTlnhVKV89ZNy/hMUjzhWIaaR0c1D3sgxeHELUewIR2HfKr0cmeuQk2YtuyX4nbRN9xdHsfM+pM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oTOPnCtw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4480tSlQ010362;
	Wed, 8 May 2024 02:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=/ZCjObFVzI65lpVfxycSD
	PFIUahEfff+75M1F2+9dBI=; b=oTOPnCtwrNqqvCiRTQi/md0vkbK+itUoS5I8n
	/p7CyQqjbyBgP4m3oT/t9CLeFKFXtJjdFtr24CWpRjNUzY+iR1oZDxiTb+rtVro9
	5W7ciqKSTfT/x6RqMY9hNouabsWuxKrtLgrzBioWuwnt22ExOiQZpz6+XbimQ/Az
	iCWjBf+IcniJb9NE242lqTUZ41mdpOXwpCo1EbJfHnQLN4MIaEmukNEo384xNSs5
	6QksrxwA3wveP5I5YaTUH4fNY/lbB6vOBmsY2AtQyDa2f/Bzm6L4YVnfbiMnFFq4
	MKfSGvAeqJw50n79e3Ot5/MrOPZDp/P8+Z8aIu7CGlTsV11vw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysph0rx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 02:37:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4482bIlH001487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 02:37:18 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 May 2024 19:37:17 -0700
Date: Tue, 7 May 2024 19:37:16 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva"
	<gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>
Subject: Re: [PATCH v4 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
Message-ID: <20240508023716.GD25316@hu-mdtipton-lv.qualcomm.com>
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-2-quic_okukatla@quicinc.com>
 <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
 <91f59477-1799-4db6-bcc2-3f0c5225d1c8@quicinc.com>
 <0a58e05a-7bf5-459a-b202-66d88c095b45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0a58e05a-7bf5-459a-b202-66d88c095b45@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cUIFXgQRc5CvC0-zkk9z50wybFjoVYuB
X-Proofpoint-GUID: cUIFXgQRc5CvC0-zkk9z50wybFjoVYuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_16,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=835
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080017

On Sat, Apr 13, 2024 at 09:31:47PM +0200, Konrad Dybcio wrote:
> On 3.04.2024 10:45 AM, Odelu Kukatla wrote:
> > 
> > 
> > On 3/27/2024 2:26 AM, Konrad Dybcio wrote:
> >> On 25.03.2024 7:16 PM, Odelu Kukatla wrote:
> >>> It adds QoS support for QNOC device and includes support for
> >>> configuring priority, priority forward disable, urgency forwarding.
> >>> This helps in priortizing the traffic originating from different
> >>> interconnect masters at NoC(Network On Chip).
> >>>
> >>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> >>> ---
> 
> [...]
> 
> >>> @@ -70,6 +102,7 @@ struct qcom_icc_node {
> >>>  	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
> >>>  	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
> >>>  	size_t num_bcms;
> >>> +	const struct qcom_icc_qosbox *qosbox;
> >>
> >> I believe I came up with a better approach for storing this.. see [1]
> >>
> >> Konrad
> >>
> >> [1] https://lore.kernel.org/linux-arm-msm/20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org/

Note that I replied to this patch series as well. Similar comments here
for how that approach would apply to icc-rpmh.

> >>
> > 
> > I see in this series, QoS parameters are moved into struct qcom_icc_desc. 
> > Even though we program QoS at Provider/Bus level, it is property of the node/master connected to a Bus/NoC.
> 
> I don't see how it could be the case, we're obviously telling the controller which
> endpoints have priority over others, not telling nodes whether the data they
> transfer can omit the queue.

The QoS settings tune the priority of data coming out of a specific port
on the NOC. The nodes are 1:1 with the ports. Yes, this does tell the
NOC which ports have priority over others. But that's done by
configuring each port's priority in their own port-specific QoS
registers.

> 
> > It will be easier later to know which master's QoS we are programming if we add in node data.
> > Readability point of view,  it might be good to keep QoS parameters in node data.  
> 
> I don't agree here either, with the current approach we've made countless mistakes
> when converting the downstream data (I have already submitted some fixes with more
> in flight), as there's tons of jumping around the code to find what goes where.

I don't follow why keeping the port's own QoS settings in that port's
struct results in more jumping around. It should do the opposite, in
fact. If someone wants to know the QoS settings applied to the qhm_qup0
port, then they should be able to look directly in the qhm_qup0 struct.
Otherwise, if it's placed elsewhere then they'd have to jump elsewhere
to find what that logical qhm_qup0-related data is set to.

If it *was* placed elsewhere, then we'd still need some logical way to
map between that separate location and the node it's associated with.
Which is a problem with your patch for cleaning up the icc-rpm QoS. In
its current form, it's impossible to identify which QoS settings apply
to which logical node (without detailed knowledge of the NOC register
layout).

Keeping this data with the node struct reduces the need for extra layers
of mapping between the QoS settings and the node struct. It keeps all
the port-related information all together in one place.

I did like your earlier suggestion of using a compound literal to
initialize the .qosbox pointers, such that we don't need a separate
top-level variable defined for them. They're only ever referenced by a
single node, so there's no need for them to be separate variables.

But I don't see the logic in totally separating the QoS data from the
port it's associated with.

> 
> Konrad

