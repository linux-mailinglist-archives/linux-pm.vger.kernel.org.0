Return-Path: <linux-pm+bounces-9094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5082690793D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47C4B23F3F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2921474B6;
	Thu, 13 Jun 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WcKzJj41"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB14C6B;
	Thu, 13 Jun 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298191; cv=none; b=GKlgLo0HGDiQ9wPgwBNoUaaiyLX3Tpl3jSURmQxgFR0Gtu0Gk1gKVE+zzDrcfUf2Vbq1YcTvwAQPkX0L74GMXiI81P+unK+4e9SVE7WTJJMjovKX4dXr3crj5DzjFa/HJQx7zqeKp+RrMuwVPlQXFYxmwiZN/lJK+f6xrAnK2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298191; c=relaxed/simple;
	bh=hY9/IYS4RiaVb9Xx3WBRsafNA7SrRdXdyOsBHATd91g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vm09aBbfmG4ZKgtio4JHYf28tgn9Gd3TRdANoV78fnqHQnYlpZvhHg4k81Gcy9Q4A5Ch5dO4CXJ9VxA8qtLK6Av/OgI5eTkmI5iGzJVYQMwQchfmfgiewEDWXrw3BvW0ihmnYoN8sH3V6SrLNxFQXuM2Os2KfurTM5T6/xMVl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WcKzJj41; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D8wv8c001101;
	Thu, 13 Jun 2024 17:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c0AIAamQnbcEzfp+dXj5IacM2uTRQ2jNA9dY7DbMN+A=; b=WcKzJj41XyOtLfE7
	+8ZVBk13tD0YW9HMCXa9aY9nTAY1MYnysoT48Ps7DhabmGiJUxYGJCidMb7ZYVXv
	t8KoE4cnGc2DePbpyQVZdIhDqgfJuH/8KrXV4padHI4C5RTC+bd82HWo06rPqGtB
	JKCb+5imbzjgvnEn+o19tE5vfqEMGIiDKsqjz0mIpm8jNrEfNPd+8M97hEl+1YSR
	+k1JEe02OVKc3atkQMQefn4VON07WZYG+edkeJK5gr7NCtmsJWtd4t2VoabejB1R
	mwmw2DacfeDNhDq1QzYECGUF6ofKWI16EgiiN3eJIfQtM6VrgHGbO1rGPJCYsHDD
	qA3hqA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypp87y9yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 17:02:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DH2ueT007987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 17:02:56 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 10:02:51 -0700
Message-ID: <5df5dc6b-872f-34c5-a6d2-a64f9c881193@quicinc.com>
Date: Thu, 13 Jun 2024 22:32:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] soc: qcom: icc-bwmon: Allow for interrupts to be
 shared across instances
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <20240604011157.2358019-3-quic_sibis@quicinc.com>
 <5e5f052b-df59-47fb-aed0-10b4f980f151@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <5e5f052b-df59-47fb-aed0-10b4f980f151@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WtebBA6V2IZQ6CERDgXW4_tBdtnP1I82
X-Proofpoint-ORIG-GUID: WtebBA6V2IZQ6CERDgXW4_tBdtnP1I82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=483 priorityscore=1501 adultscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406130122



On 6/4/24 12:16, Krzysztof Kozlowski wrote:
> On 04/06/2024 03:11, Sibi Sankar wrote:
>> The multiple BWMONv4 instances available on the X1E80100 SoC use the
>> same interrupt number. Mark them are shared to allow for re-use across
>> instances.

Hey Krzysztof,

Thanks for taking time to review the series :)

> 
> Would be nice if you also mention you checked that it is safe to have
> both devm and shared interrupts (so you investigated possibility of race
> on exit path).

I didn't see any problems with devm being used with SHARED when I posted
it out. After your review comments I went back again to vett the exit
path for races and ran into an pre-existing splat [1] but the bwmon
instances work as expected on module removal/re-insertion.

[1] - 
https://lore.kernel.org/lkml/20240613164506.982068-1-quic_sibis@quicinc.com/

-Sibi

> 
> Best regards,
> Krzysztof
> 

