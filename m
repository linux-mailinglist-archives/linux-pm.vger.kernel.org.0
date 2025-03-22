Return-Path: <linux-pm+bounces-24405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B4AA6C84C
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 09:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB74188F099
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 08:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAF51D516A;
	Sat, 22 Mar 2025 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ieHacYSb"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36471922C0;
	Sat, 22 Mar 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742631835; cv=none; b=pQEmSAjYN1xewknxnKW6xAcZl1pypONCt0Wfyd6TaOdELmWnhZIzv0QasZl8Qn8uiavyGf221gxKcjQqKdHyCf8A04we+gOb+DunhErFChSGI9jWCCTRBJoUFvkLfdMNkRqFyq4VrDPMnfLc/uVLmlBH+xc3HGzs/2B2nBArl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742631835; c=relaxed/simple;
	bh=1JtflKyowsrny4ccNJCHAmNyNDlmwMx7iwJtiAM/nUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzM/+3MonUc7NN5qtyPrr4tZOHWEegQzonRJDk8ExYlFTtYa3sE7u9750Q6Zjtp4HP4UU0WL2YJ6CzS7od2vyxcDnv7IMwCQXm3Uwa8B/MbTCL99oOMkmCLo7ZY0NQO7IywdnZqloroZwT7/qebyq8rz03polLvVZfplIg6dJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ieHacYSb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742631830;
	bh=1JtflKyowsrny4ccNJCHAmNyNDlmwMx7iwJtiAM/nUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieHacYSblP1rXFXNlq5KdNwhsLxdwYdLZKMC4361xBtkcU/m/XU4UY3jN1IfsO7DA
	 055e3C/5ao8WDHkypz4xGGwvrxC96YNEqtIE6vck218veniHGOKILA9tZXySo6mUYa
	 9PdeqRp8z3e7sN0PJtTdM9WEiUVperKrsnRFS2RE=
Date: Sat, 22 Mar 2025 09:23:49 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Derek J Clark <derekjohn.clark@gmail.com>, 
	Kevin Greenberg <kdgreenberg234@protonmail.com>, Joshua Tam <csinaction@pm.me>, 
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
	sre@kernel.org, ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com, 
	mario.limonciello@amd.com
Subject: Re: [PATCH v6 11/14] platform/x86: oxpec: Adhere to
 sysfs-class-hwmon and enable pwm on 2
Message-ID: <96d19837-167a-43d6-93ea-cd24844cff7f@t-8ch.de>
References: <20250319175512.27059-1-lkml@antheas.dev>
 <20250319175512.27059-12-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319175512.27059-12-lkml@antheas.dev>

On 2025-03-19 18:55:06+0100, Antheas Kapenekakis wrote:
> Currently, the driver does not adhere to the sysfs-class-hwmon
> specification: 0 is used for auto fan control and 1 is used for manual
> control. However, it is expected that 0 sets the fan to full speed,
> 1 sets the fan to manual, and then 2 is used for automatic control.
> 
> Therefore, change the sysfs API to reflect this and enable pwm on 2.
> 
> As we are breaking the ABI for this driver, rename oxpec to oxp_ec,
> reflecting the naming convention used by other drivers, to allow for
> a smooth migration in current userspace programs.

Where is the renaming being done?

> Closes: https://lore.kernel.org/linux-hwmon/20241027174836.8588-1-derekjohn.clark@gmail.com/
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index e84afc5f53379..680fa537babf6 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -731,7 +731,27 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  		case hwmon_pwm_input:
>  			return oxp_pwm_input_read(val);
>  		case hwmon_pwm_enable:
> -			return oxp_pwm_read(val);
> +			ret = oxp_pwm_read(val);
> +			if (ret)
> +				return ret;
> +
> +			/* Check for auto and return 2 */
> +			if (!*val) {
> +				*val = 2;
> +				return 0;
> +			}
> +
> +			/* Return 0 if at full fan speed, 1 otherwise */
> +			ret = oxp_pwm_fan_speed(val);
> +			if (ret)
> +				return ret;
> +
> +			if (*val == 255)
> +				*val = 0;
> +			else
> +				*val = 1;
> +
> +			return 0;
>  		default:
>  			break;
>  		}
> @@ -745,15 +765,24 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  			      u32 attr, int channel, long val)
>  {
> +	int ret;
> +
>  	switch (type) {
>  	case hwmon_pwm:
>  		switch (attr) {
>  		case hwmon_pwm_enable:
>  			if (val == 1)
>  				return oxp_pwm_enable();
> -			else if (val == 0)
> +			else if (val == 2)
>  				return oxp_pwm_disable();
> -			return -EINVAL;
> +			else if (val != 0)
> +				return -EINVAL;
> +
> +			/* Enable PWM and set to max speed */
> +			ret = oxp_pwm_enable();
> +			if (ret)
> +				return ret;
> +			return oxp_pwm_input_write(255);
>  		case hwmon_pwm_input:
>  			return oxp_pwm_input_write(val);
>  		default:
> -- 
> 2.48.1
> 

