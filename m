Return-Path: <linux-pm+bounces-35171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A4B91804
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703B31897783
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB130E0F2;
	Mon, 22 Sep 2025 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="To0MYj2a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DC30C0FB
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548721; cv=none; b=GSKuuJvL3lOqXph90haNE23nwgVMlkV+enCyc0cGK1+5TvFBpvCD800HiMnAMhF3H7gIdpTdUt5sU3g9hVgGV26iDiD9poI4VXIAob9W0y+uqTOUxcTGc7oAa+GyKgf3UlKLedzjaSefeW7bMKA/3SfyhzCwaigOPqNvFRE+60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548721; c=relaxed/simple;
	bh=uG75ywJ/N/C4VTC9ezp6AkudmGNPmDTqgRJVwd5unM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d17eRHLCM6i+Nig92HS4NAMf4tqL9Gys+ArX7sIQsxwxRr69Qm39sDnRdv4+EdUJwv5k+vabtJz1dVo+l/tkBKFqcpERgly7+xOfnsDvtmNg/TzpNuNi2u59Dz3+Ag0CbuS0SLO6P2kUuO68WKS6oL7muIY/ATDKSlOWph0GSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=To0MYj2a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8xMIr009803
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+GScQufAFT4/Jq3nDg5dsFylkF0kL3QXfWaxbdntkyU=; b=To0MYj2aNo8/9OTq
	e/rYP2cpxQIdJji9OOfwR9fV2WJBnUymGCrJW1V8SpZ0iBpVeFa6aJNau0zvFFB5
	wZl+ia0jCIQLvsCr0GkG0o7Of0HMpawOiwGHM4mJqmk2QDjEUxkAD9ZXqe+6IZm4
	06ITFC8/eUh8/GBgmNkFmCgy6a0q+EctabQ/r5fsCproGVzqF4uGOrTf67/7mbTo
	dbwRd6EXMQYlH+yqOrJN8XEt9hjA4jI+iDGWkRhUSDug818EqHikyOU8QsIvt3cJ
	qPFQK/dm/6Pg3zPKIoYB+F30z1WAkyT+EOh8+uCQje6BGgzCxEucJffJotN6Pyee
	mp/E2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7cx43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:45:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268149e1c28so51320925ad.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 06:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548718; x=1759153518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GScQufAFT4/Jq3nDg5dsFylkF0kL3QXfWaxbdntkyU=;
        b=emJqNvAWI9yw8Jbm5BcYhQa+YdoZJjM0kpPDCdy/14H8OPEMuWzyRw8U7BsCbfPs+F
         XLGUqkAtjO6DsSN+tWpr9m903wTyYa2DyU7uZIAP8rPr/vo5rPIHHGyGPcqEXK6YBB+J
         941sf9XrbeggWqmrQrYFLa8H2Rrmt/4Ha580uCoH6mRECObqI6ZgUAOALL6wL5V891dD
         jiyClDIBRFBWJS3TiE4SxrKnrOzfmGT9shC1274s08hZSUQhow9WGhz6p+v+g9Bl49Wl
         iJrGMnCX4hbYmF5GgeuRcG95Ed2EzkJfucxjninf2M+XhREGcpm0kzpZ0KWPeEj54oah
         YBnw==
X-Forwarded-Encrypted: i=1; AJvYcCVMtoRMHhiyETbQcTphWu9XDbaeGu++E25xURrs2FygX9tUglFFQV6klfEwndWwMaNW+m/mnKrR7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IM7p6fBOAPkFEcNOW1DMiQFPmnA37Y+oeoPgOgecZJRhj/a/
	y0mX6uVMxf0lBW/TakhyqQpjV803VF9bvuYPPzAlfgTZiXCadHbH96Erm1jpnjmvkQ8leMmRSDj
	haV/UOh5KRMbO5Q0ax5jlfuOodTCcniX0HelBicyvQlGKzMN59+pb1j70j7WvfA==
X-Gm-Gg: ASbGncv/a+ZVWE5BKtRySW5XKsnVyofkatwyLNKhvQc6VmBUgnEN2mkUBHmBToHLur0
	FzrsT7l2V0+CrKWKGIpIW1PTEr4ppOK6ALXEOK7JM8M42aeWNHVo6UllY3e/sU6hflUwzn9Cf1o
	aOlirKmZvd8qF7ruQSPX9u92NEWeTo2FBZ9Bl4ZzVv49mH62UWm77sQulVoGoBpCURoODw3Y8R9
	xUHg6P6YnqdeXq0PeLr/mU1/BlBBRszRQ1Kt93t5i6Vbw65ax902euHLiS6ScLTC3ciLn9H7WLd
	tJcXlxTAhILkupf2pxhxKogOZOnBjNaejrsuf/Efa3mlkqzACKixxbs25B0WYlru5ezLWUoFaLQ
	SnMq8BO6EJ1se3FFFJRI4Pv+fyqmlWao=
