Return-Path: <linux-pm+bounces-10171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E06991BA59
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 10:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A8E1F22F6D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E65914BF89;
	Fri, 28 Jun 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pbf77/b+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788A2139D4;
	Fri, 28 Jun 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564507; cv=none; b=D9M1ux4v/SvU9MNCX/cXOCHr4i4AY1W3+rqgLQIIfBjTk7jxJ41QtsM/JQ46UH2mBaQtL/EW6zcOIEkD6RXfXWMuQ31CmGIphEV4kzro/JCqbaJw+hkIXk3QJh79NyVUG5gHOPij9Uj9sP36J7EfgzcTgQMbdJlqpgERlF/OgOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564507; c=relaxed/simple;
	bh=5583eqhtGvPr11ryz4ZpEypX9g+qKSFTog1c7ZcLsuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCNGqQ5AbNKrRs+0Xcc+Ch3Fkii86NEnWdzOspsozATsoSsPMsgGaDHed0MeXW8X6CS8T2jp6FlFmWJ7MIfq+/DFzeQfjUyNygDfn9CI2X+2vEf8LuRt6y/93Jj0u9+y/PzBD2n+p+kM1MiBw33K5TqYn+i5j3pqRwb94brK5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pbf77/b+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S4wZmK032242;
	Fri, 28 Jun 2024 08:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xtV+MoUKKNww7l9Qxey8uYdd
	oo65kVVgk6K8vmnP6EY=; b=pbf77/b+YkkLdSr+qpRBdzeN0QVBQwayXPDHWaZ5
	iMHofBY1eNve9lpXVnf5uXsRkAMcZ8zTlok8QHWaxs4lfLpBqidxJPQ2PuIHcJlS
	0wv22HTA1WmCxXt4gD/OkrVbjNf7CnO2nto6/LPaGcno6p0WeZxwVPTanCs9uf+s
	5RUlPSkTvKvVY4oGcin2+nNiRWDQJf5X3HnjN8lrzl/Ocynn5PiO1Vpk005JuFij
	ZzDf5v2Wf7z7joPrMbsX+V+nnnPbup7sGhB4mvHqVIGwdMY6HqyUA3k4hg7DF3Nx
	woBIJSTO/OMSq4glag5k8rTYhbEyT4JVIH/zUQNDtjX3ag==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 401pm58m8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 08:48:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45S8mFaf019395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 08:48:15 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 01:48:10 -0700
Date: Fri, 28 Jun 2024 14:18:06 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
Message-ID: <Zn54xhM/qfBv58e2@hu-varada-blr.qualcomm.com>
References: <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
 <Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com>
 <176137e5-6312-4d46-97b6-c4494bc1c61b@kernel.org>
 <ZmlAdETV0+6Md8HC@hu-varada-blr.qualcomm.com>
 <e24cfd23-6f77-46a0-b020-9cb3daef6930@kernel.org>
 <Zml4RQ5R5s3mVMnI@hu-varada-blr.qualcomm.com>
 <8e32a8be-dbbf-49ca-92a1-2fe3c8bfb571@kernel.org>
 <ZmpsOdsl9AMTSH88@hu-varada-blr.qualcomm.com>
 <ZnKKjomRQtJS2ZgL@hu-varada-blr.qualcomm.com>
 <9938a67b-1f6b-4955-b4c0-a9f78c55f276@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9938a67b-1f6b-4955-b4c0-a9f78c55f276@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lLyucKUWU34WsxEbmbU0wbWK5G-MyKc0
X-Proofpoint-ORIG-GUID: lLyucKUWU34WsxEbmbU0wbWK5G-MyKc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_04,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280064

On Thu, Jun 27, 2024 at 12:00:35AM +0200, Konrad Dybcio wrote:
> On 19.06.2024 9:36 AM, Varadarajan Narayanan wrote:
>
> [...]
>
>
> > Tested the patches with both gcc and nsscc providers having
> > 'sync_state' set to icc_sync_state.
> >
> > 	# dmesg | grep synced
> > 	[    3.029820] qcom,gcc-ipq9574 1800000.clock-controller: interconnect provider is in synced state
> > 	[    3.470106] qcom,nsscc-ipq9574 39b00000.clock-controller: interconnect provider is in synced state
> >
> > I can see that icc_sync_state is getting called and clocks
> > related to paths with zero bandwidth are getting disabled.
> >
> > Will post the NSSCC patches to get the full picture.
>
> Going back to the original question, does removing interconnects = from
> things like PCIe now make them not work / crash the device, which would
> indicate the NoC clocks were indeed gated?

Yes. With and without 'interconnects =', the following behaviour
is same
	* Boot completes
	* PCIe devices were probed succesfully and can be
	  seen in /proc/bus/pci/devices.
	* icc_sync_state is called. The system has 4 pcie nodes
	  in the DT, out of which pcie0 is not enabled.

The difference is seen in icc_sync_state

    With 'interconnects ='

	* During icc_sync_state, the following 2 clocks
	  corresponding to the interconnects of 'pcie0' get
	  disabled.

	[    2.986356] ---> clk_core_disable_lock: gcc_anoc_pcie0_1lane_m_clk
	[    3.012486] ---> clk_core_disable_lock: gcc_snoc_pcie0_1lane_s_clk

	* System shutdown also completes without issues

    Without the 'interconnects =',

	* During icc_sync_state, the following clocks
	  corresponding to the interconnects of all the 4 PCIe
	  nodes get disabled.

	[    2.887860] ---> clk_core_disable_lock: gcc_anoc_pcie0_1lane_m_clk
	[    2.913988] ---> clk_core_disable_lock: gcc_snoc_pcie0_1lane_s_clk
	[    2.939857] ---> clk_core_disable_lock: gcc_anoc_pcie1_1lane_m_clk
	[    2.965725] ---> clk_core_disable_lock: gcc_snoc_pcie1_1lane_s_clk
	[    2.991594] ---> clk_core_disable_lock: gcc_anoc_pcie2_2lane_m_clk
	[    3.017463] ---> clk_core_disable_lock: gcc_snoc_pcie2_2lane_s_clk
	[    3.043328] ---> clk_core_disable_lock: gcc_anoc_pcie3_2lane_m_clk
	[    3.069201] ---> clk_core_disable_lock: gcc_snoc_pcie3_2lane_s_clk

	* System shutdown hangs (possibly due to un-clocked
	  access of PCIe register) in pcie_pme_interrupt_enable

		[   10.773134]  dump_stack+0x18/0x24
		[   10.776779]  pcie_pme_remove+0x2c/0x88
		[   10.780078]  pcie_port_remove_service+0x50/0x74
		[   10.783725]  device_remove+0x12c/0x148
		[   10.788151]  __device_release_driver+0x65c/0x8cc
		[   10.791972]  device_release_driver+0x2c/0x44
		[   10.796746]  bus_remove_device+0xcc/0x10c
		[   10.800999]  device_del+0x14c/0x400
		[   10.804904]  device_unregister+0x18/0x34
		[   10.808203]  remove_iter+0x2c/0x3c
		[   10.812369]  device_for_each_child+0x60/0xb4
		[   10.815583]  pcie_portdrv_shutdown+0x34/0x90
		[   10.820009]  pci_device_shutdown+0x34/0x74
		[   10.824263]  device_shutdown+0x150/0x258
		[   10.828169]  kernel_restart_prepare+0x98/0xbc
		[   10.832249]  kernel_restart+0x44/0x110
		[   10.836502]  __do_sys_reboot+0x18c/0x304

I believe, this is confirms NOC clocks getting disabled by
icc_sync_state.

Thanks
Varada

