Return-Path: <linux-pm+bounces-16443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6910B9AFFC0
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 12:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156201F251B3
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671E31E1C11;
	Fri, 25 Oct 2024 10:09:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFA1E00BF;
	Fri, 25 Oct 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850978; cv=none; b=qMHWiTGW47CwgqLZ1SI7RNHfI4qV+xQIaMP/F5hVqFxi3bz9KBqWJ7ekmiKduU6Qe3y7cBvek0y3idO/RGYzJhvp13uG806D4aB14pGu8uqhj1rbaJzkbxCiUxnelmmxcpvJyStcoj3+VuSYcJOvc7klWEtuOUCPqHy/n3buvyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850978; c=relaxed/simple;
	bh=2vKwd6wWS/n65Df3WGJ4gT9phN2JjJYt4uGnJUT3MYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBqAN38V/wpo5ZNTq5DTH2K9OcU3LdS7JEtbifv1grUy048Zs/AXCG3cGI5ltZiF7UhCIqjR2KHGBv+1lqDuzobMz8d0QWbVUUZx5h9YWi8MEyjRxZsepubAMhBNS8FOLeT4nfGxJmOs3Mw7yyAW+Ny0XlAk/LV2vawI2L7LfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F00F3339;
	Fri, 25 Oct 2024 03:10:03 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8419C3F73B;
	Fri, 25 Oct 2024 03:09:29 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:09:26 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
 <linux-sunxi@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-phy@lists.infradead.org"
 <linux-phy@lists.infradead.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Parthiban <parthiban@linumiz.com>, Yangtao Li <frank@allwinnertech.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Vinod Koul
 <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry
 Reding <treding@nvidia.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Maxime
 Ripard <mripard@kernel.org>, Yangtao Li <tiny.windzz@gmail.com>, Viresh
 Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 04/13] dt-bindings: usb: Add A100 compatible string
Message-ID: <20241025110926.6e033dfc@donnerap.manchester.arm.com>
In-Reply-To: <20241024170540.2721307-5-masterr3c0rd@epochal.quest>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
	<20241024170540.2721307-5-masterr3c0rd@epochal.quest>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 18:05:22 +0100
Cody Eksal <masterr3c0rd@epochal.quest> wrote:

> The Allwinner A100 contains two fully OHCI/EHCI compatible USB host
> controllers. Add their compatible strings to the list of
> generic OHCI/EHCI controllers.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
>  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> index 2ed178f16a78..e00e98dd04af 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> @@ -30,6 +30,7 @@ properties:
>                - allwinner,sun4i-a10-ehci
>                - allwinner,sun50i-a64-ehci
>                - allwinner,sun50i-h6-ehci
> +              - allwinner,sun50i-a100-ehci
>                - allwinner,sun50i-h616-ehci
>                - allwinner,sun5i-a13-ehci
>                - allwinner,sun6i-a31-ehci
> diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> index b9576015736b..6ce81979781b 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> @@ -17,6 +17,7 @@ properties:
>                - allwinner,sun4i-a10-ohci
>                - allwinner,sun50i-a64-ohci
>                - allwinner,sun50i-h6-ohci
> +              - allwinner,sun50i-a100-ohci
>                - allwinner,sun50i-h616-ohci
>                - allwinner,sun5i-a13-ohci
>                - allwinner,sun6i-a31-ohci


