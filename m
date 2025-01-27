Return-Path: <linux-pm+bounces-20980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D742CA1D91A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 16:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66A51886DD8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DCA13AA27;
	Mon, 27 Jan 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGG265+9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C213959D
	for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990732; cv=none; b=o0gpp01boxPmS/8o3BRsXahQfHOnvGrbuaoR9+X3VQXzyQORRskJpQkkNxE8Y82lAmyJt+xfLzT6OeFsfjmWha86HO+NY2Nn/jjSZyw3mlhhUxozjYyampUoJa/HboE8bMUlrGFOpF1DjZtIaj7/Lbe7FVDaiX6XDCZlK9IyoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990732; c=relaxed/simple;
	bh=0/2bJnEnDs8um6XYYODDkPZ2omRK56ST66i1OlyJEKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lXEeuQelt1XyPYdNZScAPJvyiYo+CMqE6mvCL45xUukFemSM2x7xCPuwK1v5HySxG2o2iWpmArieiKAOxHO1+06AeCJGLLNLAXSOI+VVzgJqSCjIsLksO0nUuhlBlrBZn3J+zoGsVaziPumwNhXSRh8ueRLKs5xpeLoEGdpxP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGG265+9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R9m0NM028379
	for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 15:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dQpvtI6u3lxTYx1xzlqCxqIm9uDJhDvieISDzIxyB3U=; b=KGG265+9kok1dsaT
	jn6yay7UsmHlM/Z8GeR6dq0lOj8NRdcbVnkCK9FjAgc3tAtygj884BfBU/Y4duZb
	mAXtAxfG1N2FPdjXGLFHUxV4wf1zWn1YDYibnQLOlvw7OayBOOgtyoNDv8dco2mk
	0F7Tmw0NOeJUz7SbgEXcBRbHfGi9GFQ/iNh+MbHy++Ghsr8jKLvRvUBVuqyVuXOV
	uBhYWn7rBrnJSv/tDYBYL27oRJXd7ixngJkN9WnhNZNKuTiWIKxAPLl2CVNmGde/
	evcctEhYbEKA64Y+lA/s5bonhY3+b58n5Vp1TPM6RkwN4gNpSks69TV10fbfc5DV
	VQwpKw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e7tj8pb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 15:12:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6e43ed084so90667785a.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 07:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990728; x=1738595528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQpvtI6u3lxTYx1xzlqCxqIm9uDJhDvieISDzIxyB3U=;
        b=ItI8nWRZYJgyJ+vZFRiz58iBztyGADjHAHyN2FEshCQcsyeioKrvXblYPxgJiSM4Wu
         dZOsFdLZ2k3c20hOH/j1zxjyN60pNLrELD/njR10wZJo2RTKbiOHyk2GZ2ay/venKx1J
         h0NakmTIjY5hd7oZ2XlB6z14ih+6FQH9gAaV+6tSlQSfbOMCuJ0IN3qu3XHeYfjuIBi8
         12fX8Wcj1wjGQuAp/Ywwc+vaiEwkrvHUko/mAxXD6JdK3tPI4+11zFONxfsA5dTXd8hF
         Jc43mZc+oPgHR12eey+b/uZQn/bdp9QLlQJZ6ar1zL3mfR/K7yoJHSvx9dcwJ0S8HaEQ
         er3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv5UAH80vyQ/n6NtVH24RxLfz8H81+Tt9mPErheA4VEymYKHUpmVFCuinGQDP/8OtmDT2S26z90Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCicOoYLMpRUSnjp5Gg8K6ZaRObrBMZ5Z6V+ouaMdYRQtlgum
	Y0EMRkrB58/DECOg+ZuNMcCthuEFDJyvgv5UcLjNl5w07EV0XyfkqUhxKYsZBZCNNIacIkagR+Z
	8e8z7bqm582DftiBCSzv46QPhQvSnfnU5PhbHgkL9M1XJ1AKF624X1FD0TQ==
X-Gm-Gg: ASbGncuUGbbTAw9D5HEeoXpa/wdqgQQKmkzfXgCbaY3mcjXb9XZFCMsy/HbqTHgQiPM
	7llJVMPt7k59fL+2tp17g7Sp65ZB0J35ZaYmKaMoF9fD3VH2ZnABYuw0xpbGryhxqrPpNzyf+Lr
	MEHQ2K2wyggZVwQKeT5u4+iBjgbozzX5rGb8RxgJW93VwGRxOPmogS9NkAH81AOaTcV26FM4HNK
	fNmGkS5ExFkgX7sr3mGGAWVE7fwqAbpZtsB3eK4g+AyJTJQ1i3UQjtUOhROKUzPUVXDwgUM2jzn
	RW14urdxwmixGqjtLq7EC37g6+Y/Jo4CgjyL8nwwmQQzXFRqd6m8JFFwL8c=
X-Received: by 2002:a05:622a:1b92:b0:467:692b:754f with SMTP id d75a77b69052e-46e12ba7bbcmr222256431cf.13.1737990728546;
        Mon, 27 Jan 2025 07:12:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAXSyKsvfmhX3h/ssch181jhsbqIKNv4LNE3vkPaU53NS6RVkISKb6uv5OLWtSlIdF4nr7xQ==
X-Received: by 2002:a05:622a:1b92:b0:467:692b:754f with SMTP id d75a77b69052e-46e12ba7bbcmr222256191cf.13.1737990727978;
        Mon, 27 Jan 2025 07:12:07 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760ab363sm598975666b.114.2025.01.27.07.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 07:12:07 -0800 (PST)
Message-ID: <7e118726-b22b-4c7b-9966-07c3b1ff709c@oss.qualcomm.com>
Date: Mon, 27 Jan 2025 16:12:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
To: Sricharan R <quic_srichara@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250127093128.2611247-1-quic_srichara@quicinc.com>
 <20250127093128.2611247-4-quic_srichara@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250127093128.2611247-4-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bRVnFDEeNI2h1Fn3Vab3GOctfGNDJmSR
X-Proofpoint-GUID: bRVnFDEeNI2h1Fn3Vab3GOctfGNDJmSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

On 27.01.2025 10:31 AM, Sricharan R wrote:
> From: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> IPQ5424 have different OPPs available for the CPU based on
> SoC variant. This can be determined through use of an eFuse
> register present in the silicon.
> 
> Added support for ipq5424 on nvmem driver which helps to
> determine OPPs at runtime based on the eFuse register which
> has the CPU frequency limits. opp-supported-hw dt binding
> can be used to indicate the available OPPs for each limit.
> 
> nvmem driver also creates the "cpufreq-dt" platform_device after
> passing the version matching data to the OPP framework so that the
> cpufreq-dt handles the actual cpufreq implementation.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 9c198bd4f7e9..4045bc3ce805 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -187,6 +187,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "ti,am62p5", },
>  
>  	{ .compatible = "qcom,ipq5332", },
> +	{ .compatible = "qcom,ipq5424", },
>  	{ .compatible = "qcom,ipq6018", },
>  	{ .compatible = "qcom,ipq8064", },
>  	{ .compatible = "qcom,ipq8074", },
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 3a8ed723a23e..102f7f1b031c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -200,6 +200,10 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  	case QCOM_ID_IPQ9574:
>  		drv->versions = 1 << (unsigned int)(*speedbin);
>  		break;
> +	case QCOM_ID_IPQ5424:
> +	case QCOM_ID_IPQ5404:
> +		drv->versions =  (*speedbin != 0x3b) ? BIT(0) : BIT(1);

Perhaps:

drv->versions =  (*speedbin == 0x3b) ? BIT(1) : BIT(0);

But ultimately both work:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

