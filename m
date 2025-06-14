Return-Path: <linux-pm+bounces-28720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB01AAD9F18
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B6C174601
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7BE2E62C8;
	Sat, 14 Jun 2025 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4BOk5zd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E92E2F00
	for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749926581; cv=none; b=jELnjY3c8S2QLgyKLE+Jjp4C+ERfAvxcn4klIpRbwnCJY+38jxPL1WYNzADjcMQUDzgRBrLP/4CtW/f26EF51iHfRPHwkabav/8YJD7tXKgW0Nm5T5VlZzXl5eamzhMjcU6p4hQ0G7FlaX1X57KA3bGB3E1L7g4eOdjXCfqljDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749926581; c=relaxed/simple;
	bh=s6E01uA7mvRz1DP/q5h1Kgs+cAsIQRRJGrCjFTML+PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YauQbRbyzPGxj3VNUbRsfv7UQwOVuNE18HyyIK4ZeDyV2PDvxbeI42vWVsmaS1R8KVvh87fnuG2dpUK5jJyUWTGkvXvt49jcHQN5KosV0oB2sr47dxFKjThkk1fvCEsGj6EG3HCn4P/u4Htle/I7khkHnhXin3szHTOVF8Wsae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4BOk5zd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55EHfnUI002336
	for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 18:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iLwHJ8QhRIGYKyF4YaLlo9Wwe+HrqcTZDg4UUvCSfuU=; b=E4BOk5zds0DrD8NF
	shEEzA0umYdl0+l2QQoDtHcBw3muKjC9CdF0eGWK2JNLFxH+WubblyadPNBhyJDt
	pdj9Gee4bbCTyNCIlObEgpXkd7ae/0BTqpnVCZO3Lfg+SK3uhS8vvoWziYgusxa+
	AuIiZnsYaItRG+Bt+CubgkgVNA5IuJUqElDU9TdWnFjjt3Ay5s+kVdp3iQefFfX4
	NqnCqEKE6ZAA6hwZMQRhN948mAJzLL9KTH6DGyLD3iCANdTsO0kLGUGTATNwArcs
	AuVbw/3v8ac2hLPzkgBQSO6Z3HDhsqFdkZOOOmUYkmgR13zR9ZbL9JPWArBm5Qjs
	vN4WOg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928m8uev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 18:42:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a5832bdd8dso6732681cf.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 11:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749926577; x=1750531377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLwHJ8QhRIGYKyF4YaLlo9Wwe+HrqcTZDg4UUvCSfuU=;
        b=wS/rKPGD53Tn3mVz/JTPDKnyvBW/BcDL27HiSVfhRyanhD5m/rvAOHPvWLXr9UqHPK
         s6AMVzndcNZjYi9TEoEdq4kA5SPi06f+tDG623gOKxngxRNEYksVjCNDMM8wxR2hZ8SP
         SGEat6h48/8yEPZSl7NHKY3xHbbNB3DUNjNErLHRyk2viC8aZn071+MabovNQJqa2F7m
         7v8L0+BoCd8aSPT27CLCUZ0hfV/8YwUKqEC2Ouz8GsKELySbd2Aoc9bGZXWF2AGkhbZV
         4iX/0rm6YhrWmu6HVf6+sRgXvXWs25gmFpMWDbVJlns8H5Tb5/xyS4s2/0rKkZlNJH2t
         VmWw==
X-Forwarded-Encrypted: i=1; AJvYcCWa0KFIt+pjXBlUT1gXFadCNVNrhLTcAj2CXUuHMZySj/Rq6J51Sogo3TPHCnwSdMF5+aFimFsZrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPojzzZvycta3CK0bdICcXE2svd1Hu4FpyGdv9ieE74Dp0Pgph
	oBISsQx3pTpUzi+q6r56e6dfCvIifOEYt/DOSnJUuGBeX5vc5bJwftjWN5DsFIIdvvGtnBg2I02
	Cxzktur/ivmx8UF3d6KwseqUA69JhlewR4G59SfWvdCGDeAc7sKNKbBkYhvc2IA==
X-Gm-Gg: ASbGncv3py5vG5VfC2BAPjXiRzY7WzKkBNLHPtVRrt1V+veAeBEOWbUf8UGsJUUgNzd
	+cfpkBU75zHh3N7e4UMsh1f2KYpPi6Teaiq6/w0lBqxis4Ug5jhA4+nIE75v0dAnxRxvxUnqi5h
	c/aQxjZocWaRL/pzh3oVJmVIn9SDKnJpW3K4j5N7G5jLv8JJuIsSBfHN2inbH2Z99QtEENq7qVu
	1KxgtcGyVfV34dGkKzAWHKkzA8g0XMvK5gp1MhpGm9NietUcp5n5hr56dOEJ5kLkfIT6ZQ/MCrl
	/0ntOqhFUnf2uUnXI1/axIuEr+zOi0ezzBoYod5vIz+KeUDkuaHk30C5H57+5ZCJxEq82sPwwYS
	mCWs=
