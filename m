Return-Path: <linux-pm+bounces-41823-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 67P/IRK4fWmATQIAu9opvQ
	(envelope-from <linux-pm+bounces-41823-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 09:06:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0331CC12D0
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 09:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F10173003621
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 08:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0889301485;
	Sat, 31 Jan 2026 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OAZvnROL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DYXQ0kn0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D72580F2
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769846798; cv=none; b=T0HDSfHH3wAB6jMrti17yOAdRYUHJcPRUJPAg9VVOFZCDtR0GblPAVwHyLmxwpQlLAQcBqXWENprvTwgjLWR1NOSVupBaaad9xr/Ap2wecxAs6DFn/wpOzCZbq9KhxK3Dtw853anWpP4D5IH9/dNxaxbg/wklR93UQzu/9/M/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769846798; c=relaxed/simple;
	bh=TljDi4urrmN1/0f4TKu3S+ZKN1I9tBKkewQ8FXC5Myw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj11/pEbiLocQqVdhlNwwO00UqReLhY2ffgFwUM2db+0dnm8Sr7g0oRoZghgIpe30G3LlQ1afGeH5/yGOOxM2fwI1i0vEIMR8pXVMc5eM/eP2ti22jN1CRBCb0tyNPs9XpY1I6n4dKLtA90O1ev6230Z7RQQZNSY094fYseOd+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OAZvnROL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DYXQ0kn0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4SgM91510014
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 08:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gtvw/Y+adYkGVAvhe7+B4pJAGUVBfIyG3h0D4hvzEPg=; b=OAZvnROLpL/W+eiD
	UpKyFW/qhWr83E1MA4UQcxlirE0OX/3W+GPiz/9Bo6rNXTA42rHOvwekGpvISyu3
	Bf0+GL4eAuhTh29vBEXSXyfl6CbZ4D01ruIoHqUkMWIDTwBILvXs190u1kbn3XzJ
	bo55DGuo7gOuwV/uDZNx7IFgrEGaX2FX5VHybOhMjqSwaUFO0c1gq577dyIo4Ubp
	kbpYLL4CMbpkx7M7nprbkgc6OoHEVHW1b3peUluHhYoHDNGQdFZuc9eFl16TwHSv
	zjM8F1Hh+xOtwDndPIbkXXPByY8vdSLliCf/Eh2m3jFoozlzzRCHCy6hJAjknREs
	kpDsfQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1ard0esd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 08:06:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70ab7f67fso1215833485a.3
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 00:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769846795; x=1770451595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gtvw/Y+adYkGVAvhe7+B4pJAGUVBfIyG3h0D4hvzEPg=;
        b=DYXQ0kn0DKQgDqSKK+A2bxEdXwp/j6LhMWISuFArsCe1XoYTqW/XhEKjjAuDEaVHRO
         NCMzT5tPTHR7IVVBm4ac4eHncWwJclTgtgktvIKejhbyXP1bcTgtvGeHTCK7TMtL1sfU
         qFIIisDNy06LCCa4QoO4L/7DKzmUCrM8aK3zBCevk0GbfqtBN8YgID//q6V5KXVfiV6u
         JchywR/A57eX4EcpZ7Sp9YiftTy5GTYJYJ9+uZZkCzpVAnFiEG65LSCNZd+vkQMr3EGo
         ucjtnZAOaHFYeHaWCE8KOoFtyH/0U2spur2WtRz0zlvfp6PUQxOejGbT/JJFvnU+Bhrx
         VFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769846795; x=1770451595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gtvw/Y+adYkGVAvhe7+B4pJAGUVBfIyG3h0D4hvzEPg=;
        b=Fz+VOMzZ1hDmmOTY9eYibH+BUozvd2bxweKfnVAB50MpHvSCTAnz1ulCJpZVADAePW
         GQBsLdjH1GgfHEoxK+xcMKDk1kI8OGomNKTa9Llx3PFObhs6IgczlO940zKe2kEBlD0A
         CUApA6A9ytQmhFk2l01rhURYFjI/8J9x/W4868frI1wD43D2tW26ZLo6kbLWp6CWt5A7
         3YGchRoccWkh6rGE4TmW62w5XIS5q7ISWpXG+49vXVJftimaR/zVj79s1aVzsAFO9elL
         OnhzQLXBab4+Eo1T4hxTEtzOKGUJJRI4OYMzoV2njv8Zx9PyV0Kiod8YxJZ+3fnZPPJA
         GFkw==
X-Forwarded-Encrypted: i=1; AJvYcCU88fjmEFeREapbEO9e+Vqq8EPBuWGQCAkOqoSP0vk0nKXk1YzIjCnUKN5mev5o/3+RMZKfjuceBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WJcFv8Ho3oYGMgUNb/E7cvxIFONOXDsd6FmvUZ21BgOyUaDX
	4ehyZHtIKuGE6KZ7dQVBuxdqxU/iQIlE9zz60+L49ICRj9mxBUlkSCiZKk7OvFSb9BZMvFUR+Qd
	Wuc9ZThS1leZpOhslRd2nR3QZASWtTPkQfK8x07u1cisZm9oo6zryMI8CPP23ag==
X-Gm-Gg: AZuq6aKsSi9E1DYxObV2AsCitNod3wp9eu2tmPS5K7RmyBXMZBn3h7Zy4TTG+lEmuOr
	GRGmTCvVFNcu4WfJL7bXy3oB71neGbsvNJf8Q3lvE/ZU6JxOAiBb9pIXwT15MR1bgYqWNQxEQAx
	0tbLLU9t8Iv9lDN1xWgkfxyWrC6jIhKT8cyJmDs6k8mnjxnWNynhpcHXPdMJSNgJiLdxwR9PMc+
	EmVNrkaTDycBxh1lvw2JNY2OMsLibfOOTf0ratUuQXCDf2J4up0V2h3iRg06JSR7VPOUzattUzI
	gAxO92VPk3wtQXYNeYHqFr63vcR/3TqviUgawtX7mZLZ8LV6ZakEFgu3tBRH8eJdMbuvXLd7O6M
	aigXZZgmxeXUQ411b09Mv2uaEHK5WuAFX3B4yz21lbbzrtCb87LW5EIk/Xw0+iEkE23KfaCxdZZ
	BA/mYeAPRqC/VVnR1aZbwOfNU=
X-Received: by 2002:a05:620a:c50:b0:8c7:806:386 with SMTP id af79cd13be357-8c9eb23d647mr743400685a.34.1769846795352;
        Sat, 31 Jan 2026 00:06:35 -0800 (PST)
X-Received: by 2002:a05:620a:c50:b0:8c7:806:386 with SMTP id af79cd13be357-8c9eb23d647mr743397885a.34.1769846794798;
        Sat, 31 Jan 2026 00:06:34 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625c44c32sm18685831fa.1.2026.01.31.00.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 00:06:32 -0800 (PST)
Date: Sat, 31 Jan 2026 10:06:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, mathieu.poirier@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, amitk@kernel.org,
        mani@kernel.org, casey.connolly@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/8] remoteproc: qcom: probe all child devices
