Return-Path: <linux-pm+bounces-31125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E25CBB0B899
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F797A4AAD
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721222A4E4;
	Sun, 20 Jul 2025 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK0Pfe50"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE822425E;
	Sun, 20 Jul 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050313; cv=none; b=h+XgO5dPf0ir3pdaz977mKAIRAsHV/4W8Qg6Tcd8k0uLRAao5v6bNyGiE2Pd+Jd2ziAe1dnLzB5Z4bvBiokgfaq5aKRCg66Lm1mf8vPYknQofRwcT6H9ROTXrdfQYDbnhF1HpCvIhaGafeAMluQXu9vqHgvqFaVSpYbqZZXaQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050313; c=relaxed/simple;
	bh=SVtZKrT8Uv7Pq62Z+OZUeFY5hmtzK1BRdW/3iHO4MBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfsW+Zwt9CWWqBGb2ucSnuJK6nht5MqLxyzNyXK3rmIXnjRRXH3XKOy0ksJoN2qzU/GNwBplPx5asKD/9gRxPlZH+yjBtoc4Nr7TjWoUQ5Rlyic0Rf9egLSRjVhx4s7WwekQFB7e8fZZNn6Xk6N2BfnoWru4rttV6m1tHJF5V5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK0Pfe50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93132C4CEE7;
	Sun, 20 Jul 2025 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050312;
	bh=SVtZKrT8Uv7Pq62Z+OZUeFY5hmtzK1BRdW/3iHO4MBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hK0Pfe50uHeSoVQPNMMZ7ld9Ucf7F3XuCXDide0g6uk/vkCVxV7td4CLCyvTuVbQU
	 O8FcfF896QaWVKJU1+p6N3jXofZfGtRZpBkqGlOGFt9eq4MTkWnVcdjgOdhto+huJN
	 TLXIZFbcZVbKfzHD4xNJWth4XC82HeBW4LigRaeMAUikI19+Qz7ZmCoKr3Da8iIVWR
	 H1eKwPl3P9IR15JT8vsuz0PnTULCn1mpOVo6Tt4t/BR7o1ZZSgnVsx2048sV67BZ35
	 WuMP3RxACcuNTT0mPvPT6OrwTEFcvzEVlyNEcuojEKzCQFiitxkeWn9OQZesKAxRuZ
	 tnr+hm3WMhTAQ==
Date: Sun, 20 Jul 2025 17:25:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	Nagarjuna Kristam <nkristam@nvidia.com>, linux-clk@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Prashant Gaikwad <pgaikwad@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-phy@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: Re: [PATCH 04/17] dt-bindings: usb: tegra-xudc: Document Tegra210B01
Message-ID: <175305031152.2881707.3780039498712332275.robh@kernel.org>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-4-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-4-e3f5f7de5dce@gmail.com>


On Mon, 14 Jul 2025 23:02:47 -0500, Aaron Kling wrote:
> Extend the Tegra XUSB controller device tree binding with Tegra210B01
> support.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


