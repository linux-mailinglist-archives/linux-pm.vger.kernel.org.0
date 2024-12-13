Return-Path: <linux-pm+bounces-19198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900569F115C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B711883F9C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A3F1E378C;
	Fri, 13 Dec 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldGQ9MtP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7A1E1C26
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105048; cv=none; b=nICPCbhnqbnMghOVY/AIR3zUnYwg41gNtW5wE2BM0yW6Oem0q7F7FjRgmyXtgw2GnbbMRrbThABVSM4iwhYXjlUQ0uIZsyfU8KJCZID97xtnzn/+7mN9xBUj/cGFKNBRTdAzM+TCO2pPgN1erYYJqmb1hJs+JUU/kZm3K20XGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105048; c=relaxed/simple;
	bh=AH4YC3G4oAqm/Dy3ioJZ79XaboCBCeJ5Sqlc8mVdEvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOC08OBomTj8Tik+cEvstPWWkJzF5MoBIdjnFvMpKTAw9nK+QsxLREIMOu6ZZ2RvWQs9P9e9Tend0T/KXMeOF2xgB2UG2G1ZQcJ5f2K7tlgalP7Cy2eK09gmMU3mrZ8Oy+2N4Ws2nScl+GM+WYP7Cc3HIbRNO9WA716ZaqZWE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldGQ9MtP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD81rA2022366
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 15:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4lWamNQAIDfM3yyUtey6LSacCJIPjLImwXtS4zXm6hU=; b=ldGQ9MtPJZ2QCo2F
	RrlTV+WYdn25DDHsj2e3mZI049VVUyl1EIgquJhPbXwWBnVw30GQ8SpqpOE0tjfv
	OxFLtcJ1iJs9a0qTp8Xxr6R6DCfdld+o+mkLV0dVEe3wrazbbzkJ6WSnIu3V1+zY
	PklmGuuL5g/l5gQUlkyD3R5xM6nvswao9FTVG0sobvYQPj3SEQKlans3hhJFpNA0
	qrKS2qBbots7YBYRduiD5TPOtkF4ghQ4uapPBDVvcw0yYcYfFjDav8Oh4BJDtyzK
	1GMHo90qrqd0fM13cR2x4SHy55CrfF/8CnsUsh565zCFzdHSgjKsqJ44QeFjXlDt
	Uy1oYA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gh271b0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 15:50:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6db1009a608so3483286d6.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 07:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105043; x=1734709843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lWamNQAIDfM3yyUtey6LSacCJIPjLImwXtS4zXm6hU=;
        b=IqyxlZQDf8a3ncrwjHErM6jEzNl9SKI2G7w17MBh6XjOdPBXfV/oqZ3zLW4cLAg/Cl
         OttKHA90x5gl57Umr4TUpUY2FyteRTNwYK52DKUDxBX1mTlUPiasTM8sx/PDJnxJgkq9
         FMvcLodWHv8na/q6lvctzbVIbSWAbKDjnNUdjypfsXUEwMDtgzaNH9D5QHLyKDPLOwQt
         rf/ISnkKPIEeJiMDLodCNX/y5uGsgofo5BIp3AxZIgVMOaqudyBhSJ4JiYiCHKUPpjQK
         xR3U1wH0mHIja7YtvkpIndLOpOTsloA7sD5h8V5y/yK6DonXtENr0JtRYp5+/MSCT9ej
         vwrg==
X-Forwarded-Encrypted: i=1; AJvYcCXzVnmezEgVAX/q9bJKLR3m7pYIByw4nr3feOgqYZL7kf+a9FOXFhb0mr7TLAN6V8pZMKdLdgMszQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyADDEItI2mSQ7Z8hKTnJVr6E22sZGZglu29PMGofv825PaNPnA
	2P2PBQjHwu2f+Ahe6dWgtqUxIfiMaAXHybx+lm3YOiM85pNxX8Xdj6HtYWObP4mo0S4NC7j5k8i
	ZKIsbetj4tlx0yoJgGs4ZEkzFNe2F9Q2edvEKU1AFefr1oS0BYbWYuGKzPQ==
X-Gm-Gg: ASbGncs0MSOg7epOnI1j4wF0gKRVNusjcN3EHcKM3R03XBbQDQin/di8kQq24Y+g8dj
	I4x02XLtFTggSXOBNkscIWZXRhq3oB0vxZ6oaImed3k0LgZmxLKDfll9buKTQWsxr4sXJQhSrRd
	EbXitxHzSYy+UDS1T7nuCsDAG6bw8PD238MmPoqz1XYMfOSfOwP2p9HRYH/wCNY1W9plR6uBD01
	s87+3pM0iF6qt6uU1RohaBc4EK/vjXvFuPUu86zhon9u2FOBOFOsV4XLOoBxtPWlo8y9fpyVYlt
	dZw+76u4aJK5UtNYhnNDXHVSt8xq6RHuvfQU
X-Received: by 2002:a05:620a:4593:b0:7b6:dc5c:de2 with SMTP id af79cd13be357-7b6fbf402e6mr165103785a.13.1734105043587;
        Fri, 13 Dec 2024 07:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm8l6zBqCg8QGl9x4UXubkofdFN5ahIp8JE2QujG9aG5B1WdYVDkhDOOL+l9SSQJV+oU85hQ==
X-Received: by 2002:a05:620a:4593:b0:7b6:dc5c:de2 with SMTP id af79cd13be357-7b6fbf402e6mr165102485a.13.1734105043193;
        Fri, 13 Dec 2024 07:50:43 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3df2fc65bsm8769201a12.54.2024.12.13.07.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:50:42 -0800 (PST)
Message-ID: <2911fa29-1ecb-4d2d-a89b-2068f6fe3022@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 16:50:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: z9OQ_fwZrDwYuUdMayQeo7r7ed8qjYCg
X-Proofpoint-GUID: z9OQ_fwZrDwYuUdMayQeo7r7ed8qjYCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130112

On 12.12.2024 5:11 PM, Satya Priya Kakitapalli wrote:
> Add PM8775 ADC5 GEN3 Channel info and bindings for the MBG Temp
> alarm peripheral found on PM8775 pmic.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 86 ++++++++++++++++++++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           | 41 +++++++++++
>  2 files changed, 127 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..909373eb758e4a8b7c2bbd0022c56ab2e823ca13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-mbg-tm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SPMI PMIC MBG Thermal Monitoring
> +
> +maintainers:
> +  - Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> +
> +description:
> +  Qualcomm's MBG(Master Bandgap) temperature alarm monitors the die
> +  temperature and generates an interrupt if the PMIC die temperature is
> +  over a set of programmable temperature thresholds. It allows monitoring
> +  for both hot and cold, LVL1 and LVL2 thresholds, which makes it different
> +  from the existing temp alarm peripheral. The interrupt comes over SPMI
> +  and the MBG's fault status register gives details to understand whether
> +  it is a hot/cold and LVL1/LVL2 violation.
> +
> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,spmi-pm8775-mbg-tm

The bus the chip is connected over shouldn't be part of the compatible

Konrad

