Return-Path: <linux-pm+bounces-37393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BECCC33037
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 22:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C7918C407C
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007612EC09A;
	Tue,  4 Nov 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ltHTTeem";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cn79UR0t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E023A9AE
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291198; cv=none; b=RpcFuVJcCn7TNoBSYlEHhx/Dtrb8+DG56lOaPa23oFFuGkYI4tnUc1NG8KiT65yiS5lPSuUwr0h5gMpzHdRMsWXsrZM0Cnitm7fy5tzcUVzeOyw6gIaozKOElvCdqK1PUG1GFE486dARIfns7dStbzqR6omZFHm5I62d6nBqbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291198; c=relaxed/simple;
	bh=O1h+4JCwzsGbtVqSYlNfNaUKue0RFvzI1fkR5b3AGJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAxG578R7dSsoYgfemUdP/czjevXDdV6qEKSOFdyRx48sB+2kEVOzPwLGeJHgAN6pZmi/Zu8nm94orYoXgYMJgtCqMEGBddO1syAO4xQ2yLOM12z++ogR7PAZnQBaLo/K852IHT+GuLKPeW/0pMcoWBTtXIjtMQatL19WFvU71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ltHTTeem; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cn79UR0t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KfuW22996890
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 21:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7ao1xhpFX+XOQkTW5iWtSuLDLy82w90QS7hnNgJ443Y=; b=ltHTTeem1oFN2AJD
	kR3jNKjD/90nAmVh2kC2q0TP99FT1NPjXnZFKebJO53T6b0xTc7qrS0CZLm6vByY
	3XvSRWo4Z7mdDF7SpOHFQEhNAqhAWSf+BwqPURV1os4TWUf9PuRrtEAeR95yeTh9
	Cvn/mj96ZpjVZ9YFfAi2s1NN5UoqUnL5poPRukS1KqC+3lYbtt+sulPXuEtYPJFw
	gKG0dk/yPk4Y3LFpJw4+0tDC5eo0wrUjMXHqOsgKVSQpdJ9ogKmNkbpmkxm/L34N
	acWki8IVprGTZWbaAt7Ocd/7qnd1swUMoK75uhDxW0vGTu+fASX/3arKd1SgUvdF
	OEtEow==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7c7jjgrq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 21:19:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-81d800259e3so54702706d6.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 13:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762291195; x=1762895995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ao1xhpFX+XOQkTW5iWtSuLDLy82w90QS7hnNgJ443Y=;
        b=Cn79UR0tUL4+GIw/V47ndi+mzP3E54Y/p9IBNoVC0tc+SS3GrtaztIxVvRvAkgWQKO
         0fRxStemD1H7L3fFvQfv+ZLAGcGLV7+jgaPwD4wajCx/DLmJcmq0147+L4DqnYLIDOB/
         wMXbWaz0kFviF5UZDiDrSrXXo5zWJuyTosa+jW2SSFYP2jDxsO03yLqfmVgoe0WWysds
         D9xXMBtI7IH6fzogkPdQ9JQqSN3Bz/MmsO0gIyljdzd+FHB5bddJe1FHHaQYX1X9hNnA
         w6pODoaH56OGoGVZhRdvLHFpFKutwE+uchlr7Pxb129vMF3j3YVNvZHDDe0gnlLXotbw
         7sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762291195; x=1762895995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ao1xhpFX+XOQkTW5iWtSuLDLy82w90QS7hnNgJ443Y=;
        b=de/VTstBUfcyAgxDx3Wkt94NB7EqH17ZI2wgjJ6kB1+lhxmEC9ZAYKDOIWS7hq0gJl
         i9lv/MnE33TrGokzbS7BhwYKSGfRQ0CyTpx5xi39QwrJHO5SQjitcmDRu7IhF8Hcrn/d
         FoLo2jYsLIGeNlXUvH0C+R4L3dBaIjv7KQE9+z4WPs4qXotqGAwOnN5BZeUouJieb0Zm
         TuPqZ2GFp6h8XH0QL6JKOG5BWl5bWBK+YGBAo++XG9ywIHJlrfvXuL22Fsjj33m2HXey
         UGGuW4ge9SmdZ/Av05GVabi9BkJVUylsdIBN4Td7KX51HfO3XjVVBTuzWyn/LHuahrPJ
         0Sbw==