Message-ID: <33kugspepphj3ywp642bp5ee4zd6pk6pxbooe4knv62coeofo6@5zqxy4n37k3j>
References: <evb5tn2cht7wk76fuc2wpsyxepknigfw37633n6ypuapstbceh@tn5glmi65bdv>
 <cb5430c8-12d6-4439-b1ae-c2f36f29a9f8@oss.qualcomm.com>
 <57493aef-fb35-4377-8cf3-1df7f53470c9@oss.qualcomm.com>
 <74h7r3vsig3csejax3eu3uk53mdiimg2hjx7ntmmfrwdai6s3j@eiztghclfcvt>
 <5db5dafd-3c1f-4844-b822-bbfe86b3eb4d@oss.qualcomm.com>
 <ctrpymbvjlchp3djnsqq4bghkq2zvqnf5bebszi74f3d36l5dv@icvnkdwgdxmi>
 <ef1911f5-2d96-428c-93f1-3d1815710894@oss.qualcomm.com>
 <98397a59-8ef2-4202-ae41-015c895d6bce@oss.qualcomm.com>
 <c5ace95c-6ba1-4ce9-b461-82225a9fc576@oss.qualcomm.com>
 <f461ca33-0892-4a58-a40b-6da2a32d1430@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f461ca33-0892-4a58-a40b-6da2a32d1430@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDA2NiBTYWx0ZWRfX5u1PQIcltXYS
 NhORkDXOG1xjTcddL4j7VJAI+f2vt3XLA20jtYjxW9oWiWozDBijFlpSGa0YT0X9PR9uee+yk8h
 0++N26Bymnw/jBuxvq4xc752XQOfSxtsMVR5gZ2B9RtLzpTuB/FvOenZvZ1hbXAxLhaxlATkvSf
 ZoDUumuPMha3wCoFc16wY/F1dvzGr+d4eI4z4gPVAl4tZD6zYqCfHU+9dPx5MFCpN04rp23l67x
 crfOCv5M2KkpZWGoQmPkchQPHRrJVviofysPaNlPyN0rv8MgptGdlsztsXqsY1kZFAhfwCnvwrP
 KkZzwYJEo7nhZ+q62AsrF6/VMTJCFA4JSSRRnsqBt6Omp7tY/uG93lMtlEdh5aLr3CznD8u1tv+
 S8DAu16brvFXn8SuvfzXOuNK7dUQbRgkqw+l/6p67ZF8r6ai+qIw/KQvLN/ubNq9UFlFdJt64Lp
 qaC4SjbgmC1893x3Enw==
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=697db80b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=o83Q0L2AJKWppjFfjf8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YTzMcSCywQuAMVJRev9FGLL2wCqtDeT3
X-Proofpoint-GUID: YTzMcSCywQuAMVJRev9FGLL2wCqtDeT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601310066
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-41823-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0331CC12D0
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 10:13:06AM +0100, Konrad Dybcio wrote:
> On 1/30/26 8:03 AM, Gaurav Kohli wrote:
> > 
> > On 1/28/2026 3:15 PM, Konrad Dybcio wrote:
> >> On 1/28/26 10:39 AM, Gaurav Kohli wrote:
> >>> On 1/27/2026 10:11 PM, Dmitry Baryshkov wrote:
> >>>> On Tue, Jan 27, 2026 at 09:42:10PM +0530, Gaurav Kohli wrote:
> >>>>> On 1/24/2026 12:33 AM, Dmitry Baryshkov wrote:
> >>>>>> On Fri, Jan 23, 2026 at 07:23:39PM +0530, Gaurav Kohli wrote:
> >>>>>>> On 1/8/2026 12:37 PM, Gaurav Kohli wrote:
> >>>>>>>> On 1/3/2026 8:26 PM, Bjorn Andersson wrote:
> >>>>>>>>> On Tue, Dec 23, 2025 at 06:02:21PM +0530, Gaurav Kohli wrote:
> >>>>>>>>>> From: Casey Connolly <casey.connolly@linaro.org>
> >>>>>>>>>>
> >>>>>>>>>> Generalise the qcom,bam-dmux child node support by probing all
> >>>>>>>>>> remoteproc children with of_platform_populate(). This will be used to
> >>>>>>>>>> enable support for devices which are best represented as
> >>>>>>>>>> subnodes of the
> >>>>>>>>>> remoteproc, such as those representing QMI clients.
> >>>>>>>>> Please flip this around, start with the description of the problem
> >>>>>>>>> you're trying to solve.
> >>>>>>>>>
> >>>>>>>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> >>>>>>>>> This must have your signed-off-by, where you certifies the origin of
> >>>>>>>>> this patch.
> >>>>>>>>>
> >>>>>>>>>> ---
> >>>>>>>>>>      drivers/remoteproc/qcom_q6v5.c     | 4 ++++
> >>>>>>>>>>      drivers/remoteproc/qcom_q6v5_mss.c | 8 --------
> >>>>>>>>>>      2 files changed, 4 insertions(+), 8 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/remoteproc/qcom_q6v5.c
> >>>>>>>>>> b/drivers/remoteproc/qcom_q6v5.c
> >>>>>>>>>> index 58d5b85e58cd..a02839c7ed8c 100644
> >>>>>>>>>> --- a/drivers/remoteproc/qcom_q6v5.c
> >>>>>>>>>> +++ b/drivers/remoteproc/qcom_q6v5.c
> >>>>>>>>>> @@ -6,6 +6,7 @@
> >>>>>>>>>>       * Copyright (C) 2014 Sony Mobile Communications AB
> >>>>>>>>>>       * Copyright (c) 2012-2013, The Linux Foundation. All rights
> >>>>>>>>>> reserved.
> >>>>>>>>>>       */
> >>>>>>>>>> +#include <linux/of_platform.h>
> >>>>>>>>>>      #include <linux/kernel.h>
> >>>>>>>>>>      #include <linux/platform_device.h>
> >>>>>>>>>>      #include <linux/interconnect.h>
> >>>>>>>>>> @@ -351,6 +352,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5,
> >>>>>>>>>> struct platform_device *pdev,
> >>>>>>>>>>              return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
> >>>>>>>>>>                           "failed to acquire interconnect path\n");
> >>>>>>>>>>      +    of_platform_populate(q6v5->dev->of_node, NULL, NULL, q6v5->dev);
> >>>>>>>>> There are other child nodes here, in particular the GLINK and SMD edges.
> >>>>>>>>> Do we really want platform_devices registered for them?
> >>>>>>>>>
> >>>>>>>>> Regards,
> >>>>>>>>> Bjorn
> >>>>>>>> thanks for pointing this, can you please suggest the right approach.
> >>>>>>>>
> >>>>>>>> This should not impact glink, as that is registering as rproc sub node,
> >>>>>>>> And we need rproc cooling as child node
> >>>>>>>>
> >>>>>>>> of remote proc subsytem to create probe dependency only.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Can we do platform populate for specific child, would that be right
> >>>>>>>> approach. or we should create rproc cooling as independent of parent ?
> >>>>>>>>
> >>>>>>> HI Bjorn,
> >>>>>>>
> >>>>>>> I’d like to highlight the impact and details of placement of remoteproc
> >>>>>>> cooling dt node:
> >>>>>>>
> >>>>>>>
> >>>>>>> ->As a child of the remote proc subsystem node:
> >>>>>>>        In this configuration, the cooling device will only be probed once the
> >>>>>>> corresponding remote proc subsystem itself is probed.
> >>>>>>>
> >>>>>>> ->Outside the remote proc subsystem, may be part of soc node:
> >>>>>>>        In this setup, the cooling device will be probed independently. It will
> >>>>>>> wait until the remoteproc subsystem is brought up
> >>>>>>>        before completing cooling registration.
> >>>>>>>        The drawback here is that if the parent remoteproc subsystem is
> >>>>>>> disabled, the cooling device will still undergo an
> >>>>>>>        unnecessary probe, even though it cannot be registered.
> >>>>>> Bjorns question was different. It wasn't about pushing cooling device
> >>>>>> outside of the remoteproc node. It is about not registering the devices.
> >>>>>>
> >>>>>> Can we follow the approach outlined by qcom_add_smd_subdev() /
> >>>>>> qcom_add_glink_subdev()?
> >>>>> Hi Dmitry,
> >>>>>
> >>>>> Thanks for the review. Since the remoteproc cooling is a QMI-based driver,
> >>>>> it will receive the
> >>>>> subsystem up notification directly. Therefore, there’s no need to make it a
> >>>>> subdev node or
> >>>>> tie it into the init/reset sequence of remoteproc subsytem.
> >>>> But you've added a subnode for it (and we are discussing exactly
> >>>> of_platform_populate()) call. So, you are tying it to the remoteproc
> >>>> device lifecycle instead of the remoteproc subsys, which seems strange
> >>>> to me. There is no cooling device if the DSP is not running.
> >>>
> >>> For the cooling feature, we don’t need to define it as a subnode. The cooling subsystem becomes relevant only
> >>> after the remote subsystem is up, at which point it will receive add/delete notifications from the QMI server.
> >>>
> >>>
> >>> If child nodes must be modeled as subnodes for rproc, we can move the CDSP TMD out of the remoteproc and add in soc.
> >>> Is there currently a way for the remoteproc core layer to call of_platform_populate() without requiring a subnode?
> >> I think the question is "why can't you register the remoteproc device
> >> as a cooling_device, with perhaps #cooling-cells = <1>; instead of
> >> any form of children?"
> >>
> >> Konrad
> > 
> > 
> > thanks Konrad, for the review.
> > 
> > As each subsystem can expose multiple thermal mitigation devices via the remoteproc TMD service, so need to define child node.
> 
> I think you're stuck in an XY problem - you keep insisting that adding
> a subnode is your end goal, while you really want to achieve being able
> to register multiple cooling devices. Or at least that's how I read your
> messages since you happen not to give any explanation as to why it's
> actually necessary.
> 
> In my previous message, I forgot that cells for cooling devices actually
> represent the minimum and maximum cooling state allowed. But since the
> API is just part of the kernel, there's nothing preventing us from
> evolving it.
> 
> Currently, we have:
> 
> Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> 
> properties:
>   "#cooling-cells":
>     description:
>       Must be 2, in order to specify minimum and maximum cooling state used in
>       the cooling-maps reference. The first cell is the minimum cooling state
>       and the second cell is the maximum cooling state requested.
>     const: 2
> 
> But I think it would be perfectly fine to suggest a change such that
> if cells > 2, the last two cells keep the current behavior and the former
> ones let you index into a cooling device exposed through a single OF node

