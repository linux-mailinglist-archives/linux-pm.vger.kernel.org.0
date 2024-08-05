Return-Path: <linux-pm+bounces-11910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D779C947783
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 10:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8201C21207
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2A14EC73;
	Mon,  5 Aug 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fBhRqAfC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093593FB3B;
	Mon,  5 Aug 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847446; cv=none; b=Ow9gqDp0hEO0EzgzZawM+RxuNBzjrDo6YEjgnrsb3CWkp1F965D/He4dMzHCLSSltajweNjsnjecpw6jSnhIQj3WKf0Z/ukxqQ2R12sIx3GyFSVbsj5NpHG9d4X6LsSn/cP4M7zTBNgjIutGNulmUBmWGx+DhkUFbybqT3XGYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847446; c=relaxed/simple;
	bh=P84bufUvbb/baZkAvRM3QWoRYArVv5ltMMCmqVZkat4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq1XTnwTHCpMvExg5DRvCelijJ/jmBF2yb5ffb6xqWTqaKMhDe9TTgtw2RzQD3zEQiJLQi7n1EFyFJO9lXmGWop4P337bnIv4T3um0olzy01Sgmac/rPUIzKGkruJrXnD39PI5Gu7RXUq/iKtzFijLZAsL5F9AuEoUGudif2cLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fBhRqAfC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752VWNe019109;
	Mon, 5 Aug 2024 08:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NzshO5L7CeE9rXcFLLTqTUx3
	99CeB/gX9htehoLfPIY=; b=fBhRqAfCQbcjNZTrkStyWMMcv5mT5tOmj+K781u+
	9REc2wAdWSWgu1GfEkpoBePo3gSnx4DAztYFRW97LE64vWuEjirc0AxThvp/kQ/0
	ckCcqcBzxIlk4HJcVlQH6dZeZx7T/9Ysh2O36iz6vjqc4C8e7N2VA51uznLKJkqm
	RFiy6FgXzMbjjEzV1iJtMAE3HvUp2IsSneweGMW9wyTFZDipy1EJOSi/VhPW2Hpx
	vuQgrb/QhJBZBGCrgAqB5dN/RvrIT/J8TlCpUjc1qAkR0aWAHN3Qoglpr1YbKDJK
	exeLIeCGVyJtdbxkBVGJ/pgugmQtbSwKVAOyEzvWNlFIgA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scs2uam3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 08:43:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4758hnUg031868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 08:43:49 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 5 Aug 2024 01:43:41 -0700
Date: Mon, 5 Aug 2024 14:13:38 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Niklas Cassel
	<nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Jeffrey Hugo
	<quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v15 09/10] soc: qcom: Add a driver for CPR3+
Message-ID: <ZrCQunPL/BWYwaR3@hu-varada-blr.qualcomm.com>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
 <20240708-topic-cpr3h-v15-9-5bc8b8936489@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240708-topic-cpr3h-v15-9-5bc8b8936489@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N9JZ8-M-6k7DAkJm_uU1fADo1bv2mxZh
X-Proofpoint-GUID: N9JZ8-M-6k7DAkJm_uU1fADo1bv2mxZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050061

On Mon, Jul 08, 2024 at 02:22:40PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>
> Introduce a new driver (based on qcom-cpr for CPRv1 IP) for the newer
> Qualcomm Core Power Reduction hardware, known downstream as CPR[34h]
> (h for hardened).
>
> In these new CPR versions, support for various new features was introduced.
> That includes:
> * voltage reduction for the GPU
> * security hardening
> * a new way of controlling CPU DVFS, based on internal communication
>   between CPRh and Operating State Manager MCUs.
>
> The CPR v3, v4 and CPRh are present in a broad range of SoCs, from the
> mid-range to the high end ones including, but not limited to:
> MSM8953/8996/8998 and SDM630/636/660/845.
>
> Note that to reduce the giant review and testing matrix of the driver, this
> patch (admittedly, somewhat confusingly but for good reasons) omits support
> for CPR*3* specifically, which is otherwise quite straightforward to add.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: rebase, a whole lot of cleanup/fixes]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/pmdomain/qcom/Kconfig      |   22 +
>  drivers/pmdomain/qcom/Makefile     |    4 +-
>  drivers/pmdomain/qcom/cpr-common.h |    2 +
>  drivers/pmdomain/qcom/cpr3.c       | 2711 ++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/cpr.h             |   17 +
>  5 files changed, 2755 insertions(+), 1 deletion(-)
>
	.
	.
	.
