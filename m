Return-Path: <linux-pm+bounces-37755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E34C484B3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 18:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F381886331
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7B82BCF46;
	Mon, 10 Nov 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQfdSfc0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D229BDAB;
	Mon, 10 Nov 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795394; cv=none; b=L3CkUSBm9PQK1xOxCZn2lr8AabIAma8nK4LfxbZoqKIWPbnVf0H5/1YJv6acSTrf4Rv9NJt7vrY84EgY6UeIqWvDrpPH3bVOZqV2Jvsk8uVrxSvAvd5XiPp2ImjpQQb5rahCQGEn/DrC1Qaby3+19IiBYJUBFh/fus35Vpl/xoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795394; c=relaxed/simple;
	bh=WYTcByahqL1XJ5FT3lBhy0MI/HDkJwgwIwz+0jeqOm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phRWYWEYAz4twg3a8bbQSvLEyRqIjEH3vYZIsTd5XKV/sUHup1lxnvPfAht7PaSmDJ4uyzdF0/cNuWfkCP7IoLb0q4tLqBfLcJN96ILFmS+GpxukPzjZ63Q1I6nEMpCtrp+ay/S0sa/0etzOteMxX4IkL7f2qsBFeSJMnpk6bIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQfdSfc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F51BC116B1;
	Mon, 10 Nov 2025 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762795394;
	bh=WYTcByahqL1XJ5FT3lBhy0MI/HDkJwgwIwz+0jeqOm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQfdSfc0cfZHtzUJ9FIF2TJPMrgiis+AW5bqE72iUAr1kJTRaaPZbUtpwRp9k3Fg7
	 kaDy+FJn/cM1RWvxz80jjg/KfwXU4WVPC7cyBKmTISUBRh5fMuslJq2kDzqgp3s/1/
	 ZL0GbW3pDL2bXsP+aocNuYRsgHgV4GNIN4A4zduz9RMakhewq0lXbWn2KGyT3KCHoM
	 W2vqrLu1S2H0Zz4lIJqrVVANUtH9jRz2N0TIscjfYZk29tRsZM3j9SmEDlpEdxRwEv
	 ee73ebFLg9QXRkGag3O1kxh/sVnZ5dHp2DUn/ZDsisMa/2lA/xybzW4CeaY3SsB3V9
	 Uuwb4FSO7OR1g==
Date: Mon, 10 Nov 2025 18:22:59 +0100
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
Message-ID: <aRIfc9iuC2b9DqI+@lpieralisi>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-7-46e085bca4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-7-46e085bca4cc@oss.qualcomm.com>

On Sun, Nov 09, 2025 at 08:07:20PM +0530, Shivendra Pratap wrote:
> SoC vendors have different types of resets which are controlled
> through various hardware registers. For instance, Qualcomm SoC
> may have a requirement that reboot with “bootloader” command
> should reboot the device to bootloader flashing mode and reboot
> with “edl” should reboot the device into Emergency flashing mode.
> Setting up such reboots on Qualcomm devices can be inconsistent
> across SoC platforms and may require setting different HW
> registers, where some of these registers may not be accessible to
> HLOS. These knobs evolve over product generations and require
> more drivers. PSCI spec defines, SYSTEM_RESET2, vendor-specific
> reset which can help align this requirement. Add support for PSCI
> SYSTEM_RESET2, vendor-specific resets and align the implementation
> to allow user-space initiated reboots to trigger these resets.
> 
> Implement the PSCI vendor-specific resets by registering to the
> reboot-mode framework.

I think that we should expose to user space _all_ PSCI reset types,
cold, warm + vendor specific - as a departure from using the reboot_mode
variable (and possibly deprecate it - or at least stop using it).

> As psci init is done at early kernel init, reboot-mode registration cannot
> be done at the time of psci init.  This is because reboot-mode creates a
> “reboot-mode” class for exposing sysfs, which can fail at early kernel init.
> To overcome this, introduce a late_initcall to register PSCI vendor-specific
> resets as reboot modes. Implement a reboot-mode write function that sets
> reset_type and cookie values during the reboot notifier callback.  Introduce
> a firmware-based call for SYSTEM_RESET2 vendor-specific reset in the
> psci_sys_reset path, using reset_type and cookie if supported by secure
> firmware. Register a panic notifier and clear vendor_reset valid status
> during panic.  This is needed for any kernel panic that occurs post
> reboot_notifiers.

Is it because panic uses reboot_mode to determine the reset to issue ?

> By using the above implementation, userspace will be able to issue
> such resets using the reboot() system call with the "*arg"
> parameter as a string based command. The commands can be defined
> in PSCI device tree node under “reboot-mode” and are based on the
> reboot-mode based commands.

IMHO - it would be nice if could add mode-cold (or mode-normal in reboot mode
speak) and mode-warm by default (if PSCI supports them) so that userspace
could issue those resets too without having to set the reboot_mode variable.

Reason is, since we are doing this it is worth going the whole nine
yards and try to decouple the reboot_mode variable from the RESTART2
syscall argument.

Reworded: just use the new userspace interface you are adding for
all PSCI reset types.

Thoughts very much welcome - I understand this is controversial.

