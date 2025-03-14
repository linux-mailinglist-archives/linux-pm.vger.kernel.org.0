Return-Path: <linux-pm+bounces-24022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AA6A60FC9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097517ACD3A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5984F1FA243;
	Fri, 14 Mar 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjjMhDN6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257312AF1D;
	Fri, 14 Mar 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951184; cv=none; b=R1fbdTDFsNUi4BRhmjO9Z6gSQMqsOIRhlQqAf9BSjkmxuwCqbui9YL+ThXSuhcrEUPlt6pQON6PJp3XwZWqaytu6d8YPXQwLHk6wcIei7cV8ID26ww59JFmwLLTDb4BItuEYGfTr3xj0QA2UWXXS0Yk/SGZvDzMCDf1Q+eT0/lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951184; c=relaxed/simple;
	bh=oqVgxdpTP6G2PaiGKfQC4A75YZyp+n3zWNLGzhZi3Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5fipDCd1D1ga5SlQ+K52O71lge2QlwQE30dyV/SOHHtooIu7xYfBHM2XYbpEstipwpcBJ3o578u7J3hvbr7+jFHheC0Gz9uTkzZzL49M/dezahc7+92UF92Byb2qOGz/VaZJiLAFf4R+O4bXZRFLLS7IZHn94oQOrVfa4ezya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjjMhDN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C6BC4CEE9;
	Fri, 14 Mar 2025 11:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741951183;
	bh=oqVgxdpTP6G2PaiGKfQC4A75YZyp+n3zWNLGzhZi3Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjjMhDN6TgO6LGNUdqHBc4gzpfwcgKKS0B58OrCbfyJQMPpXv5ytGjdGwIdnFkB/J
	 f1zPN4QTih0sP9PEytu5yT3wL2hKPfTosDCTUaEaZ10Y9Vh9WW32Y2xUqva2Sb5oF9
	 KkdiNSLOoiiN5gXEJHzJEy7oWr8SmzETnbusOqHG/ljSsMhXeyHwc3ImmAh0Im0BjF
	 VF1NJulcguYsWchdK5C4fDd82G3u+CXXwGNxFbjx5+uQAfYmncHo8cxA/Wafmi3gFF
	 Md8P90ysNU7Dfb+mm0ije8hK0pWr0i93VwfwPv0fmUnk2dnf87LZ/BYKu2sNwCItCp
	 3hsJvf4YkeqDg==
Date: Fri, 14 Mar 2025 12:19:31 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, cros-qcom-dts-watchers@chromium.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Elliot Berman <elliotb317@gmail.com>,
	Elliot Berman <elliot.berman@oss.qualcomm.com>
Subject: Re: [PATCH v9 2/5] firmware: psci: Read and use vendor reset types
Message-ID: <Z9QQw6BcE7IXzu+r@lpieralisi>
References: <20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com>
 <20250303-arm-psci-system_reset2-vendor-reboots-v9-2-b2cf4a20feda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-arm-psci-system_reset2-vendor-reboots-v9-2-b2cf4a20feda@oss.qualcomm.com>

On Mon, Mar 03, 2025 at 01:08:31PM -0800, Elliot Berman wrote:
> From: Elliot Berman <elliot.berman@oss.qualcomm.com>
> 
> SoC vendors have different types of resets and are controlled through
> various registers. For instance, Qualcomm chipsets can reboot to a
> "download mode" that allows a RAM dump to be collected. Another example
> is they also support writing a cookie that can be read by bootloader
> during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
> vendor reset types to be implemented without requiring drivers for every
> register/cookie.
> 
> Add support in PSCI to statically map reboot mode commands from
> userspace to a vendor reset and cookie value using the device tree.

I have managed to discuss a little bit this patchset over the last
few days and I think we have defined a plan going forward.

A point that was raised is:

https://man7.org/linux/man-pages/man2/reboot.2.html

LINUX_REBOOT_CMD_RESTART2 *arg command, what is it supposed to
represent ?

Is it the mode the system should reboot into OR it is the
actual command to be issued (which is what this patchset
implements) ?

LINUX_REBOOT_CMD_RESTART "..a default restart..."

It is unclear what "default" means. We wonder whether the
reboot_mode variable was introduced to _define_ that "default".

So, in short, my aim is trying to decouple reboot_mode from the
LINUX_REBOOT_CMD_RESTART2 *arg command.

I believe that adding a sysfs interface to reboot-mode driver
infrastructure would be useful, so that the commands would
be exposed to userspace and userspace can set the *arg command
specifically to issue a given reset/mode.

I wonder why this is not already in place for eg syscon-reboot-mode
resets, how does user space issue a command in those systems if the
available commands aren't exposed to userspace ?

Is there a kernel entity exposing those "modes" to userspace, somehow ?

> A separate initcall is needed to parse the devicetree, instead of using
> psci_dt_init because mm isn't sufficiently set up to allocate memory.
> 
> Reboot mode framework is close but doesn't quite fit with the
> design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
> be solved but doesn't seem reasonable in sum:
>  1. reboot mode registers against the reboot_notifier_list, which is too
>     early to call SYSTEM_RESET2. PSCI would need to remember the reset
>     type from the reboot-mode framework callback and use it
>     psci_sys_reset.
>  2. reboot mode assumes only one cookie/parameter is described in the
>     device tree. SYSTEM_RESET2 uses 2: one for the type and one for
>     cookie.

