Return-Path: <linux-pm+bounces-31185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BDB0BFA8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 11:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E32A1899FA3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A2288C0B;
	Mon, 21 Jul 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN1h/7cl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865221D5AA;
	Mon, 21 Jul 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088838; cv=none; b=Go3zX4IVPUqMY2Xhs3kW2c/SpuCQUQE07Px4Y/7gFbcG/eR7cH32xU9H0D5aCVAeBfxi4ppTX6/QdQOChwbaPD4c3c1qHS1hkGxOCzj5GIsXo7vhv/7yRbz5xP/lxHI4nDMVXnAMFFi7x4e9GuWQWpd4VOMzkOgAGDOeuigv/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088838; c=relaxed/simple;
	bh=mWbYUZ8RpLg7sOJxNI1MKrXpqhPZ6q61NO8r6g1VBL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0r/KkOl+OLmovvqvcciz5MhVRBWa7sCjW5EhXQ9Y5C6iEWsJoZhHQQD4Z6hIJyAVcyKvmN+gczzxtNf7DvTJpj+f0zHprzNpclaAhKKRbwAu9FHy0Wb5A/uQKH0Fi8K4VBuM6FNreRvwtxR5Z+/8voKwoSCxIr4Zz+tB8o91RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN1h/7cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBB4C4CEED;
	Mon, 21 Jul 2025 09:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753088836;
	bh=mWbYUZ8RpLg7sOJxNI1MKrXpqhPZ6q61NO8r6g1VBL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UN1h/7clLpuilJSIuDW6BgG2LU/Flp/JeMU1x1rxzWje9mT+WqDL3tq35C9NCu1+3
	 J1WWmV1kj+/HeOfsdY7LOxE+f4sX5mA/RowNQ71AM8wE0SF541udqLwfvQGFO+So1z
	 ueMPbao8XuTqLtD1JXIITALW3ZCzf9VfxMsMZIFoG4dyTLURNE8lMGc4P4CRHBfgrD
	 krx70SFQzeY7gVh2pkg44a1G14sa8NB+CoXCwE9R8HIpHxDE1NO9zbpO2w01+WvzGd
	 8kPcK1mGUXCJ+JA2y8fnDIg/BsyZPtQJbFnKC48KdC1HVGpRJW1OUH72brBOGCxJi7
	 Dhn4x7kOQLs3Q==
Date: Mon, 21 Jul 2025 11:07:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nagarjuna Kristam <nkristam@nvidia.com>, 
	JC Kuo <jckuo@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
	Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 01/17] dt-bindings: soc: tegra: pmc: Document
 Tegra210B01
Message-ID: <20250721-logical-lorikeet-of-upgrade-6dce4f@kuoka>
References: <20250720-t210b01-v2-0-9cb209f1edfc@gmail.com>
 <20250720-t210b01-v2-1-9cb209f1edfc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250720-t210b01-v2-1-9cb209f1edfc@gmail.com>

On Sun, Jul 20, 2025 at 09:14:55PM -0500, Aaron Kling wrote:
> Add the PMC driver compatible strings for Tegra210B01

And what is Tegra210B01? Do not say what you are doing - it is obvious
from the diff. In this case here say what you are ADDING, what hardware
is this.

> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
> index 7140c312d8986b0b733c519b1e89e360d9602add..eddcafc2f9398ad6fb4d2d46b3181ab91c89a229 100644
> --- a/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
> +++ b/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
> @@ -18,6 +18,7 @@ properties:
>        - nvidia,tegra114-pmc
>        - nvidia,tegra124-pmc
>        - nvidia,tegra210-pmc
> +      - nvidia,tegra210b01-pmc

Why they are not compatible? Commit msg is also silent on that.

Best regards,
Krzysztof


