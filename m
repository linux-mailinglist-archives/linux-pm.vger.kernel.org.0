Return-Path: <linux-pm+bounces-33398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897D0B3B58F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 10:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844761B23FE4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425828AB16;
	Fri, 29 Aug 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bcMPcHi0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1328641D
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455001; cv=none; b=qtAvkIVfBXb9vPfIvc2T0UYu/LadiQ9z4Zk/eKgxjSWRuT65iecIHSKDj797EGx+QI6lelnHYBiGUJZJyGBWsS5U3MetSD6t+ijNzNioSmwu/Ar4hrQGjmY4XvueEMw+8tnXDWUJ+D8irRLLRUpVXJLH76a5I+i+qISqvpbo8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455001; c=relaxed/simple;
	bh=z1h03GLNdXLleb5z+38xr8uADY1LeMbzAyZCQ9BdpzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/V/cJ74IYhOaTa5Qnmt3Kx92GJ1czEqQI4p7Ax8vb4jN9QPwBtwuarbbHzlBtNwoHreYYcmmqZ5SzyJLAlghaBxVPpyo852x/tDIplIo5DZ9t4S3WTS9DdsPJYp6bAl7tQ9PEb+X/N/y/J8EEIoyTENC2F05bDBNBqorBd0Zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bcMPcHi0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85ISw025407
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 08:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bsv6NnJRTxJOMkJMe1wyAAiF
	Gmai0uCSvzMJL+nXi6A=; b=bcMPcHi0eahG31DYTlJndkJKxsFmOJaQJjCfgPiw
	oRy7USpQH2G0MGhGU5YZKKaaVJ3vfXA3fqqofwPhwmx1U9Df4O4vt00xR8DXLYEL
	yCWAy9+fqOVRJ9jMjExYyBuq8Ng3f6sg7GNb6O9xLFlX88EUJk5bzbzyh45Ex4cB
	xyZV0IeywDMFfdqGfrM+VeHp+YXvKBPzuiLNlUarVK8gU1M6BRHD8vjRhRhDdVes
	npFNYg+cu9tBlNRqsMZMDW6IQ36xlGk6nQYjPI3/7trdnNA1wK18V8kiuhlo+MPi
	xMOht9UkYecWW5Nx/gPIkP8Rc5MkAo5C8P5Sq6cGCzLmEA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48u4xygk15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 08:09:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b30fadc974so6888381cf.3
        for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 01:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454997; x=1757059797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsv6NnJRTxJOMkJMe1wyAAiFGmai0uCSvzMJL+nXi6A=;
        b=VpcjL5iY3OdSPXLU/D/iVQAlLP+HsGTluHemyZxu1HCRTQLlWCDCvDMtp4S5QWwwiZ
         i4/tga8eFonKg8/Qb/NL5Di3hG0D8CqT6QP+HQcitOvFcRPlNQ9n6dWVH465D/BnmMSl
         YSmsRPJfoJ0mlvqk/q3jxR6MqxIdyRuRpyzgzQZqDcC3zO3HK5nhnMsixUPRcOQ+H5fN
         A+dVuSmUbHSv6rFNUSLjNDm5HRXn0tpWfwODk35TrYw5IdzwLXsLRXNO/1MuKjnR6MYx
         gkh+v4lIC/IlHWHLwUofUULXS8+0GeC01X430dp8M+F6OQa2SZtRZiKnkAbtzglaXwQ3
         Om8g==
X-Forwarded-Encrypted: i=1; AJvYcCUKh5KB9mPZr8cWw9qrdmhPoSxuE9Y1B9o/bby8Eob1/7GoxHmUrI3F9ZWEKP5GxWN6mfS7h8aHGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7du4+08RIQ1xM95Z5Q99SP0c6h5puHzU4UV22N5amhOHWGvH0
	AiPUwLg1IXLHFTxyAaFxrBBkrcXjVgW3iA2Jg7zDtvwLR9vWKzarCQmKC7lIu6jdpeZQo6K8+a1
	y+TvU8kJ0RfvQyO8oDVWjk0sBjzI4Gt3VoXpePQkyN2SV+Tty6lUDv7SpnXs9uQ==
