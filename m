Return-Path: <linux-pm+bounces-29186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6BAE286B
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 11:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385A17ABF15
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D161F5424;
	Sat, 21 Jun 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZ41U0ng"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04A1DED42
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750499544; cv=none; b=XzsRYscNBy6NSVX0fMLu+mFeZcwsZUWIrV74Hxui49iqbFJato1KyRqe0Avgy+M3Q7Fyvq9H1LJDdi1iEt1b9joge580bT1bXSLi+2+E/Ue7yNhS8VMm4vsj4XVgXWJwaDsWmKM1lDlsmCO+m+o0QC1aFV1zkPAXzTL1RaXvRa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750499544; c=relaxed/simple;
	bh=TIOGS5SCJXWCddfJl4KBZfmMAUXC5JfjUaRnfjaBJvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXdBE8Gu7iELIWK2tZhMs6P8ixC7fvabJeZ/86Z+CxpiJNdCjLk3ndo6hU1jMl+jooydM0nD/uHNP4YYDahKxXqGKenbCdrfLN9QDeAGt2c+4SPyapNuqhsY21NRhSLkM3noTAZZUHgQtWVuwUYAsN5WNPlMkj7c/qebaanq+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kZ41U0ng; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L4FRfQ016655
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MrVWxOcdaryip895kznrb0Ayb7JA8Nch7LFAlupRSz8=; b=kZ41U0ng980P4AQ9
	F/kx6YTwZUCE5XLx0Iyg0VqMuJPM/q9dRTg/Nv0RTqEui9C6dPqBWF+hC+d/gblQ
	RfTckV/npgfTNKGrbj8EgmDdnbGT4VjzEPzmaAwMGadrO/hTH4L3ximxKlTMtiiA
	BHtl33HcOY5NPf64eAJ9HtMEG3EMEwtGP5UQYSrleNy/SByFz/h0rpmq+hhRM0tp
	0PbTr0ID10lIzmSTJFA1UK9srjHd5dFKZiqzkgOmV4qBo1nHRQq8BPDqTidRV/iv
	RPT1bulkVNM4DcYWgotYxuthWGXEcHzV2T0jvh/bFZrfuwt0+Q0Gh+myjhldCcCo
	xFcw1A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47dj3q0nhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:52:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d3ea727700so35812485a.3
        for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 02:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750499540; x=1751104340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrVWxOcdaryip895kznrb0Ayb7JA8Nch7LFAlupRSz8=;
        b=CcY8/42k4p7OVGgtgoDK99vPXsjZM6SkBPQeVvw4/2IYUJX1lbaVfVwKe9eR6yM8mj
         qCQUwqVopQmG0KcfMiwfRFUvOTmjQ9eYb+OrU5wwMQbQn52JyDMQ5JYFtEzxLPB6nYPy
         ofMnminln1T9z9cLM/mvRvpgptD4G0Fec5mi7/i2e+5p3bt7uiCJ/S/EE3ooMicJyjwr
         o5zZCcfgZ2pmYO7GGmNSVus9BRH9NETnR7uA80h17I2sLc+1N2LWY6ePJgLgjj5u4Hs1
         PrIAGw8D4CS3vNkoDfn6E76yAxyIvH1LksxCxt62+k0xMUOW2u+e1zzJuMN+TBESGEMl
         dHDw==
X-Forwarded-Encrypted: i=1; AJvYcCVMV6GpHy0huKVVsoACFehfBTvMWL9cBbXu99J4AanUfxxEYA8Ier6NCCwCmeVWFHPRd1qC+ayFtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRLemEhJhJ8efdmFteBAaWGA3NHKButHLO9+c3YumI38DOTGc
	fHVtD1FLctnQE/SeyhqSaBYWJ54bkud+iE55RVwRTyWllvZxxSN0RdGq1wTc1weJPa35mQxdMkT
	NNm8LrAZ3ZWzjM8ws4Ks+c1vhKQTxCQuG6c8F82hwOTK1/BJmhksU+YOmBgPUGg==
