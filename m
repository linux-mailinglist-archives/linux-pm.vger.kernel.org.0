Return-Path: <linux-pm+bounces-34469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2BB53394
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D2F3BEC71
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67CB326D57;
	Thu, 11 Sep 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaDSz7w6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654103112D9;
	Thu, 11 Sep 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597046; cv=none; b=loYPLPpnuNvREl+9gErmsUTS3whONwYxJB0Va6HvlPMglI0BKY4+uZDeuFpHb/buknACzX5yrick5TVjbladxrr5ILL/8q/iNtoo7ocp7x/3SPR2rVrG5wrigbHXaP63nQrsWigmtO0RNXjV5TdvUwWQffximr0VOF/P+sRRFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597046; c=relaxed/simple;
	bh=ReBPBkxXd+EypkUBHcKbC5D48dqv14ID4CKpjTXEUa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVG3GUuNgJ3qAl8Zb+HzCko0OaVI2hah5guCxCTNFzoPL9vNeapZuYGBTpD4kmXEM/60MeH44MKoCHaSfoIx9QKCKSDk9k8S//JxGkIPnCXQ4MFZucSi/cTeZ6L4WWiNZB1wKFOZbPtyF2st1SpOGaBr2XJvqrT4g4b7ECQfZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaDSz7w6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2804AC4CEF0;
	Thu, 11 Sep 2025 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757597046;
	bh=ReBPBkxXd+EypkUBHcKbC5D48dqv14ID4CKpjTXEUa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CaDSz7w62JVQ9qph9vkiqPWEkMdO9ksAVmIJj6NNKrNQhtpY77er7EdYsXNaC3Gw7
	 Or7QidGxUnAo4jA+WYPKEG0esydorOwwWQZMNuyXSKReLFJbk9OUJjmMX1h8WrZaCC
	 kdugKwZrxFmyMFGRCijvIsDKthcvmqU6FbjU7TfoPRV/fEKPknX6eThWyBYYYCmWGy
	 NnptvyWq2o2frDJrRPJalmbwzPlpzkUokxPIWhCQK0WY4lfqfYh6AH5G/p/N9YIJYF
	 TZ4WZwjrZBDTfKUguTN6o6JgjeEoNWh5YbaKNSRXQFbXRrQSUX+E1cGz+mssdgJDSF
	 6ZLuO0WOJbW1Q==
Date: Thu, 11 Sep 2025 06:24:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Shawn Guo <shawnguo2@yeah.net>, Frank Li <Frank.li@nxp.com>, Joy Zou
 <joy.zou@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 frieder.schrempf@kontron.de, primoz.fiser@norik.com, othacehe@gnu.org,
 Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v10 0/6] Add i.MX91 platform support
Message-ID: <20250911062404.1d2c98f6@kernel.org>
In-Reply-To: <aMI6HNACh3y1UWhW@dragon>
References: <20250901103632.3409896-1-joy.zou@nxp.com>
	<175694281723.1237656.10367505965534451710.git-patchwork-notify@kernel.org>
	<aMI0PJtHJyPom68X@dragon>
	<aMI1ljdUkC3qxGU9@lizhi-Precision-Tower-5810>
	<aMI6HNACh3y1UWhW@dragon>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 10:55:24 +0800 Shawn Guo wrote:
> > > Can you stop applying DTS changes via net tree?  
> > 
> > shawn:
> > 	Suppose Jaku only pick patch 6.
> > 
> >         - [v10,6/6] net: stmmac: imx: add i.MX91 support
> >           https://git.kernel.org/netdev/net-next/c/59aec9138f30
> > 
> > other patches is "(no matching commit)"  
> 
> Ah, sorry for missing that!  Thanks for pointing it out, Frank!

The output is a little confusing.

Konstantin, would it be possible to add (part) to the subject of the
patchwork bot reply when only some patches were applied? I've seen
other people's bots do this. Something like:

 Re: (part) $subject

? Maybe there are other ideas how to express that just part of the
series was applied, no real preference.

