Return-Path: <linux-pm+bounces-40088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B994CCEBE37
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 12:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83E7F301C966
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 11:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0231320A04;
	Wed, 31 Dec 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fn6OLCFo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AikWFsOY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7DF31960B
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182375; cv=none; b=BZwzBVvvD7gwPjOwqaujabOHevYGHaXj+5+S4i3kw7rv2hzyRTPyNNiV1n62zX9MU94t6Pp6vHc5bmwBeVJa+UkBG5Qe5+ditlzogdjmbk17xDPw5aMOyedh6EdqoXiCiVRZMD7CD9M78i6zHL98VJWY5iHgJQ0NVnsVWYWZNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182375; c=relaxed/simple;
	bh=uyffDGfn05peAWo3sgXumgnt3wMR4eHeF4ZsEVRMf14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWDfrDuk0CdbhjAiUJ4wLVTKLOBvtLaw48vaz1+qCyk03GwUIZ+9CsdhudQcoZOnLixYm6vmN1Tqznzx+e/vCQF5GInchPeqex7Ir3SSlA1k5pwQeBouLEYw+K6er6bL3uy0DBqWeCVdOX2u7B8mydBDNP/eLRy98aNcxWsFh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fn6OLCFo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AikWFsOY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUNO9jP2618396
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 11:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TNjhPMri5egMZGfHF7ADhCRlV/hFxO0EU6L/JwwocvM=; b=Fn6OLCFoIX1LUTLM
	rbZDaBB9VeH4f2s0MIkvO2AaLbov8KhpkFInAn9K0FPyEfXY1Lsyx9kMxM7ct88F
	KLP4llSpe+85LH16mYf3UhsIWI0MSsQebIrdjV8TokJkAXc5Q/dNkyNkVYpt824O
	T+CRFPHT6MUm1u1SSE2rRuAOgHY8OY/EJXc1D8UIsWOgOCRpvrUW6LY31knwHIDp
	jbkDzNa4Ruw+9/XejK49O9rqvqViROG6EDU+ZmlCrr77O4ZwIZbWUGHFFQYjQLnP
	f3QAsPYK90G5mwod/00+OtCGRkIKTWWMLxaTXDaS0AwmdOJ+ZMDE+6NVURIsZ8KM
	OKwCZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc06gvc1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 11:59:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee23b6b6fdso27718591cf.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 03:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767182373; x=1767787173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNjhPMri5egMZGfHF7ADhCRlV/hFxO0EU6L/JwwocvM=;
        b=AikWFsOYkXug3paQ5kSHuy5cZl4UcfqmDrc9UipuIPwYpj2Vun/BtuEjOReCFYAS/z
         jhYyP/Jt72lXihigh3xJ05SvblWbRsZHhRUO85/J+H4JHhtvnzC36vKzWx9dx/rLMony
         4wzbjw9dAr+6DZlSkm+p4CE58/l608jrmu9/g4Ypg2jRh+IjlW0Fl8K6XDjsqRgJWPTe
         DtYuRtTb8ScdIrtzjORKm6m2W1nLOCEhhF3ZgnQMqsH+ZEU2HRMPykrgpWVZuMBpzrD2
         yj5uUv29nEbEbpP5BkqKb231D4nCutJzUERg5rbZ3zRqX1ylsMmg0oncAzSbxEX6Tfl1
         XzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767182373; x=1767787173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNjhPMri5egMZGfHF7ADhCRlV/hFxO0EU6L/JwwocvM=;
        b=kwqHmPbmJsYpOD3VpkcvIOOB0QyohsZ7tXi/jlPmNK/dVdlyvKK/sFLyFBtWKwKXMi
         N9dbXGIt0gcljELdvf9nw6HoN/RWgg2hYKO3cdaMt1ZUE/bAhO4s2lAqOnWoR+0Bfw3U
         wXHGFCeWSQnH4V2GkZTc0OtlIY8VTmQpJYap+TULdC/dkOnF4Tj1A//0mm0LBtBEKhGO
         JNhmQ2fS7rCPQGCpNX6n54FmP1lAsbwkR/NhlfUZk08gwdxJF/WTCTFt+S8/g5SXM2Cv
         1EkaIajHrq061S8SAyINzbx03jKjWVIhPMTmyRfVSYiJjJJPaRJeAgrLUTWKu5SsOmpm
         eA+A==
