Return-Path: <linux-pm+bounces-35467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F80BA3EE7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 15:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648B47B05F2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D2C18A6CF;
	Fri, 26 Sep 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izW9npQS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BF72605
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894403; cv=none; b=rLSpd2I+D0yDDIvlGUlafOCQD7pO2b24vYMjpGyqhG5V+jt9zRszzFHBvvIxrD6JlVkPBz4DPtlNwtsK4DTZ+cPRSQ4hK2ECt/0MFNBZJjDZZCmAnGdSsNVya4yvwQE5o3QyhqN6cs2X3ElCZtlNnKjjGexizONN6IOK/Sscx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894403; c=relaxed/simple;
	bh=0EOjaBswWQvC9XmPVf+lr9JjN3BYmeqPrTnFPJ0cBnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ou6IpA8kBTjtIzM06oAB/HiLqj/ogkxaTPSOfbaBAcvOZBW1zjfQS1SICUJRLcvtGZbks/UDY5UIB93fFZpSQoOL7fXKrCAF+jJwTDN3Cv2c3GZBLfSrVerm7RsgSoQTS1+p9Ef+wKSzHnJGjTDpV+z4NPrGhH2n5Y0fAWM/qU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izW9npQS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vfdf014653
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 13:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K7AOC2kVYXtte+/8joVQrCBNjRIRBFVGaIEKx6zbQkQ=; b=izW9npQSUWtSxCLc
	pEg7K8+BzdwWdQnB8LNP7gDOLBkDqJ/NohaFqQSxHW2mEaLLiKYV5gsVspVxgKQi
	Hx2y0ZadKq7eESLbdA7bKWAinffirfliMJn6ow/F/Z7w7hOdQ2/1jscNP81Vy0c9
	exDNJW4iGXKb/6TKLQ23gxH8erIQJf2cCGUTKtu0INSjVrQQqKGyiAuQwVIkCetc
	kXh2rkyCo5qV+HvF4TLUCJPD1PeCfwugk++GlNWR2n+AMgf3ZyzM76sbLCTZ263d
	gaVR4IUTUFw4MQ/5mOed1ttHXkoQqqFmEsDxlgUIdqtmceCtzmdTrLoaVRtgc5OL
	c6XTng==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db34k0hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 13:46:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7c51f566163so6160816d6.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 06:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894399; x=1759499199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7AOC2kVYXtte+/8joVQrCBNjRIRBFVGaIEKx6zbQkQ=;
        b=Ng7kjFUAYjvNLhRYjbpUA0tJZOxEYhC3rPQMP4XRjhDyjqynfWmGv4Bz01AJBWYiLc
         iXqE3Y08LszA5GlvWjAwjBZneiPaZWBzRb2FJgO9qVx35PJYd0RLtnIfBNDQqcwKFbZZ
         G8TxElPDnFMwLOfKP7v3uDl3ZxQXRftZRuqBHEjeGHAU/Q/paNEwfPNlAGVQuRS5fDOD
         lxY7umZIiOsO4t9nery9Ctgkaw0BiZ2c9faQtDRO41ZSgFyw/6gpCKnzFPgmnKpM1tAW
         EcTqNQ3zg3s/OWiXMT3VLXVic1A189zi/IwZd3ta780Rmid8NiAuz+RZBJCjj26w50I0
         d3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFHUouuhbOvuOXNXMF8rV7UhSziBzeQ1hFl47Q16XgDjITd6YxPTvODKiFVxA73IfkzFsNihYHAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRiIsyFoGmcaX3vgnBxzcIn1XIMQzk8JEhgd24LeY/mZzGAgl
	bTK7QKjAHjQKz9WRYYuBIB4irv0ItQQwsV59VMGSeFV95vEeGslWfqHkOUlx/hkIKpQucDgiHHq
	ZKEp79rPmac47m9/AiiMVdvKvQ29PQ36nKVC7H4Hk2de8sCb3h1LpdsxtghT6Dw==
