Return-Path: <linux-pm+bounces-12371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67869954FF7
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 19:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADD81C20D79
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924861C2300;
	Fri, 16 Aug 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu9EIHov"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BB1BE855;
	Fri, 16 Aug 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829072; cv=none; b=o6Is4FRCyPHuJhMLG9yTON7SGIUIxlLXsPIJlpmg5/QevwrFw1SDT7kMOcBlVnnnmWhhECMsdc+/HrB/e2wfXzXU7/c7avaw73jx+qutPalmxsYQWS8NmHRsemy8z1Jcd1cagfowzs+DaCHHczpFr3Ptyc6Otvt4oQhB2hlSK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829072; c=relaxed/simple;
	bh=wzh4wmfjr1u3P3pTO5sMPvkEsY0qBcNdzzA9fPjGEXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpVCzYv03oJVWibZxj7/ToZEm5qCOUFA+OIUDCHNt5czGICJ7NPeysHNJeLEPdfihOBtlwL0+LmM4AK6hc2KV+c0HrztpSQuX2UWVaIf4UKxAgwsemu7Mvy9D6fwlpMJEOHpsus9YpwjcrNIOPzL9SqUJEV4ZkgvJehKUYZyPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu9EIHov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B314DC32782;
	Fri, 16 Aug 2024 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723829071;
	bh=wzh4wmfjr1u3P3pTO5sMPvkEsY0qBcNdzzA9fPjGEXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fu9EIHovNPQSe7ULEqBXAfQMJ9BQcMZgjighweaxyfA5vCt9VTxASCsCOI5bxz/nI
	 09/oljwjVCE3HCFswFfGr1riUpBx2eNxKgjTcmIAKCkwUKSjGhGF9XVcTUDZ68z4HT
	 u1u1qhsi0oCI/ny0XxbgXRKx6knXmB7SEZrmL07elZek2fBeTglmtFa6ffhfyFWps9
	 k7MPE2xTFiFm/KPKJWDrZj5mg9O8jK01wRxMm6UvE7BO67PqvEBbCxpB3oE8JlICfM
	 G7vMnyDI4XqI4C3dFiaN3qT7IWlGcfJRZeHKYp2D8Hn8XBtpHNLooYtBRCecqqkOvW
	 l55n/md/VZkaA==
Received: by pali.im (Postfix)
	id A560D7B7; Fri, 16 Aug 2024 19:24:27 +0200 (CEST)
Date: Fri, 16 Aug 2024 19:24:27 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andres Salomon <dilinger@queued.net>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 2/2] platform/x86:dell-laptop: remove duplicate code
 w/ battery function
Message-ID: <20240816172427.yio3xnljd7n34w3b@pali>
References: <20240815192848.3489d3e1@5400>
 <20240815193546.2123b010@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815193546.2123b010@5400>
User-Agent: NeoMutt/20180716

Hello, this change looks good, I have just minor comments about
improving names of variables.

On Thursday 15 August 2024 19:35:46 Andres Salomon wrote:
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 8cc05f0fab91..5df0944e5bf6 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -935,43 +935,24 @@ static void dell_cleanup_rfkill(void)
>  static int dell_send_intensity(struct backlight_device *bd)
>  {
>  	struct calling_interface_buffer buffer;
> -	struct calling_interface_token *token;
> -	int ret;
> -
> -	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
> -	if (!token)
> -		return -ENODEV;
> -
> -	dell_fill_request(&buffer,
> -			   token->location, bd->props.brightness, 0, 0);
> -	if (power_supply_is_system_supplied() > 0)
> -		ret = dell_send_request(&buffer,
> -					CLASS_TOKEN_WRITE, SELECT_TOKEN_AC);
> -	else
> -		ret = dell_send_request(&buffer,
> -					CLASS_TOKEN_WRITE, SELECT_TOKEN_BAT);
> +	u16 pwr;
>  
> -	return ret;
> +	pwr = power_supply_is_system_supplied() > 0 ?

I would suggest to call this variable "select" or something like that.
Name "pwr" is too generic and does not express the fact that is stores
token select id.

> +			SELECT_TOKEN_AC : SELECT_TOKEN_BAT;
> +	return dell_send_request_for_tokenid(&buffer, CLASS_TOKEN_WRITE,
> +			pwr, BRIGHTNESS_TOKEN, bd->props.brightness);
>  }
...
> @@ -2171,21 +2142,11 @@ static int micmute_led_set(struct led_classdev *led_cdev,
>  			   enum led_brightness brightness)
>  {
>  	struct calling_interface_buffer buffer;
> -	struct calling_interface_token *token;
>  	int state = brightness != LED_OFF;
> +	u32 val;
>  
> -	if (state == 0)
> -		token = dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE);
> -	else
> -		token = dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE);
> -
> -	if (!token)
> -		return -ENODEV;
> -
> -	dell_fill_request(&buffer, token->location, token->value, 0, 0);
> -	dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> -
> -	return 0;
> +	val = state == 0 ? GLOBAL_MIC_MUTE_DISABLE : GLOBAL_MIC_MUTE_ENABLE;

Here variable "val" is also too generic. The real meaning of this
variable is tokenid. So I would suggest to use this name as it is used
in other places in this file for storing token id.

> +	return dell_set_std_token_value(&buffer, val, USE_TVAL);
>  }

