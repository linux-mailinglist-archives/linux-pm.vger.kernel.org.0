Return-Path: <linux-pm+bounces-39703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6ACCFEEF
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 14:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 474FB300F1A8
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5132E092E;
	Fri, 19 Dec 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JII/EGkh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZT/CjJN1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4EF2D6608
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149141; cv=none; b=S+XkkJe5CM4AIMWadvsJisLUMCzwh96S/gqS5pMq7Rx25s81cBBvfqSoOLW6K7bmNxBv7o7IsKdD1SYvyL/kSBtWY5II5+0tnjTCWD/vW5PeK4zklP+NCh7l/UGLzoysLDSGiGHo/mdHtDBqxdp7hBLfc92ew1p3Sqt2gEG5/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149141; c=relaxed/simple;
	bh=/z9RChqFbUobiCtIwibbNsTlS4mZ14RedF2GrmFSfh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Auh9YYQSRSXdds2em+n31upqvfEDPGF+KLzSPcvnqTXkFbzwT3r8Ckr/b7bVV7UdpBNb/woHVIXSWq2ePd2I40NRuA5+7CLyhM2eO94vbt9kS5C9rgrJk/a1ns7FI1WlQkpYTCzD2twUhO1EzrWjT3kgsgY0ANNNi8uYyiD/WqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JII/EGkh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZT/CjJN1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBXZsR3991031
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 12:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YQ8BpDnvaxRKS1c970H93q1ZxObJ65jXNdNzE4pE0VQ=; b=JII/EGkhBil9AGNa
	2WQ2EGLl6DStk1CNUo+3swM8oXOpmnpAy7TDkTETBM7VSPg9Ts8CBkkj0WO/PpyW
	EUKNhmw2OCvgjTYrcS4yNe5xupEAVqtSFYqCmCAaCEetuyHb113Ri4diycu3akBX
	WQ8gfN8bcQ9L6VLZHgjDqQUWfl4BbkDUtrWaQp1uCiWSxkeCTHdtzfGp1zXwurk3
	CM6j/+C2s9yiEsO8NqYkZPcY9Fe3d7f6pDl8nKuEkDOx/Ney1CE2WYf3GF2MnFpW
	U+YUNrIUlAZx906Bl1E8Q5MOMFENXRDN56pWhysxgNsEXur45fbWJxGjPEFS+WHf
	9nYeuQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2dan0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 12:58:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f34c24e2cbso4999971cf.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 04:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766149138; x=1766753938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQ8BpDnvaxRKS1c970H93q1ZxObJ65jXNdNzE4pE0VQ=;
        b=ZT/CjJN1OTDD2Kw7QgCWR7Vkqzc85C3X4Q6YuiwDWoCEO6ywbBX9M8vnReDNYipnsq
         OToSWxKxjvysDEGhtZjNqnlvmGl6P6Q4YnqZmjAwr258eNlYkgewVaPR7phUl7YSE/id
         xhUzthcyVJxQ8AMI5SwU4/ngc3+vgAoNrEbKUB5Yv/amVVwKpROOidhJKiw/Nv5NQoas
         yeCSdorOAN9Td3c2YC6Eny/Jl16jy/ifny4v+I05D/5zPQIgKpTZE6plski8FQnL83hu
         +5AFKiqzGjLAwi9zkS86vrlPWQ3gzaFFH6jkELDMUnUAYfHK/eAM1bdVWzzdIXABwF5P
         ff9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766149138; x=1766753938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQ8BpDnvaxRKS1c970H93q1ZxObJ65jXNdNzE4pE0VQ=;
        b=VYnDp+ERbs9whI1vtyo0dkcx3A++tJKPIz6zMh4S+LPQwKubiZ05Pa8XGAl1hoAUCC
         S2EJIDgUaS0oHLCxsEHbbeo1f3d1B03uskCUvGunwvgNfnIbTUZhH0qBlfng6PltJ0D6
         1zZduY07+Q4Yk+wsrpsdbNs7kfACq94NjFs75NRxjIenXTiR0onEZxRuunf8RCUfwQll
         ybNnxxScTqtps9ZLYBw41VJpCf4/olVPX+Y3uqGL3rCGsAAPKr7yyM785UJbdin7xpyb
         qv820qgPbTfB94zvi4ZPk/rdow0XdIgkP+/Pz2HzIQeCfKtHHX0Legd9cHBcdJR+DNoe
         sb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkfTw8Cy7zIfwbKt7qnG2UBmbBshXmKiHhqvZWuEEWUpXV7yBJn1lbfaMxADsEIR6VQ2y5VLdJYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqv6L2jiFAFvStLLxx+RFnxsYoWaZLIYuVhPdpnpAQBJr98j3C
	If85lDohSsuzh1Qggdl4MP8ptqoYiFgCNVpQIncLJ7AqG/o01Ql9+LOH6kugLolDxHxAHO5LlP1
	3s3lBeArUwsiFDLozBeGzmct5TjdCeXC9lIN+PyjWSicBeA14gsiiqIosHhHz6Q==
