Return-Path: <linux-pm+bounces-22783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D3A41831
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 10:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EC51883F30
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14313192B95;
	Mon, 24 Feb 2025 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QL13uMM4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A819DF48;
	Mon, 24 Feb 2025 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388119; cv=none; b=GzY/ezsfP4jCc9LiDR0Hh3Z/wTw+/RI7nguIIuiLFwX8RdsP4hUyYaPCTGxY56iigy8MZ8BwcE7eSvEpnBHAuRoqxE4B9xy27GcV73Q9XY0RBx8mT86YabtmpGo/kz5VAk2pv7ZxQ3XMx9Td2XKCvJtMglzDwJlTotRtX8P9C5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388119; c=relaxed/simple;
	bh=/KwrmDzVn/IbSMKODHXtZm6DBbwAHY94SXEGnAlkDTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kLGpTKfmtofkFq8TfseiooHxQ962se3d7Oxk1v+rRYPIMAm0UhDvWU+qjHhLQuLmvu0UgqRuhpCWDmCUoD9NBPPn6q0gnAD4KOb1gHKED+RGNNaOGjny4YHvJ3zR/JkfNdETDWFdjZ7OYJLMF631jdvZwPqhsfbfiXnwSOwa0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QL13uMM4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O93QFu010484;
	Mon, 24 Feb 2025 09:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A1jC96k6LPaXJrk8LYQZMxGVSvFRjbSnsjHPT0VVuVw=; b=QL13uMM4HV40WKVp
	gS2y+V59bfdBM2R4dPPkEN00vMTQc0lO7cM6YaX5/GWfOt2P6kIOLml4ir6YZL05
	ZjEvElnKb7TPoL9WKOsa6UYcTkeMhKwnTzSRqcXkbvR9LzGv1nqy1RIGHGeb0jKu
	B6u4dN22mcYxekQQjloX2gkpLCOkYuNEGJZlCN46GCOAUwEUa577DUlLTQWemfqn
	K6nZDD+i8ohDq8igtuuJk8Qmbpv6E8a+GOfEPc1xfByo2f/HoKLWj6QyHpn5JYXO
	ZBfUPJR9GoCNEGQiayM70nJHN2vI03PYO+HQGD08lHzjR1mrZBD/SimwhKRlODJh
	3F14Aw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y49ecgph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 09:08:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51O98Vcf018631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 09:08:31 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Feb
 2025 01:08:27 -0800
Message-ID: <be872be1-dd0a-481b-abe0-57ed2bf50c22@quicinc.com>
Date: Mon, 24 Feb 2025 14:38:24 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] thermal: drivers: qcom: Add new feat for soc
 without rpm
To: George Moussalem <george.moussalem@outlook.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <dmitry.baryshkov@linaro.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <quic_srichara@quicinc.com>
References: <20250224061224.3342-1-george.moussalem@outlook.com>
 <DS7PR19MB88837D7AE30CE306B8F71F3E9DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <DS7PR19MB88837D7AE30CE306B8F71F3E9DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 39CT8ZCXUhHY2WMtpu3GLoDtd7HggTcU
X-Proofpoint-GUID: 39CT8ZCXUhHY2WMtpu3GLoDtd7HggTcU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240066



On 2/24/2025 11:42 AM, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> In IPQ5018, Tsens IP doesn't have RPM. Hence the early init to
> enable tsens would not be done. So add a flag for that in feat
> and skip enable checks. Without this, tsens probe fails.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/thermal/qcom/tsens.c | 2 +-
>  drivers/thermal/qcom/tsens.h | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 3aa3736181aa..a25ca17adf1a 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -975,7 +975,7 @@ int __init init_common(struct tsens_priv *priv)
>  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>  	if (ret)
>  		goto err_put_device;
> -	if (!enabled) {
> +	if (!enabled && !(priv->feat->ignore_enable)) {

Please drop 'ignore_enable' and use 'VER_2_X_NO_RPM' instead.

>  		dev_err(dev, "%s: device not enabled\n", __func__);
>  		ret = -ENODEV;
>  		goto err_put_device;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 7b36a0318fa6..90bf11fba563 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -505,6 +505,8 @@ enum regfield_ids {
>   * @srot_split: does the IP neatly splits the register space into SROT and TM,
>   *              with SROT only being available to secure boot firmware?
>   * @has_watchdog: does this IP support watchdog functionality?
> + * @ignore_enable: does this IP reside in a soc that does not have rpm to
> + *                 do pre-init.

Drop 'ignore_enable'.

>   * @max_sensors: maximum sensors supported by this version of the IP
>   * @trip_min_temp: minimum trip temperature supported by this version of the IP
>   * @trip_max_temp: maximum trip temperature supported by this version of the IP
> @@ -516,6 +518,7 @@ struct tsens_features {
>  	unsigned int adc:1;
>  	unsigned int srot_split:1;
>  	unsigned int has_watchdog:1;
> +	unsigned int ignore_enable:1;

Drop 'ignore_enable'.

Thanks & Regards,
Manikanta.

