Return-Path: <linux-pm+bounces-17624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5843D9CE026
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF07D1F21905
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5441C6889;
	Fri, 15 Nov 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihMrMQse"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F11AC43E;
	Fri, 15 Nov 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677762; cv=none; b=hbPn0Ds32h/YgkQPPw1It1h1oozyz8GpR68QPWqLi2ndLjdNQqhGKWkQpybv8Pb8kmKuWnf2+IQAqLw00qavSnxn5ZBVWmQIyfAljwpau/ds4IhNaW8VuLIdylbkLECdlcW47dBYW5zvmtgCLbpViEOZVf+fCuLy2xHl9hvBVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677762; c=relaxed/simple;
	bh=AO9xLnbPqrNc6QxB+RS5a+ltPUCHQ2swdaCjyUpk4wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REfm/1JFQNbrOIy0HkhDYtpo8lCzVW9QtddIexRam9GCzwHqVQIvY/aMQRmOhTOLDnoKmkj1r8Q7XE2Yr9Nj/nfy5062i7qiVT9fvfmRKp47j0Fkb3tsgGesfXVaeHPn1xLgWoCInMicGUZH0O2lo2umvm/nvV8qkd+4tNwnPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihMrMQse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99968C4CECF;
	Fri, 15 Nov 2024 13:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731677762;
	bh=AO9xLnbPqrNc6QxB+RS5a+ltPUCHQ2swdaCjyUpk4wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihMrMQsewJGf3fyd3nlj3JxP3tSQ4LnK2kgn3BN0eJzom0hdGJ6rjAK8YzNknop2o
	 Loy9rOWAMzK2wgZYyDQftVkiBpE6qHthohXsA3wNHAfLpfVbuZm9Okvqe3R3+SSxeu
	 utZD3w8CDTNJ4hf4WPFir8h8wBBvcfLu7jKEkS6XI6g2VcixMKOysYpG4ApLl2+UNJ
	 c1TCbFe4izxfsz5re3g+DQcVASROO9DwmzJ3gFaDycj9PaZIae8gYkupbsxULSUqrq
	 YsekWgxpkSxWR1hQZop/s3vbnaz3OeG/GiOlLme6Xf1dJ95hDNFZRNADqyF336AGtc
	 d5tzg18ROdG/Q==
Date: Fri, 15 Nov 2024 14:35:52 +0100
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
Message-ID: <ZzdOOP0KuMMdo64W@lpieralisi>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
 <20241018-arm-psci-system_reset2-vendor-reboots-v6-3-50cbe88b0a24@quicinc.com>
 <CAE-0n515sUkmTWptgY8pOaMDBPfDp5pZBy9Nby+4cMdMAnAZfA@mail.gmail.com>
 <20241023092251529-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023092251529-0700.eberman@hu-eberman-lv.qualcomm.com>

