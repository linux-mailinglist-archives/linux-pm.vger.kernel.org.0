Return-Path: <linux-pm+bounces-9721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F2911936
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84BDB21469
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFCD12BEBB;
	Fri, 21 Jun 2024 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NryIwRmr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCCA1E535;
	Fri, 21 Jun 2024 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718942797; cv=none; b=Kwu+Ice8DCjaC5ox6wVm/OzWwA0AXJ4tFcHz3SIgJSVxL5uyZ94EDPmbuPBzOvFbdpZaZ8IV+6dy24noJaav8LtSPglKwijhs3d+cZiZDpcG/Xl4MlFgpYfmK32mzPYYDifKXlO0D+ZxAUNPK7aLGwvr7S6Y4qBmGath56hSS3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718942797; c=relaxed/simple;
	bh=q5eI23SwCdBtO7h+as6aceTQ9BvBJGmXFebrJIHsthI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ljgE23SMyFSjd9Xx1vUfkPZ+5hVk30Q/m8sBw1u1C14tYnQtGtuy706a1SJzocK47NOU+6JypxTzalCXtOWCasgO7qBrhQJ3ES7E+a4aiWFwMlfns5VDKtdaxMM+brbqWJ0GumLxjXx6/P+qJBSVxi32PfzO7nJkGxnKvZbsZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NryIwRmr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHBrGm020192;
	Fri, 21 Jun 2024 04:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L2nKs0Qa0VjuMP1GLy2bvvRUh1BIK0f4rqiEzz3LlMI=; b=NryIwRmrMMlNAN0+
	Pz0pObGM4j+ChhpipaRplOq/LQVJj/rmVDDOTAVmQDhi3oJ0WbbOGIeBOLfD8fTw
	IQSZLfLbXDZtLuQqr0HZVuL5/r4okMoVTXpqYzXZRf/Dd923i+kEw6lUxF4dpoCi
	0PFFDna+Z1hIkJ1A1gmeF2eh3NnRSSQG3iSCaSyC5lS6jrYyS/wyEW/FqSoWUkY8
	6oL0HcIZix6pXc10uBM2jjrhK5L/klysOYYWDBnF+Gs9BgDhLhOFp2IZ/X8B28Oj
	EGR5riAFRzbSDSdCrZ194IeShS0IGy7lV/ZfePith61OYh3jXjeeI91dk1+WhRah
	eKDpyQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrkw98xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:06:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45L46NZU025553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:06:23 GMT
Received: from [10.217.216.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 21:06:12 -0700
Message-ID: <8747d2c8-d6ed-420c-8f37-fccc2552963c@quicinc.com>
Date: Fri, 21 Jun 2024 09:36:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 5/5] venus: pm_helpers: Use dev_pm_genpd_set_hwmode to
 switch GDSC mode on V6
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
 <20240619141413.7983-6-quic_jkona@quicinc.com>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <20240619141413.7983-6-quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mr7imzXc97-dTnXFUF09W3VK7vHwpGY4
X-Proofpoint-ORIG-GUID: mr7imzXc97-dTnXFUF09W3VK7vHwpGY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210027



On 6/19/2024 7:44 PM, Jagadeesh Kona wrote:
> The Venus driver requires vcodec GDSC to be ON in SW mode for clock
> operations and move it back to HW mode to gain power benefits. Earlier,
> as there is no interface to switch the GDSC mode from GenPD framework,
> the GDSC is moved to HW control mode as part of GDSC enable callback and
> venus driver is writing to its POWER_CONTROL register to keep the GDSC ON
> from SW whereever required. But the POWER_CONTROL register addresses
> are not constant and can vary across the variants.
> 
> Also as per the HW recommendation, the GDSC mode switching needs to be
> controlled from respective GDSC register and this is a uniform approach
> across all the targets. Hence use dev_pm_genpd_set_hwmode() API which
> controls GDSC mode switching using its respective GDSC register.
> 
> In venus V6 variants, the vcodec gdsc gets enabled in SW mode by default
> with new HW_CTRL_TRIGGER flag and there is no need to switch it to SW
> mode again after enable, hence add check to avoid switching gdsc to SW mode
> again after gdsc enable. Similarly add check to avoid switching GDSC to HW
> mode before disabling the GDSC, so GDSC gets enabled in SW mode in the next
> enable.
> 
> Signed-off-by: Jagadeesh Kona<quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa<abel.vesa@linaro.org>
> Tested-by: Bryan O'Donoghue<bryan.odonoghue@linaro.org>
> ---
>   .../media/platform/qcom/venus/pm_helpers.c    | 39 +++++++++++--------
>   1 file changed, 23 insertions(+), 16 deletions(-)

Reviewed-by: Taniya Das <quic_tdas@quicinc.com>

-- 
Thanks & Regards,
Taniya Das.


