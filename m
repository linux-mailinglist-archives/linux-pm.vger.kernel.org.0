Return-Path: <linux-pm+bounces-10484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234FF92547C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B92B1F22A39
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A2136E3B;
	Wed,  3 Jul 2024 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GbKq6viF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F186135A5B;
	Wed,  3 Jul 2024 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991000; cv=none; b=BKv8qUUoDf2R34sIfM/pWbyK/P/StY0kalHjrEEJ5t95nuS5HC+QSYoEjW3pcmgtcgYufgp9DZDRXXhhsVAMtQV+z9uv4MocajTOzXdWvDZTRcASl/GlVGcsPXZwTVwlXt4t73iDGER+UX9LJqKvLBJMkKElIoH6uRWEm0jw0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991000; c=relaxed/simple;
	bh=Jnn7HRX+w2X1FfG/ozQi4PUqTF2VQIuM9En9tHDhNG0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLbI77JbenQxx2tP60sAyJy6K8lJCGd0JxTtlUA078++PNr8R/CkPoaMMh/+s/R70jXvVsFM3bTYjobnTVSuSlWvXkWOwdrfXMBzjDo/bGkBg7QDe9JUI77vJfz9S0uwr1HtJKtFH5Xy6PXKwWvrt4hANgmOW5rRmbUci68lNsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GbKq6viF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462JHddG031391;
	Wed, 3 Jul 2024 07:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/sACPhImwWUed1O1qusp4XbK
	WCHzdJchPgYvl42r6lU=; b=GbKq6viFhVIdDb/ENBp71K6HZMoT150paza7QfQE
	7KJn4MOcDClDefdg0tSiOJN0e+CJPKFU5DmQ/S+3WyvX4wPuXjcVHwisheMJZMxi
	bdw+Cf9FFws74XWkP+f2t/cr+uINS+eHwbYn5VaWTmEXOis+mJ+yBvtCiW2Haov+
	DDjnkgmP+rv1gKcccXOIQ0PV7zbDMInoIXobvJ3IwvlrvzjTcFsx0krV7E1SrXIh
	WJmYcZTYfJluxKg4Gn2ExgfOIhxSQAIxRrIdM4WwopkJCycbX4GFMmaZYwVtwzEu
	Lo2NigvzHf/AluNsNV8Ezma9qVnR20et4/4sgIt0lx9UdQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402bj8aj9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 07:16:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4637GO4c017837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 07:16:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 00:16:17 -0700
Date: Wed, 3 Jul 2024 12:46:12 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <otto.pflueger@abscue.de>,
        <neil.armstrong@linaro.org>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <danila@jiaxyga.com>, <quic_ipkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] cpufreq: qcom-nvmem: Add genpd names to
 match_data_kryo
Message-ID: <ZoT6vBAipbkfdh11@hu-varada-blr.qualcomm.com>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
 <20240626104002.420535-3-quic_varada@quicinc.com>
 <za7t6ltttq2o5qwahfrzftsb7xfzbzdtg4zx3bvnf3fewhfeqf@vjrq7na5ioqm>
 <Zn5ZEI1m4jImz/Wp@hu-varada-blr.qualcomm.com>
 <kcgqm3ywdzdttllk357szirjdvdddsrcznfuwux6y237ncjnwb@3ots4rqreznu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <kcgqm3ywdzdttllk357szirjdvdddsrcznfuwux6y237ncjnwb@3ots4rqreznu>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QAcsVQlZX_EfFTXbYG5ElCoxJ3YLrwsN
X-Proofpoint-GUID: QAcsVQlZX_EfFTXbYG5ElCoxJ3YLrwsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_03,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030052

On Fri, Jun 28, 2024 at 10:40:23AM +0300, Dmitry Baryshkov wrote:
> On Fri, Jun 28, 2024 at 12:02:48PM GMT, Varadarajan Narayanan wrote:
> > On Wed, Jun 26, 2024 at 09:23:17PM +0300, Dmitry Baryshkov wrote:
> > > On Wed, Jun 26, 2024 at 04:09:55PM GMT, Varadarajan Narayanan wrote:
> > > > This is used for tying up the cpu@N nodes with the power domains.
> > > > Without this, 'cat /sys/kernel/debug/qcom_cpr3/thread0'
> > > > crashes with NULL pointer access.
> > >
> > > Add the interesting part of the backtrace, please.

