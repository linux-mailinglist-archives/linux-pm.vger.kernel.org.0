Return-Path: <linux-pm+bounces-12271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DCB9535C1
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 16:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC61281E86
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A2A1ABEC3;
	Thu, 15 Aug 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+JUIwVy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180A1ABEB9;
	Thu, 15 Aug 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732863; cv=none; b=eh99UN7KVr3Xy5VFX+tXCLBRuIcvRNhICqkotPuVBf5D/W9NQkUuU3ZlYryeL43RNUZyw2GzKKGGGyEoG2F4NKEMmxdb5NTNBh3aNVhO5JwiIxSSdbQeSgfyApSjl6Q6fOBHBxc5IiaqI+nPeyeoFVTJ1BsDIywTKF49Sx+ykv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732863; c=relaxed/simple;
	bh=3YSMK39m8QgE55j6X/6z5EauxRWQybHWvnMADAKlagk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL6d+vh1M+H9yoKOkJmYamFXt+bTaJh5xEgINUD0XKRoF8mUIQX8p02697+4FhxQbvQ3YxEs7E7OP7iRsrNiZ47DojSVMRFdmHR69fF525jHlca1LQ2d9qdZJ5oGvefU5YG5AUs2A5wKRoypPPTxCUUFn0z6pKIRtdYuQT7EE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+JUIwVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B317C4AF0D;
	Thu, 15 Aug 2024 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723732863;
	bh=3YSMK39m8QgE55j6X/6z5EauxRWQybHWvnMADAKlagk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+JUIwVyr/kpOljPB9N6+HapKCW5JnZGdtWENfO+Vlf7fv1jVt4AWSxg7pbrGB1iy
	 tiyjCicYP3ZiVYuP6Tas5n2TBNV6dJeH8uIK3aZBlSSdKCRjcDzU2MUCER0dN5fwx8
	 wfkwG1SbEAuSujlLjYwvqM+BPHh89/iCK+tMjDnXF5TRW6zp56QS9NRPqSPfaNlV/X
	 4JdvVTSOyflI3bwE+SyLebk7VQyQ6B3yrrkBKbxDU8Tem8bqwwkL6U9e/rYUGc3yIL
	 5SC6/6i4K5o45u3EuJj8rLsThb60EMKLATbfbU27ojLoKsHHG6AhCHxZb/48kd1OIE
	 OXtaqCTo28NTA==
Date: Thu, 15 Aug 2024 16:40:55 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Shivendra Pratap <quic_spratap@quicinc.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_spratap@qucinc.com
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Message-ID: <Zr4Td7PiKhKl3Et3@lpieralisi>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <ZrOMjomTTWZ91Uzf@lpieralisi>
 <20240807103245593-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZrYZ/i1QFhfmv0zi@lpieralisi>
 <20240809090339647-0700.eberman@hu-eberman-lv.qualcomm.com>
 <28c8bc92-4a55-8a07-1ece-333316d78410@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28c8bc92-4a55-8a07-1ece-333316d78410@quicinc.com>

On Mon, Aug 12, 2024 at 11:46:08PM +0530, Shivendra Pratap wrote:
> 
> 
> On 8/9/2024 10:28 PM, Elliot Berman wrote:
> > On Fri, Aug 09, 2024 at 03:30:38PM +0200, Lorenzo Pieralisi wrote:
> >> On Wed, Aug 07, 2024 at 11:10:50AM -0700, Elliot Berman wrote:
> >>
> >> [...]
> >>
> >>>>> +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> >>>>
> >>>> 'action' is unused and therefore it is not really needed.
> >>>>
> >>>>> +{
> >>>>> +	const char *cmd = data;
> >>>>> +	unsigned long ret;
> >>>>> +	size_t i;
> >>>>> +
> >>>>> +	for (i = 0; i < num_psci_reset_params; i++) {
> >>>>> +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> >>>>> +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> >>>>> +					     psci_reset_params[i].reset_type,
> >>>>> +					     psci_reset_params[i].cookie, 0);
> >>>>> +			pr_err("failed to perform reset \"%s\": %ld\n",
> >>>>> +				cmd, (long)ret);
> >>>>> +		}
> >>>>> +	}
> >>>>> +}
> >>>>> +
> >>>>>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> >>>>>  			  void *data)
> >>>>>  {
> >>>>> +	if (data && num_psci_reset_params)
> >>>>
> >>>> So, reboot_mode here is basically ignored; if there is a vendor defined
> >>>> reset, we fire it off.
> >>>>
> >>>> I think Mark mentioned his concerns earlier related to REBOOT_* mode and
> >>>> reset type (granted, the context was different):
> >>>>
> >>>> https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/
> >>>>
> >>>> I would like to understand if this is the right thing to do before
> >>>> accepting this patchset.
> >>>>
> >>>
> >>> I don't have any concerns to move this part below checking reboot_mode.
> >>> Or, I could add reboot_mode == REBOOT_COLD check.
> >>
> >> The question is how can we map vendor specific reboot magic to Linux
> >> reboot modes sensibly in generic PSCI code - that's by definition
> >> vendor specific.
> >>
> > 
> > I don't think it's a reasonable thing to do. "reboot bootloader" or
> > "reboot edl" don't make sense to the Linux reboot modes.
> > 
> > I believe the Linux reboot modes enum is oriented to perspective of
> > Linux itself and the vendor resets are oriented towards behavior of the
> > SoC.
> > 
> > Thanks,
> > Elliot
> > 
> 
> Agree.
> 
> from perspective of linux reboot modes, kernel's current implementation in reset path is like:
> __
> #1 If reboot_mode is WARM/SOFT and PSCI_SYSRESET2 is supported 
>     Call PSCI - SYSTEM_RESET2 - ARCH RESET
> #2 ELSE
>     Call PSCI - SYSTEM_RESET COLD RESET
> ___
> 
> ARM SPECS for PSCI SYSTEM_RESET2
> This function extends SYSTEM_RESET. It provides:
> • ARCH RESET: set Bit[31] to 0               = > This is already in place in condition #1.
> • vendor-specific resets: set Bit[31] to 1.  = > current patchset adds this part before kernel's reboot_mode reset at #0.
> 
> 
> In current patchset, we see a condition added at #0-psci_vendor_reset2 being called before kernel’s current reboot_mode condition and it can take any action only if all below conditions are satisfied.
> - PSCI SYSTEM_RESET2 is supported.
> - psci dt node defines an entry "bootloader" as a reboot-modes.
> - User issues reboot with a command say - (reboot bootloader).
> - If vendor reset fails, default reboot mode will execute as is.
> 
> Don't see if we will skip or break the kernel reboot_mode flow with this patch. 
> Also if user issues reboot <cmd> and <cmd> is supported on SOC vendor reset psci node, should cmd take precedence over kernel reboot mode enum? may be yes? 
> 

Please wrap lines when replying.

I don't think it is a matter of precedence. reboot_mode and the reboot
command passed to the reboot() syscall are there for different (?)
reasons.

What I am asking is whether it is always safe to execute a PSCI vendor
reset irrispective of the reboot_mode value.

Lorenzo

