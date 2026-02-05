Return-Path: <linux-pm+bounces-42138-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJx5OCh4hGk23AMAu9opvQ
	(envelope-from <linux-pm+bounces-42138-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 11:59:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88150F1945
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 11:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6444305EF5F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62463A9D90;
	Thu,  5 Feb 2026 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXftY+WG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N8oJwOl5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF43A9638
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288962; cv=none; b=NxBG4TSCZ0xOz6p7RExlvT5GoYTO/ov/qf1bEv+C7da+Y2T2vkh08sHQ6Pypk/Dn4GW10ineh/YZWCgrZ6ndCacd3ODHveCOveZ2p17RTUfIs17r++Lgf+wwAKXXxPESh4/mRq05StrfsY7I8Bu5JLwHliU9B5QAEACuPLfLnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288962; c=relaxed/simple;
	bh=hCruqOJNUkjzkYg3Hb7e2m4DUzUOXWMWxzX+Rf5tzbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekD9yhnwjBl4vV7BraBznH2mNcKPC0UBhxdp7w5mzglNV3H1pgqKc8bgwyAS95uQp0RQQtG2O6AZuRd3vMMIH7F70Mcg5Zgbi8kOxTwzO09KW1mpba72UDE3mG3f7665DfrV47MsVwQId/Pzr+w2fce44TF4wpji35mp8GeQaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XXftY+WG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N8oJwOl5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153e7nk3031340
	for <linux-pm@vger.kernel.org>; Thu, 5 Feb 2026 10:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MlaNI97g+MXBbAmK9/Ews2rl
	rWL1UCuYDL06HboPrQQ=; b=XXftY+WG+cs9vO6VmN63TKutTxiKb17okKGAaY85
	4o/aLOspQxUaEHkcO2JWFSD6KmYnO7eZ0xjnFg8EROrqIPimqrnBWTDfy8a5d6hl
	QMjOitHCJps/rKne1qNvZoS/FGlwJhqPYYIU/zemdnCWtzTfbQlDNOgOwPaGv72C
	i7CRNYym2aSN4xtvvNWd6i69JvuOYmAbuEm3NRzuqpnwkTD3c+F3UgD/qVUcSeAy
	zki6RpyaJfmZYm7+3IgbuTqP6kGCSHa6D39l/UULcL1eN3fvLVsmaYXLDK24nmnX
	vaIb1qJjil1yghTJqVE9GEzF+glrqsX7+G4JqlBJf8Hs5w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4a7tjwp6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 10:56:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c881d0c617so207809685a.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 02:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770288961; x=1770893761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlaNI97g+MXBbAmK9/Ews2rlrWL1UCuYDL06HboPrQQ=;
        b=N8oJwOl5C8PH4COsY3FmNEk7/LKdZ86/ZV2R7NZSxDiSNVG9WzQUmTmWcaqexb+rIi
         xlcKFg8xE4JGziSqxc7AKK3TH61DpgH3wfaKc8epOS4LEZtVVVr/Qy2DT9Y2sIM0oKh6
         V6ef9KGuVMsASpm7PXAyTb/7uONPh61wEvWXVW03qm2+Hcf7e3oR1EZY8Dr7kzGbINYJ
         oT2YP3zxG5Tv+f/3znqnQh6ExVtEpk+9t9EU3VtXaOZ21XImr5rqtg9BNW7XK/fUj1XV
         IEdjQxwqs5elMFMAHMHiqWT9FSI40mmM/2NbGzYyZWFNrHteFs2q9qGrwzXnBa33J8mS
         MzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288961; x=1770893761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlaNI97g+MXBbAmK9/Ews2rlrWL1UCuYDL06HboPrQQ=;
        b=FXQHknd5Kuttjjz7sSguUBJT1k4QfAkypbryZ+dWdQhDS91iWh4WU0ox88uptiH9RD
         hWOZl4zPkSLHlWLWbrhoPWb/b4kO4N4YZl21i5JNb0JhoA5wwko5jdsKlmfbdcEJ4bkB
         Tv4D6IrEN7fO3FJfn5XRLWqwkK2B6G1sl4zz4UONnc5J7wbJ17WjpFB1lDme0KankF3t
         a36A585qIPuVjHeb+70+wln3G3biVavXK5wvXIU0GOVZ3+q8dqJnFpHyRz/IUyPHralh
         IZg83q3d2IHNF6siaHktCTEqt8dgK3jO5LLtijTduRwRbeQBMbkRkq8zgO8rfrbGV8wV
         afbw==
X-Forwarded-Encrypted: i=1; AJvYcCXe3o5w3gZ8HCEK49tXgZxzie4fP7OnYjjMnJGsXXOH6Ezo0MzMO8pkm9dgbwyHfj3l0283vOfF8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAvUvVJhtrEOegjwUUqjkXYNw8Fv7m4Xxe40vYu1oJiAiL57wH
	2UtQZ8Ze7mcNxawSKFGu8BTldMNh5OGkrB7HTGKjVA8NfJrwNjg3npUTxI4S/BPO++9AEc75LsL
	7tV8wvt19t9MK1KqvHN+d25613KoXyaj5osfPwApmPQqs20V4dWB1MjjK3fX/Xw==
X-Gm-Gg: AZuq6aKGmteZ4WHi+ujGqvfTGgZjsMrTMWqcW8qRMyO4VRsiPyx0dR+A9lxWvVEc+7Q
	lyk9zDhcSA0FmkjdFLxsWfN69nRmPodKacOMFCroTLONRTlZBVFQSVkShvo6Li/h3JJKzB6kQbL
	cRVRYCYBICMkbfcohveUumJT0JSRA6AiWUCZCzfy0unL2W31lAeYKmmoMYboczdjBWq9F15UHBb
	yAtBNkr4ez8audIhi7GHLrdk8pxOMrL28HS0uFXTKAOzr5sm9gCE742NJx0Qo37G5HhqfYlxaSy
	TtTqiZC3y8xOGo6RB0ITFswilownLmU7DRHSmC8D+ivG0saC48D9FfKLtxxpYq1tPBnkg6YeQxL
	xBUGx4HfkJD8mhR2l2kkEJzSVBySXQ+UWnAkBT9FOkzVKMaqBVWgJD6dit2IfRbzDK0tT96NPV6
	Njf33/P9pQYLdwMVe9U5xqSGQ=
X-Received: by 2002:a05:620a:1a82:b0:8b2:eea5:331b with SMTP id af79cd13be357-8ca2f856b1bmr728561985a.19.1770288960665;
        Thu, 05 Feb 2026 02:56:00 -0800 (PST)
X-Received: by 2002:a05:620a:1a82:b0:8b2:eea5:331b with SMTP id af79cd13be357-8ca2f856b1bmr728558585a.19.1770288960207;
        Thu, 05 Feb 2026 02:56:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e3882220csm1347914e87.68.2026.02.05.02.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:55:58 -0800 (PST)
Date: Thu, 5 Feb 2026 12:55:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
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
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v3 3/7] media: iris: scale MMCX power domain on SM8250
Message-ID: <3bmmqdn652xm5ja5mqq3epmycthjnhhgllm5guhc5jzn42mycj@kdjqjkhuvjkr>
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
 <20260204-iris-venus-fix-sm8250-v3-3-70fa68e57f96@oss.qualcomm.com>
 <2740739c-b0db-7248-f9ba-e1a7dd69a5a2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2740739c-b0db-7248-f9ba-e1a7dd69a5a2@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: cIlmz9jCkbFSaPPQl70ryRrKE4khA1aF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4MSBTYWx0ZWRfX38ataqJCWm9J
 61cdO6YNZ+6eB7N9blkw0+ZraVO7Y7zz/nxuZe72VKFA2WvSlzlarFUG7grfHCderTvB4Y6z0s7
 m47miBDG8tMXpu9I2TS6tHUdZIv9m7U6t4Dzmeza0D4A4rg44fxPhwZXv/iJsyc7NBDvq6HhQLG
 MUN/7KAkntNkcRsPRKJyfCMuwnBYGy///2Ei7I1BG4+1V3LvNulyCcQjWBcgqQJ2kNxIeWtu5Ug
 ff8/b8qzf1ZHiU/yw68frkATglQgVguZMSPw+zbmyWIGsRsGpRtBwduIy/HNSGnSU9Va+6cPCLz
 M7nE8aLh6ysjpnP13o7dpuaRhodqSHM26zhfovktoSL5Vwm4HnoNxs7MS+cw3Jj2LmKdE9rgKAj
 X1LMBPc5YRpU8CrgGl8PRp3/6weLh8FuNo6gnI4YXJ557lsfw0+qVnyufeP0kURlssgGsHBnsbq
 xk9O5wnbcP9hyxJMV7A==
