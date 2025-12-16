Return-Path: <linux-pm+bounces-39632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0CCC297A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 13:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C72C13015E00
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9FE34E747;
	Tue, 16 Dec 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LD7Adl0b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EwIsrSv6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120734DB52
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887211; cv=none; b=XAn9pgAjmDW0+Kn8MbQMnINOaqRkl2oSpTdKf9nXdWeHcAZl5LwlEcHOdArjPgtg4fg0SIjBAWu+iBz0r8Regtp7QRS3Op6S/Pc06K2bv/SFrsaPNJ+In/v9WEx558ttlCDM9N0sUxQinqFkdxFNxdzR9cA7Pbkm4IxzHiWzbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887211; c=relaxed/simple;
	bh=EqPoMDbyqQevPFFWEYcU+ic6ViXZu/vhtuQUgrtP8s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHHLbqOJTYl12zXio/v65CpFnEz6/7z65B+7zV7PWY5GmvQAzz+y2jkx0eBol2z8P9RnrY4Brsf6vdUtngBkahxsiQ67y3eOmAqG9LLyu4IhK1NoUdPAPzb6zcuh9sYh8jW9umbWsUFud5AldPNGlWVnUgMLkXoEKkS6lmTkBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LD7Adl0b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EwIsrSv6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG9ZpP63349309
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nBDtvdhlEDZhHvSsqtGF/U9j4heSI31S4RRQPhJZkh0=; b=LD7Adl0b9Z9hCHI+
	xXtxGDtwzrA2wWFnADYTSjtBY5FugwiM65xEzbLuxPywfhOSHd8IJmVIo8U9XwJB
	Buw/PvORcDPj+WmnA9arbFlbI44CQiWi3RjX9TBsJJ1aocZ4jDyfT0qd23E5HYw0
	glNcK8GsVtFXGfV4KGOws/hIz9x7y+VJbFiZAVIussCLOdEjrTeTXog5W2oAOE+s
	5xrXX7MdoB1W6qy6HI32BPWyS2SE8J7gS5SkhG8wM2wPAlSoYWkPwSnrCB1ivmRl
	TiVpFzLrem28n5en2mXzij3iSN9IdOBlStgp5Z7KrA4w77VWK2lM3RMerMiwBlMF
	JM9l6Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b34xd0kkw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:13:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88653c1bab5so17383456d6.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 04:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765887207; x=1766492007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBDtvdhlEDZhHvSsqtGF/U9j4heSI31S4RRQPhJZkh0=;
        b=EwIsrSv6+7UA3+4s72RYOmTFr1GPU37xr9q+lAiH0aq83aD6jDgXzqwOMCWS5CI2ST
         Ki5gSbmDA2eBp6o0s0TVGjRtWnrBy9dGxLdIG9808nAH1L6wxyKX9n49J0P+kLM8ND8A
         MvNft3vpQqfTirrOH5dX0HiPEE+n9ZXO7Umgcgp/Bi10qH+rh7g2DdAmpsu+xTF++7YS
         TucDggOeo73p+INg1e7QYfxmTn7SAv5WsT3/Hp62NfTbCzmJ+Rly6LdJou+9VCFLozlC
         4p5fsgtBCF7R40X08dfWRuCBXliiORq41MvbL5uXhDi63xd1zd0VYvmYi+dva3BeC6/5
         GJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765887207; x=1766492007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBDtvdhlEDZhHvSsqtGF/U9j4heSI31S4RRQPhJZkh0=;
        b=djRumOqsF63N5GRkypPF/ENOBWAz+emX8jJlAXZLVlThYVA85wcLd7WtUgsu30v4/H
         kPLsegKOD581V3G+RbSJpYpjReCY90ZVjsQ3dh75RKTaeylLCIYu8j2lJQQ2pcgRklcG
         8xXNqEhIFLcSR6qkas1TFL6p7LOxN6XPVr527+dsvlVgaDK0/8wNuxgtLY2s4so/FMo7
         cO3N8t8fyIQwjnt/X7P3dYPdpHw4TkeTfqRWL6J1UMiwRq8d2onXfXUY5yf1dwkN4BQi
         7WuCg9vLDxUT0fStPnw0rHWB128/fJo7JetaK0wX76nGF4GuosiX2/ybz0m1aro3f8JJ
         u+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp9Y6ah7HALOOOLS+aD2MlCT8UyBDd064RRtWGulJ07NC+XEnNiNKT4GsIIc4LXo3ykmyA8XYDIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+RmH1yJhrGIeCMAHRlMfpTbZIA7KVdvjKeaU5EiOE2yEF9pYg
	HTPXc3WVDgwIxNltDXHCTmztbZV2m2teFuwV+uSpeh5wzXOqUyaF54gst9O//YtBMCu11vjKL4k
	NHs58z/ESQqq2QA3utTHzU5r4ZXYaAu40Qp1+axr0cXG7Xd6mKcYI7j/TVHEizzF3vXFpIA==
