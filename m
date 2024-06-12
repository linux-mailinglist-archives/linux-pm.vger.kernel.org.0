Return-Path: <linux-pm+bounces-9013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABABF90505E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3314A1F22CB9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7EE16EBE9;
	Wed, 12 Jun 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OOZo2BLi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA90016D9D7;
	Wed, 12 Jun 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188120; cv=none; b=BFfYO7U7FmIOAaLP+xFJutnAuTksgg3FGIeIqfj2w3H7qha9/U3iGER4VDs3YmaocEYrt2EbfVilO7jYTIG4mWQv2kqOXAPnQD48Y2Q7lhmr1YIla8o7eY5hLHCQhJsR6jsiYDPyoJM4Afm3ywUlbzDqC9lVMCor0o6hnukkawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188120; c=relaxed/simple;
	bh=DqDmBfyPccLDacPbh+TeEIUHPb11wuDh/LGPb58lvC8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjhRH8gvmiSXQlVAFmcJWyTjx3NFBbbUXySFFYpl/d4UbLq+ZemmRRnXv41KuGN5JpN5QzRgp2jkKMYGDQnKBfVF/0zYfCa8DypIyd+ygRekhFvbomB+NSheWvwWI+3dadyi92P4/RwZY+sD0zaryAkB30FCfEfhH/S/+XsnfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OOZo2BLi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C1ub3b009732;
	Wed, 12 Jun 2024 10:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=madimlA9iBPfjtpX9TuxWdHY
	1DKpi5ag8HsBR+wtnVY=; b=OOZo2BLiF9eeK4d6ZILTT9Mu0BgqvNGq86nkm32q
	ONip/osxKpueMJD45jL/7FvbQ/HCWgGQ0CFg6p7rJOXooTi0yAE7+yM09ZIP+m94
	tbL+AeFPmLUgHlRvbALIelclARi9wnhaS0U5bUJgVDed42ByGGx2T3Cs2LLVx2+p
	ZqbYsKPeR/kAHqnIiUwECINF3aJeep7KWBDyUdE3nW182mtSRpWJM1gB9eM7247f
	vT6xKKSnezaEoSS+X8Wy5VD6n7ITvGTPoDpU9cDZyjP2NsyEiok+aM8lvX30myA0
	pOvkpU027Sesg88MLQdbEmGXJ9WqxjJwSWxGUk2OlCYcrA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ype913y2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:28:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CASUTf000347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:28:30 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Jun 2024 03:28:25 -0700
Date: Wed, 12 Jun 2024 15:58:21 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
Message-ID: <Zml4RQ5R5s3mVMnI@hu-varada-blr.qualcomm.com>
References: <27f4f3dd-9375-40cf-8c8f-1c4edf66e31b@linaro.org>
 <ZjNdTmmXucjtRxJt@hu-varada-blr.qualcomm.com>
 <c015b3a5-2213-4ebd-b960-d97ed1fe7062@kernel.org>
 <ZjshR0ekcn0gxwOa@hu-varada-blr.qualcomm.com>
 <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>
 <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
 <Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com>
 <176137e5-6312-4d46-97b6-c4494bc1c61b@kernel.org>
 <ZmlAdETV0+6Md8HC@hu-varada-blr.qualcomm.com>
 <e24cfd23-6f77-46a0-b020-9cb3daef6930@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e24cfd23-6f77-46a0-b020-9cb3daef6930@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UJjWuV05zfhtyUYc1s0wJoZwO7b2A1aH
X-Proofpoint-ORIG-GUID: UJjWuV05zfhtyUYc1s0wJoZwO7b2A1aH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406120075

