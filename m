Return-Path: <linux-pm+bounces-39650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F7CC7965
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 13:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E53CB307FC27
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B78C33E36C;
	Wed, 17 Dec 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oTcWSqkb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RHmgNxJT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4232A3C2
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973592; cv=none; b=Bk9PMuCG8D1NwNefgFJ9gLOAllt+lKRhBaunRLPUHbyPmqHuhx0dOwcnqVRaI1oAN57ORtjuZ/NfKPoM3FdExlWc63FhzwzRmz9zzXrbVGyuisdTIU0wkhXQmzy/ESFqAaL1mdIqmp+FLjajc+VgphNcMCctSv2PhQm1v/pdsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973592; c=relaxed/simple;
	bh=aGe86kWkfD3nvG8oBci9toKNq0ktbkQOHU4AB26yg7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIkfhDLujUbDDfBQovtN78u+TJEl2pIxZHtH1GoPsBOGewVrMK95x+yS9QH8WyTFWRgn/WOKWGtdtyIsPdIbxjfW8M3rGw9ujJYiywIfF6BNFCH+sgAiqSxFQhbpHtz4rv6XuJNQlSpLc8acJofL5mtqfzNuNJIAqlHpRqFaHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oTcWSqkb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RHmgNxJT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCD6ir2666125
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 12:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S5xgaoTT69/pBHPgbjFkA4EHKqWZuC60C9uOsst3bQ8=; b=oTcWSqkbsxGmFqcV
	DKUxPRuWDotNrXy9NN6FyIIqTPEINRlgdnyMVT44Lym0NS6udIUyMLxX2o7ECUbX
	3fXFEXkPE/1XsfXGA/W0F9sMfVgzACEaXtqLYMpgtYnMPXuQu4F6jK6RzDRK22C7
	GH6tQ+zpdBdKmJ68+al2GmL2nUXHI7pY5kwGVhXLYFtMVeMKXRuNM/DF9EZdwrxW
	XHrKoLGJpQ77NTWLNhKK0ZBFwQ09lgVw31bWwSU+UnahwQMWzAM7b+ZfE6CgTZ8J
	dIUQixMoNwmkWqJmuTzAeMS4p6kI9b7ru4UMb0c9ecdF4E89pkajgDuVeF43gw/w
	YPaV2A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3kkesqub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 12:13:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1e17aa706so17724361cf.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 04:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765973563; x=1766578363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5xgaoTT69/pBHPgbjFkA4EHKqWZuC60C9uOsst3bQ8=;
        b=RHmgNxJTarPRp59DQ+JI7cNReInQ3PJY80o32rUMHnFJJ3Tjhln6+RdBtLR34x3p9j
         x8uXg88KJqWpWq9wZcbRli/hzQS6k9aG1n77vndm8goznRv1hhkjt3tndgoUlETKRSLj
         syz6W1UwJulL/D+gmamAAdkWjnbnLrlXSe9mh0j0JaWswX8VuzBOp+UBARsqiDgS3CV7
         W2OnBZ5z2maGo0WThLLg0n/aq3kAI0DmiURs6t76NX9/EZckK4dQ0JB+ea45acpeDrr/
         ofe+GuJ5pQoURGziZ+sH6bKVYqyPwuMJtW/wxGaCoSSy3mMyKZB4No6rxoGrNIOTweX3
         KgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765973563; x=1766578363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5xgaoTT69/pBHPgbjFkA4EHKqWZuC60C9uOsst3bQ8=;
        b=rNC6YsJtY0B8/vdmgZjdHZhwUicWB2dLn3lkPNlMeZQ5aCEI+pW+7WYxwQucQVUbFo
         MODMcHffpUsL5AzCmeI9NgYs14akr9OsL6PD7d0IGCpCwytzBZi2hzsYcIjc1WsrQkRk
         g4HWsZfT8aXtX1yAxXlNeSEGUSRZK0ss+ZZltN+Ks+pGjW6zPA8maZqQVy7c4/eOu1Zw
         e1pP3UyXT1hcDemmQM6tMM4mb5Gwu7JF/9UGFF3UHjgrPYKx6gQZiNROrczzAhq/FgSm
         umm6e0JnV/UFvdy7qlIA1vA6NXrRH+7qsBw8ishGBdJZfUnZYX1mp2KXnAGayUMRxlS9
         mH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWT/GlEYgp6VWi8yTHxCxSLviGpPTUXMcTxl28HK2w2TPKNI1anS8NYQY3fWIWcYpuBldLwkChHqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVypiwLGGpTq9uPx8S0QNEl/1H0kDYAyhvbBqrGEWVMEWVsOYY
	4vv0S1+96V+zcj8PiP+FigGc5BeLutOWc0+urD6CQ+reonaM48xl8tLXfNRH7NqjMLMTUdcJwA2
	fJ5plwM7KntyHFCJIgLox/1eBC1cRn5Mttd0EGktcJhQShVgbaczN8S2wPgxDsw==
X-Gm-Gg: AY/fxX5qV8z/3Xi/Ox8oL7wnpLZh1RcLrOTjmLJUHETQKHzshkqu6nnjAetGMuKtjzp
	Gf09uFgo+X4iaMHx6+EXENotefjg/urJnAv2zEMqAz3tywIZYtqHg2dEnsZJAbIZhRjT/JUClcL
	nSgvFCOW5HXafQa1MdqDndWjKoSiyPihWyVgjL9LvtYHHIBIoA8zCKaxLkvUdxLMJNAECpNUFdc
	Vi8j3Yibm3esIQj12WZgnexdFcy1fcJdgFW9SJc2K+csaYYeskExosEVTn9bUly+OeAtk2tmJcm
	iivI/R8pT870Fs7CKnnLfKlPOtB6ZlJQOoXJtEH9aQyhnf99/EJ3lDBJ5el6kbgXrSMIQfj79PR
	IP7h5eWAZMU4VxD+MuBqrzIMREDMxGVOdKIPiICHm637JH/0+pHqCP8QlW0jBTDdI8w==
X-Received: by 2002:ac8:584a:0:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-4f1d062fccbmr159588791cf.6.1765973563367;
        Wed, 17 Dec 2025 04:12:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5eVGC3ZWYSUKoHlLO+PfDj5QMt25oSCp8OK57mCn7+0Tam8KJf/1iWxw5fxtG/X/1ogAfiA==
X-Received: by 2002:ac8:584a:0:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-4f1d062fccbmr159588381cf.6.1765973562909;
        Wed, 17 Dec 2025 04:12:42 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29f6cbsm1991353966b.5.2025.12.17.04.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 04:12:42 -0800 (PST)
Message-ID: <c786d33d-6c6c-4932-8593-857e7054dfda@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 13:12:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] arm64: dts: qcom: Add initial Milos dtsi
To: Luca Weiss <luca.weiss@fairphone.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
 <20251210-sm7635-fp6-initial-v4-8-b05fddd8b45c@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251210-sm7635-fp6-initial-v4-8-b05fddd8b45c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfX25OvB8l+8RQm
 b3wmJcdBWeIjU7O1l0ZnPmN5QKtk77EUkQ6Fwakd4Dl+RnqR2Wxcv0XAEaLqQW9qYX2FsBARWXM
 ehVtw0UwbZwyJLWMeYwURdsqwRJTN+ubj2O2P6tG46E5+QNmL+Lw3JoLBAVjegNgu3+NopDvrHH
 zbytVi1DkWCq+F4nAFvaMrXmGXMnLdrmpoq2BfJPbaSMwVidcu3wTVFW0yfzmJVb8Cih8BFuDo1
 MtqFNpwsFh8/lhfo+Zw+UfFvRwDzip9tsTltF+xR8zZPWGJvJUr1YGc9RgHy/RQSMf+sWFCQpqK
 IjiCE0JIpWF/Hw0OKCHtTvu2450CJaiyFLFQlTZKYFMzpBm6SH/wRBro8Ikwv9wfcsFp2RkrdGW
 Qkq5/P5horxOkU8mcgangSNTblwZBQ==
X-Proofpoint-GUID: YpM_c9MRLOYguOtJoK2_jzvLZqOPzyTD
X-Authority-Analysis: v=2.4 cv=Fcw6BZ+6 c=1 sm=1 tr=0 ts=69429e53 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=WSIVeowOIUgBBEAWWbIA:9 a=QEXdDO2ut3YA:10 a=AYr37p2UDEkA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: YpM_c9MRLOYguOtJoK2_jzvLZqOPzyTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170095

On 12/10/25 2:43 AM, Luca Weiss wrote:
> Add a devicetree description for the Milos SoC, which is for example
> Snapdragon 7s Gen 3 (SM7635).
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

