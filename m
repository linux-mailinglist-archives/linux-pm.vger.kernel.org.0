Return-Path: <linux-pm+bounces-9880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EA3914578
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 10:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A318B2526B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1ED7EF1F;
	Mon, 24 Jun 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aauhLs3l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45F3F9FC;
	Mon, 24 Jun 2024 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219368; cv=none; b=t/brd+vRxjNC3TmNXawzF6AYL5LnCT7ArbQzGg/B4EwCOWf64+IYNGoESzj16I63pQcjA6DNoL+mOrcJekVokRSOAFRdhPopJPlDrzJ2FAG4tEbR1NupsNc5ZIqnJu0geqVwlN+RlN1O+4PUyCece4FSELscMmNxS2r6cHmKbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219368; c=relaxed/simple;
	bh=+bygkKk1WfkvVMdSDIt61TKr8vEFEVMA5qyD1Gk/ccc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EVDKQqNKCKysR9Dw5n75ITGmTZOTcYkNErWujxLQuRijr0ptBfWS5UpIdtAu0wldV0h/OocC2e4NzjpH0i8Ek43NWVNmdcfmHOO0FP/ZJAcCzWu1+1bkMhxdbR6kDg7DOO3eWZfDYkf0Vx9qe1wc77yA6pcwrHZVS+3x2ASw1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aauhLs3l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8Yrmf001863;
	Mon, 24 Jun 2024 08:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ym8HMC9nai1QhqIk9+SG/+1uqg1DwzsdgBpOI0EAl8A=; b=aauhLs3lgt9M568Q
	BnXfgN+jN7UcgDEQjkQO3O+bVbuxn9pVcHMKtOmfZWSdo4kmLdsz3LKOM/pax1u1
	0ApkCfZOvPpcNUHPZ2hhxbIZM7altSXjnAdvxVaExBPS5jYheP1fxZQoSV8oMl/6
	LTQ9DfXNAb+mZpc0sj4kxILM/nzQdYU4TOTFoStnGGNUpBcrIkUclz6Shjn9rfK5
	k2jNPTU8cBbfYsRe1rXQU1nE0bWw6fWvjA0ThSiAjpnGCa0J8IVQF6S9vDOugmGZ
	DMR06j3aEu60DB+1QFtJ/Fcnag8+hBGY4pqRr5ZU1JDAo43/ajxXyy9T0A9cj0sN
	vo2kSw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaeuarw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 08:55:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O8twa0002217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 08:55:58 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 01:55:53 -0700
Message-ID: <ce899bbd-f8df-0a6d-fc8f-bae6423ff8d2@quicinc.com>
Date: Mon, 24 Jun 2024 14:25:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/3] arm64: dts: qcom: x1e80100: Add BWMONs
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
 <20240618154306.279637-4-quic_sibis@quicinc.com>
 <8cb65123-dec5-4740-b1ff-58f065716887@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <8cb65123-dec5-4740-b1ff-58f065716887@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lzwGxvMZigRPaE6z1Ihoo6XicdCmI8LG
X-Proofpoint-GUID: lzwGxvMZigRPaE6z1Ihoo6XicdCmI8LG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=852 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240071



On 6/19/24 01:03, Konrad Dybcio wrote:
> 
> 
> On 6/18/24 17:43, Sibi Sankar wrote:
>> Add the CPU and LLCC BWMONs on X1E80100 SoCs.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> 
> If you're going to resend, please add a comment like:
> 
> /* CPU0-3 */

Ack, but I'll mention the cluster info directly.

-Sibi

> 
> above the respective monitor nodes
> 
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad

