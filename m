Return-Path: <linux-pm+bounces-8930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0700A903813
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 11:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B9D281E50
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EB2176AD7;
	Tue, 11 Jun 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FWtA8+nt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29317624A;
	Tue, 11 Jun 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098952; cv=none; b=hwOFjkiH/49nRPmx6TE+fNO8RrEhm6jbA0q6EoNPFZk8mrCP8lDazG39HdbZ+SeijjuzVjDq8UA/ZV8o78KSuyVj+ztli0kzE9EX9bOJVvOLW88cE0bZfIQDMwXLCe5n2WJ83OgGSGxJZ7YVBAXSCTNsDjDEznfaA8nLKqxv2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098952; c=relaxed/simple;
	bh=vmcw0LoEb2KYPpqCFEmI5BlvDCI6GwFkzcgF2Y7u/DA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orMPhfum8fnY8u76az57XTsqjI0rm5rCs+aIM6vbx418v7Rus9nDTtdiCMZUJfaLWwOhItfu+rit2KMVI/PipeO/XgL1OOSycwEKXAvFnGABYrZsxJ7kzfZ+Q27KAplENGqgDLKOwMgZ6HGnCPvbA3cvcj53HiUYw/m5uw8GvvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FWtA8+nt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B2qdon024313;
	Tue, 11 Jun 2024 09:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4cDv83/EReSbO2bcNeU4T7lO
	TBkKY0tXj81oN6i5QT0=; b=FWtA8+ntrlZ2+XgaDmj30WDTL1gGuL0A5i2g1l0V
	Ahkh4VntEJujQ0veP8uxja+RzPDdwwzM/N+zOfJ+NxBcAZYrerqNsFw6jvnBF4On
	swYr22huRTU/cOXDk5GuH0Gl4h66AHX6tt7BP3FUOJ+udaptzd1yPQcky+KR2gaF
	eyOtwQp0Bcc+SOI++6Z+IVyD/DmifxyMu/yfUSKGHnD6m8OdIL3FX1eoSR9QsBjJ
	0sDZCokn8knOxqabSp2ASMP+wg2TuNrH/Vb6qf0tq9V2ydZyukuABOioHdfkoyE6
	ojQ4WEMQK0hM/+FGanQLJIcca30EI8KXId24xbJ7k4gKPw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymd0eehk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 09:42:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B9gPk6009672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 09:42:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Jun 2024 02:42:20 -0700
Date: Tue, 11 Jun 2024 15:12:16 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
Message-ID: <Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com>
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-7-quic_varada@quicinc.com>
 <a7194edd-a2c8-46fc-bea1-f26b0960e535@linaro.org>
 <Ziov6bWBXYXJ4Zp8@hu-varada-blr.qualcomm.com>
 <27f4f3dd-9375-40cf-8c8f-1c4edf66e31b@linaro.org>
 <ZjNdTmmXucjtRxJt@hu-varada-blr.qualcomm.com>
 <c015b3a5-2213-4ebd-b960-d97ed1fe7062@kernel.org>
 <ZjshR0ekcn0gxwOa@hu-varada-blr.qualcomm.com>
 <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>
 <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _-L6S3pVII9ef9_o7MLi0E3pCivFMPxi
X-Proofpoint-ORIG-GUID: _-L6S3pVII9ef9_o7MLi0E3pCivFMPxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_05,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110073