X-Gm-Gg: ASbGncsEFQYl/HYCezbwcu3YB6aKPSLleDhtbmZnuVmBufNKnXA47jrbs07ImIHTXDJ
	iovRv0S5Yd1m1Ne/RRDsUZgG/7Smo4ChNo4PhGSAc6+PH4/aAQQejUhPJtZ30GfbjMQF0NBnaKv
	+KXnqGvmQucwNrFXHgRMad8xA30Oi2rgECUzgzplNWKVEEGSCU0iHbBkTz/YLGFcgMserrlmoLb
	Nj3dxQ4yEkwq44gSU4MrpHQlmkXCr/+1kGBN4z7ZLwaC/vZgQL2mjMJ6T0QsIYVPtvrCuHtNirj
	XY9mubX77JzuCCv6G8zODY6jcIdUDy09ZjOZhqFCvc6w7b0nqg14NZBXwSXFzghf5CvKmt+pMXI
	7bVipHjt+DBxR8XaZuN4VMw==
X-Received: by 2002:a05:622a:587:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4da4b42618amr71328541cf.9.1758894398907;
        Fri, 26 Sep 2025 06:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLtYwLQK9mRezkGeVWZEARoBJCmZbLKmK1lgkPXDI8njEY2QENyEHcYysVVTxAFgAyrj2CFA==
X-Received: by 2002:a05:622a:587:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4da4b42618amr71328061cf.9.1758894398168;
        Fri, 26 Sep 2025 06:46:38 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d7351sm375666366b.7.2025.09.26.06.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:46:37 -0700 (PDT)
Message-ID: <e1427bcc-0502-4cfe-9cb2-bae5bb10208e@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] interconnect: qcom: sdx75: Drop QPIC interconnect
 and BCM nodes
To: manivannan.sadhasivam@oss.qualcomm.com, Georgi Djakov
 <djakov@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Lakshmi Sowjanya D <quic_laksd@quicinc.com>, stable@vger.kernel.org
References: <20250926-sdx75-icc-v2-0-20d6820e455c@oss.qualcomm.com>
 <20250926-sdx75-icc-v2-1-20d6820e455c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250926-sdx75-icc-v2-1-20d6820e455c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX95303U6FfsFR
 49D498q+uFims+ejOIyt7a6FUThKN9PYpaRbowX+JiVucHT+KzL4aV3WR33VMbdZca+8W07Mih1
 6+aezaWIuVtTrcObLfG8QNkjmgUJzzdL9k7kyqL+IdmfVj+FKQbT4mPsSoz89S9Oic0Nybbn03E
 UniTVHSZt50ZXDpXLUS8q9LNJK3DA8UgPmL4EzeUkIzD9mBJFcJUX+eA3bm9ELtZ2Ndk5u5nxIY
 BmObBh7ohcgEOIcJpUB6YA5ytsLk9LNGGdPKeDNJCga7rX8PamxBdIXdN9mlApoUXNDf9Fn0Uv4
 DXKKV9/aQ7MarFcHwUZeGqp93q8CYtSKo1jOKU7UQggXQjaA3WHtFDGVUtQUTO6JVenuUFLmh/7
 agsF1C0FB1TPU17SbHhb5182rruNUQ==
X-Authority-Analysis: v=2.4 cv=Hb0ZjyE8 c=1 sm=1 tr=0 ts=68d6993f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=aH40uDyxLlspqTMSXGwA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: U_fk2umpGfsOoGk6zPVqILZ6mA_VxK02
X-Proofpoint-GUID: U_fk2umpGfsOoGk6zPVqILZ6mA_VxK02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

On 9/26/25 8:42 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> 
> As like other SDX SoCs, SDX75 SoC's QPIC BCM resource was modeled as a
> RPMh clock in clk-rpmh driver. However, for SDX75, this resource was also
> described as an interconnect and BCM node mistakenly. It is incorrect to
> describe the same resource in two different providers, as it will lead to
> votes from clients overriding each other.
> 
> Hence, drop the QPIC interconnect and BCM nodes and let the clients use
> clk-rpmh driver to vote for this resource.
> 
> Without this change, the NAND driver fails to probe on SDX75, as the
> interconnect sync state disables the QPIC nodes as there were no clients
> voting for this ICC resource. However, the NAND driver had already voted
> for this BCM resource through the clk-rpmh driver. Since both votes come
> from Linux, RPMh was unable to distinguish between these two and ends up
> disabling the QPIC resource during sync state.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3642b4e5cbfe ("interconnect: qcom: Add SDX75 interconnect provider driver")
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> [mani: dropped the reference to bcm_qp0, reworded description]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Too bad no one noticed for the 2 years the platform has been upstream..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

