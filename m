Return-Path: <linux-pm+bounces-16532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A029B20DB
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 22:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 276B5B20D2F
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582C187550;
	Sun, 27 Oct 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhZb8jOA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D76186E27;
	Sun, 27 Oct 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730064175; cv=none; b=nKA5XwvzxB0hmxNAJaX3UBaxpqE5n3QZn/GNHUVnvJaWxTRfc4qzQNyCpde6iKTJazD+/CiRBVvg25O5/jK6dn5zbTdWSS0B9K57NI7QvlgqOyU4cat3RdjdnzIBSWlawm36ZAatFN9BlkwQElwHuGcr6Xv7wa8uaTF5l+fa1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730064175; c=relaxed/simple;
	bh=uGeF6fhJYsqOGnMmd6g0ql7+lc90LCLzjPxmpQyJ48Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/LLRS7Ug9jGf/SyOtZGzZ7Qnv2WOFkVVRI0J62D5IOTJjrrJB3hslYzlOggZ6BDJG/dycdQAD7Q+9+mA8qZ9qtiEYFyMv2h76L4xpxQsvps4fktajHKbDcML1HUjbcu6vC4zlAvYIs5njh1moQ0LTBuFktTiRvwwU1A6TRLkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhZb8jOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B199C4CEC3;
	Sun, 27 Oct 2024 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730064174;
	bh=uGeF6fhJYsqOGnMmd6g0ql7+lc90LCLzjPxmpQyJ48Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhZb8jOArLdcBAtkKDB0KQ7NICYF0jo3qvjleBFXtQ739hnWxUoLMc1jWvLU4rnGM
	 zxtoNtukh3Kdzp6+gfkAmNHVi1QB9xBblRH3AdI3IxYsJ0t5D0Mgz7Ctjn7og225JH
	 XLIxjOtOt8yTX1r04qHOziBulN7PIBkxSxjNkG0/6fZZK6brTlUfoG3aTMPaMwdLTG
	 suF1nexrEhEAMf0t9AzsNRJ3e0miozS7w4+yD7mpfl/9GAWyMZveE3GMj5rYKp4YHC
	 RpuVQht9dtvEg2byV8o5VFISquOuvBd0c+AzEPQFP8Lzk6wKjWWBR/GeZ1Bme347o4
	 mMUC9KYCUXA1w==
Date: Sun, 27 Oct 2024 16:22:53 -0500
From: Rob Herring <robh@kernel.org>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-sunxi@lists.linux.dev, Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
	Yangtao Li <frank@allwinnertech.com>, linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Parthiban <parthiban@linumiz.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, linux-usb@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 04/13] dt-bindings: usb: Add A100 compatible string
Message-ID: <20241027212253.GA98977-robh@kernel.org>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-5-masterr3c0rd@epochal.quest>
 <173006354857.88418.13246529686874362124.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173006354857.88418.13246529686874362124.robh@kernel.org>

On Sun, Oct 27, 2024 at 04:12:29PM -0500, Rob Herring (Arm) wrote:
> 
> On Thu, 24 Oct 2024 14:05:22 -0300, Cody Eksal wrote:
> > The Allwinner A100 contains two fully OHCI/EHCI compatible USB host
> > controllers. Add their compatible strings to the list of
> > generic OHCI/EHCI controllers.
> > 
> > Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> > ---
> >  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
> >  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Well, except that the compatibles should be alphabetical order.

Rob


