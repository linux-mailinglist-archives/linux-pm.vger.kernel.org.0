Return-Path: <linux-pm+bounces-28929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 212B9ADE168
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 05:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F023A4CB6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6913E02D;
	Wed, 18 Jun 2025 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw86FArF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27F28F5;
	Wed, 18 Jun 2025 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750215697; cv=none; b=FzM+/XIKaEOFEQbPQGGc92fCbdNDbxwSsWdGMOx0hU/eCgEFsQwfgdPxB2/L4IoRJRPiJFHwls7GROb/lC0lP5twEq6hOnQWQTGaP/Djt64zJwg3AO1nHW2SawS0/tXZOBB+Ec9hMVOViKIKRCaHP9XyWKe+3DwDdLYOCfIOpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750215697; c=relaxed/simple;
	bh=t64bpj/Jy42DYE5bUAkvqiJUO9YUAIAKnwMoETOdEDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDstVLh4Jg3hZ8oY6+pwKn4gW3coGYfLSf82OodA2S1h8nOa1yDlN4D2DjmX0T7w7rv3Y+obwSKqweNMeq3lPVZGI0s9V4vKyrgtZGHrAcmEDGz8TzjtLNWntRsg8XwkVRKGaoqFXJKbiUlljBBg+yErUj2m3fKAxY53Sg8qtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw86FArF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130B7C4CEE3;
	Wed, 18 Jun 2025 03:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750215697;
	bh=t64bpj/Jy42DYE5bUAkvqiJUO9YUAIAKnwMoETOdEDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zw86FArFjjTfunSWC4ojQFaMimtGRXBLhq27l9ith755fD0O1H55k8KjjENbj6WsW
	 AsldrcTTz22pbtz9xsU8a2xCAzOvn6XW/Af9lFgUdVW8fjG/QHRZVp31Je0S9QwYkK
	 39+PcexM/neXhDJuFGfAdfOG+SUpiFrWRM2+8Lbp3nGENhqoGMR9SOw09N3ywCO/8T
	 kfwWpLN7xJ+jJqsUeArdkXqWhtvW65ojsoueVvYj6KsmRfLmE7C7wTmreWiD2UuZA+
	 umyu8Ljzmxs0/YbXlDB9oYzIzOEg5c7RYKVFc29/I7wFCU8PKOncJQEcaxwegaAxal
	 20VNzZl30OlSg==
Date: Tue, 17 Jun 2025 22:01:34 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com, 
	iuliana.prodan@oss.nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 1/3] pmdomain: core: introduce dev_pm_genpd_is_on()
Message-ID: <ihhh74pzm64nalva27ukpe7v3unx6j2r4opr5yeezm4mefgryi@pi7ky4sv2t7c>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
 <20250617193450.183889-2-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617193450.183889-2-hiagofranco@gmail.com>

On Tue, Jun 17, 2025 at 04:34:48PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> This helper function returns the current power status of a given generic
> power domain.
> 
> As example, remoteproc/imx_rproc.c can now use this function to check
> the power status of the remote core to properly set "attached" or
> "offline" modes.
> 
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> v4 -> v5:
> - s/dev_pm_genpd_is_on/dev_pm_genpd_is_on()/ in function description.
> - Updated function description to be explicit the function reflects the
>   current power status and that this might change after the function
>   returns, especially if the genpd is shared.
> 
> v3 -> v4:
> - New patch.
> ---
>  drivers/pmdomain/core.c   | 33 +++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h |  6 ++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index ff5c7f2b69ce..2f387e15cb75 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -758,6 +758,39 @@ int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
>  
> +/**
> + * dev_pm_genpd_is_on() - Get device's current power domain status
> + *
> + * @dev: Device to get the current power status
> + *
> + * This function checks whether the generic power domain associated with the
> + * given device is on or not by verifying if genpd_status_on equals
> + * GENPD_STATE_ON.
> + *
> + * Note: this function returns the power status of the genpd at the time of the
> + * call. The power status may change after due to activity from other devices
> + * sharing the same genpd. Therefore, this information should not be relied for
> + * long-term decisions about the device power state.
> + *
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

