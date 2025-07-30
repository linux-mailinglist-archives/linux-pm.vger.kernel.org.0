Return-Path: <linux-pm+bounces-31594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9EAB15C43
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 11:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E545C3ADDFC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2B275865;
	Wed, 30 Jul 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GAbYsTCt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35D19D065
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868367; cv=none; b=JoEBPi7bR2jlkT9FsL7aA5qT/FQBxZcDw0cmmCQO27yyJay1NCLfDZfSfybRAspe5U8RMl7vjUMOTJxcHvNRc7RFwGe3yWXOjya42vcvFgfkSD3J7OuaXXYE+bYQXSqWTZCn5ffuRN2xh2v95ihYEg0GFmHtijImKMx8d8LQy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868367; c=relaxed/simple;
	bh=FFwMpkhOYSBmnp5I4Qk19pzDCl+8/KeHG7bi2vq6ggY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TOjFVPJY9peMN41gkdV0YonPBZ+eEbAVM6Al7EqH8LRKQCjPnQxjLTl07YeZD2wzoc7K/l+TgfHsHSynJL+/o8ouUp7H0d27xb+D3O3Yz1ZQdq1Zv6N0kKlHx42gKWecEOF5r7JPM75J0NCe1hycxbw0P/fD6B3YeK3JCzSn9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GAbYsTCt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5JEUt027603
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 09:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M4xxlIsUwBSemAmhdAK1Q9uezrhoKQ5cmwiav1SEhOQ=; b=GAbYsTCtbk/iLWdk
	p9LGJXfinV82t7J8kW6q+nZwKb3xfKmiiefeLdA6mXmsCzmN0qjzindinnEl5JzB
	lNzKpZR19fPOsG5/kTBsr9kT5b0PMDXh6Uorula6Z8SoFRzQl5c3Oj11Z+FT/BbV
	goToaiTtMBpjyGcy7VVO2xyPDiI4SwE8iwflU8VatxUbkHJpexyjRND5YZ7IZGBd
	xs4bLAyq67DEtTS/3sIZ2UO7CcJgfulQd4/Gvwl6JHejrkFo2P0qswVDKT41NHXl
	tebtiTkBC81TlG9sWscvwz/SlrBJmiVvQEKARC9Epx80JTI0t9qqo8gHieyOoVo5
	RPjtXw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep0jhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 09:39:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4abd7342386so16644541cf.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 02:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753868363; x=1754473163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4xxlIsUwBSemAmhdAK1Q9uezrhoKQ5cmwiav1SEhOQ=;
        b=N6fgYtPy/XryNTHJS4F9LBJukWvFS8FipTeQs7co04/ZeY6PV23jUkJjoFLzeHHPva
         TZt04Pkk+87PopZ9291xKnqyXVxoo8ZQD8LmT8jrd301A9NBf2SmL1S8ErMRB/CYzOlE
         +R1tHPNLPGwsSPXh92D3BCawIelt6fuzdKEEuEOVd23yiIsIuRcw0jGbZp61bpu2JSYr
         sTvuH6ipjDcQZhsmuJqKdGf9vFwcg6ILHa5J+UdMZMAtxlnEGoBh5HWIQlnCJSM18X+i
         j5Zy+f3dSnHnzw+dKnYfVzSJVmAEa8rFHVa2kofV79caKK94XhGw0yYuiytPSaSTKjNZ
         BwJA==
X-Forwarded-Encrypted: i=1; AJvYcCXdIcHGRy4kIRtcktDy3+xPKa/CqVif5Ze6Z8iEk2d7C0qCmFv8Aq7xo9w66RRfIMufAD7BLJ8ipg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1qoviBMrawuUHX2MHz3Mg/CgSwZ/T1voAhDcLAEgWnvGD4+S
	AN0MTBj0aqM3N/XB/ZQUWVo5f7mxE3iinvLcKgZL2/WHunG9vPoerST315FFiFHPatZ9eHpfuTN
	wjfDggWdvFWkrxjjXXrM31+wyuOcNJANPeNYgGPWrTb4xx99badEj3E1gJ8TCGzHFTkwNZw==
