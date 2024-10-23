Return-Path: <linux-pm+bounces-16332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6689AD767
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 00:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1EE1F23433
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 22:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2EF1E5731;
	Wed, 23 Oct 2024 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kdtS3g4P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83114BF87;
	Wed, 23 Oct 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721821; cv=none; b=lR3Bu+iudIujFCxdFtjH5+k9l8qFmzXkO/34lha/qnIeN+BUb/gNE9783o5yhNE2KDgDOi2UF9mRU8OvR3Yv3wPz7UdpvINdxD4Wh8JRDrKAdUkq1uFEizrd7+bFb4Dldi7ebsz0SxZ9FLUbHbAUV9LlOQD6SPR64GkMBQtwRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721821; c=relaxed/simple;
	bh=yYRHXHfS5yJQqCb4HqpzLBcBosjShZJGjPD2W8a7JjI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUXHN+WYKP0pTJL4SslsZ2TsoIA/7R07jinwZYCvhmOK2bhlDMGXHt9TLvCO87VVhOnl/jpeA175v0N9uMLi603eSan8G20aJdZnf0R4ET8Imtn8gs1e0dfAxFX5GOrJIf1TKEZVdwjY2+KDedYgxW5m02bWM8NdHImRfbSNhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kdtS3g4P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9p4Wt027446;
	Wed, 23 Oct 2024 22:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6tVOhdag10+zdto7khR1Tar4
	uRj8y/h1MvaU2T8DnuQ=; b=kdtS3g4PVRvQqa45IxeqL1K8c19uG7h4qSyPocdF
	zYHDhqLH1RYzZdufUQT9BZKiGsekheF/p/hBgP6gFJwPsi0Ld9jNoxyATPhFpxIB
	ixAF4NeCpC20ftLJ8jH0ULdtbsKT7OYHCxemBmCzkHbNuS1fTmuzwsneXVZXDu2F
	sFwoUNExw21cZB17syFIfVr3jkqa6iDzvSg3AmaGT5DCDYpMp60+PKlC6O1R6M9p
	vcrQ4G5N701pxAZMtEOYmbacL4lTeP1CYFIv/3CFWCBFHz0WDh8mM24rjQ7jnQ1z
	OtkCCCckMVK271lUhA5lHrU3NhxyQPZ9AKnsT0CdPCfLaQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wkk45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 22:16:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NMGdUZ003400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 22:16:39 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Oct 2024 15:16:38 -0700
Date: Wed, 23 Oct 2024 15:16:38 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Stephen Boyd <swboyd@chromium.org>
CC: Andy Yan <andy.yan@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Olof Johansson
	<olof@lixom.net>,
        Rob Herring <robh@kernel.org>, Sebastian Reichel
	<sre@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon
	<will@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Satya Durga
 Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] firmware: psci: Read and use vendor reset types
Message-ID: <20241023151556009-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
 <20241018-arm-psci-system_reset2-vendor-reboots-v6-3-50cbe88b0a24@quicinc.com>
 <CAE-0n515sUkmTWptgY8pOaMDBPfDp5pZBy9Nby+4cMdMAnAZfA@mail.gmail.com>
 <20241023092251529-0700.eberman@hu-eberman-lv.qualcomm.com>
 <CAE-0n50s1gUt7jOWLEjDzi7ABVRLmAr1kG-6V6YjTZnPD2EMQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAE-0n50s1gUt7jOWLEjDzi7ABVRLmAr1kG-6V6YjTZnPD2EMQw@mail.gmail.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jXbGRyJQK_qVccSCirzdUkNaGANmPeIF
X-Proofpoint-ORIG-GUID: jXbGRyJQK_qVccSCirzdUkNaGANmPeIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230144

On Wed, Oct 23, 2024 at 12:02:19PM -0700, Stephen Boyd wrote:
> Quoting Elliot Berman (2024-10-23 09:30:21)
> > On Fri, Oct 18, 2024 at 10:42:46PM -0700, Stephen Boyd wrote:
> > > Quoting Elliot Berman (2024-10-18 12:39:48)
> > > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > > index 2328ca58bba6..60bc285622ce 100644
> > > > --- a/drivers/firmware/psci/psci.c
> > > > +++ b/drivers/firmware/psci/psci.c
> > > > @@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> > > > +{
> > > > +       const char *cmd = data;
> > > > +       unsigned long ret;
> > > > +       size_t i;
> > > > +
> > > > +       for (i = 0; i < num_psci_reset_params; i++) {
> > > > +               if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > > > +                       ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > > > +                                            psci_reset_params[i].reset_type,
> > > > +                                            psci_reset_params[i].cookie, 0);
> > > > +                       pr_err("failed to perform reset \"%s\": %ld\n",
> > > > +                               cmd, (long)ret);
> > >
> > > Do this intentionally return? Should it be some other function that's
> > > __noreturn instead and a while (1) if the firmware returns back to the
> > > kernel?
> > >
> >
> > Yes, I think it's best to make sure we fall back to the architectural
> > reset (whether it's the SYSTEM_RESET or architectural SYSTEM_RESET2)
> > since device would reboot then.
> 
> Ok. Please add a comment in the code so we know that it's intentional.
> 
> >
> > > > +               }
> > > > +       }
> > > > +}
> > > > +
> > > >  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> > > >                           void *data)
> > > >  {
> > > > +       if (data && num_psci_reset_params)
> > > > +               psci_vendor_sys_reset2(action, data);
> > > > +
> 
> I'd add a comment here as well indicating that a fallback is used.
> 

Ack.

Thanks for the feedback!

- Elliot


