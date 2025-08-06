Return-Path: <linux-pm+bounces-32008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF0B1C5F1
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008203B8379
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FFD28BA8B;
	Wed,  6 Aug 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJKFHRdl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730FF28A1CC
	for <linux-pm@vger.kernel.org>; Wed,  6 Aug 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483737; cv=none; b=fmsG2PP38e+OgElGYZzjIchJyMHliqEEq3Sv+Ir+4CyXigH7XfJ5zPSIrKDzhwq+ijudfDLt5KqMt+5PT2gl1QJJdIKrqI3y/9IJpaXzkGFUnydWFojZrFCUbq5l/zpkmp/9JfQLz7tQ5falVn8+fVr8V2vLOs3G19GJSL7zGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483737; c=relaxed/simple;
	bh=BkMg9lrcOwRqh+c2w51M/RlUfMuRGUn2YqW6UrJlJxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFkI2LuaTAmEh6v9UpEkPgwrJew4Y23BwJzaBdOAvQTtYKUTjXx6SbpyUgLCrZfEFkC/ukISdwb4GQutUV0g421E2sYKHIWsf/FVuGt9hN24Bb2jV8yV7tZKbim87SJ5mimxckw9ucm1ZjYL1E9Jwa+0EDZWmOpQALfkkLC3WUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UJKFHRdl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765jnEA003968
	for <linux-pm@vger.kernel.org>; Wed, 6 Aug 2025 12:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cCr//mNBZZadIfbdCckvaMFLb/aTsDPU1FdFZ5M3iO8=; b=UJKFHRdlA6z6/fCV
	EHp7YyvP7We5t5JBS4qZd46IRiJJ8v8m/ob0ghLq8IHYkOO8hDwvLS9ylCn+0ff7
	dpE3CDfwtzR9GdsXl7Ow+I70J6D07diAvACDS0Poz0BoLxpRgBv9D8NiI69XqV9d
	NKHPg8CE7qQz3IIZXdH72vzemq2/VIBUZw80TUimTSVMCsIYIC8/jujT7GPXHB+k
	/Ih3fjEhB/zXaTTP+tJ4prInViN1VDHdI/QZxPsf2KcjAkih8IeAMHcgwVJ7e+ec
	qhL7BfE80OZ8vAM+xtPIbtsxF9tzN/6ej0CKYpyKEHYTq3QruSnD0CY3oQuE4FNb
	x6l2Gw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyaamnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 06 Aug 2025 12:35:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af23fa7c0cso13554271cf.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Aug 2025 05:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754483733; x=1755088533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCr//mNBZZadIfbdCckvaMFLb/aTsDPU1FdFZ5M3iO8=;
        b=qxvfpHU+LUFSoCdi05Hd8yLWes8aEi2vevD+D3HQJxk1+UQD4ybJQhx3chvC/C0zbN
         m9Zo/pmCkdtLj7qq42VXbUfHt4M3xAhBmVGR8B9E3Ya7M47B1OyYBTv6N3lRlU/zg5Lm
         tgOwBXsWmp5IyqJMxi2VL8OjRwfvZ5d0zVYCj6YhXlJhgoR3zIQqM+DyUUnzw8C5iUxu
         ZYWYtRimFR0bXxnck8weYslO7G6rkoJUdfVOW3H8o38N7bMoKjnPXQ91taXgvWYoOlvt
         yVDPufaRpuW9x7CJxbVWl6eh4pr46xhgI5L1rb0i4tBOY89ZmQ9MBO1CQ/mBfh5bEjFo
         Ofmg==
X-Forwarded-Encrypted: i=1; AJvYcCV6hua3IExpB3865XTNlSscccJ98S9hN3cYKrZcFsD+m2QZjbPxJ3bio6GCJK629JwuomiRbQAEfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuCinsw+ipOlTrn6YAmSYAjET09k1AF+KCU4Xj3/LZLOJuspJ
	UJVOccfMui8Nazc8Wjh648Gthkz7jwGluF8c2l24sCymy5Qes2/kbClIs+oUUqwY7a61CwWAd3x
	IfiTYymrFNJ0gn9CjjByn2brzVcdVGo90pv0KrpN2NMN9P+PCaSjxgLc9Pj3Lvg==