> +/**
> + * cpr_irq_handler() - Handle CPR3/CPR4 status interrupts
> + * @irq: Number of the interrupt
> + * @dev: Pointer to the cpr_thread structure
> + *
> + * Handle the interrupts coming from non-hardened CPR HW as to get
> + * an ok to scale voltages immediately, or to pass error status to
> + * the hardware (either success/ACK or failure/NACK).
> + *
> + * Return: IRQ_SUCCESS for success, IRQ_NONE if the CPR is disabled.
> + */
> +static irqreturn_t cpr_irq_handler(int irq, void *dev)
> +{
> +	struct cpr_thread *thread = dev;

While registering this handler with devm_request_threaded_irq,
'cpr_drv' pointer is used as the cookie. But, here the cookie is
being assumed to be cpr_thread. Is that intentional?

Getting this crash while testing:-

	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
	Mem abort info:
	  ESR = 0x0000000096000004
	  EC = 0x25: DABT (current EL), IL = 32 bits
	  SET = 0, FnV = 0
	  EA = 0, S1PTW = 0
	  FSC = 0x04: level 0 translation fault
	Data abort info:
	  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
	  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
	user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046efd000
	[0000000000000010] pgd=0000000000000000, p4d=0000000000000000
	Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
	Modules linked in:
	CPU: 0 UID: 0 PID: 72 Comm: irq/26-cpr Not tainted 6.11.0-rc1-next-20240729-00019-g244903f9355b-dirty #28
	Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7 (DT)
	pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	pc : mutex_lock+0x20/0x54
	lr : cpr_irq_handler+0x28/0x260
	sp : ffff80008613bd80
	x29: ffff80008613bd80 x28: ffff8000800b267c x27: ffff000006f92080
	x26: ffff000002989200 x25: ffff000002b28000 x24: 0000000000000001
	x23: ffff0000029892ac x22: ffff000002b28000 x21: 0000000000000000
	x20: 0000000000000010 x19: ffff000002ba2880 x18: 0000000000000001
	x17: 0000000073babcd7 x16: 0000000000000000 x15: ffff00003fc914c0
	x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
	x11: 0000000000000000 x10: 00000000000009b0 x9 : ffff80008613bd20
	x8 : ffff000002b28a10 x7 : ffff00003fc91700 x6 : ffff00003fc90cc0
	x5 : 00000000410fd090 x4 : 0000000000100000 x3 : 0000000000000000
	x2 : ffff000002b28000 x1 : ffff000002ba2880 x0 : 0000000000000010
	Call trace:
	 mutex_lock+0x20/0x54
	 irq_thread_fn+0x2c/0xa8
	 irq_thread+0x16c/0x274
	 kthread+0x110/0x114
	 ret_from_fork+0x10/0x20
	Code: b5000141 d65f03c0 d2800003 f9800011 (c85ffc01)
	---[ end trace 0000000000000000 ]---

Changing it to cpr_thread pointer in devm_request_threaded_irq
fixes the above crash.

> +	struct cpr_drv *drv = thread->drv;
> +	irqreturn_t ret = IRQ_HANDLED;
> +	int i, rc;
> +	enum voltage_change_dir dir = NO_CHANGE;
> +	u32 val;
> +
> +	guard(mutex)(&drv->lock);
> +
> +	val = cpr_read(thread, CPR3_REG_IRQ_STATUS);
> +
> +	dev_vdbg(drv->dev, "IRQ_STATUS = 0x%x\n", val);
> +
	.
	.
	.
> +/**
> + * cpr_thread_init() - Initialize CPR thread related parameters
> + * @drv: Main driver structure
> + * @tid: Thread ID
> + *
> + * Return: Zero for success, negative number on error
> + */
> +static int cpr_thread_init(struct cpr_drv *drv, int tid)
> +{
> +	const struct cpr_desc *desc = drv->desc;
> +	const struct cpr_thread_desc *tdesc = desc->threads[tid];
> +	struct cpr_thread *thread = &drv->threads[tid];
> +	bool pd_registered = false;
> +	int ret, i;
	.
	.
	.
> +	/* On CPRhardened, the interrupts are managed in firmware */
> +	if (desc->cpr_type != CTRL_TYPE_CPRH) {
> +		INIT_WORK(&thread->restart_work, cpr_restart_worker);
> +
> +		ret = devm_request_threaded_irq(drv->dev, drv->irq,
> +						NULL, cpr_irq_handler,
> +						IRQF_ONESHOT |
> +						IRQF_TRIGGER_RISING,
> +						"cpr", drv);

'drv' or 'thread' ?

Thanks
Varada

> +		if (ret)
> +			goto fail;
> +	}


