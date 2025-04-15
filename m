Return-Path: <linux-pm+bounces-25469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D4A89E42
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7757AC2FE
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145DA284679;
	Tue, 15 Apr 2025 12:35:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5B1C3C14;
	Tue, 15 Apr 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720554; cv=none; b=JL/AK1+WARgQDfwbE57LwRJPAUf8uGxOI3kvgPfxvOd2DWuY0dYjYofOn2t12wBhc6kKvc5H19R0S9rgFUhXqKxaq1eYFvpcxqekWiHkxPaaOXph5t5TG4DhJEAUaV88ybcyvUMb+wKc4ZcnWjI5X/GB1IHbS2bGjQQvq9Uk1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720554; c=relaxed/simple;
	bh=cvMdXWlyO7zZdUfihtvKjmStE03P3p/iRalM774IBBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri5cWcImEmcPxOJ1hnEMCkz+JuX3W/HjiVeI8v1kzVm7QrHvGQcIoFSp4Zv6NH2DVSfqT0/xtoanX84s5HwziAUus9Uy7fnDN3vMSfSIOLNHUfubk+i0gnARMRXur17YAbgesxgkFS14gaVbqgySTiKLVWhqeJ4+IAtbM2oQPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74DEB15A1;
	Tue, 15 Apr 2025 05:35:49 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFE7C3F694;
	Tue, 15 Apr 2025 05:35:49 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:35:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/8] cpuidle: psci: Transition to the faux device
 interface
Message-ID: <20250415-vigorous-platypus-of-management-c2ddaf@sudeepholla>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-2-e6cc73f78478@arm.com>
 <2025041515-duplex-recant-7235@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025041515-duplex-recant-7235@gregkh>

On Tue, Apr 15, 2025 at 02:21:33PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Mar 18, 2025 at 05:01:40PM +0000, Sudeep Holla wrote:
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
> >  drivers/cpuidle/cpuidle-psci.c | 32 ++++----------------------------
> >  1 file changed, 4 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 2562dc001fc1de69732ef28f383d2809262a3d96..5d4d6daed36d8540ba2ce3dc54a3180731b03d22 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > -#include <linux/platform_device.h>
> > +#include <linux/device/faux.h>
> >  #include <linux/psci.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > @@ -404,14 +404,14 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
> >   * to register cpuidle driver then rollback to cancel all CPUs
> >   * registration.
> >   */
> > -static int psci_cpuidle_probe(struct platform_device *pdev)
> > +static int psci_cpuidle_probe(struct faux_device *fdev)
> >  {
> >  	int cpu, ret;
> >  	struct cpuidle_driver *drv;
> >  	struct cpuidle_device *dev;
> >  
> >  	for_each_possible_cpu(cpu) {
> > -		ret = psci_idle_init_cpu(&pdev->dev, cpu);
> > +		ret = psci_idle_init_cpu(&fdev->dev, cpu);
> >  		if (ret)
> >  			goto out_fail;
> >  	}
> > @@ -431,28 +431,4 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
> >  	return ret;
> >  }
> >  
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
> 
> See, what does "true" mean here?
> 
> Why would you ever want "false"?
> 

There were few efi platform devices that were created conditionally and
the idea with this true/false was to pass that condition. I agree it was
not clean. Anyways since efi platform devices can't be moved to faux
devices, this flag becomes useless as it is most true for all other users.

Also as mention in the other thread, the need for macro also become very
weak as efi devices can't be moved into faux.

So all the patches in v1 except efi and trng are now queued via respective
trees using faux device apis directly without this weird macro 😄.

-- 
Regards,
Sudeep

