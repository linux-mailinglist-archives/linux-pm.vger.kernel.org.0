Return-Path: <linux-pm+bounces-31130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D251B0B8D7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA3C17A4CA
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137AF235BE1;
	Sun, 20 Jul 2025 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgGCmdd5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F622FF59;
	Sun, 20 Jul 2025 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050621; cv=none; b=MJCHynYMn6VcbY3L8rVdYZgJX/L76L+27BFwf7uywQ/+xHKpgNmdzbmxsbm1S8EdVQy2paad/TqPiF1A7WRqGusLC7FI4JXD8tED52qPSUrkdlO2M7rDbfksoEd5CUf6S5uZOrl0AVuGVXVmEpwGmLPGGJwV/2p+PlRK5/j4uEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050621; c=relaxed/simple;
	bh=qEgD4I5cBb5OU+UR2RFNbERDweiq78XewGziHT97wpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AupLp1rRhM8m3+VlnKpf2UtYem+R+xmCiFmblWrOJRnKx/vYCXRda4eFRF/vRpS97CBvZYebafG27qkeEUN+Wmv50B7A6WJEZeLb3G1rBxeAv/61LzBro4TvHHN09vUtuZfK8+ugzSo2FB2lTgm7urWUdupEKWmkGca68NJRvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgGCmdd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295C6C4CEE7;
	Sun, 20 Jul 2025 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050618;
	bh=qEgD4I5cBb5OU+UR2RFNbERDweiq78XewGziHT97wpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgGCmdd5phGtW64MqYleOa4hyq5Tde/Sy8A4/tJxII4stWb7IxX/Zk+23Nw5Kdxo0
	 1N0xqc2ZdUk3wdZe5GrQ+FmRSYHjjmLmfOd/w2p5qEO5cfFZrsz+uhzLoenJB5EZYr
	 pLRlsrm78TjlclZUMn/b75sRM4dUK0qhJ90ElYoA6d+5ubDKnWQPar44BQ3eDzItVW
	 h8lsAsxacvc0MDcewnKDnh05MNji8iZe3DEVLiMf3vmg7AT5iP82jzmOpmM4lKLJcj
	 3rj3/Zd8Gsj0Vy44tlAJEDQ4ifbaAgU75K2xIBrtml2Lo+mQzS3N5b5jAydAVpJ1P9
	 2gQzqtWM+ZAvw==
Date: Sun, 20 Jul 2025 17:30:17 -0500
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
Subject: Re: [PATCH 08/17] dt-bindings: tegra: Document Shield TV 2019
Message-ID: <20250720223017.GA2895524-robh@kernel.org>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-8-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-8-e3f5f7de5dce@gmail.com>

On Mon, Jul 14, 2025 at 11:02:51PM -0500, Aaron Kling wrote:
> Add the device tree binding documentation for NVIDIA Shield TV 2019
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/tegra.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
> index 9cae3268a8274fd3a38580939c79a6f21de48a3f..806190233b9859ad573fe43ac5104887fbadf428 100644
> --- a/Documentation/devicetree/bindings/arm/tegra.yaml
> +++ b/Documentation/devicetree/bindings/arm/tegra.yaml
> @@ -174,6 +174,11 @@ properties:
>                - nvidia,p2571
>                - nvidia,p2894-0050-a08
>            - const: nvidia,tegra210
> +      - items:
> +          - const: nvidia,p2894-0050-a08
> +          - const: nvidia,darcy
> +          - const: nvidia,tegra210b01
> +          - const: nvidia,tegra210

Description? Because nothing here says Shield TV...

>        - description: Jetson TX2 Developer Kit
>          items:
>            - const: nvidia,p2771-0000
> 
> -- 
> 2.50.0
> 

