Return-Path: <linux-pm+bounces-27042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F011EAB36E9
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 14:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C962189DC68
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 12:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC95293459;
	Mon, 12 May 2025 12:25:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DCD2918FB;
	Mon, 12 May 2025 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052759; cv=none; b=IinLwlnSmEqOgx/WXFEmHnODLRB8VY1oS3c09uSrHAl+IBHNtsHjBTDfU2d5IVS6M2oHDjFK3X4iXkihRtD3rIqN7lx4+y+xtKzCgYYF/a0wPLRFWBA1Jqj4Y80jfhR9dEF9HHzlY6YvsCvWgnNELUC0vRB/eEZoShPqJrxKVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052759; c=relaxed/simple;
	bh=8MyIFvj3MRzOjg9aZfzqUKLRPoOpgjfFrH5EeIsR2Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPePp5k1XlGhspaZgZDkbAJXuBGqtfCOJIW+Lv30QPo++5JCRREXXZaMDZKnGrgXK+B8VH/37EEpRPKYVgbSG7xtZBGSFeccPaBaOSORSYE3EWZsL7OSeteaeZoQOcYgYMKrmUajgiS2EX6OWAALZLwnYJvfBdB6xcbDrU/xi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fca2805ca4so4738136a12.1;
        Mon, 12 May 2025 05:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747052755; x=1747657555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unJG9v9Xn31cbuzCRYaN/tyt9UiLmNc7cj8xNAf2V7g=;
        b=Bs/Vo4CwxGf9fQHty90XMvTo1dbzAjYXvZsaG8NgMram5rOdVF9Wc6s3xWuOJYCaTM
         3C/sDtVrFSHScaJEDanaKYGDEuzcSNgQsKS3D6dlsX0cyLpP68vkGyE+vKJ0QuWDkkvH
         NxTMJkN5U+b9aOd5g/c5B4rMfpZrO7dY/TiVhv0IZbOvJ5Cu4fIBjnPF+FofrdGFJS3D
         pice5PRwjU/wLwbg4o+L7vpMtyE3JUYw33g00W3Wgdcu+M3Fa5rTVrc4I7VJXvylB1fH
         Iquz/cGoChDGdgsQa+MEXuPNk1JqmrsJRFcXlicQiTSLDVjtrGSE9pSMj0kJ45oAA5SI
         vFoA==
X-Forwarded-Encrypted: i=1; AJvYcCUcfGhuUMY7Joi/VoZU/8dhh9rISY1n1oE2ICN7q19KXNuSYly67/hyV++80cbMmLN5YnHfrF8/Tr4=@vger.kernel.org, AJvYcCVlX343DiZx0b8cTC07zVW65T+iAxvrFGGjiWvh48HiQjxXP3GtFRItQ3s3ixZjxK5GiIOi2bdVxMKu@vger.kernel.org, AJvYcCWSY2wJUDIF0TdsOiUOs4XCI2QeZ1wBvqQSltEbf6HceeplLEu3hxzYgTOfpPAwzjrR9WKp92Z9SLNhPA==@vger.kernel.org, AJvYcCXmW5Idrsd0FKBnks0jtM3bqxpudII4hvlDDi2csMXwKFiaql/gvD24Frlqu5ylu3IFxh2pW4joyytishrc@vger.kernel.org
X-Gm-Message-State: AOJu0YzGn6d/gCYT0tkIYBi33vFRH8Lx1qGA7eaRp8dGOBzqQoFqoqb1
	JVpioIKFy87ubmSG/sPsXogG77bLq6R9wMGGqW94wd98Ul3yp0u5XM1XZ+Xr2kc=
X-Gm-Gg: ASbGncvLKO4CwYU352VF01ilGJZfcK//K6mqYxpOEmYXwXl/g0yjgr/nl2ghq/C1ivu
	Oo6Agc3NxXdWdqUVsesS8y+UzFzg3zqigAo4jjN8Cus33TB5mgYq701iWJkxUNIbryiSLue6h83
	M4p2ujfLGA4uhDhwwlq6Y9vubFMQApOihbhs/Adz6QWM5k918Uui97KSMdkck1QuuR3Vo1iPRoL
	lPsSUc7FNceCQ1qDJrPkiHhz3+wvPLWkxIC4xPENUH0RLIwvQZ4FQpYmmQ3oSdPr55S5rdqePT9
	dSls/sRb+bkYGNS4fWmE8MHnH1Z9oM9M+3FpD8FbDML55Ju186Pvy8MQuPQSTLLBvrLNrbbPUii
	f/a6UUg==
