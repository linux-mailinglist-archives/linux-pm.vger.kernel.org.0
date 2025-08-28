Return-Path: <linux-pm+bounces-33230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA6B39841
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 11:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BDE5E84AF
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569752F39A4;
	Thu, 28 Aug 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rECEJydg"
X-Original-To: linux-pm@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584B2E3360;
	Thu, 28 Aug 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373261; cv=none; b=qScfTsRwqTjJ0uzuLLKk4QwEDWunidVK/e9uSnsfs3KU+VD2yPXXhs/SN3xOCrEDpf7HTdrFKny9WSTWDT3NXgoOI6lwXZXLD084PV7M69AZRlGNjZ/AH5nbRaOy6GKhQDSNd9GJENlQeXMqAPdZ+UrEafX4Im1TocnkMpXzCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373261; c=relaxed/simple;
	bh=cW2jLd7ZnHN+UbDtCuz+s3w29KXPm3Vezgp/eS6LoJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqAcXEcCneMhLq4l2ju6qcsyfpRZ56bwXOiTtdhryB9pJ/WjF9CvFPd8qd5AEN9rLtcsaK9KGWLqME1jVtYRwb2FHywVOjPvkvMeik2uT934OujtIGXu4wY4COnXJNwvr9oEGuxL4jEkTEAXRtQX2o4taJjR8uzMlQQUVMD/98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rECEJydg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PgOiY/8TM3TVUl6GJF7nL449nJQfKgvLd+3cCT8JD6o=; b=rECEJydgc7m8D9fDVfaSoNnCtY
	Cvzwrz1a+X+uHqcgSXiGPBIr/ddNcuBSy8iW0m3ERG6Nwim6qN2to5wuTZcM7KH9W2fvjxl5dZK5q
	pfNr70KoQQmHgAGweJd3ElGoczV94jzic3rfWFZkcUQHrZO8o3mlGqblzzBxx+6De/AbzRG+k/LM4
	fxgM38u5ynrl2HQTDNifVxJECo1H1CBgMhfj6FoxcvQ24klFM63xabIQagT17IUb4938lM3ZIhEEX
	EXmixQ/gPXiCsWXjlOwSi9bNPN5HrCdlU0vYdejEJln892uQKeEJCtbzlOq2HCh8K3saB0Pon/Y4/
	kmSAU+HQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42286)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urYub-000000001Pu-1HpH;
	Thu, 28 Aug 2025 10:27:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urYuW-0000000031q-1yMo;
	Thu, 28 Aug 2025 10:27:12 +0100
Date: Thu, 28 Aug 2025 10:27:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, frieder.schrempf@kontron.de,
	primoz.fiser@norik.com, othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Frank.Li@nxp.com
Subject: Re: [PATCH v9 6/6] net: stmmac: imx: add i.MX91 support
Message-ID: <aLAg8Lds-O_36aaN@shell.armlinux.org.uk>
References: <20250825091223.1378137-1-joy.zou@nxp.com>
 <20250825091223.1378137-7-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825091223.1378137-7-joy.zou@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 25, 2025 at 05:12:23PM +0800, Joy Zou wrote:
> @@ -310,6 +311,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
>  	}
>  
>  	if (of_machine_is_compatible("fsl,imx8mp") ||
> +	    of_machine_is_compatible("fsl,imx91") ||
>  	    of_machine_is_compatible("fsl,imx93")) {
>  		/* Binding doc describes the propety:
>  		 * is required by i.MX8MP, i.MX93.

Doesn't this comment need updating?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

