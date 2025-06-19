Return-Path: <linux-pm+bounces-29069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F07AE0453
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 13:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0931918890BE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D93230278;
	Thu, 19 Jun 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJBUADiP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A7221704;
	Thu, 19 Jun 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333805; cv=none; b=IA/eBxlT3Bh10/IlZcH7n2gYe/SmzHhuXGqjsafqtnKxrPpZ4szfwjYWYvOxCAsNPrh9UD9G2MAyaWMuDvlTJZEOh9k2JmOd0nWzqXRv9AOMvJBKO0pXAeE5g7NIzy5821ZTWmzn4sTWy6pt+Jn/SCWRhAVLyzi7cxZJpIVqeiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333805; c=relaxed/simple;
	bh=xcXMxMStMR8/rb3GKA1jioXnMSxQsU2Ozqjqe/yF1w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYyh2maadk7gA6pk2/oD9AbS4sVsxNvk8N+7bsHs/ltZJgHeBULH4JsHNFk3m5ZhxTgSWUlK8a6sUPSsngEVLqLH3/yn/XU8ZoQiLXvU36B6zdn3qq1ppAFH/Tc80kjo+KpTNTDlsUypmlCc3zTeYguQ+0pTOeNhn4vyOxTCyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJBUADiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B52C4CEEA;
	Thu, 19 Jun 2025 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750333805;
	bh=xcXMxMStMR8/rb3GKA1jioXnMSxQsU2Ozqjqe/yF1w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJBUADiP0/X9+azGm/g0vceCBNhs6nGkYRctOjZ0QujbBcVw07QEuw90FiyNinK/F
	 NfZ37rkV0sUP/G0oblx/GVCfEyXj/nhORcmp5qDKSX0KH3ot5K7K59vws1ab9u98Lq
	 EJoWZgGz25N5q51nkLZxnbG4upiC8/EdjQ/1y/YDTUhEIrC8aEDgvYIxCJ8RpieFcI
	 rVHrJS0yuA3ss51VZzsJ4cSoJHpoOVA5SxIfiC93NY9Py8Y8VzT/lpbSGO9BzGefL0
	 Vz9D/grzsbiLENfOJmkZpKpjPCCVMTxRsZEVtE/ahvL6O4duPDOE61p95G5saaxSRZ
	 FiFGUqm7XKKiQ==
Date: Thu, 19 Jun 2025 12:49:58 +0100
From: Lee Jones <lee@kernel.org>
To: Sven Peter <sven@kernel.org>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 05/10] mfd: Add Apple Silicon System Management
 Controller
Message-ID: <20250619114958.GJ587864@google.com>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-5-556cafd771d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610-smc-6-15-v7-5-556cafd771d3@kernel.org>

On Tue, 10 Jun 2025, Sven Peter wrote:

> The System Management Controller (SMC) on Apple Silicon machines is a
> piece of hardware that exposes various functionalities such as
> temperature sensors, voltage/power meters, shutdown/reboot handling,
> GPIOs and more.
> 
> Communication happens via a shared mailbox using the RTKit protocol
> which is also used for other co-processors. The SMC protocol then allows
> reading and writing many different keys which implement the various
> features. The MFD core device handles this protocol and exposes it
> to the sub-devices.
> 
> Some of the sub-devices are potentially also useful on pre-M1 Apple
> machines and support for SMCs on these machines can be added at a later
> time.
> 
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  MAINTAINERS                |   2 +
>  drivers/mfd/Kconfig        |  18 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/macsmc.c       | 498 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/macsmc.h | 279 +++++++++++++++++++++++++
>  5 files changed, 798 insertions(+)

This is ready.  Let me know when you have all of the other driver/* Acks.

-- 
Lee Jones [李琼斯]

