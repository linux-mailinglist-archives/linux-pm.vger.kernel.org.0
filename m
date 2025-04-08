Return-Path: <linux-pm+bounces-24947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF5FA80FB7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BC83A6173
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638522ACD6;
	Tue,  8 Apr 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X92gh4Mb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D61228375;
	Tue,  8 Apr 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125423; cv=none; b=vGJOOnuOvZgdHamOX1Q3PSIubGfGQ6zh9j3uf/7oN7ZWWXzzztnwOnSoPCWqLqwV9g/ar4+Plemp07lLp0nQfkPreKcWrjhtwDoYvlYnUbgOJONza8auh5Yap90XV/rcfQTJ/gFXM+oVsqIkoRCcix7tCRZb4C2A19PG/JyC85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125423; c=relaxed/simple;
	bh=YBHV1R1LANqwOlZ3bpGukqGWjvNFHr67D3rL1PJ5cBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u70KtKiep2jDdsk14fRKAcBW8xd9Hz933VtHeehWBTV30ryMrXUSemq/06B6M1qJJdjfKSRQ92pNMPigPpmSTvwvsqdkoFm0dspQYpmExe4BXh3/+Swl+0Tv9BdzFR/PvqNyeuTU24XW+QZ78XVmLx3XCdoAn3KoZW6RSS9HqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X92gh4Mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D62C4CEE5;
	Tue,  8 Apr 2025 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125422;
	bh=YBHV1R1LANqwOlZ3bpGukqGWjvNFHr67D3rL1PJ5cBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X92gh4MbpheXmMlisobrsJH9pTK+vbMHIiGSscsBOd56YoWUZGvQ9GHj7I9cJe6h+
	 5dRHXUfyB/dxqlFo5efWZ5yeva/1Aye54sPNLiKAx3IKWSUHvzQvwQK9j124PuMPO1
	 Y35Yap4gT60rXG6sxYh1je5jWv5XHC2V0k8g9rvvbg5T87FCunh5tk/suoXaa7r8gb
	 pMwBuEX3Lo7OopzWgRIar0Stmwj/J1rMPvIyQ5cKlGybubscMOgKlJHBDaRyeD8mCW
	 7ZjoCSUkXBiR50nZuTt8sUNYrBzIKvTY4X1U61ituZEnCC5LTi3UZCuapNVgKZV5pc
	 cvcAxj3fXp2Ng==
Date: Tue, 8 Apr 2025 17:16:52 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <Z/U95G+2GsoLD6Mi@lpieralisi>
References: <20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com>
 <20250303-arm-psci-system_reset2-vendor-reboots-v9-2-b2cf4a20feda@oss.qualcomm.com>
 <Z9QQw6BcE7IXzu+r@lpieralisi>
 <Z+K3uNjTNbq3pUis@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+K3uNjTNbq3pUis@hu-mojha-hyd.qualcomm.com>

On Tue, Mar 25, 2025 at 07:33:36PM +0530, Mukesh Ojha wrote:
> On Fri, Mar 14, 2025 at 12:19:31PM +0100, Lorenzo Pieralisi wrote:
> > On Mon, Mar 03, 2025 at 01:08:31PM -0800, Elliot Berman wrote:
> > > From: Elliot Berman <elliot.berman@oss.qualcomm.com>
> > > 
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
> > 
> > I have managed to discuss a little bit this patchset over the last
> > few days and I think we have defined a plan going forward.
> > 
> > A point that was raised is:
> > 
> > https://man7.org/linux/man-pages/man2/reboot.2.html
> > 
> > LINUX_REBOOT_CMD_RESTART2 *arg command, what is it supposed to
> > represent ?
> > 
> > Is it the mode the system should reboot into OR it is the
> > actual command to be issued (which is what this patchset
> > implements) ?
> > 
> > LINUX_REBOOT_CMD_RESTART "..a default restart..."
> > 
> > It is unclear what "default" means. We wonder whether the
> > reboot_mode variable was introduced to _define_ that "default".
> > 
> > So, in short, my aim is trying to decouple reboot_mode from the
> > LINUX_REBOOT_CMD_RESTART2 *arg command.
> > 
> > I believe that adding a sysfs interface to reboot-mode driver
> > infrastructure would be useful, so that the commands would
> > be exposed to userspace and userspace can set the *arg command
> > specifically to issue a given reset/mode.
> > 
> > I wonder why this is not already in place for eg syscon-reboot-mode
> > resets, how does user space issue a command in those systems if the
> > available commands aren't exposed to userspace ?
> > 
> > Is there a kernel entity exposing those "modes" to userspace, somehow ?
> > 
> > > A separate initcall is needed to parse the devicetree, instead of using
> > > psci_dt_init because mm isn't sufficiently set up to allocate memory.
> > > 
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
> > 
> > This can be changed and I think it should, so that the reboot modes
> > are exposed to user space and PSCI can use that.
> > 
> In the case of a regular reboot or panic, the reboot/panic notifiers run
> first, followed by the restart notifiers. The PSCI reset/reset2 should
> be the last call from Linux, and ideally, this call should not fail.
> 
> Reboot mode notifiers => restart notifiers or Panic notifiers => restart
> notifiers
> 
> So, if I understand correctly, you mean that we can change the reboot
> mode framework to expose the arguments available to user space. We can
> extend it to accept magic and cookies, save them in the reboot
> framework, and retrieve them via a call from PSCI during a regular
> reboot or panic based on the current arguments. Is this leading towards
> writing an ARM-specific PSCI-reboot-mode driver, which in its reboot
> notifier callback saves the magic and cookies, and these magic and
> cookies will be used during psci_sys_reset2()? Or is there something
> wrong with my understanding?

