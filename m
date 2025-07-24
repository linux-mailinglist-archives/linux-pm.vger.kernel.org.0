Return-Path: <linux-pm+bounces-31361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32EB10501
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D54188CC37
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FB9274B5F;
	Thu, 24 Jul 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtqYM+bt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495569D2B;
	Thu, 24 Jul 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346941; cv=none; b=IZOY1BaPUGj8fxM156R2HZzbh6zHBF7xuEZVKgFghcXA015jk0lE3rRQRby2eOPQl+X0M+JW3JOtDHyMvbw63vwiI4egL8HAuDggi7QV6wHRhak34u73ukcruZmSpfM7cIzPgaHsbAT2iwN24Q3ETrX3w/pScu1KtaFqx6k4ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346941; c=relaxed/simple;
	bh=rzxMStLAEjWZwWfiymoUFIpQH/pUdeR+8sMJTcfv8OE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qVeIwLukSkmzpsrLZxprzixAAtk5KCC/FTPQzKXvH6gwLS+1ljMe7IZIX9EvmJZQodhlRIEfqGck9iovTJw16WiDlz/HzHrqLos0PKVnhLhiMP4kd1fecF1qrQVAJAga011jdKpP1lBxKchiY9fcPriMCZqvb3ZuWoYS4Hrtdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtqYM+bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D828BC4CEF4;
	Thu, 24 Jul 2025 08:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753346940;
	bh=rzxMStLAEjWZwWfiymoUFIpQH/pUdeR+8sMJTcfv8OE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gtqYM+bt0rJWWmE2lWvgCnN2A3qpmeG0oIFEbqqLFzwujcr8YPsfno7KzJT91vwVY
	 8j7Aa564MdLlm5pGW1V9Gqta5CO4s++D5C9id1bs2bmf+7rgn7TtG+rpzHItOOxIAY
	 27KBdW5WhEBTO8xpkkFs9HbfchUFOWfJu+cbMPkvk3kE65MqL2nylmXI5+22IWexnK
	 /QLhCmPQXlXXRITRyCRoekNFCbBwGsF8MNmcE2tcaK6RES+u0yJK5lC8T2wlEpPDu6
	 C4vjr6jLAHasL+37oQOTN4zh7ul4Ph0Pac7aZ7uIrR2K/1UmjZtq5J6BZCQRcx69fG
	 8xCphYvvBRQ0w==
From: Lee Jones <lee@kernel.org>
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
Subject: Re: (subset) [PATCH v7 00/10] Apple Mac System Management
 Controller
Message-Id: <175334693659.1935861.13683239351116261977.b4-ty@kernel.org>
Date: Thu, 24 Jul 2025 09:48:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 10 Jun 2025 15:29:41 +0000, Sven Peter wrote:
> This series adds support for the System Management Controller found in
> Apple Silicon devices which we model as a mfd. It also includes support
> for the GPIO block and the power/reset block as sub-devices.
> 
> Changes between v6 and v7:
>   - Rebased on 6.16-rc1
>   - Dropped mfd- prefix from the macsmc driver name
>   - Removed the check if the MBSE key exists in the reboot driver since
>     we can rely on the device tree now
>   - Changed my mail address to kernel.org
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: gpio: Add Apple Mac SMC GPIO block
        commit: 0f0a7bd04e7e00cef6da5f4955749d6f1fc27b32
[02/10] dt-bindings: power: reboot: Add Apple Mac SMC Reboot Controller
        commit: 51bb1f6d4694cd84491847ea59eb194311b7d7f8
[03/10] dt-bindings: mfd: Add Apple Mac System Management Controller
        commit: dbad719958e162ac021716c223ba9df9071bca55
[04/10] soc: apple: rtkit: Make shmem_destroy optional
        commit: ba9ae011e8373b1ff34aa4175c79288013de7fc8
[05/10] mfd: Add Apple Silicon System Management Controller
        commit: e038d985c9823a12cd64fa077d0c5aca2c644b67
[06/10] gpio: Add new gpio-macsmc driver for Apple Macs
        commit: 9b21051b0885912f5bb2cc9d4f95c6fca697da4d
[07/10] power: reset: macsmc-reboot: Add driver for rebooting via Apple SMC
        commit: 819687eb28e501d21dabd6a3f52454638a815071

--
Lee Jones [李琼斯]


