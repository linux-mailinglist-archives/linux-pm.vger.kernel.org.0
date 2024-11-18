Return-Path: <linux-pm+bounces-17734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B99D18E7
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96341B20C6B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B8153BF0;
	Mon, 18 Nov 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eQLxlO6h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774317BBF;
	Mon, 18 Nov 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958223; cv=none; b=svcPZthNysXEmFTdjNsis3gvI2dI6o3BUIrGbqRAJx4auq8JavHCGJ3EDL4JI+NPem+nyoYvl2GybQ2LEaTHECRFra9YbnjEBUhxeM2oNUtIFuOlSnHiuX5w45DJ8udYRWt6imBm3J/kQpZPRIBu8fxxE8vS4vR0SKb9hsh3RLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958223; c=relaxed/simple;
	bh=9pb/UfvTZ5ffQXilPmxRhQXCj6SzJeUV/mNoDJqfciM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKRmwTUHw3BsRTnEwJGuYAuZtDkLNICQUv/jy7GOa1HvZxxcaG1eaHrMmHKNFYDQnVUssOETUwaC6oOc6WH00NtUdWTtdkTpqgY1CLSUhBuTn/bBAlAZwE9dGcTqgdBlP4I3//UwC8AtsgLiuHEP+ic1wlVUthAJXS2rKbMgRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eQLxlO6h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGLnb7011441;
	Mon, 18 Nov 2024 19:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ch9g1xvXWHfnC8QbBYmpT0Nb
	kpyf73TTNFt0J/RmQMM=; b=eQLxlO6hymPS3O3mNb2kcthKG2rd9unt4wgpewwm
	Sts+wtgmsWvmn4gqRz/+DcEgyVuykl+x/lFmkDyPPZesKpO6hoDH0M5eaRH82fJ0
	fNxKVbCntCwj7Ssn+mp732IIIctuwtqOlJQb7M88MhhkAGqvPWljNWoFPLyJMikE
	uKdWMS8NuPiGFaZKbZ6qZsKZZaka755cp0jI4zHsGEkNDVeNQEfmoSpgAbwbD8Vb
	OokGecy8Yiu7VUV8FMuMJtLaptZpK51uzD9oHoeBFCPl0RpNaa/NuFPtvUB4FmIv
	SwI66cbv08iKiyXR5dODOMLdJFo/dehxc4mHOt6JzWzIvQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43091m8dq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 19:30:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AIJTxC6011016
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 19:29:59 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 11:27:53 -0800
Date: Mon, 18 Nov 2024 11:27:53 -0800
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
Message-ID: <20241118104725157-0800.eberman@hu-eberman-lv.qualcomm.com>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
 <20241018-arm-psci-system_reset2-vendor-reboots-v6-3-50cbe88b0a24@quicinc.com>
 <CAE-0n515sUkmTWptgY8pOaMDBPfDp5pZBy9Nby+4cMdMAnAZfA@mail.gmail.com>
 <20241023092251529-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZzdOOP0KuMMdo64W@lpieralisi>
 <20241115101401666-0800.eberman@hu-eberman-lv.qualcomm.com>
 <ZztZq1ksXCkyLOvj@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZztZq1ksXCkyLOvj@lpieralisi>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XItZRysGkyZ-UJyI7NkUjXCXCsSwFEnA
X-Proofpoint-GUID: XItZRysGkyZ-UJyI7NkUjXCXCsSwFEnA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180160