On Wed, Jun 12, 2024 at 11:48:17AM +0300, Georgi Djakov wrote:
> On 12.06.24 9:30, Varadarajan Narayanan wrote:
> > On Tue, Jun 11, 2024 at 02:29:48PM +0300, Georgi Djakov wrote:
> > > On 11.06.24 12:42, Varadarajan Narayanan wrote:
> > > > On Thu, Jun 06, 2024 at 04:06:01PM +0200, Konrad Dybcio wrote:
> > > > > On 8.05.2024 10:10 AM, Dmitry Baryshkov wrote:
> > > > > > On Wed, 8 May 2024 at 09:53, Varadarajan Narayanan
> > > > > > <quic_varada@quicinc.com> wrote:
> > > > > > >
> > > > > > > On Fri, May 03, 2024 at 04:51:04PM +0300, Georgi Djakov wrote:
> > > > > > > > Hi Varada,
> > > > > > > >
> > > > > > > > Thank you for your work on this!
> > > > > > > >
> > > > > > > > On 2.05.24 12:30, Varadarajan Narayanan wrote:
> > > > > > > > > On Tue, Apr 30, 2024 at 12:05:29PM +0200, Konrad Dybcio wrote:
> > > > > > > > > > On 25.04.2024 12:26 PM, Varadarajan Narayanan wrote:
> > > > > > > > > > > On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > On 4/18/24 11:23, Varadarajan Narayanan wrote:
> > > > > > > > > > > > > IPQ SoCs dont involve RPM in managing NoC related clocks and
> > > > > > > > > > > > > there is no NoC scaling. Linux itself handles these clocks.
> > > > > > > > > > > > > However, these should not be exposed as just clocks and align
> > > > > > > > > > > > > with other Qualcomm SoCs that handle these clocks from a
> > > > > > > > > > > > > interconnect provider.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hence include icc provider capability to the gcc node so that
> > > > > > > > > > > > > peripherals can use the interconnect facility to enable these
> > > > > > > > > > > > > clocks.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > > > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > If this is all you do to enable interconnect (which is not the case,
> > > > > > > > > > > > as this patch only satisfies the bindings checker, the meaningful
> > > > > > > > > > > > change happens in the previous patch) and nothing explodes, this is
> > > > > > > > > > > > an apparent sign of your driver doing nothing.
> > > > > > > > > > >
> > > > > > > > > > > It appears to do nothing because, we are just enabling the clock
> > > > > > > > > > > provider to also act as interconnect provider. Only when the
> > > > > > > > > > > consumers are enabled with interconnect usage, this will create
> > > > > > > > > > > paths and turn on the relevant NOC clocks.
> > > > > > > > > >
> > > > > > > > > > No, with sync_state it actually does "something" (sets the interconnect
> > > > > > > > > > path bandwidths to zero). And *this* patch does nothing functionally,
> > > > > > > > > > it only makes the dt checker happy.
> > > > > > > > >
> > > > > > > > > I understand.
> > > > > > > > >
> > > > > > > > > > > This interconnect will be used by the PCIe and NSS blocks. When
> > > > > > > > > > > those patches were posted earlier, they were put on hold until
> > > > > > > > > > > interconnect driver is available.
> > > > > > > > > > >
> > > > > > > > > > > Once this patch gets in, PCIe for example will make use of icc.
> > > > > > > > > > > Please refer to https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/.
> > > > > > > > > > >
> > > > > > > > > > > The 'pcieX' nodes will include the following entries.
> > > > > > > > > > >
> > > > > > > > > > >           interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
> > > > > > > > > > >                           <&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
> > > > > > > > > > >           interconnect-names = "pcie-mem", "cpu-pcie";
> > > > > > > > > >
> > > > > > > > > > Okay. What about USB that's already enabled? And BIMC/MEMNOC?
> > > > > > > > >
> > > > > > > > > For USB, the GCC_ANOC_USB_AXI_CLK is enabled as part of the iface
> > > > > > > > > clock. Hence, interconnect is not specified there.
> > > > > > > > >
> > > > > > > > > MEMNOC to System NOC interfaces seem to be enabled automatically.
> > > > > > > > > Software doesn't have to turn on or program specific clocks.
> > > > > > > > >
> > > > > > > > > > > > The expected reaction to "enabling interconnect" without defining the
> > > > > > > > > > > > required paths for your hardware would be a crash-on-sync_state, as all
> > > > > > > > > > > > unused (from Linux's POV) resources ought to be shut down.
> > > > > > > > > > > >
> > > > > > > > > > > > Because you lack sync_state, the interconnects silently retain the state
> > > > > > > > > > > > that they were left in (which is not deterministic), and that's precisely
> > > > > > > > > > > > what we want to avoid.
> > > > > > > > > > >
> > > > > > > > > > > I tried to set 'sync_state' to icc_sync_state to be invoked and
> > > > > > > > > > > didn't see any crash.
> > > > > > > > > >
> > > > > > > > > > Have you confirmed that the registers are actually written to, and with
> > > > > > > > > > correct values?
> > > > > > > > >
> > > > > > > > > I tried the following combinations:-
> > > > > > > > >
> > > > > > > > > 1. Top of tree linux-next + This patch set
> > > > > > > > >
> > > > > > > > >       * icc_sync_state called
> > > > > > > > >       * No crash or hang observed
> > > > > > > > >       * From /sys/kernel/debug/clk/clk_summary can see the
> > > > > > > > >         relevant clocks are set to the expected rates (compared
> > > > > > > > >         with downstream kernel)
> > > > > > > > >
> > > > > > > > > 2. Top of tree linux-next + This patch set + PCIe enablement
> > > > > > > > >
> > > > > > > > >       * icc_sync_state NOT called
> > > > > > > >
> > > > > > > > If sync_state() is not being called, that usually means that there
> > > > > > > > are interconnect consumers that haven't probed successfully (PCIe?)
> > > > > > > > or their dependencies. That can be checked in /sys/class/devlink/.../status
> > > > > > > > But i am not sure how this works for PCI devices however.
> > > > > > > >
> > > > > > > > You can also manually force a call to sync_state by writing "1" to
> > > > > > > > the interconnect provider's /sys/devices/.../state_synced
> > > > > > > >
> > > > > > > > Anyway, the question is if PCIe and NSS work without this driver?
> > > > > > >
> > > > > > > No.
> > > > > > >
> > > > > > > > If they work, is this because the clocks are turned on by default
> > > > > > > > or by the boot loader?
> > > > > > >
> > > > > > > Initially, the PCIe/NSS driver enabled these clocks directly
> > > > > > > by having them in their DT nodes itself. Based on community
> > > > > > > feedback this was removed and after that PCIe/NSS did not work.
> > > > > > >
> > > > > > > > Then if an interconnect path (clock) gets disabled either when we
> > > > > > > > reach a sync_state (with no bandwidth requests) or we explicitly
> > > > > > > > call icc_set_bw() with 0 bandwidth values, i would expect that
> > > > > > > > these PCIe and NSS devices would not function anymore (it might
> > > > > > > > save some power etc) and if this is unexpected we should see a
> > > > > > > > a crash or hang...
> > > > > > > >
> > > > > > > > Can you confirm this?
> > > > > > >
> > > > > > > With ICC enabled, icc_set_bw (with non-zero values) is called by
> > > > > > > PCIe and NSS drivers. Haven't checked with icc_set_bw with zero
> > > > > > > values.
> > > > > > >
> > > > > > > PCIe:   qcom_pcie_probe -> qcom_pcie_icc_init -> icc_set_bw
> > > > > > > NSS:    ppe_icc_init -> icc_set_bw
> > > > > > >
> > > > > > > I believe sync_state is not getting called since there is a
> > > > > > > non-zero set bandwidth request. Which seems to be aligned with
> > > > > > > your explanation.
> > > > > >
> > > > > > This doesn't look correct. sync_state is being called once all
> > > > > > consumers are probed. It doesn't matter whether those consumers have
> > > > > > non-zero bandwidth requests or no.
> > > > >
> > > > > /sys/kernel/debug/devices_deferred may have some useful info, too
> > > >
> > > > /sys/kernel/debug/devices_deferred seems to be empty
> > > >
> > > > 	# mount | grep -w debugfs
> > > > 	none on /sys/kernel/debug type debugfs (rw,relatime)
> > > >
> > > > 	# cat /sys/kernel/debug/devices_deferred  | wc -l
> > > > 	0
> > > >
> > > > Added the following print to icc_sync_state,
> > > >
> > > > 	@@ -1096,6 +1096,7 @@ void icc_sync_state(struct device *dev)
> > > > 		struct icc_node *n;
> > > > 		static int count;
> > > >
> > > > 	+	printk("--> %s: %d %d\n", __func__, providers_count, count);
> > > > 		count++;
> > > >
> > > > 		if (count < providers_count)
> > > > 			return;
> > > >
> > > > icc_sync_state seems to be called once,
> > > >
> > > > 	# dmesg | grep icc_sync_state
> > > > 	[   12.260544] --> icc_sync_state: 2 0
> > > >
> > > > Since 'providers_count' is greated than 'count' icc_sync_state
> > > > seems to return before doing anything.
> > >
> > > Is there also another interconnect provider on this platform, other
> > > than the gcc? Check for DT nodes that have the #interconnect-cells
> > > property.
> >
> > Yes there are two interconnect providers
> >
> > 	# find /proc/device-tree/ -name '#interconnect-cells'
> > 	/proc/device-tree/soc@0/clock-controller@1800000/#interconnect-cells
> > 	/proc/device-tree/soc@0/clock-controller@39b00000/#interconnect-cells
> >
> > 	Note:	gcc => clock-controller@1800000
> > 		nsscc => clock-controller@39b00000
> >
> > > Are all providers probing successfully?
> >
> > Yes. I printed the return value of their probe functions...
> >
> > 	# dmesg | grep probe:
> > 	[    0.037815] --> gcc_ipq9574_probe: return 0
> > 	[    2.078215] --> nss_cc_ipq9574_probe: return 0
> >
> >
> > > All providers must probe, as there might be paths that cross multiple
> > > providers and we can't get into sync-state with a topology that is
> > > only partially initialized.
> >
> > It does look like both the providers' probe has completed. And,
> > there aren't any paths that cross providers
> >
> > 	interconnects = <&gcc MASTER_ANOC_PCIE1 &gcc SLAVE_ANOC_PCIE1>,
> > 			<&gcc MASTER_SNOC_PCIE1 &gcc SLAVE_SNOC_PCIE1>;
> >
> > 	interconnects = <&gcc MASTER_ANOC_PCIE3 &gcc SLAVE_ANOC_PCIE3>,
> > 			<&gcc MASTER_SNOC_PCIE3 &gcc SLAVE_SNOC_PCIE3>;
> >
> > 	interconnects = <&gcc MASTER_ANOC_PCIE2 &gcc SLAVE_ANOC_PCIE2>,
> > 			<&gcc MASTER_SNOC_PCIE2 &gcc SLAVE_SNOC_PCIE2>;
> >
> > 	interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
> > 			<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
> >
> > 	interconnects = <&nsscc MASTER_NSSNOC_PPE &nsscc SLAVE_NSSNOC_PPE>,
> > 			<&nsscc MASTER_NSSNOC_PPE_CFG &nsscc SLAVE_NSSNOC_PPE_CFG>,
> > 			<&gcc MASTER_NSSNOC_QOSGEN_REF &gcc SLAVE_NSSNOC_QOSGEN_REF>,
> > 			<&gcc MASTER_NSSNOC_TIMEOUT_REF &gcc SLAVE_NSSNOC_TIMEOUT_REF>,
> > 			<&gcc MASTER_MEM_NOC_NSSNOC &gcc SLAVE_MEM_NOC_NSSNOC>,
> > 			<&gcc MASTER_NSSNOC_MEMNOC &gcc SLAVE_NSSNOC_MEMNOC>,
> > 			<&gcc MASTER_NSSNOC_MEM_NOC_1 &gcc SLAVE_NSSNOC_MEM_NOC_1>;
>
> Are the above consumers also probing successfully? Especially the one with
> the nsscc paths? Is nss_cc_ipq9574 also using icc_sync_state? Sync state
> will be called when all consumers of the specific provider are probed.

nsscc_ipq9574 was not using icc_sync_state. After adding that, I
can see the following messages printed from icc_sync_state. I
also added a print to confirm if 'p->set(n, n);' is called.

	[   12.260138] --> icc_sync_state: 2 2
--->	[   12.260166] qcom,gcc-ipq9574 1800000.clock-controller: interconnect provider is in synced state
	[   12.262429] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_pcie0_1lane_m_clk_master)
	[   12.271206] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_pcie0_1lane_m_clk_slave)
	[   12.281225] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_pcie0_1lane_s_clk_master)
	[   12.291118] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_pcie0_1lane_s_clk_slave)
	[   12.300902] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_pcie1_1lane_m_clk_master)
	[   12.310797] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_pcie1_1lane_m_clk_slave)
	[   12.320596] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_pcie1_1lane_s_clk_master)
	[   12.330494] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_pcie1_1lane_s_clk_slave)
	[   12.340299] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_pcie2_2lane_m_clk_master)
	[   12.350224] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_pcie2_2lane_m_clk_slave)
	[   12.360013] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_pcie2_2lane_s_clk_master)
	[   12.369904] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_pcie2_2lane_s_clk_slave)
	[   12.379709] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_pcie3_2lane_m_clk_master)
	[   12.389616] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_pcie3_2lane_m_clk_slave)
	[   12.399415] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_pcie3_2lane_s_clk_master)
	[   12.409312] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_pcie3_2lane_s_clk_slave)
	[   12.419119] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_usb_clk_master)
	[   12.429017] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_snoc_usb_clk_slave)
	[   12.437781] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_usb_axi_clk_master)
	[   12.446813] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_anoc_usb_axi_clk_slave)
	[   12.456098] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_nsscc_clk_master)
	[   12.465474] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_nsscc_clk_slave)
	[   12.474767] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_snoc_clk_master)
	[   12.484138] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_snoc_clk_slave)
	[   12.493424] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_snoc_1_clk_master)
	[   12.502713] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_snoc_1_clk_slave)
	[   12.512261] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_pcnoc_1_clk_master)
	[   12.521379] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_pcnoc_1_clk_slave)
	[   12.531098] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_qosgen_ref_clk_master)
	[   12.540651] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_qosgen_ref_clk_slave)
	[   12.550456] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_timeout_ref_clk_master)
	[   12.559922] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_timeout_ref_clk_slave)
	[   12.569986] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_xo_dcd_clk_master)
	[   12.579886] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_xo_dcd_clk_slave)
	[   12.589344] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_atb_clk_master)
	[   12.598466] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_atb_clk_slave)
	[   12.607834] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_mem_noc_nssnoc_clk_master)
	[   12.617039] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_mem_noc_nssnoc_clk_slave)
	[   12.626497] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_memnoc_clk_master)
	[   12.636049] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_memnoc_clk_slave)
	[   12.645507] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_mem_noc_1_clk_master)
	[   12.654668] qcom,gcc-ipq9574 1800000.clock-controller: Calling icc_clk_set(gcc_nssnoc_mem_noc_1_clk_slave)
