Return-Path: <linux-pm+bounces-40710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAC9D18442
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B54E300FEC3
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4DB3502BB;
	Tue, 13 Jan 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADVBcV1J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJ7CIwTY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD4A325702
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301682; cv=none; b=MGP9KZDz0KLJLMnwb160UVfMNfGnGwlGtdDFYM/TZ8r8UCkSY9OzoM6ygZqClMyWKmU0+v/ZPRMBXuLXQ1tP0Cmaetk/SwQj3IF/COVnoTPnTI6DLYn2z76fLL2EJs/Kx3C4O92GRlzz7HgirwVlOFDNOELOqD0k48328AV7zqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301682; c=relaxed/simple;
	bh=geHrV8j325fjCXR/96bYWoEOz5SdRIeeeqgCGYspfyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huJ0ip00yrOCx4qse+MFv89ZyPlPeGRstU/dZ0oDaJjIgZN9nE3VwYSoGoUG8nINQsyeU/MoxxGfn/vvUwqnQhn42JgRzs3cQenff4vW3Ybwi5gxUL/1JKZESjV3ukBigDdLmEhoMo8h0zh0yDQDe8prphTlWQ5Kilw+QZDiqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADVBcV1J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJ7CIwTY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7AZtv2607176
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 10:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NxxFxFdOUorrSwubOUpoJfLcPzidJL2DPsjTQBjmS0A=; b=ADVBcV1JD+4tSwcK
	8mnFNtau84ItVxosTTzUVROqjAqO7WvLLf2TGI4j+1m4XteKrmA5ApRPS6UAYZgX
	KVjLRlcbfvJmi8E6Prum+dKAG8UJT7opF8yEjozDmSv4vnUmHSPWj8Z4LGVo3iS0
	YcfDYNDJh4bp4C9DirUKvdenbEjn6tgkL4rf/8VeWaQ8ZyCw+9hMLY/kgXMWM13L
	csxwg7I9Gq4MZUmP9ZPRP3sSkQnjMdBhDGrfo2hL5aX+07bFcewNAfjk2+XpYf7k
	8VJHi8NQvgb/ROLGZz1hZXlarxwOwtFcuOjrs4ptITtGu7eJNFOtT+CVhbzrpkLx
	L4h3Sw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn7uytc9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 10:54:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ffb8ac2cebso14314431cf.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768301679; x=1768906479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxxFxFdOUorrSwubOUpoJfLcPzidJL2DPsjTQBjmS0A=;
        b=ZJ7CIwTYQ+6k6DlrZf9+3LyFUW6BEac1q2hnIb5sVQYakYDXrIoy3xQ3dZ8GbEfvgl
         gu+znitsl4NGuoYDn+5nIAMORyGtGRETIBZtgS2R6CZr06W52H3CKF8J+cONROst9VxP
         ahhWDmaSjCGVSOzxILGhrpMx43N7VtP7eE5VfU7BM4N2rFsVtil+GLOKPHCh62Tsr5wu
         WpGNM0+aqKQaUYDSxiYYMeUefsozAckCyI+E8ThzgVE2OMem7sWG8cU1lbRTO1SZ/EbI
         K/Ttp6IWJ7MtnPons69k0sWd1yxA5k3u2w317oIe2WAqDMcTmO7dfvCeC4OcPV3VJeie
         p1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301679; x=1768906479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxxFxFdOUorrSwubOUpoJfLcPzidJL2DPsjTQBjmS0A=;
        b=h0cmQO6JA/6hIRy9x8TptBflE+hhpGZy3YzSPZZi1ckNQ/b35q5afyiv7tadS12ARu
         7qornz8mChETwTa9R7bfpbKOVzy+JuyacZcyYfAsh/N6ehJ5/29qwI4EM4u0sNtUaJyk
         MYfObvcGOt7X9Yx8D7PpQ/bbayrKM3DtphJLh9lAOddVPAX3LqhUB4eCaIlcchEmP41L
         7rDxhzPEUTSYITgt6My5RTjU+Z1A7iXwmDatdhg4QejTiXyENHZMEbddKJmepzoLaKOV
         7Ga+7p8SsEqbNVLkXJ1k1h9jt+A63sFlfA6YomsycpbHdSh47Fvq/MHi4EzsEZ/WktUL
         mGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEn3nf0dXr3BC800kWE40sQyuJtlotTih9YYkPlNrzR7tTpZUAGwqxIVpD5xesb+jkF/7pHD3X8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrI54HO2UzR/IYGrmFX6aC3AroWZomiiKzC5LdllU2GKPTVX6
	V5avYkEof2v2BryhwNLYCxgwzYD5vN2gWk5zNSWhDiWVM2oWOdFXrZbPXzfUq3QH5HVMvwioHuI
	VN3td5ObxtLZVp+iTJVoiKKH2rw5ByOHfamrPnVzt8gJeZfvkmWSrj9KlnopLRA==