This might be a big change, which probably needs to be coordinated with
thermal and DT maintainers first.

> 
> e.g.
> 
> rproc_xyz: remoteproc {
> 	compatible = "qcom,rproc-xyz";
> 
> 	...
> 
> 	#cooling-device-cells = <3>;
> };

Which brings in another topic. In DT we have labels for different DT
children, which correspond to different handlers on the DSP side. For
the CDSP we see a "cdsp_sw" only. I think I've asked several times, but
didn't get an example of the device having more than one, just claims
that there might be more thane one TMD.

Do we need different cooling cells here? Or would it be enough to send
the same max state to all TMDs on the DSP side?

> 
> ...
> 
> thermal-zones {
> 	super-rproc-therm-a {
> 		thermal-sensors = <&rproc_xyz RPROC_XYZ_COOLING_A
> 				   THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 
> 		trips { ... } ;
> 	};
> 
> 	super-rproc-therm-b {
> 		thermal-sensors = <&rproc_xyz RPROC_XYZ_COOLING_B
> 				   THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 
> 		trips { ... } ;
> 	};
> };
> 
> This would be resolved by allowing drivers to register an .of_xlate-type
> function which would take the RPROC_XYZ_COOLING_n argument and e.g. use
> it as an index into struct thermal_cooling_device cdev[]; within the
> driver struct.



> 
> Konrad

-- 
With best wishes
Dmitry

