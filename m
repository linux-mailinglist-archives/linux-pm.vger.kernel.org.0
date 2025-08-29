Return-Path: <linux-pm+bounces-33401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33845B3B710
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 11:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FBF5E5A7F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 09:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4A3043D5;
	Fri, 29 Aug 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DRyib/iq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D226302776
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459254; cv=none; b=SN1HHbE4YpxnsqsoOHbg0cPcVT5LHUdRKGEk0/LYXDvHI5LI0ssisdCjnKeBQe4c9ngAKvaUkXkb/7DCb5ESQW/TYoXgx3c8XtrW0mdllwj78KBtnVp8yQVDNQdpr34VcPieVPxgIxxdLLV9cAe0lwSXVNvhwHMCaH41AC5oYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459254; c=relaxed/simple;
	bh=41cPbZW2JuUamvHD0ni/4zW5qEt98VIFHzay0uJyE64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIwgxM6F0MOSPsmtv6Qdwcq7vbF66mXdEUsNfkHG6jtSg7PrBwWr+vYO4EMUl/UbuvPh23mz9RypUxUI6c0xYL1DJs56hlMAUG+/cThVXKyftev/TxncyXZ4qwU6c3oTowyRbos+Lb1W4k14obiLoAdUoGcSGF8mRbiUokFVm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DRyib/iq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85LJh008794
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 09:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VsGRi9TWtut80xRESvMijlEz
	Jj+9BIG8rviOsUN+Q2w=; b=DRyib/iqMVUgY+4U2/xa1PZEfrNYqH+CO6TheLAM
	f754gQa0ypq9f/ZcukNVmys08FJn+FxHy1J22okyW5Sb8nIUWpHGAjLDQoBaSNyz
	Kv/+IfVKWqKJMBfn2XtQMUIC/lj1JBTbjMudKe/c0HfCVJCrclLXhYwxIr44m4Sy
	cyyl3s1k3F+H47dD7qF4OHNWDkXq3KGkP/uj15XGoBit9PPFJSTpwnYbaJlP+Kqv
	TpVVCx8N0k0FHJGoSYDC7Xk6lJVFiZklYyvXo6qOCXfbynPAjcT0VUMuqqPmfOhS
	Ze80Ap2WaPsTEU6KQ1IeVoOdZPDjKLV2RztEoLrPWKEMYg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5up39us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 09:20:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b29cdc7417so39929881cf.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 02:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756459249; x=1757064049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsGRi9TWtut80xRESvMijlEzJj+9BIG8rviOsUN+Q2w=;
        b=LVSfFSu+4iOBybY3cMqmTVPFjUo5sDy5gKAt2EL0mzFkyi/+Fv1wXGd/j3Qw2vwi6j
         tTIHa81/prmat3Fgr7rgx0Px6DTBLtjfqlnA8HnghskNT+ebNqQGPkTeeGg57RcGNa9B
         NF/qMcRxuw2CVMGk9bjV3A1+MTPJrqW051d09jexoJlUUmxJzh4260aPIYJRLsaP8eg6
         10Vq1A+nPqgujxbGS4tZLtxkZCUwlDCUGhhBu5K32+MTuna1eo6APJJBqedioZjmSxFN
         /KU9DxabOMhOMY8iJ7Z4V8q8l7HnYbkBxDB4gkXRXeBTvt9jdu4g/SOeRphFPqcHkHZQ
         GqVg==
X-Forwarded-Encrypted: i=1; AJvYcCXLb0e5xnBRhbcFuupSahmoHW4ti7Wnpd+Sme3uMj0JCgYke0+bKFYEee9VQJa11O/2R2FxXYJJcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/fk16fUqod7UcfiGL0efSk4fLKEtm8+rgZ4Ff9SoVnbMZ2Y6
	DZqeleyEwtFWp2dR3fVPrqQzGyXeHlKX7iqo1+CljXmKv7lrHv/p/vxn5lyJHVROlZD0Ccl/Y0t
	nPAgr/UebOL2XGF/6AtEzomsnS1pMcvKtSt+PfucKcZDUQVniyWs8kdJeQ5fhuQ==