X-Received: by 2002:a17:903:380d:b0:246:de71:1839 with SMTP id d9443c01a7336-269ba5512ddmr154128435ad.50.1758548717588;
        Mon, 22 Sep 2025 06:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Bxtg/WM4oSQFnOHm5vgIFDxjSmyxZZcCDz7Kx3f4NlCh9peJ1mVy6ZCZLfMSaGBLSNf2zQ==
X-Received: by 2002:a17:903:380d:b0:246:de71:1839 with SMTP id d9443c01a7336-269ba5512ddmr154128115ad.50.1758548717036;
        Mon, 22 Sep 2025 06:45:17 -0700 (PDT)
Received: from [10.133.33.135] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df852sm134515585ad.87.2025.09.22.06.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:45:16 -0700 (PDT)
Message-ID: <1dd930a0-b975-4302-9e1f-f06904d8a25c@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 21:45:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Handle CPUFREQ_ETERNAL with a default
 transition latency
To: Shawn Guo <shawnguo2@yeah.net>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20250922125929.453444-1-shawnguo2@yeah.net>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20250922125929.453444-1-shawnguo2@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX15tvM33s4d6W
 tTZXkYauDTE74vEzjtN9sIu9BNBQ4+iFmpq8VCGuIiklJlmgjlBZm4InEZWcxHgykB1m27umW7W
 0M6n55Qop7ceOLRTu/FFtv4xf3Joslaxy2aApc3vnyiBxhqdqmD9YqAEG4WWUCkV5nwiQ4zx7FL
 LLjLM3SE80KC3xjr/pAtFLu5HlMcZ5+OifctpDFYpD8/bR7+3CtFccnvXl3OAg+LkqVxpoW/wJK
 CsHKUJ1i30/EbRYBrvobpgpsS79lz2bdVKa0wpg7xmCifrpkwxWJKB1OvcrSFsNPUepoE7abH9T
 kNSQAeASVdXZ9yVF5K+bG6WvuEjKvRtHdSaL64cWB2QAEqWro/Pe5o7BcFPfKgmkwK4h+wQY7aB
 /mI2pFZE
X-Proofpoint-GUID: oKXvcXWakfkpuOvucWnJhUPJ_kI3JlSr
X-Proofpoint-ORIG-GUID: oKXvcXWakfkpuOvucWnJhUPJ_kI3JlSr
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d152ef cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
 a=IMh0YCEmi6Npu7LhsKAA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

On 9/22/2025 8:59 PM, Shawn Guo wrote:
> From: Shawn Guo <shawnguo@kernel.org>
> 
> A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
> cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1),
> due to that platform's DT doesn't provide the optional property
> 'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
> suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
> platforms, because the default transition delay was dropped by the commits
> below.
> 
>    commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
>    commit a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
Hello Shawn,

Reported by checkpatch.pl:
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
description?)
#12:
   commit a755d0e2d41b ("cpufreq: Honour transition_latency over
transition_delay_us")


>    commit e13aa799c2a6 ("cpufreq: Change default transition delay to 2ms")
> 
> It slows down dbs governor's reacting to CPU loading change
> dramatically.  Also, as transition_delay_us is used by schedutil governor
> as rate_limit_us, it shows a negative impact on device idle power
> consumption, because the device gets slightly less time in the lowest OPP.
> 
> Fix the regressions by defining a default transition latency for
> handling the case of CPUFREQ_ETERNAL.
> 
> Cc: stable@vger.kernel.org
> Fixes: 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> Changes for v2:
> - Follow Rafael's suggestion to define a default transition latency for
>    handling CPUFREQ_ETERNAL, and pave the way to get rid of
>    CPUFREQ_ETERNAL completely later.
> 
> v1: https://lkml.org/lkml/2025/9/10/294
> 
>   drivers/cpufreq/cpufreq.c | 3 +++
>   include/linux/cpufreq.h   | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..c69d10f0e8ec 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -549,6 +549,9 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>   	if (policy->transition_delay_us)
>   		return policy->transition_delay_us;
>   
> +	if (policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)
> +		policy->cpuinfo.transition_latency = CPUFREQ_DEFAULT_TANSITION_LATENCY_NS;

For the fallback case, May we print a dbg info in dmesg to inform
developers that the device tree is missing the clock-latency-ns
property? (Rafael can help comment~)


> +
>   	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>   	if (latency)
>   		/* Give a 50% breathing room between updates */
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 95f3807c8c55..935e9a660039 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -36,6 +36,8 @@
>   /* Print length for names. Extra 1 space for accommodating '\n' in prints */
>   #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
>   
> +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
> +

TANSITION --> TRANSITION ?


>   struct cpufreq_governor;
>   
>   enum cpufreq_table_sorting {


-- 
Thx and BRs,
Zhongqiu Han

