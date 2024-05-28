Return-Path: <linux-pm+bounces-8247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81448D1F49
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F281284DD4
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B3170822;
	Tue, 28 May 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lzqO1xNX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22731DA32;
	Tue, 28 May 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907961; cv=none; b=QkM6rHyefeuhnYXRGb8YY8Rnk/uDG0n35U5VG3VHMjtypZw7l5gxIdWC1veJP637GYTja4f7LmAUsRrBGLBCQWdcmbamCxvpGl6+MmHUboE213ZNvD3urV0GsFflOWwiRkNOe9yGg0sgb6nKcMqcNQUiww6ENnGV1ub0zDyTH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907961; c=relaxed/simple;
	bh=lH2MumRnI7l3YLRPeM7BwNfpMOBnQbE+uH7AvcbBSzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pboIPhcriS5ei5K73aLwvWy161vLt3mjetZDvcP/sUeSTp0bOBhqVy+fpwCfYanbcM0Vqk1xYHkMYuTJbQWdnGB+c4jV1n+0vdJOkXMSj6qKa6O82ajywLjpXj2FhxHb8rTjKL8Bgdk+YDm1ppFLD94A0YR+aU4Lp3U1BlTkRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lzqO1xNX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SAUXuZ009025;
	Tue, 28 May 2024 14:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dWcKuFlpB9O0H+5h3Iazox/MW/EgYPo9bqGQKEr5kUM=; b=lzqO1xNXDXJt9YKE
	hdiB10isAAW9ccHigQT2WQmnzqTjysTUNgCm2QEo2ykZf1g8rkpGR3RkPUQqMX0W
	xc7JwTKbYMu7o+9UvpnqadVao/Unpi4EM4eGCzB0AOv3ZYfGvPzaXmi+keFn0W0d
	RUdL38EibXG8jQz2tIvXOvfX5Hly1GO0oepCyzQSwupbZpYkOKyKiDc1py1TQ7Aw
	CZwA/0dkqk9kYhGPDvsX9aCSO7MvnHitYFgYINOs8+gpEqtqO8XAhhsU4WoRrJE2
	Em5kFDnI4Mr69FjClK95qLTKLMo09K0kdgVHpXsOh3K715g8A11AcLSbqo29jCf0
	CYaEow==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0g6eqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 14:52:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SEqWT2007769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 14:52:32 GMT
Received: from [10.50.34.189] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 07:52:26 -0700
Message-ID: <434c6cfa-cede-4e62-a785-35a81ae0d30d@quicinc.com>
Date: Tue, 28 May 2024 20:22:22 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
To: Mike Tipton <quic_mdtipton@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-2-quic_okukatla@quicinc.com>
 <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
 <91f59477-1799-4db6-bcc2-3f0c5225d1c8@quicinc.com>
 <0a58e05a-7bf5-459a-b202-66d88c095b45@linaro.org>
 <20240508023716.GD25316@hu-mdtipton-lv.qualcomm.com>
Content-Language: en-US
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <20240508023716.GD25316@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ht2cKHlyZnYYLulXR3pVrVp17xeQlZIp
X-Proofpoint-ORIG-GUID: ht2cKHlyZnYYLulXR3pVrVp17xeQlZIp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=984 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280111

Hi Konrad,

On 5/8/2024 8:07 AM, Mike Tipton wrote:
> On Sat, Apr 13, 2024 at 09:31:47PM +0200, Konrad Dybcio wrote:
>> On 3.04.2024 10:45 AM, Odelu Kukatla wrote:
>>>
>>>
>>> On 3/27/2024 2:26 AM, Konrad Dybcio wrote:
>>>> On 25.03.2024 7:16 PM, Odelu Kukatla wrote:
>>>>> It adds QoS support for QNOC device and includes support for
>>>>> configuring priority, priority forward disable, urgency forwarding.
>>>>> This helps in priortizing the traffic originating from different
>>>>> interconnect masters at NoC(Network On Chip).
>>>>>
>>>>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>>>>> ---
>>
>> [...]
>>
>>>>> @@ -70,6 +102,7 @@ struct qcom_icc_node {
>>>>>  	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>>>>>  	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>>>>>  	size_t num_bcms;
>>>>> +	const struct qcom_icc_qosbox *qosbox;
>>>>
>>>> I believe I came up with a better approach for storing this.. see [1]
>>>>
>>>> Konrad
>>>>
>>>> [1] https://lore.kernel.org/linux-arm-msm/20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org/
> 
> Note that I replied to this patch series as well. Similar comments here
> for how that approach would apply to icc-rpmh.
> 
>>>>
>>>
>>> I see in this series, QoS parameters are moved into struct qcom_icc_desc. 
>>> Even though we program QoS at Provider/Bus level, it is property of the node/master connected to a Bus/NoC.
>>
>> I don't see how it could be the case, we're obviously telling the controller which
>> endpoints have priority over others, not telling nodes whether the data they
>> transfer can omit the queue.
> 
> The QoS settings tune the priority of data coming out of a specific port
> on the NOC. The nodes are 1:1 with the ports. Yes, this does tell the
> NOC which ports have priority over others. But that's done by
> configuring each port's priority in their own port-specific QoS
> registers.
> 
>>
>>> It will be easier later to know which master's QoS we are programming if we add in node data.
>>> Readability point of view,  it might be good to keep QoS parameters in node data.  
>>
>> I don't agree here either, with the current approach we've made countless mistakes
>> when converting the downstream data (I have already submitted some fixes with more
>> in flight), as there's tons of jumping around the code to find what goes where.
> 
> I don't follow why keeping the port's own QoS settings in that port's
> struct results in more jumping around. It should do the opposite, in
> fact. If someone wants to know the QoS settings applied to the qhm_qup0
> port, then they should be able to look directly in the qhm_qup0 struct.
> Otherwise, if it's placed elsewhere then they'd have to jump elsewhere
> to find what that logical qhm_qup0-related data is set to.
> 
> If it *was* placed elsewhere, then we'd still need some logical way to
> map between that separate location and the node it's associated with.
> Which is a problem with your patch for cleaning up the icc-rpm QoS. In
> its current form, it's impossible to identify which QoS settings apply
> to which logical node (without detailed knowledge of the NOC register
> layout).
> 
> Keeping this data with the node struct reduces the need for extra layers
> of mapping between the QoS settings and the node struct. It keeps all
> the port-related information all together in one place.
> 
> I did like your earlier suggestion of using a compound literal to
> initialize the .qosbox pointers, such that we don't need a separate
> top-level variable defined for them. They're only ever referenced by a
> single node, so there's no need for them to be separate variables.
> 
> But I don't see the logic in totally separating the QoS data from the
> port it's associated with.
> 
>>
I will update the patch as per your suggestion of keeping .qosbox initialization inside *qcom_icc_node* structure.
I will post next version with this update and addressing other comments from v4.

Thanks,
Odelu

>> Konrad

