Return-Path: <linux-pm+bounces-31342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D62AB0F41D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 15:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC291899857
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CD52E8DEE;
	Wed, 23 Jul 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQUR6D7s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE62E888F
	for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277646; cv=none; b=hC2QedM6DDhweo5j0agUpRHsV38f3eM6ZFHGHuNCm8sA2xwcJh81SF8LHUwfBe2cv+oxkvfMVcB+e4FTcDZxzNJl3oGEv5lRphCkWAx8V04FMVrUOEzBVO7YB4J/lwI5S+KIntp2puqWZIUB/EVb9ebDqbc8pOja1k/anrUgCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277646; c=relaxed/simple;
	bh=I/HwupANQZNrDN72YfoYISTR/jnhtFvcCce7OTyzEPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T2G+jzyL/FgbNuo0yCTUC59uHHe64Lxin1kRvEzIGlMg1QrgUe3q+cBRJcOrE7wL86kcu/tTwHTa/b9cdASzjDLXJ4x5R/CUsNPNZt1CSC1nSMcZgsizzyepLUMxhFTrEa1OLC/pDfn/ynfisNbdHU+hHW0RYRp+dsWtAhsDanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQUR6D7s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9QnPo025715
	for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 13:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cErycuEc1BPG/yLEfc2IRSm6016iTOA8t+hzUspH65U=; b=QQUR6D7sbLdLbO7d
	yk0ql2PNHiYYPDXcKRtlvJXdUeyMAX3dfjIr6QyFopjtEXCHWPxIDnXR5/PG3mPi
	5Se8D9MZ4f6/CRj8oe2kwsJCm2aqBIzXcdwcc2Xxyyc78f+1DHRFfmKJvE+uBHAG
	4gSa6iBRSdidOG3jn8QLG6w6DtK9dRGg7Ey92LLo1V5kwUnOgdSXDVRzGU3UL/cJ
	PpaVEhWllGgwv7d5V0tJLBkuv6UIDh2k3QBC0bM+1i5ZK2LYp35khqrADTVs24w4
	ules2YRfLEqpH4phg8zWziSpbgKWdnXSCnqmlD9x2HWepMHdeAkbMiFDOQX7T/Me
	kJNbjQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ubtxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 13:34:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fd1dcf1c5bso10098526d6.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 06:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277641; x=1753882441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cErycuEc1BPG/yLEfc2IRSm6016iTOA8t+hzUspH65U=;
        b=WI7h8W2ArydRa0g/9PajmZH3/wtvK80WiKYZughfLhXeuru/gZCHHpNSGLhXcwCYK3
         wjvJ2V2aFJNUIozqQ7bTQIMCxSJ3sgDTvorL5co6BzzYtNODv59tAD+oJnRDt7Mu6exP
         wuUWonW32HLI5Fs+xw+PYznPH8AT3KMQ0h0tCdH/S4aV3DioEPj5krYF1/Mo8GJVRAZw
         kHZkJpugLYyyq/eY/JQ8q3R7neW5SP6EIIbkdzmc0bQ9W1SNdyyyRNBpqOStL0GW2jE2
         Q01Cavt3zCw3TyW8PfofYoPEfRlbqkjXrc+RfwwCqigWjhC14Lb/hFEL2pOyBUMxaKJ3
         Lrvw==
X-Forwarded-Encrypted: i=1; AJvYcCUxGF1Bphfu8v6tO54O2H9hmJW+nchPBQYC4umnnVSPqw81fywETHCEXte78DSwwPtlCjj/KBISoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfDI8G0NoRJgSD0txvu+WREKH5I5ltc1pHROJwBPoDzG4zQ/kv
	NTo0TpvYCqSq/luVLJJ7jTri9Mnj/5XKtKct6KOzhvgAVp75+6HDTQ4xxXUHo2BzmwS2pQP21sD
	cVWIgSXy+TM4wfrqDIuO2MRz2jhK9JZDjwD3dNIFPqmmZtIXj0plYx8ohK/QqIQ==
