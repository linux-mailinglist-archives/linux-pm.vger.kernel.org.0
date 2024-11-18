Return-Path: <linux-pm+bounces-17717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8639D108B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 13:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178241F2293C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED5199253;
	Mon, 18 Nov 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZuXVAwQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9ED19412E;
	Mon, 18 Nov 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932818; cv=none; b=Pbcz7WjDQTf/GiSknidhxUi1kKFA44hnsKNfCL1j3Ooddm/n9dyFxYjhiDcaWY3kVF7hh6wbKu4PH3+VtBNkJcJ3dC53P+83np9VcrjXYKVB/OVmiDqtnDdzV6ADe02kPRZFrc9N4owSNeSyB5MtCMpHpjgmTrXDRFMUrv8FnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932818; c=relaxed/simple;
	bh=deJLPut/y9S0tvtjlmx4U4lz54CsfgJKTfqC8VQH+BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnRKGiLvDinioykbsuXUBkivs8Uc48HGQPOCiioohl64Dkty4YUo791WuryM1xqHnEaRSVlDYU/TIFKPiCtt1NWGlOMNLwSR2g4m96jc1uDZUiLM9lcMNfSI6zCifvRgx3fVNTpbwMKi42baivf9pEYFK6OKvP1cx9LtoELXv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZuXVAwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9290EC4CECC;
	Mon, 18 Nov 2024 12:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731932818;
	bh=deJLPut/y9S0tvtjlmx4U4lz54CsfgJKTfqC8VQH+BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZuXVAwQEwzKxFtrf5q9FIeMsCIsYM0eS1m9RyPqwqhQmM3jDzbbEiS6RZsa1Sjah
	 lUqZcI9k0BLRWyruMxRvrfA+cijJuHBmuzI5xY3OCdDwGF0o2E7/Em7v2gAtbUryxK
	 TSvg68J4OQJ218rf9UQ0RVLDTmBzVpvOJLj/wjaah6l5lG0Mf7nunyHXgRb++LfQr3
	 hHQkS66be/NlrBZRxKKdOZasv/rsASuegBhc3C+E4YwCZUMvftv9lHY3YSw8I8tkRT
	 poqNrlN8qwk5cifllyFQ4+77d0vrh6QbodtTQY9cALlgZfZcoBj3H4hP2SPCgPwKSa
	 P+BSz1thqgnxA==
Date: Mon, 18 Nov 2024 13:26:48 +0100
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
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 3/6] firmware: psci: Read and use vendor reset types
Message-ID: <ZzsyiC/dwv8dgySN@lpieralisi>
References: <20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com>
 <20241107-arm-psci-system_reset2-vendor-reboots-v8-3-e8715fa65cb5@quicinc.com>
 <ZzdR1HuTpnU1OL/i@lpieralisi>
 <20241115103434410-0800.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115103434410-0800.eberman@hu-eberman-lv.qualcomm.com>

