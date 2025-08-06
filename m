Return-Path: <linux-pm+bounces-31994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D83FB1C4F5
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7A561999
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB9B2376FC;
	Wed,  6 Aug 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lMiMLYjl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29000433C8;
	Wed,  6 Aug 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479886; cv=none; b=fXV3a2kGsPJl1wLBlpJUUJDtmCzdfjlgW9eghb9kpZdM8JpFsGpVSKLJUu2jF5UL59ZVHCGkOzUTPktoIK2Jo6aj6rakHlimVcoNNSk4KH7pJda9uP4u1M83nfyNMKn7e9Q1L8IM0z/l8kG1iICDEYGhOh6crACSmszITDvrhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479886; c=relaxed/simple;
	bh=ZuxRBd6jJ7SUjIF8DFJPPL4k5uJidCXY8nKkfs7swsw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPoPKTr7wKn9Hp60wWCq50WfEtc/UTWdnYQewWAGdrVXG/5NAO6PZ09zg+kO9vQR53ro5KyOwbMO5c19UTXQM2Rq+keJW+mgzyo/fwZljQm7Sf7esHKkmfccbV4BHdGpcHV6AUlq/9Qem2IhVOcWiCN17RYg5RzyGfbnJofPi4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lMiMLYjl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765Fg3D011200;
	Wed, 6 Aug 2025 11:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9uIL7Z9DYCMYxSkLuJ07zDMK
	DKvnjcJjKrLAyq9rKgw=; b=lMiMLYjlapsV3WkwpN35Q/IpqpPh+pnF62Ia1qk4
	35LP8PTeI0Z3Je4dbYm8GM1eFI05Y0sPRA7QL/SklmoLmES1wFM95/ewuONVKIoj
	JQKZIC28x1j9ukfxp2cBHu8+MG4ttk6f8piw9R+XGdRRnhcA6gPChRiRo1HinSia
	PWksAoJAMLMl8wRVUubi3FJh00Y7inpl6gLwt7GyoOd2Frqvs//aez0kaGMDqLyS
	XTezBqRkJiw6LMgkw4byCG7Ihb/6qFyBbtubh586lr0jBUg8idsy2cDoIc2XjYtP
	xEe1jXHkmKlpLk6+Is8Gi41sHeYE2mXvLLPZ4zNMzm7Ymw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw32jvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:31:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 576BVJ5I010229
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 11:31:19 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 04:31:13 -0700
Date: Wed, 6 Aug 2025 17:01:10 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        "Sricharan
 Ramabadhran" <quic_srichara@quicinc.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
Message-ID: <aJM8/pA7X5KH1eJ/@hu-varada-blr.qualcomm.com>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
 <20250804112041.845135-5-quic_varada@quicinc.com>
 <4890c832-3b78-4294-aaba-b62735f7934e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4890c832-3b78-4294-aaba-b62735f7934e@oss.qualcomm.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfXyAFyDBk6tXP8
 lQs9NcSwiuhUJi93i4rFxCt/P3WqG++qc73/D8UXHVrG6bqVutSJueNZRhdmQnvI3MAlpvh1gvZ
 bAIiLtt8pjqk/EEtVvPVuxhpndKCLVLqdLtAWi5brDIt9O48htyvYFhpYx/SW/fKE+xLJEX6G/Z
 WVFC1DJUKF3oQLBdC2qSCiy6PUrzfK+pI3vpHMH3B5oJRLAwlW/V467SE4kWTIiTePwrVMZBw4o
 rbq8uiQTYJGHuIJrO1dxO0LIsXKHf48Mhfc/gB20HFFl/ue6yqdh9tAfmRW8HRmubX+Sy4ugje8
 QHaRZD71dJb2FMsj+vlf4J9gJ0IxJ2dDC6YHXUHI46ohJhqZiIiJjAI1tLLjjGR/SxjJBJYMjvi
 41FamGDU
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=68933d08 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=s_Oo--g7qLRG9Z0-HlQA:9 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LHdlWfO724hTdmmN09zZKZNMSS5JTkKK
X-Proofpoint-ORIG-GUID: LHdlWfO724hTdmmN09zZKZNMSS5JTkKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On Mon, Aug 04, 2025 at 02:33:12PM +0200, Konrad Dybcio wrote:
> On 8/4/25 1:20 PM, Varadarajan Narayanan wrote:
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
> > +		opp-816000000 {
> > +			opp-hz = /bits/ 64 <816000000>;
> > +			opp-microvolt = <1>;
>
> I just noticed this.. I don't think we have CPUs this efficient just yet
>
> Do we know some real values for these?

Have fixed these and other comments and posted v6. Please take a look.

Thanks
Varada