> Reviewed-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> Reviewed-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> Reviewed-by: Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/firmware/psci/Kconfig |  2 +
>  drivers/firmware/psci/psci.c  | 92 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
> index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..93ff7b071a0c364a376699733e6bc5654d56a17f 100644
> --- a/drivers/firmware/psci/Kconfig
> +++ b/drivers/firmware/psci/Kconfig
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config ARM_PSCI_FW
>  	bool
> +	select POWER_RESET
> +	select REBOOT_MODE
>  
>  config ARM_PSCI_CHECKER
>  	bool "ARM PSCI checker"
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..ff82e7f4c27d1609a75cedc3a9790affaf839801 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -8,15 +8,18 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
> +#include <linux/bitops.h>
>  #include <linux/cpuidle.h>
>  #include <linux/debugfs.h>
>  #include <linux/errno.h>
>  #include <linux/linkage.h>
>  #include <linux/of.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/pm.h>
>  #include <linux/printk.h>
>  #include <linux/psci.h>
>  #include <linux/reboot.h>
> +#include <linux/reboot-mode.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  
> @@ -51,6 +54,24 @@ static int resident_cpu = -1;
>  struct psci_operations psci_ops;
>  static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
>  
> +struct psci_vendor_sysreset2 {
> +	u32 reset_type;
> +	u32 cookie;
> +	bool valid;
> +};
> +
> +static struct psci_vendor_sysreset2 vendor_reset;

I think this should represent all possible PSCI reset types, not vendor only
and its value is set by the reboot mode framework.

> +
> +static int psci_panic_event(struct notifier_block *nb, unsigned long v, void *p)
> +{
> +	vendor_reset.valid = false;

I don't like this. Basically all you want this for is to make sure that
we don't override the reboot_mode variable.

One (hack) would consist in checking the reboot_mode variable here and
set the struct I mentioned above to the value represented in reboot_mode.

Good luck if reboot_mode == REBOOT_GPIO :-)

> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block psci_panic_block = {
> +	.notifier_call = psci_panic_event
> +};
> +
>  bool psci_tos_resident_on(int cpu)
>  {
>  	return cpu == resident_cpu;
> @@ -309,7 +330,10 @@ static int get_set_conduit_method(const struct device_node *np)
>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>  			  void *data)
>  {
> -	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> +	if (vendor_reset.valid && psci_system_reset2_supported) {
> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
> +			       vendor_reset.cookie, 0);

See above. Two calls here: one for resets issued using the new userspace
interface you are adding and legacy below - no vendor vs reboot_mode, this
is a mess.

> +	} else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>  	    psci_system_reset2_supported) {
>  		/*
>  		 * reset_type[31] = 0 (architectural)
> @@ -547,6 +571,72 @@ static const struct platform_suspend_ops psci_suspend_ops = {
>  	.enter          = psci_system_suspend_enter,
>  };
>  
> +static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
> +{
> +	u32 magic_32;
> +
> +	if (psci_system_reset2_supported) {
> +		magic_32 = magic & GENMASK(31, 0);
> +		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic_32;
> +		vendor_reset.cookie = (magic >> 32) & GENMASK(31, 0);

Use FIELD_PREP/GET() please (but as mentioned above the vendor reset type
bit[31] should be part of the reboot mode magic value, see above).

> +		vendor_reset.valid = true;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int __init psci_init_vendor_reset(void)
> +{
> +	struct reboot_mode_driver *reboot;
> +	struct device_node *psci_np;
> +	struct device_node *np;
> +	int ret;
> +
> +	if (!psci_system_reset2_supported)
> +		return -EINVAL;
> +
> +	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
> +	if (!psci_np)
> +		return -ENODEV;
> +
> +	np = of_find_node_by_name(psci_np, "reboot-mode");
> +	if (!np) {
> +		of_node_put(psci_np);
> +		return -ENODEV;
> +	}
> +
> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &psci_panic_block);
> +	if (ret)
> +		goto err_notifier;
> +
> +	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
> +	if (!reboot) {
> +		ret = -ENOMEM;
> +		goto err_kzalloc;
> +	}
> +
> +	reboot->write = psci_set_vendor_sys_reset2;
> +	reboot->driver_name = "psci";
> +
> +	ret = reboot_mode_register(reboot, of_fwnode_handle(np));
> +	if (ret)
> +		goto err_register;
> +
> +	of_node_put(psci_np);
> +	of_node_put(np);
> +	return 0;
> +
> +err_register:
> +	kfree(reboot);
> +err_kzalloc:
> +	atomic_notifier_chain_unregister(&panic_notifier_list, &psci_panic_block);
> +err_notifier:
> +	of_node_put(psci_np);
> +	of_node_put(np);
> +	return ret;
> +}
> +late_initcall(psci_init_vendor_reset)

I don't like adding another initcall here.

I wonder whether this code belongs in a PSCI reboot mode driver, possibly a
faux device in a way similar to what we did for cpuidle-psci (that after all
is a consumer of PSCI_CPU_SUSPEND in a similar way as this code is a
PSCI_SYSTEM_RESET{2} consumer), that communicates with
drivers/firmware/psci/psci.c with the struct mentioned above.

Thanks,
Lorenzo

> +
>  static void __init psci_init_system_reset2(void)
>  {
>  	int ret;
> 
> -- 
> 2.34.1
> 

