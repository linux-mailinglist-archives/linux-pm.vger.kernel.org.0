Return-Path: <linux-pm+bounces-21321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F97A26C21
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 07:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0041888436
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7017202C34;
	Tue,  4 Feb 2025 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ix3T/+eO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95E25A655;
	Tue,  4 Feb 2025 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738650538; cv=none; b=JGiHqKXoNsiEvqs9jIvqikJFT+9mw8aVzOUcVhG7yEGmRl9kbrFuRtJsHA1rtDHoR5zvublOJhZBkwVtJuUhYYPluRgxFKqvO+iDpBGWHaHfbR9R23XkI41uHZHYhPRTz6nnS0nTykZbtu9rJuSA9NUN6vazBF9xuZtI+D7ixzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738650538; c=relaxed/simple;
	bh=Dqn57KPeZHxLv4sYXabrO0zuW/2UdonbxL7YbLPQmiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QpWj374Afh7h1n/13l5w+UuJnO3mqEd/4ooLp95qCTHZRs8e2BxHPnSJDoLq+ICZirQYza4NQQ2C2wkEDDDxl/GBjPRBLwMLDP9W+ELAuk6p1XmGIOvqD2/rWnPcvhPo4z1YmCYe1/WDpXGhkU1RVU6/XPrq8AmWwz4bdcfxvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ix3T/+eO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141aNFs003771;
	Tue, 4 Feb 2025 06:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Poa3aqsD9Vd5Zi+ir9FLHytRK+1RHlmIkI4PXgUyVKU=; b=Ix3T/+eOjTelPdow
	TdWSeK0NjkOlOiOdNL+w6KhaqdMo/jaXeikWlyW8kFdhJH6T4v11kuUvSNoJ6T2C
	h0UBeWa4I7cFBydObyMdQD1sfX8UfoDdoWSAa+rYCDFM8dNC/ED3DGKjyinSeHEF
	0zv/tcqYN4Vus91YO//ZSN928f+icssiZeLOASAQXpc1Bc3orOzOeANhqKMfFXRw
	WcOTuk0SyDDQusgdxRdgZEWMp/WCILQjnyoVTczKO+pJVLzgwbif4p4p0sh/4P0Q
	Iahr78rId4mOykh3CzNwkNrVzHjFFujONL3oTskpfLUOEpkS4I6C4OlCH21+8olq
	PRxmHQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k9cn0gh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 06:28:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5146SpeB023620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 06:28:51 GMT
Received: from [10.216.35.77] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 22:28:45 -0800
Message-ID: <7031f2da-36bb-4655-a4df-fa85c99e6eb4@quicinc.com>
Date: Tue, 4 Feb 2025 11:58:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
 controller
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <konradybcio@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20250127093128.2611247-1-quic_srichara@quicinc.com>
 <20250127093128.2611247-3-quic_srichara@quicinc.com>
 <47f7553d-74a2-4da0-a64c-cc49a2170efb@oss.qualcomm.com>
 <123a324c-561a-4081-be43-8d8ed0662acc@quicinc.com>
 <6c8bb178-1758-4b73-bbaf-8572dc1216d3@oss.qualcomm.com>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <6c8bb178-1758-4b73-bbaf-8572dc1216d3@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G66RT-xuFG8CsmYLyVRQpd6xlsfrBNfF
X-Proofpoint-ORIG-GUID: G66RT-xuFG8CsmYLyVRQpd6xlsfrBNfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040050



On 2/1/2025 8:55 PM, Konrad Dybcio wrote:
> On 30.01.2025 11:03 AM, Sricharan Ramabadhran wrote:
>>
>>
>> On 1/28/2025 5:29 PM, Konrad Dybcio wrote:
>>> On 27.01.2025 10:31 AM, Sricharan R wrote:
>>>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>
>>>> CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
>>>> Add support for the APSS PLL, RCG and clock enable for ipq5424.
>>>> The PLL, RCG register space are clubbed. Hence adding new APSS driver
>>>> for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
>>>> and needs to be scaled along with the CPU.
>>>>
>>>> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> ---
> 
> [...]
> 
>>>> +    clk_alpha_pll_configure(&ipq5424_l3_pll, regmap, &l3_pll_config);
>>>> +
>>>> +    clk_alpha_pll_configure(&ipq5424_apss_pll, regmap, &apss_pll_config);
>>>> +
>>>> +    ret = qcom_cc_really_probe(dev, &apss_ipq5424_desc, regmap);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    dev_dbg(&pdev->dev, "Registered APSS & L3 clock provider\n");
>>>> +
>>>> +    apss_ipq5424_cfg->dev = dev;
>>>> +    apss_ipq5424_cfg->hw = &apss_silver_clk_src.clkr.hw;
>>>> +    apss_ipq5424_cfg->cpu_clk_notifier.notifier_call = cpu_clk_notifier_fn;
>>>> +
>>>> +    apss_ipq5424_cfg->l3_clk = clk_hw_get_clk(&l3_core_clk.clkr.hw, "l3_clk");
>>>> +    if (IS_ERR(apss_ipq5424_cfg->l3_clk)) {
>>>> +        dev_err(&pdev->dev, "Failed to get L3 clk, %ld\n",
>>>> +            PTR_ERR(apss_ipq5424_cfg->l3_clk));
>>>> +        return PTR_ERR(apss_ipq5424_cfg->l3_clk);
>>>> +    }
>>>
>>> Now that you'll use OPP, you can drop all this getting.. maybe even the
>>> apss_ipq5424_cfg struct could be let go
>>
>> ok, is the suggestion here to use devm_pm_opp_set_config ?
> 
> Since what you tried to do here is binding CPU and L3 frequencies together,
> yeah, we can just scale two clocks from OPP.
> 
> On some newer platforms using the epss-l3 driver, or on msm8996 with a more
> complex setup, we expose the L3 voter as an interconnect, but here it would
> seem that we directly control the clock that feeds it.

ok, will update and check.

Regards,
Sricharan

