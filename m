Return-Path: <linux-pm+bounces-42136-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOgZKn9zhGnt2wMAu9opvQ
	(envelope-from <linux-pm+bounces-42136-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 11:39:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92774F168E
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 11:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 383B0300468A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188673A7F72;
	Thu,  5 Feb 2026 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XuWkBmsE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6fMOl/C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC63A7F51
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287988; cv=none; b=HB7dPkP0yKo1Nq5nb2hZ5K2CnI9LL0MSN08ewmKNrHunEO1C1+ziajY7XJ8cKjwRtOpyug/enRiwrq66SHCgBnCByLHyFoQsvQ+xnUepFmJIY0teye3g9DlhTf3BICFDGNyw6ydDZs1Y5gVCcvX2P31f7Tj2LTlO61WOJu1zQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287988; c=relaxed/simple;
	bh=rUowSfAed8YTJsnO9Fsdf0eOpSmsCNvNEVmEPmhva/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQAUuXwUmGpzMiXfccUb6LgRHd9fmGhJ9EEotPbrpfylpCs0EALY0qZ0iMG1HbPBw8WbAxLN/x+o00AmfXxKzj/6Xi4Um0hhwhRW2MpasSnmrj9WTEyoMEjKsKLWKh+mbyCx25PlIJCpRcPSkBCp7qn23K4yrHZ49ZkhfN/Oy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XuWkBmsE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C6fMOl/C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153drbl3397554
	for <linux-pm@vger.kernel.org>; Thu, 5 Feb 2026 10:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HI7oLWxgt+tPk2t4ik8yF6dACaxFlG5oAIq00+Clsc0=; b=XuWkBmsEiBo6bfu7
	uYFonowbo58uEsBPhms0BTm6u2PbZOqBmI/9+VBXOP4JSYoGNV0UWrwpbT9x4tFN
	+VoR4xDKbWZk5EoMWCURppTly+XcjCX5m0tFj5BW5emQHCN4e7NSZWqxyww5+IFM
	Sg5zQDst7OFgqAoyz8rnYnjHcYu+IsptLE04le5T7K9yj83T/nSQmm4urs/Y/gsv
	vdfuEqjIUuibREwGWDAZgFJO8jTGh2RMrMFDMuBlK16Q7oK+d3XUm9rfYQrpFp/P
	VNLHHBluUTHyUeaLSniRzSCaF/aCS1tumOmgX0VVc66yLKwawRXMYX+2ZbfnhufI
	Rzp67A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43dh46c4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 10:39:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a8fc061ce1so22408015ad.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 02:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770287986; x=1770892786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HI7oLWxgt+tPk2t4ik8yF6dACaxFlG5oAIq00+Clsc0=;
        b=C6fMOl/CL5BmWWUcC5nPyXazGrJ9oAN7kJ4OJptxWSuKLG0yUX6OPXHE2455Pv16xB
         i2zw7XyORwf5JwXRohwOGMUADIb2OfknGAcHK5iXVU2MvK+vFfe4x6zp2tXxTE+DMdEM
         3Av1AOLyfgb/yC4d6/cHGKERs8cCiKAPtAD3YG0EqUcf+EKWVLew1XVlatCeRdb3vS0I
         JOHgIr77ZdaUk11SkIRa/UD+Iog9c+cLZ73te3MLTQynTJHR1SRC+D3KtTo2cCngpNh1
         kbkCC6tN37N1S5xafciUYxu6GtI1BkNWRbPARXBmaoC7WSbqPGr0IOuaoft1zZ+T8dK4
         UmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770287986; x=1770892786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HI7oLWxgt+tPk2t4ik8yF6dACaxFlG5oAIq00+Clsc0=;
        b=WVZbn7W6NLfQnqIrkypzo5M6EPHvLQ4vRiGnFvRB6ZrIRjsqIdMht5u9AABEh1QRRL
         MOa4DpXEmKxZDgNVY5mfvxuarUd6medmOB6ZourO4fReCyQd4ssXfK+kGj7p5W7FZQLd
         wAoVUzsLW+qO0xr41KiL+fgOdvooCtXqiTO2cPXsD7tfbWNZgWEK62z7h85yh4Ged+nP
         XEqVF7gjH6IVrbiHa75O3XgXz/lkZJ1vUfdfhduUqAdRyC+NAGyqhEp9DABm4JbcwCWb
         24s0hcY7+1HV3xYNiOujNKpqynLOOmpTpNwCmxhTMwKdm2R1nn/6L2+5Bfxy34tFTzL5
         7IqA==
X-Forwarded-Encrypted: i=1; AJvYcCV8tiTDDEVnVhTlmAd8r4g+NTQX7ynOGAhcf2IA9LWt/oRanM3Tv6cKMcYKhF3FHPpozIdyYbTK8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMsIQ4pwj8/BRFZQAHL+uizR/skyc/wi3rRFcSM+ULhnUUcd5Q
	H1SEfoG9gD5dPZWLDlOXpURTH460WxEegbW97zmrI2NLAnAOK9AVflpAPHeVajerSje79w2SPbH
	qQJalnfCh3kBEvGbR6pQpnZtGlFD4SiLFfmutuux+Rr3I/TJ2kE5U1kMsN1bpSA==
X-Gm-Gg: AZuq6aJu1OX42bPkEOImAxO5du1Zi3xg/W+yYq7dCSdOQOwZxeqDsqkXcDSjtmuUyWU
	PRlgWlwZ001MQcVRGKYleY+UD1oZgCYyQLd//LOSoGGK/mVwiuwcbT+8MyqGQWmzHc5Bf2VEGXf
	inrHavyY5/tpyXYYoW4ebqRPD35zpRpWn8macuDeaYamx+vkOFNBoiRKr9msbjT56Pf2FXmgyH/
	UfUGqDzzX9JClLdYHMSnmhHM5a4b2dY4cpseyHyZUrOE85UzE8w1ud9GQU2Et86pgrhku2tAlSJ
	qE+6va1TMOevMPzofl0Mcw8C5Krwhfd3BqLJFaGX6eDk5IRikn8cCSqaPBRWRwqVnlM6+2pZ33M
	rdEQIY6L4HmkP6B7oHgChFMjHIVT+b2bwKK8cVh9WIQ3/
X-Received: by 2002:a17:903:3d05:b0:2a9:484c:ff1c with SMTP id d9443c01a7336-2a9484d048emr7536925ad.54.1770287985637;
        Thu, 05 Feb 2026 02:39:45 -0800 (PST)
X-Received: by 2002:a17:903:3d05:b0:2a9:484c:ff1c with SMTP id d9443c01a7336-2a9484d048emr7536605ad.54.1770287985153;
        Thu, 05 Feb 2026 02:39:45 -0800 (PST)
Received: from [10.206.109.90] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338a1309sm49609575ad.37.2026.02.05.02.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 02:39:44 -0800 (PST)
Message-ID: <2740739c-b0db-7248-f9ba-e1a7dd69a5a2@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 16:09:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/7] media: iris: scale MMCX power domain on SM8250
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
 <20260204-iris-venus-fix-sm8250-v3-3-70fa68e57f96@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20260204-iris-venus-fix-sm8250-v3-3-70fa68e57f96@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bMgb4f+Z c=1 sm=1 tr=0 ts=69847372 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=R0B0fMNruX7Akzlv-IwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: oR_THDno7xxoUC9g7oY7nFdHITBIYbyi
