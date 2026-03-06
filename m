Return-Path: <linux-pm+bounces-43885-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCN6DHJjq2mmcgEAu9opvQ
	(envelope-from <linux-pm+bounces-43885-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 00:29:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E18D228B64
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 00:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1DEA308B43A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D67A378D99;
	Fri,  6 Mar 2026 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjVHqHXk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28B378823
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839746; cv=none; b=O8D8n+LA2PNXNgrUPsonQKhGesHj58STFVG+eVx6jihUrUYUVcQspVxPY0GenjMxl+EprBS5DaEoyrXucc8SL/1EEf9ny/j1zqKv3TxwVhquuhi9zIB2T7vlSgxwQpFJm3/65oH2Z0hxAsi/YRuD2bXjvjVmCozH/96WEbUDVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839746; c=relaxed/simple;
	bh=UPz/1qsRdJyWIaGxAjf5OdGUVOKPj4+OWW8N2wpx+5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2gqOM50Ll+3QCOfWB3dZEBJ2q998nXVaOey+HXntLyHy1jEF3IyHVxZ1tSZV09gpXBIg2J393MRy6MlfcFBA9AZiGlPpkAbQQepg7bFVQIDwCB2ZP4i8aqg+xfa8zJSXPRntAgj6sIKOMO3cIgdsrXoKIRZhcOn1gK4MKqV9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjVHqHXk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296d553142so1885624b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 15:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772839741; x=1773444541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmuJidMV1Wwe0qpdw07DaES1yYrCFjR7mRIMJgUWNXw=;
        b=DjVHqHXkitQOgeTCFIgY1UBwagDbOg0hzzUmH5zkATA4k0xEPq7OLMlqy06EFf7SLM
         DRUlFsNujF9SCMe91CjSRtswTjxREeuvCzDnmOD/g8DIdB7pVB3aolUkj4GjgQeZrYwz
         yiXBN1T5uiV0scYxH9WZwweKQQ4dgZwaBatAy3x/abym6TDsrnw99Y7db1gP45MaNHgK
         hyzsRs9m5+2HF+ZBbgOrpNsRNxzyj6JoUHkUJa81EnXKQ3UBnprP7e3pxNdStaMiMGUe
         ZtgNKAcGiZLJrrbK51+Qge5PvmA9BQtUFvNXiM9GuUVeBVAzs/0+hUld+kWh73RAfhG2
         A/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839741; x=1773444541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jmuJidMV1Wwe0qpdw07DaES1yYrCFjR7mRIMJgUWNXw=;
        b=QqY8MzxJKrXfofXzaLtUvh5Hb318Sn+LZh0PAQInq/fD4ocV3HyGveuFPVDlyxkYx1
         vSDmxFHH8vE+i1VrEFKrp8L6SqLZdqJR/BLlkgx7IUF7t7PJK23b3d9ojh1vpQluLjOj
         57oiZKEjIYnB/wo7HSBco/SpyFp0x11KySnpNMZyeZeU36XC5KrkZaKXeG7Bqt+EFVJQ
         cuUzvLcgm/kN9nsu4rP2t4XyTTDvBdQ/XbBVC/DJdwStezHhDxc241HZ0pDWAfrdabEF
         FFHwUoBWCitdR82jTdGUe7DxQeeHbHUija7GjjktqebEyk2f4hHKFf4LmfN653v2gA9S
         u1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW1zBJsEkCN0g+jwzGpsjEdKatobFRvllwL3rGgFNa+LLYdbaXQpmYvTiT92YS0sdceQCUizBRH6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeXwr6jVRhK8jh2qyTO2a3ERxP0P9bC6jeucyN7Nn83NaQvYLf
	bkP8EWIXvQbGT/jn1SZJ8vUx3emIhQV1lkm2CzclOai/+w6vC/lQMnqr
X-Gm-Gg: ATEYQzyyhHpZFg/YaTSkFJABM9OCbMROZx8XrI1CcrwWq2YLx5oZ48D9ffeQgIIk/Zd
	upPhbA7rqgpyTHhNNlZEyxQuPhBEztP+AZZbpUEwCGTEqIILqx9lUGxzviC0vBxePV6OsFWl9hn
	TxvW8BVrSlCfvwe65lro3z/GvBWwJHlxrZROkPNTVF6T41Jme+aC0+t2tvwyT+05uE5xCFlcwS4
	FqIpJz/sPKu9icjKgLBesvvkj2Q7rkvxCXuxywMTWnXA8w0qS9GEIpaPEGjzJFhY3OqaCKehL7K
	+qVSRrq0/g7CHI1F8++u0DjmpnYCkJOap9DX5vAqSO19adwPCAhM92GkxiJ+LxRHLJoDZHJCC8v
	HZwO/trw5EeFytZD5Ki55mkoNtdVjAibLap4SmXHaPgeYLqxQOTvrmRHRlFJ7mv9y9aXeCIN/oD
	ZgrmXlmM4CYMjT5pq8xCBcnfvCyNB/BzK3QUfK
X-Received: by 2002:a05:6a00:9510:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-829a2d86b43mr3749707b3a.9.1772839741072;
        Fri, 06 Mar 2026 15:29:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d3621sm3213092b3a.62.2026.03.06.15.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:29:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 6 Mar 2026 15:28:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 10/14] watchdog: convert the Kconfig dependency on
 OF_GPIO to OF
Message-ID: <2c6ad0ca-fd72-4bf5-9180-f45c20e60d37@roeck-us.net>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
 <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>
X-Rspamd-Queue-Id: 9E18D228B64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43885-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,linux-watchdog.org,linuxfoundation.org,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[46];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,roeck-us.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 10:02:31AM +0100, Bartosz Golaszewski wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it
> controls also provide stubs so there's really no reason to select it
> explicitly. We could simply remove the dependency but in order to avoid
> a new symbol popping up for everyone in make config - just convert it to
> requiring CONFIG_OF.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5d6e035ed3cbe5c2b631d11b76b20..ef200339a22a6f9c51a46c9c0b8466add74313e2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -250,7 +250,7 @@ config DA9062_WATCHDOG
>  
>  config GPIO_WATCHDOG
>  	tristate "Watchdog device controlled through GPIO-line"
> -	depends on OF_GPIO
> +	depends on OF

AI feedback:

  Could this change inadvertently allow the driver to be selected when GPIOLIB
  is disabled?

  In drivers/gpio/Kconfig, OF_GPIO is defined inside the "if GPIOLIB" block,
  so it implicitly depends on GPIOLIB. By changing the dependency directly to
  OF, the GPIOLIB dependency is lost.

  If GPIOLIB is disabled, the driver will still compile because of the stubs
  in include/linux/gpio/consumer.h, but devm_gpiod_get() will unconditionally
  return -ENOSYS, causing the probe to fail. Since the driver's sole purpose
  is to control a watchdog via a GPIO line, should it be prevented from being
  configured without GPIOLIB by using something like:

	depends on OF && GPIOLIB

It has a point. Please update.

Thanks,
Guenter

>  	select WATCHDOG_CORE
>  	help
>  	  If you say yes here you get support for watchdog device