X-Proofpoint-GUID: cIlmz9jCkbFSaPPQl70ryRrKE4khA1aF
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69847741 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=9MiheJ026npgdNaa-0UA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42138-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 88150F1945
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 04:09:35PM +0530, Dikshita Agarwal wrote:
> 
> 
> On 2/4/2026 6:29 AM, Dmitry Baryshkov wrote:
> > On SM8250 most of the video clocks are powered by the MMCX domain, while
> > the PLL is powered on by the MX domain. Extend the driver to support
> > scaling both power domains, while keeping compatibility with the
> > existing DTs, which define only the MX domain.
> > 
> > Fixes: 79865252acb6 ("media: iris: enable video driver probe of SM8250 SoC")
> > Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/iris_platform_gen1.c | 2 +-
> >  drivers/media/platform/qcom/iris/iris_probe.c         | 7 +++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > index df8e6bf9430e..aa71f7f53ee3 100644
> > --- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > +++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
> > @@ -281,7 +281,7 @@ static const struct bw_info sm8250_bw_table_dec[] = {
> >  
> >  static const char * const sm8250_pmdomain_table[] = { "venus", "vcodec0" };
> >  
> > -static const char * const sm8250_opp_pd_table[] = { "mx" };
> > +static const char * const sm8250_opp_pd_table[] = { "mx", "mmcx" };
> >  
> >  static const struct platform_clk_data sm8250_clk_table[] = {
> >  	{IRIS_AXI_CLK,  "iface"        },
> > diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
> > index 7b612ad37e4f..74ec81e3d622 100644
> > --- a/drivers/media/platform/qcom/iris/iris_probe.c
> > +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> > @@ -64,6 +64,13 @@ static int iris_init_power_domains(struct iris_core *core)
> >  		return ret;
> >  
> >  	ret =  devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data, &core->opp_pmdomain_tbl);
> > +	/* backwards compatibility for incomplete ABI SM8250 */
> > +	if (ret == -ENODEV &&
> > +	    of_device_is_compatible(core->dev->of_node, "qcom,sm8250-venus")) {
> 
> A query here, is it okay to have compatible based checks in driver?
> 
> I don't have the links but I remember receiving negative feedback on having
> such compatible based checks.

In general, it's better to use platform data. In this case we have a
case of keeping comatibility for exacrly one platform. Adding that to
platform data would be meaningless for all other platforms.

> 
> Thanks,
> Dikshita
> > +		iris_opp_pd_data.num_pd_names--;
> > +		ret = devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data,
> > +						 &core->opp_pmdomain_tbl);
> > +	}
> >  	if (ret < 0)
> >  		return ret;
> >  
> > 

-- 
With best wishes
Dmitry

