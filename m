Return-Path: <linux-pm+bounces-31126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8AB0B89E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B7E18850B4
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F55F2288E3;
	Sun, 20 Jul 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHBEAI8E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095752264AC;
	Sun, 20 Jul 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050335; cv=none; b=YNPq7+xJy5PUufqbwQcxhcodm3BxflRz+clXLRqDnNc57HnUBIdrzfiU5oSKnRTCaWCPD+t3S4nALlE397WF/eaKdIbinPdbO1jAhFswB5DC678Qr1koBEYa6B2neNfYxxjuO5JGKki59BiMrRmX2VaFoh6BlAUw4IzXYgINiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050335; c=relaxed/simple;
	bh=xEKMbYY0zaWDdsbFDuSSufbmqhhv1AlaEIvCRIi6nOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1ULKZ+QTa/UnoaeN8rDlScFmNJ3wTwiXFlC8Tk/LsSrQRyb4poawMqFMHfVluccTqJZwkoCtrfjEUWzhWMynUj62XGwK/bSz1dmDFHsgrUHKfkHeLeoBgA71bwTD+G3Ae9IfwsVaE0Rpv0UWsZSaJsm26CFoS8lCEM+qCz1BzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHBEAI8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7D0C4CEE7;
	Sun, 20 Jul 2025 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050334;
	bh=xEKMbYY0zaWDdsbFDuSSufbmqhhv1AlaEIvCRIi6nOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHBEAI8EuXTcKAUbUNLYZQynQMwZvxekWlJUFjsC7y9ZSlzBD+BbhIMyr5/WCak74
	 b579euo9O1znuZaph3kTLrI4/ucS7h6Kzh90tsCdImgVQ+jlqFmxeCvwjCMM1zFSIm
	 pppojdgVzNAyDhCEbmsi+/BlPpxCQANGE2A9LPfK+oex+twCSEqmJo+Znheg3uaT1C
	 M80CCUEZmzJiylpUwSdndqoD1pKr2lqqxYsFUAXwcYyHVTOZWVCCQPtnB6lZj8HvgI
	 qzFFuP75T+GiEALO6BW0wQWcX6EiK++R5F8n+n277w2MAgz4NSG9t0Y0Mj/CXwSSW+
	 Vk0YfFeThBDSw==
Date: Sun, 20 Jul 2025 17:25:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-phy@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Prashant Gaikwad <pgaikwad@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
	devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
	Nagarjuna Kristam <nkristam@nvidia.com>, linux-clk@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	linux-pm@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/17] dt-bindings: thermal: tegra: Document Tegra210B01
Message-ID: <175305033354.2882962.9580555513553894662.robh@kernel.org>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-5-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-5-e3f5f7de5dce@gmail.com>


On Mon, 14 Jul 2025 23:02:48 -0500, Aaron Kling wrote:
> Add the compatible string for Tegra210B01 SOC_THERM
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