X-Received: by 2002:ac8:5d0f:0:b0:4a6:f809:85d6 with SMTP id d75a77b69052e-4a73c568fd6mr22439041cf.4.1749926577338;
        Sat, 14 Jun 2025 11:42:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkYi18BH9yEJbdfQSZZnPYYS236AqGcoTRf5C7tWQLhoDTwPCEtKNQkvCzqxnaF0WVubY/jQ==
X-Received: by 2002:ac8:5d0f:0:b0:4a6:f809:85d6 with SMTP id d75a77b69052e-4a73c568fd6mr22438731cf.4.1749926576868;
        Sat, 14 Jun 2025 11:42:56 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6090063ff9asm293673a12.21.2025.06.14.11.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 11:42:56 -0700 (PDT)
Message-ID: <29f1de05-0e55-42b2-9bf3-894bf4f07808@oss.qualcomm.com>
Date: Sat, 14 Jun 2025 20:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Support for Adreno X1-45 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com>
 <0e6fd97d-9a56-426b-8b98-dc8aa50d02d2@oldschoolsolutions.biz>
 <036e739c-54e4-4252-b6f0-c8eed5557d15@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <036e739c-54e4-4252-b6f0-c8eed5557d15@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE0MDE1NyBTYWx0ZWRfX8dqXQNs5LJls
 D4F/fcQEl0YTpZeIVfcFD74VQgdt4ZAEHMNPLiMix9TdTWLtEjJ73rMDF0TDaaV9YZwj8LgGEwr
 exWVCP6V+CvNi3R6GKoJOB4bFjSSzvXeaA2/jojxOnWUkb5f4T39zX9lO5eWvxWLxioCHETcR0N
 RNrHlcgGXrwUumKeHqagnCFphLuhBKJ5gOSfHM5+NQozgGtdEAqdMpTsEVw3FFli8KTxbV/wbGA
 QSUmLhSMYpREWEQof1iriDW/65kl3X6QQgVr4mSoL3ApJhJ8Z6tW4Pl6+GiEmNh/oTKb6YQoe1d
 qwGOPziuNMKpynOS8L0fX35mHmNGmJKF0JP+ZUK9ZcXovTPHtN4E3QV4hrBJU0OzgZpMsjzmRgY
 gUojDJrvRo/ztm8O0eHBeYXgK5bBXx1hbw/z8WCRA71r4tnT8c7OBZ5ljMJyMgssjrne2YiM
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=684dc2b2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=phG8Y4mLfM-ETw-KuG4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: g9z05HGoulPx5HK0d-MLZfz7EOO5sX7P
X-Proofpoint-ORIG-GUID: g9z05HGoulPx5HK0d-MLZfz7EOO5sX7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-14_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506140157

On 6/12/25 11:19 PM, Akhil P Oommen wrote:
> On 6/12/2025 5:32 PM, Jens Glathe wrote:
>> On 6/11/25 13:15, Akhil P Oommen wrote:
>>
>>> Add support for X1-45 GPU found in X1P41200 chipset (8 cpu core
>>> version). X1-45 is a smaller version of X1-85 with lower core count and
>>> smaller memories. From UMD perspective, this is similar to "FD735"
>>> present in Mesa.
>>>
>> Hi Akhil,
>>
>> when loading the driver (still without firmware files) I'm getting a
>> speedbin warning:
>>
>> [    3.318341] adreno 3d00000.gpu: [drm:a6xx_gpu_init [msm]] *ERROR*
>> missing support for speed-bin: 233. Some OPPs may not be supported by
>> hardware
>>
>> I've seen that there is a table for speed bins, this one is not there.
>> Tested on a Lenovo ThinkBook 16 G7 QOY.
> 
> Hi Jens,
> 
> Could you please try the below patch?
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 2db748ce7df5..7748f92919b8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1510,7 +1510,8 @@ static const struct adreno_info a7xx_gpus[] = {
>                         { 0,   0 },
>                         { 294, 1 },
>                         { 263, 2 },
> -                       { 141, 3 },
> +                       { 233, 3 },
> +                       { 141, 4 },
>                 ),
>         }
>  };
> 
> With this, you should see 1107Mhz as the GPU Fmax.

I see your dt entry takes care of bins 0..=4.. this oversight worries
me a bit - are these values above (post change) all in sync with what
you entered into DT?

I'm not saying they necessarily aren't, but I want to avoid
inconsistencies

Konrad