X-Gm-Gg: AY/fxX6btskkmiIK4CKC4MkqZsvK9RicT9bFl4yqe7R8kHgTgv3QI/PCZ11zbayXmnc
	P2zbTB2J2hD6cn0GkmYW0MkxUBAuv0SgSVwBd9vHJWQn7fiK8cIz5ifmqgxXpV/wvA9CMDYJW7G
	rFdhm8FNYuOO0LhkbkXHk8eKsOzNdbVEAPxeqGt2Lut/p0LxfhDzbQV+g3kMBupf2CUXEKZMV2w
	o5zD4QvLLb6czZ3AIxonLu6SX7JGq2k50I8Pz+j5Lalrqp+dvSk3tpzwFzBiMJLVQ/4yVF611dB
	jrCF8TDG6J/YOMRYD0CFY33w6ZxKg7hosrPoZopJbEG2p3YkUmAG4KGNsP9ry0B5V4UDT67xo7e
	ERRbtlMdkjUYJpzjPekWEI1XgWipZu3IxCxOX9X/C9x96h/Sh4wyL8pl/01Mu7xFXog==
X-Received: by 2002:a05:6214:3009:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-8887e15808fmr175508206d6.6.1765887207373;
        Tue, 16 Dec 2025 04:13:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjpAQSTEKJsFIxdXDIMo/SjcylewI+gSwe+VXgx1EjplcjIJAqldB/vYxgwrqEiRixO01dow==
X-Received: by 2002:a05:6214:3009:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-8887e15808fmr175507976d6.6.1765887206867;
        Tue, 16 Dec 2025 04:13:26 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-599115eb95fsm494275e87.19.2025.12.16.04.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 04:13:26 -0800 (PST)
Message-ID: <fbc5d96f-8c3f-4566-9bbc-1097604142d7@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 13:13:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: dts: qcom: dts: switch to RPMPD_* indices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com>
 <20251211-rework-rpmhpd-rpmpd-v2-2-a5ec4028129f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251211-rework-rpmhpd-rpmpd-v2-2-a5ec4028129f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwMyBTYWx0ZWRfX6oufTmAnWOsG
 drK/iLQyZks8zoXAECF2JpmHaA1smmVpgPjSwLBocb6XyImerzgdevDBCVLLWf7jZKhVgBfyGXu
 76GoIg/7E4p9w9zHme9YJu/xRdMLGRbLHXLkDvjfnRb+64uY+Otn+I2Kg0lQJVBA2/irRHL1uYT
 lt5uf9sBke40W6UcKkSQRLnQ92FCh2ju87uX6ujCts+IQAY1X4TIhrKqOp9JnofbQirRZC/RrFj
 SDIukoyTZBgUuoDkggoi531ldyuz2qlsVgWzXDUihBwO1covXMdS8K6s8swqbNkq7Tb1bH07UBm
 FpzyiNpItd4FgkFl1dM2ZRdjQ/dSAo8Ru9ZafcEREZ2jAPZilmEdPC63jibNqByOeqjHJzpHbAz
 /J83u8GXup7julEtiqUXLyUBc95yEQ==
X-Proofpoint-GUID: PkpEItPH5I4BbueqSGdK1wKC83Dz93KN
X-Proofpoint-ORIG-GUID: PkpEItPH5I4BbueqSGdK1wKC83Dz93KN
X-Authority-Analysis: v=2.4 cv=T7mBjvKQ c=1 sm=1 tr=0 ts=69414ce8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=u_qTJo_YbU8fZNC4VkAA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160103

On 12/11/25 2:52 AM, Dmitry Baryshkov wrote:
> Use generic RPMPD_* defines for power domain instead of using
> platform-specific defines.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

