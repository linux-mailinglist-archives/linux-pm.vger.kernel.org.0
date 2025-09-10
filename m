Return-Path: <linux-pm+bounces-34423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA1B52354
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF4F1771A4
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399022C2375;
	Wed, 10 Sep 2025 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWmLZEuI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B318FDBE;
	Wed, 10 Sep 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538677; cv=none; b=nIML2zgX/oQQt+aon2XHlGpMcHSEo7qRAssIkckO77ZyV5WJnbvrwi3OzHd77xbzIxhs1hIjWDhSyooZmYzm6FAzI5PbP+DNsFroAnBHvxo4Ez3a/nRdOHMMNbFJ3mK3hJS9WKZV6vG2QSBkbWak0opSg2w0RPA8zgw24py3nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538677; c=relaxed/simple;
	bh=uYOJ00hDbxfZ7PoTwhu15yA05ZdjJwHavqckAn9kWJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqAWpnOMUmNkAg8bagDk/Mcbb9enZBTVedZ8VhTtqo5s+QufTYKhopb1B2vli4FSNhjG/R6fuVB/j0fXdyzyWZpJHXj6qbz8im9LGi2tAF0+XU8uf9HV27jS65GF5zpIakeDwjYXMvoCnEjsRwWDUSnhEVmP+ytZJ6NSGmDJ43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWmLZEuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60254C4CEEB;
	Wed, 10 Sep 2025 21:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757538674;
	bh=uYOJ00hDbxfZ7PoTwhu15yA05ZdjJwHavqckAn9kWJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWmLZEuIfr9OmvUzqUOenDPH2KzmBSo6/YqX9fcEBa2WgoHiRFIlcc28tysrgexzU
	 ESiFzSYIuRftAdX/Nf0GS9cKQa1XhmeXnJu03HJbEBBCq85vK6X8J+HCNm4zXS5a73
	 gx6isX33vvObcw5ygajcAv9JXQbKagc/sD3FFVmrqZ+5eu0aNVeWTPRQqW5ZfTZTup
	 wDBJphd3cftA/51Xa31pde+MiQv1u5xb3T1i2HJ1y1rpwNsRRLGGXEuJmDGcxWZO5t
	 006ITRujbc7XLwiWTfCupkgSU01919wRAyuOSdEXiyVrfoC/xkz4ZchhzcbH8knEGH
	 8PNAqNMntzgew==
Date: Wed, 10 Sep 2025 16:11:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] dt-binding: thermal: Convert
 marvell,armada-ap806-thermal to DT schema
Message-ID: <175753867139.468005.15982827346149015413.robh@kernel.org>
References: <20250822225701.766947-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822225701.766947-1-robh@kernel.org>


On Fri, 22 Aug 2025 17:57:00 -0500, Rob Herring (Arm) wrote:
> Convert the Marvell Armada AP80x/CP110 thermal binding to schema. It is
> a straight forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> v2:
>  - Mention the SEI connection
> ---
>  .../arm/marvell/ap80x-system-controller.txt   | 39 ----------------
>  .../arm/marvell/cp110-system-controller.txt   | 43 -----------------
>  .../thermal/marvell,armada-ap806-thermal.yaml | 46 +++++++++++++++++++
>  3 files changed, 46 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/marvell,armada-ap806-thermal.yaml
> 

Applied, thanks!