X-Gm-Gg: ASbGncuCLUWqF1u0ffjMCwAT/y0bEy13xrT7JZw0+lgfAyHKc0GbYWWlAPo4XdZ4vT9
	TAIQ6ZKFEjga+BBXPdwg2PCgiHAEdcqOptmXRTzOw9Iin7aRWqUP9HK3iMMdijkTDi/zgcIsQcf
	5e1s41LzeP0TWN7MGKzGLiA8MpdsDVLeWXqW1uoSeY4S5j7ZsZqLnou41tiNvgfznwkmgg3rgXK
	mCGL0EfoeVSIFO9hvgphQEcnf3ZRFTIk9kdSfS4EizGHk0ugnT0kAUHNciPXOT+mj3wXSD9+E7R
	jcF6DjnqxF/cbYi7H7baMGG7LGH8XCfycxQXn4ET88d4RfVzc/slowsFfiazBVszXfmh3ruMyyM
	CguYungcw6NeR/54mzsWA6c0KNXwinCPNOwz/X5kmNVr82JlH0YXD
X-Received: by 2002:a05:622a:249:b0:4b2:e151:a1e3 with SMTP id d75a77b69052e-4b2ea694690mr119134301cf.36.1756454997063;
        Fri, 29 Aug 2025 01:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQwcGrf8Uq6ErZTLA64qML9AZfcxsKmHVxxEtfjH1059x26sGs3RoBSkASHz9bNHu8//dSdQ==
X-Received: by 2002:a05:622a:249:b0:4b2:e151:a1e3 with SMTP id d75a77b69052e-4b2ea694690mr119133841cf.36.1756454996508;
        Fri, 29 Aug 2025 01:09:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc52esm451242e87.8.2025.08.29.01.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:09:55 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:09:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, jic23@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V7 0/5] Add support for QCOM SPMI PMIC5 Gen3 ADC
Message-ID: <zgm2k2osmasdal6anba66pw24a7fiypgwlf3c36kvteshz7uef@wee4had7x54u>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250829-demonic-soft-guppy-512c13@kuoka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-demonic-soft-guppy-512c13@kuoka>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDAzMyBTYWx0ZWRfX9wmk6YW7ohKy
 Pid6oNRrKyqn4+nVc+TtV7jsvn4m6ig6P78hWIQWqLSBnF66Lq89zL7R+aUuPb/2Px1cNyLPQQo
 e0JA4dDa3iSQCZ3u+cSprRbwD4wfGY8HWy78rafdFONvgOXUfzA0SvcUWRzDGZjJYJG9ExmSZ2w
 IzctKNGhPlXIMpjpYTMSnB+IYgdB+eBBEEt1aKTO7P8+hum0gF5lClfEt2DkprdMAmR2akWeNpA
 8CYc10uqq+K7x+eAI2l96N1aLcobnBfIfhJNt3DgLaW0gbehT7QLtYFusP0Hj35VxHhG5ajJL1N
 UMH2m4qHGhol3Wd24mYwMEBF/+sWPMUhtKY6p2W3yuK0zOoiVuPe6y03Cjyjh8Xo4SwWaMEXRMI
 zXM5v/52
X-Proofpoint-ORIG-GUID: jiEMrnegkMVKrc20ziYhXg22hlSJoqbR
X-Authority-Analysis: v=2.4 cv=PYL/hjhd c=1 sm=1 tr=0 ts=68b16056 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrI73Fic2Yz_lu5inCMA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: jiEMrnegkMVKrc20ziYhXg22hlSJoqbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290033

On Fri, Aug 29, 2025 at 09:12:59AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Aug 26, 2025 at 02:06:52PM +0530, Jishnu Prakash wrote:
> >  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
> >  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> >  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
> >  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
> >  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
> >  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
> >  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (78%)
> >  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> > 
> > 
> > base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
> 
> What's the base commit?
> 
> git show 0f4c93f7eb861acab537dbe94441817a270537bf
> fatal: bad object 0f4c93f7eb861acab537dbe94441817a270537bf

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250822&id=0f4c93f7eb861acab537dbe94441817a270537bf

> 
> 
> b4 diff fails here, so you are not making this process easier for us.
> 
> b4 diff '20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com'
> Grabbing thread from lore.kernel.org/all/20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com/t.mbox.gz
> Checking for older revisions
> Grabbing search results from lore.kernel.org
>   Added from v6: 6 patches
> ---
> Analyzing 53 messages in the thread
> Preparing fake-am for v6: dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
> ERROR: Could not fake-am version v6
> ---
> Could not create fake-am range for lower series v6
> 
> > 

-- 
With best wishes
Dmitry