On Thu, Jun 06, 2024 at 04:06:01PM +0200, Konrad Dybcio wrote:
> On 8.05.2024 10:10 AM, Dmitry Baryshkov wrote:
> > On Wed, 8 May 2024 at 09:53, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> >>
> >> On Fri, May 03, 2024 at 04:51:04PM +0300, Georgi Djakov wrote:
> >>> Hi Varada,
> >>>
> >>> Thank you for your work on this!
> >>>
> >>> On 2.05.24 12:30, Varadarajan Narayanan wrote:
> >>>> On Tue, Apr 30, 2024 at 12:05:29PM +0200, Konrad Dybcio wrote:
> >>>>> On 25.04.2024 12:26 PM, Varadarajan Narayanan wrote:
> >>>>>> On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 4/18/24 11:23, Varadarajan Narayanan wrote:
> >>>>>>>> IPQ SoCs dont involve RPM in managing NoC related clocks and
> >>>>>>>> there is no NoC scaling. Linux itself handles these clocks.
> >>>>>>>> However, these should not be exposed as just clocks and align
> >>>>>>>> with other Qualcomm SoCs that handle these clocks from a
> >>>>>>>> interconnect provider.
> >>>>>>>>
> >>>>>>>> Hence include icc provider capability to the gcc node so that
> >>>>>>>> peripherals can use the interconnect facility to enable these
> >>>>>>>> clocks.
> >>>>>>>>
> >>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>>>>>> ---
> >>>>>>>
> >>>>>>> If this is all you do to enable interconnect (which is not the case,
> >>>>>>> as this patch only satisfies the bindings checker, the meaningful
> >>>>>>> change happens in the previous patch) and nothing explodes, this is
> >>>>>>> an apparent sign of your driver doing nothing.
> >>>>>>
> >>>>>> It appears to do nothing because, we are just enabling the clock
> >>>>>> provider to also act as interconnect provider. Only when the
> >>>>>> consumers are enabled with interconnect usage, this will create
> >>>>>> paths and turn on the relevant NOC clocks.
> >>>>>
> >>>>> No, with sync_state it actually does "something" (sets the interconnect
> >>>>> path bandwidths to zero). And *this* patch does nothing functionally,
> >>>>> it only makes the dt checker happy.
> >>>>
> >>>> I understand.
> >>>>
> >>>>>> This interconnect will be used by the PCIe and NSS blocks. When
> >>>>>> those patches were posted earlier, they were put on hold until
> >>>>>> interconnect driver is available.
> >>>>>>
> >>>>>> Once this patch gets in, PCIe for example will make use of icc.
> >>>>>> Please refer to https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/.
> >>>>>>
> >>>>>> The 'pcieX' nodes will include the following entries.
> >>>>>>
> >>>>>>         interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
> >>>>>>                         <&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
> >>>>>>         interconnect-names = "pcie-mem", "cpu-pcie";
> >>>>>
> >>>>> Okay. What about USB that's already enabled? And BIMC/MEMNOC?
> >>>>
> >>>> For USB, the GCC_ANOC_USB_AXI_CLK is enabled as part of the iface
> >>>> clock. Hence, interconnect is not specified there.
> >>>>
> >>>> MEMNOC to System NOC interfaces seem to be enabled automatically.
> >>>> Software doesn't have to turn on or program specific clocks.
> >>>>
> >>>>>>> The expected reaction to "enabling interconnect" without defining the
> >>>>>>> required paths for your hardware would be a crash-on-sync_state, as all
> >>>>>>> unused (from Linux's POV) resources ought to be shut down.
> >>>>>>>
> >>>>>>> Because you lack sync_state, the interconnects silently retain the state
> >>>>>>> that they were left in (which is not deterministic), and that's precisely
> >>>>>>> what we want to avoid.
> >>>>>>
> >>>>>> I tried to set 'sync_state' to icc_sync_state to be invoked and
> >>>>>> didn't see any crash.
> >>>>>
> >>>>> Have you confirmed that the registers are actually written to, and with
> >>>>> correct values?
> >>>>
> >>>> I tried the following combinations:-
> >>>>
> >>>> 1. Top of tree linux-next + This patch set
> >>>>
> >>>>     * icc_sync_state called
> >>>>     * No crash or hang observed
> >>>>     * From /sys/kernel/debug/clk/clk_summary can see the
> >>>>       relevant clocks are set to the expected rates (compared
> >>>>       with downstream kernel)
> >>>>
> >>>> 2. Top of tree linux-next + This patch set + PCIe enablement
> >>>>
> >>>>     * icc_sync_state NOT called
> >>>
> >>> If sync_state() is not being called, that usually means that there
> >>> are interconnect consumers that haven't probed successfully (PCIe?)
> >>> or their dependencies. That can be checked in /sys/class/devlink/.../status
> >>> But i am not sure how this works for PCI devices however.
> >>>
> >>> You can also manually force a call to sync_state by writing "1" to
> >>> the interconnect provider's /sys/devices/.../state_synced
> >>>
> >>> Anyway, the question is if PCIe and NSS work without this driver?
> >>
> >> No.
> >>
> >>> If they work, is this because the clocks are turned on by default
> >>> or by the boot loader?
> >>
> >> Initially, the PCIe/NSS driver enabled these clocks directly
> >> by having them in their DT nodes itself. Based on community
> >> feedback this was removed and after that PCIe/NSS did not work.
> >>
> >>> Then if an interconnect path (clock) gets disabled either when we
> >>> reach a sync_state (with no bandwidth requests) or we explicitly
> >>> call icc_set_bw() with 0 bandwidth values, i would expect that
> >>> these PCIe and NSS devices would not function anymore (it might
> >>> save some power etc) and if this is unexpected we should see a
> >>> a crash or hang...
> >>>
> >>> Can you confirm this?
> >>
> >> With ICC enabled, icc_set_bw (with non-zero values) is called by
> >> PCIe and NSS drivers. Haven't checked with icc_set_bw with zero
> >> values.
> >>
> >> PCIe:   qcom_pcie_probe -> qcom_pcie_icc_init -> icc_set_bw
> >> NSS:    ppe_icc_init -> icc_set_bw
> >>
> >> I believe sync_state is not getting called since there is a
> >> non-zero set bandwidth request. Which seems to be aligned with
> >> your explanation.
> >
> > This doesn't look correct. sync_state is being called once all
> > consumers are probed. It doesn't matter whether those consumers have
> > non-zero bandwidth requests or no.
>
> /sys/kernel/debug/devices_deferred may have some useful info, too

/sys/kernel/debug/devices_deferred seems to be empty

	# mount | grep -w debugfs
	none on /sys/kernel/debug type debugfs (rw,relatime)

	# cat /sys/kernel/debug/devices_deferred  | wc -l
	0

Added the following print to icc_sync_state,

	@@ -1096,6 +1096,7 @@ void icc_sync_state(struct device *dev)
		struct icc_node *n;
		static int count;

	+	printk("--> %s: %d %d\n", __func__, providers_count, count);
		count++;

		if (count < providers_count)
			return;

icc_sync_state seems to be called once,

	# dmesg | grep icc_sync_state
	[   12.260544] --> icc_sync_state: 2 0

Since 'providers_count' is greated than 'count' icc_sync_state
seems to return before doing anything.

Thanks
Varada

