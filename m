Return-Path: <linux-pm+bounces-21578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E303EA2D2BE
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 02:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB33618859BE
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABD312C499;
	Sat,  8 Feb 2025 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TsB+Vd+W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCCC1E492
	for <linux-pm@vger.kernel.org>; Sat,  8 Feb 2025 01:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738979321; cv=none; b=U5pAWodUah4XW9ULguLQE8Adg8dRpC6rhdYY8ekFSU4nKJCwkx2wmwiJdHw+DX7tYUDqY+7GfUhU/rovTmGKyR2dvYrNTdWIzqHvc5GXjTxoSlcUM8fAyGPxKqza12v6vtmBM1RK71q8MTnNumao59QdrhWo6L8A+bGG2GdIJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738979321; c=relaxed/simple;
	bh=VpnMtAzmUxjiP0Pu54O3XMOA1CWxorcIsLG1hejl4CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCGMv2twreLgVEoBnyJwKvuR8kJkLk6wg8JICQPqDAfAVHQjwtN9XZb0LAkYXCN6lBeSmtTUZUUagunTTvJ/IxWDN5FfWourLlhy+cX0X2j1MenQSQoQp+trAbJ8uYaNr/QjocIzO2wr9ujxduwobCoYXXA0Z/MWv7YtDNqokbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TsB+Vd+W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5180JmKl008091
	for <linux-pm@vger.kernel.org>; Sat, 8 Feb 2025 01:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xl9UdSwizgDLzhJeCFKLohTvtuP335q16GE/Hoo/GDI=; b=TsB+Vd+WjAPWLV8S
	SWRLnk3lUbmSLak+N6HWs8Y2yR/zz0dXx94bjOjbYjn+04Al3ZHfQQb3ZTKgxx4H
	bV298dCuuBKRsctsaHNI7mj/DSuRkNhEsQFxpm5MH8Y4FFlP8crhoRu7bSDcBiEd
	J7ckFc/2hmALwhubbfE9pV3epDkL+j6rkcCXtIhZ7LOe4z5WHYATQ+Z2FZV6xfCV
	z8nu5LjUvPXF15rtGpFxu5Osr/qggExRTK/Qznqb+Nk8EyWGZoj7U2lAmlhc+VgU
	QiPNJlOvw+8Lri6OyMfeky/c69DGaHuA68q+35cy7BsN/u0gO9laxdZHcuLUWITD
	TxwvQA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nvmkg478-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 08 Feb 2025 01:48:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e132c31eso34400385a.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2025 17:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738979318; x=1739584118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xl9UdSwizgDLzhJeCFKLohTvtuP335q16GE/Hoo/GDI=;
        b=B+s6OY027VxcTRgNN64RiIC/rkHFsKAaMMNV4V+b7pLdlG+KIl3H8ecDVISXRqcOFC
         uqSYnPrbuI6q6jkDYGDOBnsGzi8JX23woaDvzWNcxzD2rHc6LhpJevlwEsZUpGIZfoaG
         p17q8CIwG1N5Q6Ox0ozroAINzWzxjpcGAv8gysCX84dBoVEOLaG5hC+ln0dVq6C9eR9D
         suIMBVb1xUir5+AfDnfAUZEsMUHAouV5PyAnEjz3HT1unyBOx6pcagAexlUDakTKxEBn
         IkwzCACJNdE/OmJ6xqjBOR3x0u1O30qGLqVPd7d39e/DWDWd/n/l+9ptyVmOkx/xgKOl
         6GBg==
X-Forwarded-Encrypted: i=1; AJvYcCXSnbaZbMgxnV2tRl29HspkHgIzAudySPhGJd8byUg35F+EBlhoMpsTFUdEmBNiYbM/0WtaWu6SoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4j4Xd2M69if9aQcszLHZAjZnPoxX8dbtMRfLVmhbLqzNnVhjc
	smWztJrwftrlseXTsCqg1KVg6DdtG7y/HPqs7BjXlaN4LfGzu1FwQrKZqQUdCaReWH8EhgYD82+
	Zfroc0WbdLkSmTePZmI3Dlz6nTBqBg6bcYxXzfzoa/H8dE+ifg8VDYXVOjw==
X-Gm-Gg: ASbGncurSdN3hoAnsCQolCXV+OHHw30eHx8C6++30bKg4oEDzNlaH8C+YrQ6fXQmhFB
	rRdKC0zUWKThfdxfqR19gV/D57GDBvIi9j4WtCBfi7XxkYb5Eteuuv0TknWMf+2p/JMxA444mP/
	Rl6E6XiOuxNKPSVOmN0lExmv56AVVWfgUOivnZ1XG3x4mvHfKFoE3XJuRh7PO23MNKzEhFNq4Jf
	0jFdbEBZnw9yJmGhZHE/Z1Jua7hgcDH+dk5m++eAXO04Jjacmb1PEDnnnq/QYprn0CcXdCn5UcM
	emsLkY3xjTY6jBaX+M22XcZjagcv6ITHpT8pqGjld7X8GZyVRIDar3lJy28=
X-Received: by 2002:a05:620a:244d:b0:7b6:d26e:9d76 with SMTP id af79cd13be357-7c047c4ae40mr346170785a.14.1738979317967;
        Fri, 07 Feb 2025 17:48:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5DxAxvukpLhR34rHx9sdZvjTULj5Sql9mnUYRGRBbRwhSXMt6xgJkwCmMUpmSdxZ5jouzaA==
X-Received: by 2002:a05:620a:244d:b0:7b6:d26e:9d76 with SMTP id af79cd13be357-7c047c4ae40mr346169885a.14.1738979317611;
        Fri, 07 Feb 2025 17:48:37 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a275537csm32549966b.66.2025.02.07.17.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 17:48:36 -0800 (PST)
Message-ID: <a02922b6-7b48-4305-8cf3-8019cbe9a069@oss.qualcomm.com>
Date: Sat, 8 Feb 2025 02:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750: Add BWMONs
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
References: <20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com>
 <20250113-sm8750_bwmon_master-v1-2-f082da3a3308@quicinc.com>
 <Z4k8T31cw_CxHFLC@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z4k8T31cw_CxHFLC@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sJt4kXDlmgUlp6WM8rc2gjSdJP0K6AJO
X-Proofpoint-GUID: sJt4kXDlmgUlp6WM8rc2gjSdJP0K6AJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_11,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502080011

On 16.01.2025 6:05 PM, Stephan Gerhold wrote:
> On Mon, Jan 13, 2025 at 01:08:18PM -0800, Melody Olvera wrote:
>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>
>> Add the CPU BWMONs for SM8750 SoCs.
>>
>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 74 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 74 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..09fe3149da1926b74a98280fe209ae7f423db864 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> @@ -2802,6 +2802,80 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
>>  			};
>>  		};
>>  
>> +		/* cluster0 */
>> +		pmu@240b3400 {
>> +			compatible = "qcom,sm8750-cpu-bwmon", "qcom,sdm845-bwmon";
>> +			reg = <0x0 0x240b3400 0x0 0x600>;
>> +
>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> 
> The start of the interconnect path is QCOM_ICC_TAG_ACTIVE_ONLY, but the
> destination is QCOM_ICC_TAG_ALWAYS? This is strange. Interconnect used
> by the CPU should be QCOM_ICC_TAG_ACTIVE_ONLY.

I'm not sure if this is a question, but I second, both should be ACTIVE_ONLY

Konrad

