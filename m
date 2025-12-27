Return-Path: <linux-pm+bounces-39969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8488BCDFFEB
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 18:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C4BC300C8F8
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9421A459;
	Sat, 27 Dec 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MV5PuPi3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ArTNYPl0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045523254AD
	for <linux-pm@vger.kernel.org>; Sat, 27 Dec 2025 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855111; cv=none; b=WbsRadYhY+nHXUdUH7eHEvRMHW5PCZjYPH37VFbaIhSppMhUPxpzOyVDzyTWdDW3uN2sKd/Q01CSQ3RDEOC91dr1qt2LX8OW9crPmkekDSO95jI7ILnnnHNaICW8qL1vLOSBlv9u03J5cfuZZcfw0b2GDM+kkBfc9VS5n4JLKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855111; c=relaxed/simple;
	bh=MS9vLUY5ntaeZEme31BM++oWeE6wEUHUNjD0o/tN8lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pywPyXNtiyQqJhX+wKho0Ie8MbpRnp2ENnJGoCkNe3kjp6xCChIlIWY6naGvCkaTfZQkwv0oE44ZFahwhiHbtXdDvQsELQ1+8ejCSDdv1JcJBHtrnUbFcUWEvlOA6VUzhJbiXe3XLivGErNinzF2qvsi2b2ISqZyj3Yh+QNy5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MV5PuPi3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ArTNYPl0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BR6kSFe3610714
	for <linux-pm@vger.kernel.org>; Sat, 27 Dec 2025 17:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Oh/6k7T4U0Rm5ZzbG+CXXR8JXY/6vqOtJhEadyO4Tw=; b=MV5PuPi39RVmd5OU
	D21hZnZtyLtG6DudjaTQtaaXKmHaNmi072SNxd5M/vg/iTtuVwIfBcTA1u1YmX98
	u0PKk2yOOvIEZZqX2u9OQl7K3paB0WHYD2zo3W73H6qi649f0bTdLa+nHOQYXplJ
	w2i1j/Uky0F0c0MQ70sZMmEJozZ+uHoEveWSQPtaXHCS8A+68FHRT+SoVjkyjybt
	gE11IaM3XncmS9rU9sbUeZAWzQo5PhnQJ/uq02yEC0YL9nrC1oldZG/WeYz+mQUP
	ZQFLkhmdmvgPcGjz9Xfu4eEx+0OekNS/09+g6Z1Jg/LGRzlgc11EQBcqU41EAU7X
	NIytyg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7hs8uvs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 27 Dec 2025 17:05:03 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-93f568048ccso7581700241.2
        for <linux-pm@vger.kernel.org>; Sat, 27 Dec 2025 09:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766855103; x=1767459903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Oh/6k7T4U0Rm5ZzbG+CXXR8JXY/6vqOtJhEadyO4Tw=;
        b=ArTNYPl0NFa+jsHadRDDq/zS9DTrJ7JaeTl5Uz+MWq68bO/nZ7lQpOM/+IC71m6+7+
         olewnENVeBo1j0f+3hyLEEjrFac/bXBfKP/8ZheMcQlT/JX1AAVEWbb3WSiDLIcG2D6F
         yGUZDw9dXkQ0f5UZX1KRki6OEwb10p/xYowwp1+6gKDzvJd1fJ2c9rBKppUDMEMct2kt
         xko0GZM9x74RYECGR8ScCYNQojlq0bqX6LPjQjR9TpjuoU//qmiN7S4V/VlsqeHc+z48
         6aUhufRojZEDn96WS6ejrzFrNANrsVTLOa1k9YJ9QoeUM0109dxIIPZtwGuRNWcjMBsT
         qUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766855103; x=1767459903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Oh/6k7T4U0Rm5ZzbG+CXXR8JXY/6vqOtJhEadyO4Tw=;
        b=rwlVJSV3A6daNmngkNkY8gRxi4c9IZBuVFAjtJVnrB5tRgkwcFJmbn+Wd4pUSSuaTx
         wVEebzRAJ6gSk7mvSh51xPVPQY4b02rlqx7dmq2mIM7zhfwiC1BIUDjJBLnNswkgYqwx
         lffS6VsyZcf/yHAC6wo0Xz6m1H3wTjlutemqblUe5aWbNCXyveiECGOu6gpxZiLps//c
         y13ylCGuKhJ6K+zx0YgaY/jIJEtcs3Ei6dfE0S/VvGxndtI38FHYKPSdjUHMLurW8Ms1
         mg+XaIF/mFjBjF7mGIPdQdGZjndcJ5y00YKz0q9DYD4VZ10szNhf7le5dDeTe3BO6oj3
         DOVA==
X-Forwarded-Encrypted: i=1; AJvYcCXURyGdNDT9sdLhvyC5+IX6IvVY9bf27x573QMCwKsuN3oreIk2NwRFdx2bQjWnp438W3gEjCiqWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGMn1I/kC63xmDFV/rnBUG2FgnSdAcTDiiYoqjIQcatIvWxyDb
	PPeaztp51tWh6Zaqc/EA+HRpTzjlDrZZCsPfn/4WpY+oNd6rU63XpNvbpvtnRrETSjmBd9gto0C
	kaAQExcbwAr1d7K9W4Ar15DqI3UPzULD5amHB11rBciU+bAsSgkSIeuyUxwRz4g==
X-Gm-Gg: AY/fxX7hGHSJHtLnaANdu+4nFgHno16vbSbeXH1Hg7Cthp1uhK4jO0BRcFhqyR1SF/U
	V1JttKSS7L2Rm5GZegSa36b5/Kh5XeLc6s/GH8IFBo9ENrc8myMrlZb/+dblK6eEvP6UPHCZK2v
	evuxZFqDwVPS2GCm6cN0vXS7UNBr30f/C6ICilGOwPersyMSUe20hlAOAjjbDlASOdh8kJYscXc
	ZZX4RnLY3FKYVrNWGPxPOeIAHxwrcXo5He0gC8z8YYTJMvm6bIFZp2I2NODiawdUNrCoJFG3i8K
	khR3gXPBeuODSxb1gUhzKVDiGOgLU4pe/2UNMn+6jWIT3v9G01hcq1Y2hkpU3p7gI0ykO2PlWBm
	3zPfzibKQ3zNZf4k4rQQoTzwvG6SWw63Yks+9L+Zqql+QmdmJalrBIiWTThpzg3e2b+QYuTtudF
	RHV70QhCwTF13dpROZ987iOt0=
X-Received: by 2002:a05:6102:c4f:b0:5db:cc92:26e7 with SMTP id ada2fe7eead31-5eb1a853c12mr7702925137.38.1766855102562;
        Sat, 27 Dec 2025 09:05:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwkyznsZy9VLF3+rmshKCzvJdz1PTVNzfgXQXNYlm28+ki8EXPxlEy7ZyW8U3oJli0ER/zbA==
X-Received: by 2002:a05:6102:c4f:b0:5db:cc92:26e7 with SMTP id ada2fe7eead31-5eb1a853c12mr7702916137.38.1766855102117;
        Sat, 27 Dec 2025 09:05:02 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381224de719sm68420111fa.8.2025.12.27.09.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:05:01 -0800 (PST)
Date: Sat, 27 Dec 2025 19:04:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org, konradybcio@kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        ulf.hansson@linaro.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: dts: switch to RPMPD_* indices
Message-ID: <cbibz5cli5lk7wmzfzuek3rnil3xykx4ucdblonsyellochu5t@nuw6ij37ftiw>
References: <CAGsSOWWMO8+8vB2EM8s1=hyN1raO6TDpqGBTdrmNrZpfDfn5wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsSOWWMO8+8vB2EM8s1=hyN1raO6TDpqGBTdrmNrZpfDfn5wQ@mail.gmail.com>
X-Proofpoint-GUID: Cw6Zceprcw-SGWslzgfMOmakry1BdKIB
X-Authority-Analysis: v=2.4 cv=O4o0fR9W c=1 sm=1 tr=0 ts=695011bf cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=MN_lGMKq_FOr7paQGrQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=Qmqj-zlutpIA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: Cw6Zceprcw-SGWslzgfMOmakry1BdKIB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI3MDE2MSBTYWx0ZWRfX0W2zBNQrqBc8
 4T8C47Xi+/DUuQ8n27+qjkV5sClDNCx9NJuTwp166wamMoTxwe8Yte+HxZgP12597S6nnrMrr1W
 K+IHq74rhdJiP7m7Dn24u6GdA0osHRaZsSBRFEQxHh2Y6Hpc9jPt9qhuxayKyK/BhE4Gz69vtQV
 GONN3v0xj3shH6lq+zJd6dwbAsgaUuQL85vfDFhMyYUYa2rcw32FRXCWffA9QJ37xqI205csouL
 G7a6y3IzJwXJ4UD/cJjuB9rRzgGVw8Ji1fLVX7N4wfACQ428VeYp/Lf9uTkN23b3DVte3GsP6a4
 bQ0iUCixVF3MlQWZpKT9lDSsKl2890JUCQQ60d9nfoLONYeGTrqLDbmJybyQ1ENNY/HsCwAMvX6
 9tXM8aX1hXR12Dz2h8tUkgIKDey3YBQAvQ03cx8cu8zMcfkNNd74voLS3FFEq4l0oP3MTlAzf0N
 5IDkU22zidly5N8HsqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-27_04,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512270161

On Sat, Dec 27, 2025 at 05:53:18PM +0100, Barnabás Czémán wrote:
> Hi,
> 
> MSM8937 and MSM8917 MSS would need more power domains like MSM8939 and MSM8953.
> I am planning to send modem related changes soon what are interfering
> with this change.
> 
> https://github.com/barni2000/linux/commit/21151cb3d07124897e4d3dad51c833c4af27f6e0

Please extend the RPMPD_ enumeration, adding VDDMD.

> Shawn
> 
> Br,
> Barnabas

-- 
With best wishes
Dmitry

