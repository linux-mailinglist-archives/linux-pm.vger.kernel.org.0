Return-Path: <linux-pm+bounces-3560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE384D12A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 19:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85311B22E36
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A2683CAB;
	Wed,  7 Feb 2024 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x3rt6cgJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBA54645;
	Wed,  7 Feb 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330429; cv=none; b=SrUl6kP19jmPxVrZZnf//IbWKlP3Ge6j4NhQVLvyOdTq0jcVSv+Z6ZM4ccegtTfhJQZBOWfv7uhGtWV3H8oXDErDXRv7vt49wl6w1VR58qr9pOE4dDNwuEIuCXn2pYjRnoLdOUm9TxjH73IXUa4r3KkhyOQsTYTHUmbYEcU6e6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330429; c=relaxed/simple;
	bh=p1ujltCiO7Se357FqvLg+IEoA+MNrfIRkGUflqJcyvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8SfQ/YCazkmHnn/V5jtEVWMZ4FsUlEjXsAi/MmwLKlma6FzUCwbZmjlFZ/xj6wTMExaa+VSQD7NLQdhc21IOXapYuygLQws+MgA1ggneLGHloYX4maapEfXDFQpU1T23vOXx7SRgxEiZq29THWGnY5UA8gWwtDNfiW6TGi15kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x3rt6cgJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Hl/DgXvZgBVzSrTa1EvNhL2NH5ozYGDaYquJZdrGqWc=; b=x3rt6cgJJo1kYd+iobg4tND943
	g87m+Idp/qPzY5UnWQ5Q9V6rKrG1dxMEm7ntata8dQZvBVl7LRztAZSAn+5idTxdbujU9o+jRueWy
	2k90xm8nftpetm/5EgZFbxVJfjBYuabbwKpoaaXvJQk8OVBaNkd7dQDDTrY77NxCeWac=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXmdK-007F7k-Tu; Wed, 07 Feb 2024 19:26:54 +0100
Date: Wed, 7 Feb 2024 19:26:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
Message-ID: <d454015d-7c38-4fd8-839f-13d72d041d53@lunn.ch>
References: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
 <E1qA7yZ-00Ea50-OC@rmk-PC.armlinux.org.uk>
 <ZcOsjRzE8V73wNtT@eichest-laptop>
 <13ab003d-7449-4d6f-861a-fa2d0c3f4ad2@lunn.ch>
 <ZcOwB5xShhRoX5yh@shell.armlinux.org.uk>
 <ZcO0AAzK+P8sYHdX@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcO0AAzK+P8sYHdX@eichest-laptop>

On Wed, Feb 07, 2024 at 05:46:56PM +0100, Stefan Eichenberger wrote:
> On Wed, Feb 07, 2024 at 04:29:59PM +0000, Russell King (Oracle) wrote:
> > On Wed, Feb 07, 2024 at 05:25:59PM +0100, Andrew Lunn wrote:
> > > > While working on some thermal optimizations, our hardware team
> > > > discovered that this patch is still missing upstream. Is something
> > > > missing or did it get lost?
> > > 
> > > Patch 1/3 had a change request. Was it ever reposted with the
> > > requested change?
> 
> I forgot to mention that the other patches were applied, so it is only
> the one missing without change request.

Ah. O.K. Repost it to the MVEBU Maintainers.

    Andrew

