Return-Path: <linux-pm+bounces-37371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78565C31C69
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 16:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2FD1883A09
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024D0246781;
	Tue,  4 Nov 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LKlOWff2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ddpGVpLL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F50221FA0
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269155; cv=none; b=bRnkBBQQH0ugvbC+YzWImjzbSNtywe9+RYXi6llGT18cbKt9YrWsdtKrnJLZw1b05xVlWfSgrjjSitsKqIpMfM8MuH7kwIBZ/yCKAnqMpiFmR/4uAATN2Pf+muwz5JiCKKxhDQk8MNh4yx07tI/xySfliLwUVHHqpX911ZCn9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269155; c=relaxed/simple;
	bh=YnR8Xk+rfrjWIKNCC383O/sBECGfsEHElNmg1wrLO5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHRobOk94DlkMx1dDCY4/R1WFehYYKN+7TXQuFG3VcNH3oYRQd4ZAdVY3CkKiUNyTXs44vwLjxRAa2S3magCuw1IvqzNq4Q89bl/HKMvIdyuxXeQkSws5IRt61eRxRVP/bJbgJtIL1QzweuKPrNcK3xfRz1LznKwJm6RfcoYe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LKlOWff2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ddpGVpLL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CfwWN2099127
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 15:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+vqopIC4yJDbwil1oh8vhhREvmrvyN/FTdfpv/O18o4=; b=LKlOWff2vhMIj3/s
	c4XOGFbVqGWEDlYaxrxh4BfCKXKahFJIYvlwsxxAuXVulQul8aZppuC1wps3QzXM
	pqWxDQsMr3HWDvb3Q1Vn6I/t2WauP0hO8085kcaUXrIc51HcDj43sbux1O1lCFwG
	G9UvE6tcnzBB0UWHlpggLRSpPJg3UtGkz5grOHWGI0l6Hnhw2uujF3AuU/0xAWMa
	RU2G9pVJF4Pq2Me0ifV7nbOIj8aSzjRv1THVkNZ5NBz/8Ztuwz04HR9FumPS5w5J
	X/l5S/ZTzbuiMaNkLYgbaYuFSom2qR1hIO0B97cl3012Hbvt98fJwxbNJ1EfkrDk
	rDno8g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a79jjsukf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 15:12:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8805a43387cso41935656d6.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762269153; x=1762873953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vqopIC4yJDbwil1oh8vhhREvmrvyN/FTdfpv/O18o4=;
        b=ddpGVpLLwEkomSxPkFQ0agbLfwi7C/a65CeZaGW7SaIrpIvPtoJ1jxjTdDTSpEk7R3
         Xj5bwAsrmNi/WFl8g/4dTbxOFthM3s4IZHdfIBKEalFF30UbjwZ+Lq58sKzv1cvTqJ5c
         SuZ04SJjMazjMnWU4erQs8EFpDXW3SrCwie0d2ie1lIofFHf9ML/EvanNJIXZQqGFnX2
         fRgLgkyOona6Bp4gHzR6901rOfjmN+zq2F8qyQPrG7xfa2nO5AFtLqe+J1Fi5+mF8epf
         kAfk48XJQhCq7svbPvo0csb36SA55IyeK7CfEBrIXrjLIMPlNO20wdMN5h2rpmDjNsBp
         PGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762269153; x=1762873953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vqopIC4yJDbwil1oh8vhhREvmrvyN/FTdfpv/O18o4=;
        b=C+P52P/gaBZ716GhaTjKNWSylLaN77Q3EIyEivezjc2R5PNacO4Oa9IBN4mUgQN1lq
         5YA7slrMksiBnvHJXWEQn0TjjXbPmy18LM0CddtLC1Q7D9RmsLKmy/I2vwpsWliHZDHa
         vjeOF9qUTfQRglu5GlkxJx4NDr6mqjx66TkMo9xn5VWAR1nlR2Xnp5QLSANWOpq2LlR7
         oarLrKzCL3sSOc+G0ldesxRgim43I1khER/4u3mfw07WEyl1MNArPBHcJ3XvKoNhS6X/
         VkclsrGm7uhYrs/jVGm4VELasl53hHGiB0sA0tHzfNIEiCbnyMTUzuAdpyg1qnENGG89
         VQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVEw1NJK1p0wTfM/ZB8eFgQuL2g9zxo6n2l0F2sR0iu3ydFs1xsoa0YCw4P1GFME6Z+6QedCSS5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxljehSVQ2i2CZ4RLP7NRtZrSOK747HK7YSsShKDY/DA7msM7HJ
	X+wF9DaztYsaVATsu1M9o6Lc/vNWVMByEC5RhZK0k6cjsJTV9a762RSzUsJl8Ye624mCMGSNWjs
	F0fQD9+AF1SY9gGIN6dMTVxQ4cpO8jIKIlE/H1N5KUvghHadODSl9IljmArT2Hrzjj4qKyi3ZY4
	nObv8surcA0QpjpppqqxZEUq1tOnG+zmdlcf6n
