Return-Path: <linux-pm+bounces-10373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622849246DB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159001F2683A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1DA1C0DF4;
	Tue,  2 Jul 2024 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hHi3r7rE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C316B394;
	Tue,  2 Jul 2024 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943320; cv=none; b=tbioN6LzackZ313NZtR640xd8OqV0uJXec+W9Y1p7ZZUYwZRdiSycLcBGEyyRUtL52XOj3YPeYBG9q3Zn3/PNXkR99Whcv72sEdBphn2rdJRZRI6qymhbLu6n2BGPXc9KLRWQpNj0MjLWJf440DIIiAqpnOqP7JMj0oWxScvOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943320; c=relaxed/simple;
	bh=lP+nGGPwNE1RQTO6K8Nb1MPdV0ZDMIU2K4L1RrDfDgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gt0STjtQ0FeW5ceJjKUWtufWMin6d+8bF93GeiYuzGbRZb+nz1XF9ltJlZrDFKCd+zb8eMfCrfg/mrIZOez6nFR13HmwXW+rly3gmg2QMo3+SBeipydJCZaUwNEubmEc2P94zKRmXjI4CuQSwU/D7CUTL3vrUF07aaCfhl8g7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hHi3r7rE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HE9d5026185;
	Tue, 2 Jul 2024 18:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3WAkOOmx+EV/jeAG/Z7JRQqqLw7VidhBmcMNbDg3RJk=; b=hHi3r7rE6Uf5pdkx
	BP+FKu8dns4sMYzEjp7/OW3O7N2OiV2cxoYoPABSwfGzoWoCr1+Vx/dcqc5SI8Px
	FhRZfglIIBdd3Yb07pGpIGY/OnAjC45wv8TcpsUOT63ee8gRq14ExqyvbBGVgHRK
	QTFZ5o2baLPnVH038GDC70m0w/KWbFmV5qb7Ka4UHsEyecDmrvxwSrQBP4qaRAAI
	DxU0+iqIVB8dWdoCmXjQK7Nytl31ankn/XPC7AFS9uufkdhUg1BE9XiaJd1d/0h6
	ODGkSdItKwptPSHJVaTDln+dfHm+Rr56zfqmm4KBXCyy3Ie1fLE04LEXQPwH5mQt
	q4GxLg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027mnpxvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 18:01:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462I1pxE022434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 18:01:51 GMT
Received: from [10.50.20.191] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 11:01:45 -0700
Message-ID: <0a2d2bea-b043-443d-a898-c5e4c24b2b8d@quicinc.com>
Date: Tue, 2 Jul 2024 23:31:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] interconnect: qcom: sc7280: enable QoS
 configuration
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva"
	<gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
 <20240607173927.26321-3-quic_okukatla@quicinc.com>
 <ciji6nlxn752ina4tmh6kwvek52nxpnguomqek6plwvwgvoqef@yrtexkpmn5br>
 <a7b959ff-a041-4380-86dd-05cdbc11fab4@kernel.org>
Content-Language: en-US
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <a7b959ff-a041-4380-86dd-05cdbc11fab4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GjBYqGc1vZkj_4zU9iuCMsASOoElOJ5y
X-Proofpoint-GUID: GjBYqGc1vZkj_4zU9iuCMsASOoElOJ5y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_13,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020132



On 7/2/2024 5:02 AM, Georgi Djakov wrote:
> On 1.07.24 19:42, Bjorn Andersson wrote:
>> On Fri, Jun 07, 2024 at 11:09:25PM GMT, Odelu Kukatla wrote:
>>> Enable QoS configuration for master ports with predefined values
>>> for priority and urgency forawrding.
>>>
>>
>> This patch causes QCS6490 RB3Gen2 to hit a bus timeout and crash during
>> boot, unless the associated DeviceTree change (adding clocks) is
>> present.
>>
>> The two patches are reaching linux-next, and hence mainline, through
>> different code paths we now have periods where rb3gen2 is not bootable.
>> But more importantly, devices with current .dtbs installed can not boot
>> the new kernel.
>>
>>
>> It is not acceptable to introduce non-backwards compatible changes in
>> drivers (unless there's extraordinary reasons to do so).
>>
> 
> Thanks for the report, Bjorn! The intent of the patches is to keep it
> backwards compatible. I think that the patch below should fix it.
> I'll try to validate it and get it merged.
> 
> BR,
> Georgi
> 

Thanks Bjorn and Georgi!
I will send a patch to address the boot up issue on old devices and keep it backwards compatible.

> -->8--
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 93047defd5e2..487e562dbd22 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -311,7 +311,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>   		}
> 
>   		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
> -		if (qp->num_clks < 0) {
> +		if (qp->num_clks <= 0) {
>   			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
>   			goto skip_qos_config;
>   		}
This will skip the QOS configuration for the providers which don't need any clock to be enabled.
we may have to add a flag at provider level to check if it is associated with qos clocks.


Thanks,
Odelu