On Mon, Nov 18, 2024 at 04:13:47PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Nov 15, 2024 at 11:08:22AM -0800, Elliot Berman wrote:
> > On Fri, Nov 15, 2024 at 02:35:52PM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Oct 23, 2024 at 09:30:21AM -0700, Elliot Berman wrote:
> > > > On Fri, Oct 18, 2024 at 10:42:46PM -0700, Stephen Boyd wrote:
> > > > > Quoting Elliot Berman (2024-10-18 12:39:48)
> > > > > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > > > > index 2328ca58bba6..60bc285622ce 100644
> > > > > > --- a/drivers/firmware/psci/psci.c
> > > > > > +++ b/drivers/firmware/psci/psci.c
> > > > > > @@ -29,6 +29,8 @@
> > > > > >  #include <asm/smp_plat.h>
> > > > > >  #include <asm/suspend.h>
> > > > > >
> > > > > > +#define REBOOT_PREFIX "mode-"
> > > > > 
> > > > > Maybe move this near the function that uses it.
> > > > > 
> > > > > > +
> > > > > >  /*
> > > > > >   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> > > > > >   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> > > > > > @@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> > > > > > +{
> > > > > > +       const char *cmd = data;
> > > > > > +       unsigned long ret;
> > > > > > +       size_t i;
> > > > > > +
> > > > > > +       for (i = 0; i < num_psci_reset_params; i++) {
> > > > > > +               if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > > > > > +                       ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > > > > > +                                            psci_reset_params[i].reset_type,
> > > > > > +                                            psci_reset_params[i].cookie, 0);
> > > > > > +                       pr_err("failed to perform reset \"%s\": %ld\n",
> > > > > > +                               cmd, (long)ret);
> > > > > 
> > > > > Do this intentionally return? Should it be some other function that's
> > > > > __noreturn instead and a while (1) if the firmware returns back to the
> > > > > kernel?
> > > > > 
> > > > 
> > > > Yes, I think it's best to make sure we fall back to the architectural
> > > > reset (whether it's the SYSTEM_RESET or architectural SYSTEM_RESET2)
> > > > since device would reboot then.
> > > 
> > > Well, that's one of the doubts I have about enabling this code. From
> > > userspace we are requesting a reboot (I don't even think that user
> > > space knows which reboot modes are actually implemented (?)) and we may
> > > end up issuing one with completely different semantics ?
> > 
> > You're right here, userspace issue a "reboot bootloader" and if kernel
> > doesn't have the support to set up the right cookie, the device would do
> > a normal reboot and not stop at the bootloader. This problem exists
> > today and I think whether this is an issue to solve is out of scope here.
> 
> That's true. It is the same issue we have with reboot_mode anyway.
> 
> Is it a fair statement to say that currently when we request a reboot,
> the reboot mode is the one set through /sys/kernel/reboot/mode ?
> 
> Does user space use that file today ?
> 
> I guess userspace does not take specific actions according to the
> reset it thinks it issues - it is a question.
> 

Yes, user space can write to that file. User space has to configure both
the mode and command to get the desired reboot configuration. I view the
vendor reset types as replacing "both", in the sense userspace may not
need to configure the reboot mode anymore. If "reboot bootloader" or
"reboot edl" requires a warm reset, the firmware knows that's how the
PMIC needs to be configured. I don't currently see any need for Linux to
be aware that a particular vendor reset type is "like a soft" or "like a
warm" or "like a cold" reset.

> > > Are these "reset types" exported to user space ?
> > > 
> > 
> > No mechanism exists to do that. We could do something specific for PSCI
> > or do something generic for everybody. I don't think something specific
> > for PSCI is the right approach because it's a general problem. I don't
> > think there's enough interest to change reboot command plumbing to
> > advertise valid reset types to userspace.
> 
> That's for sure. I suppose the most important bit is making sure that
> all resets comply with the kernel semantics expected from a *reset*;
> I appreciate that's a vague statement (and I have no idea how to enforce
> it) but that's the gist of this discussion.
> 
> Another thing I am worried about is device drivers restart handlers
> (ie having to parse a command that might be platform specific in a
> generic driver to grok what reset was actually issued and what action
> should be taken).

Right, I got your point! I haven't seen any drivers that care about it,
besides the ones that actually do the resetting.

I'm okay to say that all vendor SYSTEM_RESET2 need to be treated like a
REBOOT_COLD, but we might run into issue in future where we might want
some vendor SYSTEM_RESET2 to act be closer to some other mode. I suppose
then a device-specific driver is needed there.

In the hypothetical situation where we need reboot_mode to be a specific
value for a vendor SYSTEM_RESET2, I like my current approach.  Userspace
already needs to align the mode and command without the kernel enforcing
it, so it's possible we could still use the generic PSCI driver without
needing to write a device-specific driver to issue the vendor
SYSTEM_RESET2. If we hard-code that vendor SYSTEM_RESET2 must be like a
cold reset, then we definitely need a device-specific driver if we'd
rather it be like a warm or soft mode.

> I admit it is a tough nut to crack this one - apologies for the time
> it is taking to reach an agreement.
> 

This is a weird one :) It seems simple at first but it flexes the design
of reboot mode and command. I appreciate the time you've taken to look
at this!

- Elliot