On Wed, Oct 23, 2024 at 09:30:21AM -0700, Elliot Berman wrote:
> On Fri, Oct 18, 2024 at 10:42:46PM -0700, Stephen Boyd wrote:
> > Quoting Elliot Berman (2024-10-18 12:39:48)
> > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > index 2328ca58bba6..60bc285622ce 100644
> > > --- a/drivers/firmware/psci/psci.c
> > > +++ b/drivers/firmware/psci/psci.c
> > > @@ -29,6 +29,8 @@
> > >  #include <asm/smp_plat.h>
> > >  #include <asm/suspend.h>
> > >
> > > +#define REBOOT_PREFIX "mode-"
> > 
> > Maybe move this near the function that uses it.
> > 
> > > +
> > >  /*
> > >   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> > >   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> > > @@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
> > >         return 0;
> > >  }
> > >
> > > +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> > > +{
> > > +       const char *cmd = data;
> > > +       unsigned long ret;
> > > +       size_t i;
> > > +
> > > +       for (i = 0; i < num_psci_reset_params; i++) {
> > > +               if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > > +                       ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > > +                                            psci_reset_params[i].reset_type,
> > > +                                            psci_reset_params[i].cookie, 0);
> > > +                       pr_err("failed to perform reset \"%s\": %ld\n",
> > > +                               cmd, (long)ret);
> > 
> > Do this intentionally return? Should it be some other function that's
> > __noreturn instead and a while (1) if the firmware returns back to the
> > kernel?
> > 
> 
> Yes, I think it's best to make sure we fall back to the architectural
> reset (whether it's the SYSTEM_RESET or architectural SYSTEM_RESET2)
> since device would reboot then.

Well, that's one of the doubts I have about enabling this code. From
userspace we are requesting a reboot (I don't even think that user
space knows which reboot modes are actually implemented (?)) and we may
end up issuing one with completely different semantics ?

Are these "reset types" exported to user space ?

Lorenzo

> > > +               }
> > > +       }
> > > +}
> > > +
> > >  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> > >                           void *data)
> > >  {
> > > +       if (data && num_psci_reset_params)
> > > +               psci_vendor_sys_reset2(action, data);
> > > +
> > >         if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> > >             psci_system_reset2_supported) {
> > >                 /*
> > > @@ -750,6 +780,68 @@ static const struct of_device_id psci_of_match[] __initconst = {
> > >         {},
> > >  };
> > >
> > > +static int __init psci_init_system_reset2_modes(void)
> > > +{
> > > +       const size_t len = strlen(REBOOT_PREFIX);
> > > +       struct psci_reset_param *param;
> > > +       struct device_node *psci_np __free(device_node) = NULL;
> > > +       struct device_node *np __free(device_node) = NULL;
> > > +       struct property *prop;
> > > +       size_t count = 0;
> > > +       u32 magic[2];
> > > +       int num;
> > > +
> > > +       if (!psci_system_reset2_supported)
> > > +               return 0;
> > > +
> > > +       psci_np = of_find_matching_node(NULL, psci_of_match);
> > > +       if (!psci_np)
> > > +               return 0;
> > > +
> > > +       np = of_find_node_by_name(psci_np, "reset-types");
> > > +       if (!np)
> > > +               return 0;
> > > +
> > > +       for_each_property_of_node(np, prop) {
> > > +               if (strncmp(prop->name, REBOOT_PREFIX, len))
> > > +                       continue;
> > > +               num = of_property_count_elems_of_size(np, prop->name, sizeof(magic[0]));
> > 
> > Use of_property_count_u32_elems()?
> > 
> > > +               if (num != 1 && num != 2)
> > > +                       continue;
> > > +
> > > +               count++;
> > > +       }
> > > +
> > > +       param = psci_reset_params = kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
> > > +       if (!psci_reset_params)
> > > +               return -ENOMEM;
> > > +
> > > +       for_each_property_of_node(np, prop) {
> > > +               if (strncmp(prop->name, REBOOT_PREFIX, len))
> > > +                       continue;
> > > +
> > > +               param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> > > +               if (!param->mode)
> > > +                       continue;
> > > +
> > > +               num = of_property_read_variable_u32_array(np, prop->name, magic, 1, 2);
> > 
> > ARRAY_SIZE(magic)?
> > 
> > > +               if (num < 0) {
> > 
> > Should this be less than 1?
> > 
> 
> of_property_read_variable_u32_array should return -EOVERFLOW (or maybe
> -ENODATA) if the array is empty. I don't see it's possible for
> of_property_read_variable_u32_array() to return a non-negative value
> that's not 1 or 2.
> 
> > > +                       pr_warn("Failed to parse vendor reboot mode %s\n", param->mode);
> > > +                       kfree_const(param->mode);
> > > +                       continue;
> > > +               }
> > > +
> > > +               /* Force reset type to be in vendor space */
> > > +               param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
> > > +               param->cookie = num == 2 ? magic[1] : 0;
> > 
> > ARRAY_SIZE(magic)?
> > 
> > > +               param++;
> > > +               num_psci_reset_params++;
> > > +       }
> > > +
> > > +       return 0;