X-Gm-Gg: ASbGncvHHitdXnBIipv7t7Q18PwfbR3K5X3jKWdp4CAgx13er6aq5LxNFvZV2jqDWOj
	1gB8wAKwkDp8N3eumrKNZnJtxbG+OffabpC3hE7YiC/+6YWgAXj/frt49Z43LXBrl566J0IRR3V
	CbedT7B/EopHiJRtGshAnSepr6jXvq1OBpKFTOHnWpA1ln6dOgT+QB2F86LznZKO1z3Bo5b6qcc
	nwbSeUOZtwKbBSmHpyAqEWAL4TG30gm1ucUf0lp9GqqtEeXbAmyiDSxBkd52SUb2xyK8pCtU3H4
	QWzQzfBIyCgBUAcpvn2SSmrYlYj4PbPOTcg0W3b9goEq9xY9umHwjbuVuofT7IMzvuDWM6fLjRS
	y9TkMSk8lmbmLUBXarQ==
X-Received: by 2002:ac8:7f89:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b09133fa54mr17986261cf.2.1754483733251;
        Wed, 06 Aug 2025 05:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7d2CqcjDNnmjfaCorK7ggZ1AD3iYaZI4VcHppGy/TET6icunnaQkfyCMwgLQKxMuq3VCiWw==
X-Received: by 2002:ac8:7f89:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b09133fa54mr17984941cf.2.1754483730668;
        Wed, 06 Aug 2025 05:35:30 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a396fsm1103435066b.42.2025.08.06.05.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 05:35:29 -0700 (PDT)
Message-ID: <48478a05-59b9-4f2e-9339-255e513a9cb2@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 14:35:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
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
References: <20250806112807.2726890-1-quic_varada@quicinc.com>
 <20250806112807.2726890-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250806112807.2726890-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zBo4Gl9zmZJWgbS1YkaiJx1eUuwHToOf
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=68934c16 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=nqClpMi1XL7t9EIYa0wA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX5pzU8+I3HHgt
 DYYy36WbxVvvplt1FWJ5bfTqjjhWQEE9Rh2lyJHOn47F1tbpH9fA/Z3MmKQg5uMNPa2mj+2cXw/
 EHNf2R0NAAC8cUQ1GFdMUxWrzRcpScP/YEvhdPzQqEKxz94TJlAST6is2D3sd4ekecKZ8UJDVhg
 AFCtdH9GtcaWkqN1Ij79SUkZyX3S8hnuOVwlRy7WhR1nlEHOWuDiv0z1hbZ6cU/buMoSK/7eF6h
 kMnuVAzX/CFtL2KjWxhvaHZ2+ezeZeGCQaKXHmI14wH6bGoT/64FGF35Yqsr5NnROW0nmhr9r8t
 MUvOmZ33lYxRKHazB0IJmXUCNP7mfF76iIs3ihkv9yGv/HBAcJ/+lyFfLjPECWsjiYLkaAmPjdi
 j0tckj/w
X-Proofpoint-GUID: zBo4Gl9zmZJWgbS1YkaiJx1eUuwHToOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/25 1:28 PM, Varadarajan Narayanan wrote:
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

> +static struct clk_branch apss_silver_core_clk = {
> +	.halt_reg = 0x008c,
> +	.clkr = {
> +		.enable_reg = 0x008c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "apss_silver_core_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&apss_silver_clk_src.clkr.hw },

Odd closing bracket placement

[...]

> +static const struct clk_parent_data parents_l3_clk_src[] = {
> +	{ .fw_name = "xo-board-clk" },
> +	{ .fw_name = "clk_ref" },
> +	{ .hw = &ipq5424_l3_pll.clkr.hw },
> +};

One more remnant /\

Konrad