X-Gm-Gg: ASbGnctEcLvcEqIcK9efhF4rJZxumQjYTsvsuAL0L0Fvhrq05rbtm8+0bnY59R+4FCC
	amSy2ZZyx18dQugNW/Wt7cQuxb6DE9aQ/XxHeHqkx6SR2jBVp0SHBGYAfc7YRAdEI/8YfmLMCd2
	6ZL+QHv+b+l2gi0bPiZB5tpI57PKWw4UgvMrNYlcDMbOxTPOqkuH4gBzCwVRupqiiaY4zvhAAJk
	4B03DWdXT82C4PxtA==
X-Received: by 2002:ad4:5f0f:0:b0:880:5249:be3e with SMTP id 6a1803df08f44-8806236710cmr43432566d6.13.1762269152551;
        Tue, 04 Nov 2025 07:12:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1mnAQoxkNokipiDnEZIOKDt4CKNUSdt8eGXRFFPOPQBreNOmC0L7nu2+HY38I5j9Yj3cuvz2IdOs/ebH/vDU=
X-Received: by 2002:ad4:5f0f:0:b0:880:5249:be3e with SMTP id
 6a1803df08f44-8806236710cmr43431976d6.13.1762269152092; Tue, 04 Nov 2025
 07:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-2-loic.poulain@oss.qualcomm.com> <20251104-spiritual-jade-marmoset-0fa0dc@kuoka>
In-Reply-To: <20251104-spiritual-jade-marmoset-0fa0dc@kuoka>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 16:12:20 +0100
X-Gm-Features: AWmQ_bkT9-hBsqBlfk6MvdU7iEm9BTtvAnmuXeeVmxUlfFeX8bUJJwWN2n-kPCQ
Message-ID: <CAFEp6-0wCEttHgyHp5hfSrThN8vqin77SWF9nAgB-QHYu=t3LA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: power: reset: qcom-pon: Document qcom,warm-reset
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: qYKMgqpzV1qJN-r785k4DDIYN48GAQji
X-Proofpoint-ORIG-GUID: qYKMgqpzV1qJN-r785k4DDIYN48GAQji
X-Authority-Analysis: v=2.4 cv=TuPrRTXh c=1 sm=1 tr=0 ts=690a17e1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=sAukdvN5d5inU9OdpqcA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEyNyBTYWx0ZWRfX9Tr2uRVNtUOx
 Q0PBV2aHHIVYlk3rNB1TRsiK+16rphaTzPQ+RJdpfGbRLwp7KvJSSEHJQT+LSWHY+OyizhQW4yt
 lvevS3oxkkB2G7RR8ewLPmikrri+4z2cAFbsAvef0qTI6cLYAz5nO8YJ1UX/Av4M2cqIrVvqVg8
 Fef7AGdpnn/J9rx99D9LYXw6N53mpohLBloB+0z99NiYg2J66CoDV/yjL47AB6mnMnEQXBERVsU
 7Ob79KgdmP2N6FSOM9nGVZsiooANi9L5RW5IX6udVVLhdshj9XgfZZDTez/Lu8KAjlJ/ElePzvS
 dCXN+bbBkTGyoNohDyIWMOVku7WzTzzyTPozviL0iDpKhE8DsiZNJQ+VU2qiebJd39cvj7kcHqM
 rIfIU4uBoCptuZSp5Pa71+sPKnPNrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040127

On Tue, Nov 4, 2025 at 3:04=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Mon, Nov 03, 2025 at 07:20:02PM +0100, Loic Poulain wrote:
> > This property can be used as a fallback mechanism when a warm reset
> > cannot be achieved through the standard firmware interface (SCPI).
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/power/reset/qcom,pon.yaml          | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yam=
l b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > index 979a377cb4ff..ad8691c87f4f 100644
> > --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > @@ -38,6 +38,13 @@ properties:
> >      minItems: 1
> >      maxItems: 2
> >
> > +  qcom,warm-reset:
> > +    description: |
>
> Do not need '|' unless you need to preserve formatting.
>
> > +      The PON (Power-On) peripheral provides support for warm reset, w=
hich can
> > +      be used as a fallback mechanism when a warm reset cannot be achi=
eved
> > +      through the standard firmware interface.
>
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.

I could argue that this property is meant to describe hardware support
for warm reset, but since all platforms support it, it effectively
becomes a way to configure behavior rather than indicate hardware
capability.

I=E2=80=99ll try to discuss and find an alternative approach that avoids
introducing this extra property.

Thanks,
Loic

