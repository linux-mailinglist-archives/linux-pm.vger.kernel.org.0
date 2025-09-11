Return-Path: <linux-pm+bounces-34429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0130AB526BA
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 04:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E3C1B279DB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5562D22332E;
	Thu, 11 Sep 2025 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="WlYgDmVJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B933D8;
	Thu, 11 Sep 2025 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559464; cv=none; b=GmOre5Nhjw8mq6brkBvMbf8FJJEr9QxLfCLdaGcS5zebQf8EiXDfuJubpipK+rHK0LS9w/7TbJPq0PLXb0le7MtW5wBRkLJgFd9RYcChPIdpQ/XJw6M9IUnoqupTMWtpANFdqICXaB8IjJV02/fDKfIryQdz+gGcGSZ9WB9Nwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559464; c=relaxed/simple;
	bh=IWC4gv/+MV4wQpmWIljhamgnPDMr1J6qUiVNr3movps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezER38L+eZeh/jSlbjFwNy5QA1mFeI2fDAoe0ouB7HgVh1W3anz8sjSO6qLwaEfnLcvet8gOTglJaZ5GeESIX0uQy2iAYX2VszwtdNZWo7npH8uurkbWx8gAHP9/P9OW7cyoWutHmSRqNXjg1EPORKBS1/mJSzL0I7m4fVdmzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=WlYgDmVJ; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Raijf0pxSNsl3FesVHkWVDpo58+B3Fa1eBdInzF1Pzo=;
	b=WlYgDmVJKeOz2HCf2T+/k5D8y+gVK/8GI5wnA3CJUtFKLCw3FKtT0HQ+SMWNbN
	r1wUJRj7/OCzAdF3qFfo7/QL143fSqZlCBNUoLAN0RUyGDl9hrO6ejStoJN9kwpN
	2v5r3juk1e+SmN/7wYQu30AYMQ0qkRkmT26/xaXEquwfs=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAHe3scOsJocw1PBA--.47548S3;
	Thu, 11 Sep 2025 10:55:27 +0800 (CST)
Date: Thu, 11 Sep 2025 10:55:24 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.li@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	frieder.schrempf@kontron.de, primoz.fiser@norik.com,
	othacehe@gnu.org, Markus.Niebel@ew.tq-group.com,
	alexander.stein@ew.tq-group.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
	netdev@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v10 0/6] Add i.MX91 platform support
Message-ID: <aMI6HNACh3y1UWhW@dragon>
References: <20250901103632.3409896-1-joy.zou@nxp.com>
 <175694281723.1237656.10367505965534451710.git-patchwork-notify@kernel.org>
 <aMI0PJtHJyPom68X@dragon>
 <aMI1ljdUkC3qxGU9@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMI1ljdUkC3qxGU9@lizhi-Precision-Tower-5810>
X-CM-TRANSID:Mc8vCgAHe3scOsJocw1PBA--.47548S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1DAFWDKryUWw18Wr18uFg_yoWxAwbEvF
	4UZw4kCws8GF4UK3Wktrn3AwnYya47Xa4xXr1UWw43Z3Z5ArWkXFWFgFWkJFn5KFWkJFna
	yr9IqrWq9rWa9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8S1v3UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwXFZWjCG0lVNgAAs1

On Wed, Sep 10, 2025 at 10:36:06PM -0400, Frank Li wrote:
> On Thu, Sep 11, 2025 at 10:30:20AM +0800, Shawn Guo wrote:
> > On Wed, Sep 03, 2025 at 11:40:17PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> > > Hello:
> > >
> > > This series was applied to netdev/net-next.git (main)
> > > by Jakub Kicinski <kuba@kernel.org>:
> >
> > Jakub,
> >
> > Can you stop applying DTS changes via net tree?
> 
> shawn:
> 	Suppose Jaku only pick patch 6.
> 
>         - [v10,6/6] net: stmmac: imx: add i.MX91 support
>           https://git.kernel.org/netdev/net-next/c/59aec9138f30
> 
> other patches is "(no matching commit)"

Ah, sorry for missing that!  Thanks for pointing it out, Frank!

Shawn


