Return-Path: <linux-pm+bounces-26943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395DDAB14E0
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0318C4A6AC8
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDA5290BB5;
	Fri,  9 May 2025 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="wPSI/vr3"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2821E0BA;
	Fri,  9 May 2025 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796539; cv=none; b=Fc49O8LDVtJSZjFBlYC8mviTXcJZPBOtEmnLzoieO+ijT+cJwckjCMzcqbdf/vcZ+b5yXvqv6cD34VqJP/TewIWBBm55Cwvvlc39gJDR1SpnbFQpSHepbre8xHrRXollI8RyWr/5oi8NvWeTm/ATNXEUKrjd5ZFxLB+w5I+4jfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796539; c=relaxed/simple;
	bh=UXyzzDpdehczTMF4+3xLIH5vpakhzPYgYGKSHcHP8YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec4d6pDWr7lUE4t0CfCXbUCOb7sASn6JuLz/oiZF7foPlKTf1YMwH9QrylUn+sdh+/uSzEKKwk06Cv3dzgKST3aeRnQWcm7fVe3l0OyFmOAmykaLeL6tlDIEa9+0vowV85M1lxLNk0EEJ4MuAVY7erbryzM8PVSMaM+Ebly2PHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=wPSI/vr3; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Fri, 9 May 2025 09:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1746796534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fUy2yKh/RPLz65MGjD30fnH1nOIBpirqiwEvJyIpAQ=;
	b=wPSI/vr3u7SF6YoZXAxqTcCV3vNyXtHP702KgSsJfIP001Re4QxA4KKir7k+2xF8WKhEtR
	MxLxGF26N6mm9JyRJVvLPSHOt3usxmKhfqCNPUlYvJupgrNNo1kHOVb62VqGkQ9JL2Pl+v
	8vhrbDHt/9MdIfWxF2vK6khuTnnV9AYsi28eYyt+i0t+Il8YbKvw6KPW5A8IgnRr4UU5QJ
	IBvq4amg/uhS+5fEQsQ7Us10in8UzaccSCMTCAwSO4UlHozBHx3N1dfFbPSmJyWm1x3P2V
	hey2AhkAnmGGJzT11fgVKNicTlm6tXcPwM5WXn5fAb8S3UdIb8f/ZTSTyz12CA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/9] Apple Mac System Management Controller
Message-ID: <aB3_8QidjfNRPmOG@blossom>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

Hi Sven,

Everything here looks good to me. I left a few minor comments through
out but overall nothing scary here to me :)

Cheers,
Alyssa

Le Sat, May 03, 2025 at 10:06:47AM +0000, Sven Peter via B4 Relay a écrit :
> Hi,
> 
> It's been quite a while (end of 2022) since the last version of this
> series was sent by Russel. I'd like to pick this up again and get SMC
> upstream.
> 
> I've taken the last version from the ML and worked in the review
> comments and some other changed:
> 
>   - Added documentation for all functions and structs
>   - Fixed dt-bindings and re-ordered commits so that the mfd one comes
>     last and can include the gpio subdevice
>   - Added the reset driver and corresponding bindings
>   - Reworked the atomic mode inside SMC since the previous implementation
>     called mutex_lock from atomic context
>   - Removed the backend split for now which lead to a quite intense discussion
>     for the previous versions which hadn't been solved as far as I could tell
>     from the old threads.
>     It's also been 2+ years and I haven't heard of any backend implementation
>     for T2 or even older macs. It's also unclear to me which sub-devices
>     are actually useful there because at least GPIO and shutdown/reboot
>     from this series will not work as-is there.
>     I'd rather have this initial version which only supports M1+ macs upstream
>     and then iterate there if any other backend is developed.
>     I'll gladly help to re-introduce backend support if it's ever required.
> 
> Dependencies:
> The code and dt-bindings themselves apply cleanly to 6.15-rc1 but
> the device tree changes require the already merged SPMI controller
> and SPMI NVMEM series which will be part of 6.16.
> The series is also using the printf format specifiers which will
> land in 6.16 via the drm-misc tree.
> A tree with all dependencies for testing is available at
> https://github.com/AsahiLinux/linux/commits/sven/smc-v4/.
> 
> Merging:
> The dt-binding patches all depend on each other such that they all
> should probably go together with the mfd device itself.
> The following commits also depend on mfd due to the new header file and
> will either have to go through the mfd tree as well or we'll need an
> immutable branch there.
> I'll take the device tree updates through our tree which also has the
> previous device tree updates these depend on.
> 
> v3: https://lore.kernel.org/asahi/Y2qEpgIdpRTzTQbN@shell.armlinux.org.uk/
> v2: https://lore.kernel.org/asahi/YxdInl2qzQWM+3bs@shell.armlinux.org.uk/
> v1: https://lore.kernel.org/asahi/YxC5eZjGgd8xguDr@shell.armlinux.org.uk/
> 
> Best,
> 
> Sven
> 
> ---
> Hector Martin (5):
>       gpio: Add new gpio-macsmc driver for Apple Macs
>       power: reset: macsmc-reboot: Add driver for rebooting via Apple SMC
>       arm64: dts: apple: t8103: Add SMC node
>       arm64: dts: apple: t8112: Add SMC node
>       arm64: dts: apple: t600x: Add SMC node
> 
> Russell King (Oracle) (2):
>       dt-bindings: gpio: Add Apple Mac SMC GPIO block
>       dt-bindings: mfd: Add Apple Mac System Management Controller
> 
> Sven Peter (2):
>       dt-bindings: power: reboot: Add Apple Mac SMC Reboot Controller
>       mfd: Add Apple Silicon System Management Controller
> 
>  .../devicetree/bindings/gpio/apple,smc-gpio.yaml   |  37 ++
>  .../devicetree/bindings/mfd/apple,smc.yaml         |  71 +++
>  .../bindings/power/reset/apple,smc-reboot.yaml     |  52 ++
>  MAINTAINERS                                        |   7 +
>  arch/arm64/boot/dts/apple/t600x-die0.dtsi          |  35 ++
>  arch/arm64/boot/dts/apple/t8103.dtsi               |  35 ++
>  arch/arm64/boot/dts/apple/t8112.dtsi               |  35 ++
>  drivers/gpio/Kconfig                               |  10 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-macsmc.c                         | 246 ++++++++
>  drivers/mfd/Kconfig                                |  15 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/macsmc.c                               | 657 +++++++++++++++++++++
>  drivers/power/reset/Kconfig                        |  11 +
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/macsmc-reboot.c                | 362 ++++++++++++
>  include/linux/mfd/macsmc.h                         | 337 +++++++++++
>  17 files changed, 1913 insertions(+)
> ---
> base-commit: 8b7e6734e2231a549a23943678ee3452bd19a1fe
> change-id: 20250304-smc-6-15-f0ed619e31d4
> 
> Best regards,
> -- 
> Sven Peter <sven@svenpeter.dev>
> 
> 

