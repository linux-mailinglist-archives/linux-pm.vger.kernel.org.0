Return-Path: <linux-pm+bounces-31122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5D6B0B882
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7081884B14
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD721B905;
	Sun, 20 Jul 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzbInYL3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A551C32;
	Sun, 20 Jul 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050246; cv=none; b=brwx8gfmcLN7v7icePxulrtHoGn+NxGIRMuexzL9+6cxj7HXhZF0wyOCrEbtR/FsWL/nykHGL2onnyZ/nKpnb7SGeHnRgAzpGZux8sY6Tyq6ABnhIC62JJI+buRL5QzZz78epbGl9QBqt0sznTwJAqXaEbxGNBjQKXOtQMfDPak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050246; c=relaxed/simple;
	bh=HG0O4JOodWF/vDgzTAePxxVeDT7kVxoEtntKu2wCaac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRy4aHJPYaXgOQ7akmZSNpJdKrRBffdAE9/epNPs/c9jW5oX3eU1TXC5cAc4wmnwM9+wLUnf8IhN+STah9JeofTV8+cOa6VlXYQsGp3Sf6rK7hCxM0erFWhafKeZr4kOKcPYlfnDhp5QggN8MCJTNncamdLn2Xb981qf3UmhPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzbInYL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC9BC4CEE7;
	Sun, 20 Jul 2025 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050245;
	bh=HG0O4JOodWF/vDgzTAePxxVeDT7kVxoEtntKu2wCaac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzbInYL3Deo2hNmkd1b8cBxfvRLr3QbILrPQe1qggEsGZTlDYFQ4zDiQoNiGInbQu
	 i6QBrBx6phXKRGrjeaF5ikl6OF6R6lNZ0hiaIhzCAkdVPSSDgLR43XPXL7OUKjtAKV
	 F7CmcumrPVcxDTNbh8KQiZcgHyoNdH7GjQermkxa6txlnoWQz4RyV29h7c1x+4QwLC
	 BQiNd8bvyjXoxF7g/yXkF1daClIyDquiwy5zoCPo+iIGf4+mNXmq+nnakxcARXKQwg
	 1QGIw4EOJEryuK9mJymdEoxnXdrTVRUs7VfZo9YQ1+VeivNFW16zgdmx6C22Id2aOx
	 skxVsySk8rSEQ==
Date: Sun, 20 Jul 2025 17:24:04 -0500
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
Subject: Re: [PATCH 01/17] dt-bindings: arm: tegra: pmc: Document Tegra210B01
Message-ID: <20250720222404.GA2870388-robh@kernel.org>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-1-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-1-e3f5f7de5dce@gmail.com>

On Mon, Jul 14, 2025 at 11:02:44PM -0500, Aaron Kling wrote:
> Add the PMC driver compatible strings for Tegra210B01

Subject should be 'soc' rather than 'arm'. Otherwise,

Acked-by: Rob Herring (Arm) <robh@kernel.org>

> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

