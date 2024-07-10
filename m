Return-Path: <linux-pm+bounces-10927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C66AF92D044
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 13:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B81F25DD8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8770918FC93;
	Wed, 10 Jul 2024 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eCv/rKFS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2518FA32;
	Wed, 10 Jul 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609860; cv=none; b=A/pG0rAQmRb4MohbwAZhZanNquo2L90gRMXOUOYfubBw6Vf7oNkoRlOhbK8idGRxW251TRE+BlUIZHzQsbMGLo56goWdlMhvidABT/0yXvwqHzmvfG1RDh93x2k197o8lMwF8aG9VaUXxUdZJ/C1VS2s7Efe92N92dYIzwiCbB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609860; c=relaxed/simple;
	bh=bJ7UMNrJhy/yiqIhlNGo85s491lo6a1mzP3pH0oIg8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSJSuBzswcV1O0yPcK1vbm0+57J7xUXw8Z8x1Q5KKcHB3zYDXG3whlEAv0WsuAoked1+W9AsJ0XCVtijneWeF+Tt3Px5IHUY5YUCV1XWvuwSR5S4QV12WAiyL3jZBavcuil+Mj4UakCdmSIp33+sbBKxDawCkJYcbpL/FTgFCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eCv/rKFS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A5per4001981;
	Wed, 10 Jul 2024 11:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DakjzVf8c5gxPDRSJYZ/afTX
	K/uKlCpAbl68FU+/wfA=; b=eCv/rKFSSRJKwHopYCOMuKgIYSnb8cXx72hlNQDY
	DvE04ssag2gCs2i3i2612E8BTlgaB8r8j+OxDdjBfvZZ0h+Bva8S+2+ffv/uVGA4
	6zgxu7HHT3V4e1JVvK4qXwRJz2bXoTphznCk/mgLGddav0lgB6QAxZyV8JJHY15X
	0m8S6ZojDk5F1MfEUhhdz9+NUgEt6+VV9WQ+tHHbxt78ypUU9MScLVRmsTGUL91z
	k83XNsR28qCKtyY87HCdlARVJb5/TrGDjYBwknhlQWR1Q5YtSGP8xUHYFei6rslB
	14hHN5bzBeSdZdp5Oiw0VzMDgy24HIGtS922P4L904ns1w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we90yp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:10:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ABAgl4031750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:10:42 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:10:35 -0700
Date: Wed, 10 Jul 2024 16:40:31 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <danila@jiaxyga.com>,
        <neil.armstrong@linaro.org>, <otto.pflueger@abscue.de>,
        <abel.vesa@linaro.org>, <luca@z3ntu.xyz>, <geert+renesas@glider.be>,
        <stephan.gerhold@kernkonzept.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v6 1/9] soc: qcom: cpr3: Fix 'acc_desc' usage
Message-ID: <Zo5sJ1Uk7wAzWflg@hu-varada-blr.qualcomm.com>
References: <20240710061102.1323550-1-quic_varada@quicinc.com>
 <20240710061102.1323550-2-quic_varada@quicinc.com>
 <325a45b7-bb02-4a32-8590-6abc14ad9619@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <325a45b7-bb02-4a32-8590-6abc14ad9619@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aB0tn39dEoel6FhajxL5jKgoeTXpIBVR
X-Proofpoint-GUID: aB0tn39dEoel6FhajxL5jKgoeTXpIBVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=740 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407100077

On Wed, Jul 10, 2024 at 01:05:12PM +0200, Konrad Dybcio wrote:
> On 10.07.2024 8:10 AM, Varadarajan Narayanan wrote:
> > cpr3 code assumes that 'acc_desc' is available for SoCs
> > implementing CPR version 4 or less. However, IPQ9574 SoC
> > implements CPRv4 without ACC. This causes NULL pointer accesses
> > resulting in crashes. Hence, check if 'acc_desc' is populated
> > before using it.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> Does it not work if you drop this patch?
>
> In v15, drv->tcsr is left NULL (from kzalloc), unless data->acc_desc
> is present

It crashed for me with NULL pointer access.

	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
	input: gpio-keys as /devices/platform/gpio-keys/input/input0
	Mem abort info:
	  ESR = 0x0000000096000004
	  EC = 0x25: DABT (current EL), IL = 32 bits
	  SET = 0, FnV = 0
	  EA = 0, S1PTW = 0
	clk: Disabling unused clocks
	  FSC = 0x04: level 0 translation fault
	Data abort info:
	  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
	  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
	PM: genpd: Disabling unused power domains
	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
	[0000000000000010] user address but active_mm is swapper
	Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
	Modules linked in:
	CPU: 0 UID: 0 PID: 74 Comm: sugov:0 Not tainted 6.10.0-rc6-next-20240703-00018-g3dfa5a2e6f31-dirty #13
	Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
	pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	pc : cpr_commit_state+0x228/0x2a8
	lr : cpr_commit_state+0x10c/0x2a8
	sp : ffff800086163a90
	x29: ffff800086163a90 x28: 0000000000000000 x27: 0000000000000000
	x26: 0000000000000000 x25: ffff000006953080 x24: ffff000006913280
	x23: 00000000000fa3e8 x22: 00000000000fa3e8 x21: 00000000000fa3e8
	x20: 0000000000000003 x19: 00000000000fa3e8 x18: 0000000000000000
	x17: 63682d6963687820 x16: 0000000000000000 x15: ffff00003fc8fd00
	x14: 0000000000000000 x13: 0000000000000001 x12: ffff8000814e8c60
	x11: 0000000000000000 x10: 00000000000009b0 x9 : 0000000000000000
	x8 : ffff00003fc87f40 x7 : 0000000000000240 x6 : 0000000000000002
	x5 : 000000000000007f x4 : 0000000000000000 x3 : 0000000000000000
	x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
	Call trace:
	 cpr_commit_state+0x228/0x2a8
	 cpr_set_performance_state+0x94/0xf4
	 _genpd_set_performance_state+0x190/0x1ac
	 genpd_set_performance_state.isra.0+0xbc/0xdc
	 genpd_dev_pm_set_performance_state+0x60/0xc0
	 dev_pm_domain_set_performance_state+0x24/0x3c
	 _set_opp+0xb4/0x51c
	 dev_pm_opp_set_opp+0x70/0xfc
	 _set_required_opps.isra.0+0x74/0xd4
	 _set_opp+0x90/0x51c
	 dev_pm_opp_set_rate+0x184/0x274
	 set_target+0x34/0x40
	 __cpufreq_driver_target+0x250/0x698
	 sugov_work+0x54/0x70
	 kthread_worker_fn+0xc4/0x174
	 kthread+0x110/0x114
	 ret_from_fork+0x10/0x20

Thanks
Varada