X-Forwarded-Encrypted: i=1; AJvYcCXtuWMKVRmFsNHpYLWDix68uA1AazHPdgAx+AIURdVDjzDsbZA4R+gjJaw24iAuYi21arO2J19qFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZwNFt2NLxTI14jYHBB7Tr4FxqKHkJue3vJDzIdeQ/O6h7JfK
	t2Xa/uR68HWVoMRKyFDtobAZXIA/Qpwim4pWt8fuWOAaOe8AFVXTzRcpXKCX56sE3ZsoXJwJmsj
	L01oM3g/FQ/8rNufb/8m9Z8dKiOXoKxW6shQcPmnPirCXb//UQbUFP+3GeifY8YQs9+/8AqZ7IS
	p0WCBB7ZQI3RScXgIaRCmndSa2df3qjk1HRJvg
X-Gm-Gg: ASbGnctRF29WqaQxTcE8zeqgOyvXeeH5a5JXewFKPbT9mTgJn7Cxze9UOhHmByzlAFj
	oDFL5pbI2y1nrJ1UiKyJiWvaS1TaH+5xE50MuOJJwoyN6F5mbGHFijHwjADBZoPsnjGCsnebEVq
	CYuYgMb+vNcRk+ku7O3Qzse8nFO/38A4roY2KWbSJYqqON+x8pOJi61mf3uNemfoc1pdFoucijX
	GpEUMOxjNhMImaZeg==
X-Received: by 2002:ad4:5e86:0:b0:880:54eb:f66d with SMTP id 6a1803df08f44-880710ef566mr19875226d6.30.1762291195328;
        Tue, 04 Nov 2025 13:19:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAtr5fi63eLSJNqRxiTEwYKcD63XOKrJwVcoRoTpEaTOJBhc0VY5rc0qTciRzV6XQYN449ljhx84vZ76s+rbU=
X-Received: by 2002:ad4:5e86:0:b0:880:54eb:f66d with SMTP id
 6a1803df08f44-880710ef566mr19874716d6.30.1762291194661; Tue, 04 Nov 2025
 13:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com> <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
In-Reply-To: <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 22:19:43 +0100
X-Gm-Features: AWmQ_bmEwhQu5qGTjy7kyV-oJxAIA4QXEdTlLapG7ZT_EYYjiAQKe5I_bkwPYHA
Message-ID: <CAFEp6-2GGA2gvBKfO0fZemVmJmjQpTQEJ0vLfEewfhHKOYQGSQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
To: Bjorn Andersson <andersson@kernel.org>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE3OSBTYWx0ZWRfXxu+/xfYzuoDs
 vj/NJp5sQ2qSu2RtH77URhO6DHKo9i9jQdZcWjF4Yca/jtKT9EzJatkc73q6g7InMyj2BRIZzpO
 THQCSGD6g06L0R3GHShxcsm/oLm2Zc2pDVD0jkKGC54v2WCefgatCyOD333fFnmlCum1wh+FKV6
 dgpVe5ZO+yITwhRsq8fAKqkIZBsr/ebB5cQcXZZ60YHBLEa3Kom5Luj2ScDjp4GwzQy2U6BJa/D
 rbzTPQB1UHyTrVU0JG/hPefcsbqscIvaahecgivDa3WckzbS0QjZjJlkj/dE2e1Wi5PzhjTPqsg
 Urbp/N1ZgR9L59X8+lbmovLKmVWGSsmlW0Xje5Hezno7f01EymDzqw8FaG0R4Qq5/VK4WSsYWjv
 ppYm1mk+DBv3Bsv3ov31UaRhmupAoA==
X-Proofpoint-ORIG-GUID: HlMJytXvCSOf2h9_E_80VQ1O-YK3S1Jk
X-Proofpoint-GUID: HlMJytXvCSOf2h9_E_80VQ1O-YK3S1Jk
X-Authority-Analysis: v=2.4 cv=DvNbOW/+ c=1 sm=1 tr=0 ts=690a6dfc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=--1CKO6TaCenDoQP3NYA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040179

On Tue, Nov 4, 2025 at 3:12=E2=80=AFAM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>
> On Mon, Nov 03, 2025 at 07:20:04PM +0100, Loic Poulain wrote:
> > SCM can be used to support reboot mode such as Emergency Recovery Mode.
>
> "such as"? Do we have any other useful bits in here?

 I heard we may have different EDL modes supported like USB or SD
based EDL, but I don't know much about the details.

>
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b=
/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > index b913192219e4..c8bb7dacd900 100644
> > --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > @@ -121,6 +121,10 @@ properties:
> >            - description: offset of the download mode control register
> >      description: TCSR hardware block
> >
> > +patternProperties:
> > +  "^mode-.*$":
>
> I'd only ever expect mode-edl =3D <1>. Do we have additional modes that
> warrant the generic nature of this?

We may extend this to mode-ramdump if it makes sense, but as of now
it's indeed only edl, will fix it.

Regards,
Loic