X-Gm-Gg: ASbGncssm6OwSlhtBz+bWllm+MOD0iFF9GsFP6H3jd3GYO9ArsamYv5AwDWm2xoTKPn
	TmBeE6Cko0eGe9A/YU0QGwDMlJgYwkJ0N8d8Qx736rR5jFYK7qHhvXWp37RtP3BQbGQaCAdK0JA
	qi0Su/VRM1tM0xbhEicmV2T8HVQeuqxD0PMV3pOD7nUsb3T9vxHiUln9mnpiy9oLtLf8h1IGmoB
	5FEM4/nsmY9JRFkeuz8iUz7YffyRj+FsEA20Mg5HsBEbfw1gv7/ZSXe4w9+l6cW28qytfxMdNPD
	Z5fxdHB93ZyWqQmNguJ6dfxwKfkhqfNv5hRrSqq9uzmscDmaQTm1lQu3F8ze472CUC9FXhmoSL4
	oBAE=
X-Received: by 2002:a05:620a:8392:b0:7d2:2019:c14b with SMTP id af79cd13be357-7d3f991e6ddmr314324585a.10.1750499539916;
        Sat, 21 Jun 2025 02:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq734alkVNfmP2y8YBUA+DkY0abDKaREh8B4fbmcqxx1pQveG+x3JgzRBjRxMOuxlvhFuZAw==
X-Received: by 2002:a05:620a:8392:b0:7d2:2019:c14b with SMTP id af79cd13be357-7d3f991e6ddmr314323985a.10.1750499539490;
        Sat, 21 Jun 2025 02:52:19 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4e32sm339696066b.57.2025.06.21.02.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jun 2025 02:52:19 -0700 (PDT)
Message-ID: <8555840a-5cbe-4650-9499-f3876528891b@oss.qualcomm.com>
Date: Sat, 21 Jun 2025 11:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] thermal: qcom-spmi-temp-alarm: add support for
 GEN2 rev 2 PMIC peripherals
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com
References: <20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com>
 <20250620001918.4090853-5-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250620001918.4090853-5-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BPWzrEQG c=1 sm=1 tr=0 ts=685680d4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=iJ2Ah6jtJjwnyIaW4igA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 7_cPfSkAFyiwHdj4L1vjt18BKvGMC24D
X-Proofpoint-GUID: 7_cPfSkAFyiwHdj4L1vjt18BKvGMC24D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA1NyBTYWx0ZWRfX4HFLeWXHiQqo
 P8n6c9byLzQ9QP+7dGgLNo9ZR5sFNt34aza56lx30AXuTmUlKVxlhdXXZ8YdYpQi5Yt0sLtk6X/
 sqw0nRozjDnGwp2FKlHeYUVZm9gi5OMWCexMJgLL9FZxXpsIGIRS2TUbUomRlTA97RfOeDRd506
 vOt/G/Q6yss35MO+f2oBr0hYGz1c4mMsUg35cEtpFx3y1mNvLnUDAC9PP2vXiqz6mJ7A1Bjz6Ql
 ytc19rgiy7xoR27jN6K6PwiQxRiLlsFdh7uVmsHDQTVfq5vFO9Pahco0MiJhgwAMhrK8um7HC3s
 K5JFExOsU2D+ZXXNPavH2wn3UfjNgTaJ+m9e0iSu3uzXR1jqnF8bBY7b16Mc1IuBP1tb1m4rBY0
 nKYTvZIOOTprgrYF3EAkjjQStGAExNrEL6hcTjST6fbWslzvCFBOhCKBYIr5C/HFNjqRMV2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506210057

On 6/20/25 2:19 AM, Anjelique Melendez wrote:
> Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
> revision 2.  This revision utilizes individual temp DAC registers
> to set the threshold temperature for over-temperature stages 1 (warning),
> 2 (system shutdown), and 3 (emergency shutdown) instead of a single
> register to specify a set of thresholds.
> 
> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>

A lone s-o-b from a non-author, without a c-d-b or similar is
ambiguous

[...]

>  /*
>   * This function intializes the internal temp value based on only the
>   * current thermal stage and threshold.
> @@ -486,6 +620,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  	chip->subtype = subtype;
>  	if (subtype == QPNP_TM_SUBTYPE_GEN1)
>  		chip->data = &spmi_temp_alarm_data;
> +	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 2)
> +		chip->data = &spmi_temp_alarm_gen2_rev2_data;
>  	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
>  		chip->data = &spmi_temp_alarm_gen2_rev1_data;

how about:

if (subtype == ..GEN1)
	...
else if (subtype == GEN2 && dig_major == 0)
	...
else if (subtype == GEN2 && dig_major == 1)
	...
else if (subtype == GEN2 && dig_major == (>=?) 2)
	...
else
	ENODEV

Konrad