X-Gm-Gg: ASbGncv2ApHrfIrmb2VY46RgVJbBmYYxGpKoaB4dkPwWz/DAkXUKWjOmkCM50VhO5R+
	E0qtOtLEmMvHfrocQjzKH+nTNe27dg6QGK9kuOJ3nsBoqmdp+CG0lVwV73chennqjV0zqqCXWTY
	LGSoLCw+meIKZ6Pf9WSqiKM9Bta/4qPkV400MtFPcC8XBnYGHy7hWjHAX6PezittZ+UnMHslOL1
	+A9sCH7yjkZPD9oWeQjnHk0AvKsikny7U1Dh960HtV+HcTF7PyZrShBK8TtT6TxwDzTmBEsw2En
	f2o/9ozOZZRxhPV1VzVV6qKFmn9YrPR2+srYCNREA8XmwY9zNL5lXA9+MKt3CbQn+uy11t/i7qm
	OiwCoUitwgYOhJlhvcQ==
X-Received: by 2002:a05:620a:48e:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e62a1da96amr124748385a.13.1753277641267;
        Wed, 23 Jul 2025 06:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzYMNLS1GUA8u7+fQK+6rKxw7iDDU93TXDtPnP5+2dDFuZKetwr7kiUpYLhhOQk9KpRqg1Eg==
X-Received: by 2002:a05:620a:48e:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e62a1da96amr124746785a.13.1753277640829;
        Wed, 23 Jul 2025 06:34:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af244a659a4sm236451266b.22.2025.07.23.06.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:34:00 -0700 (PDT)
Message-ID: <277971b8-09d5-444d-b0eb-1e658b68029f@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 15:33:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, quic_srichara@quicinc.com, quic_mdalam@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250723110815.2865403-1-quic_varada@quicinc.com>
 <20250723110815.2865403-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723110815.2865403-5-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=6880e4ca cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=R0CBZZInQid6lz33ABQA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNiBTYWx0ZWRfX1UABBZXHQeAP
 6GT8g9dM0HCXqiUko5RPNBO0z+lFOCOzz5+KlmKuzumhYegzGpk24fNNlHdWCJOg/So/Xj0M2Bj
 4Dcj4fClmVF1+UBzzWt7gG0fbsak/idyHPN+IFZ9N8dOAgE3yKwHzThI9dYOUwyPpUOz1/A2nlR
 zLiEE5yZPVNhS3E2sqnNny/zIuxamhMBagcC6PkKRyW6T7vtv9NA/nw6P8W5uPxeGlUIqsuWdNa
 +BAEZXctL+wGSIixQ6xNslYSAvN7lsZ5zY5mWCJbZk8ct99ph8XK/62rvpF1LJ+hS5R7BKR53pW
 h4XpVMDcoFXXrIoajDWYlfe2OcXuqiTw4N9Cbs0+ovWDfToh3TQv3wNN4pJtG/V5SbTnr9b9YP4
 Kq56pLjfucTOa2WX8CIV8lepgszkKJZ2fC0e5BR2ZlxPs3l9Ui9/9DyQCLdfm1k/2Qy1OxjG
X-Proofpoint-ORIG-GUID: RrKnuS7rjud3h9ET8LPmxnjWv_A_qyAt
X-Proofpoint-GUID: RrKnuS7rjud3h9ET8LPmxnjWv_A_qyAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230116

On 7/23/25 1:08 PM, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
> CPU clock scaling.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Added interconnect related entries, fix dt-bindings errors ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Add 'interconnects' to cpu nodes
>     Add 'opp-peak-kBps' to opp table
>     Add '#interconnect-cells' to apss_clk
>     Remove unnecessary comment
>     Fix dt-binding-errors in qfprom node
> ---
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi | 65 +++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 2eea8a078595..39d394f49789 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>  #include <dt-bindings/clock/qcom,ipq5424-cmn-pll.h>
>  #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
>  #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
> @@ -52,6 +53,12 @@ cpu0: cpu@0 {
>  			reg = <0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&l2_0>;
> +			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
> +				 <&apss_clk L3_CORE_CLK>;

You exposed the latter clock through the interconnect framework. Now,
every set_rate/set_bw call will be fighting for whoever completes first.

Konrad

