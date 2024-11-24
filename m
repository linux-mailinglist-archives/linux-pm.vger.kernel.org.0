Return-Path: <linux-pm+bounces-17998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FED9D6E00
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 12:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C873B20F03
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7466813B59B;
	Sun, 24 Nov 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLZSJ31s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49206F9F8;
	Sun, 24 Nov 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732446198; cv=none; b=ewvmPHscCmliiTwOpzagOOnl5pmxngvUryniFRGRqfmXSxaOFA5jW4QSS+buLyLaeLY5DjyOwP4sCcT0a77bVGNVPIoUTsKq8pTVFK9deLp+5c/q9VcvMWZlkFwEJl0FOTWvyKQRoK374n/8UEg5rdMR07vEtNKLS/dcyiolDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732446198; c=relaxed/simple;
	bh=EfW2avhhyK3SyPtpaAqnOLD1oU9lkffmDg7NK1/wkew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWuzd9b1Slu2zyfOTPTOMvp2/xqgFd7jBJNj5WxnHYn8c3bxhR4f1TcpsVEDtOWDqFzCHEQDwiS33iz8RZmGm82zLe2mZCif9ecrS0OFmFvYhbzeNP94KjiRTnxQsP5fpG5Y2cT/563U1/odLoEiJFtqsA6qds8ZlFZAizQ3o5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLZSJ31s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371F5C4CECC;
	Sun, 24 Nov 2024 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732446197;
	bh=EfW2avhhyK3SyPtpaAqnOLD1oU9lkffmDg7NK1/wkew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLZSJ31sxLHPX52vcluqFRHNKkJJAlRfqWlGEmoLMJ1+j/cuVlhPgaxXoJ6qLP5wh
	 Iy/YUKzz5O7sKsMSTJKfoJ/2w7YOnZoDV5UP7sf9w6zWHyRQCl2SB8fWlgnX1eBlsd
	 456LbUFs4zhVaB4RL50pABi05FedCNEbeIe/VG9P9i4CbUfw5qOLM7L3FJ4YxPk3cg
	 L4wi2q1lhWrx3PpNh5AEKw34P/N/FgWNg2ViWhG8W3BS/STVBU3HPEpagfonPP4XZm
	 XOEgXROvuQBc0Eww2FRbgGkT367bzq+FqclL+jIkJmsyk66MASEVpIeZUMWRk7RcVL
	 bq4IQYm3vm0ug==
Date: Sun, 24 Nov 2024 12:03:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: power/supply: Add ltc4162-f/s and
 ltc4015
Message-ID: <ax7fbdlm6a2ysqkiwi54bf5jr67ynavphu2cw6o37x6co43xz6@3znvedsd6vrq>
References: <20241124053643.6602-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241124053643.6602-1-kimseer.paller@analog.com>

On Sun, Nov 24, 2024 at 01:36:42PM +0800, Kim Seer Paller wrote:
> Add LTC4162-F/S and LTC4015 to the supported devices of LTC4162-L.
> They share a common set of registers. The only differences lie in the
> resolution value of the scaling factor for battery voltage and battery
> current measurement, input voltage, and input current for different
> battery chemistries. The differences also include the calculation of
> setting and getting the actual voltage applied to the charge voltage,
> as well as getting the die temperature.
> 
> This add compatible entries for ltc4162-f/s and ltc4015 and include
> datasheets for new devices.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


