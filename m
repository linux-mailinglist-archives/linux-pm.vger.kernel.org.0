Return-Path: <linux-pm+bounces-25468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32205A89DF2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 14:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA6C3BFB82
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3628E3F;
	Tue, 15 Apr 2025 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="csSa2P4q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1618DF8D;
	Tue, 15 Apr 2025 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719697; cv=none; b=lqy49FbPMuYGvxp8Cfe7K9iOmbCGGNLZlMBPZlHx1Vl53UMOti216tjCgGGkgeN8/bvTddlXRt8+6ADYmCUuKm8CS6xTg12Yz9/VMmfs3BgPyNQomknDqHMvpup5WGgOaQ5BJhsH1lV8Pk7VojiGDBZYfeYyx4f39dPbUGkjx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719697; c=relaxed/simple;
	bh=G3XB6UzV4Lp7TDvalgUjF5IBx2asgbZze4/GQq/rx2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psk0epAIaj4wjsSVZG0TGhFm4//K/a6N/jZF6mY/8lR/CtP4ubIQoLI+4+KYvolqrUNW0C2wvToQXYIV3cEBMw68ceMxZjgp78+U3zzWsjkL82ze8ovV3/8Z5Vq83HGVv5RXqfVeIseC2k2ax7KvlulY/ov+AwyMFP5cqkW7cIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=csSa2P4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53770C4CEE5;
	Tue, 15 Apr 2025 12:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744719697;
	bh=G3XB6UzV4Lp7TDvalgUjF5IBx2asgbZze4/GQq/rx2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csSa2P4qCSf7BymqLXMDqrEtTT4mXJtk446y/cNdv8bF2Wj+ARbhPGZFABQexVVKE
	 dT9uDIaxt71NgBlOyC+l76Vpk0+bTOal+wNRiI18hNZBjDdG7EaUVRn4dXHpKnM+gf
	 ckhsX/grAd9u0g+AhtgWyGNWLUSiB+FON0ZFAejA=
Date: Tue, 15 Apr 2025 14:21:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/8] cpuidle: psci: Transition to the faux device
 interface
Message-ID: <2025041515-duplex-recant-7235@gregkh>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-2-e6cc73f78478@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-plat2faux_dev-v2-2-e6cc73f78478@arm.com>

On Tue, Mar 18, 2025 at 05:01:40PM +0000, Sudeep Holla wrote:
> The PSCI cpuidle driver does not require the creation of a platform
> device. Originally, this approach was chosen for simplicity when the
> driver was first implemented.
> 
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the driver to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will simplify the code, reducing its footprint
> while maintaining functionality.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 32 ++++----------------------------
>  1 file changed, 4 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 2562dc001fc1de69732ef28f383d2809262a3d96..5d4d6daed36d8540ba2ce3dc54a3180731b03d22 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -16,7 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/platform_device.h>
> +#include <linux/device/faux.h>
>  #include <linux/psci.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -404,14 +404,14 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
>   * to register cpuidle driver then rollback to cancel all CPUs
>   * registration.
>   */
> -static int psci_cpuidle_probe(struct platform_device *pdev)
> +static int psci_cpuidle_probe(struct faux_device *fdev)
>  {
>  	int cpu, ret;
>  	struct cpuidle_driver *drv;
>  	struct cpuidle_device *dev;
>  
>  	for_each_possible_cpu(cpu) {
> -		ret = psci_idle_init_cpu(&pdev->dev, cpu);
> +		ret = psci_idle_init_cpu(&fdev->dev, cpu);
>  		if (ret)
>  			goto out_fail;
>  	}
> @@ -431,28 +431,4 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static struct platform_driver psci_cpuidle_driver = {
> -	.probe = psci_cpuidle_probe,
> -	.driver = {
> -		.name = "psci-cpuidle",
> -	},
> -};
> -
> -static int __init psci_idle_init(void)
> -{
> -	struct platform_device *pdev;
> -	int ret;
> -
> -	ret = platform_driver_register(&psci_cpuidle_driver);
> -	if (ret)
> -		return ret;
> -
> -	pdev = platform_device_register_simple("psci-cpuidle", -1, NULL, 0);
> -	if (IS_ERR(pdev)) {
> -		platform_driver_unregister(&psci_cpuidle_driver);
> -		return PTR_ERR(pdev);
> -	}
> -
> -	return 0;
> -}
> -device_initcall(psci_idle_init);
> +module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, true);

See, what does "true" mean here?

Why would you ever want "false"?

thanks,

greg k-h

