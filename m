Return-Path: <linux-pm+bounces-20265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964CA0A2D3
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 11:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77623169BD1
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A819046E;
	Sat, 11 Jan 2025 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEt9SZVA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3C24B229;
	Sat, 11 Jan 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736591685; cv=none; b=hrnBkh3HfWev0beZAIc1Tza755rbEKlxwYp2bT3VhjGsdh0W51UPh6i/1RliPJdhYqmTZOFFBFCa//rF7VTdOJBZXst71M5kBqSawjbOI4J/N/i/UllPMR562rw2IWa6KbQp3La8MMqYR/eEVuWtMgmePePv6SIDIXDYc37W7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736591685; c=relaxed/simple;
	bh=fZZO1bOwQFo1CHWDq8ozMF5xVNRUoFfXSFD36dQXts0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blXYU9TrL5CHgTCjyCRRdXdQRUa2cBIe7Bu+xF7viuUVIo1cZraI9fTEZ2d5tLUHPnQRtv9bliz73mexzdNLoaRY3AxwHVXcTElSbHIV7osjiX3cUzv+vK3+9gBhYvCg6tyot9ZmEDV3W6fxy8dJcopJn3wBdSkl014haQyVd7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEt9SZVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E9DC4CED2;
	Sat, 11 Jan 2025 10:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736591684;
	bh=fZZO1bOwQFo1CHWDq8ozMF5xVNRUoFfXSFD36dQXts0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEt9SZVAcsDhaE3khNvA4RArfSbaSsdZOo02A1OVG5A5LcKCD+z/U6fppXTQnqBcE
	 DHTRPht/9CbH5fTgCV3RP2aC2aQnBbtAIAjchoW4TwDAKODiQJSlsuqZpKC6KVCVB8
	 vhmVPlbpWSIzLNt/7ti308tHeIgRKluU/U5Q6CLJofPbYiIbZz1wcqrI32gn6N9bRx
	 Krd1Lnc5GIRl6hEvhc+YqLzIzLiHcFHl3cXCK//sX4UpFDXyDT7yWYTLR1eUkFbM85
	 ghKuyTqPhlWMDEqCucRvvKEwgNnkFOTsPkMWLYaGkmQkVaywRIYxjtg6DNc3QczD4q
	 N5qcXnanbMiTQ==
Date: Sat, 11 Jan 2025 11:34:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andras Szemzo <szemzo.andras@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maxime Ripard <mripard@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 06/12] dt-bindings: clk: sunxi-ng: add V853 CCU
 clock/reset
Message-ID: <tttj7va4hzpqugah4rhm2u5kganuix5iy7373h62b3rgfwvdbt@53vexrsfmskk>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-7-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110123923.270626-7-szemzo.andras@gmail.com>

On Fri, Jan 10, 2025 at 01:39:17PM +0100, Andras Szemzo wrote:
> As the device tree needs the clock/reset indices, add them to DT binding
> headers.
> 
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> ---
>  include/dt-bindings/clock/sun8i-v853-ccu.h   | 132 +++++++++++++++++++

Please use full compatible as filename.

>  include/dt-bindings/clock/sun8i-v853-r-ccu.h |  16 +++
>  include/dt-bindings/reset/sun8i-v853-ccu.h   |  62 +++++++++
>  include/dt-bindings/reset/sun8i-v853-r-ccu.h |  14 ++
>  4 files changed, 224 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sun8i-v853-ccu.h
>  create mode 100644 include/dt-bindings/clock/sun8i-v853-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun8i-v853-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun8i-v853-r-ccu.h
> 
> diff --git a/include/dt-bindings/clock/sun8i-v853-ccu.h b/include/dt-bindings/clock/sun8i-v853-ccu.h
> new file mode 100644
> index 000000000000..a405b982f914
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun8i-v853-ccu.h
> @@ -0,0 +1,132 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */

BTW, also checkpatch warns about this...

Best regards,
Krzysztof


