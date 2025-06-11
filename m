Return-Path: <linux-pm+bounces-28494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AECDAD5A8B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 17:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7F016B7E0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58481AE875;
	Wed, 11 Jun 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5LbLylM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4D189B91;
	Wed, 11 Jun 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655951; cv=none; b=RdF6jYkrQZBF8pcdyhlyMRlBAnpIP47SeVl9iEAH5RFs1Id8P0gXvmH7SMc8XPk5goGwhLpu7/b7aKwJH7qXn/V6Bug0Mz50OR2AcNQoSf3qGAFW5sKf1825piN2sz9JpMQ6478VwEp8PZs6pWtGo0SaIfPx7aXR/fQZfurUVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655951; c=relaxed/simple;
	bh=wyORKykEhxu3HxEky3H3KWL4Pst5ul6jgrJKEYkWToc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvriNakI1jlmt3euV6pvUZwIQ/ZlNgKfW46hS16bowuiYfW2k0ae6b2u3oQ5b/ytiqFg0t7iQ/aqtjLEBJPWh7B73lwrr9xIpqyMZiPXb4gbFuHB+ikO8834EcdAVxwt4Td/ci0AHvx/Fxm18hIqbwQivbLACubOWJPqsN7OCTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5LbLylM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFB5C4CEE3;
	Wed, 11 Jun 2025 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749655951;
	bh=wyORKykEhxu3HxEky3H3KWL4Pst5ul6jgrJKEYkWToc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5LbLylMgDrTABeXSsL1rJM23sHGOq3I5MDpYQxZ8jHqLpLEQUzoa3U3krtosfpZ5
	 ilyC7zaB/DhuLToP6mlcsk0vmnNSEfzpT0FkSIEoVfO9ZZ8RlO7D8ZYT4xdR6Hqt+t
	 I0x6yE4ErgCP07WLT4QGNb+43VHHa5WpAzfdXnuJBpI8GP9U1GMVsEhRFQkl9N1zPA
	 mPxV9bNr7nzIwksW3B4MqkxE/Bm3UH1m/uLc8HyvuSNPztqvv1mmbWZpzzgsATBXI7
	 ql8NGyvTiLFbFzZQowVVh3PwwcPBSg5mdVv718wVMY5XjijAbBgMH2fAkfVAYH7T+p
	 J4I0RF1GYqX+A==
Date: Wed, 11 Jun 2025 10:32:28 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com, 
	iuliana.prodan@oss.nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/3] pmdomain: core: introduce dev_pm_genpd_is_on
Message-ID: <iuotfsnaft3623lchzop6sbu5ox56scdr57uia56qm6ummcvzt@yisczcdzbc3b>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <20250602131906.25751-2-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602131906.25751-2-hiagofranco@gmail.com>

On Mon, Jun 02, 2025 at 10:19:03AM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> This helper function returns the current power status of a given generic
> power domain.
> 

Please correct me if I'm wrong, but this returns the momentary status of
the device's associated genpd, and as genpds can be shared among devices
wouldn't there be a risk that you think the genpd is on but then that
other device powers it off?

> As example, remoteproc/imx_rproc.c can now use this function to check
> the power status of the remote core to properly set "attached" or
> "offline" modes.

I presume this example works because there is a dedicated, single usage,
genpd for the remoteproc instance?

> 
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
> v4: New patch.
> ---
>  drivers/pmdomain/core.c   | 27 +++++++++++++++++++++++++++
>  include/linux/pm_domain.h |  6 ++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index ff5c7f2b69ce..bcb74d10960c 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -758,6 +758,33 @@ int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
>  
> +/**
> + * dev_pm_genpd_is_on - Get device's power status

Functions in kernel-doc should have () prefix

> + *
> + * @dev: Device to get the current power status
> + *
> + * This function checks whether the generic power domain is on or not by
> + * verifying if genpd_status_on equals GENPD_STATE_ON.
> + *

If my understanding is correct, I'd like a warning here saying that this
is dangerous if the underlying genpd is shared.

Regards,
Bjorn

> + * Return: 'true' if the device's power domain is on, 'false' otherwise.
> + */
> +bool dev_pm_genpd_is_on(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd;
> +	bool is_on;
> +
> +	genpd = dev_to_genpd_safe(dev);
> +	if (!genpd)
> +		return false;
> +
> +	genpd_lock(genpd);
> +	is_on = genpd_status_on(genpd);
> +	genpd_unlock(genpd);
> +
> +	return is_on;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_is_on);
> +
>  /**
>   * pm_genpd_inc_rejected() - Adjust the rejected/usage counts for an idle-state.
>   *
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 0b18160901a2..c12580b6579b 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -301,6 +301,7 @@ void dev_pm_genpd_synced_poweroff(struct device *dev);
>  int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
>  bool dev_pm_genpd_get_hwmode(struct device *dev);
>  int dev_pm_genpd_rpm_always_on(struct device *dev, bool on);
> +bool dev_pm_genpd_is_on(struct device *dev);
>  
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -393,6 +394,11 @@ static inline int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline bool dev_pm_genpd_is_on(struct device *dev)
> +{
> +	return false;
> +}
> +
>  #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
>  #endif
> -- 
> 2.39.5
> 

