Return-Path: <linux-pm+bounces-7496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0418BB9E8
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 10:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FD61C21291
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14EF4E7;
	Sat,  4 May 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eyutCsiu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0128EA;
	Sat,  4 May 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714809696; cv=none; b=oBoUMR+nFPxHUGK1RYZHkEtV3WDZbJK56DpaiSNfl5hTOed8W9DauExQNucYLb34cQsXbuT1TLCrx4NffCSKt9862ixlVI19GoR7oldiELzqM95Fs6X8KuBzNhpiJdhWTNPTmG13GhWIHh7Ii71CGPJWFhWfYwoTza5IJOMEa5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714809696; c=relaxed/simple;
	bh=U6WZzZKbEA0lnbJAvsjBxMcDOnhoQXC4iJmnwhPM5Z8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWCokYGJ3b5B6OJ/Ge2SWw+l/LlIld9sCOPw5nHCO6n/r8sA3uVhQ6fq05XZykT5LJv3gup8gEP6COsTLWCP3qFdyTP4QA5Hr8FFJfRQ0+UHGKp9Wkn4ek9tlqGdvTXKzDzQCoZT1Dhbey2GwK15b4eTI93q90FLXlAPAuuWeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eyutCsiu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4447g9xP026432;
	Sat, 4 May 2024 08:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=+6Mbl8PCq39bVOAadjMGu
	XgFbjxOzCts41TLEvEKtks=; b=eyutCsiuI7hXftSA2MoTIrSkwLwrJcCqWJaLi
	75MZL4J8F/RQWMytRgRLY7dJiGFuI37p5OEM0tZzb/H87fR9uhy0enQl9/YdzgbB
	+T2iHLrHDFDKLWpEgYt4Tqfoee+JlmT7UvL2f5Tmwtkd9rOAIjDHZ6lWpo3n0CcQ
	IClFfPypDGo7zTEFrZJAlHm8m7TiuIok1rZVdg/UiqS0ZSlWxkEewxfaZ14Re7o9
	xkme5gVacuWoDp9WzYhEkdMSJP1lanJ5O5zoATLknN1rXTN/Ei1DYSnsaEne2hxq
	7Xpd01DDUKArn1hi6ZLMm8xQ5col7NspmPQ6jy0AjADaga7VA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwc1c0c1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 08:01:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44481Sqc028949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 May 2024 08:01:28 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 4 May 2024 01:01:23 -0700
Date: Sat, 4 May 2024 13:31:19 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v11 0/6] Add interconnect driver for IPQ9574 SoC
Message-ID: <ZjXrTywO6+iRaEYk@hu-varada-blr.qualcomm.com>
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430064214.2030013-1-quic_varada@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: opBfPShReaSeGuYFaYc3g2cxm-g4KYMV
X-Proofpoint-ORIG-GUID: opBfPShReaSeGuYFaYc3g2cxm-g4KYMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_04,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040057

Bjorn,

> On Tue, Apr 30, 2024 at 12:12:08PM +0530, Varadarajan Narayanan wrote:
> MSM platforms manage NoC related clocks and scaling from RPM.
> However, in IPQ SoCs, RPM is not involved in managing NoC
> related clocks and there is no NoC scaling.
>
> However, there is a requirement to enable some NoC interface
> clocks for the accessing the peripherals present in the
> system. Hence add a minimalistic interconnect driver that
> establishes a path from the processor/memory to those peripherals
> and vice versa.
>
> Change icc-clk driver to take master and slave ids instead
> of auto generating.
>
> Currently, drivers/clk/qcom/clk-cbf-8996.c is the only user of
> icc-clk. And, it had exactly one master and one slave node.
> For this the auto generated master (= 1) and slave (= 0) was
> enough.
>
> However, when drivers/clk/qcom/gcc-ipq9574.c wanted to make use
> of the icc-clk framework, it had more number of master and slave
> nodes and the auto generated ids did not suit the usage.
>
> ---
> v11:	No code changes
> 	Commit log changed for the first patch
> 	Added Acked-By: to 3 patches

Can this be included in your driver changes for 6.10?

Thanks
Varada

> v10:	Set gcc-ipq9574 driver's sync_state to icc_sync_state
> v9:	Squash icc-clk driver change and cbf-msm8996 change
> 	Remove HWS_DATA macro
> v8:	Change icc-clk driver to take master and slave ids instead
> 	of auto generating
> 	Remove ICC_xxx defines from dt-bindings header
> 	Define MASTER/SLAVE_xxx macros from 0 .. n
>
> v7:	Fix macro names in dt-bindings header
> 	Do clock get in icc driver
>
> v6:	Removed 'Reviewed-by: Krzysztof' from dt-bindings patch
> 	Remove clock get from ICC driver as suggested by Stephen Boyd
> 	so that the actual peripheral can do the clock get
> 	first_id -> icc_first_node_id
> 	Remove tristate from INTERCONNECT_CLK
> v5:
> 	Split gcc-ipq9574.c and common.c changes into separate patches
> 	Introduce devm_icc_clk_register
> 	Fix error handling
> v4:
> gcc-ipq9574.c
> 	Use clk_hw instead of indices
> common.c
> 	Do icc register in qcom_cc_probe() call stream
> common.h
> 	Add icc clock info to qcom_cc_desc structure
>
> v3:
> qcom,ipq9574.h
> 	Move 'first id' define to clock driver
> gcc-ipq9574.c:
> 	Use indexed identifiers here to avoid confusion
> 	Fix error messages and move code to common.c as it can be
> 	shared with future SoCs
>
> v2:
> qcom,ipq9574.h
> 	Fix license identifier
> 	Rename macros
> qcom,ipq9574-gcc.yaml
> 	Include interconnect-cells
> gcc-ipq9574.c
> 	Update commit log
> 	Remove IS_ENABLED(CONFIG_INTERCONNECT) and auto select it from Kconfig
> ipq9574.dtsi
> 	Moved to separate patch
> 	Include interconnect-cells to clock controller node
> drivers/clk/qcom/Kconfig:
> 	Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK
>
> Varadarajan Narayanan (6):
>   interconnect: icc-clk: Specify master/slave ids
>   dt-bindings: interconnect: Add Qualcomm IPQ9574 support
>   interconnect: icc-clk: Add devm_icc_clk_register
>   clk: qcom: common: Add interconnect clocks support
>   clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
>   arm64: dts: qcom: ipq9574: Add icc provider ability to gcc
>
>  .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  2 +
>  drivers/clk/qcom/Kconfig                      |  2 +
>  drivers/clk/qcom/clk-cbf-8996.c               |  7 ++-
>  drivers/clk/qcom/common.c                     | 35 ++++++++++-
>  drivers/clk/qcom/common.h                     |  9 +++
>  drivers/clk/qcom/gcc-ipq9574.c                | 33 +++++++++++
>  drivers/interconnect/icc-clk.c                | 24 +++++++-
>  .../dt-bindings/interconnect/qcom,ipq9574.h   | 59 +++++++++++++++++++
>  include/linux/interconnect-clk.h              |  4 ++
>  10 files changed, 173 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
>
> --
> 2.34.1
>