X-Forwarded-Encrypted: i=1; AJvYcCUjrGQpbcVfnSUY+k5wK2MxW9Xi2yfBTOYmAd7G/GhFTx6rZaTUnbGIEHbLlvdAQO3eHX9AlJp6Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKE68D+GcF4rtxaLHtlzP9v13Dfyt/ZBmBoEuloPmkbRQ0YBN
	sXvbKE1c3WRgI0Jk6aL3ICbNu6ylJC8s5x07dhGM1AmbqVBqQWMOOuLrOXofXnCi4HNXPmH4f0f
	ugupeoC5WoU1U6pSqNsx470vBPYhXP5j7Kd0cfhN1PM+HenDxdVNsthFEBKH36Q==
X-Gm-Gg: AY/fxX6TAONZ9+9lGH1oM7MMNCahSrqZyUfokgPAGav5O+7kjuL3flkQ58Mwen1Ropn
	EJ0LBRw+PLhyYWsSijpTlhicmLSDAQjM7w3MmdTdcvUcfu4x6IBGfQdAHZM9oTZYEnIFzJAjf51
	QIgyxRQozKYtumGm9zCBTptSoQCL4KpWuwFg1eir9H/qQYLa+6cB4MB/Iue75Oiebowi6x17hdE
	b9KuBHorBtIKMUwBXSdOup+6+bPdzZUwAmZr915qoFsf0q690F8voa3qwI88XvhAFUvD2oyQweh
	M02TN6pNd/cLNKoE5fihv9kaia3PoGXeaNeG2A2pnAuUy+UoCN1wd2IN+8wHpJ8X9pWNkAtFUWG
	mm1oC83YXWP3FVXudnuv0RPzjv5BuIfBEOKhqx4YKw4YHZ9eWslAP7Q73fpf5SNUF0A==
X-Received: by 2002:ac8:5a46:0:b0:4f1:b580:fba8 with SMTP id d75a77b69052e-4f4abcd86f6mr410376961cf.3.1767182372588;
        Wed, 31 Dec 2025 03:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn/5ejBuCR7T6usDlrDmTh8+/iYla+IL6/jHjwTNavUKl5hdjO3p1G8/XEudpBh9M+sUWJuA==
X-Received: by 2002:ac8:5a46:0:b0:4f1:b580:fba8 with SMTP id d75a77b69052e-4f4abcd86f6mr410376771cf.3.1767182372182;
        Wed, 31 Dec 2025 03:59:32 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de10dfsm3835467966b.36.2025.12.31.03.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 03:59:31 -0800 (PST)
Message-ID: <d6396ed0-8529-44af-9d2b-cf0bf03f17f6@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 12:59:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: o9TGfPdHc4e0iPKJOsRaveto6AC-4-uS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNSBTYWx0ZWRfX1quLA5RNCkEG
 fyIbDUGrJvIg+hsRmZcz1FJczmlCeiGRWAs745X2cQV1YG+4sroukbJsMcuKp8cpKCd+vdjk7V5
 26JnIRqhoLIARmdAWqtSBWENnVQc1Cv3b6zFCoD0pPr5bkmJ0GqAv1E6+M4DZWBUVtylwXECrOZ
 9aeO5jBYtiTw83bYDte6dNGnTXyysRxALPjqSSqydvkKohtRxhl1BcFk4E+VT/y+WzxknH6ny9D
 QQBlR+SXu4291ToNLVTcRa98j5Wn/3seG0RmThAyg6W5in3YiBFDTSP6Lr3clTSfkNk3it6VldY
 QfUCwz7pcAfecwR1hNjodp/Gj508SNnFNzF3xzs8z3AbSRZot5T1OyP4kqYRowgoB8PJIqfXXFF
 7bj3NnKzH1C+4e9L2g3OaRCs+kIExXyt1qgmEW1YNmgd+DPtosUzkxj2eKYnMry+iud7TekTKd9
 6qR1soTuajbF2PrxJ7g==
X-Authority-Analysis: v=2.4 cv=A45h/qWG c=1 sm=1 tr=0 ts=69551025 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=82mGn9uJx0ILj01WsxUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: o9TGfPdHc4e0iPKJOsRaveto6AC-4-uS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310105

On 12/23/25 1:32 PM, Gaurav Kohli wrote:
> The cooling subnode of a remoteproc represents a client of the Thermal
> Mitigation Device QMI service running on it. Each subnode of the cooling
> node represents a single control exposed by the service.
> 
> Add maintainer name also and update this binding for cdsp substem.
> 
> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

[...]

> +    remoteproc-cdsp {
> +        cooling {
> +            compatible = "qcom,qmi-cooling-cdsp";
> +
> +            cdsp_sw0: cdsp_sw {

I'm curious about the meaning of the name - does "sw" here stand
for "software"?

If so, does this essentially mean "a software toggle for throttling the
CDSP"?

Would all such occurrences essentially always have a "sw" suffix?

Konrad

