Return-Path: <linux-pm+bounces-41033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 551FAD33869
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 17:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF58E3013C42
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D675F39341A;
	Fri, 16 Jan 2026 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l5oB5sKA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BQ8dWcvj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE01394472
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581289; cv=none; b=UelLP7ke49BuEVfOW/eBC8VhETu74DJAZdbK2c2N+AMZFeoXSMrfQLd/C+XfHjcj8dIsR4Gagp41TimxKhbvt6dV/jFdVmZDjhmq1mGwqWE3Sfw77kPdwopFP+FV6uCA0FzHg08qEPur4UA6zryJmqoyO2QE0UVPXeeyaaGTJN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581289; c=relaxed/simple;
	bh=e8E2A+eo/KQwzZm9O+K51Cg+TzQHkK+jR1VYjq3CkS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUytTsRtF2Xqq/JVSkXn8awJYti4FLG/PwFNwHCKmKCLQg3kHVgLhaNITIo6Hpv8gytlTZaoldAdI80XA1jL8LdelqwojcOmDxjUSmHm3VPEE+5pmX/SvE2D8/9xKyLLea79UhOXWeaQ/JRL+gJoBbqqeBpOk7+RoBWRm0mL6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l5oB5sKA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BQ8dWcvj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GDZsMr1196550
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 16:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fCYKQXs+T1JIIa5G6WnDladc
	SFMG2v8SiIjUv68q0Fk=; b=l5oB5sKAR9ZIhK+VnnPwy86114P0A5VGO2r83cll
	lBZKV+vb+UvyJ5Hm6AIWylcUc5oeLj8ZRg99D8LLmOXqXOZN7KV82Nks4fy8g6t4
	3uNVPzXWlKlctOfT8gyEweBuhf/ji1TYedMlH6j7Zu8Iu1hIrGfZmV7nUeN1axbY
	WAO7yBkoAtwCge+Kxfeu4gv+GzOIQ+0e8JSRVLBGH3Xqcfn2rua5pGbJs2dN9hm5
	Y4ZfgEpovlfGLrsRpz4NBtNu2GVSMztuN8ba3QllXqFxnBN2SXnUqM6cV9LTUmyW
	37CNu602zI0hQK7jL4yxtcqYMA2nNZtilJiTYnSEjYI64Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bqpbr0h0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 16:34:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c5297cfe68so421636985a.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 08:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768581286; x=1769186086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCYKQXs+T1JIIa5G6WnDladcSFMG2v8SiIjUv68q0Fk=;
        b=BQ8dWcvjcBd8DrNp2VbiErZL7WQSngBGF20hnHv1Mxth8DyTBegz8r//0GB+0CTqZX
         pyoSQnWKtFkumvLWczVsqLYTTCQIeavx0PHfvxjQzGAi6YlqkXg//LtCoOhPM2BCBzyu
         CYZDkZQc/Kddp9J9szZlxObx+zSh0ZcGKIktzmwyastURvtdvv6gJqzk/Wo1mdgMcAty
         DhVixioWyGZYGfWmm7b6eFInJ+NnPnCsaePRDodZ2Y+6OpxEh5UL8J+9WIU2WCamPYsf
         oCGR+WfBv+XYnNFA54ByEnthjouhzOJ/GGyYazb7sXrvGzCsrcEE/o8izChm9uv8ckqw
         HslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581286; x=1769186086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCYKQXs+T1JIIa5G6WnDladcSFMG2v8SiIjUv68q0Fk=;
        b=GBcmF1t3qQlJmRzSjtnEogUuUBYyeUjxLMrjk/MfiNTBQE9GVkBH4hpUcNe7aP8am0
         xBkWooMC1H6wDn4Xbjg5fIQQGL8tGg61WIPI1z5CLt1gIGEGgtsl6HPNhyB8ohH9W4qZ
         nD8dRbEVL5WfZUYNmILs082wTYUh+9IDlLdE9/IO2QAF0MZ8v0wQl0mDZ7xHl1ogJ1pn
         yu18MInC9H/sNgQ1OiRG6C8coCi064xJsfg519uLyGC5q2WMJFQDNmp/53uOSb4lEneA
         0Cl4+2iJcFI/CRF+sw9/edSEKwuFT/9UPbjm1ghwrDhtw9RtCaI/A+RpfxWJGYG2hm+C
         g6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnCmVrOW9/dgbMCO6fNEOzJCCf9wRhGgCkNRh+P9W0ji++ZhFM+7W0osJrtOBC2SFiMpNbs8V/QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+gf3gHyvIp3uyhW9Re6Bs3f98Eifx0N85lxXud8uKJHNnv94
	9DaqjDsfbACvSOAaVqHyQzJCLwc+sAS4NCVcPcIz6/edI1mSnUPZ6uZLWOWCAHLETWaJVYCmG0C
	GQsriO+k4gEncxoXSlAHoEIJvmSLb1u1spjNs1HMBAqpiTnWrhUOVT6dlwzM8CA==
