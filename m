Return-Path: <linux-pm+bounces-16148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A819A9306
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959271C225DE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557801E376E;
	Mon, 21 Oct 2024 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SD2QvFNj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385E433D8;
	Mon, 21 Oct 2024 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548595; cv=none; b=BJzugd/+NQR6ahExkERHt8mo6Rz44/cUowtcY1u/HrXoLVzzzOF7NIBSxvW7BPrGPyFNZ1tS1hFf265+AJuUkkVuO7z2ch9yZhjTR2CQQCnovpuuZ7JxmsLsdxJmeLadF+5/HDEd/XVsrSd9/un5/xEQnKNtgz9hjR1dHIlgvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548595; c=relaxed/simple;
	bh=J5fOJ58JTriO00v8vqyJUW4f3Ol9azJwTH6+fgim+dw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx5kfLxdHhtUoMWfPt/K6MpZdIDiETdBh279E8I34iRR9AKq5gjtFyUGhx6AzDdvpNA3CPU7vVtGdfzrj4Fe4QLQq6PwQHbJjAbtgQu/v3vD52afodQNqmdScCpxS5D/Yi/VKrkvYst1To60fN2fOowvD6S8JBHvgbOSmmOqEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SD2QvFNj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKfrJ0029542;
	Mon, 21 Oct 2024 22:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wpi7o+07TDt9MzAXwaqEjlsG
	7+hYbr7RYO3nHtxlHmo=; b=SD2QvFNjfRKCxEmdlgivknQwgtNpKaChveNeCVqg
	oaYYKP0Q+wS7V+d/F0ZA/B3vaaph6ZO/8zK/kyiQcYXbGIQi7QIRoC0+XD4t/AG8
	aA3zJSoLv34YwX3uZTrYnTBaAEADleKh9HsMiG+xzl414/3rUQ6KjxsrCrhPRe6l
	wjMzULcJhSGLaPjJAbHd5FffmTzFU4yAcuoABU2oSnsOElyCZr7z0vXGZtU9byoB
	VHtIVSgoZV6HkafQTqDHPZtkdDBT9e+B88Mvx0YdiS5CLFeXawgE7QyQWMDLC7YD
	70xE7olMEH8e/r31qbza/tQyquRl6HMIwb1AM/z7MQn6yg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vc67be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 22:09:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LM9OXp029974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 22:09:24 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 15:09:18 -0700
Date: Tue, 22 Oct 2024 03:39:14 +0530
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] drm/msm/adreno: Add support for ACD
Message-ID: <20241021220914.vrxiyeoxjyxweovu@hu-akhilpo-hyd.qualcomm.com>
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-1-1e5e91aa95b6@quicinc.com>
 <1543ae2a-76ff-4b36-adae-37076e48b7f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1543ae2a-76ff-4b36-adae-37076e48b7f8@oss.qualcomm.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NsB4opqiPqmhR1jwMIwzlPqCN0S6yBOw
X-Proofpoint-ORIG-GUID: NsB4opqiPqmhR1jwMIwzlPqCN0S6yBOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=985 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210158

On Mon, Oct 21, 2024 at 11:38:41AM +0200, Konrad Dybcio wrote:
> On 11.10.2024 10:29 PM, Akhil P Oommen wrote:
> > ACD a.k.a Adaptive Clock Distribution is a feature which helps to reduce
> > the power consumption. In some chipsets, it is also a requirement to
> > support higher GPU frequencies. This patch adds support for GPU ACD by
> > sending necessary data to GMU and AOSS. The feature support for the
> > chipset is detected based on devicetree data.
> > 
> > Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> > ---
> 
> [...]
> 
> > +
> > +	/* Initialize qmp node to talk to AOSS */
> > +	gmu->qmp = qmp_get(gmu->dev);
> > +	if (IS_ERR(gmu->qmp)) {
> > +		cmd->enable_by_level = 0;
> > +		return dev_err_probe(gmu->dev, PTR_ERR(gmu->qmp), "Failed to initialize qmp\n");
> > +	}
> 
> I'm still in favor of keeping qmp_get where it currently is, so that
> probe can fail/defer faster

Sorry, I somehow missed this email from you until now.

If it fails, then it probably doesn't matter if it is a bit late. But for defer, isn't there
some optimizations to track the dependency from devicetree data? I am
not entirely sure!

Since qmp node is related to ACD, I felt it is better to:
  1. Keep all acd probe related code in a single place.
  2. Be more opportunistic in skipping qmp_get() wherever possible.

But if you still have strong opinion on this, I can move it back in the
next revision (v3).

-Akhil

> 
> Konrad