Sure.

> >
> >         if (thread->drv->desc->cpr_type < CTRL_TYPE_CPRH) {
> >                 seq_printf(s, "current_volt = %d uV\n", thread->drv->last_uV);
> >                 seq_printf(s, "requested voltage: %d uV\n", thread->corner->last_uV);
> >         }
> >
> > thread->corner is NULL in the second printf above.
> >
> > 	# cat /sys/kernel/debug/qcom_cpr3/thread0
> > 	[   16.965241] Unable to handle kernel NULL pointer dereference at virtual address 000000000000000c
> > 	[   16.965270] Mem abort info:
> > 	[   16.973181]   ESR = 0x0000000096000004
> > 	[   16.975607]   EC = 0x25: DABT (current EL), IL = 32 bits
> > 	[   16.979425]   SET = 0, FnV = 0
> > 	[   16.984889]   EA = 0, S1PTW = 0
> > 	[   16.987756]   FSC = 0x04: level 0 translation fault
> > 	[   16.990792] Data abort info:
> > 	[   16.995652]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > 	[   16.998779]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > 	[   17.004074]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > 	[   17.009196] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000481b1000
> > 	[   17.014579] [000000000000000c] pgd=0000000000000000, p4d=0000000000000000
> > 	[   17.020919] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > 	[   17.020921] Modules linked in:
> > 	[   17.020926] CPU: 0 UID: 0 PID: 118 Comm: cat Not tainted 6.10.0-rc4-next-20240620-00020-g125eb3184fc1-dirty #9
> > 	[   17.020931] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
> > 	[   17.020933] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > 	[   17.020936] pc : cpr3_debug_info_show+0x3a0/0x3ac
> > 	[   17.020945] lr : cpr3_debug_info_show+0x390/0x3ac
> > 	[   17.020948] sp : ffff800086293b90
> > 	[   17.020949] x29: ffff800086293b90 x28: ffff0000034ae038 x27: 0000000000400cc0
> > 	[   17.020953] x26: 000000007ffff000 x25: ffff0000034ae028 x24: 0000000000000000
> > 	[   17.020957] x23: ffff800086293c80 x22: ffff000002399880 x21: ffff000002a8fa80
> > 	[   17.020960] x20: ffff0000034ae000 x19: 0000000000000000 x18: ffffffffffffffff
> > 	[   17.020964] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800086293a40
> > 	[   17.020967] x14: ffff000002913000 x13: ffff00000291200f x12: 0000000000000000
> > 	[   17.020970] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff0000034a9000
> > 	[   17.020973] x8 : 000000000a567520 x7 : 0000000000000001 x6 : 000000000a567520
> > 	[   17.020976] x5 : ffff000002912014 x4 : ffff800080e1f3a5 x3 : 0000000000000014
> > 	[   17.020979] x2 : 0000000000000000 x1 : ffff800080e1f848 x0 : ffff0000034ae000
> > 	[   17.020983] Call trace:
> > 	[   17.020984]  cpr3_debug_info_show+0x3a0/0x3ac
> > 	[   17.020987]  seq_read_iter+0xe0/0x45c
> > 	[   17.020993]  seq_read+0xec/0x130
> > 	[   17.020996]  full_proxy_read+0x60/0xb4
> > 	[   17.020999]  vfs_read+0xc0/0x31c
> > 	[   17.021003]  ksys_read+0x70/0x104
> > 	[   17.021006]  __arm64_sys_read+0x1c/0x28
> > 	[   17.021008]  invoke_syscall+0x48/0x114
> > 	[   17.021014]  el0_svc_common+0x3c/0xe8
> > 	[   17.021017]  do_el0_svc+0x20/0x2c
> > 	[   17.021020]  el0_svc+0x34/0xd8
> > 	[   17.021024]  el0t_64_sync_handler+0x120/0x12c
> > 	[   17.021027]  el0t_64_sync+0x190/0x194
> > 	[   17.021031] Code: f94012c2 aa1403e0 b0004701 91212021 (b9400c42)
> > 	[   17.021033] ---[ end trace 0000000000000000 ]---
> > 	Segmentation fault
>
> Well, I asked to add it, so please drop the timestamps and registers and
> include it into the commit message. While you are at it, please review
> Documentation/process/submitting-patches.rst and change the commit
> message to follow the guidelines.
>
> While doing so (and while responding to a comment below) you will notice
> that this change should not be applied to the generic match_data_kryo
> instance. Instead you should add a device-specific entry into match
> table and use struct qcom_cpufreq_match_data instance that has
> .genpd_names set.

