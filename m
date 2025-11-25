Return-Path: <linux-pm+bounces-38663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A08C87811
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 00:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 273AB4E3C72
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 23:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5322F1FE9;
	Tue, 25 Nov 2025 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lAQ4+Bzs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aCev0qpp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448872DF151
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114511; cv=none; b=jdy02uFzFLIl3TT22L+Trb1BvZucdT8wbY9HRlRRFM0fxcRuHUWmJncLf2hTujcBz4cyknGaaSU3GRmk4y8JR4dUxdx/cqK9gkIxyPN5Ok8PjRdV7v0ypHKLmcj6YEErtUZxpkK60fBIzCZ3gUc1ocgKoQEftdlDf33qp+geToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114511; c=relaxed/simple;
	bh=1TXfVPlixmyba6i4iq08P8vC0/duqILVROJdsnsxVr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpxlTAUkey0yQYNRGUnUGWl3R2G7i0ADUYuLWhYAIBwuhzn67NhjIJoCvlHC1s7KK1nzbwM5MbbOYCtMRIuxr6DU8L2lYMi0aWgmrc/lnJ15OS1LJphWkjYy1w3kYmToKjL12kqYPVWKdARTaJP8e7Ebcm4wJtfMQTk4mZNo1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lAQ4+Bzs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aCev0qpp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APNMnNC4049271
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LaLJMWzhhoL7jF0TkISIME95
	5ZsctfKtB90v8ZvJ6RQ=; b=lAQ4+Bzsij7HP9ZKcNk/rDsdxXaz4VYoKQSOv6i0
	pWBmUB3vRcQLDuVKc2r38Xx5gRNjTXM0Bm/B35rpW5CO7pg0FiftzD5qSrHoSowO
	pCa4kmJ/UFPB9mQxE77Z3Xa4EtGxBehwiZGvjNOsZ668MNh7wBuISgWmY8xawfB3
	pbj/jX6idcpKJWEC9ZebnDsmEj60pEzLuDgYQfhhaZLmic34EvZMwUsP2ShdxN7x
	GlQuKWzPTlu0On7kleXKv2x9RcdcozAyoghJNcQsVSj4De0feitaYxYU4DRyT4eB
	8RZU3+tX0PdY9r8/86vwY1GRNU+okmP3gZM+Z0HEsgGKhA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anp2ng1du-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 23:48:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2657cfcdaso730023385a.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 15:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764114507; x=1764719307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LaLJMWzhhoL7jF0TkISIME955ZsctfKtB90v8ZvJ6RQ=;
        b=aCev0qppPsXyYXWCMCEwhocBwvPwmj6yFrql7CS5fu7CtYBk2OhON79I+53fTtRt0L
         h1K53MNBimDkRPJGNLjmBX7kIKrLLYaquXiMtPweUtV7rqvbD6XhhNOtRmGc9O4Ntm3n
         nw05wNfKLa0ueqru6wbuiTioUSXOWemQUC7Acchib3hBfkhNYLAIeNRs0Hqf/UgXBQyL
         G/Z5TwY5gBl6imCwk8TSjc3jBCeSsT9urOGJ93Nu0cHYqV/5cddjdtB4deJiu7JXgkGh
         VHj+hd6k/HFO/1QncqvhPNZ9PS4HJzNA+4Q/Af+5nlAtP2xiPuRK3B8EBQA18GVgx5x7
         wKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114507; x=1764719307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaLJMWzhhoL7jF0TkISIME955ZsctfKtB90v8ZvJ6RQ=;
        b=o9rldX5BByDnxY2hByPJOs0HrxWlGCdp42z/wU9XsqvLVIOGMdJb2Tqmo9QfeyMJZX
         4+qAxeQItq/AifAQHOse5U5uVijYkBnMDqVSa4m0uCYKE2mlEz6MBTswTgYZ3CsTeCY9
         JL2acSVD8/mKX6R5K+1rYgBVhuEDxjCAGlHO0dnkD5RuIw15kAscy9UEeubFPxWsBbwe
         9/fraJ8UrjxY9WBUbwdRYJuz2/BCB04LE12EDBRPcawMmBWCKwi+8Yr1zHdUnWe7sjuf
         85C+zbeDKP0HYLSu+PZ0k27bo40OQez60M0iJhrSdMWkgs7wfmCIMeJlmJNJDqrAMbjs
         Iyug==
X-Forwarded-Encrypted: i=1; AJvYcCVD5ROw3oeWVzWTsEl6nYJEuro+pRU5gv1zOnsKKHJ4cnv0B5CKpC4uP0s4ldYzQpQnLDByfWiAxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AmRjU+H2t7PLw+jpldHQo9AkQFCrwYUqRRT05zT7mb5bAKT2
	+H71bbRyFN0Qp1ZfMoq66vYsVR8wj6VvCPNZnPFDJyHABblgS14CHwrSUG4+jxnGenLBNKKd4fN
	0UbJdyeoIvnVcgAfUPGgOZOVdYmkg5tpg0nKS1u+aJFhvHkryDb9BJa0eLfuz4w==
X-Gm-Gg: ASbGncvl/lKDKlE4GFnn67uCTCSZlphdWfEvANbRYRo/dB8uJDm9s+BQ7XesqSV0Ob1
	qGwltzj92XqaObmAIHG+OXdl+GK8OKjGMLrjZv4f1YM1J9lHqd1HGrnHZ6TZnzyG9S99sNpojLT
	HY9knPWHjiAXFlLQeJtgWlm9XRnx+Q49AzRNQIut/LrbAqa9a7AvCa6vDwSsyD4w3Gel13Vpe4w
	H205dqoFYhAkGqEkF++SJTvlVET3JsNelmNEiGuZyMc9OoQKobqIuSkMJRQc/pa8qrkjYqZRwaI
	oW0XZBQJj8NyZJ3nNHho1vMxK+bhUXQYSE3jLZ9L2/LIWI7WJPrBZBr/yyFnJBNmLC7i44bmLkl
	BONRwgu1Do0xWLWwnvpN29fT4DO6us5hNlJDX6Z6Izai7PeuK1tQyF/MozBFKKLuxoUnbZVxYmz
	ItUpJN05VB2piClcwRD+Lfu54=
X-Received: by 2002:a05:620a:450c:b0:8b1:1585:225d with SMTP id af79cd13be357-8b4ebdbced6mr609942685a.82.1764114507486;
        Tue, 25 Nov 2025 15:48:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6Iz6guPEwafR2wvdP6krEPpb9fwqNVDu16YYRJcFruP0aUiA6bZ6DvM6LUsWD8DjhuU93Vg==
X-Received: by 2002:a05:620a:450c:b0:8b1:1585:225d with SMTP id af79cd13be357-8b4ebdbced6mr609939185a.82.1764114506973;
        Tue, 25 Nov 2025 15:48:26 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbccd9esm5511505e87.92.2025.11.25.15.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:48:26 -0800 (PST)
Date: Wed, 26 Nov 2025 01:48:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH RFC 5/8] arm64: dts: qcom: sdm845-xiaomi-beryllium:
 Enable fuel gauge
Message-ID: <rtkhkh57hnmq4vb6nh6wh2no6z52tamt4tiiaplxpon3jrbl3g@pe6cm4hmvj4p>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
 <20251124-pmi8998_fuel_gauge-v1-5-dd3791f61478@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-5-dd3791f61478@ixit.cz>
X-Authority-Analysis: v=2.4 cv=KerfcAYD c=1 sm=1 tr=0 ts=6926404c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WFa1dZBpAAAA:8 a=EUspDBNiAAAA:8 a=B0FhMAULOlTCn5wgl4IA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=MZguhEFr_PtxzKXayD1K:22
X-Proofpoint-GUID: cI8xi5UjuU0598Kbw5c-cFv5N5f0ci65
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE5OCBTYWx0ZWRfX3sV0c0lyOCBC
 XqJohc8Dk0Eynr83iXb8v1c4yb//plaq6ax3MPjsLH1xxz9JTEH7X6+d7Leb5t/hcV2pWKvxxKK
 e1aIJuzOcAvx6xbMv6kXm+ruAPiUGh3Xxn5WpvIbqRcv4OPew2YsvwydUGKizPef8Ft2L5Jy4v2
 9v3YXCEV8L2uJ0wbCSiJ2ZNY18jSwWzqi/ElGFfZZ/UCkhmMhZb9vvKJdWlqto3f6ewOcw/6qbf
 4vRAX+2EjLjdMzqLAnMrsR26MWX1NQjEgXSDs0+FPpf/m8uSonV1aCZ79cgYQcY/PGhzVE1aHs0
 j76nOtlwwtGwGntcHC2qCs5f6olpUeT4RRiBJm5GaQT88dDf+2Pt+9/6S2XC1ThRVB0b4vRdStN
 SxVVJEkO7y5xQ55ekwYfnsni4j55bA==
X-Proofpoint-ORIG-GUID: cI8xi5UjuU0598Kbw5c-cFv5N5f0ci65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250198

On Mon, Nov 24, 2025 at 10:53:38PM +0100, David Heidelberg via B4 Relay wrote:
> From: Joel Selvaraj <foss@joelselvaraj.com>
> 
> Enable the fuel gauge and configure the associated charger and battery.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