X-Gm-Gg: AY/fxX6faHv6JtsH4jomWKB43dH6zsKoV9uv3EyI+VAscDnklitatE83rDTlI9d36PN
	hHrlnfhc1jw3SuHDoRHSOmVfLawu9SEWeXqm83bnMP5bV0+B9kgOIy01e62dkSaulY6IxqWDGvz
	sd8FwJyPfkmtca8NFFu9PKlNHzBaxOli5oIRryl+uvl8A6PIEd6YEd4HSXOJYZIh8dbftYax67r
	Y9CF6oG3Bm+7POtWSUqgfCUQl0b4gwm06WCQlBJk3sQUyIuEtZFbbgm06UEl2/9ljeERdQoYjBP
	FFOYB5OPZhEWsMGXBZ3huX4CTMv609hwey36Zk1HElDgdsstxePAMEIh+2rPHCQXQyttDRBFuB8
	eeINnwlDyHQc9XmZPKTYEIIkWQb0LNHDx1QjxWTkYK9OQhDtxJL2cyTatRrUUoydcw8o=
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr230844141cf.11.1768301679040;
        Tue, 13 Jan 2026 02:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQc0YXkBhVUzUnAsavtTTb1WiheZk2936oqIhZquyqc2Qmv8AcuJgaGJ36Y/j13vnLAjXrUA==
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr230843941cf.11.1768301678519;
        Tue, 13 Jan 2026 02:54:38 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8709d11b90sm741890766b.12.2026.01.13.02.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:54:38 -0800 (PST)
Message-ID: <cfc4914d-a8e7-49ba-a5d5-7ebfa62fd0a2@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 11:54:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: dt-platdev: Block the driver from probing on
 more QC platforms
To: Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260113-topic-cpufreq_block-v1-1-91f27df19028@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260113-topic-cpufreq_block-v1-1-91f27df19028@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Is5r8UkgbEGP_6AgV8BnnLfDHl9yfej9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MiBTYWx0ZWRfX/kr7ql20FcP/
 SxL3lXo5KxjwZaSbPMEDN9YrjcFmrcdUvpzG8mC0y0PrvCa4kGtD1OxkevvmnWKtBGK3QKMxykz
 2QdUb4WUS6eTThKuy3BLjmg/sLF2NU32DPXUkqZ+YAn7xTL+S2Bx5qBF6/JBRZbQAvp92WaoOCh
 N9cKDNusTyyubWwX2opC81SgPLN8jQ53TBPK/LmpZGCSj7MLTmkZIng3t3GZBiqrSB6cDi4OUTp
 PgxVucDMWIXaqFbSdE8yH7rQHd8rEhLuIyqUu6fnTC41j8Flz+CG8sf9oVelYFAtrlWDnBLXU/g
 qacim/K9J5eYdRTNrakEy/aA9teluX01Y56UGdATzWXw8OwulmxvSAXyaHLu5QNEAu+MpqIWVzd
 Jrz4Xatb+AR4IMcso2jod6Izzlq6uL8SUhoq9jB1M2mSVdqwNUrDpcHPwM2u25lFJqTawLQ6uKt
 hPX7h465pWkbDA783iw==
X-Authority-Analysis: v=2.4 cv=bpdBxUai c=1 sm=1 tr=0 ts=69662470 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=vMhQApj_rjIVdvPUXlcA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Is5r8UkgbEGP_6AgV8BnnLfDHl9yfej9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130092

On 1/13/26 11:53 AM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Add a number of QC platforms to the blocklist, they all use either the
> qcom-cpufreq-hw or scmi-cpufreq drivers.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Note: the "qcom,glymur" compatible is not in -next, but is already
> approved by krzk and should be merged shortly

Scratch that, immediately after pressing enter I realized the ones
using cpufreq-scmi won't even have an OPP table attached to the CPUs

I'll send a v2..

Konrad

