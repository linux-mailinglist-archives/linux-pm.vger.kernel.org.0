Return-Path: <linux-pm+bounces-3556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C4684CED4
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0AFB23536
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CB811F5;
	Wed,  7 Feb 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1GZlapcC"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5BE7FBC9;
	Wed,  7 Feb 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323177; cv=none; b=OoKMSaV1tFARUM/nGBpuMcXtk9Ku0VjLX9hK5nJct1SjR4i+m+fjbfWfI4aN+2tW3hTLbqrEz9jZ1cqzArRZ0hAv6+SatE7K2YdYJd37FsK2MsxJKgIBAFzgja+yAuHSjRkx8479ZiHZvuwLrkhmr5XjyToeIqkLDoat2qF4uQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323177; c=relaxed/simple;
	bh=+zhFNcjljO8eUyVnHueReZfjxF3E9Yj+utWHBJpYqOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUqsmlrRpkAosSUAOkO+jOWltakJ5+TQXOHKU6GWnob+NV9N3F7iDO73ti5bgyRJZXAkvEPKz8JDLrEq8zlJafNl9Fgnj7any6SYfWEAyQWrksr+ioEoyHQ6PCSmYpGMwlSFsWeyPqAlGGbpH9Gn8X1cCnGWpmp5d+bcaTCuh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1GZlapcC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GLB4Ak6omxg10pAPnfsUZTWUGvkbetcGVG9XYnbeFWg=; b=1GZlapcC3AQBLQ9iaiP56L3xX9
	qKgt8IHRc5BuUBRepOXQWlq74JaC2+FlXv7/WCXjrZjWJUSSG5p6ScTUMTuzcv/EmX1ZmvM6IENZV
	uQAx+fTw9x3jr05eBXhzM15jKOdJ33APCvZK0ZWgBbYZxcEp0qST6dE+r/PO48LOj+Qo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXkkJ-007EfN-Du; Wed, 07 Feb 2024 17:25:59 +0100
Date: Wed, 7 Feb 2024 17:25:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Amit Kucheria <amitk@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, Josua Mayer <josua@solid-run.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, manuel.aebischer@netmodule.com
Subject: Re: [PATCH 3/3] arm64: dts: armada-ap807: update thermal compatible
Message-ID: <13ab003d-7449-4d6f-861a-fa2d0c3f4ad2@lunn.ch>
References: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
 <E1qA7yZ-00Ea50-OC@rmk-PC.armlinux.org.uk>
 <ZcOsjRzE8V73wNtT@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOsjRzE8V73wNtT@eichest-laptop>

On Wed, Feb 07, 2024 at 05:15:48PM +0100, Stefan Eichenberger wrote:
> Hi Russell and Alex,
> 
> On Fri, Jun 16, 2023 at 12:50:47PM +0100, Russell King wrote:
> > From: Alex Leibovich <alexl@marvell.com>
> > 
> > Use the correct thermal coefficients for the Armada AP807 dies.
> > 
> > Signed-off-by: Alex Leibovich <alexl@marvell.com>
> > Reviewed-by: Stefan Chulski <stefanc@marvell.com>
> > Tested-by: Stefan Chulski <stefanc@marvell.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> > index 4a23f65d475f..a3328d05fc94 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> > @@ -33,3 +33,6 @@ &ap_sdhci0 {
> >  		     "marvell,armada-ap806-sdhci"; /* Backward compatibility */
> >  };
> >  
> > +&ap_thermal {
> > +	compatible = "marvell,armada-ap807-thermal";
> > +};
> 
> While working on some thermal optimizations, our hardware team
> discovered that this patch is still missing upstream. Is something
> missing or did it get lost?

Patch 1/3 had a change request. Was it ever reposted with the
requested change?

It would also be nice to convert the .txt to .yaml. The DT Maintainers
might insist on that when it is reposted?

      Andrew


