Return-Path: <linux-pm+bounces-9788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AEE912C8C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 19:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BF8289ECD
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD811684AA;
	Fri, 21 Jun 2024 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K7NLThrQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501F8BFD;
	Fri, 21 Jun 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991831; cv=none; b=Jxvz9YEtydhNvgEOMiF4BLO7M6K0Qm4q3qbD3JZnyVp9JzrYBTJ8I+K+uEvNvQ6y+VNYWUW+WaRig40WNG6TsNuEyGjqmYwaLCtc2hpx1eXz6yG6fQboRx++QbwccPlC/q6fEOH/JTW/ZOaVejJq3vzUl8Ji8lCxFeWU5N+pst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991831; c=relaxed/simple;
	bh=X8jfzg/wyxs168n27oHncGTMVl1l94eynwuziWyg5Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nke2TCTKy5lNmJkhJkGmfwjBKEWOUWAyvCvpGjgNUfPyJy+X92GzIVis1wJEbUGqaLfNDw1brOt7Lvu4AZDrhI6z9W3B15CFdqgvXgS2Ia1AzAPNuqgLBIEmiGsodO0sWOF9+B/fuyc3ttswIjjgHneJvKF0dTR88+6I71ll8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K7NLThrQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LFbvjP021677;
	Fri, 21 Jun 2024 17:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J4d77Yn0f566TtqVIjt1HDWczzH71mbrVuT84+uqzSA=; b=K7NLThrQVbTZeS88
	U/bpc+F1H1yGivwcMb6k6M/JklRLG8K87fI4MJhZ5emkO1SYLZQreP4kOECF4gLE
	GNkQL2fE7LeliP5TDdC4DkARFVxRKjuXpxbsoB+7Ig9/Co5FQr8OLxVj8whI+uIs
	PGRmX+fPZTiU+1+GhH3XNnXY25LHnNODs6P0aTdK+MnyrsX/HtoDR2nTMQARrOAa
	XFZGKV/8KkR/iluEMT6vvA57zRhcW+jrHQ4YtR7h/RObPGSqRZbOr0Sm0N63sjuA
	pTqNLsg0SnxxAhDd53KGjdn7rnQOe5U8rN1+IVo1Q4++1Zoxc4Zhhb0PCBGgaNBq
	Q37dmg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywcb28a65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 17:43:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45LHhhGe013848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 17:43:43 GMT
Received: from [10.50.38.38] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 10:43:38 -0700
Message-ID: <d6c4ceed-5804-473a-8599-405d4ace099f@quicinc.com>
Date: Fri, 21 Jun 2024 23:13:34 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] interconnect: qcom: sc7280: enable QoS
 configuration
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
 <20240607173927.26321-3-quic_okukatla@quicinc.com>
 <910af90e-affb-45f2-a2f7-875ca8362c0f@linaro.org>
Content-Language: en-US
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <910af90e-affb-45f2-a2f7-875ca8362c0f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B_kqqTIC_s-xjSuoVgL781wJiaYmrprG
X-Proofpoint-ORIG-GUID: B_kqqTIC_s-xjSuoVgL781wJiaYmrprG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=645 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210126



On 6/18/2024 8:16 PM, Konrad Dybcio wrote:
> 
> 
> On 6/7/24 19:39, Odelu Kukatla wrote:
>> Enable QoS configuration for master ports with predefined values
>> for priority and urgency forawrding.
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
> 
> msm-5.4 also has a qhm_gic node with QoS offset 0x9000, is that of any
> importance, or can we forget it exists?
> 

qhm_gic node QoS is not that important, it is fine.

> LGTM otherwise:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad

Thanks for the review!

Regards,
Odelu

