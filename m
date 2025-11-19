Return-Path: <linux-pm+bounces-38215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01557C6DC31
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 10:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 5AE432943D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D7333C514;
	Wed, 19 Nov 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPuKtQH6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925C3370F0;
	Wed, 19 Nov 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545073; cv=none; b=PYQ6FLuY/3X0p3T1113tavBAEe7vBFLHXDhL2l5+Fsj7F+EtTbyZq3P/g9z4n6EIOWneybFcOMNrG14hZCT/ls1FvfEXI/+DvxF2+55TZIH7zn9WML9qh2nr5o7acu5pm2CbAZx5bcinEIxlIQDgwPVshvZcyUHcBMSNCMR5eak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545073; c=relaxed/simple;
	bh=qJ27QqSqy2aQ8bR94H58fVNVBbRRWZpfIXXPaaaXVeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av+LoZV6Su5xB9EFE4R13yXmZCBB+EPxJ/OCvFoQBU8DgYtGQv1526IRmnG5gJTNMpB5Cp/2+PcQTARlrAKQ9Ha51ejL6UAhUTGrB9C2F1NmHRtx7wSQ9xwNXsQMtUBTj/pF52ivE1hY7ylhP/2N9NybmmWshs/DvXHOoykBVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPuKtQH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8534EC16AAE;
	Wed, 19 Nov 2025 09:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763545072;
	bh=qJ27QqSqy2aQ8bR94H58fVNVBbRRWZpfIXXPaaaXVeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPuKtQH6MddyMbxPVrr/nNCjUtZ7AXlEuqE0BlTxpgBNQw8YwN9ybmv46PRLnTfr1
	 63jqWbn0bdP1csm8sgAysRQ6xur+JDVkUvvRgzF+C14HhGSwykRolb1e9h9imoKZ3C
	 SApGLIm4eAzF44BbTxByeQFaiQriGYaIOsIqDsWNca94h1/d0BOoVXNmM049AEuNB6
	 UHoXRIP+cGxGvQBCOvZTOCfXvbFC/24I7Sz+0LrzyjMxPAjnSVc/Ul0Ar8009lG1ug
	 TSqpPcxgWV4qlDUKGjPTBwnk/IpS302LYiliwZRnpRi6P+Y1nl89qaC89OgFnHk5g1
	 kzbIeumuGYXAA==
Date: Wed, 19 Nov 2025 10:37:36 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	John Stultz <john.stultz@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Andre Draszik <andre.draszik@linaro.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	Elliot Berman <quic_eberman@quicinc.com>,
	Xin Liu <xin.liu@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>,
	Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
Subject: Re: [PATCH v17 07/12] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Message-ID: <aR2P4CxQNebac6oU@lpieralisi>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-7-46e085bca4cc@oss.qualcomm.com>
 <aRIfc9iuC2b9DqI+@lpieralisi>
 <80e68e44-a8e0-464a-056e-9f087ad40d51@oss.qualcomm.com>
 <aRxmWrAkD0Vu4pF+@lpieralisi>
 <1da024e7-efb1-3a1c-cc13-0ae5212ed8bd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da024e7-efb1-3a1c-cc13-0ae5212ed8bd@oss.qualcomm.com>

On Tue, Nov 18, 2025 at 11:11:33PM +0530, Shivendra Pratap wrote:

[...]

> > Yes this could be a potential way forward but that's decoupled from the
> > options below. If we take this route PSCI maintainers should be added
> > as maintainers for this reboot mode driver.
> 
> you mean the new psci_reset driver? yes. Maintainer would be PSCI maintainer,
> if we create a new  psci_reset reboot mode driver.

Yes.

> >> - struct with pre-built psci reset_types - (warm, soft, cold). Currently
> >>   only two modes supported, anything other than warm/soft defaults to cold.
> >> - vendor resets to be added as per vendor choice, inside psci device tree(SOC specific).
> >> - psci_reset registers with reboot-mode for registering  vendor resets. Here, we
> >>   have a problem, the pre-built psci reset_types - (warm, soft, cold) cannot be added via
> >>   reboot-mode framework.
> > 
> > Why ?
> 
> If we want the new psci_reset to take the reboot-mode framework route, is it ok to
> add default modes (warm, cold) in the device tree?
> If not, then the design of reboot-mode framework(power:reset:reboot-mode.c) needs to be
> further changed to equip this new feature. 

Well, yes, all it needs to do is allowing prepopulated reboot modes on top
of which DT based ones are added.

I don't see any point in adding properties to the DT node to provide
information we can already probe.

> If new psci_reset driver move away from reboot-mode framework(power:reset:reboot-mode.c), the driver
> can have its own design, its own sysfs interface and maintained under psci Maintainer.
> 
> > 
> >>   Should the new psci_reset driver, move away from reboot-mode
> >>   framework as-well? And define its own parsing logic for psci_reset_types,
> >>   and have its own restart_notifier instead of reboot_notifier?
> > 
> > No. As I said earlier, I think it makes sense to allow user space to
> > select _all_ PSCI reset types - architected and vendor specific in
> > a single reboot mode driver.
> > 
> > I believe that we must be able to have two well defined ways for
> > issuing resets:
> > 
> > - one based on reboot mode driver
> > - one based on reboot_mode variable interface
> 
> So may be in more details-
> user space issues - reboot cold
>    -> go for psci_reset (as psci_sysrest2 does not has cold reset?)
> user space issues - reboot warm or a vendor_reset
>    -> if psci_sysreset2 is supported - call psci_sysreset2 with required params.
>    ->   else
>    ->  go for psci_reset COLD
> 
> user space issues - reboot (no commands) or a panic_in_progress
>    -> fallback to reboot_mode 
>    ->  if (reboot_mode == WARM and psci_sysreset2 is supported )
>    ->     call psci_sysreset2 (ARCH WARM RESET)
>    ->  else
>    ->     go for psci_reset COLD
> 
> 
> And we want to do this in two conditional statements in firmware:psci: psci_sys_reset
> function?
> Or am i not getting the point here?

You are getting the point.

Thanks,
Lorenzo

> thanks,
> Shivendra
> 
> > 
> > Does this make sense everyone ? I don't know the history behind
> > reboot_mode and the reboot mode driver framework I am just stating
> > what I think makes sense to do for PSCI.
> > 
> > Thanks,
> > Lorenzo
> > 
> >> - If new psci_reset driver move away from reboot-mode, we can get rid of the panic_notifier
> >>   added in the psci code. Else, we may still need the panic_notifier for any kernel panic
> >>   that occurs between reboot_notifier and restart_notifier?
> >> - psci driver will export a function which will be called externally to set the current
> >>   psci reset_type.
> >> - psci_sys_reset in psci driver should remove the check on reboot_mode. It will default to
> >>   cold reset (for the reason the current kernel defaults to cold reset in psci.)
> >>   example change in psci_sys_reset:
> >>     if(psci_system_reset2_supported && <psci_reset_new_struct_var> != cold)
> >>        psci_sys_reset2(AS PER PARAMS FROM new psci_reset driver)
> >>     else
> >>        psci_sys_reset(COLD RESET)
> >>
> >> thanks,
> >> Shivendra

