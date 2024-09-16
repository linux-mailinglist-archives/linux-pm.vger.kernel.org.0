Return-Path: <linux-pm+bounces-14338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A366897A43E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 16:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F01B1F286A0
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274C157A46;
	Mon, 16 Sep 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgcZjSOl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E151DFCF;
	Mon, 16 Sep 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497288; cv=none; b=h8N4KtTM27doZpQskAPW499+CpJmsBSlq1dbE13bF9HAP4LjTYA39F2QywqUygOBqZrC+smL1HKlN9wegtWYu7YB+SuCgHWWrJk3rrfi0fCBZ6kufkfRBhh6nH+pEaUMioZad207/faslYhRIVhJTpxM0Wh5Xv/VuwjqNNQRmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497288; c=relaxed/simple;
	bh=rKP5XE1Cxzev0bdpkSJoQcIDN1WayWB5QANq3Evw5I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj5FhjOF5hq1uKpNA8m+hJY4S0YmVTDdt4TNfsImvINzIL1qoRjz7UylFph2vleshOYaO9aZvFyKlPKARXmZdVZknpjiOd2CUInG54lWr9hnRfb6cj5QTeCeHM068WYCPrklZPxtMh1kkYX/IW+wC0cNJCRCVV/aAdh6AvAJ4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgcZjSOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B9C4CEC4;
	Mon, 16 Sep 2024 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726497287;
	bh=rKP5XE1Cxzev0bdpkSJoQcIDN1WayWB5QANq3Evw5I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kgcZjSOlV8Axw0P+F/lyiUXhdh9W8I8BAyduLXG9SjpSfggvAeRAinZazqA1ONXu4
	 F1Fnk7ZqFcx40Ay6nx6JvPWc2t9fzDFz987I0pqQtdhOqcHBmwnVPIjIgI74lr+azV
	 hFhr6Yy18YU8PlImKTI/DHLDVWdHTZ68zrpajRVYtZFY7IFfQzXCpptV+UVUm2Tkhq
	 xnt3egeBP/PJOMYdA9S1wXeyXPiPRIEbsy0+lTf2Xxs7boGZyG247PAzVfP9+Vr8Yv
	 KVEd7WqJ/6whPynnhS3IcIk+9e4oGGKsgNUbkMVm118zPoh2BENwxiNJHpisePY4hE
	 lmPFEzS1hX/MA==
Date: Mon, 16 Sep 2024 16:34:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v3 01/20] dt-bindings: arm: cpus: Add Apple A7-A11 CPU
 cores
Message-ID: <m4hw6wt2xcsgt23fvu7okump62bqhugpyecp3hqlj37x6m4gno@tmui7wdzhs3h>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
 <20240915080733.3565-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240915080733.3565-2-towinchenmi@gmail.com>

On Sun, Sep 15, 2024 at 03:58:46PM +0800, Nick Chan wrote:
> Add the following CPU cores:
> 
> - apple,cyclone: A7 cores
> - apple,typhoon: A8 cores
> - apple,twister: A9 cores
> - apple,hurricane-zephyr: A10 logical cores
> - apple,monsoon: A11 performance cores
> - apple,mistral: A11 efficiency cores
> 
> In the Apple A10, there are physical performance-efficiency cores that
> forms logical cores to software depending on the current p-state, and
> only one type of core may be active at one time.
> 
> This follows the existing newest-first order.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index f308ff6c3532..3959e022079f 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -89,6 +89,12 @@ properties:
>        - apple,blizzard
>        - apple,icestorm
>        - apple,firestorm
> +      - apple,mistral
> +      - apple,monsoon
> +      - apple,hurricane-zephyr
> +      - apple,twister
> +      - apple,typhoon
> +      - apple,cyclone

Please keep alphabetical order. And no, just because earlier Hector
added stuff in reversed order, is not a reason to keep doing the same.

Best regards,
Krzysztof


