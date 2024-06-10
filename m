Return-Path: <linux-pm+bounces-8851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BAC901E83
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 11:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451DBB24082
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B27406B;
	Mon, 10 Jun 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FJZhkK0X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D944D8A0;
	Mon, 10 Jun 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012588; cv=none; b=sVR5kCzS33Ux7qCnLRpJ9ifgrR8wjZjM12TYtGAmGAjTzuqFjlab4d+4ZVycBOQuOc3+Qo4Cbgdu1D6nIQhu/CWyxXje5wCa//4yhjellijDiOnSWpb5SQYExcHdHJDKFP+Zc+j8uAXVpNLdT0EeeZVuI55lbBBN4Uz80K1lh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012588; c=relaxed/simple;
	bh=TaKJyVNi/cu++Eizp/eGPbp5HPTzs872TaxHy23NOT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Isw830667gve8+nEoKGWg0k/DSRg25pZMvl5XCZl5+jZF5ccO/m2+UY6FXZRLLkvNdnrS4MxStpcOGlIOOsThowGPl/bF7hWSOv4zpwmeYzzHMoVFLg7yb54oMNj1/TXk2ltYTGqoxcakYdE9wzkyfkMUtg7Y8IpQQ0FCWQxeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FJZhkK0X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459J4M5T003466;
	Mon, 10 Jun 2024 09:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D42MpLWGTDVFUGWjf5RwrXOIAc39Y4aLu37Amoo2mKo=; b=FJZhkK0XtBeyQeVR
	6HmRBrMBIINyLuYl9bGMRH0U4K3YnH1kkOnwZqpsfUgDSzTfI8AtvdBy2chCGSxv
	gf65DK9uQkDyXoTowMz85q5SeK+FHRFAupCVlJD4rKlURF3spnjpVNXZB6esAC3v
	g+wbcGJfMcJuTC98MP3ICuH6zVZgercKDosZei1Qp0nConDVapYu9zAmvAI+7NHt
	9STu8NDmZvEIhQmP8vNeIszEjLWJCs6oXXikYce0RE77MjXiedtKulG5CJSImr6h
	lEVhNw81I0va2vIUD7pozkcx4GuzZsaEyJCduwmiAQIkPwCbBe52lOmfqTlCjnKX
	muKfow==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfh33jgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:43:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45A9h2eH013124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:43:03 GMT
Received: from [10.218.0.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 02:42:53 -0700
Message-ID: <76f0e79c-b100-4b61-b861-17b324e1e4f7@quicinc.com>
Date: Mon, 10 Jun 2024 15:12:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Skip retention level for Power
 Domains
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_jkona@quicinc.com>, <quic_imrashai@quicinc.com>
References: <20240531114148.8550-1-quic_tdas@quicinc.com>
 <99967eee-da39-4a35-b80f-a78fe3c10733@linaro.org>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <99967eee-da39-4a35-b80f-a78fe3c10733@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nlMjLVGv9UbxE-q9seCE9ZwGoaw27Bys
X-Proofpoint-GUID: nlMjLVGv9UbxE-q9seCE9ZwGoaw27Bys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100074



On 6/4/2024 5:46 PM, Konrad Dybcio wrote:
> 
> 
> On 5/31/24 13:41, Taniya Das wrote:
>> In the cases where the power domain connected to logics is allowed to
>> transition from a level(L)-->power collapse(0)-->retention(1) or
>> vice versa retention(1)-->power collapse(0)-->level(L)  will cause the
>> logic to lose the configurations. The ARC does not support retention
>> to collapse transition on MxC rails.
> 
> This is not very legible. Are you saying that:
> 
> a) transitioning to/from LEVEL_RETENTION causes the resource to be powered
> off internally for some short time and lose state
> 

If there is a logic connected to MxC and the vote on that logic(MXC) 
from a subsystem is initially to LEVEL_RETENTION and then to power 
collapse [0], then the PLL connected to MxC will loose the contents. 
This the transition I am referring here.

> or
> 
> b) the linux implementation of rpmhpd handling causes that transition to
> include a power collapse step that makes it lose the state

No, this is not the case of SW implementation, it is more from the HW 
ARC implementation.
> 
> ?
> 
>>
>> The targets from SM8450 onwards the PLL logics of clock controllers are
>> connected to MxC rails and the recommended configurations are carried
>> out during the clock controller probes. The MxC transition as mentioned
>> above should be skipped to ensure the PLL settings are intact across
>> clock controller power on & off.
> 
> So is this a workaround for clock controller drivers specifically, or 
> should
> MXC never enter retention, and only poweroff? (the latter sounds like it 
> makes
> more sense given MXC's purpose)
> 

This is avoid MxC to not enter retention to OFF state.

>>
>> On older generation of targets which supports only Mx the logic is never
>> collapsed and it is parked always at RETENTION, thus this issue is never
>> observed on those targets.
> 
> "On older targets that do not split MX into MXA and MXC..."

Yes, but that is only Mx :).
> 
> Konrad

-- 
Thanks & Regards,
Taniya Das.

