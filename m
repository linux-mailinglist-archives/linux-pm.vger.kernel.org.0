Return-Path: <linux-pm+bounces-23680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9595FA57CAC
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 19:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA323B16C5
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBE41E834E;
	Sat,  8 Mar 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTtYv9Qp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1D15B54C
	for <linux-pm@vger.kernel.org>; Sat,  8 Mar 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457931; cv=none; b=ZTm609NkyvyxNK/UrevJAuoqeYV1ufEG0JhCMSWhh93mGYPpXu1aaE2qMTLE7vA7eULPOzAi16IKgPWEvG8ppHr3V/BYS6G8ZZeSiUR+7mWQnesOnz/8y8F5585yY/xEAxzZnJ3MBQVMKzZtu8rDfakLq4+ODNnplmbioE08Pzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457931; c=relaxed/simple;
	bh=bD5AxlW2VuIQuhSBoqUIurhWpaf1zNk6Jv/tgufQBYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u/Lhk8eYwI9Hocf6nalS6s7tUYQ4PcE4b+EHavwZmnpClg7a/jFv8se3E0yN+LGOWOm//WcFI1O25UulHll0bB3EKCEt7xPCYRSYyA7U1oXXh1tPQAe2GyD6wq2HuFigC/x5zC5udDMlKa3Tex80/9b1D1cX6gy/Y4iK4i1Qgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTtYv9Qp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528HkThR012069
	for <linux-pm@vger.kernel.org>; Sat, 8 Mar 2025 18:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m7VMOOHCnWWv5i1BgNSjDHokS7zDbQFxUlnbve9H9B4=; b=WTtYv9Qpmbt5XRJu
	dlottvEEGXZZ4SeHzc1MmmZuRSELxqcaTKhxpYyYZLP9zsZ0n7whCf81oTyVnJZo
	CgQsyLBhF/Kz4s5grlQ9jLYUVvrv3WnSBKJGHvWq2/TWUU6z7DY0+RjOJH4g6W17
	8tupzaUP/j2vO+DKxyuPSVj/eeJvQLUCEwTLMhPoA2U14oXKwMQ76SJcx3tMpPRu
	us1vqr/nwmiXW2jgJPLc0LXaP+Hr1NdiZ0RGqoMpC9RqIzfiLN6OtpTwx+WBQS1C
	6AotpaBAGzsvVDFBFfTeKgF4vBTK1Cc6nWdG05ZFllrpldcpe3OFmql5r/23bzjw
	GI1jHQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex0ryn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 08 Mar 2025 18:18:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-474f467e613so8504251cf.2
        for <linux-pm@vger.kernel.org>; Sat, 08 Mar 2025 10:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741457928; x=1742062728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7VMOOHCnWWv5i1BgNSjDHokS7zDbQFxUlnbve9H9B4=;
        b=JwU0Ucl4J8xymp2Ef1QGFcAsS1ACdtRQkxXiY9UaAha7MeU0DZJncFVHVuOSUp3M/L
         h9iAbyV8QqMu1XBPxmePCipOYxv8ejtSRRS2QDOjOn7NkrrthwRD7WLvK6vIlYQ9NdWv
         EUbm7sabcfrudwi6yd++/7mK0aXsjnNdNZ2sEk07S/M14gg2vtFg105kn8ofXIAL+x8J
         H/OlToRd9fhUEWzlcs52mVfSF5iSyY6QAmtRhwSDFgVfPIDIOHECIeP/y0g+8PgXRIH/
         qIeCg+yJnr1ouPVyWowPauWyN4FFsmJAybH//vGkSuICsqf1KXXxo4yIRbhh6UqZVifc
         WQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH2HwQhG9DPopCEzbxa+6zylFyPGR6NJF0slIYLwIN8ZiK0BQnhCfEQ9wyt02KRE14KYbFIg0oZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztX+5SeZG0E/cBGi634qNjxamih2Jpuf7H8nj2u8gFyFtHyWhS
	Tzdm5IEYdXyh1LdlBB4swZ6fLKhPSMtqqEAL3Niv8YJfNZHpSAcLFLhpL2ZAOzvpXN6+I1vSu8b
	cq+l9A2bb3ymKZxIpBUg2s83F0TsvpJlsuGFDWXaNXFDrr/6Qvek9q5DQJA==