On Fri, Nov 15, 2024 at 11:08:13AM -0800, Elliot Berman wrote:
> On Fri, Nov 15, 2024 at 02:51:16PM +0100, Lorenzo Pieralisi wrote:
> > On Thu, Nov 07, 2024 at 03:38:27PM -0800, Elliot Berman wrote:
> > > SoC vendors have different types of resets and are controlled through
> > > various registers. For instance, Qualcomm chipsets can reboot to a
> > > "download mode" that allows a RAM dump to be collected. Another example
> > > is they also support writing a cookie that can be read by bootloader
> > > during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
> > > vendor reset types to be implemented without requiring drivers for every
> > > register/cookie.
> > > 
> > > Add support in PSCI to statically map reboot mode commands from
> > > userspace to a vendor reset and cookie value using the device tree.
> > > 
> > > A separate initcall is needed to parse the devicetree, instead of using
> > > psci_dt_init because mm isn't sufficiently set up to allocate memory.
> > 
> > Nit: information below this point is more a cover letter than for the
> > commit log.
> > 
> > > Reboot mode framework is close but doesn't quite fit with the
> > > design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
> > > be solved but doesn't seem reasonable in sum:
> > >  1. reboot mode registers against the reboot_notifier_list, which is too
> > >     early to call SYSTEM_RESET2. PSCI would need to remember the reset
> > >     type from the reboot-mode framework callback and use it
> > >     psci_sys_reset.
> > >  2. reboot mode assumes only one cookie/parameter is described in the
> > >     device tree. SYSTEM_RESET2 uses 2: one for the type and one for
> > >     cookie.
> > >  3. psci cpuidle driver already registers a driver against the
> > >     arm,psci-1.0 compatible. Refactoring would be needed to have both a
> > >     cpuidle and reboot-mode driver.
> > > 
> > > Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > > ---
> > >  drivers/firmware/psci/psci.c | 104 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 104 insertions(+)
> > > 
> > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > index 2328ca58bba61fdb677ac20a1a7447882cd0cf22..e60e3f8749c5a6732c51d23a2c1f453361132d9a 100644
> > > --- a/drivers/firmware/psci/psci.c
> > > +++ b/drivers/firmware/psci/psci.c
> > > @@ -79,6 +79,14 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
> > >  static u32 psci_cpu_suspend_feature;
> > >  static bool psci_system_reset2_supported;
> > >  
> > > +struct psci_reset_param {
> > > +	const char *mode;
> > > +	u32 reset_type;
> > > +	u32 cookie;
> > > +};
> > > +static struct psci_reset_param *psci_reset_params __ro_after_init;
> > > +static size_t num_psci_reset_params __ro_after_init;
> > > +
> > >  static inline bool psci_has_ext_power_state(void)
> > >  {
> > >  	return psci_cpu_suspend_feature &
> > > @@ -305,9 +313,38 @@ static int get_set_conduit_method(const struct device_node *np)
> > >  	return 0;
> > >  }
> > >  
> > > +static void psci_vendor_system_reset2(const char *cmd)
> > > +{
> > > +	unsigned long ret;
> > > +	size_t i;
> > > +
> > > +	for (i = 0; i < num_psci_reset_params; i++) {
> > > +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > > +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > > +					     psci_reset_params[i].reset_type,
> > > +					     psci_reset_params[i].cookie, 0);
> > > +			/*
> > > +			 * if vendor reset fails, log it and fall back to
> > > +			 * architecture reset types
> > > +			 */
> > > +			pr_err("failed to perform reset \"%s\": %ld\n", cmd,
> > > +			       (long)ret);
> > > +			return;
> > > +		}
> > > +	}
> > > +}
> > > +
> > >  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> > >  			  void *data)
> > >  {
> > > +	/*
> > > +	 * try to do the vendor system_reset2
> > > +	 * If the reset fails or there wasn't a match on the command,
> > > +	 * fall back to architectural resets
> > > +	 */
> > > +	if (data && num_psci_reset_params)
> > > +		psci_vendor_system_reset2(data);
> > > +
> > >  	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> > >  	    psci_system_reset2_supported) {
> > 
> > This is a mess. To issue architectural warm reset we check reboot_mode,
> > for vendor resets we ignore it - there is no rationale, that's the point
> > I am making.
> 
> If I expand the comment to:
> 
> 
>  * try todo the vendor system_reset2
>  * If the reset fails or there wasn't a match on the command,
>  * fall back to architectural resets.
>  * Ignore reboot_mode enum to behave like setting a cookie, which don't
>  * care about the reboot_mode.

/*
 * Check if the system supports vendor resets and issue
 * SYSTEM_RESET2 if the reboot command matches a vendor reset.
 * Ignore reboot_mode and execute SYSTEM_RESET2 with type and
 * cookie as defined by the firmware bindings.
 *
 * If the reset fails or there is not a match for the command
 * fall back to architectural resets; reset type detection in
 * this case will be done using reboot_mode.
 */

?

> Help to address this concern?

Not entirely, sorry, I will get back to this.

> > Also see my question on the other thread re: user space and reset
> > "modes".
> > 
> > I appreciate we are not making progress but I don't want to pick up
> > the pieces later after merging this code - it is unclear to me what's
> > the best path forward - I would like to understand how other
> > platforms/arches behave in this respect.
> > 
> 
> I went through the couple hundred drivers which register reboot and
> restart handlers. The majority don't care about reboot command nor
> reboot_mode enum. The few that do:
> 
> Two drivers which I could find which care about the reboot command don't
> look at the reboot_mode argument.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/efibc.c?h=v6.11#n35
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/reset/reboot-mode.c?h=v6.11#n42
> 
> One driver looks at the reboot command overrides the reboot_mode
> argument:
> 
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/watchdog/pnx4008_wdt.c?h=v6.11#n125

Thanks for doing that, that helps.

> I wasn't able to find any platform/arches which check the reboot_mode
> before reading the reboot command.
> 
> > >  		/*
> > > @@ -750,6 +787,73 @@ static const struct of_device_id psci_of_match[] __initconst = {
> > >  	{},
> > >  };
> > >  
> > > +#define REBOOT_PREFIX "mode-"
> > > +
> > > +static int __init psci_init_system_reset2_modes(void)
> > > +{
> > > +	const size_t len = strlen(REBOOT_PREFIX);
> > > +	struct psci_reset_param *param;
> > > +	struct device_node *psci_np __free(device_node) = NULL;
> > > +	struct device_node *np __free(device_node) = NULL;
> > > +	struct property *prop;
> > > +	size_t count = 0;
> > > +	u32 magic[2];
> > > +	int num;
> > > +
> > > +	if (!psci_system_reset2_supported)
> > > +		return 0;
> > > +
> > > +	psci_np = of_find_matching_node(NULL, psci_of_match);
> > > +	if (!psci_np)
> > > +		return 0;
> > > +
> > > +	np = of_find_node_by_name(psci_np, "reset-types");
> > > +	if (!np)
> > > +		return 0;
> > > +
> > > +	for_each_property_of_node(np, prop) {
> > > +		if (strncmp(prop->name, REBOOT_PREFIX, len))
> > > +			continue;
> > > +		num = of_property_count_u32_elems(np, prop->name);
> > > +		if (num != 1 && num != 2)
> > > +			continue;
> > > +
> > > +		count++;
> > > +	}
> > > +
> > > +	param = psci_reset_params =
> > > +		kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
> > > +	if (!psci_reset_params)
> > > +		return -ENOMEM;
> > > +
> > > +	for_each_property_of_node(np, prop) {
> > > +		if (strncmp(prop->name, REBOOT_PREFIX, len))
> > > +			continue;
> > > +
> > > +		param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> > 
> > FWIW - I think you need to keep the logic in the previous loop into account
> > because that's what is used to allocate param, it is not a given that
> > param is valid at this stage if I am not mistaken - the previous loop
> > checked:
> > 
> > 	num = of_property_count_u32_elems(np, prop->name);
> > 	if (num != 1 && num != 2)
> > 		continue;
> 
> of_property_read_variable_u32_array() performs effectively the same
> check.  It returns -EOVERFLOW if it couldn't find enough (== 0) or too
> many values (>2). I currently have the added bonus of complaining in
> dmesg about the bad reboot mode property, instead of silently ignoring.

Right but we are dereferencing param (param->mode) before carrying out that
check.

Thanks,
Lorenzo

> 
> - Elliot
> 
> > > +		if (!param->mode)
> > > +			continue;
> > > +
> > > +		num = of_property_read_variable_u32_array(np, prop->name, magic,
> > > +							  1, ARRAY_SIZE(magic));
> > > +		if (num < 0) {
> > > +			pr_warn("Failed to parse vendor reboot mode %s\n",
> > > +				param->mode);
> > > +			kfree_const(param->mode);
> > > +			continue;
> > > +		}
> > > +
> > > +		/* Force reset type to be in vendor space */
> > > +		param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
> > > +		param->cookie = num > 1 ? magic[1] : 0;
> > > +		param++;
> > > +		num_psci_reset_params++;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +arch_initcall(psci_init_system_reset2_modes);
> > > +
> > >  int __init psci_dt_init(void)
> > >  {
> > >  	struct device_node *np;
> > > 
> > > -- 
> > > 2.34.1
> > > 