No, you got it right (apologies for the delay in replying) - if the
case for making reboot mode available to user space is accepted.

> P.S. We appreciate Elliot for his work and follow-up on this while being
> employed at Qualcomm.

Yes I sincerely do for his patience, thank you.

Lorenzo

> > >  3. psci cpuidle driver already registers a driver against the
> > >     arm,psci-1.0 compatible. Refactoring would be needed to have both a
> > >     cpuidle and reboot-mode driver.
> > > 
> > > Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
> > > ---
> > >  drivers/firmware/psci/psci.c | 105 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 105 insertions(+)
> > > 
> > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > index a1ebbe9b73b136218e9d9f9b8daa7756b3ab2fbe..6f8c47deaec0225f26704e1f3bcad52603127a85 100644
> > > --- a/drivers/firmware/psci/psci.c
> > > +++ b/drivers/firmware/psci/psci.c
> > > @@ -80,6 +80,14 @@ static u32 psci_cpu_suspend_feature;
> > >  static bool psci_system_reset2_supported;
> > >  static bool psci_system_off2_hibernate_supported;
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
> > > @@ -306,9 +314,39 @@ static int get_set_conduit_method(const struct device_node *np)
> > >  	return 0;
> > >  }
> > >  
> > > +static int psci_vendor_system_reset2(const char *cmd)
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
> > 
> > That's not what the code does.
> > 
> Ack.
> 
> -Mukesh
> 
> > > +			 */
> > > +			pr_err("failed to perform reset \"%s\": %ld\n", cmd,
> > > +			       (long)ret);
> > > +			return 0;
> > > +		}
> > > +	}
> > > +
> > > +	return -ENOENT;
> > > +}
> > > +
> > >  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> > >  			  void *data)
> > >  {
> > > +	/*
> > > +	 * try to do the vendor system_reset2
> > > +	 * If there wasn't a matching command, fall back to architectural resets
> > > +	 */
> > > +	if (data && !psci_vendor_system_reset2(data))
> > > +		return NOTIFY_DONE;
> > > +
> > >  	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> > >  	    psci_system_reset2_supported) {
> > >  		/*
> > > @@ -795,6 +833,73 @@ static const struct of_device_id psci_of_match[] __initconst = {
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
> > 
> > Related to my initial question above. If LINUX_REBOOT_CMD_RESTART2 *arg command,
> > is the actual reset to be issued, should we add a default mode "cold"
> > and, if SYSTEM_RESET2 is supported, a "warm" reset mode too ?
> > 
> > It all boils down to what *arg represents - adding "cold" and "warm"
> > modes would remove the dependency on reboot_mode for resets issued
> > through LINUX_REBOOT_CMD_RESTART2, the question is whether this
> > is the correct thing to do.
> > 
> > Comments very welcome.
> > 
> > Thanks,
> > Lorenzo
> > 
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
> > > +		num = of_property_read_variable_u32_array(np, prop->name, magic,
> > > +							  1, ARRAY_SIZE(magic));
> > > +		if (num < 0) {
> > > +			pr_warn("Failed to parse vendor reboot mode %s\n",
> > > +				param->mode);
> > > +			kfree_const(param->mode);
> > > +			continue;
> > > +		}
> > > +
> > > +		param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> > > +		if (!param->mode)
> > > +			continue;
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

