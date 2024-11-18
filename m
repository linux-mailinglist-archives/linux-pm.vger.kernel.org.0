Return-Path: <linux-pm+bounces-17726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A49D142E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 16:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBD7284526
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D91BAEDC;
	Mon, 18 Nov 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP2eA5+c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A11A0B0C;
	Mon, 18 Nov 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942837; cv=none; b=VrEn3k8Yew/Y1NHAEY0RZ6OPDDKljS6zly1CvsolPBZaNvn/JbJTjQfsHRSfVW7b4AXC5hEEd0QwQcVaeBUhYNfLZhlVr4EF+/sTz8O5CpBFUVBFpFJS0kcbkLsCmsDkaTGFUxhuKY5GFHCyfmn3HBE8Sc2wZzCIVSKiWbldtSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942837; c=relaxed/simple;
	bh=nwxs+Pgok1iHmZED1hS62HGL3ECEC031zlEfZR7ZHho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esD/0zPNp5xNLBaLnGgImk/tMtaHtAuoDkeLt3JHsXZBb1qdNKIsa9MAcMqMmRNl/C6LTOCkSryEcsSBihEmkpbxR9BFHtQz/UbNuSX+rBIffIzhsPsxZxiTCcFoyPHAU3eYjQnyzqhtKo5/4WWvQJQBAdj41FKbLkOV0lF83Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP2eA5+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159B2C4CED8;
	Mon, 18 Nov 2024 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731942837;
	bh=nwxs+Pgok1iHmZED1hS62HGL3ECEC031zlEfZR7ZHho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jP2eA5+ci4UjL6ymsR6d2tyOR/JgT46yIx8n+s706GKfYUN1/Qv0utpLtKSX6OkWU
	 jkJBQp8uzK/Wv9JVUlWR0uV1JoPAQc9oka7V6VHBG2jRb8Dr5jzbd5o51a/WX6Fe7Z
	 yqcj7rq2Wbswn+BN56l1jDTFlDLhSN/iWEnGGsULbts6Z5ETtuEBdh3LewbSPxaq6N
	 axXqoTcYFt4Dt1RONCzl40/+u3wrIXSbuWTXeE4Yt9vCfPrw2TgDXlXesAGwl/oIrW
	 9E2c3Ka8Zx4mXZzPWbEP2IeaRQzEiXRlZtWQOIcqJ7aDrviErXdBTK55NrVv7fqSb4
	 tO08QlSrTY08g==
Date: Mon, 18 Nov 2024 16:13:47 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Andy Yan <andy.yan@rock-chips.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Will Deacon <will@kernel.org>, cros-qcom-dts-watchers@chromium.org,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 3/5] firmware: psci: Read and use vendor reset types
Message-ID: <ZztZq1ksXCkyLOvj@lpieralisi>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
 <20241018-arm-psci-system_reset2-vendor-reboots-v6-3-50cbe88b0a24@quicinc.com>
 <CAE-0n515sUkmTWptgY8pOaMDBPfDp5pZBy9Nby+4cMdMAnAZfA@mail.gmail.com>
 <20241023092251529-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZzdOOP0KuMMdo64W@lpieralisi>
 <20241115101401666-0800.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115101401666-0800.eberman@hu-eberman-lv.qualcomm.com>

On Fri, Nov 15, 2024 at 11:08:22AM -0800, Elliot Berman wrote:
> On Fri, Nov 15, 2024 at 02:35:52PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Oct 23, 2024 at 09:30:21AM -0700, Elliot Berman wrote:
> > > On Fri, Oct 18, 2024 at 10:42:46PM -0700, Stephen Boyd wrote:
> > > > Quoting Elliot Berman (2024-10-18 12:39:48)
> > > > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > > > index 2328ca58bba6..60bc285622ce 100644
> > > > > --- a/drivers/firmware/psci/psci.c
> > > > > +++ b/drivers/firmware/psci/psci.c
> > > > > @@ -29,6 +29,8 @@
> > > > >  #include <asm/smp_plat.h>
> > > > >  #include <asm/suspend.h>
> > > > >
> > > > > +#define REBOOT_PREFIX "mode-"
> > > > 
> > > > Maybe move this near the function that uses it.
> > > > 
> > > > > +
> > > > >  /*
> > > > >   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> > > > >   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> > > > > @@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> > > > > +{
> > > > > +       const char *cmd = data;
> > > > > +       unsigned long ret;
> > > > > +       size_t i;
> > > > > +
> > > > > +       for (i = 0; i < num_psci_reset_params; i++) {
> > > > > +               if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > > > > +                       ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > > > > +                                            psci_reset_params[i].reset_type,
> > > > > +                                            psci_reset_params[i].cookie, 0);
> > > > > +                       pr_err("failed to perform reset \"%s\": %ld\n",
> > > > > +                               cmd, (long)ret);
> > > > 
> > > > Do this intentionally return? Should it be some other function that's
> > > > __noreturn instead and a while (1) if the firmware returns back to the
> > > > kernel?
> > > > 
> > > 
> > > Yes, I think it's best to make sure we fall back to the architectural
> > > reset (whether it's the SYSTEM_RESET or architectural SYSTEM_RESET2)
> > > since device would reboot then.
> > 
> > Well, that's one of the doubts I have about enabling this code. From
> > userspace we are requesting a reboot (I don't even think that user
> > space knows which reboot modes are actually implemented (?)) and we may
> > end up issuing one with completely different semantics ?
> 
> You're right here, userspace issue a "reboot bootloader" and if kernel
> doesn't have the support to set up the right cookie, the device would do
> a normal reboot and not stop at the bootloader. This problem exists
> today and I think whether this is an issue to solve is out of scope here.

That's true. It is the same issue we have with reboot_mode anyway.

Is it a fair statement to say that currently when we request a reboot,
the reboot mode is the one set through /sys/kernel/reboot/mode ?

Does user space use that file today ?

I guess userspace does not take specific actions according to the
reset it thinks it issues - it is a question.

> > Are these "reset types" exported to user space ?
> > 
> 
> No mechanism exists to do that. We could do something specific for PSCI
> or do something generic for everybody. I don't think something specific
> for PSCI is the right approach because it's a general problem. I don't
> think there's enough interest to change reboot command plumbing to
> advertise valid reset types to userspace.

That's for sure. I suppose the most important bit is making sure that
all resets comply with the kernel semantics expected from a *reset*;
I appreciate that's a vague statement (and I have no idea how to enforce
it) but that's the gist of this discussion.

Another thing I am worried about is device drivers restart handlers
(ie having to parse a command that might be platform specific in a
generic driver to grok what reset was actually issued and what action
should be taken).

I admit it is a tough nut to crack this one - apologies for the time
it is taking to reach an agreement.

Lorenzo

