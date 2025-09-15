Return-Path: <linux-pm+bounces-34662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB18BB57621
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 12:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBBF188AF95
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE522DF9E;
	Mon, 15 Sep 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="da0JSbhu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF732FB984
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931528; cv=none; b=qYm07wgudQ0wbKkx2qTM/LQNj43NhVrYqq5BUODBicKS2/gzlVQBnhJm8uFDwxCMBj4peJ1+lgs2ygMRt8DGPg0uehg/Mv2OgUS/HmPijXoICL7vUGx6HvpAeq4iK4oNdKvmhzGFY79U3cnE9sU8Ug5zeNJLHemM/UqNnuelfXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931528; c=relaxed/simple;
	bh=2DFmeklvao42pHIQMNAwiexVB+Ti6nsJ0npJbl0Lig0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/8vaCaRYYiWb/RnmvL+UQoB8oNVl36gJVi4m/OWZCF/+L92TEsF4wQrNn+y2QeJTVFyL+x0e97vAVlRU+wozfmRSpfH5q7lNJBB9FWqNE8kykvc1day2RA24hRV0CNSp+4GOSLFo1NnPaGAe/owcRun+7zhQfq+xXdZkWOMXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=da0JSbhu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FilI002367
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=55rSt8hh8LRp7D+XRwZ3HRX8
	gaT2aSzDULCuVkcpLrk=; b=da0JSbhutHhuvYdOrnSuP3WVs/M7F7kPfyjnQgg8
	pGmMsFBJ1B6++4IUsdS5u0rAH1qJCmgt/9L7GTWsypoNDJ5ghen9JKUfmwCecSRN
	RL/CHtmjZ1USdZIJldVUyXcUUF7gMRDV3GIIeCOg+CL1I8kIkSqxubPw/cLH6uJd
	d167DALSOkivr9vX+Ujk7RL4Aw8Qre8/GSR8uzswGZslhIsfZ/ALBRp4sFfqsFts
	OzAWz11rMTzHiwz7CQQiEuxI3A/k2PvAywkZnSu4b2zrc/Onbx1Srj3s/EqXFLIN
	rtTdZGoM/9/Hua8N6fIulSDP9q8akZKmL/6pFZ7VPLXcgQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da98vkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:18:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b7ad72bc9fso4243421cf.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 03:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931525; x=1758536325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55rSt8hh8LRp7D+XRwZ3HRX8gaT2aSzDULCuVkcpLrk=;
        b=AlLFJBsGTql/1M3m3OIBS6z44uKH2RNNllrQCJ8QCytoCEeuGqmLidi6SgWyiBnZzK
         Ck201BBfscrpRrw4FA7Wz/LQiB6U/KrAw5K8GGYrP4dgvAPR5hgnIhEbnzZwCCMG3ZOZ
         NlcxAQHX8cKjNHvFuPnULfqfRMySV/bL5CX9oEmM44Kigw6riBdLHWD0xNWJT5BfytwU
         7KjaVAgtFaRId7j0Fqb0tVHbRUKrzFnTomapxhMm58o+4/f7d58SfmtKAuIheYRXdZ69
         8zJ3wcu9a+GjSKls41/NhiOhJkCUL0Ffrm6uN35guQc71Wr4Dk7C4uPgEej/EbcTAtww
         C9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjFBt1EBDeeELFCDKcAd+Prr4fAJcgnX+thnu0emCZDxCPpVFJhoyXwrck5ILcHSLQcH39QcaKFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbR+PlyVAxHqmwNC/TMy9UsTSck3tRjGHb8/Z7VfQTNX7Ik0IJ
	t/6WpWjbWhQp6yNE+2/3EI+I/hnpl4/xf3G6h5D3XjbiHgwQfuF2P6XLOXA8DmrIJa9w//2adaQ
	XaMvsg2xVjB2E3NClcKC2KFfBlUTRoCqeKQvz0yMxD9pb83oWNIE26ZXvI8093Q==
X-Gm-Gg: ASbGncs7jXwBKZXwO07414ahUi7vmeUpxiqUxVsxTZWnYbwUvkymmRq0wNXfExffaar
	dKEV+uKwOeolgL/SbXwW4l11i2H4bQqbbsdCnBi5VOjwyqZl5YSDXPOWUPWa2QJYs22Z8dfe0hi
	LNxqrMMgN4+DKJacrjOyw7GatW0ewDesxQUfswxiA9+pSssSGEcLXEjMKvnEhqM6M5LsUTNl6xs
	Pxh0r848qFVAuGIRymsrJkVSC0FXjCPkBt+tc1iwEBZ710aSKYbGXOs+ELVvO9KsIn/q9DL8uXH
	1tpfBB2P2xM7jK6B1+220EH+KabSfPpsXCOHm36R/7xfZ6rPES1FxQfEe5UZUDJ4lOgu28iYSzH
	gDr/cHcanVkf1LyfDsxf578yF49trfoe9S/CX7q3RwEDfdv1EK2sH