This can be changed and I think it should, so that the reboot modes
are exposed to user space and PSCI can use that.

>  3. psci cpuidle driver already registers a driver against the
>     arm,psci-1.0 compatible. Refactoring would be needed to have both a
>     cpuidle and reboot-mode driver.
> 
> Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
> ---
>  drivers/firmware/psci/psci.c | 105 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index a1ebbe9b73b136218e9d9f9b8daa7756b3ab2fbe..6f8c47deaec0225f26704e1f3bcad52603127a85 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -80,6 +80,14 @@ static u32 psci_cpu_suspend_feature;
>  static bool psci_system_reset2_supported;
>  static bool psci_system_off2_hibernate_supported;
>  
> +struct psci_reset_param {
> +	const char *mode;
> +	u32 reset_type;
> +	u32 cookie;
> +};
> +static struct psci_reset_param *psci_reset_params __ro_after_init;
> +static size_t num_psci_reset_params __ro_after_init;
> +
>  static inline bool psci_has_ext_power_state(void)
>  {
>  	return psci_cpu_suspend_feature &
> @@ -306,9 +314,39 @@ static int get_set_conduit_method(const struct device_node *np)
>  	return 0;
>  }
>  
> +static int psci_vendor_system_reset2(const char *cmd)
> +{
> +	unsigned long ret;
> +	size_t i;
> +
> +	for (i = 0; i < num_psci_reset_params; i++) {
> +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> +					     psci_reset_params[i].reset_type,
> +					     psci_reset_params[i].cookie, 0);
> +			/*
> +			 * if vendor reset fails, log it and fall back to
> +			 * architecture reset types

That's not what the code does.

> +			 */
> +			pr_err("failed to perform reset \"%s\": %ld\n", cmd,
> +			       (long)ret);
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>  			  void *data)
>  {
> +	/*
> +	 * try to do the vendor system_reset2
> +	 * If there wasn't a matching command, fall back to architectural resets
> +	 */
> +	if (data && !psci_vendor_system_reset2(data))
> +		return NOTIFY_DONE;
> +
>  	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>  	    psci_system_reset2_supported) {
>  		/*
> @@ -795,6 +833,73 @@ static const struct of_device_id psci_of_match[] __initconst = {
>  	{},
>  };
>  
> +#define REBOOT_PREFIX "mode-"
> +
> +static int __init psci_init_system_reset2_modes(void)
> +{
> +	const size_t len = strlen(REBOOT_PREFIX);
> +	struct psci_reset_param *param;
> +	struct device_node *psci_np __free(device_node) = NULL;
> +	struct device_node *np __free(device_node) = NULL;
> +	struct property *prop;
> +	size_t count = 0;
> +	u32 magic[2];
> +	int num;
> +
> +	if (!psci_system_reset2_supported)
> +		return 0;
> +
> +	psci_np = of_find_matching_node(NULL, psci_of_match);
> +	if (!psci_np)
> +		return 0;
> +
> +	np = of_find_node_by_name(psci_np, "reset-types");
> +	if (!np)
> +		return 0;

Related to my initial question above. If LINUX_REBOOT_CMD_RESTART2 *arg command,
is the actual reset to be issued, should we add a default mode "cold"
and, if SYSTEM_RESET2 is supported, a "warm" reset mode too ?

It all boils down to what *arg represents - adding "cold" and "warm"
modes would remove the dependency on reboot_mode for resets issued
through LINUX_REBOOT_CMD_RESTART2, the question is whether this
is the correct thing to do.

Comments very welcome.

Thanks,
Lorenzo

> +
> +	for_each_property_of_node(np, prop) {
> +		if (strncmp(prop->name, REBOOT_PREFIX, len))
> +			continue;
> +		num = of_property_count_u32_elems(np, prop->name);
> +		if (num != 1 && num != 2)
> +			continue;
> +
> +		count++;
> +	}
> +
> +	param = psci_reset_params =
> +		kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
> +	if (!psci_reset_params)
> +		return -ENOMEM;
> +
> +	for_each_property_of_node(np, prop) {
> +		if (strncmp(prop->name, REBOOT_PREFIX, len))
> +			continue;
> +
> +		num = of_property_read_variable_u32_array(np, prop->name, magic,
> +							  1, ARRAY_SIZE(magic));
> +		if (num < 0) {
> +			pr_warn("Failed to parse vendor reboot mode %s\n",
> +				param->mode);
> +			kfree_const(param->mode);
> +			continue;
> +		}
> +
> +		param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> +		if (!param->mode)
> +			continue;
> +
> +		/* Force reset type to be in vendor space */
> +		param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
> +		param->cookie = num > 1 ? magic[1] : 0;
> +		param++;
> +		num_psci_reset_params++;
> +	}
> +
> +	return 0;
> +}
> +arch_initcall(psci_init_system_reset2_modes);
> +
>  int __init psci_dt_init(void)
>  {
>  	struct device_node *np;
> 
> -- 
> 2.34.1
> 

