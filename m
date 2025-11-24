Return-Path: <linux-pm+bounces-38432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F8C7F42C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 08:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6F254E2CF6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1542E7BC0;
	Mon, 24 Nov 2025 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMe6OuXO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F727FB26;
	Mon, 24 Nov 2025 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970813; cv=none; b=XbYOyhhUfyWLNQpqpsadjWPHMGAHdbhzCxAlSXyzdTHwmxagaGvsHBqUamCuR7Ks5d3sRRkjxUDA5d0lZJwWW8AljZlY/Mq3XkxNefG6PpMWipX797taSSsZzOHfjUHpDJV5vKT2ScDClkqI1tZBRaBd254ZvuayfaAE2PM7oH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970813; c=relaxed/simple;
	bh=Ba/x+lH0Or0r4SZ7ljSij6gkS+YlackfK8oPM3gblmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpdUVESAAO41PEIfI27OFyGfuAdeynlkbmhtfRX1XNDZ7CzkRBfjKp0WuMJtlNVP0HgsKUDFuiXVTOnuU0pGzooGv5pyFyx02wUfQ7N29/VdKH/LLNy2iVca977/V/QhRM+uaMiwDe3sg74n47b+kGNub0wEla9tP/FAKxxjf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMe6OuXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A78C16AAE;
	Mon, 24 Nov 2025 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763970813;
	bh=Ba/x+lH0Or0r4SZ7ljSij6gkS+YlackfK8oPM3gblmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMe6OuXOUOmehIt+QzEUuw/lQgOX01lWBrHw8vpL6J/fiWGGpnMLr1BKcIMIDklXT
	 nyRrJKO6h1TH1Z/aoAY+kFUdN1w/UG1uldfcdYxD+Q428otXYsspogHKBWLwrLyME3
	 xuDSxuWTo51K2rWpO5QROSuTjtxIOKb0XPIN6obkSiwAh0TWswPy4jQKmKGTR67cJW
	 cQs6u88OOxEsAzLH6Gq41WXJnOPqogyQ2Ojze2NRDjufgVdWriZmeFCkUWY4hMHSlL
	 OZN32NR1OQrSIPORWmGLfOZv2njsgyD1xWXZTzLvoqOJTYIQg/Dqk/qJxFau7YPvNp
	 MUFrgTT33KyKw==
Date: Mon, 24 Nov 2025 08:53:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH 3/6] dt-bindings: usb: maxim,max33359: Add supply
 property for VBUS in OTG mode
Message-ID: <20251124-rook-of-exotic-innovation-fedcc5@kuoka>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-3-6b2e4b8f7f54@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251123-max77759-charger-v1-3-6b2e4b8f7f54@google.com>

On Sun, Nov 23, 2025 at 08:35:50AM +0000, Amit Sunil Dhamne wrote:
> Add a regulator supply property for VBUS when usb is in OTG mode.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> index 3de4dc40b791..a529f18c4918 100644
> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> @@ -32,6 +32,9 @@ properties:
>      description:
>        Properties for usb c connector.
>  
> +  otg-vbus-supply:

How is the pin or supply called in the datasheet?

Best regards,
Krzysztof