X-Gm-Gg: ASbGnct52fuXwjve42OqwJS0E7Gc/vhNHYRbCaxaJ+LpPXxr4oCnRNVTm9mj5GEePT1
	E7TXYC8y0FmRluWbLiReNtWpEUa9DBX2u5C6/l11mSsjQcmTuja8TNlj6qgnHccfS7UDz2TvGWY
	bmd/UwN9Hyp43M3TTv5ysNpY3VxRfHBNIZotBIcTAesdb/SlwgjT0WSAdRK36K4M/SDZrBJ12jc
	vyoEmxLzC6Fq9RLQrnvZgCloDzDhDMc0Q8HtHQ3m5fBplEyfD6M+AMIgFI3oWbUsbCJ9e/Oet+P
	hBvt53uVJYeGrPW31kpW3cwnZx+LcMvLGAlrXIPveteWSIS/K8VtMf7KJ3KppgSDneojvg==
X-Received: by 2002:a05:6214:d8e:b0:6d9:2fe3:bf0c with SMTP id 6a1803df08f44-6e908cbf908mr19100306d6.4.1741457928273;
        Sat, 08 Mar 2025 10:18:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU4F95kcd7Qv2rTv7eBfeED28SPZ057PpxuS5TT0SI7vVwgcCC3vnEZVR8Vy+AG1PAq2SKZQ==
X-Received: by 2002:a05:6214:d8e:b0:6d9:2fe3:bf0c with SMTP id 6a1803df08f44-6e908cbf908mr19100116d6.4.1741457927902;
        Sat, 08 Mar 2025 10:18:47 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988cec9sm472280966b.144.2025.03.08.10.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 10:18:46 -0800 (PST)
Message-ID: <39389406-a581-46a7-bfa4-384d3bbd09fa@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 19:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq support
To: Sricharan R <quic_srichara@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250127093128.2611247-1-quic_srichara@quicinc.com>
 <20250127093128.2611247-5-quic_srichara@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250127093128.2611247-5-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5NNdnnv6ydwk6t6CuUWkuKpkgHnYW8JS
X-Authority-Analysis: v=2.4 cv=f/qyBPyM c=1 sm=1 tr=0 ts=67cc8a09 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=qTnuS0Aw-iaHhWJ6p_YA:9 a=QEXdDO2ut3YA:10
 a=X5f3S4XyYk52BB0gviDM:22 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5NNdnnv6ydwk6t6CuUWkuKpkgHnYW8JS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=981 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080141

On 27.01.2025 10:31 AM, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

subject: you're not enabling support, you're either enabling cpufreq (the
feature), or adding support for it

> Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
> CPU clock scaling.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---

[...]

> +	cpu_opp_table: opp-table-cpu {
> +		compatible = "operating-points-v2-kryo-cpu";
> +		opp-shared;
> +		nvmem-cells = <&cpu_speed_bin>;
> +
> +		/*
> +		 * CPU supports two frequencies and the fuse has LValue instead
> +		 * of limits. As only two frequencies are supported, considering
> +		 * zero Lvalue as no limit and Lvalue as 1.4GHz limit.
> +		 * ------------------------------------------------------------
> +		 * Frequency     BIT1    BIT0    opp-supported-hw
> +		 *	      1.4GHz  No Limit
> +		 * ------------------------------------------------------------
> +		 * 1416000000      1       1	    0x3
> +		 * 1800000000      0       1	    0x1
> +		 * ------------------------------------------------------------
> +		 */

This is trivially inferred from the nodes below

> +
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <1>;
> +			opp-supported-hw = <0x3>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1800000000 {
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <2>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <200000>;
> +		};
> +	};
> +
>  	memory@80000000 {
>  		device_type = "memory";
>  		/* We expect the bootloader to fill in the size */
> @@ -151,6 +202,18 @@ soc@0 {
>  		#size-cells = <2>;
>  		ranges = <0 0 0 0 0x10 0>;
>  
> +		qfprom@a6000 {
> +			compatible = "qcom,qfprom";
> +			reg = <0x0 0xa6000 0x0 0x1000>;

Please pad the address part to 8 hex digits with leading zeroes

Konrad