X-Gm-Gg: AY/fxX625vuhompR038QomFGQL35WmthRrj4t6JRGx8SQfwwaQ4dVBKT9T0arwQoyWz
	GbnSJcoKs4JRHNAE9ZuozlIZfLJS4Siw5nM08QC2aVA8x21863Xk+4z+eXFbGHa82RGmkKm880F
	x5oZe+tcK0v/kMnlNWxlKZABfGzP8PmXdusp9elJuCSlcgf6RUwvAhM/RkaBYyAEPsUFMjXLHNL
	iPe2Kl+qSmVPdbf9P1vr4dGBqCB/QjMs2qxf+Sf0S2hL/i7vqVNyM6hhHPh3F0jDDXGJUGKWmdt
	xTcNMfLPJ81KFAPM4neF4aEObEhlvcWh0h/4nBtAQOMe9Ey5+qqMLT/sIPjbuahoSFxNPrIKAQx
	+F0WVVZwDl4KhwXkqxCfYXG/5o8/p1VzUgUH8o5fomgWYEc9PqhoV866T7sHgbxHBxA==
X-Received: by 2002:ac8:5e4f:0:b0:4ec:f9c2:c1ec with SMTP id d75a77b69052e-4f4abdc5c87mr26785061cf.9.1766149137954;
        Fri, 19 Dec 2025 04:58:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDWGdxEfmLosc59bks5bBeNjqEWIzY041ekBoX64RJpOVkxNK5lvoChgtD4nKmgNOZ5gynEQ==
X-Received: by 2002:ac8:5e4f:0:b0:4ec:f9c2:c1ec with SMTP id d75a77b69052e-4f4abdc5c87mr26784921cf.9.1766149137553;
        Fri, 19 Dec 2025 04:58:57 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c70sm2115423a12.6.2025.12.19.04.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 04:58:56 -0800 (PST)
Message-ID: <9d5d1caf-5c3c-4c58-92dc-10f73694ec0e@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 13:58:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add initial interconnect (icc_path) Rust abstractions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <CANiq72kxcEywL4L6HEqn7AZa-jOBsw08jr+Kvjdwrd+iTOO_uQ@mail.gmail.com>
 <9884efc6-c6c5-49f1-b582-55bba8397521@oss.qualcomm.com>
 <CANiq72n31LBnLdAtZH0VBzVGau-ddWCp=5=Bra=boRE4RiCZGw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CANiq72n31LBnLdAtZH0VBzVGau-ddWCp=5=Bra=boRE4RiCZGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AcG83nXG c=1 sm=1 tr=0 ts=69454c12 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PfD2oos9AAAA:8 a=EUspDBNiAAAA:8
 a=giwF036dxWHEPjP9aMMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=oXWlT9oWAVMySZ1Hvsws:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEwNiBTYWx0ZWRfXyLHRr3XpWohX
 k0gKjOZXq3AEh9dgtCnBW1QgNvFlIdn0+KQ72ZIRfJNuH1DgF92bl8xWYj66nJsTuLegfXYEakd
 +OzMMr7kUq9hpODPF8CMplxduqAReaI92ZWp1/vJopGjj8ZyCLIWL59clWBwdNpMEW/1PntBplU
 yF3H0m+jTuepDHNkpruRtUr5hOWIwXcoYueThDmmNSN7zP/qXG342Y7MYYSG2ZKxAJ5+gGCP78T
 JmH9d6eztzBkB1eBh+0Zbn9gCIXds1eXckSfIf63yCkQ/2+deE5uA8SRwK2zrNcrPxoVXu4sDRT
 VQJFEekjvB6ZjQtCAzynJgLeipxog3KktkL17vHwuAvASrdl5uRJF6dB6GYP+kcurm0GA138kha
 u2r1xCQ71qkyy68MqppeC+eCGW8M8NEEme1+9IGJMMj1ZrVL/QTmz2329fUHnLidSD0F8LvyBtp
 eXL9MSeuPFqmhbsr+hA==
X-Proofpoint-GUID: Rt0L-8I_lGeLR4-XUOEeNOjelYhAayY2
X-Proofpoint-ORIG-GUID: Rt0L-8I_lGeLR4-XUOEeNOjelYhAayY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190106

On 7/24/25 5:55 PM, Miguel Ojeda wrote:
> On Thu, Jul 24, 2025 at 2:36 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> Regarding the users, I don't have any specific promises on a consumer
>> of these abstractions in a short term, although the ICC API is rather
>> common (especially across the major arm-based SoCs), so it shouldn't be
>> long before someone needs it.
> 
> In general, abstractions cannot be added unless there is a known user
> that is coming upstream (or developed in-tree over time, like Nova and
> Tyr).
> 
> There is also the "Rust reference driver" approach/exception to help C
> maintainers bootstrap the Rust side, which you may be able to take
> advantage of:
> 
>     https://rust-for-linux.com/rust-reference-drivers
> 
> At the end of the day, it depends on the particular case and the
> maintainers, of course.
> 
> I hope that helps.

I don't quite recall why I ended up sending it as-is, but thanks for your
(and all others') insight!

I may revisit this series one day, unless someone needs ICC bindings first,
then feel free to take it over.

Konrad

