Return-Path: <linux-pm+bounces-20834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927C2A1A227
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A4E166199
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C6A20DD43;
	Thu, 23 Jan 2025 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WWG9pLdt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54956186A;
	Thu, 23 Jan 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629249; cv=none; b=T64E/y5NN6kDma9NGydWnMskGRFoTA7GYnG23QLo+8zpEgVq/9m6FkTbKcweRYeMqD9vq9z9wuFfo+JJL8q10PRh7Ws7VvAluqiAiySneZg6J1foHq5ehlPWyK3OjHXgewWJOBNdwuMfwN/4JIfA/bFab0VDPA9bnwlsVx13eGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629249; c=relaxed/simple;
	bh=Cewj0Md/NTh4ZJ5h70KHilACclNk2qKU09zvX8tHOaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TRs9mcI8zcZW/bNZidhgaJ/5iJKc3DoeaTtVA6CTwUkUB/lsD6F4KnNFFcTC/jazSfmNByCUgHl81LIIumQcOEZdAMXHoFHZq5AYnrs8zULhd9urhLpCbNhRzZtSMo/c4WkOn91Mefvzhbp9FUH0jhqpq3nWAyqmOMAoxPdlzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WWG9pLdt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N6flWl015635;
	Thu, 23 Jan 2025 10:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LXFfOM3cM4Bctga8ghtT0qc4KDj4JJJKBXLnvvtPKx0=; b=WWG9pLdtRAqTg7JL
	Tdf/pxXTPGf8bohIAyI+IG+8AIFBefFfITqZzvHzRYYm7BqOwP8c3u+4OdzMH2uK
	82WJN88olLSkJsW96mPHFhCuzQh5AnJY3InAvzHaL8CJaEAp6yrfMySaTJwxSYV6
	ZOtmVbJEdQo6hQ+n176bZLH9/ecw5Tqz9QqgdtN7JOHz7HKNRFxUhr3RqIM4ay09
	n0qbTSFvYbMMpoH8F+ArJN6hoRu1Y6ErB1ifqezL1UcSmH/fPV31emDuFtXbBNH/
	BBBTr6XXer4xIKyAMErzORV/aUx4rGvMBlrAZcB4MIhdNF+US18oliudPZLvIVbk
	VEtSaw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bgqrgjq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:47:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50NAlOIm009702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:47:24 GMT
Received: from [10.216.27.253] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 02:47:19 -0800
Message-ID: <50b0f587-e4b6-4767-b284-f68a1e12b7d3@quicinc.com>
Date: Thu, 23 Jan 2025 16:17:14 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/5] interconnect: core: Add dynamic id allocation
 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <mdtipton@quicinc.com>,
        Vivek Aknurwar <viveka@quicinc.com>,
        "Sibi
 Sankar" <quic_sibis@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
 <20250111161429.51-2-quic_rlaggysh@quicinc.com>
 <x4lsksrpwe5z6ti7gi2kufyhrpvffsmo2im3oqhqgfaft2ihfm@7xnd6bvy47rv>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <x4lsksrpwe5z6ti7gi2kufyhrpvffsmo2im3oqhqgfaft2ihfm@7xnd6bvy47rv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jDCtysMep1kIE7Pmf0Y51rPEy_zaK0Gb
X-Proofpoint-GUID: jDCtysMep1kIE7Pmf0Y51rPEy_zaK0Gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=695 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230082



On 1/13/2025 1:44 PM, Dmitry Baryshkov wrote:
> On Sat, Jan 11, 2025 at 04:14:25PM +0000, Raviteja Laggyshetty wrote:
>> Current interconnect framework is based on static IDs for creating node
>> and registering with framework. This becomes a limitation for topologies
>> where there are multiple instances of same interconnect provider. Add
>> icc_node_create_alloc_id() API to create icc node with dynamic id, this
>> will help to overcome the dependency on static IDs.
> 
> This doesn't overcome the dependency on static ID. Drivers still have to
> manually lookup the resulting ID and use it to link the nodes. Instead
> ICC framework should be providing a completely dynamic solution:
> - icc_node_create() should get a completely dynamic counterpart. Use
>   e.g. 1000000 as a dynamic start ID.
> - icc_link_create() shold get a counterpart which can create a link
>   between two icc_node instances directly, without an additional lookup.
> 

Agreed, with current implementation, still there is dependency on IDs
for linking the nodes.
Instead of relying on node names for the links, array of struct pointers
will be used, this will eliminate the need for ID lookup and avoids
extra loops.
Instead of providing counter part for the ICC framework APIs which
involves duplication of most of the code, I will modify the existing
icc_node_create, icc_link_create and icc_node_add APIs to support both
static and dynamic IDs.

> You can check if your implementation is correct if you can refactor
> existing ICC drivers (e.g. icc-clk and/or icc-rpm to drop ID arrays
> completely).
> 
ok, I will check the implementation on icc-rpmh driver for sa8775p SoC.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/core.c           | 32 +++++++++++++++++++++++++++
>>  include/linux/interconnect-provider.h |  6 +++++
>>  2 files changed, 38 insertions(+)
>>
> 