X-Proofpoint-GUID: oR_THDno7xxoUC9g7oY7nFdHITBIYbyi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA3NyBTYWx0ZWRfX/nq0ExPdZdb+
 QKXzcxGhUbhoaH8T8rO+hyXblb3EyhPFDV0ISx8frmbMz5Pr2KUMWxwb8kEhwhbuSTdRBExoF4K
 +TOmIX4UZCjdKnrRIhqn0KS+kKDxvCCQyXSmdroADeHBAFBinGKXVFHoWMewcoEGviUzaF64Klh
 SdZQBGo/eYxSpFKYwpghpuG/IvvrJLvei24GtPizP4YjYOHuFwtEQ73FNKrSs+iPBtWhdeR/Fdi
 4eBmrvRJJYBn/MK8MYVsljQyou9bCjsx0oRru9sn74bLtmRZvoZqGXu2urJgoqE/jl5A1Sywi83
 3DoLsR/2GdkOLXxxA8wNGhxgtHTttQ4BH27ei5t6mN1gPEyM29HpWTcQGRYhJoqg3QdttoOX9th
 +Ysv4XQI6Slp3nASCyODD7E7J7rMxM1qT4ssvtNDePk/ldw7rls8QGvYiHwOmrJ+9oQAZq7lkEz
 Kjiizi+DSghom9V2+xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42136-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dikshita.agarwal@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 92774F168E
X-Rspamd-Action: no action



On 2/4/2026 6:29 AM, Dmitry Baryshkov wrote:
> On SM8250 most of the video clocks are powered by the MMCX domain, while
> the PLL is powered on by the MX domain. Extend the driver to support
> scaling both power domains, while keeping compatibility with the
> existing DTs, which define only the MX domain.
> 
> Fixes: 79865252acb6 ("media: iris: enable video driver probe of SM8250 SoC")
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_platform_gen1.c | 2 +-
>  drivers/media/platform/qcom/iris/iris_probe.c         | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> index df8e6bf9430e..aa71f7f53ee3 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> @@ -281,7 +281,7 @@ static const struct bw_info sm8250_bw_table_dec[] = {
>  
>  static const char * const sm8250_pmdomain_table[] = { "venus", "vcodec0" };
>  
> -static const char * const sm8250_opp_pd_table[] = { "mx" };
> +static const char * const sm8250_opp_pd_table[] = { "mx", "mmcx" };
>  
>  static const struct platform_clk_data sm8250_clk_table[] = {
>  	{IRIS_AXI_CLK,  "iface"        },
> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
> index 7b612ad37e4f..74ec81e3d622 100644
> --- a/drivers/media/platform/qcom/iris/iris_probe.c
> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> @@ -64,6 +64,13 @@ static int iris_init_power_domains(struct iris_core *core)
>  		return ret;
>  
>  	ret =  devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data, &core->opp_pmdomain_tbl);
> +	/* backwards compatibility for incomplete ABI SM8250 */
> +	if (ret == -ENODEV &&
> +	    of_device_is_compatible(core->dev->of_node, "qcom,sm8250-venus")) {

A query here, is it okay to have compatible based checks in driver?

I don't have the links but I remember receiving negative feedback on having
such compatible based checks.

Thanks,
Dikshita
> +		iris_opp_pd_data.num_pd_names--;
> +		ret = devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data,
> +						 &core->opp_pmdomain_tbl);
> +	}
>  	if (ret < 0)
>  		return ret;
>  
> 

