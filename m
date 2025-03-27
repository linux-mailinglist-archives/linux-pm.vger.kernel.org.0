Return-Path: <linux-pm+bounces-24552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA3A72B20
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 09:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F2F3B9FCD
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD741FFC7D;
	Thu, 27 Mar 2025 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2BXzZvC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2931FFC72;
	Thu, 27 Mar 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063056; cv=none; b=ZrXoueMGwotBuBMSeHMj2JXD2MDViDKMYpxnA0dHYI3OP3hHokDB50mlzRWi67zROCzXjD/k6u2+iTaZZ2vgDCzH01ABmhl08Bi7qLHtRKvWhcTnRCbql/imGe/2surqbJx9jKb3RUbxo8tgliYGkSZxarx0vL3OVSmpRFmZubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063056; c=relaxed/simple;
	bh=Baey/hKY5HeNZzCvhgM16Y64uCaysLM93MUTBAsSK/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St2kF6Q0Ti+OyTcHHDzo3dhfShh0IaGds6lJoE5kZ5wYejMKUN8bWeU8w11koE027apnLJLHhYwuhvgBhNqUpg6Z0NjflH1xvrjoTMJANunVB32ALD7dHzqy9LicYlHyyI/Mb7gqeC/j8yEO2JtG5EUKUOrLHXdlnXXLR8fvxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2BXzZvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0274DC4CEDD;
	Thu, 27 Mar 2025 08:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743063055;
	bh=Baey/hKY5HeNZzCvhgM16Y64uCaysLM93MUTBAsSK/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2BXzZvCAjK77VxMI8ldwW7U8QzkapYQy+l+RKYxMuIQVQqhs442AMGE/sADpcZHg
	 8F4D/VGF1S7By4eTe7SE+tep1iG3EAX80qTm4uyZFNMNYEHmz8l5HTMO3TLmztP3H1
	 EOCl9y9bK8U4CUmKWc3JmUbYyG5zZIEBQ5Io07GUK6Lwzl7pGZSHxA6l1Nwxv1bDJg
	 Slr6jkQI0h5uMOOb0k7uX5G32VHj8EKF9uysbmhH/1po0KnePVjD5ZgJJWqpUGwUSL
	 QGuNF1WXIY6z70rQUuuX6WGNULZ1M7woMG+mA+SWxL6plj4gAC5PklwJ01MaL3BbuS
	 g4/NbmDN0LkNA==
Date: Thu, 27 Mar 2025 09:10:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	lee@kernel.org, sre@kernel.org, p.zabel@pengutronix.de, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4 07/11] dt-bindings: mfd: syscon:
 atmel,sama5d2-secumod: convert to yaml
Message-ID: <20250327-skilled-beluga-from-mars-b7fda7@krzk-bin>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
 <271b23440f79bfad3e902689a9f4b240ab43eb28.1742936082.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <271b23440f79bfad3e902689a9f4b240ab43eb28.1742936082.git.Ryan.Wanner@microchip.com>

On Wed, Mar 26, 2025 at 08:35:40AM -0700, Ryan.Wanner@microchip.com wrote:
> +
> +examples:
> +  - |
> +    secumod@fc040000 {

Use generic names, probably tamper-protection@ or security-module@

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