--->	[   12.664354] qcom,nsscc-ipq9574 39b00000.clock-controller: interconnect provider is in synced state
	[   12.674069] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_ppe_clk_master)
	[   12.683012] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_ppe_clk_slave)
	[   12.692646] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_ppe_cfg_clk_master)
	[   12.702369] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_ppe_cfg_clk_slave)
	[   12.712349] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_nss_csr_clk_master)
	[   12.722431] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_nss_csr_clk_slave)
	[   12.732404] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_imem_qsb_clk_master)
	[   12.742473] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_imem_qsb_clk_slave)
	[   12.752801] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_imem_ahb_clk_master)
	[   12.762611] qcom,nsscc-ipq9574 39b00000.clock-controller: Calling icc_clk_set(nss_cc_nssnoc_imem_ahb_clk_slave)

> The idea of sync state is to allow all consumers to probe and to request
> their paths. Only after that, the framework will take into account the
> bandwidth values that has been requested from consumers and disable unused
> paths.
>
> Sorry, but i am doing a bit of guessing here as i am missing the complete
> picture. So you add interconnect-cells to nsscc, but what is this DT node
> that requests the nss and gcc paths? I am failing to find these on the
> mailing lists.

The gcc based interconnect paths are referenced by PCIe controller
nodes. Please refer to this patch

	[PATCH V5 4/6] arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
	https://lore.kernel.org/linux-arm-msm/20240512082858.1806694-5-quic_devipriy@quicinc.com/

Sorry, did not post the nsscc related patches since this base ICC
patch hasn't reached closure. The nsscc patches are very similar
to this gcc based series. Wanted to gather the issues raised in
this and address them in nsscc so that it is in a more acceptable
shape.

Thanks
Varada