X-Gm-Gg: ASbGncuht0sk7oABv9Y3LO6X3jClgusHlF+btX2Kz9rrsgQEO7waPxQnMFjtdf+o+K3
	XjZcfX7e99kp2ZSy1Nef0v5pcsUJjoADHQmqSaUY+9mCGkkttRHUK29RlA+UwKLgfdneeaErc4v
	Rtm51WL3pKjUQsgPZRrDYHi5uiJSm01LGGTvxH+fa/By51P5Rqgko/iUeI4wDxd3Dzv/5YkiiC8
	A7z+zh/b7NtUNZ1+Z2nU4ABj9ZbnUW1CqaueTc/lGO1z7rFs+X8Wo6cZ85c+x/cEVA96Ne1Izax
	FsqWpeOprAVq5mo8H99CwO+P4GJ3g4nCC/0rbn7fUNO8/qWv/pbUkiXtum30K1FpwSCeJRuCsR4
	hhvjMsVNUDHfx0JyWLDnHEQtTT7PsOXA/n35+HcKc2ug+fAOkpRU5
X-Received: by 2002:ad4:5ce4:0:b0:70d:d5eb:cb09 with SMTP id 6a1803df08f44-70dd5ebccafmr134046186d6.20.1756459249012;
        Fri, 29 Aug 2025 02:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu+l8+GZuUy+NaTPLiPmyXfppCCrSzXfTWjiiARcq2CiwkxvRqPIvCjYJyzT2ulw8LGLrwHQ==
X-Received: by 2002:ad4:5ce4:0:b0:70d:d5eb:cb09 with SMTP id 6a1803df08f44-70dd5ebccafmr134046086d6.20.1756459248542;
        Fri, 29 Aug 2025 02:20:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336b9462e97sm2472451fa.11.2025.08.29.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:20:47 -0700 (PDT)
Date: Fri, 29 Aug 2025 12:20:45 +0300
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
Message-ID: <nsyhau4pnn2nbxdf35npwq4gvjiphocrftrwi4seirxqzurww6@6jgyzzmjyg7q>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250829-demonic-soft-guppy-512c13@kuoka>
 <zgm2k2osmasdal6anba66pw24a7fiypgwlf3c36kvteshz7uef@wee4had7x54u>
 <8fdc99b6-4ad2-4a08-9dca-6289c8fdddd6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fdc99b6-4ad2-4a08-9dca-6289c8fdddd6@linaro.org>
X-Proofpoint-GUID: LiKSrgZPWYGuGxddx5nrcTcCPyCa4lVb
X-Proofpoint-ORIG-GUID: LiKSrgZPWYGuGxddx5nrcTcCPyCa4lVb
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b170f2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=cXZZpXjwJqeueyEXUCgA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX8YzN7do92Eii
 gUzRfPOUJV089lAy5tQ6onj0pERAdUSwB63B1zv2adcGCH5nSPXXJHONnCnI6FzWcu2H596J2E7
 4uPkF0tFwIlGkBHS9bTGNfycy7pLIRPMDh0hewLQIGEOyT0ikoaLAYi6iV6HEkjiKqZKxjcO9jf
 9sCyub179V/Me8s/6htZ4zBXIzNc6lSJfyNJu8pfxlPbPbvFXFUq4KZX3xXJSYa5W2RAcPO9LFI
 MxVeY5IcHezhODlS5nFPZygWUGIP7MkhW/SYanYofDabVFQq3Rx9/041g8SXh7+oGRjB/LlDJG6
 ftea0xwkSgov5zAOiD4olLP+SQ+7cv+Ky2W9+NqAYszU3GfeK/aajkkHllOG5qTyKL+L+HjYPcX
 EpW04Dnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

On Fri, Aug 29, 2025 at 11:11:48AM +0200, Krzysztof Kozlowski wrote:
> On 29/08/2025 10:09, Dmitry Baryshkov wrote:
> > On Fri, Aug 29, 2025 at 09:12:59AM +0200, Krzysztof Kozlowski wrote:
> >> On Tue, Aug 26, 2025 at 02:06:52PM +0530, Jishnu Prakash wrote:
> >>>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
> >>>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
> >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
> >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
> >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
> >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (78%)
> >>>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> >>>
> >>>
> >>> base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
> >>
> >> What's the base commit?
> >>
> >> git show 0f4c93f7eb861acab537dbe94441817a270537bf
> >> fatal: bad object 0f4c93f7eb861acab537dbe94441817a270537bf
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250822&id=0f4c93f7eb861acab537dbe94441817a270537bf
> 
> I see:
> "Notice: this object is not reachable from any branch."
> 
> I guess you think this is 20250822?

Well, it kinda is. It's a commit by Stephen, it has proper contents,
etc.  next-20250822 is not a branch, but a tag, that's why you observe
the warning from gitweb. You can verify it yourself by manually pulling
the tag from the repo.

-- 
With best wishes
Dmitry

