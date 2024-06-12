Return-Path: <linux-pm+bounces-8990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DBE904BA5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 08:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3681F285DB7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 06:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3516516B72C;
	Wed, 12 Jun 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OpB+GO2R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A6B16ABF2;
	Wed, 12 Jun 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173832; cv=none; b=BdDU9xqA6zjZ/aoIbr6tm8kXSumozwQb2LK50M9D/s3u2qO1a7y/qG/Qf1YDn3B39IC7HeEIz9MOIUzYW+HwUNGO/Bq6GOqupBTDIG9foAuByNPDQoqwaBHU3yEmyB2wFZRyMG4mVIfWPj3fgpz2zyn18s1HMIxioojHkzKmchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173832; c=relaxed/simple;
	bh=qaveu0xvm6cxnIaGZGTT0EUoKuxpCX3hWPQUgbCE3m0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eORlZqtEpmuRQyFYfdZITEiERy7NZ/Z4X5Wi4IpuXyX/6/ipPBZrFuX2aATmY2djNmuzk1sWkIWtxEDU8azvErJGFu3EWjahnDmxvVbJopAPgFyffIYg6xYqizR0Egn4DXxxJWyIRUks7nlx7nF0oyfSxSgGjQh7kdo7WreszFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OpB+GO2R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C5h25q026045;
	Wed, 12 Jun 2024 06:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wGV9Qzs8L7GbLfEcwvD1UOfv
	d8tBSv6tvyZiOrhV4Mw=; b=OpB+GO2R+SZXmcgqUVLBYZlZBN+J6vg6kzDMyfUg
	8zRaliMM3eNtJ0zz5lIrP3ANywrH/hB1rqPNDDFPywCfuK8X88sTaLska+/xGisC
	HZXRm2MVtAyIUxZJj4PLCxs3Y6Jbj5gXuffVWyTwU5AcGiifeXevgaM+JCBxb3zI
	hm/cqkcrGJjacDm3SWTuogFwb64T4uFc4Ari+oirA2Y67/Hc1cr44qIEotXyMWub
	1RuoCeVJSehzMSoJiZou17wA+w9YCSpqLJta3ybqOoLNQlpsSud6hI2UnjUuLHLL
	4IKZ8OsbypJNEtlOdSTs6TRy1o/nijx8co3Nh7wSQNvcxQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yps5x9qb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 06:30:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C6UNrX022948
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 06:30:23 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Jun 2024 23:30:18 -0700
Date: Wed, 12 Jun 2024 12:00:12 +0530
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
Message-ID: <ZmlAdETV0+6Md8HC@hu-varada-blr.qualcomm.com>
References: <a7194edd-a2c8-46fc-bea1-f26b0960e535@linaro.org>
 <Ziov6bWBXYXJ4Zp8@hu-varada-blr.qualcomm.com>
 <27f4f3dd-9375-40cf-8c8f-1c4edf66e31b@linaro.org>
 <ZjNdTmmXucjtRxJt@hu-varada-blr.qualcomm.com>
 <c015b3a5-2213-4ebd-b960-d97ed1fe7062@kernel.org>
 <ZjshR0ekcn0gxwOa@hu-varada-blr.qualcomm.com>
 <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>
 <1a08ef42-b52f-4c97-90d7-e7fdee7725b4@linaro.org>
 <Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com>
 <176137e5-6312-4d46-97b6-c4494bc1c61b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <176137e5-6312-4d46-97b6-c4494bc1c61b@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jl_bv2wy8F4EbVXUo2KYBEAll4vO8q0N
X-Proofpoint-ORIG-GUID: Jl_bv2wy8F4EbVXUo2KYBEAll4vO8q0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_02,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406120044

