Return-Path: <linux-pm+bounces-11973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDC594AB1B
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC5C1C213E2
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7A1126F1E;
	Wed,  7 Aug 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCsOXo3R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1E85654;
	Wed,  7 Aug 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042966; cv=none; b=ch8wKCeva3N56WjZs7hS4ZOc3UBnsiqxTzuDNiuodK3hHlaDkMM+dP6HQJpTxsoR0O+eJQHtY5ooa/7PRtyh38Q6+VWzroGO6WDGVBzUeAapi8ZR3yJPAY6LiSxhvSMVVSwVueBALDipqpFVMQTOs1g9uOhe9Cjv01txZQhxPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042966; c=relaxed/simple;
	bh=biH+U01nxwxEeqT9f/bCBvINyb2qztxIVE1TeA/3V30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T09AiMVdqf3Tb/lW1asprs21Xg+W8cAvKnrnJq7fNzq9Se6oWWo+HClCQ8Wo3JP37SxY62Mkw9tcuT2Xlibf+ggYWRdct5sx5b0eYM7os/DvuOKrh0sC52IQEaFQVSe4Ol/p3aoOsmUrIbmWi9z+aypStHS7c216MSLgwBZ5EJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCsOXo3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AD5C4AF0D;
	Wed,  7 Aug 2024 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723042965;
	bh=biH+U01nxwxEeqT9f/bCBvINyb2qztxIVE1TeA/3V30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qCsOXo3RdTXUAKRqdO8BnZoDN58uw7xLzcrszatlO8v4nuWDF6xWLYtPrwPlQ59SC
	 XjufuwlRfaMEr5OI8q0Yv4zkrHbbX7D8DZMxCbzlVMSYOXn3vHTCYz1cL0G2X0XOnt
	 Yr89p7WalqVKv/Z+ozY1Gw97/XsU4qg7nBM1jsqdGnjqoGPk7KaypYa0kglB583fjf
	 XRg/VnSsx8cTbBKxBOMBzlt2biL2bKFOzd6cc6K4A6L8B5IZFRJiHLsQ3d2n1nsw8k
	 /VRP0vHM4eByjflxAAEcybDYfyKpocvHnOF2cFkBAE1sjA1I0aEu61oJyasSbj8zTm
	 PBRHoeuvtPuCw==
Date: Wed, 7 Aug 2024 17:02:38 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Message-ID: <ZrOMjomTTWZ91Uzf@lpieralisi>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>

On Mon, Jun 17, 2024 at 10:18:09AM -0700, Elliot Berman wrote:
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
> 
> A separate initcall is needed to parse the devicetree, instead of using
> psci_dt_init because mm isn't sufficiently set up to allocate memory.
> 
> Reboot mode framework is close but doesn't quite fit with the
> design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
> be solved but doesn't seem reasonable in sum:
>  1. reboot mode registers against the reboot_notifier_list, which is too
>     early to call SYSTEM_RESET2.

Please define "too early" (apologies if it has been explained before).

>     PSCI would need to remember the reset type from the reboot-mode
>     framework callback and use it psci_sys_reset.
>  2. reboot mode assumes only one cookie/parameter is described in the
>     device tree. SYSTEM_RESET2 uses 2: one for the type and one for
>     cookie.

That's surmountable I suppose.

>  3. psci cpuidle driver already registers a driver against the
>     arm,psci-1.0 compatible. Refactoring would be needed to have both a
>     cpuidle and reboot-mode driver.

We could put together a PSCI "parent" driver that creates child platform
devices for idle and reboot drivers to match (which actually is not
really pretty but it would make more sense than matching the idle
driver only to the psci compatible string, which is what current code
does).

> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/firmware/psci/psci.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index d9629ff87861..e672b33b71d1 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -29,6 +29,8 @@
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  
> +#define REBOOT_PREFIX "mode-"
> +
>  /*
>   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
>   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> @@ -79,6 +81,14 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
>  static u32 psci_cpu_suspend_feature;
>  static bool psci_system_reset2_supported;
>  
> +struct psci_reset_param {
> +	const char *mode;
> +	u32 reset_type;
> +	u32 cookie;
> +};
> +static struct psci_reset_param *psci_reset_params;
> +static size_t num_psci_reset_params;
> +
>  static inline bool psci_has_ext_power_state(void)
>  {
>  	return psci_cpu_suspend_feature &
> @@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
>  	return 0;
>  }
>  
> +static void psci_vendor_sys_reset2(unsigned long action, void *data)

'action' is unused and therefore it is not really needed.

> +{
> +	const char *cmd = data;
> +	unsigned long ret;
> +	size_t i;
> +
> +	for (i = 0; i < num_psci_reset_params; i++) {
> +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> +					     psci_reset_params[i].reset_type,
> +					     psci_reset_params[i].cookie, 0);
> +			pr_err("failed to perform reset \"%s\": %ld\n",
> +				cmd, (long)ret);
> +		}
> +	}
> +}
> +
>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>  			  void *data)
>  {
> +	if (data && num_psci_reset_params)

So, reboot_mode here is basically ignored; if there is a vendor defined
reset, we fire it off.

I think Mark mentioned his concerns earlier related to REBOOT_* mode and
reset type (granted, the context was different):

https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/

I would like to understand if this is the right thing to do before
accepting this patchset.

Thanks,
Lorenzo

> +		psci_vendor_sys_reset2(action, data);
> +
>  	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>  	    psci_system_reset2_supported) {
>  		/*
> @@ -748,6 +778,68 @@ static const struct of_device_id psci_of_match[] __initconst = {
>  	{},
>  };
>  
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
> +
> +	for_each_property_of_node(np, prop) {
> +		if (strncmp(prop->name, REBOOT_PREFIX, len))
> +			continue;
> +		num = of_property_count_elems_of_size(np, prop->name, sizeof(magic[0]));
> +		if (num != 1 && num != 2)
> +			continue;
> +
> +		count++;
> +	}
> +
> +	param = psci_reset_params = kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
> +	if (!psci_reset_params)
> +		return -ENOMEM;
> +
> +	for_each_property_of_node(np, prop) {
> +		if (strncmp(prop->name, REBOOT_PREFIX, len))
> +			continue;
> +
> +		param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> +		if (!param->mode)
> +			continue;
> +
> +		num = of_property_read_variable_u32_array(np, prop->name, magic, 1, 2);
> +		if (num < 0) {
> +			pr_warn("Failed to parse vendor reboot mode %s\n", param->mode);
> +			kfree_const(param->mode);
> +			continue;
> +		}
> +
> +		/* Force reset type to be in vendor space */
> +		param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
> +		param->cookie = num == 2 ? magic[1] : 0;
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

