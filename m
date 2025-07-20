Return-Path: <linux-pm+bounces-31123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9BB0B88B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48D23BA9B8
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B512224B14;
	Sun, 20 Jul 2025 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwMZyRzH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF82149C41;
	Sun, 20 Jul 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050294; cv=none; b=cEnDsWmg0a4SPKVZFf1oGerWIUTm3wttdnU9mMQLgd96QUb2I+qCz8gJisg3R78Pj6eWg9evkCQZ5l+DXqPv56dKk9T+YadWUOfQXW7Mf6BOxX4XajjEwQm4uqIDoEixE5oHi6SoUEeDGZYbq9lGdpJMW918hc3KsQK6lpKUcJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050294; c=relaxed/simple;
	bh=XgfkZkVTsBWHGNK/DUKnDVvnKSKl3BJfYseFTKfD0WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs73IXwujLWEAbSrmpW9YI93bDdJLFFDeCJFLXH6h/ZxKSTQ9f7uwPegvNTACI3ubpAb/65Fj2Rv59Io1Hcr64ivszQ0+DthzceVaowt0D1Lkoil27Faib8dXJyMdVjRJ57ogJXqYBoexgKz+Xdyj3ZLFml+v+xGoONc/IjULVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwMZyRzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E24C4CEE7;
	Sun, 20 Jul 2025 22:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050293;
	bh=XgfkZkVTsBWHGNK/DUKnDVvnKSKl3BJfYseFTKfD0WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwMZyRzHNa2nEACfQJaDvMZ41dJ1vFZY4LTsPRYWHfEecaVgs9c8VLKLIaPyB/o8h
	 zMwOqwa9jsQNWlQgVRRu+Qtdh+VrijNIHpMBiwGolucvF89xf28HJMJ+BsSwbardEm
	 ZzJYTcNRD82litNt1pPeHh9OeBg9p9bdwceE4wMpGtt4zk/xVdYnePsz6Kb13H9PA0
	 9+HIjQk1sYsmSZyGpaNMfjB13/Ck5ljGZqQiZ2PcEJszz72exJq/R5FfuIAd38dT+K
	 8g5KauFhHMMoC3jcjAKx8MRy7+3jCA0R9ep3H10Gej2Wd3hs944rUprdenFKieqQPe
	 iQ9mgKQL37yWQ==
Date: Sun, 20 Jul 2025 17:24:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Nagarjuna Kristam <nkristam@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	linux-tegra@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
	JC Kuo <jckuo@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 02/17] dt-bindings: phy: tegra-xusb: Document Tegra210B01
Message-ID: <175305029184.2879831.7158509725744218824.robh@kernel.org>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-2-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-2-e3f5f7de5dce@gmail.com>


On Mon, 14 Jul 2025 23:02:45 -0500, Aaron Kling wrote:
> Add the compatible string for the Tegra210B01 XUSB PHY
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