On Tue, Jun 11, 2024 at 02:29:48PM +0300, Georgi Djakov wrote:
> On 11.06.24 12:42, Varadarajan Narayanan wrote:
> > On Thu, Jun 06, 2024 at 04:06:01PM +0200, Konrad Dybcio wrote:
> > > On 8.05.2024 10:10 AM, Dmitry Baryshkov wrote:
> > > > On Wed, 8 May 2024 at 09:53, Varadarajan Narayanan
> > > > <quic_varada@quicinc.com> wrote:
> > > > >
> > > > > On Fri, May 03, 2024 at 04:51:04PM +0300, Georgi Djakov wrote:
> > > > > > Hi Varada,
> > > > > >
> > > > > > Thank you for your work on this!
> > > > > >
> > > > > > On 2.05.24 12:30, Varadarajan Narayanan wrote:
> > > > > > > On Tue, Apr 30, 2024 at 12:05:29PM +0200, Konrad Dybcio wrote:
> > > > > > > > On 25.04.2024 12:26 PM, Varadarajan Narayanan wrote:
> > > > > > > > > On Tue, Apr 23, 2024 at 02:58:41PM +0200, Konrad Dybcio wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > On 4/18/24 11:23, Varadarajan Narayanan wrote:
> > > > > > > > > > > IPQ SoCs dont involve RPM in managing NoC related clocks and
> > > > > > > > > > > there is no NoC scaling. Linux itself handles these clocks.
> > > > > > > > > > > However, these should not be exposed as just clocks and align
> > > > > > > > > > > with other Qualcomm SoCs that handle these clocks from a
> > > > > > > > > > > interconnect provider.
> > > > > > > > > > >
> > > > > > > > > > > Hence include icc provider capability to the gcc node so that
> > > > > > > > > > > peripherals can use the interconnect facility to enable these
> > > > > > > > > > > clocks.
> > > > > > > > > > >
> > > > > > > > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > If this is all you do to enable interconnect (which is not the case,
> > > > > > > > > > as this patch only satisfies the bindings checker, the meaningful
> > > > > > > > > > change happens in the previous patch) and nothing explodes, this is
> > > > > > > > > > an apparent sign of your driver doing nothing.
> > > > > > > > >
> > > > > > > > > It appears to do nothing because, we are just enabling the clock
> > > > > > > > > provider to also act as interconnect provider. Only when the
> > > > > > > > > consumers are enabled with interconnect usage, this will create
> > > > > > > > > paths and turn on the relevant NOC clocks.
> > > > > > > >
> > > > > > > > No, with sync_state it actually does "something" (sets the interconnect
> > > > > > > > path bandwidths to zero). And *this* patch does nothing functionally,
> > > > > > > > it only makes the dt checker happy.
> > > > > > >
> > > > > > > I understand.
> > > > > > >
> > > > > > > > > This interconnect will be used by the PCIe and NSS blocks. When
> > > > > > > > > those patches were posted earlier, they were put on hold until
> > > > > > > > > interconnect driver is available.
> > > > > > > > >
> > > > > > > > > Once this patch gets in, PCIe for example will make use of icc.
> > > > > > > > > Please refer to https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/.
> > > > > > > > >
> > > > > > > > > The 'pcieX' nodes will include the following entries.
> > > > > > > > >
> > > > > > > > >          interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
> > > > > > > > >                          <&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
> > > > > > > > >          interconnect-names = "pcie-mem", "cpu-pcie";
> > > > > > > >
> > > > > > > > Okay. What about USB that's already enabled? And BIMC/MEMNOC?
> > > > > > >
> > > > > > > For USB, the GCC_ANOC_USB_AXI_CLK is enabled as part of the iface
> > > > > > > clock. Hence, interconnect is not specified there.
> > > > > > >
> > > > > > > MEMNOC to System NOC interfaces seem to be enabled automatically.
> > > > > > > Software doesn't have to turn on or program specific clocks.
> > > > > > >
> > > > > > > > > > The expected reaction to "enabling interconnect" without defining the
> > > > > > > > > > required paths for your hardware would be a crash-on-sync_state, as all
> > > > > > > > > > unused (from Linux's POV) resources ought to be shut down.
> > > > > > > > > >
> > > > > > > > > > Because you lack sync_state, the interconnects silently retain the state
> > > > > > > > > > that they were left in (which is not deterministic), and that's precisely
> > > > > > > > > > what we want to avoid.
> > > > > > > > >
> > > > > > > > > I tried to set 'sync_state' to icc_sync_state to be invoked and
> > > > > > > > > didn't see any crash.
> > > > > > > >
> > > > > > > > Have you confirmed that the registers are actually written to, and with
> > > > > > > > correct values?
> > > > > > >
> > > > > > > I tried the following combinations:-
> > > > > > >
> > > > > > > 1. Top of tree linux-next + This patch set
> > > > > > >
> > > > > > >      * icc_sync_state called
> > > > > > >      * No crash or hang observed
> > > > > > >      * From /sys/kernel/debug/clk/clk_summary can see the
> > > > > > >        relevant clocks are set to the expected rates (compared
> > > > > > >        with downstream kernel)
> > > > > > >
> > > > > > > 2. Top of tree linux-next + This patch set + PCIe enablement
> > > > > > >
> > > > > > >      * icc_sync_state NOT called
> > > > > >
> > > > > > If sync_state() is not being called, that usually means that there
> > > > > > are interconnect consumers that haven't probed successfully (PCIe?)
> > > > > > or their dependencies. That can be checked in /sys/class/devlink/.../status
> > > > > > But i am not sure how this works for PCI devices however.
> > > > > >
> > > > > > You can also manually force a call to sync_state by writing "1" to
> > > > > > the interconnect provider's /sys/devices/.../state_synced
> > > > > >
> > > > > > Anyway, the question is if PCIe and NSS work without this driver?
> > > > >
> > > > > No.
> > > > >
> > > > > > If they work, is this because the clocks are turned on by default
> > > > > > or by the boot loader?
> > > > >
> > > > > Initially, the PCIe/NSS driver enabled these clocks directly
> > > > > by having them in their DT nodes itself. Based on community
> > > > > feedback this was removed and after that PCIe/NSS did not work.
> > > > >
> > > > > > Then if an interconnect path (clock) gets disabled either when we
> > > > > > reach a sync_state (with no bandwidth requests) or we explicitly
> > > > > > call icc_set_bw() with 0 bandwidth values, i would expect that
> > > > > > these PCIe and NSS devices would not function anymore (it might
> > > > > > save some power etc) and if this is unexpected we should see a
> > > > > > a crash or hang...
> > > > > >
> > > > > > Can you confirm this?
> > > > >
> > > > > With ICC enabled, icc_set_bw (with non-zero values) is called by
> > > > > PCIe and NSS drivers. Haven't checked with icc_set_bw with zero
> > > > > values.
> > > > >
> > > > > PCIe:   qcom_pcie_probe -> qcom_pcie_icc_init -> icc_set_bw
> > > > > NSS:    ppe_icc_init -> icc_set_bw
> > > > >
> > > > > I believe sync_state is not getting called since there is a
> > > > > non-zero set bandwidth request. Which seems to be aligned with
> > > > > your explanation.
> > > >
> > > > This doesn't look correct. sync_state is being called once all
> > > > consumers are probed. It doesn't matter whether those consumers have
> > > > non-zero bandwidth requests or no.
> > >
> > > /sys/kernel/debug/devices_deferred may have some useful info, too
> >
> > /sys/kernel/debug/devices_deferred seems to be empty
> >
> > 	# mount | grep -w debugfs
> > 	none on /sys/kernel/debug type debugfs (rw,relatime)
> >
> > 	# cat /sys/kernel/debug/devices_deferred  | wc -l
> > 	0
> >
> > Added the following print to icc_sync_state,
> >
> > 	@@ -1096,6 +1096,7 @@ void icc_sync_state(struct device *dev)
> > 		struct icc_node *n;
> > 		static int count;
> >
> > 	+	printk("--> %s: %d %d\n", __func__, providers_count, count);
> > 		count++;
> >
> > 		if (count < providers_count)
> > 			return;
> >
> > icc_sync_state seems to be called once,
> >
> > 	# dmesg | grep icc_sync_state
> > 	[   12.260544] --> icc_sync_state: 2 0
> >
> > Since 'providers_count' is greated than 'count' icc_sync_state
> > seems to return before doing anything.
>
> Is there also another interconnect provider on this platform, other
> than the gcc? Check for DT nodes that have the #interconnect-cells
> property.

Yes there are two interconnect providers

	# find /proc/device-tree/ -name '#interconnect-cells'
	/proc/device-tree/soc@0/clock-controller@1800000/#interconnect-cells
	/proc/device-tree/soc@0/clock-controller@39b00000/#interconnect-cells

	Note:	gcc => clock-controller@1800000
		nsscc => clock-controller@39b00000

> Are all providers probing successfully?

Yes. I printed the return value of their probe functions...

	# dmesg | grep probe:
	[    0.037815] --> gcc_ipq9574_probe: return 0
	[    2.078215] --> nss_cc_ipq9574_probe: return 0


> All providers must probe, as there might be paths that cross multiple
> providers and we can't get into sync-state with a topology that is
> only partially initialized.

It does look like both the providers' probe has completed. And,
there aren't any paths that cross providers

	interconnects = <&gcc MASTER_ANOC_PCIE1 &gcc SLAVE_ANOC_PCIE1>,
			<&gcc MASTER_SNOC_PCIE1 &gcc SLAVE_SNOC_PCIE1>;

	interconnects = <&gcc MASTER_ANOC_PCIE3 &gcc SLAVE_ANOC_PCIE3>,
			<&gcc MASTER_SNOC_PCIE3 &gcc SLAVE_SNOC_PCIE3>;

	interconnects = <&gcc MASTER_ANOC_PCIE2 &gcc SLAVE_ANOC_PCIE2>,
			<&gcc MASTER_SNOC_PCIE2 &gcc SLAVE_SNOC_PCIE2>;

	interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
			<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;

	interconnects = <&nsscc MASTER_NSSNOC_PPE &nsscc SLAVE_NSSNOC_PPE>,
			<&nsscc MASTER_NSSNOC_PPE_CFG &nsscc SLAVE_NSSNOC_PPE_CFG>,
			<&gcc MASTER_NSSNOC_QOSGEN_REF &gcc SLAVE_NSSNOC_QOSGEN_REF>,
			<&gcc MASTER_NSSNOC_TIMEOUT_REF &gcc SLAVE_NSSNOC_TIMEOUT_REF>,
			<&gcc MASTER_MEM_NOC_NSSNOC &gcc SLAVE_MEM_NOC_NSSNOC>,
			<&gcc MASTER_NSSNOC_MEMNOC &gcc SLAVE_NSSNOC_MEMNOC>,
			<&gcc MASTER_NSSNOC_MEM_NOC_1 &gcc SLAVE_NSSNOC_MEM_NOC_1>;

Thanks
Varada

