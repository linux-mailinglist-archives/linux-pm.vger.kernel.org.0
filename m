Return-Path: <linux-pm+bounces-9417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A5D90C80D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4211F24B27
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959301D18EC;
	Tue, 18 Jun 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RMWrRuXJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D393157E79;
	Tue, 18 Jun 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703249; cv=none; b=LRVsHbZbKpT3NTGbfEaD2gq3z9EggACB+vfvxUBv4vQzsIEF4oajn/S68yk0YgCMZMBMRIUbFv9DTKKQfU0IX3ZRC+n14bnI8TttcWFfY8wbGFhCiXnQQUMolrFs3Wl8YbavT8riaOM8FN5aRVR+MyHu2d1/HNYslZgLUI8od/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703249; c=relaxed/simple;
	bh=zFlMvfBl2P4NhuI6BBzS4ExUNG7hThtpUn+utmIeUgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AQzYOdW470O0SNQgUr3IRgWCgiIBpZeE5Mr6Lmber0BOi3WeZ02gv+aFSrt1RIKH29hj+ARBNbvTt1/PnFBSRd20KgSfV+obh9jYCf5j28mLWbYzZpDZIc/aE8pv6lcEWlk3i0mjgveYN4ELpFkgKb7SLQQ2lxxBeFm1siPVfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RMWrRuXJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HMbjaj021207;
	Tue, 18 Jun 2024 09:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DdUL7YfNac0hKIZCsfP5KZGGmbBoWh6cqxZWRNZu0uw=; b=RMWrRuXJikbav+B9
	PX8CHC7Nqy6tbXukKWLji4IlTfFjBMRDew2pRwrVlCsdomzZySTGSf6UfCCwmKRw
	KcVpVdCW79uJKG5psdHyyJKKv1U6bZT8WmhdR/iYoIfkBY0hpAdYnBPr8vKqUGzZ
	KvMMZ8Snp2Um4VXj661E+UAftZBVRiH7aW7od21UkLF9ealSOtzKTQebtF4Tzd48
	plZorjPBDseRNh6D51h3Z39U90uSnjDgIvMOs+cQyMRoJuMjqwtBtnTKPs5u13xb
	6UEgci8nb/7jqtQi2bi+sn87grGLOXQ0NpB4y+RZXrLQKexzmQiDNLAQp9pq4pK6
	crVXAA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytx3ws5e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:33:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I9Xv86011840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:33:57 GMT
Received: from [10.217.216.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 02:33:47 -0700
Message-ID: <196c480a-bde8-4bd4-b065-7a2f40fa638f@quicinc.com>
Date: Tue, 18 Jun 2024 15:03:39 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 2/5] PM: domains: Add the domain HW-managed mode
 to the summary
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
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit
 Pandey" <quic_ajipan@quicinc.com>, Dhruva Gole <d-gole@ti.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-3-quic_jkona@quicinc.com>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <20240413152013.22307-3-quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A7SUt374yK3RvJiUu5onXXTU7UR0rOTM
X-Proofpoint-ORIG-GUID: A7SUt374yK3RvJiUu5onXXTU7UR0rOTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180070



On 4/13/2024 8:50 PM, Jagadeesh Kona wrote:
> Now that genpd supports dynamically switching the control for an
> attached device between hardware- and software-mode, let's add this
> information to the genpd summary under managed by column in debugfs.
> 
> Suggested-by: Taniya Das<quic_tdas@quicinc.com>
> Signed-off-by: Abel Vesa<abel.vesa@linaro.org>
> Signed-off-by: Jagadeesh Kona<quic_jkona@quicinc.com>
> Reviewed-by: Ulf Hansson<ulf.hansson@linaro.org>
> Reviewed-by: Dmitry Baryshkov<dmitry.baryshkov@linaro.org>
> Reviewed-by: Bjorn Andersson<andersson@kernel.org>
> Reviewed-by: Dhruva Gole<d-gole@ti.com>
> ---
>   drivers/pmdomain/core.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Taniya Das <quic_tdas@quicinc.com>

-- 
Thanks & Regards,
Taniya Das.

