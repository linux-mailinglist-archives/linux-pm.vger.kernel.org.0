Return-Path: <linux-pm+bounces-3557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D840884CEE1
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 17:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6C8B248AE
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E01E532;
	Wed,  7 Feb 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A2fFEHzd"
X-Original-To: linux-pm@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A41E498;
	Wed,  7 Feb 2024 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323427; cv=none; b=LxPkpXOUR1MladWZBBctQurC8/KldDri/h9oEYLIHE4iKdY/R5A25unwYjO3CsBLkNTwyuUxqOXyk5QAVCQwH0uQGMuN+hpRIRI/hoeq1teJ3gA4nhTElMGIFMnPo5EEgI8p7Q/fp3QXy391C24mo5rBT91JAKUttVUFVRrBsLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323427; c=relaxed/simple;
	bh=Y3MiFi68RsW2/1W+DBqh4ihCSs9a/UvoIieVZEb0uLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAXhMiDpv5SRsABC1FETBx8GwClreX8ok8Cft5iIyphY/HtbgBdyLlnSPZ8/ztBJcoeTRmF76yC+c/3wzk9ocwAnQdR04BhpYdHjZeAj6BHheaEx1x47UnNua5/GsPr7F9yHibvm7x/mJtkoE3odDIP1mxwsqOmc6TYbpQUj+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A2fFEHzd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4QIMtO4mEbZ+/EroEk3hCpatB1zGAhkEKqF30slxxyQ=; b=A2fFEHzdmvO0xzVPZ6/FZzSslZ
	EonrbHtSYj15PeEUv4eTqczy9L+I20OUpaZmadF/jPn/5PY4Jw+6BjtPnVCb2pjR8PIdU8vi3Vkaq
	mMIVedT5tMGssphNmjCtLGOw0w9F2Gcdk2qVJPv2FPfR3Xw4jeADa3R7Z8crhg4XuXSQFNroJV5PD
	Ff8CCMy6LsLixGmx8kBcDZmEpEQB09jXTscxD8aTvgQuun4jntr9Fv3qEwk5R04yaupxn4yPNyQNL
	xVh4Y1WHDAhVHFinyCtYBheNpav4SnU/R9qLPImA0la1mkHZ9ob/eW8Cmfz/JuN4NAGzEEh0JzbZK
	v1DQs8Lg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42404)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rXkoH-0003Ta-2X;
	Wed, 07 Feb 2024 16:30:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rXkoB-0004im-CW; Wed, 07 Feb 2024 16:29:59 +0000
Date: Wed, 7 Feb 2024 16:29:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefan Eichenberger <eichest@gmail.com>,
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
Message-ID: <ZcOwB5xShhRoX5yh@shell.armlinux.org.uk>
References: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
 <E1qA7yZ-00Ea50-OC@rmk-PC.armlinux.org.uk>
 <ZcOsjRzE8V73wNtT@eichest-laptop>
 <13ab003d-7449-4d6f-861a-fa2d0c3f4ad2@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ab003d-7449-4d6f-861a-fa2d0c3f4ad2@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 07, 2024 at 05:25:59PM +0100, Andrew Lunn wrote:
> On Wed, Feb 07, 2024 at 05:15:48PM +0100, Stefan Eichenberger wrote:
> > Hi Russell and Alex,
> > 
> > On Fri, Jun 16, 2023 at 12:50:47PM +0100, Russell King wrote:
> > > From: Alex Leibovich <alexl@marvell.com>
> > > 
> > > Use the correct thermal coefficients for the Armada AP807 dies.
> > > 
> > > Signed-off-by: Alex Leibovich <alexl@marvell.com>
> > > Reviewed-by: Stefan Chulski <stefanc@marvell.com>
> > > Tested-by: Stefan Chulski <stefanc@marvell.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> > > index 4a23f65d475f..a3328d05fc94 100644
> > > --- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> > > +++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> > > @@ -33,3 +33,6 @@ &ap_sdhci0 {
> > >  		     "marvell,armada-ap806-sdhci"; /* Backward compatibility */
> > >  };
> > >  
> > > +&ap_thermal {
> > > +	compatible = "marvell,armada-ap807-thermal";
> > > +};
> > 
> > While working on some thermal optimizations, our hardware team
> > discovered that this patch is still missing upstream. Is something
> > missing or did it get lost?
> 
> Patch 1/3 had a change request. Was it ever reposted with the
> requested change?

I don't think so, it's just another patch series of many that I have
that's basically low priority, and other stuff probably overrode it
and I then forgot about it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