X-Google-Smtp-Source: AGHT+IHUp8fDHOs6OSKzOrdavlwHUCf+GNS2IJ24nxIN2gMNi9VS6VzwRDqYH+Y3RNEir9T+octUYg==
X-Received: by 2002:a17:907:72d0:b0:ace:6d5b:e785 with SMTP id a640c23a62f3a-ad2192b6b17mr1166292566b.47.1747052754753;
        Mon, 12 May 2025 05:25:54 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197be17csm604863466b.156.2025.05.12.05.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:25:53 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbed53b421so6731843a12.0;
        Mon, 12 May 2025 05:25:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlWtWykdr5AZSDzujTMCWX20nD3dFZZVZYYRy2fyrO/XYcrRC5QjaLH/mI2ZNhMSZ4YmA4u9ZRN35b1Q==@vger.kernel.org, AJvYcCXDBgU3beQinyQ5fCjAiSokczsq4SLje8xIa6v26FUAtPjT0Tg4Hs1rUMFKI+09IrS3topwMclLDYtK@vger.kernel.org, AJvYcCXeZFpqdGddUxj2+9OEmhnW61mjibxcnc7P/i8fkSxpirnFBiGCo8CbYX8zqpS+5xSf/eVMFolPrGu0d3Ci@vger.kernel.org, AJvYcCXy2S8IQT/w4J7jCRj0B3ca6X3c/OT892He+tBNcoIgbqpaldOjkdyNjjHcsJUJl0LsPv3L4HdXxfg=@vger.kernel.org
X-Received: by 2002:a17:907:c243:b0:ad2:5198:d711 with SMTP id
 a640c23a62f3a-ad25198d88amr381917366b.10.1747052753743; Mon, 12 May 2025
 05:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
