Return-Path: <linux-pm+bounces-31127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF0B0B8A4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EB118888C3
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46F2226D1E;
	Sun, 20 Jul 2025 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktL/B8Aw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8D1A2547;
	Sun, 20 Jul 2025 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050428; cv=none; b=rtcmxc8x2QwL5PKiRhlMiGcANXmQcXXomTjWm/LKg3EBHVxmhO9yYAc7coD3QbAXpNXgwTsqCkwkAmvMrH7Qvoe+WKPN6PXbP2JV8sLkPpYqj6H55vRTWz9oX+csUGK82PPYlGhX9+eFqpx6WZszgdG18tPRCFZhHED3Ae10rYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050428; c=relaxed/simple;
	bh=XFoJ+QoeylaVvKszHW/UiA61y62McXiFRBHLIfspD0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIvfzjWgySjrNA9/akRCQs0SNFvN9hM49+9pfY9IH9dxC2BfGSD6CzocMtWTGtTn3aKT8LcwyK1tIdBmtiSlEvdr0eC+OoQVWTPivL+fpIq2NNp92RSBHXMAqYf3h6TiVMYdY+9cXdrHMzVe7VJ/ybMREmf9R286mpqBuJyytkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktL/B8Aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0752CC4CEE7;
	Sun, 20 Jul 2025 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050428;
	bh=XFoJ+QoeylaVvKszHW/UiA61y62McXiFRBHLIfspD0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktL/B8AwRIaVBNzeALVYazb7pnEKq1v1AC4nsXLsBZZSxHOLCpgu5klPeinOzvB0Y
	 /9ZciO8WJ5om+fW5dYlFuqaEnQHs1OKvBZYR6UwKNgxLPMS+0W5ohM+j3mvQzCIaNX
	 feXi9rpccajyFE001GoRDn0pNtsIpRftqm78i3/FBfu+PAaKqzXQqwwCJ9IqHehuPO
	 n5OxUX8o+mGCOXJYNFMicvrbaCbIaUjbKwm1wcNljK/c0+l8yRSwWGb7OHFV234tJk
	 JZwuGV4TI4NWXVfqXVP+Gjx2R5nguyycy0HKKjjk4LVK1Nhv8wd3g3LmjBwvEgoz6n
	 B78I7m57R66gQ==
Date: Sun, 20 Jul 2025 17:27:07 -0500
From: Rob Herring <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nagarjuna Kristam <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 06/17] dt-bindings: clock: tegra: Document Tegra210B01
Message-ID: <20250720222707.GA2885707-robh@kernel.org>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-6-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-6-e3f5f7de5dce@gmail.com>

On Mon, Jul 14, 2025 at 11:02:49PM -0500, Aaron Kling wrote:
> * Add the compatible string for Tegra210B01 clock and reset
> * Add Tegra210B01 specific clock bindings
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml | 1 +
>  include/dt-bindings/clock/tegra210-car.h                        | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> index bee2dd4b29bfe391caee346aa5afad49772c2c41..88cce500bbc43de934f6c56152e5b2d006f8a8bb 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> @@ -32,6 +32,7 @@ properties:
>        - nvidia,tegra30-car
>        - nvidia,tegra114-car
>        - nvidia,tegra210-car
> +      - nvidia,tegra210b01-car
>  
>    reg:
>      maxItems: 1
> diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
> index 9cfcc3baa52c6eef0439c859200cf44446a1cd17..27485d9b80f68fc0e7668a8abbd1b821f62035dd 100644
> --- a/include/dt-bindings/clock/tegra210-car.h
> +++ b/include/dt-bindings/clock/tegra210-car.h
> @@ -409,6 +409,9 @@
>  #define TEGRA210_CLK_DMIC3_SYNC_CLK 392
>  #define TEGRA210_CLK_DMIC3_SYNC_CLK_MUX 393
>  
> -#define TEGRA210_CLK_CLK_MAX 394
> +#define TEGRA210_CLK_UTMIPLL_60M 531
> +#define TEGRA210_CLK_PLL_P_UPHY_OUT 532
> +
> +#define TEGRA210_CLK_CLK_MAX 533

Generally we've been dropping these max values because they are not part 
of the ABI if they can change. I guess that's a separate change.

Rob

