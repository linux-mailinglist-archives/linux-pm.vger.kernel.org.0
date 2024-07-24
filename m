Return-Path: <linux-pm+bounces-11372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2A93B839
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 22:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858941F226EF
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 20:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5513A409;
	Wed, 24 Jul 2024 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw5JmPMX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54B139588;
	Wed, 24 Jul 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721854210; cv=none; b=jJDtGEMkUnsIo1ymKKo0h5o5wYV9lvsaXuOk3Z3Gf4ev95tC3oLkglHkI3j5pOR30kYFLhmFg460vTXULqK5U4gtdACppt/klKxBGbYfhv5nd16MzrH0Dh9VmchTagRzQ6Zn4036uFZB9gAb0AJYhJZQpmIpu+r8Gy0wS6VygKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721854210; c=relaxed/simple;
	bh=sTRJn/ZXtHQZzEr0Mgxep5JSYetG8fDfVuOoT4QxmzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfytFp9qnYmX+5cAvawnEwJsP8ln5N0Tdtp+qmpzoHlbws8uf4SrwOZoAyEp+6TEIWbH8dwQzfWyNKvpekil3V+RuUj5WRGQg5Yh7JFRAZVNsYgYUX4T2ji8ex82fQrMSR40KJa5llc7f7wgGMCFUi32/uBzgEfj1XBevVWWAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw5JmPMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A433BC32781;
	Wed, 24 Jul 2024 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721854209;
	bh=sTRJn/ZXtHQZzEr0Mgxep5JSYetG8fDfVuOoT4QxmzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xw5JmPMXNXrefp91XEBVCPxGsXkegaRT6RDBFKmg43tXqjC4O22MeMeGDnU8KaxVh
	 kJUc5zMMSZt0/+034jfUvD3zVIdCI2wsl0Y/fUs7pOXx4wJLjvQpqGPc0siFna16Qc
	 FEh/g+tGzCgHEF/GMDBt/IWBVr7yOqKx0v7ot1ikam7miJ5eV86vQIdxv4J20OPBZ2
	 p+h2wwmH5DD6XORgmLYw7HfcLU2F6L9b36y82jivDSS/ygJ/Oixt/+bIiqeWOsXS1s
	 KE8/MrhOU0Xe0XinLR/dV/1nk2BAnF4ljPGkxidie9WkBgvg/da5MPvRMsXZ3aUFDo
	 bkaOParXMUmUw==
Received: by pali.im (Postfix)
	id E2280726; Wed, 24 Jul 2024 22:50:04 +0200 (CEST)
Date: Wed, 24 Jul 2024 22:50:04 +0200
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
Message-ID: <20240724205004.zcevow3swmpwhq3e@pali>
References: <20240723220502.77cb0401@5400>
 <20240723220724.4f8eaf49@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723220724.4f8eaf49@5400>
User-Agent: NeoMutt/20180716

On Tuesday 23 July 2024 22:07:24 Andres Salomon wrote:
> The dell battery patch added dell_send_request_by_token_loc(), which
> encapsulates a very common pattern when SMBIOS queries are addressed
> to token->location. This sets up the function to be used throughout
> the dell laptop code, and calls it in various places allowing us to
> delete a bunch of code.
> 
> Also some very minor cleanups:
>   - mark the kbd init functions as __init
>   - don't read buffer.output unless dell_send_request() was successful.
> 
> No behavior changes, other than the delayed read of buffer.output.

This change looks good, I do not see any obvious problem there. Nice cleanup!

Reviewed-by: Pali Rohár <pali@kernel.org>

> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
>  drivers/platform/x86/dell/dell-laptop.c | 148 ++++++++----------------
>  1 file changed, 48 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index aae9a95fb188..facf00c8289d 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -367,6 +367,25 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
>  	{ }
>  };
>  
> +/* -1 is a sentinel value, telling us to use token->value */
> +#define USE_TVAL ((u32) -1)
> +static int dell_send_request_by_token_loc(struct calling_interface_buffer *buffer,
> +					  u16 class, u16 select, int type,
> +					  u32 val)
> +{
> +	struct calling_interface_token *token;
> +
> +	token = dell_smbios_find_token(type);
> +	if (!token)
> +		return -ENODEV;
> +
> +	if (val == USE_TVAL)
> +		val = token->value;
> +
> +	dell_fill_request(buffer, token->location, val, 0, 0);
> +	return dell_send_request(buffer, class, select);
> +}
> +
>  /*
>   * Derived from information in smbios-wireless-ctl:
>   *
> @@ -909,43 +928,24 @@ static void dell_cleanup_rfkill(void)
>  static int dell_send_intensity(struct backlight_device *bd)
>  {
>  	struct calling_interface_buffer buffer;
> -	struct calling_interface_token *token;
> -	int ret;
> -
> -	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
> -	if (!token)
> -		return -ENODEV;
> +	u16 pwr;
>  
> -	dell_fill_request(&buffer,
> -			   token->location, bd->props.brightness, 0, 0);
> -	if (power_supply_is_system_supplied() > 0)
> -		ret = dell_send_request(&buffer,
> -					CLASS_TOKEN_WRITE, SELECT_TOKEN_AC);
> -	else
> -		ret = dell_send_request(&buffer,
> -					CLASS_TOKEN_WRITE, SELECT_TOKEN_BAT);
> -
> -	return ret;
> +	pwr = power_supply_is_system_supplied() > 0 ?
> +			SELECT_TOKEN_AC : SELECT_TOKEN_BAT;
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			pwr, BRIGHTNESS_TOKEN, bd->props.brightness);
>  }
>  
>  static int dell_get_intensity(struct backlight_device *bd)
>  {
>  	struct calling_interface_buffer buffer;
> -	struct calling_interface_token *token;
>  	int ret;
> +	u16 pwr;
>  
> -	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
> -	if (!token)
> -		return -ENODEV;
> -
> -	dell_fill_request(&buffer, token->location, 0, 0, 0);
> -	if (power_supply_is_system_supplied() > 0)
> -		ret = dell_send_request(&buffer,
> -					CLASS_TOKEN_READ, SELECT_TOKEN_AC);
> -	else
> -		ret = dell_send_request(&buffer,
> -					CLASS_TOKEN_READ, SELECT_TOKEN_BAT);
> -
> +	pwr = power_supply_is_system_supplied() > 0 ?
> +			SELECT_TOKEN_AC : SELECT_TOKEN_BAT;
> +	ret = dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ, pwr,
> +			BRIGHTNESS_TOKEN, 0);
>  	if (ret == 0)
>  		ret = buffer.output[1];
>  
> @@ -1369,20 +1369,12 @@ static int kbd_set_state_safe(struct kbd_state *state, struct kbd_state *old)
>  static int kbd_set_token_bit(u8 bit)
>  {
>  	struct calling_interface_buffer buffer;
> -	struct calling_interface_token *token;
> -	int ret;
>  
>  	if (bit >= ARRAY_SIZE(kbd_tokens))
>  		return -EINVAL;
>  
> -	token = dell_smbios_find_token(kbd_tokens[bit]);
> -	if (!token)
> -		return -EINVAL;
> -
> -	dell_fill_request(&buffer, token->location, token->value, 0, 0);
> -	ret = dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> -
> -	return ret;
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, kbd_tokens[bit], USE_TVAL);
>  }
>  
>  static int kbd_get_token_bit(u8 bit)
> @@ -1401,11 +1393,10 @@ static int kbd_get_token_bit(u8 bit)
>  
>  	dell_fill_request(&buffer, token->location, 0, 0, 0);
>  	ret = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> -	val = buffer.output[1];
> -
>  	if (ret)
>  		return ret;
>  
> +	val = buffer.output[1];
>  	return (val == token->value);
>  }
>  
> @@ -1511,7 +1502,7 @@ static inline int kbd_init_info(void)
>  
>  }
>  
> -static inline void kbd_init_tokens(void)
> +static inline void __init kbd_init_tokens(void)
>  {
>  	int i;
>  
> @@ -1520,7 +1511,7 @@ static inline void kbd_init_tokens(void)
>  			kbd_token_bits |= BIT(i);
>  }
>  
> -static void kbd_init(void)
> +static void __init kbd_init(void)
>  {
>  	int ret;
>  
> @@ -2145,21 +2136,12 @@ static int micmute_led_set(struct led_classdev *led_cdev,
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
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, val, USE_TVAL);
>  }
>  
>  static struct led_classdev micmute_led_cdev = {
> @@ -2173,21 +2155,12 @@ static int mute_led_set(struct led_classdev *led_cdev,
>  			   enum led_brightness brightness)
>  {
>  	struct calling_interface_buffer buffer;
> -	struct calling_interface_token *token;
>  	int state = brightness != LED_OFF;
> +	u32 val;
>  
> -	if (state == 0)
> -		token = dell_smbios_find_token(GLOBAL_MUTE_DISABLE);
> -	else
> -		token = dell_smbios_find_token(GLOBAL_MUTE_ENABLE);
> -
> -	if (!token)
> -		return -ENODEV;
> -
> -	dell_fill_request(&buffer, token->location, token->value, 0, 0);
> -	dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> -
> -	return 0;
> +	val = state == 0 ? GLOBAL_MUTE_DISABLE : GLOBAL_MUTE_ENABLE;
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, val, USE_TVAL);
>  }
>  
>  static struct led_classdev mute_led_cdev = {
> @@ -2197,31 +2170,12 @@ static struct led_classdev mute_led_cdev = {
>  	.default_trigger = "audio-mute",
>  };
>  
> -static int dell_send_request_by_token_loc(struct calling_interface_buffer *buffer,
> -					  u16 class, u16 select, int type,
> -					  u32 val)
> -{
> -	struct calling_interface_token *token;
> -
> -	token = dell_smbios_find_token(type);
> -	if (!token)
> -		return -ENODEV;
> -
> -	/* -1 is a sentinel value, telling us to use token->value */
> -	if (val == (u32)-1)
> -		val = token->value;
> -
> -	dell_fill_request(buffer, token->location, val, 0, 0);
> -	return dell_send_request(buffer, class, select);
> -}
> -
>  static int dell_battery_set_mode(const int type)
>  {
>  	struct calling_interface_buffer buffer;
>  
> -	/* -1 means use the value from the token */
>  	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> -			SELECT_TOKEN_STD, type, -1);
> +			SELECT_TOKEN_STD, type, USE_TVAL);
>  }
>  
>  static int dell_battery_read(const int type)
> @@ -2470,7 +2424,7 @@ static void __exit dell_battery_exit(void)
>  
>  static int __init dell_init(void)
>  {
> -	struct calling_interface_token *token;
> +	struct calling_interface_buffer buffer;
>  	int max_intensity = 0;
>  	int ret;
>  
> @@ -2532,16 +2486,10 @@ static int __init dell_init(void)
>  	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>  		return 0;
>  
> -	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
> -	if (token) {
> -		struct calling_interface_buffer buffer;
> -
> -		dell_fill_request(&buffer, token->location, 0, 0, 0);
> -		ret = dell_send_request(&buffer,
> -					CLASS_TOKEN_READ, SELECT_TOKEN_AC);
> -		if (ret == 0)
> -			max_intensity = buffer.output[3];
> -	}
> +	ret = dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ,
> +			SELECT_TOKEN_AC, BRIGHTNESS_TOKEN, 0);
> +	if (ret == 0)
> +		max_intensity = buffer.output[3];
>  
>  	if (max_intensity) {
>  		struct backlight_properties props;
> -- 
> 2.39.2
> 
> 
> 
> -- 
> I'm available for contract & employment work, see:
> https://spindle.queued.net/~dilinger/resume-tech.pdf

