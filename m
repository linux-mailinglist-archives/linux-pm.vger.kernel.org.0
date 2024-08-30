Return-Path: <linux-pm+bounces-13204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEAB965954
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD11D1C20B7A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C50166F30;
	Fri, 30 Aug 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Htr/ljZ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C513166F19;
	Fri, 30 Aug 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004978; cv=none; b=YYPbMsOEyydNhTdKKVW1iFAkgWpxQzCrsAIAXyYR43cvtR0UUuapj174VyHmSmytPipGAu5ISn6//Zj+2S6j49UC+ntWKw0wpC3VdrOAbhT3yTYmRtDVgF7s2JpRWc9wqA1b4nJl9Kyh5ikg6XLD+/v3GyTrNqwfLa+sJS3Y19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004978; c=relaxed/simple;
	bh=V5JLcyP1XZThVqKP2FLK8yZHQp7BSEs//17dfoHaEaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzyFW2t+kAxktfQm/lmIYa/0tL8UXsPMICNmFFpO1Mrn/m55bYavZuPbCYO1H+JIric1Fpcul4/odeRNv9uPpjgKTn/YIQd7bmqlR2IK1Dmw5SiY6KvgfMNk1OzI8j3QtQkE8tgMvoPZGgKLj3DFyd7kJ3FJoCSGcSP0j/g1n8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Htr/ljZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3028C4CEC8;
	Fri, 30 Aug 2024 08:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725004978;
	bh=V5JLcyP1XZThVqKP2FLK8yZHQp7BSEs//17dfoHaEaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Htr/ljZ4bcbC+qH3hiz+ps1PACcNUaMjDmNVw57mwJ336MuYU9kJC4HeWUQo0nfZm
	 /6gCNWrVzTDl64iW0D5MCCWXyVYMHdDIbZ7r3RarSP+gpdaVdn4mxWQeoHo9II9chF
	 lC8E2JhDQK6X3nWyOoiwIV3k2yAi+Za+6aH/edwFJTwYCxMy9IxCbvd4P+4Cfze41J
	 HCHUPeSdRxVhWy6OZO8YPG9ugnv+YuqyeTbtSpmdME3Fvcl21x2hUhj3O1aP46a4lg
	 Pt+iBmqP6HmO+4Bmu0UuIy2ZXxpaO26aRTna2oav0kll4jc6QilhpdphuN+Iz1nf/6
	 MPfaAD68BgEJg==
Date: Fri, 30 Aug 2024 13:32:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "Claudiu.Beznea" <claudiu.beznea@tuxon.dev>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to
 initialize the bus
Message-ID: <ZtF8rtI7e/7cK4BR@vaman>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-11-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113468A6CA4ADBCA577670AD486882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <8faa6b6d-a013-4a71-a8b7-af02ac92d94b@tuxon.dev>
 <TY3PR01MB11346FBA77256F2156D374ECF86882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346FBA77256F2156D374ECF86882@TY3PR01MB11346.jpnprd01.prod.outlook.com>

On 23-08-24, 09:01, Biju Das wrote:
> > >> The Renesas RZ/G3S need to initialize the USB BUS before transferring data due to hardware
> > limitation.
> > >> As the register that need to be touched for this is in the address
> > >> space of the USB PHY, and the UBS PHY need to be initialized before
> > >> any other USB drivers handling data transfer, add support to initialize the USB BUS.
> > >>
> > >> As the USB PHY is probed before any other USB drivers that enables
> > >> clocks and de-assert the reset signals and the BUS initialization is
> > >> done in the probe phase, we need to add code to de-assert reset signal and runtime resume the
> > device (which enables its clocks) before accessing the registers.
> > >>
> > >> As the reset signals are not required by the USB PHY driver for the
> > >> other USB PHY hardware variants, the reset signals and runtime PM was handled only in the function
> > that initialize the USB BUS.
> > >>
> > >> The PHY initialization was done right after runtime PM enable to have
> > >> all in place when the PHYs are registered.
> > >
> > > There is no user for this patch. The first user is RZ/G3S and you
> > > should merge this patch with next one.
> > 
> > I think this is a matter of taste... This is how I usually format the patches (for scenarios like
> > this) and got no request for squashing.
> 
> That is strange for trivial patches like this.

Splitting is better, this patch does one thing whereas the next one uses
it adds in new device, i would say quite a clean approach

NOTE: Don't quote the not required context while replying, it is good
mail list hygiene

-- 
~Vinod

