Return-Path: <linux-pm+bounces-32012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F8CB1C6FD
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 15:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE3A3BA3A3
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF028B519;
	Wed,  6 Aug 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HIj33Esb"
X-Original-To: linux-pm@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B0A23CB;
	Wed,  6 Aug 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488166; cv=none; b=D/Y5kAjx8YZ5tbJ+6fmoo851NK8s3R5VvYig1UxpdgEAo5OhzRV+WLvTxxqIiyAU+raGUm7FQDt4ZQCjhfMqmN8ovpk3IVC2/5SnO3sIgKFl2tBK2E7RuTiCqPDFu+zHIUEgadXj7sLBCE/BLCohV47khhyfppvVfx5Mto95n4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488166; c=relaxed/simple;
	bh=EZOPf18f1ehT/pYeALbvj9ffOHKrv9bhpiMWGVx09fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaMqVX1pLtVNAI6TX447khGTmBL0FWGNYbItw8vz1n+uu3yNH7bjhD0nRLWNU+U8uDjwYGO0Ug2QvGNOS7DZP2I5b1+jgZhBQjxlyeI/iW2aQpBGADsrYpJdXI3N48tL01lW/zkMC/ms4t6rdDivcPTdvzJ0ycBnw5HvPJv6Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HIj33Esb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hx75GfJBE17gahFtByj409jMkcTDImb3a5kJ8Lf/J/o=; b=HIj33Esb5PfQk7IBwUmIlHkHUA
	LRuy+nHOQx2DwWZCk/jisqrsCt8fo5S8Jx/N+tYAAJKTWiLXwROaNNmqInc9CviRg+tof3dzGs5df
	tcaakCTGvzKPOHUt37VX4VWBIJ7ljBcud31mWEagk93ylSie7vhn0KKS+ZuX3MU+jiJfUZ+h0hbQi
	AEJYzuP68hqbqsRS/o0ARTZSSW3K5taUDByDOaKPBHdQeZ6idA4TwSfkeTO143/Mf5Qk/ScIqS6y4
	FfNbZ3L41f3L5G9icNbagOYuj/QeTQ5IG/KYt5CUa+DuFW1MwxPXdRYRBTXj5piPS85kyD3WjjYWZ
	L8TU60yQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ujeVb-0004cA-2P;
	Wed, 06 Aug 2025 14:48:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ujeVV-00079n-1X;
	Wed, 06 Aug 2025 14:48:41 +0100
Date: Wed, 6 Aug 2025 14:48:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, peng.fan@nxp.com, richardcochran@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, frieder.schrempf@kontron.de,
	primoz.fiser@norik.com, othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Frank.Li@nxp.com
Subject: Re: [PATCH v8 11/11] net: stmmac: imx: add i.MX91 support
Message-ID: <aJNdOTZHfyG7fMgE@shell.armlinux.org.uk>
References: <20250806114119.1948624-1-joy.zou@nxp.com>
 <20250806114119.1948624-12-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806114119.1948624-12-joy.zou@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 06, 2025 at 07:41:19PM +0800, Joy Zou wrote:
> Add i.MX91 specific settings for EQoS.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

