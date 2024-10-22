Return-Path: <linux-pm+bounces-16193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFCF9A9B7B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F641F22E9E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 07:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA3F1547C0;
	Tue, 22 Oct 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mudIEwTw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4813AD2A;
	Tue, 22 Oct 2024 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583449; cv=none; b=BUrXVH7DNFoL5etm2KUccvkzGH0o/ku9AcBCaeOoaoBTeUrSflUZgJhi3i2iFUW3pvdKqdIMLyOpIdFH1zB1oweepfbf6JlKZ9LSwzz0LJupF+45gpntZDrTjGVRTCAViPltCg2bMc2NyxJ5wXthUdwIaXW9et2XGl+db72bg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583449; c=relaxed/simple;
	bh=FFkqX8JXSwAe5nloeMb6u4fpSIZT16b4DjZAifoQqCQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz+xsfYuBW6vdukMd6wTFvqLR6MP/m4t9bi40pimCkRiSTyzh781qul2qDNRJT9KwhNFTLKUT7zvyL4MvYCnkoDI2jSBGUHY0yZG81gZKddktYKB1OXakj0goMBQsEL1vU+91OnhdYjuC+rfhG6fhmipsTnhOkjmUoDGqScj6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mudIEwTw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LI0wrf012434;
	Tue, 22 Oct 2024 07:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=E3OAqgJqJplSETmxkoQm58tf
	JNZ2u+eymO4b66DsCoM=; b=mudIEwTw6qoSU1vE1u/KUoDo0/Pa/uha++bS9Ltq
	Fy8K+4p6tfC126fkakCd4UaucGEPXKk6v/IW+K3RZe25FUgXwD14thhwpU/xSXKz
	JRVxMVhL6el7v36GC9vYUoh86IJTW4NPQWWcYcDS1F1/V9pafiUd0q5dfZLq+iv2
	/uh3pgzYlVPTGpVGA7/GRVp+oQXGyCpYVoKkT5QNkvORYvPIs3nK3Q47P4p5XN6i
	oXXNc1UenH2hvwXWmpaHvsf7lGPaPABxgXq0qd8qkuY83b4SA65c/stwpDcw5IhK
	dzCnKUxoJahaFEnzwp5GTwxpCG2awaH+fjt8pO5iOJAXJw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vc7fv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 07:50:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49M7oRTn002734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 07:50:27 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 00:50:21 -0700
Date: Tue, 22 Oct 2024 13:20:16 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <djakov@kernel.org>, <richardcochran@gmail.com>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <arnd@arndb.de>, <nfraprado@collabora.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: Re: [PATCH v5 7/8] arm64: dts: qcom: ipq5332: add support for the
 NSSCC
Message-ID: <ZxdZONgqUag9kJ2L@hu-varada-blr.qualcomm.com>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-8-quic_varada@quicinc.com>
 <hvbrd7lyf4zjhwphxiephohuoy7olmqb5hxsa4qnidmuuae45p@swezjh3lfpzi>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <hvbrd7lyf4zjhwphxiephohuoy7olmqb5hxsa4qnidmuuae45p@swezjh3lfpzi>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jzr-NvcTDyNsO1DpnpI8DxZ-0T4akIq3
X-Proofpoint-ORIG-GUID: Jzr-NvcTDyNsO1DpnpI8DxZ-0T4akIq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=956 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220049

On Thu, Aug 29, 2024 at 01:21:20PM +0300, Dmitry Baryshkov wrote:
> On Thu, Aug 29, 2024 at 01:58:29PM GMT, Varadarajan Narayanan wrote:
> > From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> >
> > Describe the NSS clock controller node and it's relevant external
> > clocks.
>
> Who generates these clocks? 300 MHz crystal?

These two clocks are from the output clocks of CMN PLL.
IPQ5332 CMN PLL patches similar to [1] are in the pipeline
and should get posted soon.

1: https://lore.kernel.org/all/20241015-qcom_ipq_cmnpll-v4-0-27817fbe3505@quicinc.com/

Thanks
Varada

> > Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v5: Remove #power-domain-cells
> >     Add #interconnect-cells
> > ---
> >  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 28 +++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > index 71328b223531..1cc614de845c 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> > @@ -16,6 +16,18 @@ / {
> >  	#size-cells = <2>;
> >
> >  	clocks {
> > +		cmn_pll_nss_200m_clk: cmn-pll-nss-200m-clk {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <200000000>;
> > +			#clock-cells = <0>;
> > +		};
> > +
> > +		cmn_pll_nss_300m_clk: cmn-pll-nss-300m-clk {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <300000000>;
> > +			#clock-cells = <0>;
> > +		};
> > +
> >  		sleep_clk: sleep-clk {
> >  			compatible = "fixed-clock";
> >  			#clock-cells = <0>;
> > @@ -479,6 +491,22 @@ frame@b128000 {
> >  				status = "disabled";
> >  			};
> >  		};
> > +
> > +		nsscc: clock-controller@39b00000 {
> > +			compatible = "qcom,ipq5332-nsscc";
> > +			reg = <0x39b00000 0x80000>;
> > +			clocks = <&cmn_pll_nss_200m_clk>,
> > +				 <&cmn_pll_nss_300m_clk>,
> > +				 <&gcc GPLL0_OUT_AUX>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>,
> > +				 <&xo_board>;
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +			#interconnect-cells = <1>;
> > +		};
> >  	};
> >
> >  	timer {
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

