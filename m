Return-Path: <linux-pm+bounces-31670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68EB16D6A
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162465A26AA
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A9C21A92F;
	Thu, 31 Jul 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GYRs2AzV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1D82C60;
	Thu, 31 Jul 2025 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950054; cv=none; b=k6QCYae4fSOFIu3HNoQaYCJuJMxhPgXS3+12tXmNrpmX6PTfbHXhE3BPAqhPGVrZh7GcLBIl0lEoEfny3vHF/vmnDSsFbftuaRBsyP+TQPbcLGuFauGHo7Op1yzyuJky1VwyfuS6YJhhMhST7LhDJ0vTOUkNWmvdhb8TLdI3G5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950054; c=relaxed/simple;
	bh=DVVdYUQhNXrT8nIZN7oHoaqViY3lQdp3bi8pSnyiBuE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c62IUlo0hb/qZtf7Dt67Rn7t83OgGPSqri3Dh3ANrj0jYfsrCiyT9Xxsn/hoBGul4cJGtxGTGrYJopgGlFinrCm5WgnJIa30cVHAHfHjfcfUCgAXs2zgDXi2xcvRVAXxuD9QkOGzrrJU7RnbwmJcmv5mPJcmeIt+ib7EkY/Op8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GYRs2AzV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fXsi003474;
	Thu, 31 Jul 2025 08:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mG/9O/5shgU2wVXynKChJyvr
	rVAhnyuanNYOCUrEHoo=; b=GYRs2AzVALbBtvVraYTN9CTHugzhVTJjJdqreJoi
	mAn2RGkIv0TWZFZZj+k6H25riuyYmft1U/uNh78nPihtTQU9hmOvvrdpfQlcnBri
	2QrVxvFT7aRAr3O05hgmdhJo1bR0/QqpW6RoIpHIebHF6x3IHw5J5ovRHEX6RoIb
	db8L35fUpRwPA95w3a/s2B8t31cLh1fiiTG9kJ84Aw8Z+9dxzNV/8jE2lAFph9kA
	OjS48ZRbMSWYds3AH4/LW6x6vrtji6UB1qFXQvD62L/77bZNhd9Fp0cBRLqFaCgx
	TI215cPxSlXK0G1Nu5evsll+jWUNhwzWlxBLnMfrLwvT3w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwgbcpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 08:20:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56V8Klx0012337
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 08:20:47 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 31 Jul 2025 01:20:42 -0700
Date: Thu, 31 Jul 2025 13:50:38 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
Message-ID: <aIsnVuWnwBisCm82@hu-varada-blr.qualcomm.com>
References: <20250730081316.547796-1-quic_varada@quicinc.com>
 <20250730081316.547796-5-quic_varada@quicinc.com>
 <b51305cd-0e4f-49f9-adc1-fbe83b539e98@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b51305cd-0e4f-49f9-adc1-fbe83b539e98@oss.qualcomm.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688b2760 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=RPjSdeSmNi3ZrBCKw2EA:9 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Nq5ExcuO0SAtTQr9-7fWVEkMv8IrQ25o
X-Proofpoint-GUID: Nq5ExcuO0SAtTQr9-7fWVEkMv8IrQ25o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA1NiBTYWx0ZWRfXwTStoN9aK3cq
 YX72oyK7bfMsLB2s7AZ/GTSK+Hat7xeTAV6ohC5eIzqPy8wXEfVeaA94nAP6Gjq+JnIOPWllZJy
 k5nb2hE/CuDafGiWP7V/QTTdiU+TFqopJt+ljoTX+WODzdh0avehoc0iWopb3ZvKRn7BFRQIysq
 eR+O1r6DaVzHxtOiH69v/ZbGb9kpx5uKm2Qa9kqcdmfqIYbPLAO0XtXsYe0VXDbvaF7VCQsYELi
 an/x2kAMZnKhuAbIiVG3jKV4f3ndh1COTtROWgEzo0Ai+8cBZV8BGwJvH522C0iy/T5WRAySrec
 8OqWgx4Kc5ViXtEnVPFyEAf8WLNRttHTncuhWsmgJWNUNuKTuSMBvlv2k0P3ngSXnq1r9m3hAZW
 V1WE7EVqxCIJBhHfYaByY0b/0KWCot0L1AyGx4q564bTwCY+n7T/6PMl8BbORY9HWaREtdGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=585 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310056

On Wed, Jul 30, 2025 at 02:49:58PM +0200, Konrad Dybcio wrote:
> On 7/30/25 10:13 AM, Varadarajan Narayanan wrote:
> > From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >
> > Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
> > CPU clock scaling.
> >
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > [ Added interconnect related entries, fix dt-bindings errors ]
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> [...]
>
> > +	cpu_opp_table: opp-table-cpu {
> > +		compatible = "operating-points-v2-kryo-cpu";
> > +		opp-shared;
> > +		nvmem-cells = <&cpu_speed_bin>;
> > +
> > +		opp-1416000000 {
>
> These rates seem quite high, are there no lower fstates for idling?

Will check on this and update.

> > +			opp-hz = /bits/ 64 <1416000000>;
> > +			opp-microvolt = <1>;
> > +			opp-supported-hw = <0x3>;
> > +			clock-latency-ns = <200000>;
> > +			opp-peak-kBps = <984000>;
> > +		};
> > +
> > +		opp-1800000000 {
> > +			opp-hz = /bits/ 64 <1800000000>;
> > +			opp-microvolt = <2>;
> > +			opp-supported-hw = <0x1>;
> > +			clock-latency-ns = <200000>;
> > +			opp-peak-kBps = <1272000>;
> > +		};
> > +	};
> > +
> >  	memory@80000000 {
> >  		device_type = "memory";
> >  		/* We expect the bootloader to fill in the size */
> > @@ -388,6 +428,18 @@ system-cache-controller@800000 {
> >  			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> >  		};
> >
> > +		qfprom@a6000 {
> > +			compatible = "qcom,ipq5424-qfprom", "qcom,qfprom";
> > +			reg = <0x0 0x000a6000 0x0 0x1000>;
>
> The block is a bit bigger

Per the documentation, the block is 4KB. But the last register is at 0xa62bc.

> On IPQ platforms, can the OS blow fuses directly without TZ
> interference?

No.

> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +
> > +			cpu_speed_bin: cpu-speed-bin@234 {
> > +				reg = <0x234 0x1>;
> > +				bits = <0 8>;
> > +			};
> > +		};
> > +
> >  		tlmm: pinctrl@1000000 {
> >  			compatible = "qcom,ipq5424-tlmm";
> >  			reg = <0 0x01000000 0 0x300000>;
> > @@ -730,6 +782,15 @@ frame@f42d000 {
> >  			};
> >  		};
> >
> > +		apss_clk: clock@fa80000 {
> > +			compatible = "qcom,ipq5424-apss-clk";
> > +			reg = <0x0 0x0fa80000 0x0 0x20000>;
>
> Let's make it 0x30_000 to reserve the actual carved out reg space

ok.

> > +			clocks = <&xo_board>, <&gcc GPLL0>;
> > +			clock-names = "xo", "clk_ref";
>
> 1 per line would be perfect

Sure.

Thanks
Varada

