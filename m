Return-Path: <linux-pm+bounces-43590-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JolFWBtqGn9uQAAu9opvQ
	(envelope-from <linux-pm+bounces-43590-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 18:35:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C420535D
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 18:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A858B30219FC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04443C3C06;
	Wed,  4 Mar 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3gRyRbA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C03C2796;
	Wed,  4 Mar 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645722; cv=none; b=QBvN4aZSi8lBnDNKGAnHGMdR7OmD2clz4+49CPJfb2jB0wTRn8HQgFYR7yovOSdiuEf4u9zwCE+3dWx1mzn+Rb+tag6/mO4BUJ4Bkv+eXuxlw/CuRj6ZlR29PZTTygZqCvQVKIwLkWZH/n7lpVGx2nTrCQro8GdaSrP974lg2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645722; c=relaxed/simple;
	bh=G9vyc/ilKI+19PmiBHaHsKJ89Xu7vIMfI3QiSI5VErY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrh2JJAaZezbUVr81myQ6njNg/NWr4lbFIZQ5mE/jpl2cawZ89z/lIp8IgcYT/o9qGWFwPulL1RlMkmZ7Rtp7OI9vaZoO5cQMGlhNDQegsD4cwGIbEzhKmIhtBPbJDbjL0sDL9lyC35acKySSr9CEwL80frdEgqF1koGN0w3Dtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3gRyRbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829B1C4CEF7;
	Wed,  4 Mar 2026 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772645722;
	bh=G9vyc/ilKI+19PmiBHaHsKJ89Xu7vIMfI3QiSI5VErY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p3gRyRbAmt88QYW+qJdvWj5qtD8qosiS8iWmV/39WnJFzuC4DFAe3Tyh3mY5h74qn
	 7FInoYzEWeFQ7CY8OwV54MEwdqBRVWYnNQjTVdnKRUwBSziNDWA8ecqaRvzzK/Ff90
	 NfHNcwk1I3PM4D715Ch9BaVnphe1VPolSNNw/U/tzszjymiQfwM4YNdTcdbZC7y810
	 7RYshqucnV1ca7eqd5+alsDV7oBEf6j/gB6X5uQ0hYuTexFE8Xvio9sCPsXsInNbYo
	 9ZA6X79vEceTQn8vjICVOHvGoStAFiT1AZGx6edtfTQ2DKM/24xYE+6Yy8QIDT5o5s
	 kOKClwu9c5Q9w==
Message-ID: <f00b1812-a27f-49db-9277-6697af098248@kernel.org>
Date: Wed, 4 Mar 2026 09:35:19 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] arc: axs10x: drop unneeded dependency on OF_GPIO
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@kernel.org>,
 Scott Wood <oss@buserror.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-pm@vger.kernel.org
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
 <20260304-gpio-of-kconfig-v1-2-d597916e79e7@oss.qualcomm.com>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <20260304-gpio-of-kconfig-v1-2-d597916e79e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 410C420535D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43590-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vgupta@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/4/26 1:02 AM, Bartosz Golaszewski wrote:
> OF_GPIO is automatically enabled on all OF systems. There's no need to
> select it explicitly.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  arch/arc/plat-axs10x/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arc/plat-axs10x/Kconfig b/arch/arc/plat-axs10x/Kconfig
> index b9652c69d1b90e506f82b3b8c5be373c51246671..40f2a74d404ad9759ab9d6764c2496159eea045a 100644
> --- a/arch/arc/plat-axs10x/Kconfig
> +++ b/arch/arc/plat-axs10x/Kconfig
> @@ -7,7 +7,6 @@ menuconfig ARC_PLAT_AXS10X
>  	bool "Synopsys ARC AXS10x Software Development Platforms"
>  	select DW_APB_ICTL
>  	select GPIO_DWAPB
> -	select OF_GPIO
>  	select HAVE_PCI
>  	select GENERIC_IRQ_CHIP
>  	select GPIOLIB

Acked-by: Vineet Gupta <vgupta@kernel.org>

Thx and apologies for the delay in getting to it.

Cheers,
-Vineet

