Return-Path: <linux-pm+bounces-17651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766B89CF48F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 20:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A9B1F23BAD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463611E104E;
	Fri, 15 Nov 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i9j/aLun"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895031E0E0A;
	Fri, 15 Nov 2024 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697722; cv=none; b=klJLfmq8oWTaYGCOlZK19ANMmy7/lJitbOV16LjHCMyOEns6u4T3M4RRj+D74bq1ofL8hVNeG6PII6YGvOYio5Jqxp2IdRECd/rUvNFaCx7I/7HOc0+IQqmioGto+/yp1qk+FUZS00AizJzvCFiKwMxtbqoOzUWBVL5Q22K8oxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697722; c=relaxed/simple;
	bh=TCOSm8clR8TI9u6P3no9b0j8BXQ1LAFANHu2wM43Lrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXlcAwcWTWqMplew0Skv9DQEM9jOQVqGIAzIM1ghM1F39Vb71L3+lMpxHpwRAcnx4m4SWEzsZiz+gSTp+Jq1JoeDjDfQNrIrtVw5uaFaNvBHQJ9jiliPkIIQZSKvBH6X5s031bw2n6fhRS0AuwsekOjm9aFpWxEoL/jWujLfekM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i9j/aLun; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF91kv8023967;
	Fri, 15 Nov 2024 19:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=S3OKejUHsvqVk7PU6/stDd70
	c9pYuhRxj1RM5Vzawqg=; b=i9j/aLunxtEiNHtvgR2yi3XotQ37mc4z/Fo5AFJU
	N5y8fZs7iRp9KNnG150GycG/TVmPDNXxb5eFVAppIyOlwO+LGK46PoLal7bj5Ebu
	EkG1ixd4trN0WNT/+dJQlxw9TIIjTO0uG5bkC1jX8DcSYK1Yb7xzJx5sfMI0xYIg
	MY75CDreDZsLYki89xqAoJaCdF5Luo7ZM4ezRH7XG+K7vmpgAMSv6Uqz3w/Ax7pC
	XCROvx9mDfs3TTSGpTcfKtri+7kBv7AdMArL2DCe+3ikulB6Z/cBRRjKDp/9lHeP
	/TJfI05HkVV68kHzUeBMtF2xTiHIhQPz++9YGMQ9VLBzOA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42x3achkd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 19:08:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFJ8NQp014202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 19:08:23 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 11:08:23 -0800
Date: Fri, 15 Nov 2024 11:08:22 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Stephen Boyd <swboyd@chromium.org>, Andy Yan <andy.yan@rock-chips.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh@kernel.org>, "Sebastian
 Reichel" <sre@kernel.org>,
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
Message-ID: <20241115101401666-0800.eberman@hu-eberman-lv.qualcomm.com>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
 <20241018-arm-psci-system_reset2-vendor-reboots-v6-3-50cbe88b0a24@quicinc.com>
 <CAE-0n515sUkmTWptgY8pOaMDBPfDp5pZBy9Nby+4cMdMAnAZfA@mail.gmail.com>
 <20241023092251529-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZzdOOP0KuMMdo64W@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZzdOOP0KuMMdo64W@lpieralisi>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7i90-Yo4Cnv42FH5lKbdam--oi7je5Dk
X-Proofpoint-ORIG-GUID: 7i90-Yo4Cnv42FH5lKbdam--oi7je5Dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150161

On Fri, Nov 15, 2024 at 02:35:52PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Oct 23, 2024 at 09:30:21AM -0700, Elliot Berman wrote:
> > On Fri, Oct 18, 2024 at 10:42:46PM -0700, Stephen Boyd wrote:
> > > Quoting Elliot Berman (2024-10-18 12:39:48)
> > > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > > index 2328ca58bba6..60bc285622ce 100644
> > > > --- a/drivers/firmware/psci/psci.c
> > > > +++ b/drivers/firmware/psci/psci.c
> > > > @@ -29,6 +29,8 @@
> > > >  #include <asm/smp_plat.h>
> > > >  #include <asm/suspend.h>
> > > >
> > > > +#define REBOOT_PREFIX "mode-"
> > > 
> > > Maybe move this near the function that uses it.
> > > 
> > > > +
> > > >  /*
> > > >   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> > > >   * calls it is necessary to use SMC64 to pass or return 64-bit values.
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
> Well, that's one of the doubts I have about enabling this code. From
> userspace we are requesting a reboot (I don't even think that user
> space knows which reboot modes are actually implemented (?)) and we may
> end up issuing one with completely different semantics ?

You're right here, userspace issue a "reboot bootloader" and if kernel
doesn't have the support to set up the right cookie, the device would do
a normal reboot and not stop at the bootloader. This problem exists
today and I think whether this is an issue to solve is out of scope here.

> 
> Are these "reset types" exported to user space ?
> 

No mechanism exists to do that. We could do something specific for PSCI
or do something generic for everybody. I don't think something specific
for PSCI is the right approach because it's a general problem. I don't
think there's enough interest to change reboot command plumbing to
advertise valid reset types to userspace.

- Elliot