X-Gm-Gg: ASbGncu0tQfqElomgpogHAJjCNyeQ2Viz4DC7BjXRhYFm+c2tCWGap54gJVUfERomMR
	GUUCq+UXdhnsFcJu0qnNiXVHHFxujtSgDUyNMOihvDvbh+CFJuknmio6VtZZxK2QIhEK1xxbh4u
	ImId1+qQZJkCtmByrL3yPcpPKnEyVGMjPbnmaPrbt8XBm9IiELskJd+vU0ojQ5b3nqz7JB6o6Hb
	V6Kb8hHGOIPxIgPbYX3q513AmKCRYodGfPI/apPKdtRVYJYujZJKIBDXf58D5J7t13C1+Vik6eG
	ULhCThCCySjVaHYeFmbI3hegaxNlHi/5OZfV3D0x/OPeOuHRNhZitMvwP57362EQ7vGLRuJzV6P
	a1uOalSeM8xwpPQbIUQ==
X-Received: by 2002:a05:622a:4d91:b0:4ae:dc63:462a with SMTP id d75a77b69052e-4aedc6347b7mr22328801cf.0.1753868362909;
        Wed, 30 Jul 2025 02:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNmC57TxqA5fJorGH135uruMdHSiL4OQkD3t41/Mi83JfFgYns87im7Ap3ZJoIyYR/7aVvuw==
X-Received: by 2002:a05:622a:4d91:b0:4ae:dc63:462a with SMTP id d75a77b69052e-4aedc6347b7mr22328541cf.0.1753868362361;
        Wed, 30 Jul 2025 02:39:22 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358acb2asm717167866b.56.2025.07.30.02.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 02:39:21 -0700 (PDT)
Message-ID: <3c69deb7-3a23-4627-a64f-3179785bf6f5@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 11:39:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
 controller
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, quic_srichara@quicinc.com, quic_mdalam@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250730081316.547796-1-quic_varada@quicinc.com>
 <20250730081316.547796-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730081316.547796-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: klhuKswSAub6U2isqKtEGvLXTLevpuPK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA2NyBTYWx0ZWRfX3+mLZs/xvS0J
 e0dSSOxzrp0MqmgAmtEBPANJvF/9W4LX/OlpZ1RYRcAXzBv0mOQQlgIUsU04MmpngIje3TyWTqN
 /6MMER+EuZ583jn/+c9Ug2/6yjRDE21M7eBadH5c27vCzTbL45gMcRKpT0seM14w/Lhyf7g7q9m
 gtEmJ5vhNTRrWBnNzQ1TWb06c78ggS3okcFSyxQBev5+8NTXj+lCfyRrrvcvJaw+Vkn6zqBLrrP
 pvi5XfEbbV7gWlEGi7SnDzAt8mTeb4NzWqGAKSTEdvUfLQTIEaJo1KEirYDZVMXfi88RlNUdxkS
 PM7fzDLo/9T0Ms+2/L89jwO+amOswoAB9pAjT5wkoaUys/f6+Po2gE+WdlZxOC5nS4lVZFigoxS
 ngdrVebmOICj+ctoKRzVvzJh2WI/K/Z8QSCrJhxGhVEh+DAqtSISIhqgeZhYrv8Q18e6ykpr
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=6889e84c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=i-JfjlNmehoY5ENsB_0A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: klhuKswSAub6U2isqKtEGvLXTLevpuPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300067

On 7/30/25 10:13 AM, Varadarajan Narayanan wrote:
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
> +				.fw_name = "xo-board-clk",

This is not consistent with your dt-bindings.

You should instead define an enum that reflects them and use .index
(see e.g. gcc-sm8750.c)

> +			},
> +			.parent_names = (const char *[]){ "xo-board-clk"},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_parent_data parents_apss_silver_clk_src[] = {
> +	{ .fw_name = "xo-board-clk" },
> +	{ .fw_name = "clk_ref" },

Similarly here, neither one exists

Konrad