X-Received: by 2002:a05:6214:260b:b0:767:a99:9652 with SMTP id 6a1803df08f44-767bc5e5489mr113847466d6.21.1757931524603;
        Mon, 15 Sep 2025 03:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb0rsGhFRkV1wcbwpZkUhSb0Y79dOKiqbr59bDkqCwcyia5wF996ysW8fqVZME6pG5L6Q2OA==
X-Received: by 2002:a05:6214:260b:b0:767:a99:9652 with SMTP id 6a1803df08f44-767bc5e5489mr113847086d6.21.1757931524032;
        Mon, 15 Sep 2025 03:18:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f400esm27540601fa.23.2025.09.15.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:18:43 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:18:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: fenglin.wu@oss.qualcomm.com
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?utf-8?Q?Gy=C3=B6rgy?= Kurucz <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/8] power: supply: qcom_battmgr: Add resistance power
 supply property
Message-ID: <gk2ho7ugp35kb4x65meqsm3aufnry6srr4p7jspf6xyn7ywzkh@vd5ca7txjdk6>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-3-6f6464a41afe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-qcom_battmgr_update-v4-3-6f6464a41afe@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c7e805 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=4KYCil5nhH5hbAJYY60A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nv668GWOfh9gFeuwAyHoUys9sxRAtde4
X-Proofpoint-ORIG-GUID: nv668GWOfh9gFeuwAyHoUys9sxRAtde4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfX7QFK8X5ZxF/F
 EXgxC1T10hORm473h1wWogNDANpWqWAWr44V7g6wSHnLX7MprXqIc8BT3BRRwcHq3TWTIj38oMt
 1C0+U68h5GRdWACJgIoPaOW25T4IJU0y3x5QME8IRR+nWq4UAcQcnp/bs7vjZxqhF99HxZLzgtW
 q8eBeaNZ71948tIrV+Fa3Nr3uItQn7yl4Ki7H+tPAOk4VqQf9y1uh2yMPP4v4JZCmjKGi3925Eq
 sFBu0+CzY242czF+ojbvrq8rJyj4IrbLh5a+aHl0OGeFlkGLv+1gAftTVW5vrjDoJBkI3cuudTJ
 TR6bJmRSJuQWsoU2GkBtig3mU2J7P9mxtGK4x1q6QKw4C3g8BesqQl5+bMLalUYBBqdInUdtOOq
 9Jc9gacF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056

On Mon, Sep 15, 2025 at 04:49:55PM +0800, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Add power supply property to get battery internal resistance from
> the battery management firmware.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED

T14S is X1E80100, which uses SC8280XP-specific sets of properties. This
patch changes only SM8350-related data. How was it tested?

> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index fe27676fbc7cd12292caa6fb3b5b46a18c426e6d..55477ae92fd56ede465b32d6f7ed9da78ebd869c 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2022, Linaro Ltd
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.

Please follow marketing guidelines here.

>   */
>  #include <linux/auxiliary_bus.h>
>  #include <linux/module.h>
> @@ -254,6 +255,7 @@ struct qcom_battmgr_status {
>  	unsigned int voltage_now;
>  	unsigned int voltage_ocv;
>  	unsigned int temperature;
> +	unsigned int resistance;
>  
>  	unsigned int discharge_time;
>  	unsigned int charge_time;
> @@ -418,6 +420,7 @@ static const u8 sm8350_bat_prop_map[] = {
>  	[POWER_SUPPLY_PROP_MODEL_NAME] = BATT_MODEL_NAME,
>  	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] = BATT_TTF_AVG,
>  	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] = BATT_TTE_AVG,
> +	[POWER_SUPPLY_PROP_INTERNAL_RESISTANCE] = BATT_RESISTANCE,
>  	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
>  };
>  
> @@ -582,6 +585,9 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_TEMP:
>  		val->intval = battmgr->status.temperature;
>  		break;
> +	case POWER_SUPPLY_PROP_INTERNAL_RESISTANCE:
> +		val->intval = battmgr->status.resistance;
> +		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
>  		val->intval = battmgr->status.discharge_time;
>  		break;
> @@ -665,6 +671,7 @@ static const enum power_supply_property sm8350_bat_props[] = {
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
>  	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> +	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
>  	POWER_SUPPLY_PROP_POWER_NOW,
>  };
>  
> @@ -1174,6 +1181,9 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>  		case BATT_TTE_AVG:
>  			battmgr->status.discharge_time = le32_to_cpu(resp->intval.value);
>  			break;
> +		case BATT_RESISTANCE:
> +			battmgr->status.resistance = le32_to_cpu(resp->intval.value);
> +			break;
>  		case BATT_POWER_NOW:
>  			battmgr->status.power_now = le32_to_cpu(resp->intval.value);
>  			break;
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry

