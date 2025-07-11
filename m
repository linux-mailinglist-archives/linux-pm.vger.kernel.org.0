Return-Path: <linux-pm+bounces-30671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FACAB0187B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 11:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B2D1CA5547
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 09:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CCD252292;
	Fri, 11 Jul 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgVQh/tN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28027C14B
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226929; cv=none; b=h0l+mLuk1aBJjDIrUfskG9pqNGX4lypfREgiuA3KyqAHuevdxabx1qTTHB9WKTRfcdDkEzYJR22TvZoBM82XB12LHFFypCuQu0uY4sxSWjctOPKkOog1BE6ENoqVdVAKmhdwuUETmHKeHmnVWiq5Y74wFXENUt5xXLcrXuFzob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226929; c=relaxed/simple;
	bh=M2ee21tTcdsIhrvWz0enz8WOXTUstDicdOJtOioNZJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaKZdXWCyHfmeheNLnYjoXYP3pXjQJ8YMuGlDR6rQEdnKuSoNuprPs/2gs66P1QV/14uyt4MQkuNDQB/XERld1ttgzacuSKQ3rRXgPa8dAR5J4W8igTq58/ZICfvl3Xl4PYPYAUQShJyHxQPUwqAp9UPVV6uYwchUWjcQoIdTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgVQh/tN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X7pn029971
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 09:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DxT8qv3JdcwWqLEg3mZXR/RdYNSUZ8uyVo3R4Z/tvhs=; b=RgVQh/tNjms3uI7z
	63p1hdceWw6IiyfpnHMNR2wEz58iZxlfPrE+fOFFgKbDH+COY5G9CAFC3ZAVeWMI
	ovkQBlzrvMivlOyRcHpXYgMkPvsh7wSiX+KsP+p7o29SYSaNKY5/bt0yfwY2fp+j
	5IKjudO5W2mCLJBHkVWinQ3CQ7o7z0GXKmBot6gvU2h6T/REI1CzNUcPUccspwRR
	mgFAUDfAb99S1Iuv7arMR4hd0iCrfTV5Exe7YkCJjU4sS9HCZnJoL9Ixekmr/eLA
	0sj9wkzwFDOubNnkSe+zCR2C65Wtk1wu5Dww/IzvwpthG4jYBzZezhjmKLo8q219
	2TVGfA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smber57w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 09:42:06 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f539358795so4945726d6.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 02:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752226925; x=1752831725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxT8qv3JdcwWqLEg3mZXR/RdYNSUZ8uyVo3R4Z/tvhs=;
        b=kIybI7tk/BUD8TyFXwrO0Rtbelw1r4cI9gMjql69NMCWLz5HUCOcZFVoPCJXDmH1gd
         h1VnWewQ0vCs0yafy8TBxxNboDaOE0dUXLO3j3r+rlL/JdCEOKTPoSJsJQhwsC0kFZ3c
         jOiFUzpUzIVqX0lmGJqPWWdstai35nQiuY1F6uOu+zUp0+x+V0/Yfq35beJ8uQo2ZJqp
         kSffyhgVDZvjI6z+KeXbjC9/3GmE2Nqv7vjHDxaXtqqLej5IUK9WIAnjrwFBdjyynOfx
         aL7qlBy6JbIzOBiRXmNFqUcD2zf9utGwXkLwd1aX8dx4v3/eYPebD8Ie5Eq6FF7enE/u
         ZUJA==
X-Forwarded-Encrypted: i=1; AJvYcCW3BITcsLjueCM6I7bAolaAmicZ6VJ61Mn0Nf0SMGRc4PwmYn4FzW2nCACnRZEhbt4zPHCZTZo24g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbN42v5lvFSQSN55arXjLD7QrRY7XVvUFC6KI7YFOyexr4AwfP
	8Wf7A4qOXZEgCaa1Z0pdQtgIgFpDuM19lJD5XIbf68RkIRnjeIyobCIQ40rMVuN2uyrlw2288+b
	YA4T1PA+Mn2JIQzVtkyWka5AvJSPCh18fLmEYROO8B3WbN19zXBAomBFtVpTJ8w==
X-Gm-Gg: ASbGncvrt6J16qaxEZalzOZs34ScNY7Sg4aWeEfYjWmZcmuhbJ836Jlb8tv4LoHpZi1
	c3T5cqAkopJbGBaadC2y7kjtffiO42jGZ8HX5sITrdcWfKdWQlp9Dud757BEvBfTqq321PoMdGu
	WvOzG+J5W+Fp/YQsvJmaHxvhk0grdWREUmuBC2ApjuHcfglMZEmJ7lrk22fbKl4iyFjJ2/Ne0WN
	FzVpakSUyN29p92Q7X+cQNx1eslnMnJXzPdbZGlh2TKIdi7KK8BIGlaMiu2yTLHHYpduMM3SQHf
	9CeSos+ElMDMBsd4NFhh3C4SlDedxgANsISz5w7MhJU9UrHif1Mu5L7Z/taKaGIYEbw9SF8ZbEB
	UrzyOPBTGqsz7piRyRdkL
X-Received: by 2002:a05:622a:652:b0:48a:80e5:72be with SMTP id d75a77b69052e-4aa35cb1dd9mr12074251cf.2.1752226925474;
        Fri, 11 Jul 2025 02:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ+ry7T+rYf9AJ1NPwASKa3NBXW4kgR6/+yGXRVJ8wsFukrBio5hDeZn/edxK6s4hKKR64tA==
X-Received: by 2002:a05:622a:652:b0:48a:80e5:72be with SMTP id d75a77b69052e-4aa35cb1dd9mr12074091cf.2.1752226924908;
        Fri, 11 Jul 2025 02:42:04 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90a07sm269371866b.6.2025.07.11.02.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 02:42:04 -0700 (PDT)
Message-ID: <e358b93e-cdc2-48f7-b52e-b6560e8e5ff1@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 11:42:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/thermal/qcom/lmh: Fix incorrect error message
To: Sumeet Pawnikar <sumeet4linux@gmail.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250710175426.5789-1-sumeet4linux@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710175426.5789-1-sumeet4linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA2OCBTYWx0ZWRfX6FGg/BuKDsWc
 WnDYz8beB64CjuHbg4UyPReQBUSbd2Xgrb1Iig3QddgE1j6M6eOrBSTgf0/9bjqfQuhUjhqxHfJ
 SuhMPTte9DMe4eisSnsuZxHPN/qAL9N71t+fyl5POK7ItccyNDTYuFWqlPggw0/+v0dusFcYTuW
 pkwXNWoIgsx7ZrRjcEz/zBBkvE2Bn/IcDxD6cS3shVhp35LYM6rtP03feeh1NLj9hO64OTn3hzD
 9GRAM+dHadkX4MLW2/Hq9PfK+JZpSHP8/PmyYxD/hBAW2+uGB7EeiX59fCjwNB33qDOzO3y6v0s
 3vdgvXaLGmMODsIpzbEFmtnHMDUDlJnHZynRPEBMstZXFM/i0oBVHWpe++5b+DCosIn1wnmjCSl
 hU95oGgOEjhak9qhiDFL+xmeN5Ehvw6D8X7GP6g/jNhjO+GRWHvdHxzSBDpn4HnTfHFg0HiD
X-Proofpoint-GUID: AK9Cb8cfGzSOrvEHJouBLKmYDIWRen3L
X-Proofpoint-ORIG-GUID: AK9Cb8cfGzSOrvEHJouBLKmYDIWRen3L
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=6870dc6e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=3Ok3IA0u0twTkz7lZ6EA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110068

On 7/10/25 7:54 PM, Sumeet Pawnikar wrote:
> It was showing wrong error message as ARM threshold
> thremal trip for setting LOW threshold thermal trip.
> Fix this incorrect error message for setting LOW
> threshold thermal trip.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---

Thanks for noticing

For future patches, please wrap your comment messages at 72
characters, so they look less squished (you don't need to do
anything for this one) 

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

