Return-Path: <linux-pm+bounces-9720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C1191192F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2331F2264A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 04:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268412A16D;
	Fri, 21 Jun 2024 04:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q/V7Ed+Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084681E535;
	Fri, 21 Jun 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718942690; cv=none; b=r3DfhhjHJKTXynKfe47OBp90yqkdkm818F9qCF3okHc7+vDh56sppG3nUpZETnOZffdhSghGoGwtM4XA5h1wsymOEOgdPSeK+p+LjxDr9fYA+lSx4GqX1bSH/9h/qj6sLLGcuEHkf06dVA5KtsFjCp3iAacOtqNiBaKivXStNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718942690; c=relaxed/simple;
	bh=TWn+VAs+yt1poufCYoHR95yT76a4lkePLQrFw+0ybU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qAJZQeZHv7S3XqQFDBpAKG9q6Doh3uTm0lzKryUCAbArT96c+MMf1W1pAVX1Z2dyIVZT+sBwLVvsWB1ELSVU2q6yrex4tacl+1RFYu7kMm8bhtw/kMd5WldF9Tgh9WoVxI2o2UiZ+06ivEQ09DkvICfz4LdIiLQ+HWoH0k4uvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q/V7Ed+Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHBCQ8023958;
	Fri, 21 Jun 2024 04:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qRWpFRcdT23aDhe98lnzKmXFGk0cKE+JDfcVUnQ0AFI=; b=Q/V7Ed+YHWrWw5ag
	EjrTSBRvW6rLsI/5vJxtTL7xYpXX+GLp7ip7Fwm1Ktnz+eNN7bjsl37iS33v+Fny
	Wc084lcs0VJr9DNsJGBNKVhdDBCRSNxYNCeLzR29L5bV3VYZAgAs8dIS/jf469HD
	8Sp28+gLIbdemm31ouDmWDyxcf2rrEZnJ3wIAMKzxNYp568Ss2gMKCMvLHGGAhk/
	8lUEYT6AL/bcUv4VQgYQL9uvN9r3D51B+szwkhgDk7jGThISns1hJXAqrAgRPPvN
	6W+cOnz7qLY9aw6Bgt/PyChjksL8EsKDejGtroAR9SFw+22olJxq6up6BA+ZcWw1
	03U/2A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrkssb9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:04:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45L44dSM000608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:04:39 GMT
Received: from [10.217.216.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 21:04:27 -0700
Message-ID: <96e541fe-9be5-45aa-be64-c1f85cad998e@quicinc.com>
Date: Fri, 21 Jun 2024 09:34:23 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] clk: qcom: videocc: Use HW_CTRL_TRIGGER for
 SM8250, SC7280 vcodec GDSC's
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy
 Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit
 Pandey" <quic_ajipan@quicinc.com>
References: <20240619141413.7983-1-quic_jkona@quicinc.com>
 <20240619141413.7983-5-quic_jkona@quicinc.com>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <20240619141413.7983-5-quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4elfS-UmcBU681s8DmqkxEWBiHEo-AzA
X-Proofpoint-GUID: 4elfS-UmcBU681s8DmqkxEWBiHEo-AzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=889 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210027



On 6/19/2024 7:44 PM, Jagadeesh Kona wrote:
> For Venus V6 variant SoCs(sm8250, sc7280), the venus driver uses the newly
> introduced dev_pm_genpd_set_hwmode() API to switch the vcodec GDSC to
> HW/SW control modes at runtime. Hence use HW_CTRL_TRIGGER flag for vcodec
> GDSC's on sm8250, sc7280 to register the set_hwmode_dev & get_hwmode_dev
> callbacks for vcodec GDSC and allow the GDSC mode to be changed using
> dev_pm_genpd_set_hwmode() API.
> 
> Signed-off-by: Jagadeesh Kona<quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa<abel.vesa@linaro.org>
> ---
>   drivers/clk/qcom/videocc-sc7280.c | 2 +-
>   drivers/clk/qcom/videocc-sm8250.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Taniya Das <quic_tdas@quicinc.com>
-- 
Thanks & Regards,
Taniya Das.

