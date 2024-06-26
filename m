Return-Path: <linux-pm+bounces-10060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A7F9186F6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1F31C20AC9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802A190488;
	Wed, 26 Jun 2024 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G42M5ieT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF201836DD;
	Wed, 26 Jun 2024 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418168; cv=none; b=t2S6GOGECNOjb1G5phxDeJh7/pI0PNlAXp4V/iliWegbtr5h/THt9d7bMocvGgO5kgSOsd+4wg+oyaaLTHfbAkMP2CuirCkVYDtuTnJA09L4UDTB/GuMitcTcv4T2EdQ5VH0P/wfGjwpZBzSIK9l4S50iPm5GhLdKTNI6rnTqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418168; c=relaxed/simple;
	bh=+HnB7kIF8mFJGnjNHwdzEVnKSMHqAod79G8Z5X+tzp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=apooRV9PUI18InsPjrfIJcyXbI4R+3KBsgAdAhPCTHSP0+60Go0LW4Tf+sFJyFBCecxOFHExmPQFu/8TAw2zfhCwoHsBsnaKm+4BFIjgnb7Xb5sryHc3cp40SwT5Sd+OOT78jhDUk/f6kCzq2LIyCMCSexvCwOyr1JdJUCE99iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G42M5ieT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfVcp023759;
	Wed, 26 Jun 2024 16:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C1G/TakuwelynWwy6SdzE6YabFPLE1AhY9DsYo8fk3s=; b=G42M5ieTTUeN3EpV
	PlS7PzIEGnWR8po9BdozlWxsKIAJXl8QE4egHbNji8RpG6Syj7HCMjqpKnr/E6gd
	qylAjRqNwxcg1VkGvWFhN+94dzt4yghZVkqIDMutjmNbXyW3Lr0+2meKnzon/zS7
	DvzZkHRdNZdlpE8kKctM73kB0oq82Q3GmBVmCml+E9vDqja3US8LAEuTXmn/hpnQ
	FFu5WOXm1qt/sfTUKaQOkcIV4nIVXJhsrAgUaOGxLCvbNI/CUlT2yaqu//YhesCi
	UZ5aBg4bAylyJVjb+0MtK+uB4zB+yS/6zA7zWjh3XXhm9slMWyRb50HybkLdRxBj
	sDbuFA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6yt2p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:09:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QG9KPA031306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:09:20 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 09:09:20 -0700
Message-ID: <0e8455c6-7236-4bfc-ac0b-8661d3195850@quicinc.com>
Date: Wed, 26 Jun 2024 09:09:19 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: reset: piix4: add missing MODULE_DESCRIPTION()
 macro
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240608-md-drivers-power-reset-v1-1-08dbc1a546a2@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240608-md-drivers-power-reset-v1-1-08dbc1a546a2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fMloydVgFMs3Lah4CNyE9zbElj0JAWSM
X-Proofpoint-ORIG-GUID: fMloydVgFMs3Lah4CNyE9zbElj0JAWSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260118

On 6/8/2024 9:02 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/power/reset/piix4-poweroff.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/power/reset/piix4-poweroff.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/piix4-poweroff.c
> index 7f308292d7e3..e6822c021000 100644
> --- a/drivers/power/reset/piix4-poweroff.c
> +++ b/drivers/power/reset/piix4-poweroff.c
> @@ -106,4 +106,5 @@ static struct pci_driver piix4_poweroff_driver = {
>  
>  module_pci_driver(piix4_poweroff_driver);
>  MODULE_AUTHOR("Paul Burton <paul.burton@mips.com>");
> +MODULE_DESCRIPTION("Intel PIIX4 power-off driver");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
> change-id: 20240608-md-drivers-power-reset-488bf66477c6
> 

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff

