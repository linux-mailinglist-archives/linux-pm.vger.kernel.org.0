Return-Path: <linux-pm+bounces-31890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD8B1A15B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7F416299F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2ED25A2B2;
	Mon,  4 Aug 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+dEfGu+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0025A2C6
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310291; cv=none; b=KE5+7YEDWCt25ODBH6yUcEZQz4AAVSQwOrSPjk7sMNcgyMo4LlJ8eTrN82BWPgGl6/39XUiyuwxHJ7pI8NvmzMYVH5k49e3dBY/fkEJpxh3jEmdB2dtoYfyfn5YS9cLNmZ537ZzY7nIztSu8HukOpz9bbdMcL2mAioDqbX1xjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310291; c=relaxed/simple;
	bh=X6OB+y3v7wjXgZyMvUtX1QmaETTwv0OrP/MFdJ4tRaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRTkDmkJ69tSfw7wETbxYYijrGDXXTZKmVPsUckzTzv8eNnzN6OMjr749mapB7n8U3UKbCRaa31vnvn7rmDzLkyTSsz2xdr8txgwJXzE7kxAL79xIdtcunHmxVbWm4aIa+TxhlcZziqPXTYzymW1tl9O3uGAvZvJyiZ3Wjwgi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S+dEfGu+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748WBAb030905
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 12:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V7q+KzrML4Aj2hTJom5AvJd1j16yraW+cQX6AncDhrc=; b=S+dEfGu+Xvo2PSL8
	sx++OpYqhWZhQYK2w+Jt7kWzii0uNuWEIaGCZLJvn2m0YJ9LhsIPyrr95b7NPlY8
	fcsr7jL6N9Un/DKhPN8pCT/WP/Rv6YMnwHMLzkSL8X1DovWhHMAsM6tPPWeFOftU
	e3AN+MIHk1VpfVDU0BHeSeml0fjNgt/jn5uX3cADrXjrAzqMG37r/P2xxdgQOpOg
	tHVLDuLtJPVTtkGJqNd2kpadPzTpXKN8/eayVmh6i5ArjhfiQCAUy54Y19WbNZjU
	aRNhGD184na1y6nTdwyxFp4Bab1tdENR7VGvTvAwpo8wWy29ZTWFiU5MumNPcc6x
	0ZbG7g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48a2ke31qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 12:24:43 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073674bc2aso12317786d6.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 05:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310282; x=1754915082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7q+KzrML4Aj2hTJom5AvJd1j16yraW+cQX6AncDhrc=;
        b=b2qKudz9fXPSQ6b04JJ+EsGGzv/zXMOVgSbRzAt5lrj6Th6qx2X5J/D8QTg9T8LDOQ
         rLivunV/8TtwTYh39SfWWO0n6U7zFQlCtub8CETx5NF1vaHkaYTKL80xMT6B57NzTvDY
         T+tU2N7QMOdb81wCv7L/rvzGdCzuS/A2hzaUR8ZJOJfMAqgg8Yhyklqw5av1/Y49poL7
         1tj1t4Mv8btN3YraF2wnVbKLO03k60O7IfajjT+hvWNjH0bJx+jxnSJLZ/lN25fgOj2B
         o9XzsgguIC8BRVAtO3Ti6uIJQdOUjGb6fZPnf74UxzTvmoUd/txfonCcMiriR+PmhxR2
         NTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQauMmuJeSqWrNWvuWktBCUSGbFCKFxSf9lf8oyIihEFfghVlNcZAcSC846xEtyvKPS2Pf4tDMtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3yfKsbLQhAUqfP6bNKsQ+1jS828sAThLil3fboUD7ghQd9Qgq
	A/ctVaTGbaAEGiBPRotjBrxTVkxDNRQjbutcvXrYemTPlpUKFxb17K68R1qRktoDpgoebxyi2wW
	nxZat/AwYpZqONzH8ofPDLhpeT8AVW2L/96BOY7+xvfb8C8FJAKec0hyNrmbaTA==
X-Gm-Gg: ASbGncsedtu/sGzqNiY1lPmLcUBUqNxFqLL1teMpIvTh9feHElaY0bGzp3msS5BzN0x
	kcFs7FGpqf9pPEzE0+/iz/DmZCa8Pvrz5v+D1hdlEgbYTlbFT3IV7+5AM9OqiekzG6luBcES0v3
	7pNMRj6Pz9HjxoF54Jac0kMIFPbEjPyIZSbxMPtK3SyiZ/5Bkc4jVYGq45Ra7MFG+92jejx7mHD
	EOQu7PIBRDXEApM2NsT3RrNrp6UEWgKPSHsb1gfCBxe01YHzISvkyiZ/Aqfk4Erdq9woqlmskCQ
	ctTjOCrABZgO5SmGazbiTizGHeabDxfSLU7177cUfDOSTnn6PLMIs4qNnHG64kP7ziaKNIHOsHJ
	62KQi7VYFsR3i7cH9oA==
X-Received: by 2002:a05:620a:3705:b0:7e6:81d9:359a with SMTP id af79cd13be357-7e696361fc9mr598166785a.9.1754310281994;
        Mon, 04 Aug 2025 05:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmi/HcIwoXXkI8woIdhi4ceFmLxFr8bFlUqDHXyyyLGKaBXdFINx4NRwp0ys6ezcnFAInnrw==
X-Received: by 2002:a05:620a:3705:b0:7e6:81d9:359a with SMTP id af79cd13be357-7e696361fc9mr598164285a.9.1754310281537;
        Mon, 04 Aug 2025 05:24:41 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0763d8sm736128266b.2.2025.08.04.05.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:24:41 -0700 (PDT)
Message-ID: <93fc49a1-ce8f-447a-9208-251e74d4bf88@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 14:24:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
 controller
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
 <20250804112041.845135-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250804112041.845135-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ip5RBxDlzl20KEjk70xQ5V0-ZghX-fAg
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=6890a68b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=276k8YKwey--yEOqDJUA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2NyBTYWx0ZWRfX7EJK/Ls0VsNU
 8AfGU8/IFWrvHS4R9Cah12xwrZfqzAkOdLtx6971UAQb0Bgw/eg421hEglWYX2isnfQxaPUdObm
 9982xAbH5Y65BcIgJCs/NBVP3Jc2rQiIb0bUQVeMAXznO4mU7wOo1VW11qshrBXgKQh03qE4GVS
 ftIEQ/+IOY66loCzdqkx1FSpKh0FM0xVJzdCoHDYbXjhZ+STcutM18EiILwYa0iA0V423L/0OpY
 h5rimHeC2CHuCFMxxvBt3BInJyE+zESHaBWTLEdz39E8LfPL4S7dHy+d8IYur22eni2Fmr2YxVU
 CuvbHkocifTjjjx5aGgARIq3aRn9YEo+4IUDrun8R5Pu2hVQL04na6dLt7RG0yzzJqwmjw4jE2L
 NKlcXvBi7PsnK4owAE75eIEQATHUISOC5HLZcXZhI/H5LEplR55TTH2BfmIhAAeAnI8UlKXj
X-Proofpoint-GUID: Ip5RBxDlzl20KEjk70xQ5V0-ZghX-fAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040067

On 8/4/25 1:20 PM, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
> Add support for the APSS PLL, RCG and clock enable for ipq5424.
> The PLL, RCG register space are clubbed. Hence adding new APSS driver
> for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
> and needs to be scaled along with the CPU and is modeled as an ICC clock.
> 
> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Removed clock notifier, moved L3 pll to icc-clk, used existing
> alpha pll structure ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

[...]

> +static struct clk_alpha_pll ipq5424_apss_pll = {
> +	.offset = 0x0,
> +	.config = &apss_pll_config,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_2290],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.enable_reg = 0x0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "apss_pll",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_XO,
> +			},
> +			.parent_names = (const char *[]){ "xo-board-clk"},

Parent_data and parent_names are mutually exclusive

[...]

> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_parent_data parents_apss_silver_clk_src[] = {
> +	{ .index = DT_XO },
> +	{ .index = DT_CLK_REF },
> +	{ .hw = &ipq5424_apss_pll.clkr.hw },
> +};

You use indices here /\

[...]

But not here \/


> +static struct clk_alpha_pll ipq5424_l3_pll = {
> +	.offset = 0x10000,
> +	.config = &l3_pll_config,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_2290],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.enable_reg = 0x0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "l3_pll",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.fw_name = "xo-board-clk",
> +			},
> +			.parent_names = (const char *[]){ "xo-board-clk"},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_parent_data parents_l3_clk_src[] = {
> +	{ .fw_name = "xo-board-clk" },
> +	{ .fw_name = "clk_ref" },
> +	{ .hw = &ipq5424_l3_pll.clkr.hw },
> +};

[...]

> +		.hw.init = &(struct clk_init_data){
> +			.name = "l3_clk",
> +			.parent_hws = (const struct clk_hw *[]){

"clk_hw *[]) {"

Konrad

