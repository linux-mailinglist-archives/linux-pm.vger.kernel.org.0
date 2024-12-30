Return-Path: <linux-pm+bounces-19834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B5F9FE33B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 08:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D176C160D43
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 07:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07FD19F13B;
	Mon, 30 Dec 2024 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zso6f6ON"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1AC8F4A;
	Mon, 30 Dec 2024 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543747; cv=none; b=WPEFfpocjH4xq51Xw3XmotMrtDsY2diWBj3ymqP2ZVWk5Xm+bLjWYpx/r3xJirMn5EmVb4k/aM8dx4EdWn+Q6GkwZ8xREx18cuOtu1pEZEmtEqRLPs9v59V+pi/eddMmV6dFH15uTMNOdy0skSLBX+jaXHKCRp8unpsOVjNj3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543747; c=relaxed/simple;
	bh=ma0dPynFxLWsFo0VXTorvpeLC1XqPhHxqSt1B5Movi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oFDHui5auTZhVO5xCjc5xbgXFUPbk9HqEqAQANXPkwajbbWJJGpZ4A4NaYjff2494jCEACNesKt1ZZWznP4lPYje5t7APlwmV0aQwCb76YrEUybf2DnG4x7tRgwhq8/4o0ehI/EgKl+iWF5cBJ1TMHOP530RaKzdqpo6jmKbJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zso6f6ON; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU00MDR002620;
	Mon, 30 Dec 2024 07:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Q50vJAZpKCoqJT5Un0pZozhJ37/LQDZWrlzxdceSUE=; b=Zso6f6ONW2LUJUJi
	IDrGaLuqa3vjdLsX6zqEQHQrwwyLWua2NuS9KNfzhm5waGxKAUW7e6ezdIAsxqwV
	gLtEG86zewL/6AIxALTXRuAhFp6Vr0gf0tswb0PD4odjE2IfbMvo1uv57eh5Jymc
	0xe7ND+gLmwJ1JTQ+Nv6JKmtRjApPTklhLQSMnhdUqEBopaqhJhsD4zIki3GJRnW
	pSNfdgNJtln+c4INGFcx/pcZwHBuxFOnO87BsFxlTa1xJiwEPy/WIlBV0ykkdM1y
	jjPOFwaBcfMjSrfvHbeMJJgWh/tzYl92cazGVq1e2xIIGc9xHgTGyJy8eNg281lJ
	Vs96Mg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43u6u2hb5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 07:28:50 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BU7SnDF009811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 07:28:49 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 29 Dec
 2024 23:28:45 -0800
Message-ID: <7fc6c727-d3c1-4c6d-a990-8caeb95c43c5@quicinc.com>
Date: Mon, 30 Dec 2024 15:28:43 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
To: Pengyu Luo <mitltlatltl@gmail.com>, <krzk@kernel.org>
CC: <andersson@kernel.org>, <bryan.odonoghue@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <gregkh@linuxfoundation.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <konradybcio@kernel.org>,
        <krzk+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <nikita@trvn.ru>,
        <platform-driver-x86@vger.kernel.org>, <robh@kernel.org>,
        <sre@kernel.org>
References: <ff53d7f7-0103-4e52-ac0a-c05bf4521cd1@kernel.org>
 <20241229101244.59779-1-mitltlatltl@gmail.com>
From: "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241229101244.59779-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4k_lzmMPo2W1ZvgZFZ_MGMCvV20xdCrv
X-Proofpoint-ORIG-GUID: 4k_lzmMPo2W1ZvgZFZ_MGMCvV20xdCrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1011 spamscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412300062

On 12/29/2024 6:12 PM, Pengyu Luo wrote:
[...]
>>>>> +      - const: huawei,gaokun-ec
>>>>
>>>> How did you get the name?
>>>>
>>>
>>> From website of Huawei([1]), please search for 'gaokun' here, we can know

Gaokun appears to be a code name from Huawei for the HUAWEI MateBook E
Go devices.

Could you please specify which EC functions are customized specifically
for Gaokun and which EC functions are common features used in
qcom,sc8180x and qcom,sc8280xp boards? For example, the upstreamed ones
like sc8180x (Lenovo Flex 5G/Primus) and sc8280xp (CRD/Lenovo ThinkPad
X13s/Microsoft Arcata).

>>
[...]
>>
> 
> Check the motherboard, https://postimg.cc/V5r4KCgx (Credit to Tianyu Gao <gty0622@gmail.com>)

The link is not accessible from my end. Could you please help follow the
document tips referenced by [1] if this content is important for the
overall naming design?

Here are some snippets for reference:
"for 'volatile' documents, please create an entry in the kernel
bugzilla https://bugzilla.kernel.org and attach a copy of these documents
to the bugzilla entry. Finally, provide the URL of the bugzilla entry in
the changelog."

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst
[1]

-- 
Thx and BRs,
Aiqun(Maria) Yu