Ok, will add a new match data for IPQ9574.

> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > index 939702dfa73f..5e6525c7788c 100644
> > > > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > @@ -399,6 +399,7 @@ static const char *generic_genpd_names[] = { "perf", NULL };
> > > >
> > > >  static const struct qcom_cpufreq_match_data match_data_kryo = {
> > > >  	.get_version = qcom_cpufreq_kryo_name_version,
> > > > +	.genpd_names = generic_genpd_names,
> > >
> > > This forces that every Kryo SoC has "perf" genpd, which obviously isn't
> > > corret (at least from the upstream support point of view).

Understand, will have a different match data for IPQ9574.

> > While trying to get the above backtrace, randomly during boot
> > I see the following BUG too.
>
> This isn't a response to my comment.

Sorry, felt that genpd_names would be needed for kryo CPUs too
and wanted to bring this BUG() to your attention. Was wondering
how kryo CPUs didn't face the following BUG(). Since this BUG()
was hitting occasionally, assumed it could be some boot time
driver probe order/timing related race that was getting masked in
kryo CPUs but occuring in IQP9574.

> > 	[    1.562847] ------------[ cut here ]------------
> > 	[    1.574342] kernel BUG at drivers/cpufreq/cpufreq.c:1542!
> > 	[    1.579203] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > 	[    1.579209] Modules linked in:
> > 	[    1.579217] CPU: 2 UID: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.10.0-rc4-next-20240620-00020-g125eb3184fc1-dirty #10
> > 	[    1.579227] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
> > 	[    1.579232] Workqueue: events_unbound deferred_probe_work_func
> > 	[    1.579249] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > 	[    1.579257] pc : cpufreq_online+0x938/0x954
> > 	[    1.579271] lr : cpufreq_online+0x788/0x954
> > 	[    1.579281] sp : ffff8000817c3520
> > 	[    1.579283] x29: ffff8000817c3520 x28: ffff0000029efa50 x27: 0000000000000001
> > 	[    1.579294] x26: 0000000000000001 x25: ffff8000814d8da0 x24: 0000000000000000
> > 	[    1.579303] x23: ffff0000029ef9d0 x22: ffff800081735000 x21: 0000000000000000
> > 	[    1.579312] x20: 00000000000c15c0 x19: ffff0000029ef800 x18: ffff00000183481c
> > 	[    1.579321] x17: ffff8000818a3638 x16: 0000000000000000 x15: ffff8000818a3670
> > 	[    1.579330] x14: 0000000000000003 x13: ffff00000192b140 x12: ffff8000814d8c58
> > 	[    1.579338] x11: ffff00000192b140 x10: 00000000000009b0 x9 : ffff8000817c3240
> > 	[    1.579347] x8 : ffff00000192bad0 x7 : 0000000000000001 x6 : ffff8000814d8da0
> > 	[    1.579355] x5 : ffff8000812c32d0 x4 : 0000000000000000 x3 : 0000000000000000
> > 	[    1.579363] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffff0
> > 	[    1.579372] Call trace:
> > 	[    1.579375]  cpufreq_online+0x938/0x954
> > 	[    1.579386]  cpufreq_add_dev+0x80/0x98
> > 	[    1.579395]  subsys_interface_register+0x100/0x130
> > 	[    1.579404]  cpufreq_register_driver+0x150/0x244
> > 	[    1.579413]  dt_cpufreq_probe+0x8c/0x440
> > 	[    1.579420]  platform_probe+0x68/0xc8
> > 	[    1.579430]  really_probe+0xbc/0x29c
> > 	[    1.579438]  __driver_probe_device+0x78/0x12c
> > 	[    1.579446]  driver_probe_device+0xd8/0x15c
> > 	[    1.579454]  __device_attach_driver+0xb8/0x134
> > 	[    1.579463]  bus_for_each_drv+0x84/0xe0
> > 	[    1.579470]  __device_attach+0x9c/0x188
> > 	[    1.579478]  device_initial_probe+0x14/0x20
> > 	[    1.579487]  bus_probe_device+0xac/0xb0
> > 	[    1.579494]  device_add+0x55c/0x720
> > 	[    1.579500]  platform_device_add+0x1b8/0x244
> > 	[    1.579510]  platform_device_register_full+0xfc/0x184
> > 	[    1.579516]  platform_device_register_resndata.constprop.0+0x5c/0x8c
> > 	[    1.579524]  qcom_cpufreq_probe+0x1e4/0x498
> > 	[    1.579531]  platform_probe+0x68/0xc8
> > 	[    1.579540]  really_probe+0xbc/0x29c
> > 	[    1.579548]  __driver_probe_device+0x78/0x12c
> > 	[    1.579556]  driver_probe_device+0xd8/0x15c
> > 	[    1.579564]  __device_attach_driver+0xb8/0x134
> > 	[    1.579573]  bus_for_each_drv+0x84/0xe0
> > 	[    1.579580]  __device_attach+0x9c/0x188
> > 	[    1.579588]  device_initial_probe+0x14/0x20
> > 	[    1.579596]  bus_probe_device+0xac/0xb0
> > 	[    1.579603]  deferred_probe_work_func+0x88/0xc0
> > 	[    1.579611]  process_one_work+0x148/0x28c
> > 	[    1.579623]  worker_thread+0x2e8/0x3f8
> > 	[    1.579633]  kthread+0x110/0x114
> > 	[    1.579641]  ret_from_fork+0x10/0x20
> > 	[    1.579653] Code: aa1703e0 52800021 97e38ed5 17ffffea (d4210000)
> > 	[    1.579657] ---[ end trace 0000000000000000 ]---
> > 	[    1.851078] note: kworker/u16:0[11] exited with irqs disabled
> > 	[    1.855791] note: kworker/u16:0[11] exited with preempt_count 1
> > 	[    1.861586] ------------[ cut here ]------------
> >
> > Randomly, the following call seems to return -EBUSY causing
> > the above BUG().
> >
> > 	ret = __cpufreq_driver_target(policy, old_freq - 1,
> > 				      CPUFREQ_RELATION_L);
> >
> > 	/*
> > 	 * Reaching here after boot in a few seconds may not
> > 	 * mean that system will remain stable at "unknown"
> > 	 * frequency for longer duration. Hence, a BUG_ON().
> > 	 */
> > 	BUG_ON(ret);
> >
> > Not sure why this does not happen in every boot, and how it
> > is tied to genpd_names. Will debug and update.

qcom_cpufreq_probe invokes dev_pm_opp_set_config if either
genpd_names or get_version is set in qcom_cpufreq_match_data.
If genpd_names is available, dev_pm_opp_set_config calls
_opp_attach_genpd giving genpd_names as an input. This in turn
calls dev_pm_domain_attach_by_name and binds the CPU device with
the OPP tables etc. Sometimes, the pm_domain driver is probed by
this time and sometimes it is not. When it is not probed,
qcom_cpufreq_probe is also held back via the EPROBE_DEFER
mechanism. This in turn holds back the cpufreq driver probe.

When genpd_names is not set in match_data_kryo,
dev_pm_opp_set_config doesn't call _opp_attach_genpd. Hence,
regardless of pm_domain driver's probe status, qcom_cpufreq_probe
completes. This allows the cpufreq driver's probe to proceed. The
cpufreq driver tries to set some frequency based on the
opp-tables. At this point if pm_domain driver is probed, the
frequency change goes through. If pm_domain is not probed yet,
the above BUG() happens.

Will post the next version shortly with this and the other
comments addressed. Please take a look.

Thanks
Varada

