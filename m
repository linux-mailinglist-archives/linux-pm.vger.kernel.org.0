Return-Path: <linux-pm+bounces-23204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8574A4A4F3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 22:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C7816F72B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 21:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416E91D7E5C;
	Fri, 28 Feb 2025 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRb0gCr+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFD1D14FF;
	Fri, 28 Feb 2025 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777763; cv=none; b=ubwXMaIT3bmGdy+/GEe9mwpA40zxbf+q/RozfSTlJagL+Pt20ilLtHors1MQjelClVhTzY+waKSfOaw+8IlCUnLz4MwVIADJsvfJZCWcN4CiVt0RuCoseD/+aiJTpxG5hf9c9BQQS+e6NybZjUfRz+CaA77QZ9iDROMY5nNO8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777763; c=relaxed/simple;
	bh=19svqh1siOCkpzBHLc+Dj5fHj6/weZnlblQyDcyz5qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhaHVbN3N0ZWUu0yC0UO5ZmFbWgAM4HS2Wkyu8CW/tYIWZo2jk8eVDYOcoDDj8dOWfOA5lM1mGw89Urw72Lrhjzt5f8ihgBHzwH0WDr+DvUMasUDF/kToVw3WBY2W5jM1iWPzeEwAKuUIZpIlmj1FVV2CmK1vMmSoUeR844hXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRb0gCr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FFAC4CED6;
	Fri, 28 Feb 2025 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777762;
	bh=19svqh1siOCkpzBHLc+Dj5fHj6/weZnlblQyDcyz5qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRb0gCr+Eznf0X3ZXRJ5QbKwz7m0tRL6HRxtTf3Dicqf3cikxki3ayi7ca9rTDMAE
	 MnIe0JdjYHOizADibd7yMSDwXjMKdqvKRSxL/1J4+EzEn8hLKXaVXxd5udN/Az4kwP
	 H2X28qW5i+tCHEFWqFmaps7acTnNVlfa2RICUpee1Scp7WEZVaunX4zO5E5zmmEhsX
	 C+kMoSgGvgbhppJ+RNpnUETnFb7mazSlk0Rk1kbTXu7lnWb/9d0nM+0diR7smO96D+
	 r+SzGZVH6DaNMQBSXR1aj4IsDrDDswSZQdkojhDg7QTk3vYGPam7knXVUge6iIfIhx
	 3+4ZVSNbsQHhQ==
Date: Fri, 28 Feb 2025 15:22:35 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: sre@kernel.org, p.zabel@pengutronix.de, lee@kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, claudiu.beznea@tuxon.dev,
	alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 06/21] dt-bindings: rtc: at91rm9200: add
 microchip,sama7d65-rtc
Message-ID: <174077775442.3739270.14568148277019446646.robh@kernel.org>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <27c5b177a41b89c5c983e7e292eb4b321a258991.1740671156.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c5b177a41b89c5c983e7e292eb4b321a258991.1740671156.git.Ryan.Wanner@microchip.com>


On Thu, 27 Feb 2025 08:51:53 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RTC compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml         | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


