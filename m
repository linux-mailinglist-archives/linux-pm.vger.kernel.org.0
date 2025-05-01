Return-Path: <linux-pm+bounces-26507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BACAA6130
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 18:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9454667E7
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B883A2036ED;
	Thu,  1 May 2025 16:07:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8118C011;
	Thu,  1 May 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115647; cv=none; b=AizVDyn2Csi64RzE37zhy6oSVAW0GeGuRfZFpXEFpt3HNbK0BV0vGca0zFfyHnFO4wge4ckkqnGult/sdWF2ATtF1jfZ2ChUEW9N430tG1NHUvZDO6kViNfoLp9i7vJ9wsRC88bJWEP51WqlAGEevnB34tH6kx1SMluYAfclBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115647; c=relaxed/simple;
	bh=2tVqBdPxBFJ0mtEhuB7K8OSbHOc9c5zYbTK8Vxk9Wu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Het2VsSHhU/DhnFHOL+l52tuqvGzBNAygguMkrcFTme8ghh4NQH3boj/fMZR8k4Bcv68KApkoF+vpCdNEC3W1rLGE1xalE8lIOtepDRNrdABm8ExQDbhztf9zsXfJdalKV/NbdMiV8rMNF3LAeKrDjmNDLYPYJ9KaIKPrGGzUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7B46168F;
	Thu,  1 May 2025 09:07:17 -0700 (PDT)
Received: from bogus (unknown [10.57.47.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF2833F673;
	Thu,  1 May 2025 09:07:23 -0700 (PDT)
Date: Thu, 1 May 2025 17:07:20 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] cpuidle: psci: Transition to the faux device
 interface
Message-ID: <20250501-pony-of-undeniable-reverence-f34cb7@sudeepholla>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-2-e6cc73f78478@arm.com>
 <cf4e70e4-9fe5-4697-8744-8c12c41b5ff9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4e70e4-9fe5-4697-8744-8c12c41b5ff9@nvidia.com>

On Thu, May 01, 2025 at 02:01:19PM +0100, Jon Hunter wrote:
> Hi Sudeep,
> 
> On 18/03/2025 17:01, Sudeep Holla wrote:
> > The PSCI cpuidle driver does not require the creation of a platform
> > device. Originally, this approach was chosen for simplicity when the
> > driver was first implemented.
> > 
> > With the introduction of the lightweight faux device interface, we now
> > have a more appropriate alternative. Migrate the driver to utilize the
> > faux bus, given that the platform device it previously created was not
> > a real one anyway. This will simplify the code, reducing its footprint
> > while maintaining functionality.
> > 
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   drivers/cpuidle/cpuidle-psci.c | 32 ++++----------------------------
> >   1 file changed, 4 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 2562dc001fc1de69732ef28f383d2809262a3d96..5d4d6daed36d8540ba2ce3dc54a3180731b03d22 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -16,7 +16,7 @@
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/of.h>
> > -#include <linux/platform_device.h>
> > +#include <linux/device/faux.h>
> >   #include <linux/psci.h>
> >   #include <linux/pm_domain.h>
> >   #include <linux/pm_runtime.h>
> > @@ -404,14 +404,14 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
> >    * to register cpuidle driver then rollback to cancel all CPUs
> >    * registration.
> >    */
> > -static int psci_cpuidle_probe(struct platform_device *pdev)
> > +static int psci_cpuidle_probe(struct faux_device *fdev)
> >   {
> >   	int cpu, ret;
> >   	struct cpuidle_driver *drv;
> >   	struct cpuidle_device *dev;
> >   	for_each_possible_cpu(cpu) {
> > -		ret = psci_idle_init_cpu(&pdev->dev, cpu);
> > +		ret = psci_idle_init_cpu(&fdev->dev, cpu);
> >   		if (ret)
> >   			goto out_fail;
> >   	}
> > @@ -431,28 +431,4 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
> >   	return ret;
> >   }
> > -static struct platform_driver psci_cpuidle_driver = {
> > -	.probe = psci_cpuidle_probe,
> > -	.driver = {
> > -		.name = "psci-cpuidle",
> > -	},
> > -};
> > -
> > -static int __init psci_idle_init(void)
> > -{
> > -	struct platform_device *pdev;
> > -	int ret;
> > -
> > -	ret = platform_driver_register(&psci_cpuidle_driver);
> > -	if (ret)
> > -		return ret;
> > -
> > -	pdev = platform_device_register_simple("psci-cpuidle", -1, NULL, 0);
> > -	if (IS_ERR(pdev)) {
> > -		platform_driver_unregister(&psci_cpuidle_driver);
> > -		return PTR_ERR(pdev);
> > -	}
> > -
> > -	return 0;
> > -}
> > -device_initcall(psci_idle_init);
> > +module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);
> > 
> 
> 
> I have noticed the following error messages on some of our Tegra devices ...
> 
>  ERR KERN faux psci-cpuidle: probe did not succeed, tearing down the device
>  ERR KERN CPUidle PSCI: Failed to create psci-cpuidle device
> 
> I had a quick look at this and this occurs because of the following code in
> the probe cpuidle-psci driver ...
> 
>         /*
>          * If no DT idle states are detected (ret == 0) let the driver
>          * initialization fail accordingly since there is no reason to
>          * initialize the idle driver if only wfi is supported, the
>          * default archictectural back-end already executes wfi
>          * on idle entry.
>          */
>         ret = dt_init_idle_driver(drv, psci_idle_state_match, 1);
>         if (ret <= 0)
>                 return ret ? : -ENODEV;
> 
> 
> So although it could be argued that the error message is valid, I am not
> sure if there is anything that mandates that we need to have the idle-states
> present.
> 
> We are always checking for new kernel errors and so if something new occurs,
> I am trying to figure out what is the correct way to fix. For this case I am
> not sure what is best.
> 

This is another case where probe was failing before too just that faux
device probe throws the error. I will take a look and see what can be done.
But yes, we shouldn't throw error if no idle-states are present in the DT.

-- 
Regards,
Sudeep