In-Reply-To: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 12 May 2025 08:25:16 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_5t2VuOyhU-xziG_DNVLb5aSMFQ_XiMMboiVokuDB4cw@mail.gmail.com>
X-Gm-Features: AX0GCFshW8pkFO5zWRP_MYEJ_yTJ-TXto5fm5rHE3tApvoCDGWwD2lMg8o2TzQg
Message-ID: <CAEg-Je_5t2VuOyhU-xziG_DNVLb5aSMFQ_XiMMboiVokuDB4cw@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] Apple Mac System Management Controller
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 4:19=E2=80=AFAM Sven Peter via B4 Relay
<devnull+sven.svenpeter.dev@kernel.org> wrote:
>
> Hi,
>
> This series adds support for the System Management Controller found in
> Apple Silicon devices which we model as a mfd. It also includes support
> for the GPIO block and the power/reset block as sub-devices.
>
> Changes between v4 and v5:
>   - Alyssa's comments:
>     - Made the WARN_ON in the reboot driver more obvious
>     - Added missing brackets around a for loop in the reboot driver
>     - Used min instead of open-coded variant inside the gpio driver
>     - Reoder struct memebers to prevent padding inside the mfd driver
>   - Lee's comments:
>     - All comments now start with an uppercase letter
>     - Removed apple_smc_read_ioft_scaled and apple_smc_read_f32_scaled
>       since these are not yet used and likely don't belong into
>       drivers/mfd
>     - Relaced if (ret !=3D 0) with if (ret) when possible
>     - Used devm_platform_get_and_ioremap_resource to get and map the
>       SRAM resource
>     - Used reverse Christmas-tree formating when declaring variables
>     - Dropped _platform left-overs from probe and remove functions
>     - Removed dev_dbg prints which are no long required after
>       development
>     - Reworked is_alive/is_initialized so that it's obvious how errors
>       during boot are propagated from the callback to the probe function
>     - Used dev_warn instead of dev_err in a few places
>     - Removed no-op apple_smc_rtkit_shmem_destroy; this required an
>       additional change in rtkit.c because we had a check there that's a
>       bit too strict
>     - Removed struct resource in apple_smc_rtkit_shmem_setup and
>       open-coded resource_contains instead
>     - Unwrapped lines with less than 100 chars
>     - Made sure to compile with W=3D1 and ran scripts/kernel-doc -v
>       on macsmc.h once and fixed any fallout
>   - Removed first_key/last_key from struct smc and moved
>     apple_smc_find_first_key_index to the gpio driver since it's only
>     used there anyway to find the index of the first GPIO key (gP00)
>   - Return -EIO when a command fails instead of whatever SMC returns
>     which does not map to Linux errnos on errors
>
> Changes between v3 and v4:
>   - Added documentation for all functions and structs
>   - Fixed dt-bindings and re-ordered commits so that the mfd one comes
>     last and can include the gpio subdevice
>   - Added the reset driver and corresponding bindings
>   - Reworked the atomic mode inside SMC since the previous implementation
>     called mutex_lock from atomic context
>   - Removed the backend split for now which lead to a quite intense discu=
ssion
>     for the previous versions which hadn't been solved as far as I could =
tell
>     from the old threads.
>     It's also been 2+ years and I haven't heard of any backend implementa=
tion
>     for T2 or even older macs. It's also unclear to me which sub-devices
>     are actually useful there because at least GPIO and shutdown/reboot
>     from this series will not work as-is there.
>     I'd rather have this initial version which only supports M1+ macs ups=
tream
>     and then iterate there if any other backend is developed.
>     I'll gladly help to re-introduce backend support if it's ever require=
d.
>
> Dependencies:
> The code and dt-bindings themselves apply cleanly to 6.15-rc1 but
> the device tree changes require the already merged SPMI controller
> and SPMI NVMEM series which will be part of 6.16.
> The series is also using the printf format specifiers which will
> land in 6.16 via the drm-misc tree.
> A tree with all dependencies for testing is available at
> https://github.com/AsahiLinux/linux/commits/sven/smc-v5/.
>
> Merging:
> The dt-binding patches all depend on each other such that they all
> should probably go together with the mfd device itself.
> The following commits also depend on mfd due to the new header file and
> will either have to go through the mfd tree as well or we'll need an
> immutable branch there or we just wait one kernel release and I'll
> re-submit the rest then.
> I'll take the device tree updates through our tree which also has the
> previous device tree updates these depend on.
>
> v4: https://lore.kernel.org/asahi/20250503-smc-6-15-v4-0-500b9b6546fc@sve=
npeter.dev/
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
> Sven Peter (3):
>       dt-bindings: power: reboot: Add Apple Mac SMC Reboot Controller
>       soc: apple: rtkit: Make shmem_destroy optional
>       mfd: Add Apple Silicon System Management Controller
>
>  .../devicetree/bindings/gpio/apple,smc-gpio.yaml   |  37 ++
>  .../devicetree/bindings/mfd/apple,smc.yaml         |  71 +++
>  .../bindings/power/reset/apple,smc-reboot.yaml     |  52 +++
>  MAINTAINERS                                        |   7 +
>  arch/arm64/boot/dts/apple/t600x-die0.dtsi          |  35 ++
>  arch/arm64/boot/dts/apple/t8103.dtsi               |  35 ++
>  arch/arm64/boot/dts/apple/t8112.dtsi               |  35 ++
>  drivers/gpio/Kconfig                               |  10 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-macsmc.c                         | 293 ++++++++++++
>  drivers/mfd/Kconfig                                |  15 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/macsmc.c                               | 506 +++++++++++++++=
++++++
>  drivers/power/reset/Kconfig                        |  11 +
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/macsmc-reboot.c                | 363 +++++++++++++++
>  drivers/soc/apple/rtkit.c                          |   3 +-
>  include/linux/mfd/macsmc.h                         | 277 +++++++++++
>  18 files changed, 1751 insertions(+), 2 deletions(-)
> ---
> base-commit: 5abab6ab4ebacfff5857b63bd349902a6568d2e8
> change-id: 20250304-smc-6-15-f0ed619e31d4
>

Series overall looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