X-Gm-Gg: AY/fxX4Rx7fpTwIQyPcoSYRPccLH0f3SEY6iWzTFX5i7DZcrXm+4wPw7oNPDxbKmZ5O
	fju3XgPcMO4+yTr3M2msQ4Ud46Ewv87wjLlOFciEEdMcb6rS8OlisFrths61WhXbPHtTosuzx9M
	6S+HPcoum8TYODn0frWjCSHkEWNf+oT6kd0NHHus4G431517+SR00YmUHqjpka0f8viEhVz2Js0
	xl5J5ozxlxfBMhd8hPq/D9Kw7ae7TzL6N8lGZoZoCQEdhd8Uq9s7Vikq6vx2FGjnaHU40HOE5OA
	emB3dg8N1Ehp6v5hHj0TRkRlWd5BO2H8qUxvzn8D3qgjBjKU3A9jJYoa6TOwFd+YkFvouvNBMxs
	YMdCJU7tcWu/A9B54nTkLnciVXmlelISdvgUbgT9S2lbZ1oI83gbEzX76csXX9cXGhHbJIim3Js
	qJRWjF8OngoEHvzg48sqvUWXc=
X-Received: by 2002:a05:620a:4801:b0:89e:67a9:fced with SMTP id af79cd13be357-8c6a6789e6bmr501564385a.66.1768581286227;
        Fri, 16 Jan 2026 08:34:46 -0800 (PST)
X-Received: by 2002:a05:620a:4801:b0:89e:67a9:fced with SMTP id af79cd13be357-8c6a6789e6bmr501559485a.66.1768581285613;
        Fri, 16 Jan 2026 08:34:45 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33ef74sm897580e87.17.2026.01.16.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:34:44 -0800 (PST)
Date: Fri, 16 Jan 2026 18:34:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: milos: Add interconnects to camcc
Message-ID: <272itffci5xkelvykfijviarm6np22fvcofj4m4tud7l3fn7c5@n6p77vfid36u>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-5-400b7fcd156a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-milos-camcc-icc-v1-5-400b7fcd156a@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEyMCBTYWx0ZWRfX7LG2yPOW4JdT
 /Tma+P6ErjXguc19E+tY2sEhF/mPx6Xpx7aU8XYe95/rRvtvBGJby5BT3pTO2+0oibEAMAPRUq4
 pButWelSvdjjA32zSVRLjrORkKfwFItQLvGnmJ6RZpdlH4BYfy/SaXgAlLdqIpdcMFlSIqm75AD
 y79P10knRSFnyq/8OyGMlz5nzpvRea4kbAFzrQRghBLNTGHY+IvWJLR1hYrDhjNRiwYJF+dqdQn
 AxS4Qu6K4JUm+ee7lWhWSUSdgh9wiRAe77oRyM4csGrYilBTQbRvp1/s85wCVbZSlDvGkcb0KRl
 RpqOuXKFLzn5+bJ8Anf4XCQbUpVKK0XO5PwYgn0pMDS2cCU27zMQnnQ0VVe06kR79eqbHmYbIP4
 9FI/SRsM6C61rmkr6cF6uFfkhdn5znPea7BVuqlC016+5VibYUvqwua3tV1R3b3CGAaMbMmAsGw
 87x4ixXo3ck65xV9G1A==
X-Authority-Analysis: v=2.4 cv=dL6rWeZb c=1 sm=1 tr=0 ts=696a68a6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=jeBussX95TUAqHeP4CEA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: 8nnP7ueZX3q46A2GCIG0hbDmVrcaywhU
X-Proofpoint-ORIG-GUID: 8nnP7ueZX3q46A2GCIG0hbDmVrcaywhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601160120

On Fri, Jan 16, 2026 at 02:17:24PM +0100, Luca Weiss wrote:
> The CAMSS_TOP_GDSC inside camcc requires an interconnect path to be
> enabled, otherwise the GDSC will be stuck on 'off' and can't be enabled.
> 
> Add the interconnect path so that this requirement can be satisfied by
> the kernel.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

